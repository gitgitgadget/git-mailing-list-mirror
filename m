Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FC7C2018B
	for <e@80x24.org>; Mon, 18 Jul 2016 23:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386AbcGRXln (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 19:41:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:46696 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752271AbcGRXlk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 19:41:40 -0400
Received: (qmail 6878 invoked by uid 102); 18 Jul 2016 23:41:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jul 2016 19:41:40 -0400
Received: (qmail 8020 invoked by uid 107); 18 Jul 2016 23:42:02 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jul 2016 19:42:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jul 2016 17:41:21 -0600
Date:	Mon, 18 Jul 2016 17:41:21 -0600
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Eric Wong <e@80x24.org>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] test-lib: stricter unzip(1) check
Message-ID: <20160718234121.GA26152@sigill.intra.peff.net>
References: <20160718064431.GA10819@starla>
 <20160718130405.GA19751@sigill.intra.peff.net>
 <xmqqshv6ivfk.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqshv6ivfk.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 18, 2016 at 12:43:27PM -0700, Junio C Hamano wrote:

> -- >8 --
> test: check "unzip" and "unzip -a"
> 
> Different platforms have implementations "unzip" that behave
> differently.  Most of the tests we use GIT_UNZIP we only care about
> the command to be able to extract from *.zip archive, but one test
> in t5003 wants it to also be able to grok the "-a" option.
> 
> Prepare a sample zip file that has a single text file in it, and try
> extracting its contents to see GIT_UNZIP is usable. when setting
> UNZIP prerequisite.  Similarly, set UNZIP_AUTOTEXT prerequisite by
> running GIT_UNZIP with the "-a" option.

I like the direction here, modulo the problems with "-a" that Eric
pointed out. Maybe "zip -l" would be a better approach.

One nit:

> +test_lazy_prereq UNZIP_AUTOTEXT '
> +	(
> +		mkdir unzip-autotext &&
> +		cd unzip-autotext
> +		"$GIT_UNZIP" -a "$TEST_DIRECTORY"/t5003/infozip-text.zip &&
> +		test -f text
> +	)
> +'

I don't think we need the extra directory or the subshell here.
test_lazy_prereq takes care of that for us.

> diff --git a/t/t5003/infozip-text.zip b/t/t5003/infozip-text.zip
> new file mode 100644
> index 0000000..a019acb
> Binary files /dev/null and b/t/t5003/infozip-text.zip differ

Couldn't apply this locally without --binary, of course. :)

-Peff
