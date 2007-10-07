From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make strbuf_cmp inline, constify its arguments and 
 optimize it a bit
Date: Sun, 7 Oct 2007 19:25:24 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710071925120.4174@racer.site>
References: <1190625904-22808-1-git-send-email-madcoder@debian.org>
 <1190625904-22808-2-git-send-email-madcoder@debian.org> <20071007140052.GA3260@steel.home>
 <20071007172425.bb691da9.tihirvon@gmail.com> <20071007143912.GB10024@artemis.corp>
 <Pine.LNX.4.64.0710071710190.4174@racer.site> <20071007191821.c872cc51.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Timo Hirvonen <tihirvon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 07 20:25:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ieap6-0007Xs-8x
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 20:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307AbXJGSZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 14:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752863AbXJGSZm
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 14:25:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:46738 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752678AbXJGSZl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 14:25:41 -0400
Received: (qmail invoked by alias); 07 Oct 2007 18:25:39 -0000
Received: from unknown (EHLO [172.17.38.182]) [38.99.84.33]
  by mail.gmx.net (mp044) with SMTP; 07 Oct 2007 20:25:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/5Mg8SHsP5+qvBR4qaLfSLCUPNUO9y20xTGciCjC
	Wi2iGjtWVIyWHV
X-X-Sender: gene099@racer.site
In-Reply-To: <20071007191821.c872cc51.tihirvon@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60208>

Hi,

On Sun, 7 Oct 2007, Timo Hirvonen wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > On Sun, 7 Oct 2007, Pierre Habouzit wrote:
> > 
> > > On Sun, Oct 07, 2007 at 02:24:25PM +0000, Timo Hirvonen wrote:
> > >
> > > > strbuf->buf is always non-NULL and NUL-terminated so you could just do
> > > > 
> > > > static inline int strbuf_cmp(const struct strbuf *a, const struct strbuf *b)
> > > > {
> > > > 	int len = a->len < b->len ? a->len : b->len;
> > > > 	return memcmp(a->buf, b->buf, len + 1);
> > > > }
> > > 
> > >   doesn't work, because a buffer can have (in some very specific cases)
> > > an embeded NUL.
> > 
> > But it should work.  The function memcmp() could not care less if there is 
> > a NUL or not, it just compares until it finds a difference.
> 
> Almost.  If a is "hello\0world" and b is "hello" then it would compare 6
> characters from both and think the strings are equal.

Good point.

Ciao,
Dscho
