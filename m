Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 075F11F453
	for <e@80x24.org>; Fri, 15 Feb 2019 17:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfBORNz (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 12:13:55 -0500
Received: from elephants.elehost.com ([216.66.27.132]:28945 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfBORNz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 12:13:55 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1FHDmvt001567
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 12:13:48 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Max Kirillov'" <max@max630.net>, <git@vger.kernel.org>
Cc:     "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "'Junio C Hamano'" <gitster@pobox.com>
References: <20190209185930.5256-4-randall.s.becker@rogers.com> <20190215164237.12250-1-max@max630.net>
In-Reply-To: <20190215164237.12250-1-max@max630.net>
Subject: RE: [PATCH] t5562: do not depend on /dev/zero
Date:   Fri, 15 Feb 2019 12:13:42 -0500
Message-ID: <001601d4c551$d0f24c30$72d6e490$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIP382J2qWF5an7SfxTULbAVk2HKqVq4oog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 15, 2019 11:43, Max Kirillov wrote:
> It was reported [1] that NonStop platform does not have /dev/zero.
> 
> The test uses /dev/zero as a dummy input. Passing case (http-backed failed
> because of too big input size) should not be reading anything from it. If
http-
> backend would erroneously try to read any data returning EOF probably
> would be even safer than providing some meaningless data.
> 
> Replace /dev/zero with /dev/null to avoid issues with platforms which do
not
> have /dev/zero.
> 
> [1] https://public-inbox.org/git/20190209185930.5256-4-
> randall.s.becker@rogers.com/
> 
> Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
> Signed-off-by: Max Kirillov <max@max630.net>
> ---
> By the way, I don't think this requires such sofisticated fix. In the
success
> case the input would not be read at all.
> You could replace it with /dev/null, the in failure (not immediate fail)
git
> would fail due to truncated input or something.
> 
> Also, as you experience hang issue [2] in earlier tests, this one should
not
> have contributed to it.
> 
> [2] https://public-
> inbox.org/git/001901d4c22b$194bfe60$4be3fb20$@nexbridge.com/
>  t/t5562-http-backend-content-length.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t5562-http-backend-content-length.sh
b/t/t5562-http-backend-
> content-length.sh
> index 90d890d02f..436c261c86 100755
> --- a/t/t5562-http-backend-content-length.sh
> +++ b/t/t5562-http-backend-content-length.sh
> @@ -150,7 +150,7 @@ test_expect_success 'CONTENT_LENGTH overflow
> ssite_t' '
>  		GIT_HTTP_EXPORT_ALL=TRUE \
>  		REQUEST_METHOD=POST \
>  		CONTENT_LENGTH="$NOT_FIT_IN_SSIZE" \
> -		git http-backend </dev/zero >/dev/null 2>err &&
> +		git http-backend </dev/null >/dev/null 2>err &&
>  	grep "fatal:.*CONTENT_LENGTH" err

FTR, this particular subtest is not the one that is hanging. This subtest
passes on NonStop with any and all (now) 4 solutions that have been floating
around.

Cheers,
Randall

