From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Bizarre missing changes (git bug?)
Date: Wed, 30 Jul 2008 02:16:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0807291433430.6791@localhost.localdomain>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com> 
 <200807260512.40088.zippel@linux-m68k.org> 
 <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org> 
 <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain> 
 <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org> 
 <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain> 
 <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org> 
 <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain> 
 <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org> 
 <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain>
 <46a038f90807282015m7ce3da10h71dfee221c960332@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 02:18:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNzO9-0008FC-7q
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 02:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752976AbYG3AQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 20:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753173AbYG3AQ4
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 20:16:56 -0400
Received: from smtp-vbr13.xs4all.nl ([194.109.24.33]:3732 "EHLO
	smtp-vbr13.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918AbYG3AQz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 20:16:55 -0400
Received: from squid.home (linux-m68k.xs4all.nl [82.95.193.92])
	(authenticated bits=0)
	by smtp-vbr13.xs4all.nl (8.13.8/8.13.8) with ESMTP id m6U0GgOt058238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 Jul 2008 02:16:42 +0200 (CEST)
	(envelope-from zippel@linux-m68k.org)
X-X-Sender: roman@localhost.localdomain
In-Reply-To: <46a038f90807282015m7ce3da10h71dfee221c960332@mail.gmail.com>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90713>

Hi,

On Tue, 29 Jul 2008, Martin Langhoff wrote:

> On Tue, Jul 29, 2008 at 2:59 PM, Roman Zippel <zippel@linux-m68k.org> wrote:
> > Can we please get past this and look at what is required to produce the
> > correct history?
> 
> Roman - correct is --full-history -- any simplification that makes it
> easy on your eyes *is* a simplification. And consumers that want to do
> nice user-friendly simplification like gitk does can hang off the data
> stream.

I don't quite understand what you're trying to say.
To avoid further confusion it maybe helps to specify a few of the terms:

- full history graph: produced by "git-log --full-history --parents"
- compact history graph: the full history graph without without any 
  repeated merges, this is what my example script produces.
- full simplified history: output of "git-log --full-history"
- short simplified history: standard output of "git-log"

The important part about the history graphs is that all commits are 
properly connected in it (i.e. all except the head commit have a child), 
This is needed to know if you don't just what want to know what happened, 
but also how it got merged, also any graphical interface needs it to 
produce a useful history graph.

What the short simplified history is more pure laziness, it's fast and 
gets the most common cases right, but in order to do this it has to ignore 
part of the history. The full simplified history at least produces 
produces the full change history, but it lacks part of the merge history 
and it stills takes longer to generate.

The point I'm trying to make is that the compact history graph has the 
potential to completely replace the simplified history. The only problem 
is that it needs a bit of cached extra information, then it can be as fast 
the short simplified history for the common case and it still can produce 
as much information as the full simplified history, thus you can still 
apply as much simplification as you want on top of it.

Keep in mind that e.g. git-web is using the full simplified history, so 
what I'm offering also has the potential to improve git-web performance...

> > it's also possible to update it when merging/pulling new data.
> 
> If that's what you want to do, you can prototype it with a hook on
> fetch and commit. That is definitely an area that hasn't been explored
> - what nicer (but expensive) views on the history we have can be
> afforded by pre-computing things on fetch and commit hooks.

I already did the prototype, I know how to generate that information, the 
problem is to get that information to the various graphical interfaces.

bye, Roman
