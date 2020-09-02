Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CD0C43461
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 14:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AE1020829
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 14:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dk0G2dbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgIBOvs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgIBOvN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 10:51:13 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D14C061244
        for <git@vger.kernel.org>; Wed,  2 Sep 2020 07:51:11 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so5567803wrm.2
        for <git@vger.kernel.org>; Wed, 02 Sep 2020 07:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QKQ8YS+mMidRzF2asddvlLBliPMfr6krYpYopTsXlWQ=;
        b=dk0G2dbKgce9MiEEnSS1pWkArB6+48HQ4z0g8un8I4s2wrgPY3yfy1zHLxozJgOG9y
         eqda6/HtKL1lQDgjDbmdbusKk7omf5c6p2hL26J3WbgA3vVMG6TqKL5PXzg+DtReB6xC
         +Y/4Dlcp8UX4g0HinflRzJxN9gIltvysv2Eu7mBLl3EuZQoD/I/1tyeHsctJPwcrRHUZ
         JsHLVibD8hzdqqmGwKkOYh0sopeKn2WAtHuvYKjV7v5ZRmaMFYNPUjg9ggiAPNN0DpR1
         NArt4dhWIazWLQ4jgxBhJ2h3ZWzFg6dqzbtOrSoSdmj5jwvitm3/edpoXdxXSKY3LNY8
         Dt7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=QKQ8YS+mMidRzF2asddvlLBliPMfr6krYpYopTsXlWQ=;
        b=TDjQRV28jVpitsg9lQ73B1GHnLhah25dxyKZug1ipqZEU9NnP/aZHDeJrcgVjJYZA5
         FDpFFQ6ni99v2dy97wZ2/0NKo5KPo1j346SLUzL7vH6ghhkaZVf/lJqNbnUgY38xMdOH
         8R3GbjWIDsTfk/V6T48/kPyxxW4qXDX8P56EukkG0dc5CCXUC+3ASGKrA6GGt2Rdf4WB
         4M65Xmr3aBGLQaLhXkqhOF9IzzNs4oPQ2Ug1Z84mv+MXIVSnYu7IZyYnb2T0vgYgzZ1+
         unAa1qJb8ft9UwyFrI3gCoHnmlalyOd8/t7GSXUqQORszADFced1Fs+N7cD18+3zD0/c
         FDxg==
X-Gm-Message-State: AOAM533+8x2J3tz2fApCcIQtfhz8/dHTOdBFsxtr8PpsmPNhsAFk4bVn
        7wwMCYmSj1XHojhMh714S8+P69m42dM=
X-Google-Smtp-Source: ABdhPJxDls0TbpCMBgKSTOLJ9w1dn3TZU119wbxIK0iUiSOMhvAKXzXsywG9vsUz6e2qXrBdm1IW6A==
X-Received: by 2002:adf:fec6:: with SMTP id q6mr7594343wrs.59.1599058270184;
        Wed, 02 Sep 2020 07:51:10 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-654-1-378-135.w86-199.abo.wanadoo.fr. [86.199.233.135])
        by smtp.gmail.com with ESMTPSA id v7sm6697305wmj.28.2020.09.02.07.51.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 07:51:09 -0700 (PDT)
