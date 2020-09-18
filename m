Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5F3C43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 14:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E18E21D42
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 14:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="vI+v79rz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgIROqz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 10:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgIROqz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 10:46:55 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D47C0613CE
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 07:46:54 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e7so5123344qtj.11
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 07:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NqbFV6EJjdCl3iA0O1N8XeJXdQgP64RjZc+DwOaOPHs=;
        b=vI+v79rzdb9gRltudMrIYEnM18lWJBFJguKUScDK2ebvMu1SWO0nlucPkoBZb7+heF
         FmNMRNRdxDLReEryGY9Mi4AZ5fLuRhZBT3KyDdJD4xSneAdwgZilrtjNcb1xzFTW0RdF
         PxhomerMMVrm+FgohdqJyjfPEIqt7we7BXtig9GDo4oR0I8sq0Nz18oItgrdQ0lnXnrx
         ARjwCMnW70bypk/rt+ZZWS6r12f0zurCuSu47jqFC5tHTwNUWNbehM0ZvZwoptkBII5Q
         RJWY3I6nPzlk6RE9ct/ImVkYBNtmCFcfFe0UUj7VWAx5nsg/bYZz8PLvfkJsLwNGPBjE
         SL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NqbFV6EJjdCl3iA0O1N8XeJXdQgP64RjZc+DwOaOPHs=;
        b=uZ2vQrKxPhuxHB4ppfTktXPn52sjdtN1TQtasijBEA43uXg3iQizOPZWhQEJGlT0XI
         6nazy/x+xlSbotxB6sDOQX6dbl53KR+ultGIdIkXTI+u5iao/0Mno3ZkCfbieGAqGb7F
         ZwZ9gNrmY0K/0CK1gSIcfQO4HvxQEgWffWx1gmsHSsT8Ks6sLf4yTJw2cGsuLn5NpYvO
         7nbNcgwAM1nfJXoo2OWr8MZkyJ82uQuvfEigz/IQkB3CKd47a0uNXDb09jJmtHnOLL0h
         n68X47UOIvkoxPojNyEJz49G0fZVb+7QAWrazY3pbB7MmOn43qkQ7QFkPz1JWRFYr0Ek
         guJA==
X-Gm-Message-State: AOAM532In/wpJFhPgi6kSrjeRyrKV9egz32poepUscjF2T2zkPxAfvbE
        nvh8OFUVtism/lKDEuAYFBdTJw==
X-Google-Smtp-Source: ABdhPJyWbmmqq1zbMyWBUdsclup7aDycHyqBgrN4qYo3Ih3xo75injalygzKwf5YB+3Y9tJzJD+siQ==
X-Received: by 2002:ac8:120a:: with SMTP id x10mr32619402qti.88.1600440413978;
        Fri, 18 Sep 2020 07:46:53 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:2003:d617:ca70:4fd1])
        by smtp.gmail.com with ESMTPSA id 192sm2262061qkn.9.2020.09.18.07.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 07:46:53 -0700 (PDT)
Date:   Fri, 18 Sep 2020 10:46:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Thomas Guyot-Sionnest <tguyot@gmail.com>
Cc:     git@vger.kernel.org, dermoth@aei.ca
Subject: Re: [PATCH 1/2] diff: Fix modified lines stats with --stat and
 --numstat
Message-ID: <20200918144651.GA1612043@nand.local>
References: <20200918113256.8699-1-tguyot@gmail.com>
 <20200918113256.8699-2-tguyot@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200918113256.8699-2-tguyot@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 18, 2020 at 07:32:55AM -0400, Thomas Guyot-Sionnest wrote:
> In builtin_diffstat(), when both files are coming from "stdin" (which
> could be better described as the file's content being written directly
> into the file object), oideq() compares two null hashes and ignores the
> actual differences for the statistics.
>
> This patch checks if is_stdin flag is set on both sides and compare
> contents directly.
>
> Signed-off-by: Thomas Guyot-Sionnest <tguyot@gmail.com>
> ---
>  diff.c                | 5 ++++-
>  t/t3206-range-diff.sh | 8 ++++----
>  2 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index a5114fa864..2995527896 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3681,7 +3681,10 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
>  		return;
>  	}
>
> -	same_contents = oideq(&one->oid, &two->oid);
> +	if (one->is_stdin && two->is_stdin)
> +		same_contents = !strcmp(one->data, two->data);

Hmm. A couple of thoughts here:

  - strcmp seems like a slow-down here, since we'll have to go through
    at worst the smaller of one->data and two->data to compare each of
    them.

  - strcmp is likely not the right way to do that, since we could be
    diffing binary content, in which case we'd want to continue over
    NULs and instead stop at a fixed length (the minimum of the length
    of one->data and two->data, specifically). I'd have expected memcmp
    here instead.

  - Why do we have to do this at all all the way up in
    'builtin_diffstat'? I would expect these to contain the right
    OIDs by the time they are given back to us from the call to
    'diff_fill_oid_info' in 'run_diffstat'.

So, my last point is the most important of the three. I'd expect
something more along the lines of:

  1. diff_fill_oid_info resolve the link to the pipe, and
  2. index_path handles the resolved fd.

...but it looks like that is already what it's doing? I'm confused why
this doesn't work as-is.

> +	else
> +		same_contents = oideq(&one->oid, &two->oid);
>
>  	if (diff_filespec_is_binary(o->repo, one) ||
>  	    diff_filespec_is_binary(o->repo, two)) {
> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> index e024cff65c..4715e75b68 100755
> --- a/t/t3206-range-diff.sh
> +++ b/t/t3206-range-diff.sh
> @@ -258,11 +258,11 @@ test_expect_success 'changed commit with --stat diff option' '
>  	     a => b | 0
>  	     1 file changed, 0 insertions(+), 0 deletions(-)
>  	3:  $(test_oid t3) ! 3:  $(test_oid c3) s/11/B/
> -	     a => b | 0
> -	     1 file changed, 0 insertions(+), 0 deletions(-)
> +	     a => b | 2 +-
> +	     1 file changed, 1 insertion(+), 1 deletion(-)
>  	4:  $(test_oid t4) ! 4:  $(test_oid c4) s/12/B/
> -	     a => b | 0
> -	     1 file changed, 0 insertions(+), 0 deletions(-)
> +	     a => b | 2 +-
> +	     1 file changed, 1 insertion(+), 1 deletion(-)

The tests definitely demonstrate that the old behavior was wrong,
though...

Thanks,
Taylor
