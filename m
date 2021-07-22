Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4163C4338F
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 22:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D860360EB4
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 22:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbhGVV3I (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 17:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbhGVV3I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 17:29:08 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E16C061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 15:09:41 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 68-20020a9d0f4a0000b02904b1f1d7c5f4so216058ott.9
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 15:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Rzx1HHiFcJrJEoq7vpW72NMWM2asfi3djco/stBJFzQ=;
        b=Epwsjh0Kje17TTGijzkDb2pnxXfLDImPohVWHOZxSOWD6bZPNfVvE6x9ZIjHRFUqOE
         4i4Z7JnVLQj1Go9rOJe5xYSeryj7h8QQqDJPQPA9mgE/NrHMN/8MI9QCwVpyO3c93y/Y
         rK4iKJaFn1GNSAI5c1JQrT8F81bjDOe7iULqXv0u90x2Yu/OrVJqzB0bpCpPdBW5T1Pg
         8JD0TYBBZvkoWn538d9PBYV0ZE6hIRUk93gm80L4wjkVd9dSuOpYIxyvSNKC7XU0QXqY
         KQ8C+aswLSx7oIeHcH9wHcXHxniP1pRJ4LkAGr545fZnwfVwb5pQ8BTl43luVmmaHaR6
         LvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Rzx1HHiFcJrJEoq7vpW72NMWM2asfi3djco/stBJFzQ=;
        b=eDHofzyTYXjFvw3c/vDKANRqXd6krDwoUzUbrRZDYqv8hRW91+QJD5Yon70H1srQYq
         QCOYBVITynGdxzVp/DZvGyRkK/Jy0kALT1T3cSNQXk/PiB07NS2s12AMUtoEmBg/VFzC
         xealonPCmhTysiLjHl5kcJYZV9bDqXcyPBtHL3Tb5ba89tCI8LKXnOJTF+fzJCQ91tbY
         yyyhvcCJpNOc6QJavlap28BgnEiA3GMOd9pnmJIQ4uSCDFTCrDdcKJvNant+MOmB+D4Y
         ZAaB/6QXTJn6WyHUm0V8oYKV3RsFmV784t9Hp3s41LbM9rP74ptaWJ1K0xQtJMddeGEz
         ED5A==
X-Gm-Message-State: AOAM531y7KfYi7G8XyXpeO6vaC/8Qm24/TfZO6yh6q6nlKHfNrz7H/0c
        L2Kf2dvutqCpXYOIuK746EU=
X-Google-Smtp-Source: ABdhPJyTEUd5os+WdzMaBmHvkaF4X9pA4LETqAQTxIWotpSr4/+sndbC1XCSK0cOBA/o6+GZDm3vcA==
X-Received: by 2002:a05:6830:b83:: with SMTP id a3mr1218684otv.319.1626991781256;
        Thu, 22 Jul 2021 15:09:41 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id u126sm608128ooa.23.2021.07.22.15.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 15:09:40 -0700 (PDT)
Date:   Thu, 22 Jul 2021 17:09:39 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <60f9eca348290_678a208fb@natae.notmuch>
In-Reply-To: <xmqq7dhi9nxv.fsf@gitster.g>
References: <c62933fb-96b2-99f5-7169-372f486f6e39@aixigo.com>
 <CABPp-BEHZcfZNL+PG1vmqXGf4Qs3eoULb4NDDgbmOB30HzJu_Q@mail.gmail.com>
 <60f1b7853b8a2_ade9208c1@natae.notmuch>
 <00b50aa6-9b61-9f80-1d8d-2db3ed5e7638@aixigo.com>
 <60f1c9378d5a1_3302085c@natae.notmuch>
 <fa757764-db25-849d-d8d5-e28908059f6b@aixigo.com>
 <xmqq7dhi9nxv.fsf@gitster.g>
Subject: Re: pull.rebase config vs. --ff-only on command line
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Matthias Baumgarten <matthias.baumgarten@aixigo.com> writes:

> >  * git -c pull.ff=only pull --merge, force a merge commit
> 
> This would fast-forward if it can or otherwise create a merge.
> Unlike "pull --no-ff", this should not "force" a merge commit.

Today people rely on this doing a fast-forward-only merge (with
--no-rebase).

Changing this would break existing behavior they rely on.

It's not hypothetical [1].

[1] https://www.reddit.com/r/git/comments/omcngl/do_you_use_both_pullff_and_pullrebase/

-- 
Felipe Contreras