Subject: Re: [PATCH v2 02/11] merge-one-file: rewrite in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk
References: <20200625121953.16991-1-alban.gruin@gmail.com>
 <20200901105705.6059-1-alban.gruin@gmail.com>
 <20200901105705.6059-3-alban.gruin@gmail.com>
 <xmqqk0xdcim6.fsf@gitster.c.googlers.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Autocrypt: addr=alban.gruin@gmail.com; prefer-encrypt=mutual; keydata=
 mQINBFcsWp4BEAC6dalBNr/CZCvvfeARylnjAaZCxMPwUHXAyf4xotA59sNcyVmaFQ6KxQEs
 R20CSJhO6HqCh4bR9/994vdc4cGuNaWf82eYRYzqCzwFWvFJHj83QgDR2cjtz4frKpj3jSFJ
 No3KBlMmpU8yvSnYaCxjqHxBB+fZwkmmONj/57KdFRU83DvDllQdAxXfxEavL3qUKjVbld29
 o82M2xsN8ZN5KTw7rAMHcigYVnlrgP50euxz3WvfrV+Mky2W7q7m5rTK7eXqOKhewsKcxo0I
 AP+H0Nt91YTmMIAX2Ba25IfHI99kUCLpbHX9xdvj5UH1SZsG84APahdI3CXYibfYIS+qssoo
 72qj7eBIoCFbVS4Q5AINxojio32orGBDE8CaCy3EzTF+vwJ+h4uUKrTX4wyUMy8nXS0UxZqD
 aQsS7Di6LdAHu+4uf064mXdgjehJ2uHAydFnCThMoxckRoSZ70iCPwgconhNrnuTmunJ43BF
 YjAurjg8y3WrMPJuJaI42q0sYbAX21XeayyMI8dzoNwyG6s+v0Udb/uxdYnHhsGx1oXjYCeR
 nyBdVwdMLWFP4XmJH7JueGUZ37TLh719ME6HYRpfM3sh915ywPxKxQYmGC9iXRThXdGK7ipq
 hJM5RtMq4QPGg+/ShgTZaDdFuMnG8Zrq6W+O29h9NB5rQ/UvBwARAQABtCNBbGJhbiBHcnVp
 biA8YWxiYW4uZ3J1aW5AZ21haWwuY29tPokCcAQTAQIAWgIbAwIeAQIXgAULBwgJCgQVCAkK
 BRYAAQIDHxhoa3A6Ly9wb29sLnNrcy1rZXlzZXJ2ZXJzLm5ldC8CGQEWIQS1T1bLFrFdtpxn
 TIMOC58lWpNWKgUCWRSuYAAKCRAOC58lWpNWKoCfEACHmff95NF5OrBKN+GPYo3TOojjgjio
 CREt9BNIU1ltbks33N/84QF1ifjFF5xjK1XpNhZdk2Nxk+Uf3ByAS24i0b7/BM58RX3sJMHd
 mklCbqBGLBTS+bO/3nc+1snb7FPmjoi3IXznQ25ZXiV/9MUABUBZi7odwNhxeI3Hd2PaX/x5
 ZM0BApqhmBrueUd0JKqY7f/7a+0rTJ8fIHV9ml3cVWf72t2BVnxJMeNLSAIT1FaL8Okp8ViO
 t7RfjF0JZsYZouhCcw2fx7U0VxXGu6bONdVGxu07I7G3+vjhd2C/ld0dgRRjx8viA5HecUSf
 bwbviEXlc44TVo8D6tkrKOezctqNTLII498C7gIQZjc+6HmIIQrOzzLX/C27JQbXch+6KtHO
 ThYGzmD0d7EttTRtXnFJFTMbQMMFnc2X+Rh1ubvfp4Zp2U3a7Nh1//4+ikqIAPV8poJcEdQ0
 A6CaGD8pTCMdExDovizfJRU0ZN3AU9UgFsZWkMK7MFyJneRObUf26oXCQH8zVuJEJHrEsYPk
 VHdV1G86d++CdipKqe9iDNBGNa/5Q9IvYEKK6vj4wLS5ZaOwLGfApbsOcDJvFA1ll/KeHvzx
 Ig9dhUnNCtYXKJ1npChigwRbAiAADoTFI2rI69g6ZTTzBd0+9GM4z6RcOJvtGLnViO4tOCmy
 sbwbxA==
Message-ID: <bb2cc3e0-b84e-7814-9898-c6f697f2a72b@gmail.com>
Date:   Wed, 2 Sep 2020 16:50:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqk0xdcim6.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 01/09/2020 à 23:06, Junio C Hamano a écrit :
> Alban Gruin <alban.gruin@gmail.com> writes:
> 
>> diff --git a/builtin/merge-one-file.c b/builtin/merge-one-file.c
>> new file mode 100644
>> index 0000000000..306a86c2f0
>> --- /dev/null
>> +++ b/builtin/merge-one-file.c
>> @@ -0,0 +1,85 @@
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
>> +	if (repo_read_index(the_repository) < 0)
>> +		die("invalid index");
>> +
>> +	repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
> 
> I do understand why we would want merge_strategies_one_file() helper
> introduced by this step so that the helper can work in an arbitrary
> repository (hence taking a pointer to repository structure as one of
> its parameters).
> 
> But the "merge-one-file" command will always work in the_repository.
> I do not see a point in using helpers that can work in an arbitrary
> repository, like repo_read_index() or repo_hold_locked_index(), in
> the above.  I only see downsides --- it is longer to read, makes
> readers wonder if there is something tricky involving another
> repository going on, etc.
> 

