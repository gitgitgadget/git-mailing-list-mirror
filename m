Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B6651F42D
	for <e@80x24.org>; Sun, 13 May 2018 07:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751364AbeEMHeH (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 03:34:07 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:19656 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751022AbeEMHeG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 03:34:06 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 40kFvJ31sHz5tlP;
        Sun, 13 May 2018 09:34:04 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 56D391CAC;
        Sun, 13 May 2018 09:34:03 +0200 (CEST)
Subject: Re: [PATCH v2 17/28] t4014: abstract away SHA-1-specific constants
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20180513022438.60003-1-sandals@crustytoothpaste.net>
 <20180513022438.60003-18-sandals@crustytoothpaste.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <7485f683-e57e-acdd-4502-02c3f4f0b394@kdbg.org>
Date:   Sun, 13 May 2018 09:34:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180513022438.60003-18-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.05.2018 um 04:24 schrieb brian m. carlson:
> Adjust the test so that it computes values for blobs instead of using
> hard-coded hashes.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>   t/t4014-format-patch.sh | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index dac3f349a3..42b3e11207 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -578,7 +578,9 @@ test_expect_success 'excessive subject' '
>   
>   	rm -rf patches/ &&
>   	git checkout side &&
> +	before=$(git rev-parse --short $(git hash-object file)) &&
>   	for i in 5 6 1 2 3 A 4 B C 7 8 9 10 D E F; do echo "$i"; done >>file &&
> +	after=$(git rev-parse --short $(git hash-object file)) &&

It would be better to avoid process expansion in command arguments, 
because the shell does not diagnose failures. This is preferable:

	before=$(git hash-object file) &&
	before=$(git rev-parse --short $before) &&

-- Hannes
