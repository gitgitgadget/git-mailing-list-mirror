Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D981C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 14:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AE7F207C4
	for <git@archiver.kernel.org>; Mon, 18 May 2020 14:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCk3GTf/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgERO5i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 10:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgERO5h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 10:57:37 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E5AC061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 07:57:37 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id z18so8306305qto.2
        for <git@vger.kernel.org>; Mon, 18 May 2020 07:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=vbVn340Q3U+nYfyjc2Uh9c9JbeVnkywYrVi20Df1g88=;
        b=SCk3GTf/NYJCt5jqPJPDDIMcEv+T9GF1BFxHTDBdVGgZO9U12awfpffxe0ITlM6c8z
         3Yv0bj/IgT4Q4egLLC2Q0BARwxijmjXhoEiPgOeNGDzrqWNjvxzcE4Lx+2SMqvvXjRmN
         Uo/6pNapXFvk08dj1oWKgjaL6UaByzXZPw0JIAtWqPUdP+3cPFdjVhQpLzrbr3kqb84u
         jqcTn4H5ElvMvTSO6VFNFntZhwyMyzJ0GYt/2qXMymPzdXisILsq+yrcWV2dyi1Dqn1N
         bbBjffyRLwdoSViEnutVS35h3Ozq+TT8OhurYJzw67y+lDJK5m11BSVyIZVNGzQ/5vF/
         oSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vbVn340Q3U+nYfyjc2Uh9c9JbeVnkywYrVi20Df1g88=;
        b=esi8tUD/WVCHOja+lJK8cTwdxxhYfZMi8QEeBc/G5j1yboYgSvmIE1OvdzW1ZxClCz
         KqHd79yCfl8Tai2Ot59PRI+OeuiWuVdd4qLo4B0m4a5LKOoVNJSOpdXujAwLC4Y5KrQJ
         5u3pPzz0q7s05HrJd5nhhFv5TFVHIEwF5dmT0vKDgd/TTDyUqD7yB/UuT8poPR9aqJDO
         FChzQGWrMEFQ91KbMRmDzCBUmzFiugPnGDNwvrWA+pyvucqtsiIPYv1yE0hhOCJ62QW6
         e7hjRcKYfLjRPA9kw/WEExcHlGyeDxqEV7omhMLzqtaesO5dZZn583UcwWGG78VMDY/c
         KRgw==
X-Gm-Message-State: AOAM5308RzkN1f1uJ+jZI8MkuWQ3EhzfXxNwHzHrLHoQEtqdfuoFXCs0
        /gbkua/QyXo5Pe0vqsqaZ+numjE/T08=
X-Google-Smtp-Source: ABdhPJzULqjRswa3WiUQPCUKVJLhBjq2xrhl9wjyFcBIdl8AljtYUg8O8u0x3PPdl+ca84Y7V9lg/Q==
X-Received: by 2002:ac8:1090:: with SMTP id a16mr17130930qtj.181.1589813856261;
        Mon, 18 May 2020 07:57:36 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id u20sm9576022qtj.97.2020.05.18.07.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 07:57:35 -0700 (PDT)
Subject: Re: [PATCH 7/7] rev-list-options.txt
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
References: <cover.1589739920.git.martin.agren@gmail.com>
 <acfca5465e822eaa6f0ddf85a01f7855d3dfb7d1.1589739920.git.martin.agren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <34870e5f-8e61-4af8-1050-43bfbe30d8f9@gmail.com>
Date:   Mon, 18 May 2020 10:57:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <acfca5465e822eaa6f0ddf85a01f7855d3dfb7d1.1589739920.git.martin.agren@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/17/2020 2:52 PM, Martin Ågren wrote:
> The explanation of the `--show-pulls` option added in commit 8d049e182e
> ("revision: --show-pulls adds helpful merges", 2020-04-10) consists of
> several paragraphs and we use "+" throughout to tie them together in one
> long chain of list continuations. Only thing is, we're not in any kind
> of list, so these pluses end up being rendered literally.
> 
> The preceding few paragraphs describe `--ancestry-path` and there we
> *do* have a list, since we've started one with `--ancestry-path::`. But
> we don't have a similar list running here. We could tie all our
> paragraphs from 8d049e182e to that list, but that doesn't make much
> sense: We aim to describe another option entirely.
> 
> We could start a new list item:
> 
>  --show-pulls:
>     Before discussing another option, `--show-pulls`, we need to
>     create a new example history.
>  +
>     ...
> 
> That reads somewhat awkwardly to me. Not to mention that the chain of
> paragraphs that follows is fairly long, introducing a new example
> history and discussing it in quite some detail. Let's make this run
> along without any kind of indentation. It effectively means that we're
> treating "Before discussing..." as a paragraph on the same level as
> "There is another simplification mode available:" which precedes the
> `--ancestry-path::` list.
> 
> If we really want a `--show-pulls::` list somewhere, we could perhaps
> let it begin around "The `--show-pulls` option helps with both of these
> issues ..." further down. But for now, let's just focus on getting rid
> of those literal pluses.

I think the way you adjusted the preamble is good. It matches this prior
work before --ancestry-path:

	Finally, there is a fifth simplification mode available:

	--ancestry-path::
		(description)
	+
	(example)
	+
	...

And you're right, we do drop the "--show-pulls::" itemization. Will that
make it hard to link to that exact option? Probably.

What about the fixup below, to create this list item?

Thanks,
-Stolee

-- >8 --

From 6416bbc14fbdb21868c6f3b609f66e5fe5607265 Mon Sep 17 00:00:00 2001
From: Derrick Stolee <dstolee@microsoft.com>
Date: Mon, 18 May 2020 10:55:59 -0400
Subject: [PATCH] fixup! rev-list-options.txt

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/rev-list-options.txt | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 48e37e2456..b01b2b6773 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -672,25 +672,28 @@ into the important branch. This commit may have information about why
 the change `X` came to override the changes from `A` and `B` in its
 commit message.
 
-The `--show-pulls` option helps with both of these issues by adding more
-merge commits to the history results. If a merge is not TREESAME to its
-first parent but is TREESAME to a later parent, then that merge is
+--show-pulls::
+	In addition to the commits shown in the default history, show
+	each merge commit that is not TREESAME to its first parent but
+	is TREESAME to a later parent.
++
+When a merge commit is included by `--show-pulls`, the merge is
 treated as if it "pulled" the change from another branch. When using
 `--show-pulls` on this example (and no other options) the resulting
 graph is:
-
++
 -----------------------------------------------------------------------
 	I---X---R---N
 -----------------------------------------------------------------------
-
++
 Here, the merge commits `R` and `N` are included because they pulled
 the commits `X` and `R` into the base branch, respectively. These
 merges are the reason the commits `A` and `B` do not appear in the
 default history.
-
++
 When `--show-pulls` is paired with `--simplify-merges`, the
 graph includes all of the necessary information:
-
++
 -----------------------------------------------------------------------
 	  .-A---M--.   N
 	 /     /    \ /
@@ -699,7 +702,7 @@ graph includes all of the necessary information:
 	  \ /      /
 	   `---X--'
 -----------------------------------------------------------------------
-
++
 Notice that since `M` is reachable from `R`, the edge from `N` to `M`
 was simplified away. However, `N` still appears in the history as an
 important commit because it "pulled" the change `R` into the main
-- 
2.27.0.rc0

