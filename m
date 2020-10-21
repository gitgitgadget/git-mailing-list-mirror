Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529D4C56202
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 19:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D176224179
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 19:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uKlGxV+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440705AbgJUTr7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 15:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409957AbgJUTrz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 15:47:55 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CA0C0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 12:47:55 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d81so3319678wmc.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 12:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TyMFdcUVjhpS0fKv39FKLX2m9BhMPHq3Tfloy1+vGPE=;
        b=uKlGxV+31nKA1hjdDxAeFx1lQvEfZDN3WAdF0Zg791Ukrolbw0amHNU53axUdWc5Ez
         N7ePy/fo/naSyi8tJUz+eaqXMzUoI5n65WfZ7AfL2a2gVDg3KY8axH3UaocpsXRBgc76
         FGK0VTw12HP3/tWBZ+ENYWi7zv13YLkwMyPo0bxEhhfa1znKNuc9Li/xsKCvvjGUChHa
         iS3d1LoP64FuSHOZ4O1txa+kXj7sqMgQAt0ppTqv8ET2G+o3rKh3zAGiXszTZNsGearK
         iqJDw0xmwH5VKta8Y1O3OXWFJvlzRAvB4xsYvFso5rAi+awpULG6URppslSYE0squZNv
         UBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TyMFdcUVjhpS0fKv39FKLX2m9BhMPHq3Tfloy1+vGPE=;
        b=FcCggvW5VfTWfsip2Ie57ICpoWQhKVi4r6H3pKh8V2cVuW+csFr7j3GQnFXLcQxTWl
         bA0TCqNjvm1hHsS3Ew5QQgv7eoGM92BUiHAy4s77s3bUg3aTtrAQf7fALAId/eHVheG9
         JCklgQaxTfN74Cu5CdQsAN70gD1Sj5dn4Zwbg0nn57uAvroR8BSroDlBvR5gCWvld9hL
         R1OpX9Bu9q3UMWKKPNXbi/PfGMLtFok6vfl14aB5u/7ZqtiNzGy+H4c5mlaBL4SPfHOp
         kaAjGxiZCFa24wmw/vP5AiYI5RX9sfyHcp3tktHTpDV/v3t5/vXUmwivQc4Yv8nscMmv
         DW/w==
X-Gm-Message-State: AOAM531OrN/0xITgKQjkXKDQSTGtJelLLE/Ru4K6+4s4fDFHI2K8Yxik
        F5s/llfkXMXCKwKGKbCKeuE=
X-Google-Smtp-Source: ABdhPJx0ihKyDZMrA+pp5OwLeP8p2yrdy0DWkYymIMjPvpHCqGlkiFg9d6rz0fy56DljwO9OXA+e8A==
X-Received: by 2002:a7b:c847:: with SMTP id c7mr5248679wml.41.1603309673573;
        Wed, 21 Oct 2020 12:47:53 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-654-1-419-63.w2-6.abo.wanadoo.fr. [2.6.82.63])
        by smtp.gmail.com with ESMTPSA id z15sm5705559wrq.24.2020.10.21.12.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 12:47:52 -0700 (PDT)
Subject: Re: [PATCH v3 02/11] merge-one-file: rewrite in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk
References: <20200901105705.6059-1-alban.gruin@gmail.com>
 <20201005122646.27994-1-alban.gruin@gmail.com>
 <20201005122646.27994-3-alban.gruin@gmail.com>
 <xmqqmu0z3tge.fsf@gitster.c.googlers.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Message-ID: <e407ce78-8f93-3fb1-4ef2-ce8213f39df2@gmail.com>
