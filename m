Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C81EA1F453
	for <e@80x24.org>; Sat,  9 Feb 2019 08:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfBIIqO (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 03:46:14 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:3534 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfBIIqO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Feb 2019 03:46:14 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 43xQd02lHNz5tlB;
        Sat,  9 Feb 2019 09:46:12 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 1CB551EA9;
        Sat,  9 Feb 2019 09:46:12 +0100 (CET)
Subject: Re: [Fix v2] t5562: remove dependency on /dev/zero
To:     randall.s.becker@rogers.com
Cc:     git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
References: <20190208220751.9936-1-randall.s.becker@rogers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <f01141d4-e77e-24ba-2354-e7aebc2c3c57@kdbg.org>
Date:   Sat, 9 Feb 2019 09:46:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190208220751.9936-1-randall.s.becker@rogers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.02.19 um 23:07 schrieb randall.s.becker@rogers.com:
> From: "Randall S. Becker" <rsbecker@nexbridge.com>
> 
> Replaced subtest 15 (CONTENT_LENGTH overflow ssite_t) use of /dev/zero
> with yes and a translation of its result to a stream of NULL. This is
> a more portable solution.
> 
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
>  t/t5562-http-backend-content-length.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
> index 90d890d02..b8d1913e5 100755
> --- a/t/t5562-http-backend-content-length.sh
> +++ b/t/t5562-http-backend-content-length.sh
> @@ -143,14 +143,14 @@ test_expect_success GZIP 'push gzipped empty' '
>  
>  test_expect_success 'CONTENT_LENGTH overflow ssite_t' '
>  	NOT_FIT_IN_SSIZE=$(ssize_b100dots) &&
> -	env \
> +	yes | tr "y" "\\0" | env \
>  		CONTENT_TYPE=application/x-git-upload-pack-request \
>  		QUERY_STRING=/repo.git/git-upload-pack \
>  		PATH_TRANSLATED="$PWD"/.git/git-upload-pack \
>  		GIT_HTTP_EXPORT_ALL=TRUE \
>  		REQUEST_METHOD=POST \
>  		CONTENT_LENGTH="$NOT_FIT_IN_SSIZE" \
> -		git http-backend </dev/zero >/dev/null 2>err &&
> +		git http-backend >/dev/null 2>err &&
>  	grep "fatal:.*CONTENT_LENGTH" err
>  '

How many bytes are needed here? yes() in test-lib.sh generates only 99
'y', if I am not mistaken.

-- Hannes
