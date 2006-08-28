From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Starting to think about sha-256?
Date: Tue, 29 Aug 2006 01:09:18 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608290101320.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <44F1DCB7.6020804@garzik.org>  <m31wr1exbf.fsf@defiant.localdomain>
 <Pine.LNX.4.64.0608271343120.27779@g5.o sdl.org>
 <Pine.LNX.4.63.0608272341330.28360@wbgn013.biozentrum.uni-wuerzburg .de>
 <Pine.LNX.4.64.0608271522390.27779@g5.osdl.org> <656C30A1EFC89F6B2082D9B6@localhost>
 <Pine.LNX.4.64.0608281034440.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Lang <david.lang@digitalinsight.com>,
	Krzysztof Halasa <khc@pm.waw.pl>,
	Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 29 01:09:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHqES-0004HA-Md
	for gcvg-git@gmane.org; Tue, 29 Aug 2006 01:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbWH1XJ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 19:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWH1XJ0
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 19:09:26 -0400
Received: from mail.gmx.de ([213.165.64.20]:17832 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751442AbWH1XJZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Aug 2006 19:09:25 -0400
Received: (qmail invoked by alias); 28 Aug 2006 23:09:23 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 29 Aug 2006 01:09:23 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0608281034440.27779@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26185>

Hi,

On Mon, 28 Aug 2006, Linus Torvalds wrote:

> 
> 
> On Mon, 28 Aug 2006, David Lang wrote:
> > 
> > just to double check.
> > 
> > if you already have a file A in git with hash X is there any condition where a
> > remote file with hash X (but different contents) would overwrite the local
> > version?
> 
> Nope. If it has the same SHA1, it means that when we receive the object 
> from the other end, we will _not_ overwrite the object we already have.

The only notable exception I can think of: "git fetch -k". If you then try 
to retrieve the bogus object, it will return the one of whichever pack was 
returned first be readdir(). (If I read the source correctly.)

Now, the cases are rare where you do both "git fetch -k" and "git repack 
-a -d" (the latter of which _could_ leave a hole in the directory which 
_could_ make the next fetched pack fill that hole, which in turn _could_ 
make readdir() return that pack before more "senior" packs) in the same 
repository, but in these cases, yes, you could end up with the copy of the 
remote side.

You'd need to explicitely use "git fetch -k", though.

Ciao,
Dscho
