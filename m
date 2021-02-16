Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D521EC433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 20:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FACE64E85
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 20:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbhBPUuD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 15:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhBPUuB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 15:50:01 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB102C06174A
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 12:49:19 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id g20so6171646plo.2
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 12:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=K01qWHutrd2OuJn3c2smPLvfy1aANDC7U+MoP38hzvQ=;
        b=f9b0PloLey3sjw0o1zmZhAe/mY//b1du4ubxmH76jNbWzRC6/QhdDheL614U4qgVyU
         ZJoheqA8fRYB3Q+xano/sZdwJNwsQR8yU0K46GVsZCbP9FIUPJfR2cojYj+nyDdp64TC
         xB1HnQWOinnQw2IeEdxFuk8nX2gsZk1Aj9omtjn/qJ09KHFZYRTVgUx3RKrXXCdWRVs9
         vpxJEUlDWkOQy+V1YYolOlfYDinoCatv5vw9vaFX8UzdsGKHpsM9DiuXIsU0GH4k1cts
         WGh0exAv5krcw20aQWQPWDxRg6BLShb5UJeCmgSqwLHPtY8X51p4tWV/G5W+1haA3wNV
         0Pqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=K01qWHutrd2OuJn3c2smPLvfy1aANDC7U+MoP38hzvQ=;
        b=pgZnFyuEfNvnfEi8U/z7qW3awpSr7A8rhX3y64GqdXaBii82G624TGL3gMltIfHbTQ
         rjrdLZFNZEVnI7PbilwXywFwjlXhB+p6pupe9feCcfm1vRwt+HNFj50U7HnOWpc64uod
         sTRJQGbSpEX3tSheY1Fb2yh0zIZA99c1thfehQhjpmtk1/WK7EeGK6xAuuJo8/GZkhON
         7dE3kXfRSgWAuXSCDlbw0ujgU0n6HJR04tGt80mwDuYGA8I1Syh9zvwBjpfQmBh4UXSl
         7KMPmNZQLmfhSQC3eut2c1FqgBFyDMRMDCgW053936/g/aGCQeV4pcPIigtbapCN9ZlM
         8gaA==
X-Gm-Message-State: AOAM532nRoT9nEpCzwR7n9kEKJ/BNqn6bv5rVFprsh+ZorHE3dEZaLV6
        6OCbFUxB9F+BPZ92o7FeuOFmdw==
X-Google-Smtp-Source: ABdhPJwQ/TXzUS9ETXN9nHX6lKW3bvnuz8Yagr+JIHXuUdAt28RJIm9VsMRyeTHJGTA7JvCpeiwYZw==
X-Received: by 2002:a17:90a:bb18:: with SMTP id u24mr412397pjr.67.1613508559034;
        Tue, 16 Feb 2021 12:49:19 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:708a:4111:699b:757])
        by smtp.gmail.com with ESMTPSA id v3sm21843428pff.217.2021.02.16.12.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 12:49:18 -0800 (PST)
Date:   Tue, 16 Feb 2021 12:49:13 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] http-fetch: allow custom index-pack args
Message-ID: <YCwvycbylJ9O4qx8@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <20210115234300.350442-1-jonathantanmy@google.com>
 <cover.1611455251.git.jonathantanmy@google.com>
 <3032117ee747e72f6208eab7f960737d25f8a82a.1611455251.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3032117ee747e72f6208eab7f960737d25f8a82a.1611455251.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.01.23 18:34, Jonathan Tan wrote:
