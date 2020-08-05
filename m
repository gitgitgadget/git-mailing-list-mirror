Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B1DC433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C13242075A
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="TGFl1QS0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgHEVUj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 17:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgHEVUj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 17:20:39 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B899CC061575
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 14:20:36 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id t6so16535442qvw.1
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 14:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ys5OHA0n/NXohUzRFDFS//G3YYtifO57aCaS/eGxvUo=;
        b=TGFl1QS0kQk8biJTFJ4jpjdy/ojPs51C2qsTOJjSgst74PPznS+Kit22LNdHAejpgY
         N9Y51BJlKVMHQ4FZrF63zfwUrGBideGqUoFEQdG+18dIKnT8enor1baMlU+wDruJJAPN
         ccUr8Pm7Z1g+44bgyX3TyiMkCDMT5UDo5Z1buq4K3TVXTA59YHPf5O4k1EX/74ofr2tw
         i3eP3A/XKOtkuRlmIMzs4NYvMiN268ndd3wngL2rbo8PTExloVzJy5t30ub8jdoV04HY
         XuyXgttr6J8GHM8I9ywJUz/l2DshkpvG6HEmydNK5IRSzXNwD0VFUV198clg/X50uNDj
         jRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ys5OHA0n/NXohUzRFDFS//G3YYtifO57aCaS/eGxvUo=;
        b=tt0GTl3XrbO9+SeinMpJMjD7nw0/0JgJoMRE2QXhy8mOiNh5Dt7zod5uBnKWnwP6JS
         xGoLKHRCk285LIrC+2RHAaA8jxuz+vPV4BIb3TXh2CfGSZfCR/6HmvCLJhfev7y1MWgP
         l1OcXjTLlzleB4lGAPCgvZU9isj7tHF6ObHFBvjgu427TArgyoWLNe7OBXtJMkvSDxYK
         K0wRIileXwmjecE5UHPT7VQgAz3eRnOr+cSOA8O0C5OBUmAwJEe6hAw3ZMywRgqZu4Iu
         fLmFK0JkndJreLU2euyDRKK7YNdpkh7Q4en/DTVSwjRxbrCK+Gyo80hOoFioYCQi4GI9
         ASVw==
X-Gm-Message-State: AOAM531PHrtgykgtSFM/aqWTsHID2P2VfW0YfX6sxVJVzxqpWoExljMB
        NbJi/CYdfkDncf9tdMt73atofQ==
X-Google-Smtp-Source: ABdhPJyUbVG1bW0DIYL7x/0iwRLfrp3DN6wILHYV6nT+hJ/C4n1MBsHekHd4PrTQ1LScIrl2JgMNAA==
X-Received: by 2002:a0c:ffa1:: with SMTP id d1mr5694020qvv.36.1596662434613;
        Wed, 05 Aug 2020 14:20:34 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:d118:9acc:fdba:dee7])
        by smtp.gmail.com with ESMTPSA id d20sm2510285qkk.84.2020.08.05.14.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 14:20:34 -0700 (PDT)
Date:   Wed, 5 Aug 2020 17:20:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] sequencer: avoid garbled merge machinery messages due to
 commit labels
Message-ID: <20200805212032.GK9546@syl.lan>
References: <pull.828.git.git.1596654345718.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.828.git.git.1596654345718.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 05, 2020 at 07:05:45PM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
>
> sequencer's get_message() exists to provide good labels on conflict
> hunks; see commits
>   d68565402a ("revert: clarify label on conflict hunks", 2010-03-20)
>   bf975d379d ("cherry-pick, revert: add a label for ancestor", 2010-03-20)
>   043a4492b3 ("sequencer: factor code out of revert builtin", 2012-01-11).
> for background on this function.  These labels are of the form
>   <commitID>... <commit summary>
> or
>   parent of <commitID>... <commit summary>
> These labels are then passed as branch names to the merge machinery.
> However, these labels, as formatted, often also serve to confuse.  For
> example, if we have a rename involved in a content merge, then it
> results in text such as the following:
>
>     <<<<<<<< HEAD:foo.c
>       int j;
>     ========
>       int counter;
>     >>>>>>>> b01dface... Removed unnecessary stuff:bar.c
>
> Or in various conflict messages, it can make it very difficult to read:
>
>     CONFLICT (rename/delete): foo.c deleted in b01dface... Removed
>     unnecessary stuff and renamed in HEAD.  Version HEAD of foo.c left
>     in tree.
>
>     CONFLICT (file location): dir1/foo.c added in b01dface... Removed
>     unnecessary stuff inside a directory that was renamed in HEAD,
>     suggesting it should perhaps be moved to dir2/foo.c.
>
> Make a minor change to remove the ellipses and add parentheses around
> the commit summary; this makes all three examples much easier to read:
>
>     <<<<<<<< HEAD:foo.c
>       int j;
>     ========
>       int counter;
>     >>>>>>>> b01dface (Removed unnecessary stuff):bar.c
>
>     CONFLICT (rename/delete): foo.c deleted in b01dface (Removed
>     unnecessary stuff) and renamed in HEAD.  Version HEAD of foo.c left
>     in tree.
>
>     CONFLICT (file location): dir1/foo.c added in b01dface (Removed
>     unnecessary stuff) inside a directory that was renamed in HEAD,
>     suggesting it should perhaps be moved to dir2/foo.c.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>

