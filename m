Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58C2CCA47B
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 10:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbiF3KnR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 06:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235149AbiF3Kms (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 06:42:48 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D3A51B18
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 03:41:12 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id o9so25935195edt.12
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 03:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=0vHpNV/0cNtKNKysFah3oBXfSISd9bvULtjT1CMQ/2s=;
        b=CD6ZMVrnwrBppgI/pJQLgo3bxUnqMKcG1yb+bdu/32A0IvMq7kkEOzEWDGiDUr6Bfq
         PbuORQxVOqXpX7OPRx0W9yW7fUbni3oCBYTUQLItaTjGCrOES6vzWQHJa4mXfDfcDLxJ
         /XOU3BZUpDdpx2EKiwpvy5kNB27M3KwgaFGjKxn3zNsG7Vu7eJWZUNrBhB7vknhDFqVp
         k1YGDJc9NCOv75+bZOU2mYmSPQ2l4FovtDmpq2XjlQfFI2b2PIoyrgn+5MaI7W6rtKlb
         AOvJMirOJaQkNztMaUzQLf6IF2dnwf6fRp2hsFtSHJE2cMqnjLOf7Y9A6S4tFXq8SIp2
         epdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=0vHpNV/0cNtKNKysFah3oBXfSISd9bvULtjT1CMQ/2s=;
        b=Os4Dcod4E7yJcufaHCuUcrIIzbWSh1Hr5pBE37LG5pGWzkHUT11O6LFFjul+rIkOkj
         pMUb3m4T8JrpmRV7dSDxflPIHJn/PmSqbhl8fxKzvUCNhu7HePNfOhUPCt9m3rvk9VQA
         TkmWiuopgEIhWBMy7qxzjMucTf4I9oWORaQq9NiEtvA731C/y0hVE2Ttz2xbniU2bjuP
         tXBHGwVx7G7Z5pOuV8GWHLzsW0ebNXVbdRLcjcZ+DzlWd0MMowBTuVZRfynlrUraOLWT
         oKv7vdi+NXnV/ZexntnY8mx1/LG9i55q0lX+ITL6rVcQhp19qaZOuuyg49nPJ9ARWJOO
         Pjkw==
X-Gm-Message-State: AJIora80wOI8op3IyTpQeUUqbB9r7Rp7ys77sfYmlJa33c7EwbyzXxO/
        Ag/oTUuUUzHnpIqzJA7aTo6/blXof6sZ1g==
X-Google-Smtp-Source: AGRyM1uJ7c/9ziCb+VFbOWMDy8ocYC9+790fXbOGUzpnVHYixG3261kyDCkVCYJuH1PDyaXoy/Cr3w==
X-Received: by 2002:a05:6402:d5c:b0:435:6e2f:245b with SMTP id ec28-20020a0564020d5c00b004356e2f245bmr10696328edb.145.1656585670476;
        Thu, 30 Jun 2022 03:41:10 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id u6-20020a170906780600b006fef557bb7asm8856571ejm.80.2022.06.30.03.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 03:41:09 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o6rbg-002FT8-Qz;
        Thu, 30 Jun 2022 12:41:08 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 3/3] merge-ort: fix issue with dual rename and
 add/add conflict
Date:   Thu, 30 Jun 2022 12:31:52 +0200
References: <pull.1268.git.1655871651.gitgitgadget@gmail.com>
 <pull.1268.v2.git.1656572225.gitgitgadget@gmail.com>
 <da3ae38e390df8acf86e910389d1620569a95a87.1656572226.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <da3ae38e390df8acf86e910389d1620569a95a87.1656572226.git.gitgitgadget@gmail.com>
