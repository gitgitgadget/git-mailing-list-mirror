From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-bundle: move objects and references by archive
Date: Thu, 22 Feb 2007 18:09:02 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702221805070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702220157130.22628@wbgn013.biozentrum.uni-wuerz
 burg.de> <alpine.LRH.0.82.0702212224510.31945@xanadu.home>
 <Pine.LNX.4.63.0702221654131.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45DDC158.9090902@fs.ei.tum.de> <Pine.LNX.4.63.0702221735130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45DDC8D7.60902@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Mark Levedahl <mdl123@verizon.net>,
	Junio C Hamano <junkio@cox.net>
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Thu Feb 22 18:09:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKHRP-0004Ci-7X
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 18:09:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbXBVRJH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 12:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbXBVRJH
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 12:09:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:37985 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750857AbXBVRJG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 12:09:06 -0500
Received: (qmail invoked by alias); 22 Feb 2007 17:09:03 -0000
X-Provags-ID: V01U2FsdGVkX180bdY5GnM0HdG9h+6MGWeaUOJnilOfD2xMGv/4Ar
	ZYaQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45DDC8D7.60902@fs.ei.tum.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40361>

Hi,

On Thu, 22 Feb 2007, Simon 'corecode' Schubert wrote:

> Johannes Schindelin wrote:
> > 
> > On Thu, 22 Feb 2007, Simon 'corecode' Schubert wrote:
> > 
> > > Maybe something like this would be cleaner:
> > > 
> > > if (IS_REF(st.st_mode) && lseek(input_fd, 0, SEEK_CUR) != st.st_size)
> > > 	die("...");
> > 
> > The lseek would fail whenever the input is _not_ a file, dying. Since
> > index-pack is called from fetch-pack, with a socket instead of a file, it
> > would fail for the most common user.
> 
> that's why i put IS_REF (should read IS_REG) there.

Ah, yes, I understand.

> but as nicolas pointed out, this won't work for read-ahead.

Well, you could do this:

if (S_ISREG(st.st_mode) &&
		lseek(input_fd, 0, SEEK_CUR) - input_len != st.st_size)
	die("...");

Of course, this suggests that a file containing a pack must not have 
_anything_ after the pack. But AFAIR the reading part chokes on "garbage 
after pack" anyway.

Ciao,
Dscho
