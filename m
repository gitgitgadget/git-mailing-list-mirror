From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: thoughts on a possible "pre-upload" hook
Date: Tue, 22 Sep 2009 09:17:25 -0700
Message-ID: <20090922161725.GS14660@spearce.org>
References: <2e24e5b90909220320rbd5fd1l40c7898656445232@mail.gmail.com> <867hvr2cms.fsf@blue.stonehenge.com> <vpqd45jvub6.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 22 18:17:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mq83V-0000zi-1w
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 18:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756859AbZIVQRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 12:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756807AbZIVQRT
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 12:17:19 -0400
Received: from george.spearce.org ([209.20.77.23]:48960 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756790AbZIVQRT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 12:17:19 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 841A938151; Tue, 22 Sep 2009 16:17:25 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <vpqd45jvub6.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128947>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> >>>>>> "Sitaram" == Sitaram Chamarty <sitaramc@gmail.com> writes:
> > Sitaram> As git is used more and more in corporate-type environments, at some
> > Sitaram> point it becomes convenient to have *branches* (or more accurately,
> > Sitaram> refs) that are not readable.
> 
> But that alone would make it rather painfull for the user : "git
> clone" would fail if any branch in the repository is not readable, for
> example.

No, what Sitaram is asking for is to have upload-pack not advertise
the hidden branches.  By not advertising them, the client cannot
send a "want" request for them, and they won't appear in the list
that clone believes exists when it creates the new local repository.
Thus, clone would succeed.
 
> Also, don't forget that branches are just references, which means that
> if you prevent reference A from being uploaded, then another reference
> B may point to the same commits as A, and then you can bypass the
> safety hook on A by using B.

Yes.  But this is no different than having two different git
repositories, A.git and B.git.  Pushing commits from A.git into B.git
allows someone to bypass A.git's filesystem read access control by
instead reading those commits from B.git.

IOW, those who have access to the data must protect it.  You can't
do it entirely in software, especially when you don't control the
user's computer.

-- 
Shawn.
