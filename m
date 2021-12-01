Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB0EC433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 20:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352955AbhLAUim (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 15:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352909AbhLAUiP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 15:38:15 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A453EC061758
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 12:34:51 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id y12so106875134eda.12
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 12:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=1sjm+AUi4/9qhcuSRdtUYzVftzNepk1+bdDl6r4qxfo=;
        b=HxdnwSRhkiO6df4ombcOEbrrk6ILHXQnivkFbrI0Tn0a9FFlrpGX7KiaGPRq4+DFW8
         RtKOZFshY2az5DYfOhwVMa28F4SA6O/xnb8tivgf+4e8JfSYk0ZXX2PX8skS7pcQ/cP3
         jy0WMTVPMAc+DllerSgBoM6uvISof73rAiYA0lkXuO7T27AB969jcINaHJKgLOPZ+rUS
         uokwESNHPmQP2XXS3kjNkCxZ4MTLKXSUweTpZWxhwt/JHLMtbLA8ltYd9y16UkfQs70m
         uzo3fEIsMDzzxEXa9QCONlNk9tz2GcB4n+dBrNC7yba9fJ1Isl4W2AOPmfpVhDR6v5cK
         h9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=1sjm+AUi4/9qhcuSRdtUYzVftzNepk1+bdDl6r4qxfo=;
        b=4bI69toGYajkzaKij6He6tF7pz3om8+Am0vfT34PSuy1H+IYXbo7lHcbwO9pDgc0oD
         ThKKR64iXxNgj16ehOLflSihza9CmgHnuTcKE5Wsxj6YdvxQvEdhHZwKlBQvWSZzNzFf
         yvkRaPJNLEq2cmbx+y8tRuUHIn3Z4HkkmyUZqzvm4+xUrzmzp/II1cZPS/rC+BAhIcLs
         bJaMLmBV0tvn8/isLcZ5USQmvWtj5kip+ygYAcITgpSE8GU+BFRF+td+jJM+dAOS+64N
         Ba14s27s0VJe97ZPRcfhYWRwox8dsfqG4MF8nx6PxSGRGUpZ0WJk4AQ8/wK6GgDdDQi7
         I7yg==
X-Gm-Message-State: AOAM531kOi0uvltfXkl9XQLfv9l24QWFJP8nhk0Q8ovW9dv7wj2TY7Xl
        06LkWMoGlY2/VGvBo71b7Lc=
X-Google-Smtp-Source: ABdhPJyUa/YZLx0ZPaHj+c9PIVelFCFLRx2XPreYVcas4hbHQ0LeAT2o2wfJ9Vi/BQOJCCmrvxfjQw==
X-Received: by 2002:a17:906:48c9:: with SMTP id d9mr10031255ejt.57.1638390890075;
        Wed, 01 Dec 2021 12:34:50 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p13sm485297eds.38.2021.12.01.12.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 12:34:49 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1msWJV-001OHD-28;
        Wed, 01 Dec 2021 21:34:49 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v6 0/8] Sparse Index: integrate with reset
Date:   Wed, 01 Dec 2021 21:26:12 +0100
References: <pull.1048.v5.git.1635345563.gitgitgadget@gmail.com>
 <pull.1048.v6.git.1638201164.gitgitgadget@gmail.com>
 <CABPp-BG0iDHf268UAnRyA=0y0T69YTc+bLMdxCmSbrL8s=9ziA@mail.gmail.com>
 <9c5b7067-b0e3-0153-5cd3-042bae92f91e@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <9c5b7067-b0e3-0153-5cd3-042bae92f91e@github.com>
Message-ID: <211201.86v9089i8m.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 29 2021, Victoria Dye wrote:

