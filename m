From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Fri, 18 May 2007 14:27:03 +0200
Message-ID: <200705181427.03598.Josef.Weidendorfer@gmx.de>
References: <200705170539.11402.andyparkins@gmail.com> <200705181021.30062.andyparkins@gmail.com> <20070518110804.GD4708@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Fri May 18 14:27:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp1Yl-0006mt-13
	for gcvg-git@gmane.org; Fri, 18 May 2007 14:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754776AbXERM1n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 08:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754390AbXERM1m
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 08:27:42 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:54244 "EHLO
	mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754545AbXERM1m (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 May 2007 08:27:42 -0400
Received: from dhcp-3s-51.lrr.in.tum.de (dhcp-3s-51.lrr.in.tum.de [131.159.35.51])
	by mail.in.tum.de (Postfix) with ESMTP id C511327C6;
	Fri, 18 May 2007 14:27:40 +0200 (MEST)
User-Agent: KMail/1.9.6
In-Reply-To: <20070518110804.GD4708@mellanox.co.il>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47599>

On Friday 18 May 2007, Michael S. Tsirkin wrote:
> > Quoting Andy Parkins <andyparkins@gmail.com>:
> > Subject: Re: [3/4] What's not in 1.5.2 (new topics)
> > 
> > On Friday 2007 May 18, Josef Weidendorfer wrote:
> > 
> > > It all depends on how we construct the default URL out of the subproject
> > > identifier. Options:
> > > (1) do not try to construct a default URL at all. Error out without a
> > > config (2) use a configurable rewriting scheme like s/(.*)/git://host/\1/
> > > (3) automatically detect a senseful rewriting scheme
> > >
> > > Let's start with (1). We can invent convenient default schemes later on.
> > 
> > All good; except let's start with 
> > 
> >  (1) if no config, try using the key itself - error out if that fails
> > 
> > Then everybody is happy - if you want to use your system where the key is not 
> > a URL, then don't - you'll get the error you want.  If the user chose to use 
> > a URL then magic will happen.
> 
> I don't want an error. No one wants an error.

Heh.
Of course, a git-clone should come up with a URL in the local config
such that subproject clones can happen without any an error.

The error would potentially happen after cloning if no config entry
for the URL can be found, e.g. when you decided at clone time to not
fetch any subprojects, but do that later.

> I want to be able to clone a super project, a subproject,
> and use my copy of both instead of the original - including
> cloning my copy, pulls between such clones, being able to verify
> that they are identical.

What about using user-global git configuration for this *before*
git-clone of the superprojects happens?

Lets say you have a clone of the linux-2.6 repository at ~/gitrepo/linux26,
and you want to clone a superproject which includes linux-2.6 as subproject,
using "linux26" (or perhaps "git://git.kernel.org/pub/linux-2.6.git") as
subproject identifier.
Before cloning this superproject, you should be able to set up in ~/.gitconfig

 [project "linux26"]
   localurl = ~/gitrepo/linux26

and the clone of the superproject should be able to use this repository as
subproject repository.

> What I *don't* want is a situation where the fact that original repository
> resides in north america necessarily means that everyone who looks at *my* clone
> of it will do a round trip to north america too.

Someone which clones from you probably does not have access to "~/gitrepo/linux26",
so you have to provide a public visible URL either way, like

 [project "linux26"]
   localurl = ~/gitrepo/linux26
   url = git://myhost/mylinux26.git

and the "url" should be configured at the remote side at clone time.

Josef
