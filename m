Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE4AC433E7
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 23:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07039206F8
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 23:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwdV6bN8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgIBX4e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 19:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgIBX4c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 19:56:32 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAD2C061244
        for <git@vger.kernel.org>; Wed,  2 Sep 2020 16:56:31 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f18so683997pfa.10
        for <git@vger.kernel.org>; Wed, 02 Sep 2020 16:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Lc1KBpmTDdsw26wfxcN2xQ0HMdqeUPQm1kOyJUPYy1U=;
        b=QwdV6bN8nMBHmdCMGET0T0l67PweXD++hqGuj9syJKbodJqtgVDtREGDlAfDjX/Dy0
         gzDQEO2D08YMKUoBOwEpk9yFH0pnaxa0hhSLWOemDWe+G12eZ6qMiY0ULImU5p47/+Wd
         RUXzTIMPU2Xl74Z2DhJgj3bfEgNnWMZrBJYHj5PWjA4SaNDX1BlY7jJhIw+5WhvIogkS
         JTAX/g8q6HhzzBVGoloI9We0xs8vn5rtQ2iz4Co/lmcutoGS2/J1vPDWRHs3C8m1BfJm
         QyBR8Vz0hVZLD4ghFZ4rM6GsJwVL/41Bt3fRUhpkzuM2p4P7u4HWDStuqZPeM/Pk03jh
         MNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lc1KBpmTDdsw26wfxcN2xQ0HMdqeUPQm1kOyJUPYy1U=;
        b=OjQVT4H/+ePFC0viOvMzDT8sSbveDO2aEJtfxewjHLm4fJImS3ukgzdvPJcEHc9crM
         OlfxFxbd8Q4jQPOI6hJPj5GuzWQ3ypJYPKBlLdJPuHRqWspKVPXnOOAo9YZdUVusqFm2
         YaXZ1hyy3LgatjQc5+tInDzoxWmsH8oF2OZhBZYD0iaXm0b6GnVaGKzWujfg6DhSvx2q
         fvZP/1uDEgZk1+HgBdN4RV1bB3djGgyUcdR3B6Wn4uJufTx232K/4JhNuAeqRMvmNAQ8
         4kzGFggiCNWL9IOfmZkPIvu+CRGEHBBlk7RkUEWSGbCEkl+QfgsFxX6Gp69U2KGlPz7K
         pE3w==
X-Gm-Message-State: AOAM533qqgrOmXc8VCndLsGIM78sobFrAs7GYee0JlFjirzqYcOiE+nl
        BFgYp8MeUyVtb3r02mlba70=
X-Google-Smtp-Source: ABdhPJxT1dbCbHpx1NNKVId6tQh8WXzMQYUp9USZnDJAFwtMMsU4JeoErFvBytwbqEHq6Hh11aI++Q==
X-Received: by 2002:a17:902:8203:: with SMTP id x3mr794677pln.166.1599090991047;
        Wed, 02 Sep 2020 16:56:31 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id y7sm434002pgk.73.2020.09.02.16.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 16:56:30 -0700 (PDT)
Date:   Wed, 2 Sep 2020 16:56:28 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] fetch: no FETCH_HEAD display if --no-write-fetch-head
Message-ID: <20200902235628.GB4035286@google.com>
References: <xmqq7dtcaqob.fsf@gitster.c.googlers.com>
 <20200902210539.1981453-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902210539.1981453-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:

> 887952b8c6 ("fetch: optionally allow disabling FETCH_HEAD update",
> 2020-08-18) introduced the ability to disable writing to FETCH_HEAD
> during fetch, but did not suppress the "<source> -> FETCH_HEAD" message
> when this ability is used. This message is misleading in this case,
> because FETCH_HEAD is not written. Also, because "fetch" is used to
> lazy-fetch missing objects in a partial clone, this significantly
> clutters up the output in that case since the objects to be fetched are
> potentially numerous.
>
> Therefore, suppress this message when --no-write-fetch-head is passed
> (but not when --dry-run is set).
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
[...]
>  builtin/fetch.c          |  8 +++++++-
>  t/t0410-partial-clone.sh |  7 +++++--
>  t/t5510-fetch.sh         | 18 ++++++++++--------
>  3 files changed, 22 insertions(+), 11 deletions(-)

