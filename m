Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 5614 invoked by uid 107); 10 Apr 2013 19:16:52 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.84) with ESMTP; Wed, 10 Apr 2013 15:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761639Ab3DJTOp (ORCPT <rfc822;peff@peff.net>);
	Wed, 10 Apr 2013 15:14:45 -0400
Received: from plane.gmane.org ([80.91.229.3]:38297 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761587Ab3DJTOn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 15:14:43 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UQ0Th-0001Xv-4O
	for git@vger.kernel.org; Wed, 10 Apr 2013 21:14:41 +0200
Received: from ip68-227-87-145.sb.sd.cox.net ([68.227.87.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 21:14:41 +0200
Received: from richard_hubbe11 by ip68-227-87-145.sb.sd.cox.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 21:14:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: git@vger.kernel.org
To:	git@vger.kernel.org
From:	rh <richard_hubbe11@lavabit.com>
Subject: Re: segfault in git-remote-http
Date:	Wed, 10 Apr 2013 12:16:25 -0700
Organization: " "
Message-ID: <20130410121625.7424bede4b3706c27e1388c1@lavabit.com>
References: <20130407093812.cae0e19123f7b6d2061800aa@lavabit.com>
	<20130409084718.587e99aa7a935296867a84a1@lavabit.com>
	<20130409171623.GE21972@sigill.intra.peff.net>
	<20130409104134.a9a42b74ec33b3147cd45c81@lavabit.com>
	<20130409174735.GA23494@sigill.intra.peff.net>
	<20130409124044.908c160c718cc357a139354e@lavabit.com>
	<20130410043030.GD795@sigill.intra.peff.net>
	<20130410090850.bacd762ad52eb3643ca99927@lavabit.com>
	<20130410185114.GA18084@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ip68-227-87-145.sb.sd.cox.net
User-Agent: dsodnetnin
X-Mailer: EZnn0.37p
X-Newsreader: EZnn0.37p
X-Gmane-NNTP-Posting-Host: EZnn0.37p
Original-Received: from slem by 1.1 with local
X-No-Archive: yes
Archive: no
X-Archive: encrypt
X-Operating-System: Barebones_6.1
X-Gmane-NNTP-Posting-Host: 192.168.1.1
X-NNTP-Posting-Host: 192.168.1.1
Mail-Copies-To:	never
X-Archive: expiry=17
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org
X-Status: A

On Wed, 10 Apr 2013 14:51:15 -0400
Jeff King <peff@peff.net> wrote:

> On Wed, Apr 10, 2013 at 09:08:50AM -0700, rh wrote:
> 
> > > which should show both program names. Git invokes git-remote-*
> > > based on the URL you fed it. So if you are seeing a segfault in
> > > git-remote-http, presumably you fed it an http URL (which may
> > > still execute SSL code if it redirects to an https URL).
> > 
> > Here's the command I ran (from initial post):
> > git clone https://github.com/bitcoin/bitcoin.git
> > 
> > This returns no error on the command line and produced the segfault
> > reported by the kernel. git clone returns immediately.
> 
> It does correctly report a failed exit code. The lack of message is
> because git assumes that the helper will produce a useful message
> before dying, but obviously it doesn't.  There's already a patch[1]
> to fix this, but it hasn't been merged yet.

Oh yeah, I didn't check $? but I got sidetracked seeing the segfault.

> 
> As for why dmesg reports git-remote-http, I'm not sure. If you "strace
> -f" the command, you can see that git is running git-remote-https. Why
> the kernel chooses to report "git-remote-http", I don't know; you'd
> have to look into how the kernel makes that decision. But I doubt it
> is related to the reason for the segfault in the first place.

This could be that it's using the first match or entry in the hardlink list.
Which seems like a bad idea ... but that's a wild guess.

I agree it seems unlikely that it's related to the segfault.

