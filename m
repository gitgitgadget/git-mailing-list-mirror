Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B15FC1FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 21:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752401AbcLIVcw (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 16:32:52 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:32220 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751540AbcLIVcv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 16:32:51 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3tb575468kz5tlQ;
        Fri,  9 Dec 2016 22:32:49 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id AA5981D19;
        Fri,  9 Dec 2016 22:32:48 +0100 (CET)
Subject: Re: [BUG] Colon in remote urls
To:     Jeff King <peff@peff.net>
References: <20161209140215.qlam6bexm5irpro2@ikki.ethgen.ch>
 <20161209152219.ehfk475vdg4levop@sigill.intra.peff.net>
Cc:     Klaus Ethgen <Klaus@Ethgen.ch>, git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <88bed7c9-4d5d-45d5-5d13-6a8ae834e602@kdbg.org>
Date:   Fri, 9 Dec 2016 22:32:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161209152219.ehfk475vdg4levop@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.12.2016 um 16:22 schrieb Jeff King:
> +const char *parse_alt_odb_entry(const char *string, int sep,
> +				struct strbuf *out)
> +{
> +	const char *p;
> +	int literal = 0;
> +
> +	strbuf_reset(out);
> +
> +	for (p = string; *p; p++) {
> +		if (literal) {
> +			strbuf_addch(out, *p);
> +			literal = 0;
> +		} else {
> +			if (*p == '\\')
> +				literal = 1;

There are too many systems out there that use a backslash in path names. 
I don't think it is wise to use it also as the quoting character.

> +			else if (*p == sep)
> +				return p + 1;
> +			else
> +				strbuf_addch(out, *p);
> +		}
> +	}
> +	return p;
> +}

-- Hannes

