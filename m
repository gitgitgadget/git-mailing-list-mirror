From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Update on builtin-commit
Date: Mon, 2 Jul 2007 18:02:05 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707021758090.4071@racer.site>
References: <11833861634103-git-send-email-krh@redhat.com> 
 <Pine.LNX.4.64.0707021709120.4071@racer.site> <1183395082.30611.16.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 19:02:22 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5PI6-0008Q7-8h
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 19:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbXGBRCJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 13:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbXGBRCI
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 13:02:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:56393 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750921AbXGBRCH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 13:02:07 -0400
Received: (qmail invoked by alias); 02 Jul 2007 17:02:05 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp056) with SMTP; 02 Jul 2007 19:02:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/H1EcPkFLH/DG1ygRz8HCLw5Ti0reNoN1spAwp1x
	RNhK20fuGS2CaV
X-X-Sender: gene099@racer.site
In-Reply-To: <1183395082.30611.16.camel@hinata.boston.redhat.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51384>

Hi,

On Mon, 2 Jul 2007, Kristian H?gsberg wrote:

> On Mon, 2007-07-02 at 17:11 +0100, Johannes Schindelin wrote:
> > just a quick comment on the option parser:
> > 
> > On most platforms, sizeof(void*)>=sizeof(int). But I would not rely on 
> > that. Rather (also because it is prettier), I'd use "union".
> 
> In the OPTION_INTEGER case, the 'value' void pointer points to an 
> integer global that's set to the value passed.  In the OPTION_NONE, it 
> also points to an integer, which is set to 1 if the option is seen.  So 
> I'm relying on sizeof(void*) == sizeof(int*), but I'm not storing ints 
> in pointers.

Ah, right.

> > Besides, your option parser loses order information, correct? IOW, 
> > something like "--color --no-color --color" would confuse it.
> 
> Yes, I don't record the order of options, but in the builtin-commit 
> case, I don't think there are any options where that makes a difference?

That might be correct now. But why not make the option parser general 
enough to (finally!) support something like "git clone -lns <directory>", 
i.e. short options a la GNU? This is something that has been wanted for a 
long time.

Besides, if you make the option parser not general enough to be reused in 
all git programs, I wonder why bother at all? It's not like it is less 
complex than a hand-rolled option parser, if it is used only once.

> In cases where order is important or we have an option that negates the 
> effect of another option (your --no-color example), we could either 1) 
> extend the option struct with a 'disable' name that flips the value back 
> to 0 or 2) instead of just setting it to 1, record the index of the 
> options passed and compare the indexes of conflicting options to see 
> which one was passed last.

Hmm. Somehow I think that the getopt solution is not so bad at all. We'd 
need some code in compat/, but since we're GPL, and there are so many 
GPLed getopt versions out there, I don't see any obstacle there.

Ciao,
Dscho
