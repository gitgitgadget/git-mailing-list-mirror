Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22678C433F5
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 21:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350273AbhLWVvu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 16:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbhLWVvt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 16:51:49 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EA9C061401
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 13:51:49 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id w7so4770715plp.13
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 13:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pWou4rlEc0LZEWFNYkR92hn6SmCwunxz+ALs9NIAbNw=;
        b=n5w5VJgEF4K87yAmnvfiYkoBh0JFWU9sdlxrlLDFZQT0GgotOlyVzy82EWJZQquIAX
         kHaEgIg8jR74Av5i/rdiYJlClfMwrJOIxQ2x+bxyE2tay1uYx3j3XC+H1uRSLgH/xFBa
         qsnALhK6xM7jqilTq3GdtcrHxu6F3euhZ0XNtEzeeJAqL4Kgc0dcF8RwN7yvkahiJGui
         itZW0IG44ye4GZvhi/cZI5hfr2NMpP4Dl/HQCO7YlHtmpFPZDdF12xJCd1P4WSRXE66v
         ARz6D6BloOHNsMCY87+Aae8CxqL07QbjEVOkglnO2cbaVMa3nu2cefBXelsTctm3jDRg
         y7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=pWou4rlEc0LZEWFNYkR92hn6SmCwunxz+ALs9NIAbNw=;
        b=n+lO4PBs24fMHYvjXkQRoYzFzL/pbK9G/TR4bq6LxzHh/U2Gfkh77p2nf1LcuneXa0
         mBUYCMrk/f5QaMwLVR/yaUoi3OyFbA7+de45S4tP1xD4+EUgf7suiev+3jTZ66sR9JJu
         rPiD0z+EfMdnKjIaqmkMvQzsNcWa/7cDnJN1vQBsjdMuRUvxCDOywG5QTiNmSD1tL73o
         0p7okk0LaLpn8UW0uqiFiH23+uJf0Ncfz9W+PfnW0ilAdh/MuM1vk4Nj3tB/QFQRKifZ
         xvTicJAKtcN/WVjc1zIR75wiuokdaJRBTChd/cQJFzoT7SOcQtpH0QlkdI3uX1nITRk0
         OsAw==
X-Gm-Message-State: AOAM5314MTrQzZ+nW2LlyusOykP0qyA0tYmfW+aup2UAwKU+8KcuX0nY
        RiGLSrD4trRgIjoY/y6ke0wu2O0RVbv2Aw==
X-Google-Smtp-Source: ABdhPJw6G78MghRG2jo2ORxHrgWouRVo3/WgAWBoeuXNPjPQFkWUk2ijUt1AkwbnJJeJpzHEKK1DZg==
X-Received: by 2002:a17:902:c214:b0:148:a798:7aa with SMTP id 20-20020a170902c21400b00148a79807aamr4101815pll.90.1640296307924;
        Thu, 23 Dec 2021 13:51:47 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:3d09:6204:5070:ab7a])
        by smtp.gmail.com with ESMTPSA id on7sm6891473pjb.50.2021.12.23.13.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 13:51:47 -0800 (PST)
Date:   Thu, 23 Dec 2021 13:51:40 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v5 1/6] object-name tests: add tests for ambiguous object
 blind spots
Message-ID: <YcTvbH9tjXoJYpVN@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Bagas Sanjaya <bagasdotme@gmail.com>
References: <cover-v4-0.3-00000000000-20211122T175219Z-avarab@gmail.com>
 <cover-v5-0.6-00000000000-20211125T215529Z-avarab@gmail.com>
 <patch-v5-1.6-767165d096d-20211125T215529Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v5-1.6-767165d096d-20211125T215529Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.11.25 23:03, Ævar Arnfjörð Bjarmason wrote:
