From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: libxdiff and patience diff
Date: Tue, 4 Nov 2008 16:57:44 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811041650510.24407@pacific.mpi-cbg.de>
References: <20081104004001.GB29458@artemis.corp> <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de> <20081104083042.GB3788@artemis.corp> <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: davidel@xmailserver.org, Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Nov 04 16:51:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxOBv-0003rD-Lf
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 16:51:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753684AbYKDPuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 10:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753683AbYKDPuY
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 10:50:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:37976 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753630AbYKDPuY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 10:50:24 -0500
Received: (qmail invoked by alias); 04 Nov 2008 15:50:22 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp012) with SMTP; 04 Nov 2008 16:50:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+aBo9dtVaasuOBsqE0szP27mRdu+INImSFBXtLYv
	gZycUTU9Zi4uD8
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20081104152351.GA21842@artemis.corp>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100083>

Hi,

On Tue, 4 Nov 2008, Pierre Habouzit wrote:

> The nasty thing about the patience diff is that it still needs the usual
> diff algorithm once it has split the file into chunks separated by
> "unique lines".

Actually, it should try to apply patience diff again in those chunks, 
separately.

> So you cannot make really independant stuff. What I could do is put most 
> of the xpatience diff into xpatience.c but it would still have to use 
> some functions from xdiffi.c that are currently private, so it messes 
> somehow the files more than it's worth IMHO.

I think it is better that you use the stuff from xdiffi.c through a well 
defined interface, i.e. _not_ mess up the code by mingling it together 
with the code in xdiffi.c.  The code is hard enough to read already.

Oh, BTW, "ha" is a hash of the lines which is used to make the line 
matching more performant.  You will see a lot of "ha" comparisons before 
actually calling xdl_recmatch() for that reason.  Incidentally, this is 
also the hash that I'd use for the hash multi-set I was referring to.

Oh, and I am not sure that it is worth your time trying to get it to run 
with the linear list, since you cannot reuse that code afterwards, and 
have to spend the same amount of time to redo it with the hash set.

I am awfully short on time, so it will take some days until I can review 
what you have already, unfortunately.

Ciao,
Dscho
