Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4894DCD6137
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 20:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378136AbjJIU7b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 16:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378132AbjJIU7a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 16:59:30 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79005A3
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 13:59:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a528c2c8bso200228276.1
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 13:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696885168; x=1697489968; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NDR2JISK2iggJcpjFsL6YBeOqwFbhz3qgNrx7Y/wNGo=;
        b=vG5x+Y1NC9oG7TtWeRWgqSCy6ddOsvGDkY+X1KfjAEjHzDwWPCQD3LIyjVx4PeXX/g
         eHRiHWIV04+vXQNtEjO3iqWODDnUQ/0OERRIp0F1li/Ph5JdCz9RqxjtVwugdewp7dqz
         lZgUnU2Rc+UgLpC6qXf9QcqZGYR0l6ShjZ15cl68l7WmG4fLXhOorzumf4dbha1RInJ5
         5l3vbnR2Lijxzc+CbCG4r7FKPLP6VKuWDSmw5oGhaC2ylNYJS32+9LE96wcUPaIDfw6l
         Iawv11xouvYwEvIZ9KV6vIB6igDyUbc90x1kxAGfBzHxgZU/TQniLVK4NMbl5eQDd28O
         z77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696885168; x=1697489968;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NDR2JISK2iggJcpjFsL6YBeOqwFbhz3qgNrx7Y/wNGo=;
        b=B7SGOrH7nrjOap38OK8ahW+8V5xnYoVwNORIX4NYgGx8emOTbLd2yLdqdcn3oEUkK9
         BuhmvcK120DLjwVqSVG9DPj0QtiQATv5EFHA8XqXCWwwFoQTvk3ou13M9fjWpUw3vt2A
         tz3oHYStfvVIEu5ooh67cU6OXAZaDi1jeruUvdrdhQOFYY6GDrXtbIIgjEjSp+DJItGY
         wQ1hJR0hccGFc8vJM8afE78fwbkkiDCe07ePtCUQ8TJ+g9JsA4ofAZAZ8PimaF3Qaec0
         MwHVzO06S9kjhsbW6HiPhsfK5F8dtygh1jssR9xlCtTd4y1j3zzn6riyQ90CIjyfLPWc
         +/aw==
X-Gm-Message-State: AOJu0YxF5dVjWMyaMex2Ij5i7n3SaBGOUUEcpRuGNuB1Dk6JJDbLNDjO
        1FwawDaB4q6fTES2W+CkGcxRC7mRPneCQPwXyQnr
X-Google-Smtp-Source: AGHT+IH3BhYimZl+YQ+t+eJRjbU9/g5YyxswZlHd7Yi0uTegpYjLY+Y3irtsTjE/hNHXo4CXkKUWuDAmDJ7dN7Udzsl6
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:fca4:4039:3bc8:5582])
 (user=jonathantanmy job=sendgmr) by 2002:a25:68d2:0:b0:d79:3b84:9997 with
 SMTP id d201-20020a2568d2000000b00d793b849997mr241486ybc.7.1696885168748;
 Mon, 09 Oct 2023 13:59:28 -0700 (PDT)
Date:   Mon,  9 Oct 2023 13:59:25 -0700
In-Reply-To: <ZSQ3s3ZiRcvQIKOa@nand.local>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231009205925.1915096-1-jonathantanmy@google.com>
Subject: Re: [RFC PATCH] Not computing changed path filter for root commits
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        "=?UTF-8?q?SZEDER=20G=C3=A1bor?=" <szeder.dev@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:
> This only happens when we return REV_TREE_NEW from a call to
> `rev_compare_tree(revs, p, commit, nth_parent)`. But we'll only get
> REV_TREE_NEW back if
> 
>     repo_get_commit_tree(the_repository, p);
> 
> returns NULL. But when we call rev_same_tree_as_empty(revs, p) in the
> REV_TREE_NEW case, we return early as follows:
> 
>     struct tree *t1 = repo_get_commit_tree(revs, p);
>     if (!t1)
>       return 0;
> 
> So we won't even consult the Bloom filter in that case, since t1 is NULL
> for the same reason as what caused rev_compare_tree() to return
> REV_TREE_NEW in the first place.
> 
> I am still dumbfounded by how we would ever get REV_TREE_NEW in the
> first place, but if we did, I think we would be OK here.
> 
> Thanks,
> Taylor

Ah, good point. Your patch in
https://lore.kernel.org/git/ZQnmTXUO94%2FQy8mq@nand.local/ looks good to
me, then.