I was under the impression that using the_index is just deprecated, and
that we ought to avoid using it, even in builtins.

Will update that.

>> +	if (!get_oid(argv[1], &orig_blob)) {
>> +		p_orig_blob = &orig_blob;
>> +		orig_mode = strtol(argv[5], NULL, 8);
> 
> Write a wrapper around strtol(...,...,8) to reduce repetition, and
> make sure you do not pass NULL as the second parameter to strtol()
> to always check you parsed the string to the end.
> 
>> +	ret = merge_strategies_one_file(the_repository,
>> +					p_orig_blob, p_our_blob, p_their_blob, argv[4],
>> +					orig_mode, our_mode, their_mode);
> 
> Here, as I said above, it is perfectly fine to pass
> the_repository().
> 
>> +	if (ret) {
>> +		rollback_lock_file(&lock);
>> +		return ret;
>> +	}
>> +
>> +	return write_locked_index(the_repository->index, &lock, COMMIT_LOCK);
> 
> Likewise, I do not see much point in saying the_repository->index; the_index
> is a perfectly fine short-hand.
> 
> -%<-
>> +static int do_merge_one_file(struct index_state *istate,
>> +			     const struct object_id *orig_blob,
>> +			     const struct object_id *our_blob,
>> +			     const struct object_id *their_blob, const char *path,
>> +			     unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode)
>> +{
>> +	int ret, i, dest;
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
>> +
>> +	for (i = 0; i < 3; i++)
>> +		free(mmfs[i].ptr);
>> +
>> +	if (ret > 127 || !orig_blob)
>> +		ret = error(_("content conflict in %s"), path);
> 
> The original only checked if ret is zero or non-zero; here we
> require ret to be large.  Intended?  
> 
> ll_merge() that called ll_xdl_merge() (i.e. the most common case)
> would return the value returned from xdl_merge(), which can be -1
> when we got an error before calling xdl_do_merge().  xdl_do_merge()
> in turn can return -1.  The most common case returns the value
> returned from xdl_cleanup_merge(), which is 0 for clean merge, and
> any positive integer (not clipped to 127 or 128) for conflicted one.
> 

Huh, not sure why I did this, and I'm puzzled that it did not broke
anything.

>> +	/* Create the working tree file, using "our tree" version from
>> +	   the index, and then store the result of the merge. */
> 
> Style. (cf. Documentation/CodingGuidelines).
> 
>> +	ce = index_file_exists(istate, path, strlen(path), 0);
>> +	if (!ce)
>> +		BUG("file is not present in the cache?");
>> +
>> +	unlink(path);
>> +	dest = open(path, O_WRONLY | O_CREAT, ce->ce_mode);
>> +	write_in_full(dest, result.ptr, result.size);
> 
> If open() fails, we write to a bogus file descriptor here.
> 
>> +	close(dest);
>> +
>> +	free(result.ptr);
>> +
>> +	if (ret && our_mode != their_mode)
>> +		return error(_("permission conflict: %o->%o,%o in %s"),
>> +			     orig_mode, our_mode, their_mode, path);
>> +	if (ret)
>> +		return 1;
> 
> What is the error returning convention around here?  Our usual
> convention is that 0 signals a success, and negative reports an
> error.  Returning the value returned from add_file_to_index() below,
> and error() above, are consistent with the convention, but this one
> returns 1 that is not.  When deviating from convention, it needs to
> be documented for the callers in a comment before the function
> definition.
> 

I stayed to close to the shell script on this one…

Note that this is not the case for "resolve" and "octopus", they use the
convention for merge backends, documented in builtin/merge.c:

> 		/*
> 		 * The backend exits with 1 when conflicts are
> 		 * left to be resolved, with 2 when it does not
> 		 * handle the given merge at all.
> 		 */

(In practice, it looks like any non-zero value lower than 2 indicates a
merge conflict, any value greater or equal to 2 is a general failure.)

>> +
>> +	return add_file_to_index(istate, path, 0);
>> +}
> 
> 
> 
>> +int merge_strategies_one_file(struct repository *r,
>> +			      const struct object_id *orig_blob,
>> +			      const struct object_id *our_blob,
>> +			      const struct object_id *their_blob, const char *path,
>> +			      unsigned int orig_mode, unsigned int our_mode,
>> +			      unsigned int their_mode)
>> +{
>> +	if (orig_blob &&
>> +	    ((!their_blob && our_blob && oideq(orig_blob, our_blob)) ||
>> +	     (!our_blob && their_blob && oideq(orig_blob, their_blob))))
>> +		/* Deleted in both or deleted in one and unchanged in
>> +		   the other */
>> +		return merge_one_file_deleted(r->index,
>> +					      orig_blob, our_blob, their_blob, path,
>> +					      orig_mode, our_mode, their_mode);
>> +	else if (!orig_blob && our_blob && !their_blob) {
>> +		/* Added in one.  The other side did not add and we
>> +		   added so there is nothing to be done, except making
>> +		   the path merged. */
>> +		return add_to_index_cacheinfo(r->index, our_mode, our_blob, path);
>> +	} else if (!orig_blob && !our_blob && their_blob) {
>> +		printf(_("Adding %s\n"), path);
>> +
>> +		if (file_exists(path))
>> +			return error(_("untracked %s is overwritten by the merge."), path);
>> +
>> +		if (add_to_index_cacheinfo(r->index, their_mode, their_blob, path))
>> +			return 1;
>> +		return checkout_from_index(r->index, path);
>> +	} else if (!orig_blob && our_blob && their_blob &&
>> +		   oideq(our_blob, their_blob)) {
>> +		/* Added in both, identically (check for same
>> +		   permissions). */
>> +		if (our_mode != their_mode)
>> +			return error(_("File %s added identically in both branches, "
>> +				       "but permissions conflict %o->%o."),
>> +				     path, our_mode, their_mode);
>> +
>> +		printf(_("Adding %s\n"), path);
>> +
>> +		if (add_to_index_cacheinfo(r->index, our_mode, our_blob, path))
>> +			return 1;
>> +		return checkout_from_index(r->index, path);
>> +	} else if (our_blob && their_blob)
>> +		/* Modified in both, but differently. */
>> +		return do_merge_one_file(r->index,
>> +					 orig_blob, our_blob, their_blob, path,
>> +					 orig_mode, our_mode, their_mode);
>> +	else {
>> +		char *orig_hex = "", *our_hex = "", *their_hex = "";
>> +
>> +		if (orig_blob)
>> +			orig_hex = oid_to_hex(orig_blob);
>> +		if (our_blob)
>> +			our_hex = oid_to_hex(our_blob);
>> +		if (their_blob)
>> +			their_hex = oid_to_hex(their_blob);
> 
> Prepare three char [] buffers and use oid_to_hex_r() instead,
> instead of relying that we'd have sufficient number of entries in
> the rotating buffer.
> 
>> +		return error(_("%s: Not handling case %s -> %s -> %s"),
>> +			     path, orig_hex, our_hex, their_hex);
>> +	}
>> +
>> +	return 0;
>> +}
>> diff --git a/merge-strategies.h b/merge-strategies.h
>> new file mode 100644
>> index 0000000000..b527d145c7
>> --- /dev/null
>> +++ b/merge-strategies.h
>> @@ -0,0 +1,13 @@
>> +#ifndef MERGE_STRATEGIES_H
>> +#define MERGE_STRATEGIES_H
>> +
>> +#include "object.h"
>> +
>> +int merge_strategies_one_file(struct repository *r,
>> +			      const struct object_id *orig_blob,
>> +			      const struct object_id *our_blob,
>> +			      const struct object_id *their_blob, const char *path,
>> +			      unsigned int orig_mode, unsigned int our_mode,
>> +			      unsigned int their_mode);
>> +
>> +#endif /* MERGE_STRATEGIES_H */
>> diff --git a/t/t6415-merge-dir-to-symlink.sh b/t/t6415-merge-dir-to-symlink.sh
>> index 2eddcc7664..5fb74e39a0 100755
>> --- a/t/t6415-merge-dir-to-symlink.sh
>> +++ b/t/t6415-merge-dir-to-symlink.sh
>> @@ -94,7 +94,7 @@ test_expect_success SYMLINKS 'a/b was resolved as symlink' '
>>  	test -h a/b
>>  '
>>  
>> -test_expect_failure 'do not lose untracked in merge (resolve)' '
>> +test_expect_success 'do not lose untracked in merge (resolve)' '
>>  	git reset --hard &&
>>  	git checkout baseline^0 &&
>>  	>a/b/c/e &&

