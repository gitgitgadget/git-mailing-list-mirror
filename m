From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] Let .git/config specify the url for submodules
Date: Sat, 02 Jun 2007 19:35:51 +0200
Message-ID: <20070602173551.GC955MdfPADPa@greensroom.kotnet.org>
References: <8c5c35580705301717h4e9b127fr21ee19764f8ec288@mail.gmail.com>
 <20070601085705.GT955MdfPADPa@greensroom.kotnet.org>
 <8c5c35580706010225p7c34c3ceu8bbfb9996388d673@mail.gmail.com>
 <20070601093554.GV955MdfPADPa@greensroom.kotnet.org>
 <8c5c35580706010745l76fc5410l21f2e3f385693ad9@mail.gmail.com>
 <20070601145104.GY955MdfPADPa@greensroom.kotnet.org>
 <8c5c35580706010856s390b1157p3ea0d28cb2074cae@mail.gmail.com>
 <alpine.LFD.0.98.0706010919360.3957@woody.linux-foundation.org>
 <20070602074910.GB955MdfPADPa@greensroom.kotnet.org>
 <alpine.LFD.0.98.0706020923170.23741@woody.linux-foundation.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Lars Hjemli <hjemli@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jun 02 19:36:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuXWD-0004rO-T2
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 19:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760866AbXFBRfy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 13:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760889AbXFBRfy
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 13:35:54 -0400
Received: from smtp19.wxs.nl ([195.121.247.10]:54360 "EHLO smtp19.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760866AbXFBRfy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 13:35:54 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp19.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JJ000570RJREL@smtp19.wxs.nl> for git@vger.kernel.org; Sat,
 02 Jun 2007 19:35:52 +0200 (CEST)
Received: (qmail 619 invoked by uid 500); Sat, 02 Jun 2007 17:35:51 +0000
In-reply-to: <alpine.LFD.0.98.0706020923170.23741@woody.linux-foundation.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48939>

On Sat, Jun 02, 2007 at 09:34:26AM -0700, Linus Torvalds wrote:
> On Sat, 2 Jun 2007, Sven Verdoolaege wrote:
> > On Fri, Jun 01, 2007 at 09:29:58AM -0700, Linus Torvalds wrote:
> > > 	[module "infrastructure"]
> > > 		submodule = lib
> > > 		submodule = build
> > > 
> > > 	[submodule "lib"]
> > > 		url = git://xyzzy/lib-1.2.3
> > > 
> > > 	[submodule "build"]
> > > 		url = git://xyzzy/build-0.61
> > > 
> > > 
> > > IOW, in the above case, we have *three* modules:
> > > 
> > >  - module "infrastructure", that is the union of submodules/paths "lib" 
> > >    and "build"
> > >  - module "lib" (== submodule/path "lib")
> > >  - module "build" (== submodule/path "build")
> > 
> > If there are three modules, then why is one in the "module" section
> > and the other two in the "submodule" section?
> 
> Because there are:
> 
>  - *two* actual submodules (== path), namely "lib" and "build".
> 
>  - each submodule always is *implicitly* a module too
> 
>  - we have a *named* (aka explicit) module "infrastructure" that is a 
>    higher-level name for one or more submodules (in this case two).
> 
> So the implicit modules could have been written out:
> 
> 	[module "lib"]
> 		submodule = "lib" 	# aka 'path = "lib"'
> 
> 	 [module "build"]
> 		submodule = "build"	# aka 'path = "build"'
> 
> but my suggestion was that if the module name and the path name are the 
> same, you don't need to say it.
> 
> (And quite frankly, I think it reads better as "submodule" than as "path", 
> but maybe that threw you).

I did indeed glance over the "submodule == path" in your mail (and it
seems Junio did so too).
I thought it was more or less agreed that the URL should be associated
to the logical module rather than the path (which you call "submodule"
here).  See http://article.gmane.org/gmane.comp.version-control.git/47567 .

Personally, I find your section names confusing.
Both your "submodule"s and "module"s are submodules from the point
of view of the project containing the .gitmodules.
And anything in the "submodule" section is only a (proper) submodule
of some other module if there happens to be a "module" containing it.

What's wrong with the following?

	[module "infrastructure"]
		submodule = lib
		submodule = build

	[module "lib"]
		url = git://xyzzy/lib-1.2.3

	[module "build"]
		url = git://xyzzy/build-0.61

A module with a "url" attribute can be cloned from that url.
A module with one or more "submodule" attributes requires
these modules as well.

> > Why not allow a module to both contain smaller modules and be contained
> > in a bigger module?
> 
> Because the "module" definition is _different_ from the "submodule" 
> definition.

>From the point of view of the user, they are the same.
They can both be used as an argument to

	git submodule checkout

> The "module" definition is just a level of indirection.

But why limit yourself to _one_ level of indirection?
If you call everything a "module" (or everything a "submodule")
then you get multiple levels of indirection for free.

skimo
