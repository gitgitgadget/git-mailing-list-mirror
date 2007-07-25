From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: submodule init problem
Date: Wed, 25 Jul 2007 10:15:08 +0200
Message-ID: <20070725081508.GN1591MdfPADPa@greensroom.kotnet.org>
References: <alpine.LFD.0.98.0706010919360.3957@woody.linux-foundation.org>
 <7vfy5bzby1.fsf@assigned-by-dhcp.cox.net>
 <8c5c35580706020013g2a4039fcsdf8974da8cd4c2c2@mail.gmail.com>
 <20070602074410.GA955MdfPADPa@greensroom.kotnet.org>
 <b6ebd0a50707201023h12ed3c61v31ccb2b356c1ee42@mail.gmail.com>
 <7vsl7jvthk.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0707201933360.14781@racer.site>
 <d4b731510707241709pcad0a4bj85b71892cd2de84c@mail.gmail.com>
 <d4b731510707241730u45755c0dwfde5e0b14b14f1da@mail.gmail.com>
 <7vir89fe1l.fsf@assigned-by-dhcp.cox.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Ricky Nite <ricky.nite@gmail.com>,
	Chris Larson <clarson@kergoth.com>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 10:15:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDc1g-0005HS-Fz
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 10:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753042AbXGYIPO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 04:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752497AbXGYIPN
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 04:15:13 -0400
Received: from psmtp13.wxs.nl ([195.121.247.25]:54009 "EHLO psmtp13.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752099AbXGYIPK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 04:15:10 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp13.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JLQ00AWJ6X8GY@psmtp13.wxs.nl> for git@vger.kernel.org; Wed,
 25 Jul 2007 10:15:09 +0200 (MEST)
Received: (qmail 19150 invoked by uid 500); Wed, 25 Jul 2007 08:15:08 +0000
In-reply-to: <20070602074410.GA955MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707201933360.14781@racer.site>
 <7vir89fe1l.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53675>

On Tue, Jul 24, 2007 at 06:49:26PM -0700, Junio C Hamano wrote:
> Ok, this appears it most likely to be related to the fact that
> one is a prefix of the other in problematic case.

Yes, this has been noted before and Chris Larson sent in a patch,
but he didn't follow up on it.

On Fri, Jul 20, 2007 at 07:36:43PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 20 Jul 2007, Junio C Hamano wrote:
> 
> > "Chris Larson" <clarson@kergoth.com> writes:
> > 
> > > +       name=$(GIT_CONFIG=.gitmodules git config --get-regexp
> > > '^submodule\..*\.path$' "^$path$" |
> > >        sed -nre 's/^submodule\.(.+)\.path .+$/\1/p')
> 
> I wonder why it is a regular expression to begin with, since we seem to 
> prefer shell patterns on paths.
> 
> However, _if_ we already go with regexps, why not just put it into the 
> "sed" call, which is _already_ there, and leave "git config" alone?  IOW 
> call
> 
> 	git config --get-regexp '^submodule\..*\.path$' |
> 		sed -nre 's/^submodule\.(.*$path.*)\.path .+$\1/p'
>

You would be matching the key (the name of the module) rather than
the value (the path of the module) here.

Anyway, I'm not sure why Lars went for the regexp.
I thought he wanted to match the path exactly, which
is why I originally proposed (the more clunky)

On Sat, Jun 02, 2007 at 09:44:10AM +0200, Sven Verdoolaege wrote:
> On Sat, Jun 02, 2007 at 09:13:55AM +0200, Lars Hjemli wrote:
> > But I don't see an easy way to do the mapping from path to url/submodule 
> > with:
> > 
> > [submodule "xyzzylib"]
> >  path=lib
> >  url=git://xyzzy/lib-1.2.3
> > 
> > Suggestions?
> 
> I'm not a shell programmer, but it could look something like this
> 
>     $ name=$(git config --get-regexp 'submodule\..*\.path' | while read module modulepath; do if test "$modulepath" = "$path"; then echo $module | sed -e 's/^submodule.//' -e 's/.path//'; fi; done)

skimo
