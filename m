Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DF971F600
	for <e@80x24.org>; Thu, 20 Jul 2017 20:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933966AbdGTUNB (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 16:13:01 -0400
Received: from avasout05.plus.net ([84.93.230.250]:41611 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753659AbdGTUNB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 16:13:01 -0400
X-Greylist: delayed 455 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Jul 2017 16:13:00 EDT
Received: from hashpling.plus.com ([212.159.69.125])
        by avasout05 with smtp
        id n85P1v0052iA9hg0185Qjr; Thu, 20 Jul 2017 21:05:24 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Iav3YSia c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17
 a=kj9zAlcOel0A:10 a=G3gG6ho9WtcA:10 a=pGLkceISAAAA:8 a=cAOYPgfzEdERnQSzBxoA:9
 a=CjuIK1q_8ugA:10 a=6kGIvZw6iX1k4Y-7sg4_:22
Received: from charles by hashpling.plus.com with local (Exim 4.84_2)
        (envelope-from <charles@hashpling.org>)
        id 1dYHhL-0003d7-Cg; Thu, 20 Jul 2017 21:05:23 +0100
Date:   Thu, 20 Jul 2017 21:05:23 +0100
From:   Charles Bailey <charles@hashpling.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Victor Toni <victor.toni@gmail.com>, git@vger.kernel.org,
        Charles Bailey <cbailey32@bloomberg.net>,
        Jeff King <peff@peff.net>
Subject: Re: Handling of paths
Message-ID: <20170720200523.GA13792@hashpling.org>
References: <CAG0OSgdEE3g-ugEJU4EZqfbxZ=3h2WPdLC4W4mG7b6UeTaXQ-Q@mail.gmail.com>
 <xmqq7ez2lwsv.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7ez2lwsv.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 20, 2017 at 12:42:40PM -0700, Junio C Hamano wrote:
> Victor Toni <victor.toni@gmail.com> writes:
> 
> > What's unexpected is that paths used for sslKey or sslCert are treated
> > differently insofar as they are expected to be absolute.
> > Relative paths (whether with or without "~") don't work.
> 
> It appears that only two of these among four were made aware of the
> "~[username]/" prefix in bf9acba2 ("http: treat config options
> sslCAPath and sslCAInfo as paths", 2015-11-23), but "sslkey" and
> "sslcert" were still left as plain vanilla strings.  I do not know
> if that was an elaborate omission, or a mere oversight, as it seems
> that it happened while I was away, so...

It was more of an oversight than a deliberate omission, but more
accurately I didn't actively consider whether the other http.ssl*
variables were pathname-like or not.

At the time I was trying to make a config which needed to set
http.sslCAPath and/or http.sslCAInfo more portable between users and
these were "obviously" pathname-like to me. Now that I read
the help for http.sslCert and http.sslKey, I see no reason that they
shouldn't also use git_config_pathname. If I'd been more thorough I
would have proposed this at the time.

Charles.
