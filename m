Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538FEC3A5A9
	for <git@archiver.kernel.org>; Tue,  5 May 2020 00:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FFEB206EB
	for <git@archiver.kernel.org>; Tue,  5 May 2020 00:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="za1XZWmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgEEANk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 20:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgEEANj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 20:13:39 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFB7C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 17:13:39 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 18so33801pfv.8
        for <git@vger.kernel.org>; Mon, 04 May 2020 17:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5dLSoyBVoM6FipdliA3KmQ5slK0mKGaQP3ELfc9/fDM=;
        b=za1XZWmJ1fJdpHwOrsV80SXod1vdUeWx/lr4Lc2fRe+KpJ0hTJCBOMsNe5N/WKLFuz
         u1S39bJHD6Dp4PElRyXLKJjyI3ywSjk7CMH/q/p9fVAqrP7niTgBwW8NfzP75nS7G9FB
         j34DkdddSaNC9iQqsfZT8E3F6Oq7mxalwU3THz1KegOfFOPvmm/6437a/2VFkb3PdHuI
         OQroucX5uhLV446OU7DRtAOO8pHwsovIHHrrve/WDibBsIWAom6be3cJiUgInjMm8bJk
         LiwS5w6JHvohJ3eOByGjAgT4vh/sAohHWKXWwzbU5OFqMooOmcK0c0OS7u7OKAIXopZK
         eORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5dLSoyBVoM6FipdliA3KmQ5slK0mKGaQP3ELfc9/fDM=;
        b=DkBNw5OTLGzk9KpiMO2Oi1ZsovdLKcOy9X+KpzuVtLrn0frIJRk12ocHquGipUFk7J
         u5yTltInZ85REiNV49e9VoB2LlpXK7UhuvNrKWUFWDBkeLMqqI7e9gFGqBTbzyXS5842
         dc7nT61+zrMM1g5aNfcOD20IR6ifl49+PcZf4r8O2fzzxZbkPnqJO/M+oxh8VMK9T0Lf
         68hmUvGVUwFOKEO5k0CBBW/2hDYEB0DBkKdgaHUgUAbDSpgnO1RBxPIFNME/MIk1dRwM
         F1PRNzHmYDbP0oRK2eUYOmxEcIPlenhkUj0D3UWujWOOGFZfGCZvVzh1bWKx5em0cJoT
         mjkA==
X-Gm-Message-State: AGi0Pua1QvzTnD3vPDaFU99RrRxxVS7K2jTNIHPNd864+YL03sY6WyI/
        E2GWfQ8ePnEf4wR+iqkhScHdmtJXJ0S0ww==
X-Google-Smtp-Source: APiQypJcImS9xaEbqcQ/AMHe2nE1lInByoB0r5S/fgqWYSVr+WBgyIdQaBF/nJ4M84wErao+1FyBPw==
X-Received: by 2002:a62:7ece:: with SMTP id z197mr560110pfc.244.1588637618976;
        Mon, 04 May 2020 17:13:38 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id r12sm179348pgv.59.2020.05.04.17.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 17:13:38 -0700 (PDT)
Date:   Mon, 4 May 2020 18:13:36 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     clime <clime7@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] ref-filter: apply --ignore-case to all sorting keys
Message-ID: <20200505001336.GK45250@syl.local>
References: <20200503090952.GA170768@coredump.intra.peff.net>
 <20200503091157.GA170902@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200503091157.GA170902@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 03, 2020 at 05:11:57AM -0400, Jeff King wrote:
> All of the ref-filter users (for-each-ref, branch, and tag) take an
> --ignore-case option which makes filtering and sorting case-insensitive.
> However, this option was applied only to the first element of the
> ref_sorting list. So:
>
>   git for-each-ref --ignore-case --sort=refname
>
> would do what you expect, but:
>
>   git for-each-ref --ignore-case --sort=refname --sort=taggername
>
> would sort the primary key (taggername) case-insensitively, but sort the
> refname case-sensitively. We have two options here:
>
>   - teach callers to set ignore_case on the whole list
>
>   - replace the ref_sorting list with a struct that contains both the
>     list of sorting keys, as well as options that apply to _all_
>     keys
>
> I went with the first one here, as it gives more flexibility if we later
> want to let the users set the flag per-key (presumably through some
> special syntax when defining the key; for now it's all or nothing
> through --ignore-case).

Makes sense, I think that this will provide us more flexibility in the
future in case we want to have per-flag keys or some such.

> The new test covers this by sorting on both tagger and subject
> case-insensitively, which should compare "a" and "A" identically, but
> still sort them before "b" and "B". We'll break ties by sorting on the
> refname to give ourselves a stable output (this is actually supposed to
> be done automatically, but there's another bug which will be fixed in
> the next commit).