Date:   Wed, 21 Oct 2020 21:47:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <xmqqmu0z3tge.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 07/10/2020 00:01, Junio C Hamano wrote:
> Alban Gruin <alban.gruin@gmail.com> writes:
> 
>> This rewrites `git merge-one-file' from shell to C.  This port is not
>> completely straightforward: to save precious cycles by avoiding reading
>> and flushing the index repeatedly, write temporary files when an
>> operation can be performed in-memory, or allow other function to use the
>> rewrite without forking nor worrying about the index,...
> 
> So, the in-core index is still used, but when the contents of the in-core
> index does not have to be written out disk, we just don't?  Makes sense.
> 

>> diff --git a/builtin/merge-one-file.c b/builtin/merge-one-file.c
>> new file mode 100644
>> index 0000000000..598338ba16
>> --- /dev/null
>> +++ b/builtin/merge-one-file.c
>> @@ -0,0 +1,92 @@
>> +/*
>> + * Builtin "git merge-one-file"
>> + *
>> + * Copyright (c) 2020 Alban Gruin
>> + *
>> + * Based on git-merge-one-file.sh, written by Linus Torvalds.
>> + *
>> + * This is the git per-file merge utility, called with
>> + *
>> + *   argv[1] - original file SHA1 (or empty)
>> + *   argv[2] - file in branch1 SHA1 (or empty)
>> + *   argv[3] - file in branch2 SHA1 (or empty)
> 
> Let's modernize this comment while we are at it.
> 
>     SHA1 -> "object name" (or "blob object name")
> 
>> + *   argv[4] - pathname in repository
>> + *   argv[5] - original file mode (or empty)
>> + *   argv[6] - file in branch1 mode (or empty)
>> + *   argv[7] - file in branch2 mode (or empty)
>> + *
>> + * Handle some trivial cases. The _really_ trivial cases have been
>> + * handled already by git read-tree, but that one doesn't do any merges
>> + * that might change the tree layout.
>> + */
>> +
>> +#define USE_THE_INDEX_COMPATIBILITY_MACROS
>> +#include "cache.h"
>> +#include "builtin.h"
>> +#include "lockfile.h"
>> +#include "merge-strategies.h"
>> +
>> +static const char builtin_merge_one_file_usage[] =
>> +	"git merge-one-file <orig blob> <our blob> <their blob> <path> "
>> +	"<orig mode> <our mode> <their mode>\n\n"
>> +	"Blob ids and modes should be empty for missing files.";
>> +
>> +static int read_mode(const char *name, const char *arg, unsigned int *mode)
>> +{
>> +	char *last;
>> +	int ret = 0;
>> +
>> +	*mode = strtol(arg, &last, 8);
>> +
>> +	if (*last)
>> +		ret = error(_("invalid '%s' mode: expected nothing, got '%c'"), name, *last);
>> +	else if (!(S_ISREG(*mode) || S_ISDIR(*mode) || S_ISLNK(*mode)))
>> +		ret = error(_("invalid '%s' mode: %o"), name, *mode);
>> +
>> +	return ret;
>> +}
>> +
>> +int cmd_merge_one_file(int argc, const char **argv, const char *prefix)
>> +{
>> +	struct object_id orig_blob, our_blob, their_blob,
>> +		*p_orig_blob = NULL, *p_our_blob = NULL, *p_their_blob = NULL;
>> +	unsigned int orig_mode = 0, our_mode = 0, their_mode = 0, ret = 0;
>> +	struct lock_file lock = LOCK_INIT;
>> +
>> +	if (argc != 8)
>> +		usage(builtin_merge_one_file_usage);
>> +
>> +	if (read_cache() < 0)
>> +		die("invalid index");
>> +
>> +	hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
>> +
>> +	if (!get_oid(argv[1], &orig_blob)) {
>> +		p_orig_blob = &orig_blob;
>> +		ret = read_mode("orig", argv[5], &orig_mode);
>> +	}
> 
> argv[1] is defined as "either the object name of the blob in the
> common ancestor, or an empty string".  So you need to distinguish
> three cases here, but you are only catching two.
> 
>  - argv[1] is an empty string; p_orig_blob can legitimately be left
>    NULL.
> 
>  - argv[1] is a valid blob object name.  orig_blob should be
>    populated and p_orig_blob should point at it.
> 
>  - argv[1] is garbage, names a non-blob object, or there is no such
>    object with that name.  Don't we want to catch it as a mistake?
> 
> Also, when argv[1] is an empty string, argv[5] must also be an empty
> string, or we got a wrong input---don't we want to catch it as a
> mistake?
> 
> The third case needs a bit of thought.  For example, if $1 and $2
> are the same and points at a non-existent object, we know we won't
> care because we only care about $3.  In a lazily-cloned repository,
> that may matter---we would not want to fail even if we not have blob
> $1 and $2, as long as they are reasonably spelled a full hexadecimal
> object name.  But we would want to fail if blob object named by $3
> is missing.
> 
> One way to achieve semantics closer to the above than the posted
> patch may be to tighten the parsing.  Instead of using "anything
> goes" get_oid(), use get_oid_hex(), perhaps.
> 
>> +	if (!get_oid(argv[2], &our_blob)) {
>> +		p_our_blob = &our_blob;
>> +		ret = read_mode("our", argv[6], &our_mode);
>> +	}
>> +
>> +	if (!get_oid(argv[3], &their_blob)) {
>> +		p_their_blob = &their_blob;
>> +		ret = read_mode("their", argv[7], &their_mode);
>> +	}
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = merge_strategies_one_file(the_repository,
>> +					p_orig_blob, p_our_blob, p_their_blob, argv[4],
>> +					orig_mode, our_mode, their_mode);
> 
> That's a funny function name.  It's not like the function will be
> taught different strategy to handle the three-way merge, no?  It
> probably makes sense to name it after what it does, which is "three
> way merge".
> 

Okay.  There's already a function called threeway_merge() in
unpack_trees() that does something different.
merge_strategies_threeway() should be good?

>> +	if (ret) {
>> +		rollback_lock_file(&lock);
>> +		return !!ret;
>> +	}
>> +
>> +	return write_locked_index(&the_index, &lock, COMMIT_LOCK);
>> +}
> 
>> diff --git a/merge-strategies.c b/merge-strategies.c
>> new file mode 100644
>> index 0000000000..bbe6f48698
>> --- /dev/null
>> +++ b/merge-strategies.c
>> @@ -0,0 +1,214 @@
>> +#include "cache.h"
>> +#include "dir.h"
>> +#include "ll-merge.h"
>> +#include "merge-strategies.h"
>> +#include "xdiff-interface.h"
>> +
> 
>> +static int add_to_index_cacheinfo(struct index_state *istate,
>> +				  unsigned int mode,
>> +				  const struct object_id *oid, const char *path)
>> +{
>> +	struct cache_entry *ce;
>> +	int len, option;
>> +
>> +	if (!verify_path(path, mode))
>> +		return error(_("Invalid path '%s'"), path);
>> +
>> +	len = strlen(path);
>> +	ce = make_empty_cache_entry(istate, len);
>> +
>> +	oidcpy(&ce->oid, oid);
>> +	memcpy(ce->name, path, len);
>> +	ce->ce_flags = create_ce_flags(0);
>> +	ce->ce_namelen = len;
>> +	ce->ce_mode = create_ce_mode(mode);
>> +	if (assume_unchanged)
>> +		ce->ce_flags |= CE_VALID;
>> +	option = ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE;
>> +	if (add_index_entry(istate, ce, option))
>> +		return error(_("%s: cannot add to the index"), path);
>> +
>> +	return 0;
>> +}
> 
> The above correctly does 'git update-index --add --cacheinfo "$6"
> "$2" "$4"' but don't copy-and-paste existing code to do so.  Add one
> preliminary patch before everything else in the series to massage
> and extract add_cacheinfo() function out of builtin/update-index.c,
> move it to somewhere common like read-cache.c and so that we can
> call it from here.
> 

Hmm, I’d really like to do this, but I have one remark/question about
it.  In builtin/update-index.c, when add_cache_entry() fails, this
message is printed:

	cannot add to the index - missing --add option?

Obviously, this is not what we want to show in git-merge when
add_index_entry() fails.  But then, verify_path() can also fail, and
will show a sensible message for any situation:

	Invalid path '%s'

Should I return error when verify_path() fails, but eg. -2 in the case
of add_index_entry(), and if this new add_cacheinfo() returns -2 but not
-1, print the correct message?  Or let the caller verify the path so it
cannot fail because of this?

>> +static int checkout_from_index(struct index_state *istate, const char *path)
>> +{
>> +	struct checkout state = CHECKOUT_INIT;
>> +	struct cache_entry *ce;
>> +
>> +	state.istate = istate;
>> +	state.force = 1;
>> +	state.base_dir = "";
>> +	state.base_dir_len = 0;
>> +
>> +	ce = index_file_exists(istate, path, strlen(path), 0);
> 
> This call is unfortunate for the reasons I mention later.
> 
> But if you must have this call, then you need to sanity check what
> you get from index_file_exists().  ce must be a merged cache entry,
> so
> 
> 	if (!ce || ce_stage(ce))
> 		BUG(...);
> 

That’s ok, I managed to remove it following your advice.

>> +	if (checkout_entry(ce, &state, NULL, NULL) < 0)
>> +		return error(_("%s: cannot checkout file"), path);
>> +	return 0;
>> +}
>> +
>> +static int merge_one_file_deleted(struct index_state *istate,
>> +				  const struct object_id *orig_blob,
>> +				  const struct object_id *our_blob,
>> +				  const struct object_id *their_blob, const char *path,
>> +				  unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode)
>> +{
>> +	if ((our_blob && orig_mode != our_mode) ||
>> +	    (their_blob && orig_mode != their_mode))
>> +		return error(_("File %s deleted on one branch but had its "
>> +			       "permissions changed on the other."), path);
>> +
>> +	if (our_blob) {
>> +		printf(_("Removing %s\n"), path);
>> +
>> +		if (file_exists(path))
>> +			remove_path(path);
>> +	}
>> +
>> +	if (remove_file_from_index(istate, path))
>> +		return error("%s: cannot remove from the index", path);
>> +	return 0;
> 
> If the side that did not remove changed the mode, we don't silently
> remove but fail and give a chance to inspect the situation to the
> end user.  If we had the blob and it is removed by them, we give a
> message and only in that case we remove the file from the working
> tree, together with any leading directory that has become empty.
> 
> And after that we make sure that the path is no longer in the
> index.  The function removes entries for the path at all the stages,
> which is exactly what we want.
> 
> OK.
> 
>> +}
>> +
>> +static int do_merge_one_file(struct index_state *istate,
>> +			     const struct object_id *orig_blob,
>> +			     const struct object_id *our_blob,
>> +			     const struct object_id *their_blob, const char *path,
>> +			     unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode)
>> +{
>> +	int ret, i, dest;
>> +	ssize_t written;
>> +	mmbuffer_t result = {NULL, 0};
>> +	mmfile_t mmfs[3];
>> +	struct ll_merge_options merge_opts = {0};
>> +	struct cache_entry *ce;
>> +
>> +	if (our_mode == S_IFLNK || their_mode == S_IFLNK)
>> +		return error(_("%s: Not merging symbolic link changes."), path);
>> +	else if (our_mode == S_IFGITLINK || their_mode == S_IFGITLINK)
>> +		return error(_("%s: Not merging conflicting submodule changes."), path);
>> +
>> +	read_mmblob(mmfs + 1, our_blob);
>> +	read_mmblob(mmfs + 2, their_blob);
>> +
>> +	if (orig_blob) {
>> +		printf(_("Auto-merging %s\n"), path);
>> +		read_mmblob(mmfs + 0, orig_blob);
>> +	} else {
>> +		printf(_("Added %s in both, but differently.\n"), path);
>> +		read_mmblob(mmfs + 0, &null_oid);
>> +	}
>> +
>> +	merge_opts.xdl_opts = XDL_MERGE_ZEALOUS_ALNUM;
>> +	ret = ll_merge(&result, path,
>> +		       mmfs + 0, "orig",
>> +		       mmfs + 1, "our",
>> +		       mmfs + 2, "their",
>> +		       istate, &merge_opts);
> 
> Is it correct to call into ll_merge() here?  The original used to
> call "git merge-file" which called into xdl_merge().  Calling into
> ll_merge() means the path is used to look up the attributes and use
> the custom merge driver, which I am not offhand sure is what we want
> to see at this low level (and if it turns out to be a good idea, we
> definitely should explain the change of semantics in the proposed
> log message for this commit).
> 
>> +	for (i = 0; i < 3; i++)
>> +		free(mmfs[i].ptr);
>> +
>> +	if (ret < 0) {
>> +		free(result.ptr);
>> +		return error(_("Failed to execute internal merge"));
>> +	}
>> +
>> +	/*
>> +	 * Create the working tree file, using "our tree" version from
>> +	 * the index, and then store the result of the merge.
>> +	 */
> 
> The above is copied from the original, to explain what it did after
> the comment, but it does not seem to match what the new code does.
> 
>> +	ce = index_file_exists(istate, path, strlen(path), 0);
>> +	if (!ce)
>> +		BUG("file is not present in the cache?");
>> +
>> +	unlink(path);
>> +	if ((dest = open(path, O_WRONLY | O_CREAT, ce->ce_mode)) < 0) {
>> +		free(result.ptr);
>> +		return error_errno(_("failed to open file '%s'"), path);
>> +	}
>> +
>> +	written = write_in_full(dest, result.ptr, result.size);
>> +	close(dest);
>> +
>> +	free(result.ptr);
>> +
>> +	if (written < 0)
>> +		return error_errno(_("failed to write to '%s'"), path);
>> +
> 
> This open(..., ce->ce_mode) call is way insufficient.
> 
> The comment we have above this part of the code talks about the
> difficulty of doing this correctly in scripted version.  Creating a
> file by 'git checkout-index -f --stage=2 -- "$4"' and reusing it to
> store the merged contents was the cleanest and easiest way without
> having direct access to adjust_shared_perm() to create a working
> tree file with the correct permission bits.
> 
> We are writing in C, so we should be able to do much better than the
> scripted version, as we can later call adjust_shared_perm().
> 

I'm not sure I understand the issue correctly.

Is this because I fetch an entry from the index to have the mode of the
file, instead of using `our_mode'?  So I should move the error handling
of ll_merge()/xdl_merge() and the detection of the permission conflict
before writing in the file, and call open(…, our_mode)?

