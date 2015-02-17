From: Jeff King <peff@peff.net>
Subject: Re: Lift --stdout restriction for using reachability bitmap in
 pack-objects?
Date: Tue, 17 Feb 2015 05:42:29 -0500
Message-ID: <20150217104228.GA26301@peff.net>
References: <CACsJy8AC5ZcsB2_qS4k-+6fJt2_e7m=o8C9UAEcywh=P_4HXAw@mail.gmail.com>
 <20150217101344.GA5343@peff.net>
 <CACsJy8C=MC2xVbkXE-RBcLtcn0yEX4iqBLjgOw+M0iK5n-Kyhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent Marti <tanoku@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 11:42:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNfbv-0004Xn-UO
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 11:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755056AbbBQKmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 05:42:32 -0500
Received: from cloud.peff.net ([50.56.180.127]:49822 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754934AbbBQKmb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 05:42:31 -0500
Received: (qmail 17799 invoked by uid 102); 17 Feb 2015 10:42:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Feb 2015 04:42:31 -0600
Received: (qmail 6079 invoked by uid 107); 17 Feb 2015 10:42:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Feb 2015 05:42:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Feb 2015 05:42:29 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8C=MC2xVbkXE-RBcLtcn0yEX4iqBLjgOw+M0iK5n-Kyhw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263943>

On Tue, Feb 17, 2015 at 05:36:30PM +0700, Duy Nguyen wrote:

> On Tue, Feb 17, 2015 at 5:13 PM, Jeff King <peff@peff.net> wrote:
> > If the only reason is for gdb, then perhaps:
> >
> >   set args pack-objects --stdout </dev/null >/dev/null
> >
> > in gdb would help?
> 
> Right. I used "gdb --args command >/dev/null" instead. Stupid
> question. Sorry for the noise.

I've made the same mistake myself many times. I really wish gdb would
interact over /dev/tty by default. The perl debugger does this, and I
find it quite handy. But I've never managed to make gdb do it. Maybe
there is an option I've missed[1].

The downside of what approach, though, is that you cannot restart the
program reliably from within the debugger (it cannot know how to
re-set-up the descriptors). So you have to quit and restart, which loses
any breakpoints, etc.

-Peff

[1] Having written that, I'm not sure I ever tried a script that does
    something like:

      program=$1; shift
      exec 3<&0
      exec 4>&1
      gdb </dev/tty >/dev/tty -ex "set args <&3 >&4 gdb $*" "$program"

    I think that would work, but it does screw up quoting/whitespace in
    your arguments.
