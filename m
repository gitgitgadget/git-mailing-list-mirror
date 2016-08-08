Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FF222018E
	for <e@80x24.org>; Mon,  8 Aug 2016 15:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbcHHP33 (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 11:29:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:51198 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752020AbcHHP33 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 11:29:29 -0400
Received: (qmail 11632 invoked by uid 109); 8 Aug 2016 15:29:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Aug 2016 15:29:28 +0000
Received: (qmail 5714 invoked by uid 111); 8 Aug 2016 15:29:27 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Aug 2016 11:29:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Aug 2016 11:29:26 -0400
Date:	Mon, 8 Aug 2016 11:29:26 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
Subject: Re: t0027 racy?
Message-ID: <20160808152926.mciovipy5qlnqegs@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1608081556280.5786@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1608081556280.5786@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 08, 2016 at 05:05:07PM +0200, Johannes Schindelin wrote:

> I remember that you did a ton of work on t0027. Now I see problems, and
> not only that the entire script now takes a whopping 4 minutes 20 seconds
> to run on my high-end Windows machine.
> 
> It appears that t0027 fails randomly for me, in seemingly random places.
> Sometimes all 1388 cases pass. Sometimes "29 - commit NNO files crlf=true
> attr=auto LF" fails. Sometimes it is "24 - commit NNO files crlf=false
> attr=auto LF". Sometimes it is "114 - commit NNO files crlf=false
> attr=auto LF", and sometimes "111 - commit NNO files attr=auto aeol=lf
> crlf=false CRLF_mix_LF".
> 
> When I run it with -i -v -x --tee, it passes every single time (taking
> over 5 minutes, just to make things worse)...
> 
> Any idea about any possible races?

Try:

  https://github.com/peff/git/blob/meta/stress

which you can run as "sh /path/to/stress t0027" in the top-level of your
git repository. I got failure within about 30 seconds on t0027 (though 5
minutes? Yeesh. It runs in 9s on my laptop. I weep for you).

The verbose output is not very exciting, though:

	expecting success: 
	                check_warning "$lfwarn" ${pfx}_LF.err

	--- NNO_attr_auto_aeol_crlf_false_LF.err.expect 2016-08-08 15:26:37.061701392 +0000
	+++ NNO_attr_auto_aeol_crlf_false_LF.err.actual 2016-08-08 15:26:37.061701392 +0000
	@@ -1 +0,0 @@
	-warning: LF will be replaced by CRLF
	not ok 114 - commit NNO files crlf=false attr=auto LF

-Peff
