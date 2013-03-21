From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] drop some "int x = x" hacks to silence gcc warnings
Date: Thu, 21 Mar 2013 11:44:02 -0400
Message-ID: <20130321154402.GA25907@sigill.intra.peff.net>
References: <20130321110338.GA18552@sigill.intra.peff.net>
 <514AF2E1.7020409@viscovery.net>
 <20130321115545.GB21319@sigill.intra.peff.net>
 <7vppysbxzo.fsf@alter.siamese.dyndns.org>
 <7vhak4bx0w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 21 16:44:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIhfS-0007xr-AX
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 16:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932706Ab3CUPoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 11:44:11 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33931 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932453Ab3CUPoK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 11:44:10 -0400
Received: (qmail 24326 invoked by uid 107); 21 Mar 2013 15:45:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Mar 2013 11:45:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Mar 2013 11:44:02 -0400
Content-Disposition: inline
In-Reply-To: <7vhak4bx0w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218737>

On Thu, Mar 21, 2013 at 08:19:43AM -0700, Junio C Hamano wrote:

> >     $ git grep '#define uninitialized_var' include/
> >     include/linux/compiler-gcc.h:#define uninitialized_var(x) x = x
> >     include/linux/compiler-intel.h:#define uninitialized_var(x) x
> >
> > but they recently had a discussion, e.g.
> >
> >     http://thread.gmane.org/gmane.linux.kernel.openipmi/1998/focus=1383705
> >
> > so...
> 
> While flipping the paragraphs around before sending the message out
> I managed to lose the important one.  Here is roughly what I wrote:
> 
>     I am for dropping "= x" and leaving it uninitialized at the
>     declaration site, or explicitly initializing it to some
>     reasonable starting value (e.g. NULL if it is a pointer) and
>     adding a comment to say that the initialization is to squelch
>     compiler warnings.

I'd be in favor of that, too. In many cases, I think the fact that gcc
cannot trace the control flow is a good indication that it is hard for a
human to trace it, too. And in those cases we would be better off
restructuring the code slightly to make it more obvious to both types of
readers.

Two patches to follow.

  [5/4]: fast-import: clarify "inline" logic in file_change_m
  [6/4]: run-command: always set failed_errno in start_command

-Peff
