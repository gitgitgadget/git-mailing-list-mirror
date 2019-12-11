Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1252C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 18:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778F421556
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 18:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vWjxoFHY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfLKS7L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 13:59:11 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41867 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfLKS7L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 13:59:11 -0500
Received: by mail-qt1-f193.google.com with SMTP id v2so7197317qtv.8
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 10:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J6fAeoAXvI527IOiCmnoEyy+b9DW6bkIHosKlyKBdRU=;
        b=vWjxoFHYpkbRgtTRefLHZTTlxj11Xs71Pn7wCGAkcpW5h/HL+hX00G7AsvKRy2IWmm
         ouSEnbm+fV7uJKpQ8a738N+H66pofVGZU6xtUHlHjwJDlOlYcfJOgzEGvrl77keBLqkD
         FKK4rU2eirWPR0xBF9QX0CjKsgGbkxytsWtygcgBftYyI8S9tI8o+k809SzzZfsqfX2B
         lRVH0QlAh/Tfi6thX+/8eZfGJNicyidn0mUkDx7GzlqXf6Ooh985/htsKcTqbXCu0BV1
         z/M649x7DMj3ZlJa440dk+Vo+/gwBMLrZYaKSvsGyx7qdNwWRJWYzK+x0GqZxNyQzl/L
         RKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J6fAeoAXvI527IOiCmnoEyy+b9DW6bkIHosKlyKBdRU=;
        b=XSCz1Iaq3UKKyAhPKPMOEgAxyymgbaRSvPYebix8IIJtItpwImLAnXcTjMQpodBNQ5
         eKgsVW9MuGRuX9kuo4BjIByqF95llSNzT62rd1982LHzblFDmIFs93dYiRhDpjcFMFaU
         TCqEdxYs6wHI9HKxJ8jMy5i5E/sjnweIHkb2j6vctW+P5bH3vu8ll+sq+wHN7xpAgG71
         x6aEb/lMT5MS8iLJP4zoowV7tAVcfvHk2J4ao1kKalSG/ob06iXG5QP+phz1u74emkXA
         DDqx2dCGOGCg6HagJTYT6RezFOjMlfu6hMUdGqbj/ZMEo4b7cMOJtaxqa1gQ4MkdqrMj
         evSQ==
X-Gm-Message-State: APjAAAWlU+zDHjMnXI9Dg9GJEkjoCZAPl1kAZdtWTTCZhWDM2QTpDhHO
        JqDrulwpUSQViRyr2aC53oQ=
X-Google-Smtp-Source: APXvYqyMNWrjPwieIjJNKqCYM/LzkJBsuKX2aA70cUb9AqAgfvseETnjnd2MXmuaDofXSA3sTInXnQ==
X-Received: by 2002:ac8:7499:: with SMTP id v25mr4237234qtq.284.1576090750019;
        Wed, 11 Dec 2019 10:59:10 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:3126:c1d8:6135:a84d? ([2001:4898:a800:1010:e25b:c1d8:6135:a84d])
        by smtp.gmail.com with ESMTPSA id d9sm1180344qth.34.2019.12.11.10.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 10:59:09 -0800 (PST)
Subject: Re: [PATCH] t7004: don't create unused file
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <98eca6e4-f3d5-8bb2-efde-0160b3d5e507@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ad15a938-d47c-f996-b884-9e52e45243f1@gmail.com>
Date:   Wed, 11 Dec 2019 13:59:06 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <98eca6e4-f3d5-8bb2-efde-0160b3d5e507@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/11/2019 1:46 PM, René Scharfe wrote:
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 4a09bea1d6..6db92bd3ba 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -517,7 +517,6 @@ test_expect_success \
>  test_expect_success \
>  	'trying to create tags giving both -m or -F options should fail' '
>  	echo "message file 1" >msgfile1 &&
> -	echo "message file 2" >msgfile2 &&

Obviously correct.

-Stolee