I'm also not sure why we need adjust_shared_perm() here.

>> +	if (ret != 0 || !orig_blob)
>> +		ret = error(_("content conflict in %s"), path);
>> +	if (our_mode != their_mode)
>> +		return error(_("permission conflict: %o->%o,%o in %s"),
>> +			     orig_mode, our_mode, their_mode, path);
>> +	if (ret)
>> +		return -1;
>> +
>> +	return add_file_to_index(istate, path, 0);
>> +}
>> +
>> +int merge_strategies_one_file(struct repository *r,
>> +			      const struct object_id *orig_blob,
>> +			      const struct object_id *our_blob,
>> +			      const struct object_id *their_blob, const char *path,
>> +			      unsigned int orig_mode, unsigned int our_mode,
>> +			      unsigned int their_mode)
>> +{
> 
> In a long if/else if/else if/.../else cascade, enclose all bodies in
> braces, if any one of them has a multi-statement body, to avoid
> being distracting.
> 
>> +	if (orig_blob &&
>> +	    ((!their_blob && our_blob && oideq(orig_blob, our_blob)) ||
>> +	     (!our_blob && their_blob && oideq(orig_blob, their_blob))))
>> +		/* Deleted in both or deleted in one and unchanged in the other. */
>> +		return merge_one_file_deleted(r->index,
>> +					      orig_blob, our_blob, their_blob, path,
>> +					      orig_mode, our_mode, their_mode);
> 
> OK, we've already reviewed that function.
> 
>> +	else if (!orig_blob && our_blob && !their_blob) {
>> +		/*
>> +		 * Added in one.  The other side did not add and we
>> +		 * added so there is nothing to be done, except making
>> +		 * the path merged.
>> +		 */
>> +		return add_to_index_cacheinfo(r->index, our_mode, our_blob, path);
> 
> OK, we've already reviewed that function.
> 
>> +	} else if (!orig_blob && !our_blob && their_blob) {
>> +		printf(_("Adding %s\n"), path);
>> +
>> +		if (file_exists(path))
>> +			return error(_("untracked %s is overwritten by the merge."), path);
>> +
>> +		if (add_to_index_cacheinfo(r->index, their_mode, their_blob, path))
>> +			return -1;
>> +		return checkout_from_index(r->index, path);
> 
> You did "add_to_index_cacheinfo()", so you MUST know which ce is to
> be checked out.
> 
> Consider if it is worth to teach add_to_index_cacheinfo() to give
> you ce back and pass it to checkout_from_index(); that way, you do
> not have to call index_file_exists() based on path in the function.
> 

OK, this is doable.

>> +	} else if (!orig_blob && our_blob && their_blob &&
>> +		   oideq(our_blob, their_blob)) {
>> +		/* Added in both, identically (check for same permissions). */
>> +		if (our_mode != their_mode)
>> +			return error(_("File %s added identically in both branches, "
>> +				       "but permissions conflict %o->%o."),
>> +				     path, our_mode, their_mode);
>> +
>> +		printf(_("Adding %s\n"), path);
>> +
>> +		if (add_to_index_cacheinfo(r->index, our_mode, our_blob, path))
>> +			return -1;
>> +		return checkout_from_index(r->index, path);
> 
> Ditto.
> 
>> +	} else if (our_blob && their_blob)
>> +		/* Modified in both, but differently. */
>> +		return do_merge_one_file(r->index,
>> +					 orig_blob, our_blob, their_blob, path,
>> +					 orig_mode, our_mode, their_mode);
>> +	else {
>> +		char orig_hex[GIT_MAX_HEXSZ] = {0}, our_hex[GIT_MAX_HEXSZ] = {0},
>> +			their_hex[GIT_MAX_HEXSZ] = {0};
>> +
>> +		if (orig_blob)
>> +			oid_to_hex_r(orig_hex, orig_blob);
>> +		if (our_blob)
>> +			oid_to_hex_r(our_hex, our_blob);
>> +		if (their_blob)
>> +			oid_to_hex_r(their_hex, their_blob);
>> +
>> +		return error(_("%s: Not handling case %s -> %s -> %s"),
>> +			     path, orig_hex, our_hex, their_hex);
>> +	}
>> +
>> +	return 0;
>> +}
> 
> I can see that this does go in the right direction.  With a bit more
> attention to details it would soon be production-ready quality.
> 
> Thanks.
> 

Thank you,
Alban

