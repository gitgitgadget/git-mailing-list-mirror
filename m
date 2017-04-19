Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 799C71FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 22:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935421AbdDSWCN (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 18:02:13 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:49160 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935175AbdDSWCM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 18:02:12 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3w7bZT1fTWz5tlD;
        Thu, 20 Apr 2017 00:02:09 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id A728142CA;
        Thu, 20 Apr 2017 00:02:08 +0200 (CEST)
Subject: Re: [PATCH v3 05/12] refs: move submodule slash stripping code to
 get_submodule_ref_store
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20170419110145.5086-1-pclouds@gmail.com>
 <20170419110145.5086-6-pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <a74cf309-fb16-2f45-8189-d1d0c655dea4@kdbg.org>
Date:   Thu, 20 Apr 2017 00:02:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170419110145.5086-6-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.04.2017 um 13:01 schrieb Nguyễn Thái Ngọc Duy:
> @@ -1558,7 +1543,17 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
>  {
>  	struct strbuf submodule_sb = STRBUF_INIT;
>  	struct ref_store *refs;
> +	char *to_free = NULL;
>  	int ret;
> +	size_t len;
> +
> +	if (submodule) {
> +		len = strlen(submodule);
> +		while (len && submodule[len - 1] == '/')

What is the source of the value of 'submodule'? Is it an index entry? Or 
did it pass through parse_pathspec? In these cases it is correct to 
compare against literal '/'. Otherwise, is_dir_sep() is preferred.

> +			len--;
> +		if (!len)
> +			submodule = NULL;
> +	}
>
>  	if (!submodule || !*submodule) {
>  		/*

-- Hannes

