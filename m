Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C07DC4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 08:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F1CD20756
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 08:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZZAnHgT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbgJEID4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 04:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgJEID4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 04:03:56 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519C4C0613CE
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 01:03:56 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id g10so3063217pfc.8
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 01:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Kt0zV0QSbCSFpX5HMgLHbfC55WGi0R5zvzVtkBcp+Wk=;
        b=RZZAnHgT69kpgwjderfXZELo9yU7xltaCDHthRdxAqwf7TavG7G+G05r9ur9Jwy2kU
         gQiaY9tH9OVo9lFAF0+aLifB2klUgVWcx21ySBcyhC9+SGj8Z7HAR+sOwPlugcXpXcs7
         HwpUPM8MM911YY9kY/xSw/+UHZ0+ddPaZMQjqp3iD5HMOgHmSoGNIYj56uUPCEjTHCp3
         QU7OBctz3lD9wXY8Zwyh3A3QdjTZKRTMOtEh1Rh8X2CRSc8GFEcw8+qZvHaZlKjcGze0
         ucHTBdsxfUnsdzioEvPk5iFYaSetjhf6w7PFL0u/7joZ3U7ILNua1aV0qAgAN9bFeL0E
         JQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kt0zV0QSbCSFpX5HMgLHbfC55WGi0R5zvzVtkBcp+Wk=;
        b=c80yOHVPb70rKfFazZ6RLfGrVU8puSCdvvxlRQv6Y0MluM+sIWa71YNCd40FUJoD3y
         WEHKBB2qA9l3WgVbieTXXljhO3tMlm+K4R1wk4xE35O8yVHxhr6kijxXLjiny4dlLR4K
         ILccSgdD5lSZTlwPGDGp95ey0YBQn6sBwF7uHfr1T7SBOm4B7tsuujLAZnvce/YlMLHm
         mV5y1MSbrOE0E88wImVVkgYeKHHSevHpNEwQSm+XAs1bzhOFkiZhwgTX/8pynuymlAMo
         MKMhdZZ2wA9xAm18s5F67Fn69RVuiZyNdhutUKqKeCsT9XMkBSo1AlDidf4zsMkqHyLw
         Jd7Q==
X-Gm-Message-State: AOAM532TpiVWW0Rucs/iK9kRGFy5+lCLUZ74LR1eMW6CDbhl3mX6347H
        q1yB3gi7CJs4Etqk7u8uUbw=
X-Google-Smtp-Source: ABdhPJwnn4NfCJM5UC35EVvhBzVEJ8P9ZS7b6kXa/Ffj51rhaYPACq0lnu/7196rZQw/c2tvutsdlw==
X-Received: by 2002:a63:8c49:: with SMTP id q9mr14001189pgn.427.1601885035756;
        Mon, 05 Oct 2020 01:03:55 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id z7sm9920562pgc.35.2020.10.05.01.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 01:03:55 -0700 (PDT)
Date:   Mon, 5 Oct 2020 01:03:53 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 5/7] t0060: test obscured .gitattributes and .gitignore
 matching
Message-ID: <20201005080353.GH1166820@google.com>
References: <20201005071751.GA2290770@coredump.intra.peff.net>
 <20201005072102.GE2291074@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005072102.GE2291074@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(+cc: Dscho for NTFS savvy)
Jeff King wrote:

> We have tests that cover various filesystem-specific spellings of
> ".gitmodules", because we need to reliably identify that path for some
> security checks. These are from dc2d9ba318 (is_{hfs,ntfs}_dotgitmodules:
> add tests, 2018-05-12), with the actual code coming from e7cb0b4455
> (is_ntfs_dotgit: match other .git files, 2018-05-11) and 0fc333ba20
> (is_hfs_dotgit: match other .git files, 2018-05-02).
>
> Those latter two commits also added similar matching functions for
> .gitattributes and .gitignore. These ended up not being used in the
> final series, and are currently dead code. But in preparation for them
> being used, let's make sure they actually work by throwing a few basic
> checks at them.
>
> I didn't bother with the whole battery of tests that we cover for
> .gitmodules. These functions are all based on the same generic matcher,
> so it's sufficient to test most of the corner cases just once.

Yeah, that's reasonable.

> Note that the ntfs magic prefix names in the tests come from the
> algorithm described in e7cb0b4455 (and are different for each file).

Doesn't block this patch, but I'm curious: how hard would it be to make
a test with an NTFS prerequisite that makes sure we got the magic prefix
right?

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/helper/test-path-utils.c | 41 ++++++++++++++++++++++++++------------
>  t/t0060-path-utils.sh      | 20 +++++++++++++++++++
>  2 files changed, 48 insertions(+), 13 deletions(-)
> 
> diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
> index 313a153209..9e253f8058 100644
> --- a/t/helper/test-path-utils.c
> +++ b/t/helper/test-path-utils.c
> @@ -172,9 +172,22 @@ static struct test_data dirname_data[] = {
>  	{ NULL,              NULL     }
>  };
>  
> -static int is_dotgitmodules(const char *path)
> +static int check_dotgitx(const char *x, const char **argv,
> +			 int (*is_hfs)(const char *),
> +			 int (*is_ntfs)(const char *))
>  {
> -	return is_hfs_dotgitmodules(path) || is_ntfs_dotgitmodules(path);
> +	int res = 0, expect = 1;
> +	for (; *argv; argv++) {
> +		if (!strcmp("--not", *argv))
> +			expect = !expect;
> +		else if (expect != (is_hfs(*argv) || is_ntfs(*argv)))
> +			 res = error("'%s' is %s.%s", *argv,
> +				     expect ? "not " : "", x);
> +		else
> +			fprintf(stderr, "ok: '%s' is %s.%s\n",
> +				*argv, expect ? "" : "not ", x);

micronit: extra space on the "res" line.

This "if" cascade is a little hard to read, even though it does the
right thing.  Can we make it more explicit?  E.g.

		if (!strcmp("--not", *argv)) {
			expect = !expect;
			continue;
		}

		actual = is_hfs(*argv) || is_ntfs(*argv);

		fprintf(stderr, "%s: '%s' is %s%s",
			expect == actual ? "ok" : "error",
			*argv, actual ? "" : "not ", x);
		if (expect != actual)
			res = -1;

I think it's a little easier to read with either (a) the dot included
in the 'x' parameter or (b) the entire ".git" missing from the 'x'
parameter.

[...]
> index 56db5c8aba..b2e3cf3f4c 100755
> --- a/t/t0060-path-utils.sh
> +++ b/t/t0060-path-utils.sh
> @@ -468,6 +468,26 @@ test_expect_success 'match .gitmodules' '
>  		.gitmodules,:\$DATA
>  '
>  
> +test_expect_success 'match .gitattributes' '
> +	test-tool path-utils is_dotgitattributes \
> +		.gitattributes \
> +		.git${u200c}attributes \
> +		.Gitattributes \
> +		.gitattributeS \
> +		GITATT~1 \
> +		GI7D29~1
> +'
> +
> +test_expect_success 'match .gitignore' '
> +	test-tool path-utils is_dotgitignore \
> +		.gitignore \
> +		.git${u200c}ignore \
> +		.Gitignore \
> +		.gitignorE \
> +		GITIGN~1 \
> +		GI250A~1
> +'
> +
>  test_expect_success MINGW 'is_valid_path() on Windows' '
>  	test-tool path-utils is_valid_path \
>  		win32 \

With whatever subset of the changes above makes sense,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
