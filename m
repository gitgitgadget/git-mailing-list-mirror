Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2780520196
	for <e@80x24.org>; Thu, 14 Jul 2016 16:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbcGNQst (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 12:48:49 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:34887 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314AbcGNQss (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 12:48:48 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3rr1qf2kgQz5tlC;
	Thu, 14 Jul 2016 18:48:46 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 9CC7E52A1;
	Thu, 14 Jul 2016 18:48:45 +0200 (CEST)
Subject: Re: [PATCH v4 3/5] archive-tar: write extended headers for file sizes
 >= 8GB
To:	Jeff King <peff@peff.net>
References: <20160630090614.GA16725@sigill.intra.peff.net>
 <20160630090916.GC17463@sigill.intra.peff.net>
Cc:	git@vger.kernel.org, =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>
From:	Johannes Sixt <j6t@kdbg.org>
Message-ID: <ac016bb4-9f69-7e03-bc99-7a5bbc1a1a33@kdbg.org>
Date:	Thu, 14 Jul 2016 18:48:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2
MIME-Version: 1.0
In-Reply-To: <20160630090916.GC17463@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 30.06.2016 um 11:09 schrieb Jeff King:
> +/*
> + * This is the max value that a ustar size header can specify, as it is fixed
> + * at 11 octal digits. POSIX specifies that we switch to extended headers at
> + * this size.
> + */
> +#define USTAR_MAX_SIZE 077777777777UL

This is too large by one bit for our 32-bit unsigned long on Windows:

archive-tar.c: In function 'write_tar_entry':
archive-tar.c:295: warning: integer constant is too large for 'unsigned 
long' type
archive-tar.c: In function 'write_global_extended_header':
archive-tar.c:332: warning: integer constant is too large for 'unsigned 
long' type
archive-tar.c:335: warning: integer constant is too large for 'unsigned 
long' type
archive-tar.c:335: warning: overflow in implicit constant conversion

-- Hannes