This is much easier to read, and the change below is obviously correct.
Thanks for working to improve the readability of these markers.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

> ---
>     sequencer: avoid garbled merge machinery messages due to commit labels
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-828%2Fnewren%2Fsequencer-merge-messages-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-828/newren/sequencer-merge-messages-v1
> Pull-Request: https://github.com/git/git/pull/828
>
>  sequencer.c                     |  2 +-
>  t/t3404-rebase-interactive.sh   |  2 +-
>  t/t3507-cherry-pick-conflict.sh | 20 ++++++++++----------
>  3 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index fd7701c88a..e988c12ad2 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -355,7 +355,7 @@ static int get_message(struct commit *commit, struct commit_message *out)
>  	subject_len = find_commit_subject(out->message, &subject);
>
>  	out->subject = xmemdupz(subject, subject_len);
> -	out->label = xstrfmt("%s... %s", abbrev, out->subject);
> +	out->label = xstrfmt("%s (%s)", abbrev, out->subject);
>  	out->parent_label = xstrfmt("parent of %s", out->label);
>
>  	return 0;
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 4a7d21f898..1d0a656ebd 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -256,7 +256,7 @@ test_expect_success 'stop on conflicting pick' '
>  	D
>  	=======
>  	G
> -	>>>>>>> $commit... G
> +	>>>>>>> $commit (G)
>  	EOF
>  	git tag new-branch1 &&
>  	test_must_fail git rebase -i master &&
> diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
> index 752bc43487..152ea11dc9 100755
> --- a/t/t3507-cherry-pick-conflict.sh
> +++ b/t/t3507-cherry-pick-conflict.sh
> @@ -283,12 +283,12 @@ test_expect_success 'failed cherry-pick describes conflict in work tree' '
>  	a
>  	=======
>  	c
> -	>>>>>>> objid picked
> +	>>>>>>> objid (picked)
>  	EOF
>
>  	test_must_fail git cherry-pick picked &&
>
> -	sed "s/[a-f0-9]*\.\.\./objid/" foo >actual &&
> +	sed "s/[a-f0-9]* (/objid (/" foo >actual &&
>  	test_cmp expected actual
>  '
>
> @@ -298,16 +298,16 @@ test_expect_success 'diff3 -m style' '
>  	cat <<-EOF >expected &&
>  	<<<<<<< HEAD
>  	a
> -	||||||| parent of objid picked
> +	||||||| parent of objid (picked)
>  	b
>  	=======
>  	c
> -	>>>>>>> objid picked
> +	>>>>>>> objid (picked)
>  	EOF
>
>  	test_must_fail git cherry-pick picked &&
>
> -	sed "s/[a-f0-9]*\.\.\./objid/" foo >actual &&
> +	sed "s/[a-f0-9]* (/objid (/" foo >actual &&
>  	test_cmp expected actual
>  '
>
> @@ -319,7 +319,7 @@ test_expect_success 'revert also handles conflicts sanely' '
>  	a
>  	=======
>  	b
> -	>>>>>>> parent of objid picked
> +	>>>>>>> parent of objid (picked)
>  	EOF
>  	{
>  		git checkout picked -- foo &&
> @@ -345,7 +345,7 @@ test_expect_success 'revert also handles conflicts sanely' '
>  	test_must_fail git update-index --refresh -q &&
>  	test_must_fail git diff-index --exit-code HEAD &&
>  	test_cmp expected-stages actual-stages &&
> -	sed "s/[a-f0-9]*\.\.\./objid/" foo >actual &&
> +	sed "s/[a-f0-9]* (/objid (/" foo >actual &&
>  	test_cmp expected actual
>  '
>
> @@ -429,16 +429,16 @@ test_expect_success 'revert conflict, diff3 -m style' '
>  	cat <<-EOF >expected &&
>  	<<<<<<< HEAD
>  	a
> -	||||||| objid picked
> +	||||||| objid (picked)
>  	c
>  	=======
>  	b
> -	>>>>>>> parent of objid picked
> +	>>>>>>> parent of objid (picked)
>  	EOF
>
>  	test_must_fail git revert picked &&
>
> -	sed "s/[a-f0-9]*\.\.\./objid/" foo >actual &&
> +	sed "s/[a-f0-9]* (/objid (/" foo >actual &&
>  	test_cmp expected actual
>  '
>
>
> base-commit: dc04167d378fb29d30e1647ff6ff51dd182bc9a3
> --
> gitgitgadget
Thanks,
Taylor