Thanks for fixing it, and sorry I didn't catch it during initial
review.

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 320ba9471d..c6c4689250 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1023,11 +1023,17 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>  				rc |= update_local_ref(ref, what, rm, &note,
>  						       summary_width);
>  				free(ref);
> -			} else
> +			} else if (write_fetch_head || dry_run) {
> +				/*
> +				 * Display fetches written to FETCH_HEAD (or
> +				 * would be written to FETCH_HEAD, if --dry-run

nit: to fix the parallel construction, s/would/that would/ or
s/written/that were written/

> +				 * is set).
> +				 */
>  				format_display(&note, '*',
>  					       *kind ? kind : "branch", NULL,
>  					       *what ? what : "HEAD",
>  					       "FETCH_HEAD", summary_width);
> +			}
>  			if (note.len) {
>  				if (verbosity >= 0 && !shown_url) {
>  					fprintf(stderr, _("From %.*s\n"),
> diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
> index d681e90640..584a039b85 100755
> --- a/t/t0410-partial-clone.sh
> +++ b/t/t0410-partial-clone.sh
> @@ -183,7 +183,7 @@ test_expect_success 'missing CLI object, but promised, passes fsck' '
>  '
>  
>  test_expect_success 'fetching of missing objects' '
> -	rm -rf repo &&
> +	rm -rf repo err &&
>  	test_create_repo server &&
>  	test_commit -C server foo &&
>  	git -C server repack -a -d --write-bitmap-index &&
> @@ -194,7 +194,10 @@ test_expect_success 'fetching of missing objects' '
>  
>  	git -C repo config core.repositoryformatversion 1 &&
>  	git -C repo config extensions.partialclone "origin" &&
> -	git -C repo cat-file -p "$HASH" &&
> +	git -C repo cat-file -p "$HASH" 2>err &&
> +
> +	# Ensure that no spurious FETCH_HEAD messages are written
> +	! grep FETCH_HEAD err &&

This test feels very specific to the bug being addressed.  That said,
since we *also* have a test below for the generic behavior I don't mind.

>  
>  	# Ensure that the .promisor file is written, and check that its
>  	# associated packfile contains the object
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index 2a1abe91f0..759aec9305 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -543,16 +543,18 @@ test_expect_success 'fetch into the current branch with --update-head-ok' '
>  
>  '
>  
> -test_expect_success 'fetch --dry-run does not touch FETCH_HEAD' '
> -	rm -f .git/FETCH_HEAD &&
> -	git fetch --dry-run . &&
> -	! test -f .git/FETCH_HEAD
> +test_expect_success 'fetch --dry-run does not touch FETCH_HEAD, but still prints what would be written' '
> +	rm -f .git/FETCH_HEAD err &&
> +	git fetch --dry-run . 2>err &&
> +	! test -f .git/FETCH_HEAD &&
> +	grep FETCH_HEAD err
>  '
>  
> -test_expect_success '--no-write-fetch-head does not touch FETCH_HEAD' '
> -	rm -f .git/FETCH_HEAD &&
> -	git fetch --no-write-fetch-head . &&
> -	! test -f .git/FETCH_HEAD
> +test_expect_success '--no-write-fetch-head does not touch FETCH_HEAD, and does not print what would be written' '
> +	rm -f .git/FETCH_HEAD err &&
> +	git fetch --no-write-fetch-head . 2>err &&
> +	! test -f .git/FETCH_HEAD &&
> +	! grep FETCH_HEAD err

Nice.

With or without the following squashed in,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

diff --git i/builtin/fetch.c w/builtin/fetch.c
index c6c46892503..387eeb1ec08 100644
--- i/builtin/fetch.c
+++ w/builtin/fetch.c
@@ -1025,9 +1025,9 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 				free(ref);
 			} else if (write_fetch_head || dry_run) {
 				/*
-				 * Display fetches written to FETCH_HEAD (or
-				 * would be written to FETCH_HEAD, if --dry-run
-				 * is set).
+				 * Display fetches that wrote to FETCH_HEAD (or,
+				 * if --dry-run is set, that would write to
+				 * FETCH_HEAD).
 				 */
 				format_display(&note, '*',
 					       *kind ? kind : "branch", NULL,
