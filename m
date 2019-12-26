Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA368C2D0DA
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 14:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885FB206A4
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 14:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhCJcNov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfLZOuM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 09:50:12 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:42883 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfLZOuM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 09:50:12 -0500
Received: by mail-qv1-f68.google.com with SMTP id dc14so9108418qvb.9
        for <git@vger.kernel.org>; Thu, 26 Dec 2019 06:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UCrn3shpnqwe0WV+hufu0Li7OySoVsS4/71GI5pVHqc=;
        b=fhCJcNovXoA5aut5yDvqSLExmBD/RBhQ+ySKnxrCC2G52DJ3ySAaqTKjzVjn/UHgBb
         eEezQdQoM54blYgITC+MVpck5a/oISI3eOfAI0Y+nW5mMU5qQKHid+sIVU2QECqaHzhh
         RrVR9XGxoZpysPwoyg9oGbQ5SrLjl3bD6t8c92zUhLQVQicjM9gGZfBJJ7eK+7MKSvXW
         gKC/3TMQ/BXJwPY+17GveGydGVePZ/tjMwgxQ4exB65XikdleJarQU8AIDu12RNS2FhP
         m6BJ6kxixRl7PiCFcK32C2j5Q6pOVoxF+7f+xx/+CEIYUQij29qxEIOYZGZjxKBuMlOd
         lCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UCrn3shpnqwe0WV+hufu0Li7OySoVsS4/71GI5pVHqc=;
        b=MVEnHQewSzqooBlA/DglE77S2sleIeMAWOHWJw96KFN/G13Y1MiaKtgbuv6JCrJBf/
         uh+WfJhtyoRGrnx1Sddqmqe9uFp1DV86lBaCIbKnziAk8QBtRnEXcV019rSCOhddpXCu
         pOCG9ij3R8Y8703ApA2zEajT+o4oY/OUNIMM4jvjtR++xQDB9uc5p0i4pnj74o1eyk2V
         KRwFVT734D3+NtqoqhbhJ+z3Y7vQoQq/arS6P6bb5NtZo+HnaabCbnDba4morKdzAfll
         79e+cGW/kCP08BKpTo6PhIoc49lVdfKTEiEYUDsyJ9thGHO58ajcauDvv9U/hix4yhJl
         MxEg==
X-Gm-Message-State: APjAAAXRK9gu3BKro0abMdHPyAHrh31ixQiC0ghGrrM7VnOroO0rZ8fa
        OcA2VgNC4liU8rhMZI8qS1g=
X-Google-Smtp-Source: APXvYqzVZMAojVd+58i2sSYyn5aPKJjj4MRFZi1VRhAbEFoMN+MK3ga7X2RPctiuyRNiYlxbc80GxQ==
X-Received: by 2002:ad4:580b:: with SMTP id dd11mr35961278qvb.242.1577371810925;
        Thu, 26 Dec 2019 06:50:10 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:d596:b1c5:69e0:b2e5? ([2001:4898:a800:1010:86cc:b1c5:69e0:b2e5])
        by smtp.gmail.com with ESMTPSA id x27sm8688304qkx.81.2019.12.26.06.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2019 06:50:10 -0800 (PST)
Subject: Re: [PATCH 10/20] t5319: make test work with SHA-256
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
 <20191221194936.1346664-11-sandals@crustytoothpaste.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <54d80d36-f9b9-1c92-faf0-41bbcbe0a133@gmail.com>
Date:   Thu, 26 Dec 2019 09:50:09 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20191221194936.1346664-11-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/21/2019 2:49 PM, brian m. carlson wrote:
> This test corrupts various locations in a multi-pack index to test
> various error responses.  However, these offsets differ between SHA-1
> indexes and SHA-256 indexes due to differences in object length.  Use
> test_oid to look up the correct offsets based on the algorithm.
> ---
>  t/t5319-multi-pack-index.sh | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> index 464bb68e89..43a7a66c9d 100755
> --- a/t/t5319-multi-pack-index.sh
> +++ b/t/t5319-multi-pack-index.sh
> @@ -28,6 +28,20 @@ midx_read_expect () {
>  	test_cmp expect actual
>  }
>  
> +test_expect_success 'setup' '
> +	test_oid_init &&
> +	test_oid_cache <<-EOF
> +	idxoff sha1:2999
> +	idxoff sha256:3739
> +
> +	packnameoff sha1:652
> +	packnameoff sha256:940
> +
> +	fanoutoff sha1:1
> +	fanoutoff sha256:3
> +	EOF
> +'
> +
>  test_expect_success 'write midx with no packs' '
>  	test_when_finished rm -f pack/multi-pack-index &&
>  	git multi-pack-index --object-dir=. write &&
> @@ -225,7 +239,7 @@ test_expect_success 'verify bad signature' '
>  		"multi-pack-index signature"
>  '
>  
> -HASH_LEN=20
> +HASH_LEN=$(test_oid rawsz)

I'm glad this was an easy update.

> +MIDX_OFFSET_OID_FANOUT=$(($MIDX_OFFSET_PACKNAMES + $(test_oid packnameoff)))
> +MIDX_BYTE_OID_FANOUT_ORDER=$((MIDX_OFFSET_OID_FANOUT + 250 * $MIDX_OID_FANOUT_WIDTH + $(test_oid fanoutoff)))

I see why these are necessary: we need to find an exact position that
causes an order check to fail. In that sense, the offsets need to match
the early bytes of a packfile name or an OID fanout value.

> @@ -387,7 +401,7 @@ test_expect_success 'force some 64-bit offsets with pack-objects' '
>  	pack64=$(git pack-objects --index-version=2,0x40 objects64/pack/test-64 <obj-list) &&
>  	idx64=objects64/pack/test-64-$pack64.idx &&
>  	chmod u+w $idx64 &&
> -	corrupt_data $idx64 2999 "\02" &&
> +	corrupt_data $idx64 $(test_oid idxoff) "\02" &&

Sorry that this was not a better-calculated value, but
your approach works well here.

Thanks,
-Stolee
 