Thanks for adding a test.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/branch.c        |  2 +-
>  builtin/for-each-ref.c  |  2 +-
>  builtin/tag.c           |  2 +-
>  ref-filter.c            |  6 ++++++
>  ref-filter.h            |  2 ++
>  t/t6300-for-each-ref.sh | 40 ++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 51 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index d8297f80ff..86341cc835 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -739,7 +739,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  		 */
>  		if (!sorting)
>  			sorting = ref_default_sorting();
> -		sorting->ignore_case = icase;
> +		ref_sorting_icase_all(sorting, icase);
>  		print_ref_list(&filter, sorting, &format);
>  		print_columns(&output, colopts, NULL);
>  		string_list_clear(&output, 0);
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 465153e853..57489e4eab 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -70,7 +70,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>
>  	if (!sorting)
>  		sorting = ref_default_sorting();
> -	sorting->ignore_case = icase;
> +	ref_sorting_icase_all(sorting, icase);
>  	filter.ignore_case = icase;
>
>  	filter.name_patterns = argv;
> diff --git a/builtin/tag.c b/builtin/tag.c
> index dd160b49c7..ff7610b5c8 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -485,7 +485,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  	}
>  	if (!sorting)
>  		sorting = ref_default_sorting();
> -	sorting->ignore_case = icase;
> +	ref_sorting_icase_all(sorting, icase);
>  	filter.ignore_case = icase;
>  	if (cmdmode == 'l') {
>  		int ret;
> diff --git a/ref-filter.c b/ref-filter.c
> index 35776838f4..bdb3535ce5 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2317,6 +2317,12 @@ static int compare_refs(const void *a_, const void *b_, void *ref_sorting)
>  	return 0;
>  }
>
> +void ref_sorting_icase_all(struct ref_sorting *sorting, int flag)
> +{
> +	for (; sorting; sorting = sorting->next)
> +		sorting->ignore_case = !!flag;
> +}
> +
>  void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
>  {
>  	QSORT_S(array->items, array->nr, compare_refs, sorting);
> diff --git a/ref-filter.h b/ref-filter.h
> index 64330e9601..8ecc33cdfa 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -114,6 +114,8 @@ void ref_array_clear(struct ref_array *array);
>  int verify_ref_format(struct ref_format *format);
>  /*  Sort the given ref_array as per the ref_sorting provided */
>  void ref_array_sort(struct ref_sorting *sort, struct ref_array *array);
> +/*  Set the ignore_case flag for all elements of a sorting list */
> +void ref_sorting_icase_all(struct ref_sorting *sorting, int flag);
>  /*  Based on the given format and quote_style, fill the strbuf */
>  int format_ref_array_item(struct ref_array_item *info,
>  			  const struct ref_format *format,
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index b3c1092338..c9caf26327 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -895,4 +895,44 @@ test_expect_success 'for-each-ref --ignore-case ignores case' '
>  	test_cmp expect actual
>  '
>
> +test_expect_success 'for-each-ref --ignore-case works on multiple sort keys' '
> +	# name refs numerically to avoid case-insensitive filesystem conflicts
> +	nr=0 &&
> +	for email in a A b B
> +	do
> +		for subject in a A b B
> +		do
> +			GIT_COMMITTER_EMAIL="$email@example.com" \
> +			git tag -m "tag $subject" icase-$(printf %02d $nr) &&
> +			nr=$((nr+1))||
> +			return 1
> +		done
> +	done &&
> +	git for-each-ref --ignore-case \
> +		--format="%(taggeremail) %(subject) %(refname)" \
> +		--sort=refname \
> +		--sort=subject \
> +		--sort=taggeremail \
> +		refs/tags/icase-* >actual &&
> +	cat >expect <<-\EOF &&
> +	<a@example.com> tag a refs/tags/icase-00
> +	<a@example.com> tag A refs/tags/icase-01
> +	<A@example.com> tag a refs/tags/icase-04
> +	<A@example.com> tag A refs/tags/icase-05
> +	<a@example.com> tag b refs/tags/icase-02
> +	<a@example.com> tag B refs/tags/icase-03
> +	<A@example.com> tag b refs/tags/icase-06
> +	<A@example.com> tag B refs/tags/icase-07
> +	<b@example.com> tag a refs/tags/icase-08
> +	<b@example.com> tag A refs/tags/icase-09
> +	<B@example.com> tag a refs/tags/icase-12
> +	<B@example.com> tag A refs/tags/icase-13
> +	<b@example.com> tag b refs/tags/icase-10
> +	<b@example.com> tag B refs/tags/icase-11
> +	<B@example.com> tag b refs/tags/icase-14
> +	<B@example.com> tag B refs/tags/icase-15
> +	EOF
> +	test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.26.2.957.g6dc93e954a

All looks very reasonable, so:

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
