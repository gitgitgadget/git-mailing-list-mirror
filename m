Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD68C6FA8E
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 15:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjBYPIN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Feb 2023 10:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBYPIM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2023 10:08:12 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A830A126C2
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 07:08:10 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m25-20020a7bcb99000000b003e7842b75f2so1281021wmi.3
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 07:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677337689;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbjlkKWKjnTRLxl3qmr+g2dzncIGZp7/31APo1Sl3jI=;
        b=pxrCVuydzhAG/NsiTa85duKozdgIea5Yoe+s3BxMJgwe8Elh3ikRqPwO12lnT8KApL
         QF14OOtI1MYq/9i2W1+VaPLVn0jat7ABnpL1Ear3ATv7gT5VXnzDemp+S35Y8hGsEFv3
         mUj5ZbAWrZ4sYTkR8MAfB8tWp4akg5W0wVD2ciuEHzZlzEir2GnQAFA2DqpXf+aF0oms
         nGAiGozhOIWf8GjJIutlxlJQ0SBLZxVwkuWeZ6QKkYj7UCYONLDi05/wptLxAM+9tc9h
         jR7gwqpZGETdIFjD+r3FGaft3TnYvlVSlyj6Jv3fHlUFXaQtmToVviYNRMy5B1Lo3BjC
         GzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677337689;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mbjlkKWKjnTRLxl3qmr+g2dzncIGZp7/31APo1Sl3jI=;
        b=rXSNSCBFJGujgsDCg8Rx3+Fl6Kmm/FdHLRn6EDsS9+5mUcvTlJwBlCOj6ob86IA/HZ
         mLjhGCT6G8c5t9m/y1ybz1js+4kbQ691pRMjcoKTqy4VZFrMpfNCMqwQaXT/vpc6abHe
         t628dD6tvJ92l2+aBbIeJj6lJDFX71otuXUeaCD20rmMbF3Q+Hr0zZgi7fbMRcncx8I2
         VZRuLCDKMawsZdOaDiN7nEq886wTmaJwT95Dkwr4Sj6t3PNV6nsVNXga3TaZ3iSRDRHS
         2yvmPaQEhBMmCVTXOU3cKFJ1khEacPC1I5VLYMN6w8N4LAoO7+mnA7aiUgQg/lKI9Coy
         7QPw==
X-Gm-Message-State: AO0yUKVDWY73hJWfkZWkDuNJTX3zZpD6cS2GTsIsyvayUpDMPpcm7eWM
        10DeH+8+u3U+cQ3b8Vz8H2Y=
X-Google-Smtp-Source: AK7set9e8X8S1TfvpWwKLLfhuUgesS8x2Oyl8xXorkMxIH/JMKx38V2wFCa/c3/EP07SK5jFCmQtzA==
X-Received: by 2002:a05:600c:43d4:b0:3dc:58a2:3900 with SMTP id f20-20020a05600c43d400b003dc58a23900mr8376988wmn.29.1677337689213;
        Sat, 25 Feb 2023 07:08:09 -0800 (PST)
Received: from [192.168.2.52] (59.red-88-14-203.dynamicip.rima-tde.net. [88.14.203.59])
        by smtp.gmail.com with ESMTPSA id bd12-20020a05600c1f0c00b003e0015c8618sm6623474wmb.6.2023.02.25.07.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 07:08:08 -0800 (PST)
Subject: Re: [PATCH v4 1/3] branch: avoid unnecessary worktrees traversals
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
 <34a58449-4f2e-66ef-ea01-119186aebd23@gmail.com>
 <2193a4ed-b263-068e-92f8-847dcb053f8c@gmail.com>
 <139555f1-21ab-d987-a58e-c7f04ce222d3@gmail.com>
 <50dd7c7a-5656-e010-1c0b-819a40a1f1a0@gmail.com>
