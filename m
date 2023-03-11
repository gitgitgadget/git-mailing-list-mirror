Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA7EC6FA99
	for <git@archiver.kernel.org>; Sat, 11 Mar 2023 03:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjCKDJ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 22:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCKDJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 22:09:27 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5337FF3E
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 19:09:26 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id i11-20020a256d0b000000b0086349255277so7743923ybc.8
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 19:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678504166;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BKK/xEqaXTZZ+K4OIgTfJgjSTi736CMnENf9qcJSSqw=;
        b=m9ju73+ENMKOp4kQoRK/m0POqnrVdfAwVHsvGcIPq97ynMl3DHYoP0o1BeKJKh3C3b
         AEH2a7sbbM8sBVTXFtZLjkpI/UGcSXSackgwW9DkAWbRMIlZlO6MwNYY7YobpOHGc9b6
         1xl2cfdBJRBmhyT+bvwkP1PgXSDO5hd2HhJ/AoHiEHwRMPC5p/4fXa8ZDhGSUVGmveeJ
         RU756JnuXM9m+AUi91qfnp1ocI91zngrxrWeI28QUto8TxDllXLwfDYwHxqC9pTPrVqL
         oLW/l1Tt9nGQ/YNsDjHIPlsg+L/PsebiLLqa/Rw1JbO8ApeUNS+CQAVGMAOp0VagDRoB
         qpwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678504166;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BKK/xEqaXTZZ+K4OIgTfJgjSTi736CMnENf9qcJSSqw=;
        b=IVAEOalDBqy6AAELyKaXO/MVn6EyaWwLm9FWUYHgMl1HL5tv333GP+6Rp8SsfKIQXp
         nAuzgX286s2bGL4G5NysYR7hzV2gKwuCq+rO0xV9swgxjls9wnhAVMg8bPFHgJYLRkNk
         K5vI72qOUwKeSh4ipGXriwZR/g6ZgG3jZmNECPHSxRNGhprjcOqd8ruEmz3t+Nr/mvVB
         z3/YxZedAQliSV9Me7ahGbzR9cTM3HMW+dC9TcToh4Tq+mgddKzE0xsP4sR9BsRMWVjW
         0ZWE1ZThVWaugzv240ICZOaYNVvZZy4X9X1xvggRWafnYqq25/lSI+J5jGNnRQoVFNsj
         WF6w==
X-Gm-Message-State: AO0yUKWcnD+Tf8gE7r5XQ1J3md/4KG+z/FSQWxKMYvmjk7hwJM0UKbjY
        hw23nBiKGTb4IzYcwqKJmPjl7rEzKbGFX10kZZhq
X-Google-Smtp-Source: AK7set8xKBz+gB+Nybtt/SPZ7H2rPK5Cz8Q6DBDEyDHwoIYWWJ72Ba2C58PyCfaHXPCalQgDO0cLaPu6Qqq37gGj9L7L
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:f63:e36e:a446:b3ac])
 (user=jonathantanmy job=sendgmr) by 2002:a81:a9c8:0:b0:533:8f19:4576 with
 SMTP id g191-20020a81a9c8000000b005338f194576mr17990322ywh.0.1678504166139;
 Fri, 10 Mar 2023 19:09:26 -0800 (PST)
Date:   Fri, 10 Mar 2023 19:09:23 -0800
In-Reply-To: <xmqqilf8yx3k.fsf@gitster.g>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230311030923.4171623-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2] object-file: reprepare alternates when necessary
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > But I guess clearing a linked list and hashmap can be a bit cumbersome
> > in C, so maybe it would be reasonable to assume that this behavior
> > would not change.
> 
> I think the original reason why we did not clear was because we
> never knew (and we do not know) what is still in use.  

Ah, I meant that prepare_alt_odb() assumes that the data structures
are as they were originally initialized. So I can think of at least
2 ways that we could implement prepare_alt_odb():

 (a) Repeatedly modify r->objects->odb_tail and repeatedly assign to
     kh_value(r->objects->odb_by_path, pos).
 (b) Call make_odb(), which returns a pointer that we assign to
     r->objects->odb, and call make_odb_hashmap(), which returns a
     pointer that we assign to r->objects->odb_by_path.

Remember that prepare_alt_odb() is meant to start from scratch, so it is
reasonable to do either.

In Java, for example, it would be very reasonable to do (b). But
this patch assumes that we have implemented it as (a). Indeed we
have implemented it as (a) (although we have never documented it as
such), and my quoted statement above is meant to say that it might be
reasonable to keep assuming that it would be (a).
