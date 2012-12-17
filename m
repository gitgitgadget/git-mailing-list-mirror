From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH 3/3] Makefile: use -Wdeclaration-after-statement if
 supported
Date: Mon, 17 Dec 2012 02:15:01 +0000
Message-ID: <20121217021501.GA13745@gmail.com>
References: <1355686561-1057-1-git-send-email-git@adamspiers.org>
 <1355686561-1057-4-git-send-email-git@adamspiers.org>
 <7vk3shphru.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 03:15:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkQEs-0004PQ-N2
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 03:15:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949Ab2LQCPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 21:15:05 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:41554 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768Ab2LQCPF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 21:15:05 -0500
Received: from localhost (4.8.9.4.4.5.7.d.4.0.6.a.a.2.0.b.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:b02a:a604:d754:4984])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 593202E5D5
	for <git@vger.kernel.org>; Mon, 17 Dec 2012 02:15:02 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vk3shphru.fsf@alter.siamese.dyndns.org>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211622>

On Sun, Dec 16, 2012 at 05:52:05PM -0800, Junio C Hamano wrote:
> Adam Spiers <git@adamspiers.org> writes:
> 
> > If we adopt this approach,...
> > diff --git a/Makefile b/Makefile
> > index a49d1db..aae70d4 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -331,8 +331,13 @@ endif
> >  # CFLAGS and LDFLAGS are for the users to override from the command line.
> >  
> >  CFLAGS = -g -O2 -Wall
> > +GCC_DECL_AFTER_STATEMENT = \
> > +	$(shell $(CC) --help -v 2>&1 | \
> > +		grep -q -- -Wdeclaration-after-statement && \
> > +	  echo -Wdeclaration-after-statement)
> > +GCC_FLAGS = $(GCC_DECL_AFTER_STATEMENT)
> > +ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS) $(GCC_FLAGS)
> >  LDFLAGS =
> > -ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
> >  ALL_LDFLAGS = $(LDFLAGS)
> 
> Please do not do this.
> 
> People cannot disable it from the command line, like:
> 
>     $ make V=1 CFLAGS='-g -O0 -Wall'
> 
> If anything, this should be part of the default CFLAGS.
> 
> More importantly, this will run the $(shell ...) struct once for
> every *.o file we produce, I think, in addition to running it twice
> for the whole build.

[snipped]

OK; I expect these issues with the implementation are all
surmountable.  I did not necessarily expect this to be the final
implementation anyhow, as indicated by my comments below the divider
line.  However it's not clear to me what you think about the idea in
principle, and whether other compiler flags would merit inclusion.

(And also, please don't let this discussion hold up acceptance of the
two prior patches in the series.  Even though they are independent,
they are somewhat logically related so I grouped them into the same
series, although I'm not sure if that was the right thing to do.)
