From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] describe/name-rev: tell name-rev to peel the
 incoming object to commit first
Date: Tue, 9 Jul 2013 01:12:52 -0400
Message-ID: <20130709051252.GG27903@sigill.intra.peff.net>
References: <1373236424-25617-1-git-send-email-gitster@pobox.com>
 <1373236424-25617-5-git-send-email-gitster@pobox.com>
 <CALkWK0nMmQO=cML-s9rgku+_4fZnYwtGC+daYPOBPn6-RFZj=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 07:13:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwQEV-00046I-LX
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 07:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499Ab3GIFM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 01:12:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:35591 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751962Ab3GIFMz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 01:12:55 -0400
Received: (qmail 3776 invoked by uid 102); 9 Jul 2013 05:14:10 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 09 Jul 2013 00:14:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Jul 2013 01:12:52 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0nMmQO=cML-s9rgku+_4fZnYwtGC+daYPOBPn6-RFZj=g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229910>

On Mon, Jul 08, 2013 at 06:38:32PM +0530, Ramkumar Ramachandra wrote:

> Junio C Hamano wrote:
> > With this on top of the other patches in this series, you would get:
> >
> >     $ git describe --contains $(git rev-parse v1.8.3 v1.8.3^0)
> >     v1.8.3
> >     v1.8.3
> >
> > while you can still differentiate tags and the commits they point at
> > with:
> >
> >     $ git name-rev --refs=tags/\* --name-only $(git rev-parse v1.8.3 v1.8.3^0)
> >     v1.8.3
> >     v1.8.3^0
> >
> > The difference in these two behaviours is achieved by adding --peel-to-commit
> > option to "name-rev" and using it when "describe" internally calls it.
> 
> Essentially a revert of [2/4] for describe-purposes, achieved by
> adding an ugly command-line option to name-rev.

I don't think it is a revert. The two patches complement each other.

2/4 is basically "if we have a non-commit object which is pointed at
directly by a tip, make sure we name it by that tip". But you can only
get such an object by "name-rev --stdin", since name-rev peels its
command-line arguments.

4/4 is "stop peeling command line objects, so we can find their exact
tips". IOW, it lets the command line do the same thing that --stdin was
able to do in 2/4.

> Before we argue any further, let me ask: who uses name-rev (and
> depends strongly on its output)?!  Our very own testsuite does not
> exercise it.  There are exactly two users of describe/name-rev:
> 
> 1. prompt, obviously.
> 2. DAG-tests, for simplification.

Yeah, I'm not clear on who we are breaking with the change in default
peeling behavior, nor why the "describe --contains" wrapper wants to
keep it.

-Peff
