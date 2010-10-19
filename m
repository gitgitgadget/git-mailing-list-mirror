From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: fetch and bundle don't work in (semi-)broken repo
Date: Tue, 19 Oct 2010 16:48:23 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010191635030.2764@xanadu.home>
References: <20101019160957.GK11713@pengutronix.de>
 <20101019183925.GF25139@burratino> <20101019201139.GB28166@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_b2pLHdQBQfStyW3Sz3a51A)"
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Tue Oct 19 22:48:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8J74-00007x-Cu
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 22:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757535Ab0JSUsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 16:48:37 -0400
Received: from relais.videotron.ca ([24.201.245.36]:17331 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757531Ab0JSUsg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 16:48:36 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ22.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LAK00C911SNGU00@VL-MR-MRZ22.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 19 Oct 2010 16:48:23 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20101019201139.GB28166@pengutronix.de>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159362>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_b2pLHdQBQfStyW3Sz3a51A)
Content-type: TEXT/PLAIN; charset=iso-8859-1
Content-transfer-encoding: 8BIT

On Tue, 19 Oct 2010, Uwe Kleine-König wrote:

> Hi Jonathan,
> 
> On Tue, Oct 19, 2010 at 01:39:25PM -0500, Jonathan Nieder wrote:
> > Uwe Kleine-König wrote:
> > 
> > > 	ukl@hostname:~/path1/linux-2.6$ git fetch ~/path2/linux-2.6 sectionmismatches
> > > 	remote: Counting objects: 118, done.
> > > 	remote: error: unable to find 40aaeb204dc04d3cf15c060133f65538b43b13b0
> > > 	remote: Compressing objects: 100% (83/83), done.
> > > 	remote: fatal: unable to read 40aaeb204dc04d3cf15c060133f65538b43b13b0
> > > 	error: git upload-pack: git-pack-objects died with error.
> > > 	fatal: git upload-pack: aborting due to possible repository corruption on the remote side.
> > 
> > Sounds like alternates or workdir allowed gc to be overzealous, indeed.
> > 
> > Could you:
> > 
> >  1. Make a copy of the corrupted repo, just in case.
> >  2. Explode all backs with "git unpack-objects"

That's usually unnecessary.  If the pack itself is corrupted, trying to 
unpack it all won't help.

> I did:
> 
> 	mv .git/objects/pack .git/objects/pack.bak
> 	rm .git/objects/info/alternates
> 	for p in .git/objects/pack.bak/*.pack ~/path1/linux-2.6/.git/objects/pack/*.pack; do
> 		git unpack-objects < $p
> 	done

Ouch!  You will end up with a multi-gigabyte repository, which will be 
abominably slow.

> >  3. Identify the missing object, as explained in
> >     Documentation/howto/recover-corrupted-blob-object.txt?

That's useful when you have only one corrupted object and you want to 
recreate it from raw material.  But ideally you should simply find a 
pack that contains the problematic object in another repository and copy 
it with its index 
file into the broken repository.

> and I'm running git-fsck --full now over night as it's bedtime here.

Given that you exploded your repo into loose objects, it'll take _time_.


Nicolas

--Boundary_(ID_b2pLHdQBQfStyW3Sz3a51A)--
