From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-bundle - bundle objects and references for disconnected
   transfer.
Date: Thu, 15 Feb 2007 16:32:20 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702151629130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11714622292110-git-send-email-mdl123@verizon.net>
 <11714622292295-git-send-email-mdl123@verizon.net>
 <Pine.LNX.4.63.0702142238310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45D398F9.6070205@verizon.net> <Pine.LNX.4.63.0702150054210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45D3C62D.6090609@verizon.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Thu Feb 15 16:55:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHiav-0006ZR-JF
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 16:32:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbXBOPcW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 10:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbXBOPcW
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 10:32:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:56955 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751642AbXBOPcW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 10:32:22 -0500
Received: (qmail invoked by alias); 15 Feb 2007 15:32:20 -0000
X-Provags-ID: V01U2FsdGVkX18D/Y5qs3sDHb7E8WQn8rR09kQqQeu8JXncGEFrQI
	HNqA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45D3C62D.6090609@verizon.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39831>

Hi,

On Wed, 14 Feb 2007, Mark Levedahl wrote:

> Johannes Schindelin wrote:
> > 
> > On Wed, 14 Feb 2007, Mark Levedahl wrote:
> > 
> > Ah, I just realized that you do not shift. This is wrong. For example,
> > 
> > 	git bundle --output=a1 a..b
> > 
> > would pass "--output=a1 a..b" to git-rev-parse. While you say "--revs-only",
> > this would work, but so would "these are no refs". You lose valuable
> > information that way (namely invalid parameters). The standard shell way is
> > nicely visible in git-tag.sh (see the while loop). It is basically
> > 
> > while case "$#" in 0) break ;; esac
> > do
> > 	case "$1" in
> > 	--output)
> > 		# handle $1 (and check that you can write to it).
> > 		;;
> > 	-*)
> > 		usage
> > 		;;
> > 	*)
> > 		break
> > 	esac
> > done
> 
> And that loop would always abort on things meant for git-rev-list. I 
> want to avoid making git-bundle have to understand everything that is 
> legal to git-rev-list. The current construct does this: it lets 
> git-rev-parse remove what that function knows, aborting if something is 
> amiss (or aborting later in git-rev-list), leaving git-bundle's parser 
> to chew on the rest.

Why not force unmixing? I.e. first the options for git-bundle, _then_ the 
rest? (In that case, you would leave out the "-*)" clause).

> > > Originally, this was in python with zip file built in memory (no 
> > > temporaries). Sticking to portable shell makes many easy things 
> > > really hard.
> > 
> > Not if you just pipe the two parts (refs & pack) into the output. 
> > Piping also allows for "--output -" meaning stdout...
> 
> git-unbundle uses no temporary files: it pipes directly from tar (was 
> zip, but I've changed to tar per Junio's request).

It does not have to be tar. There is no good reason that the parts you put 
into the bundle have to be files, rather than header and body.

Ciao,
Dscho
