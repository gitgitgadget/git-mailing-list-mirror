From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Bizarre missing changes (git bug?)
Date: Tue, 29 Jul 2008 04:59:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com>
 <alpine.LFD.1.10.0807211331390.31863@woody.linux-foundation.org>
 <200807260512.40088.zippel@linux-m68k.org>
 <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 05:00:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNfRg-0000e2-JT
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 05:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753113AbYG2C7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 22:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753088AbYG2C7O
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 22:59:14 -0400
Received: from smtp-vbr11.xs4all.nl ([194.109.24.31]:4968 "EHLO
	smtp-vbr11.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081AbYG2C7N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 22:59:13 -0400
Received: from squid.home (linux-m68k.xs4all.nl [82.95.193.92])
	(authenticated bits=0)
	by smtp-vbr11.xs4all.nl (8.13.8/8.13.8) with ESMTP id m6T2x1gT043124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 29 Jul 2008 04:59:06 +0200 (CEST)
	(envelope-from zippel@linux-m68k.org)
X-X-Sender: roman@localhost.localdomain
In-Reply-To: <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90556>

Hi,

On Sun, 27 Jul 2008, Linus Torvalds wrote:

> You don't actually understand how git works, do you?

Probably not and to be honest I don't care, all I want is my history - the 
correct one. All I know it's in there somehow and all I care is how to get 
it out of there.
Right now you're giving me the choice between a crappy incomplete history 
or a crappy history full of useless information. That's it? As long as 
your challenge involves being compared to crappy history, I'm not 
interested. If the solution should involve a switch "--correct-history" 
or I have to wait for the result, I don't care, because it's the correct 
history I want. As long as you're trying to sell me crappy history I'm not 
buying it.

Can we please get past this and look at what is required to produce the 
correct history?

Fact is based on the current git-log output it's simply impossible to 
produce the correct history without reading the whole history first, since 
the very last commit can still be relevant for an earlier merge to connect 
it properly into the graph. This means we need some extra information 
before even starting to scan through the commits. Luckily this information 
can be cached once it has been generated and it also can be updated 
incrementally. E.g. this information could be generated while generating 
the pack, so you only had to scan the commits which haven't been packed 
yet, but it's also possible to update it when merging/pulling new data. 
It's also not much information that is needed, all that is needed is list 
of commits per file (which are are usually only a few, mostly even none), 
which git-log can use, so it knows that these are important while scanning 
the tree.

Technically I don't see a really hard problem to implement this, the 
problem for me is only that I have no idea where to start this within git 
and how to integrate it. The other problem (over which I have absolutely 
no control) is whether anyone actually wants to produce a correct history.
I hope there is someone, otherwise there would be no need for "git-log 
--full-history" (which is also used by git-web), this e.g. produces a nice 
example in kernel/printk.c, where git-web produces two commits (search for 
tty_write_message), for which none of the front ends can tell me usefully 
how it fits into the history (they either don't show it at all or it's 
lost in "gitk --full-history").

bye, Roman