Message-ID: <4e6aeffe-98ef-b4d7-7c8f-782e0a617653@gmail.com>
Date:   Sat, 25 Feb 2023 16:08:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <50dd7c7a-5656-e010-1c0b-819a40a1f1a0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22-feb-2023 23:52:51, Rubén Justo wrote:
> "reject_rebase_or_bisect_branch()" was introduced [1] to prevent a
> branch under bisect or rebase from being renamed or copied.  It
> traverses all worktrees in the repository and dies if the specified
> branch is being rebased or bisected in any of them.
> 
> "replace_each_worktree_head_symref()" was introduced [2] to adjust the
> HEAD in all worktrees after a branch rename succeeded.  It traverses all
> worktrees in the repository and if any of them have their HEAD pointing
> to the renamed ref, it adjusts it.
> 
> Considering that both functions are only called from within
> copy_or_rename_branch() and each of them traverses all worktrees, which
> might involve disk access and resolving multiple references, inlining
> these two functions to do the traversing once, makes sense.
> 
>   1.- 14ace5b (branch: do not rename a branch under bisect or rebase,
>       2016-04-22)
> 
>   2.- 70999e9 (branch -m: update all per-worktree HEADs, 2016-03-27)
> 
> Signed-off-by: Rubén Justo <rjusto@gmail.com>
> ---
>  branch.c         | 27 --------------------
>  branch.h         |  8 ------
>  builtin/branch.c | 64 ++++++++++++++++++++++++++++--------------------
>  3 files changed, 38 insertions(+), 61 deletions(-)
> 
> diff --git a/branch.c b/branch.c
> index e5614b53b3..f64062be71 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -830,30 +830,3 @@ void die_if_checked_out(const char *branch, int ignore_current_worktree)
>  
>  	free_worktrees(worktrees);
>  }
> -
> -int replace_each_worktree_head_symref(const char *oldref, const char *newref,
> -				      const char *logmsg)
> -{
> -	int ret = 0;
> -	struct worktree **worktrees = get_worktrees();
> -	int i;
> -
> -	for (i = 0; worktrees[i]; i++) {
> -		struct ref_store *refs;
> -
> -		if (worktrees[i]->is_detached)
> -			continue;
> -		if (!worktrees[i]->head_ref)
> -			continue;
> -		if (strcmp(oldref, worktrees[i]->head_ref))
> -			continue;
> -
> -		refs = get_worktree_ref_store(worktrees[i]);
> -		if (refs_create_symref(refs, "HEAD", newref, logmsg))
> -			ret = error(_("HEAD of working tree %s is not updated"),
> -				    worktrees[i]->path);
> -	}
> -
> -	free_worktrees(worktrees);
> -	return ret;
> -}
> diff --git a/branch.h b/branch.h
> index ef56103c05..30c01aed73 100644
> --- a/branch.h
> +++ b/branch.h
> @@ -155,12 +155,4 @@ int read_branch_desc(struct strbuf *, const char *branch_name);
>   */
>  void die_if_checked_out(const char *branch, int ignore_current_worktree);
>  
> -/*
> - * Update all per-worktree HEADs pointing at the old ref to point the new ref.
> - * This will be used when renaming a branch. Returns 0 if successful, non-zero
> - * otherwise.
> - */
> -int replace_each_worktree_head_symref(const char *oldref, const char *newref,
> -				      const char *logmsg);
> -
>  #endif
> diff --git a/builtin/branch.c b/builtin/branch.c
> index f63fd45edb..a32ae64006 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -486,28 +486,6 @@ static void print_current_branch_name(void)
>  		die(_("HEAD (%s) points outside of refs/heads/"), refname);
>  }
>  
> -static void reject_rebase_or_bisect_branch(const char *target)
> -{
> -	struct worktree **worktrees = get_worktrees();
> -	int i;
> -
> -	for (i = 0; worktrees[i]; i++) {
> -		struct worktree *wt = worktrees[i];
> -
> -		if (!wt->is_detached)
> -			continue;
> -
> -		if (is_worktree_being_rebased(wt, target))
> -			die(_("Branch %s is being rebased at %s"),
> -			    target, wt->path);
> -
> -		if (is_worktree_being_bisected(wt, target))
> -			die(_("Branch %s is being bisected at %s"),
> -			    target, wt->path);
> -	}
> -
> -	free_worktrees(worktrees);
> -}
>  
>  static void copy_or_rename_branch(const char *oldname, const char *newname, int copy, int force)
>  {
> @@ -516,6 +494,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
>  	const char *interpreted_oldname = NULL;
>  	const char *interpreted_newname = NULL;
>  	int recovery = 0;
> +	struct worktree **worktrees = get_worktrees();
>  
>  	if (strbuf_check_branch_ref(&oldref, oldname)) {
>  		/*
> @@ -544,7 +523,20 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
>  	else
>  		validate_new_branchname(newname, &newref, force);
>  
> -	reject_rebase_or_bisect_branch(oldref.buf);
> +	for (int i = 0; worktrees[i]; i++) {
> +		struct worktree *wt = worktrees[i];
> +
> +		if (!wt->is_detached)
> +			continue;
> +
> +		if (is_worktree_being_rebased(wt, oldref.buf))
> +			die(_("Branch %s is being rebased at %s"),
> +			    oldref.buf, wt->path);
> +
> +		if (is_worktree_being_bisected(wt, oldref.buf))
> +			die(_("Branch %s is being bisected at %s"),
> +			    oldref.buf, wt->path);
> +	}
>  
>  	if (!skip_prefix(oldref.buf, "refs/heads/", &interpreted_oldname) ||
>  	    !skip_prefix(newref.buf, "refs/heads/", &interpreted_newname)) {
> @@ -574,9 +566,29 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
>  				interpreted_oldname);
>  	}
>  
> -	if (!copy &&
> -	    replace_each_worktree_head_symref(oldref.buf, newref.buf, logmsg.buf))
> -		die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
> +	if (!copy) {
> +		/*
> +		 * Update all per-worktree HEADs pointing at the old ref to
> +		 * point the new ref.
> +		 */
> +		for (int i = 0; worktrees[i]; i++) {
> +			struct ref_store *refs;
> +
> +			if (worktrees[i]->is_detached)
> +				continue;
> +			if (!worktrees[i]->head_ref)
> +				continue;
> +			if (strcmp(oldref.buf, worktrees[i]->head_ref))
> +				continue;
> +
> +			refs = get_worktree_ref_store(worktrees[i]);
> +			if (refs_create_symref(refs, "HEAD", newref.buf, logmsg.buf))
> +				die(_("Branch renamed to %s, but HEAD is not updated!"),
> +					newname);

Reviewing this, I noticed I made a mistake here.  The original code
doesn't stop iterating whenever refs_create_symref() fails; it continues
trying to update the remaining worktrees.  When the iteration ends, if
any of the updates failed, then die().  Also, the error message "HEAD of
working tree %s is not updated" is lost.  I'll reroll with this errors
fixed but maybe some review is already underway, so I'll wait some
time.  Sorry for the inconvenience.