> Elijah Newren wrote:
>> Hi,
>> 
>> On Mon, Nov 29, 2021 at 7:52 AM Victoria Dye via GitGitGadget
>> <gitgitgadget@gmail.com> wrote:
>>>
>>> Changes since V5
>>> ================
>>>
>>>  * Update t1092 test 'reset with wildcard pathspec' with more cases and
>>>    better checks
>>>  * Add "special case" wildcard pathspec check when determining whether to
>>>    expand the index (avoids double-loop over pathspecs & index entries)
>> 
>> Looks pretty good.  However, I'm worried this special case you added
>> at my prodding might be problematic, and that I may have been wrong to
>> prod you into it...
>> 
>>> Thanks! -Victoria
>>>
>>> Range-diff vs v5:
>>>
>>>  7:  a9135a5ed64 ! 7:  822d7344587 reset: make --mixed sparse-aware
>>>      @@ Commit message
>>>
>>>           Remove the `ensure_full_index` guard on `read_from_tree` and update `git
>>>           reset --mixed` to ensure it can use sparse directory index entries wherever
>>>      -    possible. Sparse directory entries are reset use `diff_tree_oid`, which
>>>      +    possible. Sparse directory entries are reset using `diff_tree_oid`, which
>>>           requires `change` and `add_remove` functions to process the internal
>>>           contents of the sparse directory. The `recursive` diff option handles cases
>>>           in which `reset --mixed` must diff/merge files that are nested multiple
>>>      @@ builtin/reset.c: static void update_index_from_diff(struct diff_queue_struct *q,
>>>       +          * (since we can reset whole sparse directories without expanding them).
>>>       +          */
>>>       +         if (item.nowildcard_len < item.len) {
>>>      ++                 /*
>>>      ++                  * Special case: if the pattern is a path inside the cone
>>>      ++                  * followed by only wildcards, the pattern cannot match
>>>      ++                  * partial sparse directories, so we don't expand the index.
>>>      ++                  */
>>>      ++                 if (path_in_cone_mode_sparse_checkout(item.original, &the_index) &&
>>>      ++                     strspn(item.original + item.nowildcard_len, "*") == item.len - item.nowildcard_len)
>> 
>> I usually expect in an &&-chain to see the cheaper function call first
>> (because that ordering often avoids the need to call the second
>> function), and I would presume that strspn() would be the cheaper of
>> the two.  Did you switch the order because you expect the strspn call
>> to nearly always return true, though?
>> 
>
> This is a miss on my part, the `strspn()` check is probably less expensive
> and should be first.

I doubt it matters either way, and I didn't look into this to any degree
of carefulness.

But having followed the breadcrumb trail from the "What's Cooking"
discussion & looked at the code one thing that stuck out for me was that
path_in_cone_mode_sparse_checkout() appears returns 1 inconditionally in
some cases based on global state:

	/*
	 * We default to accepting a path if there are no patterns or
	 * they are of the wrong type.
	 */
	if (init_sparse_checkout_patterns(istate) ||
	    (require_cone_mode &&
	     !istate->sparse_checkout_patterns->use_cone_patterns))
		return 1;

So moreso than the nano-optimization of strspn()
v.s. path_in_cone_mode_sparse_checkout() I found it a bit odd that we're
calling something in a loop where presumably we can punt out a lot
earlier, and at least make that "continue" a "break" or "return" in that
case.

I.e. something in this direction (this patch obviously doesn't even
compile, but should clarify what I'm blathering about :); but again, I
really haven't looked at this properly, so just food for thought:

diff --git a/builtin/reset.c b/builtin/reset.c
index b1ff699b43a..cefdabb09c2 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -187,6 +187,9 @@ static int pathspec_needs_expanded_index(const struct pathspec *pathspec)
 	if (pathspec->magic)
 		return 1;
 
+	if (cant_possibly_have_path_in_cone_mode_blah_blah(&the_index))
+		return 1;
+
 	for (i = 0; i < pathspec->nr; i++) {
 		struct pathspec_item item = pathspec->items[i];
 
diff --git a/dir.c b/dir.c
index 5aa6fbad0b7..19f2d989dd3 100644
--- a/dir.c
+++ b/dir.c
@@ -1456,14 +1456,8 @@ int init_sparse_checkout_patterns(struct index_state *istate)
 	return 0;
 }
 
-static int path_in_sparse_checkout_1(const char *path,
-				     struct index_state *istate,
-				     int require_cone_mode)
+int cant_possibly_have_path_in_cone_mode_blah_blah(...)
 {
-	int dtype = DT_REG;
-	enum pattern_match_result match = UNDECIDED;
-	const char *end, *slash;
-
 	/*
 	 * We default to accepting a path if there are no patterns or
 	 * they are of the wrong type.
@@ -1472,6 +1466,16 @@ static int path_in_sparse_checkout_1(const char *path,
 	    (require_cone_mode &&
 	     !istate->sparse_checkout_patterns->use_cone_patterns))
 		return 1;
+}
+
+
+static int path_in_sparse_checkout_1(const char *path,
+				     struct index_state *istate,
+				     int require_cone_mode)
+{
+	int dtype = DT_REG;
+	enum pattern_match_result match = UNDECIDED;
+	const char *end, *slash;
 
 	/*
 	 * If UNDECIDED, use the match from the parent dir (recursively), or
