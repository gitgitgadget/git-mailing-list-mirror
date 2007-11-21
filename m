From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Wishlist for a bundle-only transport mode
Date: Wed, 21 Nov 2007 17:07:51 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711211702440.27959@racer.site>
References: <8aa486160711210654p357ccd87i4809e0cda9471303@mail.gmail.com> 
 <Pine.LNX.4.64.0711211554370.27959@racer.site> <1195662180.28318.19.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Santi =?ISO-8859-1?Q?B=E9jar?= <sbejar@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 18:08:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iut3c-0008T7-Gf
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 18:08:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbXKURHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 12:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752002AbXKURHy
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 12:07:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:53075 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751614AbXKURHx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 12:07:53 -0500
Received: (qmail invoked by alias); 21 Nov 2007 17:07:51 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp003) with SMTP; 21 Nov 2007 18:07:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Ak1ltMtgAh9hkYUolEk5kH7eT/mRpFlf7ITMeT3
	hHELhPJWflrxES
X-X-Sender: gene099@racer.site
In-Reply-To: <1195662180.28318.19.camel@hinata.boston.redhat.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65682>

Hi,

On Wed, 21 Nov 2007, Kristian H?gsberg wrote:

> On Wed, 2007-11-21 at 15:59 +0000, Johannes Schindelin wrote:
> > Hi,
> > 
> > On Wed, 21 Nov 2007, Santi B?jar wrote:
> > 
> > > 1) git-clone does not accept a bundle file, even if git-fetch does. I've 
> > > made a patch to use git-fetch in git-clone for this.
> > 
> > This, along with rewriting git-clone as a very thin wrapper over git-init, 
> > -remote and -fetch, is a really low hanging fruit.
> > 
> > Or maybe go the full nine yards and build it in.  Should be a breeze now, 
> > given parse_options() and run_command().
> 
> I started doing this, which is pretty stupid as I'm pressed to find time 
> to finish up builtin-commit.  Nevertheless, could you elaborate on the 
> plan here?  How would you rewrite it to just use remote and fetch?  I 
> just finished the boilerplate option parsing stuff (patch below) and 
> started reading the core of git-clone.sh, but if most of this can be 
> replaced I'd like to hear about it :)

After handling the options like --reference, and except for special 
handling of a local clone (not via file:// protocol), it should be as easy 
as

	git remote add -f origin $url &&
	case "$no_checkout" in
	t)
		;;
	*)
		git checkout -f -b master remotes/origin/HEAD
		;;
	esac

(Of course I'd use run_command() for this.)

I would avoid at all costs to reimplement the different methods for the 
different protocols.

Ciao,
Dscho
