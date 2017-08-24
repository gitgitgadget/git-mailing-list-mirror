Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A28F820285
	for <e@80x24.org>; Thu, 24 Aug 2017 20:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753457AbdHXU30 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 16:29:26 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:56653 "EHLO bsmtp8.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751168AbdHXU3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 16:29:25 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp8.bon.at (Postfix) with ESMTPSA id 3xdbVq4LMWz5tlD;
        Thu, 24 Aug 2017 22:29:23 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 1158E2079;
        Thu, 24 Aug 2017 22:29:23 +0200 (CEST)
Subject: Re: [Patch size_t V3 11/19] Use size_t for config parsing
To:     Martin Koegler <martin.koegler@chello.at>
References: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
 <1502914591-26215-12-git-send-email-martin@mail.zuhause>
Cc:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <0a045197-199a-b1bc-f0bb-9ecf96ad2b50@kdbg.org>
Date:   Thu, 24 Aug 2017 22:29:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1502914591-26215-12-git-send-email-martin@mail.zuhause>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.08.2017 um 22:16 schrieb Martin Koegler:
> +int git_parse_size_t(const char *value, size_t *ret)
> +{
> +	uintmax_t tmp;
> +	if (!git_parse_unsigned(value, &tmp, maximum_signed_value_of_type(size_t)))
> +		return 0;
> +	*ret = tmp;
> +	return 1;
> +}
> +

I think this requires the following on top:

diff --git a/config.c b/config.c
index 81d46602f9..b3075aa1c4 100644
--- a/config.c
+++ b/config.c
@@ -866,7 +866,7 @@ static int git_parse_ssize_t(const char *value, ssize_t *ret)
 int git_parse_size_t(const char *value, size_t *ret)
 {
 	uintmax_t tmp;
-	if (!git_parse_unsigned(value, &tmp, maximum_signed_value_of_type(size_t)))
+	if (!git_parse_unsigned(value, &tmp, maximum_unsigned_value_of_type(size_t)))
 		return 0;
 	*ret = tmp;
 	return 1;
