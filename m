Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B73C433E1
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 10:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4980C206F4
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 10:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnWykxI6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbgGOKAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 06:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgGOKAr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 06:00:47 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B196C061755
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 03:00:47 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id w6so1539976ejq.6
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 03:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wzCvBKnK8rhrB2QVLJxFoypAn731acS2WGXAToIIyh0=;
        b=OnWykxI6JXy66XOWlGT1a8tSTzpSf9znJCKAkbKwxblnfoCZbChfh6lGDQpqtp2lZX
         /tjIj4Cv1t4NufCmqUe9pSCGEgK/ZKVxLm0UUFHhEhDq5eogAJ8mh2VvXkPb+owAJNw6
         HtOI/DhkhAMIlKOrjP28kwMta0zC6OxbcauvUTxP4JW9qklnW0mAL2AQmcBOzMVOEiuA
         guvSB9unwHeGuSwecR4nsm9LyNt6HOlh03LNBFNjuYFbJpWTUjkJRQaTlAQf1kDjG1LG
         ZnEscH65Q5dbEtmNCxMMuIa8hAf71QIKEWQKd8FysMlh0tfPDt7JlBkCS02wl6R98hT3
         pglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wzCvBKnK8rhrB2QVLJxFoypAn731acS2WGXAToIIyh0=;
        b=KSDeUsfh16FinG+zpj/XeOq0q153G7fvEMthP8uJT2atK3XiILNnqVrTGhQA1lv6Qq
         o6BuvsyFmCrIvD/bdqKqgfVQP9inVNg7qM5M6++Zzcdzkyz7IakfynjbbRj4KOQWWsXu
         43BIEFiu4m58YvaJTowfF0b38L0LLXQxIntMgjB4bT40DLvk+eNQebIlykRJ3aIaLJ0O
         YYScpW+1u9Bgoig1OjG0VofHiislYGsmQZUvlg4C/8UFRCy8MywUSZAb/FzsDTJbzt9o
         Y8uD9bNk8QB9KibsO4ReXbWRqHiSPNW1oKT9YF73kOrQtVLCbe4iEo0ka35zSUDpWxxL
         f7nA==
X-Gm-Message-State: AOAM530wNJAbZCFMyAOoreZRyQsR29yoM7j9z2q+kwLAEyTBG1xcq8z8
        hWPqjYCdByYuQ8T9ZdKzNPg=
X-Google-Smtp-Source: ABdhPJz0dZaKjRkhC+EfQ0FGBEM3/W09wVbyAjGk9URMpuwGPnolv12bWTFk3lOWuAicvB+YhwYC6w==
X-Received: by 2002:a17:906:8595:: with SMTP id v21mr8706907ejx.333.1594807246185;
        Wed, 15 Jul 2020 03:00:46 -0700 (PDT)
Received: from szeder.dev (78-131-17-71.pool.digikabel.hu. [78.131.17.71])
        by smtp.gmail.com with ESMTPSA id i10sm1659620edx.42.2020.07.15.03.00.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 03:00:45 -0700 (PDT)
Date:   Wed, 15 Jul 2020 12:00:43 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, chriscool@tuxfamily.org
Subject: Re: [PATCH 2/4] upload-pack.c: allow banning certain object filter(s)
Message-ID: <20200715100043.GG11341@szeder.dev>
References: <cover.1593720075.git.me@ttaylorr.com>
 <f0982d24e74155f6c0e405e5e3ae8c3e579f798a.1593720075.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f0982d24e74155f6c0e405e5e3ae8c3e579f798a.1593720075.git.me@ttaylorr.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 02, 2020 at 04:06:32PM -0400, Taylor Blau wrote:
> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> index 8a27452a51..5dcd0b5656 100755
> --- a/t/t5616-partial-clone.sh
> +++ b/t/t5616-partial-clone.sh
> @@ -235,6 +235,32 @@ test_expect_success 'implicitly construct combine: filter with repeated flags' '
>  	test_cmp unique_types.expected unique_types.actual
>  '
>  
> +test_expect_success 'upload-pack fails banned object filters' '
> +	# Test case-insensitivity by intentional use of "blob:None" rather than
> +	# "blob:none".
> +	test_config -C srv.bare uploadpack.filter.blob:None.allow false &&
> +	test_must_fail git clone --no-checkout --filter=blob:none \
> +		"file://$(pwd)/srv.bare" pc3 2>err &&
> +	test_i18ngrep "filter '\''blob:none'\'' not supported" err
> +'
> +
> +test_expect_success 'upload-pack fails banned combine object filters' '
> +	test_config -C srv.bare uploadpack.filter.allow false &&
> +	test_config -C srv.bare uploadpack.filter.combine.allow true &&
> +	test_config -C srv.bare uploadpack.filter.tree.allow true &&
> +	test_config -C srv.bare uploadpack.filter.blob:none.allow false &&
> +	test_must_fail git clone --no-checkout --filter=tree:1 \
> +		--filter=blob:none "file://$(pwd)/srv.bare" pc3 2>err &&
> +	test_i18ngrep "filter '\''blob:none'\'' not supported" err
> +'
> +
> +test_expect_success 'upload-pack fails banned object filters with fallback' '
> +	test_config -C srv.bare uploadpack.filter.allow false &&
> +	test_must_fail git clone --no-checkout --filter=blob:none \
> +		"file://$(pwd)/srv.bare" pc3 2>err &&
> +	test_i18ngrep "filter '\''blob:none'\'' not supported" err
> +'

These three tests are very flaky: 'git upload-pack' can error out
while clone is still sending packets (usually the 'done' line),
resulting in SIGPIPE and frequent CI failures.  Running this test
script with '-r 1,2,17-19 --stress' tends to fail in a couple of
seconds.

Using 'test_must_fail ok=sigpipe', as you did in the test in the last
patch, avoids the test failure caused by SIGPIPE, of course, but,
unfortunately, all three tests remain flaky, because the expected
error message sometimes doesn't make it to 'git clone's stderr, e.g.:

  expecting success of 5616.19 'upload-pack fails banned object filters with fallback': 
          test_config -C srv.bare uploadpack.filter.allow false &&
          test_must_fail ok=sigpipe git clone --no-checkout --filter=blob:none \
                  "file://$(pwd)/srv.bare" pc3 2>err &&
          test_i18ngrep "filter 'blob:none' not supported" err
  
  + test_config -C srv.bare uploadpack.filter.allow false
  + pwd
  + test_must_fail ok=sigpipe git clone --no-checkout --filter=blob:none file:///home/szeder/src/git/t/trash directory.t5616-partial-clone.stress-2/srv.bare pc3
  + test_i18ngrep filter 'blob:none' not supported err
  error: 'grep filter 'blob:none' not supported err' didn't find a match in:
  Cloning into 'pc3'...
  fatal: git upload-pack: banned object filter requested
  error: last command exited with $?=1
  not ok 19 - upload-pack fails banned object filters with fallback


Once upon a time I had a PoC patch to deal with 'git upload-pack'
aborting while 'git fetch' is still send_request()-ing, by catching
the write error to the closed connection and trying read any pending
ERR packets; Christian cleaned it up and submitted it with a proper
commit message in

  https://public-inbox.org/git/20200422163357.27056-1-chriscool@tuxfamily.org/

but it haven't been picked up yet.  Disappointingly, that patch
doesn't solve these issues...  I haven't looked what's going on
(perhaps 'git clone' does something differently than 'git fetch'?  no
idea)