Message-ID: <220630.86letee8mz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 30 2022, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> There is code in both merge-recursive and merge-ort for avoiding doubly
> transitive renames (i.e. one side renames directory A/ -> B/, and the
> other side renames directory B/ -> C/), because this combination would
> otherwise make a mess for new files added to A/ on the first side and
> wondering which directory they end up in -- especially if there were
> even more renames such as the first side renaming C/ -> D/.  In such
> cases, it just turns "off" directory rename detection for the higher
> order transitive cases.
>
> The testcases added in t6423 a couple commits ago are slightly different
> but similar in principle.  They involve a similar case of paired
> renaming but instead of A/ -> B/ and B/ -> C/, the second side renames
> a leading directory of B/ to C/.  And both sides add a new file
> somewhere under the directory that the other side will rename.  While
> the new files added start within different directories and thus could
> logically end up within different directories, it is weird for a file
> on one side to end up where the other one started and not move along
> with it.  So, let's just turn off directory rename detection in this
> case as well.
>
> Another way to look at this is that if the source name involved in a
> directory rename on one side is the target name of a directory rename
> operation for a file from the other side, then we avoid the doubly
> transitive rename.  (More concretely, if a directory rename on side D
> wants to rename a file on side E from OLD_NAME -> NEW_NAME, and side D
> already had a file named NEW_NAME, and a directory rename on side E
> wants to rename side D's NEW_NAME -> NEWER_NAME, then we turn off the
> directory rename detection for NEW_NAME to prevent the
> NEW_NAME -> NEWER_NAME rename, and instead end up with an add/add
> conflict on NEW_NAME.)
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-ort.c                         | 7 +++++++
>  t/t6423-merge-rename-directories.sh | 4 ++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index fa6667de18c..17db4c30e5b 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -2292,9 +2292,16 @@ static char *check_for_directory_rename(struct merge_options *opt,
>  	struct strmap_entry *rename_info;
>  	struct strmap_entry *otherinfo = NULL;
>  	const char *new_dir;
> +	int other_side = 3 - side_index;
>  
> +	/*
> +	 * Cases where we don't have or don't want a directory rename for
> +	 * this path, so we return NULL.
> +	 */
>  	if (strmap_empty(dir_renames))
>  		return new_path;
> +	if (strmap_get(&collisions[other_side], path))
> +		return new_path;

I realize from looking at merge-recursive.c that this is carrying
forward some legacy debt, but I find this code and the need for a
comment more complex than it needs to. On top of master this will work
just as well:
	
	diff --git a/merge-ort.c b/merge-ort.c
	index b5015b9afd4..f5a02b1ff6f 100644
	--- a/merge-ort.c
	+++ b/merge-ort.c
	@@ -2268,16 +2268,16 @@ static char *check_for_directory_rename(struct merge_options *opt,
	 					struct strmap *collisions,
	 					int *clean_merge)
	 {
	-	char *new_path = NULL;
	+	char *new_path;
	 	struct strmap_entry *rename_info;
	 	struct strmap_entry *otherinfo = NULL;
	 	const char *new_dir;
	 
	 	if (strmap_empty(dir_renames))
	-		return new_path;
	+		return NULL;
	 	rename_info = check_dir_renamed(path, dir_renames);
	 	if (!rename_info)
	-		return new_path;
	+		return NULL;
	 	/* old_dir = rename_info->key; */
	 	new_dir = rename_info->value;

I.e. we're really just making the reader squint to see that we're
actually returning NULL here, it's only later that we have an actual
"new path".

Wouldn't sticking that earlier in this series be an improvement? The
reason you need to explain "so we return NULL" is because we're carrying
forward this oddity, but if we just don't initialize it and return NULL
instead...

If you want to keep this pretty much as-is I think you should add a \n
before the (not seen in your context) "old_dir" comment seen in the
context here above, to make it visually clear that your new comment is
referring to these chains of returns. That could also be made clearer
with (again, on top of master, and could be combined with the above):
	
	diff --git a/merge-ort.c b/merge-ort.c
	index b5015b9afd4..a418f81a3eb 100644
	--- a/merge-ort.c
	+++ b/merge-ort.c
	@@ -2278,8 +2278,6 @@ static char *check_for_directory_rename(struct merge_options *opt,
	 	rename_info = check_dir_renamed(path, dir_renames);
	 	if (!rename_info)
	 		return new_path;
	-	/* old_dir = rename_info->key; */
	-	new_dir = rename_info->value;
	 
	 	/*
	 	 * This next part is a little weird.  We do not want to do an
	@@ -2305,6 +2303,7 @@ static char *check_for_directory_rename(struct merge_options *opt,
	 	 * As it turns out, this also prevents N-way transient rename
	 	 * confusion; See testcases 9c and 9d of t6043.
	 	 */
	+	new_dir = rename_info->value; /* old_dir = rename_info->key; */
	 	otherinfo = strmap_get_entry(dir_rename_exclusions, new_dir);
	 	if (otherinfo) {
	 		path_msg(opt, rename_info->key, 1,
