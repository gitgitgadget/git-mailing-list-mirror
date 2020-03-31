Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699D7C43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 12:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 281AA20714
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 12:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bi9kFf5p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbgCaMOz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 08:14:55 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33708 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730500AbgCaMOz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 08:14:55 -0400
Received: by mail-ot1-f68.google.com with SMTP id 22so21764627otf.0
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 05:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cu08zp5np+3+5p/xU4TcIbkFWZhxGVXRYlaPvHxJhq4=;
        b=Bi9kFf5pqxKx47oNHGxTp/UTEA1s6fkhrQ8UP7vYRJvvhR+4IGgbHA1XQuaB2LmNyQ
         w++8u2noQZHiLW/lIr5TOO1y0AdenAbap/dTjBufQjulquNccA6HOrl9SYOcJ2xFmfMQ
         zxqt2SAX2Ukl7gBWmEpbmAsY1IlwkQzasDaa17KJic06axEw/QGeD/6HnmVCEuaIAu8M
         fibFtQ3IMbCShCp1FYvHLH2j+63EQFkv2XM26+6QcviyJmqAH/ULay41vYWfVaJsPrsF
         WIr9zGBqYX/RFkJMizaF8BYpS64gkpVAE2ZHXVhRklGu0kHXEvJjXyNfqvOJZwAj2+mb
         vVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cu08zp5np+3+5p/xU4TcIbkFWZhxGVXRYlaPvHxJhq4=;
        b=d5Z5JRFSOM1ttb3iVYasT9Wfb1GaP7WPN2HXH5EhJEMa5YGLI5WOwOcL+ZnuCfT1D0
         qgLcFyHE+ei01tbugqCMgkKKlshCaks00RLvv8CNQLwdybuijoNiaT5e3Ty31y7QRonJ
         VJKyX7ovyUiulnXkY7f/CCE7VaEadpcyoQ9JPIQJhOrh556MgueCsrwlI47Ch1TOO5JO
         3ZtAQuP/7b8akSXdC8+87S+hkA9RqRiglxdX1V8Mh1oV+ilJMyy5ddyqlDkURcgBIRJ6
         Rpw3Kd5eORiEE8H/mVS0ZBrxN2r2W6XpW2UEKxyfq3jEMGPIhcsMPZfjrWeZ8NKJ0dxf
         no1w==
X-Gm-Message-State: ANhLgQ0wLmqyhH51ST1fqPbevBpFP84B27ZV1tnoKwxJa5hcaxY0USij
        6dv4xUyQCOyB8qOMw6EUl2U=
X-Google-Smtp-Source: ADFU+vsJmMCbxc15XWIfUSFMyGPq01JQBvOB8TGs2dJYIcrvOixbYNHXUp50FHtQ72fJzoWFjH6P4w==
X-Received: by 2002:a4a:2cc6:: with SMTP id o189mr2826873ooo.20.1585656893482;
        Tue, 31 Mar 2020 05:14:53 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id r18sm4997627ooc.17.2020.03.31.05.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 05:14:52 -0700 (PDT)
Subject: Re: [PATCH] diff: restrict when prefetching occurs
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     peff@peff.net
References: <20200331020418.55640-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b956528c-412b-2f38-bd90-1fa2ae4b8604@gmail.com>
Date:   Tue, 31 Mar 2020 08:14:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <20200331020418.55640-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/30/2020 10:04 PM, Jonathan Tan wrote:
> Commit 7fbbcb21b1 ("diff: batch fetching of missing blobs", 2019-04-08)
> optimized "diff" by prefetching blobs in a partial clone, but there are
> some cases wherein blobs do not need to be prefetched. In particular, if
> (1) no blob data is included in the output of the diff, (2)
> break-rewrite detection is not requested, and (3) no inexact rename
> detection is needed, then no blobs are read at all.
> 
> Therefore, in such a case, do not prefetch. Change diffcore_std() to
> only prefetch if (1) and/or (2) is not true (currently, it always
> prefetches); change diffcore_rename() to prefetch if (3) is not true and
> no prefetch has yet occurred.

This conflicts with [3], so please keep that in mind.

Maybe [3] should be adjusted to assume this patch, because that change
is mostly about disabling the batch download when no renames are required.
As Peff said [2] the full rename detection trigger is "overly broad".

However, the changed-path Bloom filters are an excellent test for this
patch, as computing them in a partial clone will trigger downloading all
blobs without [3].

[3] https://lore.kernel.org/git/55824cda89c1dca7756c8c2d831d6e115f4a9ddb.1585528298.git.gitgitgadget@gmail.com/T/#u

