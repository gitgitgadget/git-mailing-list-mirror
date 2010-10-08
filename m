From: Jeff King <peff@peff.net>
Subject: Re: fatal: BUG: dashless options don't support arguments
Date: Fri, 8 Oct 2010 00:11:00 -0400
Message-ID: <20101008041100.GA3272@sigill.intra.peff.net>
References: <AANLkTi=xscHHPTBtTJ3uXPO9y9gpQTBF4AWTe47C9njU@mail.gmail.com>
 <AANLkTikqB-EvE6uxgBmutssJoiH2RiPjSxtjbo++Jj-X@mail.gmail.com>
 <20101008031818.GC992@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brian Zitzow <bzitzow@gmail.com>, git@vger.kernel.org,
	Christopher Cameron <christopher.cameron@live.com>,
	Henrik Tidefelt <tidefelt@isy.liu.se>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 08 06:11:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P44IO-0005JK-Kc
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 06:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094Ab0JHEKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 00:10:55 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:42541 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750776Ab0JHEKy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 00:10:54 -0400
Received: (qmail 23943 invoked by uid 111); 8 Oct 2010 04:10:53 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 08 Oct 2010 04:10:53 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Oct 2010 00:11:00 -0400
Content-Disposition: inline
In-Reply-To: <20101008031818.GC992@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158472>

On Thu, Oct 07, 2010 at 10:18:18PM -0500, Jonathan Nieder wrote:

> > Ki:$ git checkout master
> > fatal: BUG: dashless options don't support arguments
> 
> Strange indeed.  Here's what I would suggest:
> 
> 1. For debugging output:
> 
>  $ echo 'prefix=/usr/local' >>config.mak; # or whatever prefix you use
>  $ git describe
>  $ gcc --version
>  $ wget 'http://download.gmane.org/gmane.comp.version-control.git/128067/128068'
>  $ git am -3 128068
>  $ make
>  $ bin-wrappers/git checkout m

Yeah, I would be curious to see the output of that. Interesting, too,
that it seems to happen with multiple commands (it looked like it
happened with "git push foo" in the pastebin from the irc log).

> 2. To track down the issue, if you like to read assembler:
> 
>  $ make builtin/checkout.s
>  $ vi checkout.s

Ugh. I think a better course of action is to find out which option is
being munged (from step 1 above), and then try running it under gdb with
a watch set on that option struct. Assuming it's easily reproducible of
course.

-Peff
