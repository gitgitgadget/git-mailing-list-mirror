Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24EC61F453
	for <e@80x24.org>; Fri,  8 Feb 2019 22:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfBHWAa (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 17:00:30 -0500
Received: from elephants.elehost.com ([216.66.27.132]:28359 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfBHWAa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 17:00:30 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x18M0Qix096559
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 8 Feb 2019 17:00:26 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <randall.s.becker@rogers.com>, <git@vger.kernel.org>
References: <20190208215926.23600-1-randall.s.becker@rogers.com>
In-Reply-To: <20190208215926.23600-1-randall.s.becker@rogers.com>
Subject: RE: [Fix v1] t5562: remove dependency on /dev/zero
Date:   Fri, 8 Feb 2019 17:00:19 -0500
Message-ID: <004d01d4bff9$b1c49780$154dc680$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHxa0g45J7mRptxWx0HXUuremljBqWdHLpQ
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please disregard this.. I left garbage inside.

> -----Original Message-----
> From: git-owner@vger.kernel.org <git-owner@vger.kernel.org> On Behalf
> Of randall.s.becker@rogers.com
> Sent: February 8, 2019 16:59
> To: git@vger.kernel.org
> Cc: Randall S. Becker <rsbecker@nexbridge.com>
> Subject: [Fix v1] t5562: remove dependency on /dev/zero
> 
> From: "Randall S. Becker" <rsbecker@nexbridge.com>
> 
> Replaced subtest 15 (CONTENT_LENGTH overflow ssite_t) use of /dev/zero
> with yes and a translation of its result to a stream of NULL. This is a
more
> portable solution.
> 
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
>  t/t5562-http-backend-content-length.sh | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t5562-http-backend-content-length.sh
b/t/t5562-http-backend-
> content-length.sh
> index 90d890d02..63f82cca2 100755
> --- a/t/t5562-http-backend-content-length.sh
> +++ b/t/t5562-http-backend-content-length.sh
> @@ -143,14 +143,16 @@ test_expect_success GZIP 'push gzipped empty' '
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
> +	echo "Err is" &&
> +	cat err &&
>  	grep "fatal:.*CONTENT_LENGTH" err
>  '
> 
> --
> 2.12.3

