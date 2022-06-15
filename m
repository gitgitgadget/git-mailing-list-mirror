Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECCCC43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 02:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbiFOCCx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 22:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239343AbiFOCCg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 22:02:36 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A38C13D58
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 19:02:34 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id x18so7441767qtj.3
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 19:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NWSdx1K2wbVUlqpUJwO8BrpIDAoN99eE8kfy8Ll2n3Q=;
        b=jzt4R+QAvNpFDlAtKxynxro2gHpcEnv2kU08FaH+43GmaHxkI3LmAhPjlvi8ckFv0z
         3BjdUyzhpUQG23ELK/cLWuh+GrNbW88DMCRvIWAYGMZon2N2rfXUPFRif5gSFX9ZjzqA
         G6LY91zsTK7zxHuuLZ80Di+P96SngExNekjDJ/EIM3oasdHDhrNQzKwwz+7V8LAAJIvs
         1QLJZ8Qhb7zOgwl+Ap82XVBDvw1AJ5qi6xOzL6fYzCCJar54MBbFYXiHey1AVASMRvkb
         RE1dshdIPAk6q8iYtXV02oZbCkzmr5/uI/+tWWrNQoSD0EvmLasPZgCdq28uHH4CpFiZ
         VT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NWSdx1K2wbVUlqpUJwO8BrpIDAoN99eE8kfy8Ll2n3Q=;
        b=IcG2kNJk4qTvbo6TNFcX99pdHKS8Ngr+0K25Hq9u/nNLZl4d1Br+O1MqIbSwolmWLY
         Q0LiElc4aCr2H3qStG83t1tXpDMwL+ckzaGIeTDZb/KCPOF5v/AROeZr7Wr0FFA6hZ7Y
         Rji0ypKAxXdL55jZW23o7xoUuvhCaq3IDhjTNzQkKmFGAXK4y/PsnbfsyHQwyfHIqxXm
         GDcvjhJ2D4LSTFpRqKqcir7pQ6mUb9kuZbgCGh6Pmi0yDZTjDb+Df7zk+cLHlullMRx/
         qwNSmvB/2vivcsNghaRG5pmbUQgtSlm4AU+7AgMZ6cToan8JWFkzP/at+tyDpEy1SmvM
         t3Cg==
X-Gm-Message-State: AOAM532zhzqSay2GUtZuN6i/URoOjgQuY7ttaIYhfnufTLHcoIBV07gV
        4sAZat4oKRpo4XZ+T6ekthHJDg==
X-Google-Smtp-Source: ABdhPJxuuWwfd24BSKSP6QxjXwgiUW8opCX2G32U7V0JQGz7D2QqAEeat/HV7piQ38M8VB7V5vxuKw==
X-Received: by 2002:ac8:5ad1:0:b0:305:864:2eb0 with SMTP id d17-20020ac85ad1000000b0030508642eb0mr6963885qtd.168.1655258553371;
        Tue, 14 Jun 2022 19:02:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d5-20020ac85ac5000000b00304ddab5fc9sm8666739qtd.95.2022.06.14.19.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 19:02:33 -0700 (PDT)
Date:   Tue, 14 Jun 2022 22:02:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] revision: mark blobs needed for resolve-undo as reachable
Message-ID: <Yqk9uMS5kxHD6o7l@nand.local>
References: <xmqqfskdieqz.fsf@gitster.g>
 <7cd41846-e6ef-7a24-0426-6031a529360f@github.com>
 <220614.86czfcytlz.gmgdl@evledraar.gmail.com>
 <31f406b1-b4e8-5da2-40af-5747938de634@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <31f406b1-b4e8-5da2-40af-5747938de634@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 14, 2022 at 10:35:10AM -0400, Derrick Stolee wrote:
> I thinks I had something like
>
> 	for ((list) && item = (list)->items; (list) && item && ...

I wrote something like this:

--- >8 ---

diff --git a/string-list.h b/string-list.h
index d5a744e143..425abc55f4 100644
--- a/string-list.h
+++ b/string-list.h
@@ -143,7 +143,7 @@ int for_each_string_list(struct string_list *list,

 /** Iterate over each item, as a macro. */
 #define for_each_string_list_item(item,list)            \
-	for (item = (list)->items;                      \
+	for (item = (list) ? (list)->items : NULL;      \
 	     item && item < (list)->items + (list)->nr; \
 	     ++item)

--- 8< ---

> but even with your suggestion, I get this compiler error:

...so did I. Though I'm not sure I understand the compiler's warning
here. Surely the thing being passed as list in the macro expansion
_won't_ always evaluate to non-NULL, will it?

Thanks,
Taylor
