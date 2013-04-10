From: Jeff King <peff@peff.net>
Subject: Re: segfault in git-remote-http
Date: Wed, 10 Apr 2013 14:51:15 -0400
Message-ID: <20130410185114.GA18084@sigill.intra.peff.net>
References: <20130407093812.cae0e19123f7b6d2061800aa@lavabit.com>
 <20130409084718.587e99aa7a935296867a84a1@lavabit.com>
 <20130409171623.GE21972@sigill.intra.peff.net>
 <20130409104134.a9a42b74ec33b3147cd45c81@lavabit.com>
 <20130409174735.GA23494@sigill.intra.peff.net>
 <20130409124044.908c160c718cc357a139354e@lavabit.com>
 <20130410043030.GD795@sigill.intra.peff.net>
 <20130410090850.bacd762ad52eb3643ca99927@lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 10 20:51:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ07D-0005aL-3p
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 20:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678Ab3DJSvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 14:51:22 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38988 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751057Ab3DJSvV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 14:51:21 -0400
Received: (qmail 5119 invoked by uid 107); 10 Apr 2013 18:53:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Apr 2013 14:53:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Apr 2013 14:51:15 -0400
Content-Disposition: inline
In-Reply-To: <20130410090850.bacd762ad52eb3643ca99927@lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220719>

On Wed, Apr 10, 2013 at 09:08:50AM -0700, rh wrote:

> > which should show both program names. Git invokes git-remote-* based
> > on the URL you fed it. So if you are seeing a segfault in
> > git-remote-http, presumably you fed it an http URL (which may still
> > execute SSL code if it redirects to an https URL).
> 
> Here's the command I ran (from initial post):
> git clone https://github.com/bitcoin/bitcoin.git
> 
> This returns no error on the command line and produced the segfault
> reported by the kernel. git clone returns immediately.

It does correctly report a failed exit code. The lack of message is
because git assumes that the helper will produce a useful message before
dying, but obviously it doesn't.  There's already a patch[1] to fix this,
but it hasn't been merged yet.

As for why dmesg reports git-remote-http, I'm not sure. If you "strace
-f" the command, you can see that git is running git-remote-https. Why
the kernel chooses to report "git-remote-http", I don't know; you'd have
to look into how the kernel makes that decision. But I doubt it is
related to the reason for the segfault in the first place.

-Peff