> [1] https://lore.kernel.org/git/20200128213508.31661-1-jonathantanmy@google.com/
> [2] https://lore.kernel.org/git/20200130055136.GA2184413@coredump.intra.peff.net/
> ---
>  diff.c                        | 26 +++++++++++++++----
>  diffcore-rename.c             | 40 +++++++++++++++++++++++++++-
>  diffcore.h                    |  2 +-
>  t/t4067-diff-partial-clone.sh | 49 +++++++++++++++++++++++++++++++++++
>  4 files changed, 110 insertions(+), 7 deletions(-)
> 
> diff --git a/diff.c b/diff.c
> index 1010d806f5..19c5d638d6 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -6507,10 +6507,24 @@ static void add_if_missing(struct repository *r,
>  
>  void diffcore_std(struct diff_options *options)
>  {
> -	if (options->repo == the_repository && has_promisor_remote()) {
> -		/*
> -		 * Prefetch the diff pairs that are about to be flushed.
> -		 */
> +	int prefetched = 0;
> +	int output_formats_to_prefetch = DIFF_FORMAT_DIFFSTAT |
> +		DIFF_FORMAT_NUMSTAT |
> +		DIFF_FORMAT_PATCH |
> +		DIFF_FORMAT_SHORTSTAT |
> +		DIFF_FORMAT_DIRSTAT;
> +
> +	/*
> +	 * Check if the user requested a blob-data-requiring diff output and/or
> +	 * break-rewrite detection (which requires blob data). If yes, prefetch
> +	 * the diff pairs.
> +	 *
> +	 * If no prefetching occurs, diffcore_rename() will prefetch if it
> +	 * decides that it needs inexact rename detection.
> +	 */
> +	if (options->repo == the_repository && has_promisor_remote() &&
> +	    (options->output_format & output_formats_to_prefetch ||
> +	     (!options->found_follow && options->break_opt != -1))) {
>  		int i;
>  		struct diff_queue_struct *q = &diff_queued_diff;
>  		struct oid_array to_fetch = OID_ARRAY_INIT;
> @@ -6520,6 +6534,8 @@ void diffcore_std(struct diff_options *options)
>  			add_if_missing(options->repo, &to_fetch, p->one);
>  			add_if_missing(options->repo, &to_fetch, p->two);
>  		}
> +		prefetched = 1;
> +
>  		if (to_fetch.nr)

It was difficult to see from the context, but the next line is
"do the prefetch", so "prefetched = 1" makes sense here, even
if to_fetch.nr is zero. We've already done the work to see that
a batch download is not needed.

>  			/*
>  			 * NEEDSWORK: Consider deduplicating the OIDs sent.
> @@ -6538,7 +6554,7 @@ void diffcore_std(struct diff_options *options)
>  			diffcore_break(options->repo,
>  				       options->break_opt);
>  		if (options->detect_rename)
> -			diffcore_rename(options);
> +			diffcore_rename(options, prefetched);
>  		if (options->break_opt != -1)
>  			diffcore_merge_broken();
>  	}
> diff --git a/diffcore-rename.c b/diffcore-rename.c
> index e189f407af..962565f066 100644
> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> @@ -7,6 +7,7 @@
>  #include "object-store.h"
>  #include "hashmap.h"
>  #include "progress.h"
> +#include "promisor-remote.h"
>  
>  /* Table of rename/copy destinations */
>  
> @@ -448,7 +449,18 @@ static int find_renames(struct diff_score *mx, int dst_cnt, int minimum_score, i
>  	return count;
>  }
>  
> -void diffcore_rename(struct diff_options *options)
> +static void add_if_missing(struct repository *r,
> +			   struct oid_array *to_fetch,
> +			   const struct diff_filespec *filespec)
> +{
> +	if (filespec && filespec->oid_valid &&
> +	    !S_ISGITLINK(filespec->mode) &&
> +	    oid_object_info_extended(r, &filespec->oid, NULL,
> +				     OBJECT_INFO_FOR_PREFETCH))
> +		oid_array_append(to_fetch, &filespec->oid);
> +}
> +
> +void diffcore_rename(struct diff_options *options, int prefetched)
>  {
>  	int detect_rename = options->detect_rename;
>  	int minimum_score = options->rename_score;
> @@ -538,6 +550,32 @@ void diffcore_rename(struct diff_options *options)
>  		break;
>  	}
>  
> +	if (!prefetched) {
> +		/*
> +		 * At this point we know there's actual work to do: we have rename
> +		 * destinations that didn't find an exact match, and we have potential
> +		 * sources. So we'll have to do inexact rename detection, which
> +		 * requires looking at the blobs.
> +		 *
> +		 * If we haven't already prefetched, it's worth pre-fetching
> +		 * them as a group now.
> +		 */
> +		int i;
> +		struct oid_array to_fetch = OID_ARRAY_INIT;
> +
> +		for (i = 0; i < rename_dst_nr; i++) {
> +			if (rename_dst[i].pair)
> +				continue; /* already found exact match */
> +			add_if_missing(options->repo, &to_fetch, rename_dst[i].two);

Could this be reversed instead to avoid the "continue"?

	if (!rename_dst[i].pair)
		add_if_missing(options->repo, &to_fetch, rename_dst[i].two);

> +		}
> +		for (i = 0; i < rename_src_nr; i++)
> +			add_if_missing(options->repo, &to_fetch, rename_src[i].p->one);

Does this not have the equivalent "rename_src[i].pair" logic for exact
matches?

> +		if (to_fetch.nr)
> +			promisor_remote_get_direct(options->repo,
> +						   to_fetch.oid, to_fetch.nr);

Perhaps promisor_remote_get_direct() could have the check for
nr == 0 to exit early instead of putting that upon all the
callers?

> +		oid_array_clear(&to_fetch);
> +	}
> +
>  	if (options->show_rename_progress) {
>  		progress = start_delayed_progress(
>  				_("Performing inexact rename detection"),
> diff --git a/diffcore.h b/diffcore.h
> index 7c07347e42..9f69506574 100644
> --- a/diffcore.h
> +++ b/diffcore.h
> @@ -144,7 +144,7 @@ struct diff_filepair *diff_queue(struct diff_queue_struct *,
>  void diff_q(struct diff_queue_struct *, struct diff_filepair *);
>  
>  void diffcore_break(struct repository *, int);
> -void diffcore_rename(struct diff_options *);
> +void diffcore_rename(struct diff_options *, int prefetched);
>  void diffcore_merge_broken(void);
>  void diffcore_pickaxe(struct diff_options *);
>  void diffcore_order(const char *orderfile);
> diff --git a/t/t4067-diff-partial-clone.sh b/t/t4067-diff-partial-clone.sh
> index 4831ad35e6..7acb64727d 100755
> --- a/t/t4067-diff-partial-clone.sh
> +++ b/t/t4067-diff-partial-clone.sh
> @@ -131,4 +131,53 @@ test_expect_success 'diff with rename detection batches blobs' '
>  	test_line_count = 1 done_lines
>  '
>  
> +test_expect_success 'diff does not fetch anything if inexact rename detection is not needed' '
> +	test_when_finished "rm -rf server client trace" &&
> +
> +	test_create_repo server &&
> +	echo a >server/a &&
> +	printf "b\nb\nb\nb\nb\n" >server/b &&
> +	git -C server add a b &&
> +	git -C server commit -m x &&

> +	rm server/b &&
> +	printf "b\nb\nb\nb\nb\n" >server/c &&

Would "mv server/b server/c" make it more clear that
this is an exact rename?

> +	git -C server add c &&
> +	git -C server commit -a -m x &&
> +
> +	test_config -C server uploadpack.allowfilter 1 &&
> +	test_config -C server uploadpack.allowanysha1inwant 1 &&
> +	git clone --bare --filter=blob:limit=0 "file://$(pwd)/server" client &&
> +
> +	# Ensure no fetches.
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff --raw -M HEAD^ HEAD &&
> +	! test_path_exists trace
> +'
> +
> +test_expect_success 'diff --break-rewrites fetches only if necessary, and batches blobs if it does' '
> +	test_when_finished "rm -rf server client trace" &&
> +
> +	test_create_repo server &&
> +	echo a >server/a &&
> +	printf "b\nb\nb\nb\nb\n" >server/b &&
> +	git -C server add a b &&
> +	git -C server commit -m x &&
> +	printf "c\nc\nc\nc\nc\n" >server/b &&
> +	git -C server commit -a -m x &&
> +
> +	test_config -C server uploadpack.allowfilter 1 &&
> +	test_config -C server uploadpack.allowanysha1inwant 1 &&
> +	git clone --bare --filter=blob:limit=0 "file://$(pwd)/server" client &&
> +
> +	# Ensure no fetches.
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff --raw -M HEAD^ HEAD &&
> +	! test_path_exists trace &&
> +
> +	# But with --break-rewrites, ensure that there is exactly 1 negotiation
> +	# by checking that there is only 1 "done" line sent. ("done" marks the
> +	# end of negotiation.)
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client diff --break-rewrites --raw -M HEAD^ HEAD &&
> +	grep "git> done" trace >done_lines &&
> +	test_line_count = 1 done_lines
> +'
> +
>  test_done
> 

Thanks,
-Stolee

