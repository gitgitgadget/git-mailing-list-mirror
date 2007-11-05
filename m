From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] parseopt: introduce OPT_RECURSE to specify shared
 options
Date: Mon, 5 Nov 2007 16:29:43 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711051623450.4362@racer.site>
References: <1194264204-3475-1-git-send-email-madcoder@debian.org>
 <1194264204-3475-2-git-send-email-madcoder@debian.org>
 <Pine.LNX.4.64.0711051230020.4362@racer.site> <Pine.LNX.4.64.0711051237420.4362@racer.site>
 <Pine.LNX.4.64.0711051315300.4362@racer.site> <Pine.LNX.4.64.0711051340490.4362@racer.site>
 <alpine.LFD.0.999.0711050755340.15101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Nov 05 17:30:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip4qh-0004WQ-Bv
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 17:30:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871AbXKEQag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 11:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752393AbXKEQag
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 11:30:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:53716 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752080AbXKEQaf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 11:30:35 -0500
Received: (qmail invoked by alias); 05 Nov 2007 16:30:33 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp051) with SMTP; 05 Nov 2007 17:30:33 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18/M59O3Ck/90/6DaO1bhKbMsWolEVoHPt0cQoMBp
	RCRbea5krDXotn
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.999.0711050755340.15101@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63524>

Hi,

On Mon, 5 Nov 2007, Linus Torvalds wrote:

> On Mon, 5 Nov 2007, Johannes Schindelin wrote:
> > 
> > After kicking this around a bit more on IRC, we had another idea.  
> > Instead of introducing OPT_RECURSE(), do something like OPT__QUIET(), 
> > only this time in diff.h: ....
> 
> I think the preprocessor approach would tend to be simpler, which is an 
> advantage. But whichever approach is chosen, I think one important issue 
> is to make sure that options that *hide* other options are correctly 
> handled in the help printout..

Yep. See my patch 3/3, which just used a char[256] for the short names, 
and a path-list for the long names.

> But that's an implementation issue. The same certainly *can* be done 
> with a recursive setup, just passing a linked list of what the earlier 
> levels were (which is what we do in other places). And it's not like the 
> recursion is going to be very deep or complex.

Exactly.

The more pressing issue is that we have pointers in the option structure, 
which point back to the variables expected to hold the option values.

The recurse approach would need fixing up those (or some ugly copying of 
a struct diff_options).

But the preprocessor approach means wasting space (since we basically have 
the same options in different builtins), and it means that the callback 
functions needed to parse e.g. the diff colour names need to be public.  
Which is not the worst thing, of course.

Ciao,
Dscho
