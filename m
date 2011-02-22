From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 0/3] Thinning the git toplevel directory
Date: Tue, 22 Feb 2011 10:56:37 -0500
Message-ID: <20110222155637.GC27178@sigill.intra.peff.net>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
 <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie>
 <AANLkTik8wUrUnjTiUxUZbg3paaQEc7UERQ6J6jUzA2u5@mail.gmail.com>
 <20110218092518.GB30648@elie>
 <7vei75p3zr.fsf@alter.siamese.dyndns.org>
 <20110219111103.GA1841@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 16:56:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrubV-0002XH-PH
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 16:56:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345Ab1BVP4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 10:56:41 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:51963 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753942Ab1BVP4k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 10:56:40 -0500
Received: (qmail 2323 invoked by uid 111); 22 Feb 2011 15:56:39 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 22 Feb 2011 15:56:39 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Feb 2011 10:56:37 -0500
Content-Disposition: inline
In-Reply-To: <20110219111103.GA1841@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167558>

On Sat, Feb 19, 2011 at 05:11:03AM -0600, Jonathan Nieder wrote:

>  - merge builtins/ with commands/.  It never was clear to me why
>    making a command builtin should require changing its filename.

This may be a bit too radical, but maybe the Makefile should use this
structure to save maintenance effort. In other words, is there any
reason not to just have:

  BUILTIN_SOURCES = $(wildcard builtin/*.c)
  BUILTIN_OBJS = $(patsubst builtin/%.c, builtin/%.o, $(BUILTIN_SOURCES))

and similar for LIB_OBJS and LIB_H?

It is one less thing to need to do when writing new code, and one less
thing to have silly textual conflicts on. It probably doesn't matter
that much, though; we don't actually add new files or commands all that
often.

Speaking of Makefiles, one downside to all of this directory
segmentation is that you can't run "make" from the subdirectories. I
don't know how much we care. Certainly we could put a dummy Makefile
in each subdir that just goes to the toplevel and runs make.

-Peff
