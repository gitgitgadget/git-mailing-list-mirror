Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4129C83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 18:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2DCD20731
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 18:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="VKeN0nAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgD2S6y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 14:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726556AbgD2S6y (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 14:58:54 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E5AC03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 11:58:54 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f8so1181049plt.2
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 11:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qr8F23DGMP0HBt1/8hWCFcD5yHPlF158E7T6mySW9y8=;
        b=VKeN0nASLHEuewBpxOZG4WMF0PnfbzuVafNas2IgxA35Tk8la7x4jtzZmZdhxoBEvn
         hwEO0FlBRlWQD3d5tfufcsuVlsFHdDbYRh+crzj/Zer1ILKCT8ySaOVe6hTHxSfFp7N+
         KUWPkEFVeIg6f8gYNxQVh2hAuk1NfFFRTkReNFxyWSiWSh7UEe1/VLZTNC03g4X1KvWT
         MdTcZkgbKQKt71U4n3TxoWNYzFDVFcs5cTUoBzDi/uuLv3QjKlJDLzKVD0Qp7mmzyM8Z
         vnuWlGs1zIF4OXNMZrqzmb+M1bBMOdibPA4MhiTk5q16YJJWEwpmd5WrhTbMODyG1lxZ
         XGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qr8F23DGMP0HBt1/8hWCFcD5yHPlF158E7T6mySW9y8=;
        b=Zv2FxnwYpX3k8UFH73NRqa35LegZNuseu5xkTG217sF3VEECImOzyBnXgn3tcw52iS
         wspLjVpr/pOsX4DCI6JhIsrvoZ3bdnzWZiflcs7ETpt2mIyePjf0uZaqBqL5Rwd6CfCz
         CDj47qRkP9MTiEjhFDxpifds7l+JbPiSuXlnzsyoyLf96GTVewchmCF/V6HO6ZQ3y+Q/
         FhJcDHHVIMR4pSv51HZN1vLwYBLbwNh66/rwmrJsLw9w/Fvtd4Idgi761NkrR0A4OVuE
         E/TsBFNcPjxbFdavJ70Kc4+HHIA91bIZuLEJhV6dFjm3qXBlq+jolxD6NsdwF2cTslaW
         VAqw==
X-Gm-Message-State: AGi0PubGaZC545DEyr/9POXHXUTDMxFTY/UVKlLgTNoLnAcN3gASIFa9
        +2+wDzw3uwoxTO/qCMBnAjfkeApGYLg6ig==
X-Google-Smtp-Source: APiQypKfetzkVbtmAVLs+2Kyx+UbKCQyiubWUyRb4VDDdMpZxUuMgk3jYS+uCiPVvzB+gNH7BvkBew==
X-Received: by 2002:a17:902:b405:: with SMTP id x5mr34964072plr.312.1588186733597;
        Wed, 29 Apr 2020 11:58:53 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id w30sm1650705pfj.25.2020.04.29.11.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 11:58:52 -0700 (PDT)
Date:   Wed, 29 Apr 2020 12:58:51 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Ivan Tham <pickfire@riseup.net>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] branch: add '-' to delete previous branch
Message-ID: <20200429185851.GF83442@syl.local>
References: <20200429130133.520981-1-pickfire@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200429130133.520981-1-pickfire@riseup.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 29, 2020 at 09:01:33PM +0800, Ivan Tham wrote:
> Add support to delete previous branch from git checkout/switch to have
> feature parity with git switch -.
>
> Signed-off-by: Ivan Tham <pickfire@riseup.net>
> ---
>  Documentation/git-branch.txt | 10 ++++++++++
>  builtin/branch.c             |  6 +++++-
>  t/t3200-branch.sh            |  7 +++++++
>  3 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index 135206ff4a..37e7cbbc52 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -265,6 +265,10 @@ start-point is either a local or remote-tracking branch.
>  	The new branch name must pass all checks defined by
>  	linkgit:git-check-ref-format[1].  Some of these checks
>  	may restrict the characters allowed in a branch name.
> ++
> +You can use the `@{-N}` syntax to refer to the N-th last branch checked out
> +using "git checkout" operation. You may also specify `-` which is synonymous to
> +`@{-1}`.

Interesting; we're already using strbuf_branchname, so the first part of
this documentation was true even before this commit. Would you consider
splitting this into two patches?

The first should include the first sentence of this documentation, an
additional test in t3200 exercising an explicit 'git branch -D @{-N}'
for some 'N', but no changes in builtin/branch.c. The second patch would
then make '-' a synonym for '@{-1}'.

>  <start-point>::
>  	The new branch head will point to this commit.  It may be
> @@ -334,6 +338,12 @@ $ git branch -D test                                    <2>
>  <2> Delete the "test" branch even if the "master" branch (or whichever branch
>      is currently checked out) does not have all commits from the test branch.
>
> +To delete the previous branch::
> ++
> +------------
> +$ git branch -D -
> +------------
> +
>  Listing branches from a specific remote::
>  +
>  ------------
> diff --git a/builtin/branch.c b/builtin/branch.c
> index d8297f80ff..5537f819a6 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -227,9 +227,13 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>  	}
>  	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
>  		char *target = NULL;
> +		const char *arg = argv[i];
>  		int flags = 0;
>
> -		strbuf_branchname(&bname, argv[i], allowed_interpret);
> +		if (!strcmp(arg, "-"))
> +			arg = "@{-1}";
> +
> +		strbuf_branchname(&bname, arg, allowed_interpret);
>  		free(name);
>  		name = mkpathdup(fmt, bname.buf);
>
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 411a70b0ce..6819107c1d 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -1387,4 +1387,11 @@ test_expect_success 'invalid sort parameter in configuration' '
>  	)
>  '
>
> +test_expect_success 'delete previous branch' '
> +	git checkout -b a &&
> +	git checkout -b b &&
> +	git branch -D - &&
> +	test_path_is_missing .git/refs/heads/a

This assertion is a little uncommon in t3200 for this style of test.
Please use the more-standard:

  git branch >actual &&
  cat >expect <<-\EOF &&
     master
   * b
  EOF
  test_cmp expect actual

Substituting the body of the heredoc for the actual state of things.
This form makes it a little clearer what branches should and shouldn't
exist.

> +'
> +
>  test_done
> --
> 2.26.2
>

Thanks,
Taylor