> This is the next step in teaching fetch-pack to pass its index-pack
> arguments when processing packfiles referenced by URIs.
> 
> The "--keep" in fetch-pack.c will be replaced with a full message in a
> subsequent commit.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  Documentation/git-http-fetch.txt |  9 ++++++--
>  fetch-pack.c                     |  1 +
>  http-fetch.c                     | 35 +++++++++++++++++++++++++++-----
>  t/t5550-http-fetch-dumb.sh       |  3 ++-
>  4 files changed, 40 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
> index 4deb4893f5..aa171088e8 100644
> --- a/Documentation/git-http-fetch.txt
> +++ b/Documentation/git-http-fetch.txt
> @@ -41,11 +41,16 @@ commit-id::
>  		<commit-id>['\t'<filename-as-in--w>]
>  
>  --packfile=<hash>::
> -	Instead of a commit id on the command line (which is not expected in
> +	For internal use only. Instead of a commit id on the command line (which is not expected in
>  	this case), 'git http-fetch' fetches the packfile directly at the given
>  	URL and uses index-pack to generate corresponding .idx and .keep files.
>  	The hash is used to determine the name of the temporary file and is
> -	arbitrary. The output of index-pack is printed to stdout.
> +	arbitrary. The output of index-pack is printed to stdout. Requires
> +	--index-pack-args.
> +
> +--index-pack-args=<args>::
> +	For internal use only. The command to run on the contents of the
> +	downloaded pack. Arguments are URL-encoded separated by spaces.

I'm a bit skeptical of using URL encoding to work around embedded
spaces. I believe in Emily's config-based hooks series, she wrote an
argument parser to pull repeated arguments into a strvec, could you do
something like that here?

I'm sympathetic to the idea that since this is an internal-only flag, we
can be a bit weird with the argument format, though.

>  --recover::
>  	Verify that everything reachable from target is fetched.  Used after
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 876f90c759..274ae602f7 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1645,6 +1645,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  		strvec_pushf(&cmd.args, "--packfile=%.*s",
>  			     (int) the_hash_algo->hexsz,
>  			     packfile_uris.items[i].string);
> +		strvec_push(&cmd.args, "--index-pack-args=index-pack --stdin --keep");
>  		strvec_push(&cmd.args, uri);
>  		cmd.git_cmd = 1;
>  		cmd.no_stdin = 1;
> diff --git a/http-fetch.c b/http-fetch.c
> index 2d1d9d054f..12feb84e71 100644
> --- a/http-fetch.c
> +++ b/http-fetch.c
> @@ -3,6 +3,7 @@
>  #include "exec-cmd.h"
>  #include "http.h"
>  #include "walker.h"
> +#include "strvec.h"
>  
>  static const char http_fetch_usage[] = "git http-fetch "
>  "[-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin | --packfile=hash | commit-id] url";
> @@ -43,11 +44,9 @@ static int fetch_using_walker(const char *raw_url, int get_verbosely,
>  	return rc;
>  }
>  
> -static const char *index_pack_args[] =
> -	{"index-pack", "--stdin", "--keep", NULL};
> -
>  static void fetch_single_packfile(struct object_id *packfile_hash,
> -				  const char *url) {
> +				  const char *url,
> +				  const char **index_pack_args) {
>  	struct http_pack_request *preq;
>  	struct slot_results results;
>  	int ret;
> @@ -90,6 +89,7 @@ int cmd_main(int argc, const char **argv)
>  	int packfile = 0;
>  	int nongit;
>  	struct object_id packfile_hash;
> +	const char *index_pack_args = NULL;
>  
>  	setup_git_directory_gently(&nongit);
>  
> @@ -116,6 +116,8 @@ int cmd_main(int argc, const char **argv)
>  			packfile = 1;
>  			if (parse_oid_hex(p, &packfile_hash, &end) || *end)
>  				die(_("argument to --packfile must be a valid hash (got '%s')"), p);
> +		} else if (skip_prefix(argv[arg], "--index-pack-args=", &p)) {
> +			index_pack_args = p;
>  		}
>  		arg++;
>  	}
> @@ -128,10 +130,33 @@ int cmd_main(int argc, const char **argv)
>  	git_config(git_default_config, NULL);
>  
>  	if (packfile) {
> -		fetch_single_packfile(&packfile_hash, argv[arg]);
> +		struct strvec encoded = STRVEC_INIT;
> +		char **raw;
> +		int i;
> +
> +		if (!index_pack_args)
> +			die(_("--packfile requires --index-pack-args"));
> +
> +		strvec_split(&encoded, index_pack_args);
> +
> +		CALLOC_ARRAY(raw, encoded.nr + 1);
> +		for (i = 0; i < encoded.nr; i++)
> +			raw[i] = url_percent_decode(encoded.v[i]);
> +
> +		fetch_single_packfile(&packfile_hash, argv[arg],
> +				      (const char **) raw);
> +
> +		for (i = 0; i < encoded.nr; i++)
> +			free(raw[i]);
> +		free(raw);
> +		strvec_clear(&encoded);
> +
>  		return 0;
>  	}
>  
> +	if (index_pack_args)
> +		die(_("--index-pack-args can only be used with --packfile"));
> +
>  	if (commits_on_stdin) {
>  		commits = walker_targets_stdin(&commit_id, &write_ref);
>  	} else {
> diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
> index 483578b2d7..af90e7efed 100755
> --- a/t/t5550-http-fetch-dumb.sh
> +++ b/t/t5550-http-fetch-dumb.sh
> @@ -224,7 +224,8 @@ test_expect_success 'http-fetch --packfile' '
>  
>  	git init packfileclient &&
>  	p=$(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git && ls objects/pack/pack-*.pack) &&
> -	git -C packfileclient http-fetch --packfile=$ARBITRARY "$HTTPD_URL"/dumb/repo_pack.git/$p >out &&
> +	git -C packfileclient http-fetch --packfile=$ARBITRARY \
> +		--index-pack-args="index-pack --stdin --keep" "$HTTPD_URL"/dumb/repo_pack.git/$p >out &&
>  
>  	grep "^keep.[0-9a-f]\{16,\}$" out &&
>  	cut -c6- out >packhash &&
> -- 
> 2.30.0.280.ga3ce27912f-goog
> 
