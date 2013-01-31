From: Jeff King <peff@peff.net>
Subject: Re: Segmentation fault with latest git (070c57df)
Date: Thu, 31 Jan 2013 03:54:31 -0500
Message-ID: <20130131085431.GA8467@sigill.intra.peff.net>
References: <15825158.309231359617223702.JavaMail.weblogic@epml26>
 <20130131075511.GB5342@sigill.intra.peff.net>
 <87wqutvj4w.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jongman Heo <jongman.heo@samsung.com>, git <git@vger.kernel.org>,
	Antoine Pelisse <apelisse@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jan 31 09:55:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0pv7-0003Z3-G1
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 09:54:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753048Ab3AaIyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 03:54:36 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54529 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751594Ab3AaIye (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 03:54:34 -0500
Received: (qmail 9527 invoked by uid 107); 31 Jan 2013 08:55:58 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 31 Jan 2013 03:55:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Jan 2013 03:54:31 -0500
Content-Disposition: inline
In-Reply-To: <87wqutvj4w.fsf@pctrast.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215110>

On Thu, Jan 31, 2013 at 09:42:07AM +0100, Thomas Rast wrote:

> > int main(void)
> > {
> >   struct foo f = { NULL, 0, 0, 0 };
> >   printf("cmp is %lu\n", (unsigned long)f.cmp);
> >   return 0;
> > }
> 
> I doubt that would help because that stack region would be 0 anyway due
> to kernel initialization of new pages.  You'd have to somehow trample
> over it first, like below.

Good point. Unfortunately, I can't get either yours or mine to fail,
neither with a recent version of gcc nor with gcc-4.1.  But I can't
convince git to fail, either. The only gcc-4.1 I have is Debian's
4.1.3 release, which is not quite what the OP has.

> Or perhaps something in the build process went wrong, and fetch.c didn't
> get the memo about the new field in the struct.  Depending on stack
> layout, the next variable might be the 'int i' right before the
> 'string_list list' in the code, which could explain the value of 1.

Yeah, that would make sense to me with respect to the behavior we are
seeing, but that part of the Makefile should be pretty simple and
bug-free, I'd think (and from the original report, it seems like he was
able to reproduce it well enough to bisect). Still, trying a "make clean
&& make" might be worth it just to rule that out.

Puzzled...

-Peff