> Extend the tests for ambiguous objects to check how we handle objects
> where we return OBJ_BAD when trying to parse them. As noted in [1] we
> have a blindspot when it comes to this behavior.
> 
> Since we need to add new test data here let's extend these tests to be
> tested under SHA-256, in d7a2fc82491 (t1512: skip test if not using
> SHA-1, 2018-05-13) all of the existing tests were skipped, as they
> rely on specific SHA-1 object IDs.
> 
> For these tests it only matters that the first 4 characters of the OID
> prefix are the same for both SHA-1 and SHA-256. This uses strings that
> I mined, and have the same prefix when hashed with both.
> 
> 1. https://lore.kernel.org/git/YZwbphPpfGk78w2f@coredump.intra.peff.net/
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/t1512-rev-parse-disambiguation.sh | 84 +++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
> diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
> index 7891a6becf3..ae1c0cf2b21 100755
> --- a/t/t1512-rev-parse-disambiguation.sh
> +++ b/t/t1512-rev-parse-disambiguation.sh
> @@ -25,6 +25,90 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  
>  . ./test-lib.sh
>  
> +test_cmp_failed_rev_parse () {
> +	dir=$1
> +	rev=$2
> +	shift
> +
> +	test_must_fail git -C "$dir" rev-parse "$rev" 2>actual.raw &&
> +	sed "s/\($rev\)[0-9a-f]*/\1.../g" <actual.raw >actual &&
> +	test_cmp expect actual
> +}
> +
> +test_expect_success 'ambiguous blob output' '
> +	git init --bare blob.prefix &&
> +	(
> +		cd blob.prefix &&
> +
> +		# Both start with "dead..", under both SHA-1 and SHA-256
> +		echo brocdnra | git hash-object -w --stdin &&
> +		echo brigddsv | git hash-object -w --stdin &&

These "dead.." objects don't seem to be used later, unless I've missed
something.


> +		# Both start with "beef.."
> +		echo 1agllotbh | git hash-object -w --stdin &&
> +		echo 1bbfctrkc | git hash-object -w --stdin
> +	) &&
> +
> +	cat >expect <<-\EOF &&
> +	error: short object ID beef... is ambiguous
> +	hint: The candidates are:
> +	hint:   beef... blob
> +	hint:   beef... blob
> +	fatal: ambiguous argument '\''beef...'\'': unknown revision or path not in the working tree.
> +	Use '\''--'\'' to separate paths from revisions, like this:
> +	'\''git <command> [<revision>...] -- [<file>...]'\''
> +	EOF
> +	test_cmp_failed_rev_parse blob.prefix beef
> +'

Rather than comparing the entire output (which can be brittle), can we
just grep for the important parts of the error message and compare
those?


> +test_expect_success 'ambiguous loose blob parsed as OBJ_BAD' '
> +	git init --bare blob.bad &&
> +	(
> +		cd blob.bad &&
> +
> +		# Both have the prefix "bad0"
> +		echo xyzfaowcoh | git hash-object -t bad -w --stdin --literally &&
> +		echo xyzhjpyvwl | git hash-object -t bad -w --stdin --literally
> +	) &&
> +
> +	cat >expect <<-\EOF &&
> +	error: short object ID bad0... is ambiguous
> +	hint: The candidates are:
> +	fatal: invalid object type
> +	EOF
> +	test_cmp_failed_rev_parse blob.bad bad0
> +'
> +
> +test_expect_success POSIXPERM 'ambigous zlib corrupt loose blob' '
> +	git init --bare blob.corrupt &&
> +	(
> +		cd blob.corrupt &&
> +
> +		# Both have the prefix "cafe"
> +		echo bnkxmdwz | git hash-object -w --stdin &&
> +		oid=$(echo bmwsjxzi | git hash-object -w --stdin) &&
> +
> +		oidf=objects/$(test_oid_to_path "$oid") &&
> +		chmod 755 $oidf &&
> +		echo broken >$oidf
> +	) &&
> +
> +	cat >expect <<-\EOF &&
> +	error: short object ID cafe... is ambiguous
> +	hint: The candidates are:
> +	error: inflate: data stream error (incorrect header check)
> +	error: unable to unpack cafe... header
> +	error: inflate: data stream error (incorrect header check)
> +	error: unable to unpack cafe... header
> +	hint:   cafe... unknown type
> +	hint:   cafe... blob
> +	fatal: ambiguous argument '\''cafe...'\'': unknown revision or path not in the working tree.
> +	Use '\''--'\'' to separate paths from revisions, like this:
> +	'\''git <command> [<revision>...] -- [<file>...]'\''
> +	EOF
> +	test_cmp_failed_rev_parse blob.corrupt cafe
> +'
> +
>  if ! test_have_prereq SHA1
>  then
>  	skip_all='not using SHA-1 for objects'
> -- 
> 2.34.1.838.g779e9098efb
> 
