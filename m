From: Jeff King <peff@peff.net>
Subject: Re: Building git 2.4.5 on AIX 6.1 problems
Date: Sun, 12 Jul 2015 00:18:18 -0400
Message-ID: <20150712041818.GA17595@peff.net>
References: <516b832bd9db48e4bdb486d63b2a3977@imap.force9.net>
 <xmqqwpy9uqth.fsf@gitster.dls.corp.google.com>
 <a4eee6a136cafece6be5dbd5ee934f7a@imap.force9.net>
 <xmqq1tggmwdc.fsf@gitster.dls.corp.google.com>
 <1436596266437-7635513.post@n2.nabble.com>
 <CAPc5daWJ7T9UFi_457MvTBN7hoxAD0mEwwbQE1R076=Z+BWu7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: norricorp <john@norricorp.f9.co.uk>
X-From: git-owner@vger.kernel.org Sun Jul 12 06:18:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZE8if-0005qt-Ql
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jul 2015 06:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060AbbGLESW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2015 00:18:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:59074 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750759AbbGLESV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2015 00:18:21 -0400
Received: (qmail 15769 invoked by uid 102); 12 Jul 2015 04:18:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 11 Jul 2015 23:18:21 -0500
Received: (qmail 19573 invoked by uid 107); 12 Jul 2015 04:18:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 12 Jul 2015 00:18:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Jul 2015 00:18:18 -0400
Content-Disposition: inline
In-Reply-To: <CAPc5daWJ7T9UFi_457MvTBN7hoxAD0mEwwbQE1R076=Z+BWu7w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273886>

On Fri, Jul 10, 2015 at 11:57:28PM -0700, Junio C Hamano wrote:

> > So it is obviously a structure or variable that is being used so does anyone
> > know the library that this is defined in?
> 
> Most of our objects should be found in libgit.a (you can see it on your
> command line) that our Makefile builds.
> 
> Now, it has been more than a decade since I last had to deal with a
> system that needs this the last time, but perhaps AIX linker needs the
> archives explicitly prepared with ranlib(1)? Just a shot in the dark...

Ugh, you are giving me flashbacks. ;)

We use the "s" flag to "ar", which is supposed to do the same thing as
ranlib. But I guess it is possible that the system ar does not respect
that flag. Certainly running ranlib manually would be an interesting
experiment.

If the system has GNU ar on it as well as an AIX ar, it might be
interesting to point $(AR) at the former. E.g.:

  make clean
  make AR=gar

(where "gar" is whatever GNU ar is called on the system).

-Peff
