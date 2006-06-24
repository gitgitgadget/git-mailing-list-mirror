From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cvsimport - streamline temp index file creation and
 avoid creating empty tmpfiles
Date: Sat, 24 Jun 2006 11:50:09 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606241145280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0606231811200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <11511257501323-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sat Jun 24 11:50:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fu4mh-0007Ml-JO
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 11:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933374AbWFXJuM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 05:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933376AbWFXJuM
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 05:50:12 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:29101 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S933374AbWFXJuL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 05:50:11 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 47ED6288F;
	Sat, 24 Jun 2006 11:50:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 3C7B4288E;
	Sat, 24 Jun 2006 11:50:10 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 1AD9D288A;
	Sat, 24 Jun 2006 11:50:09 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Martin Langhoff <martin@catalyst.net.nz>
In-Reply-To: <11511257501323-git-send-email-martin@catalyst.net.nz>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22496>

Hi,

On Sat, 24 Jun 2006, Martin Langhoff wrote:

> On 6/24/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > It seems that git-cvsimport makes a temporary file of size 0, which cannot
> > get mmap()ed, because it has size 0.
> 
> This switch to tmpnam() avoids creating the tmpfile in the first place and
> streamlines the code. This handling of tmpfiles is slightly safer, but there
> is an inherent race condition.

Thank you. This fixes the error.

HOWEVER, it does not fix the main problem: when I try to git-cvsimport, 
there is no index for that branch yet, since I used to git-cvsimport with 
the old cvsimport.

Now, when cvsimport sees there is no index, it evidently assumes that the 
current state is an empty tree, which is *not* true.

The effect is: the first commit removes all files from the tree which were 
not touched by the cvs commit. Bad.

> This usage of tempfiles is open to a race condition

I would not care too strongly about that. Eventually, I really would like 
this file to reside in $GIT_DIR, not /tmp, but whatever. That is not my 
biggest concern right now. That I cannot update since June 18th, however, 
is.

Ciao,
Dscho
