From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH 3/3 v2] Make "git-remote rm" delete refs acccording to
	fetch specs
Date: Mon, 02 Jun 2008 12:10:25 -0500
Message-ID: <1212426625.3990.19.camel@ld0161-tx32>
References: <20080601042804.GA32293@spearce.org>
	 <7vprr1d8p2.fsf@gitster.siamese.dyndns.org>
	 <20080601063051.GH12896@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 02 19:12:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3DZP-0004dF-8A
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 19:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752845AbYFBRKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 13:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752822AbYFBRKu
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 13:10:50 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:56861 "EHLO
	de01egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbYFBRKt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 13:10:49 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id m52HARxO010765;
	Mon, 2 Jun 2008 10:10:27 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m52HAPCR012889;
	Mon, 2 Jun 2008 12:10:26 -0500 (CDT)
In-Reply-To: <20080601063051.GH12896@spearce.org>
X-Mailer: Evolution 2.0.2 (2.0.2-35.el4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83544>

On Sun, 2008-06-01 at 02:30 -0400, Shawn O. Pearce wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> > "Shawn O. Pearce" <spearce@spearce.org> writes:
> > 
> > >  This is a longer, but better version of this patch.  Instead of
> > >  blindly deleting the refs we remove them only if this is the last
> > >  remote that would write to the local tracking ref.
> > 
> > If this is a better version than the previous one, then probably "git
> > remote prune" patch to unconditionally remove ones that do not exist in
> > one of the remotes that fetch into the tracking namespace also needs to be
> > rethought, doesn't it?
> 
> Nope.  I've thought about this already.  ;-)
>  
> > Admittedly, next fetch from the other remote may or may not resurrect them
> > and either way it is not a big deal.
> 
> Correct.
> 
> > I think this is exactly the same issue as this improvement in [3/3] deals
> > with.  If "git remote rm" of one remote removed the shared tracked refs,
> > next fetch from the other remote would resurrect them if the other remote
> > still exists.  It may probably feel better to be extra careful like this
> > improved patch, but I doubt it would matter in practice.  After all,
> > people who creates such a configuration would know what they are doing.
> 
> I don't think it matters in practice.
> 
> If the user has configured two different remotes with different URLs
> fetching to the same set of tracking branches, well, they get what
> they get when their prune and fetch start fighting over a tracking
> branch existing or disappearing.
> 
> Today I found these misfeatures in git-remote because I sort of do
> what I showed in my second patch.  I have two remotes which fetch to
> the same tracking branches, as they fetch from the same repository,
> just over two different protocols.  There never should be a time
> where I can see a difference between them, unless its just a race
> condition where someone else created or deleted a branch between
> my two sequential git-fetch/git-remote calls.

This all seems sort of fragile to me.  Like maybe there
is a different name-space concept itching to get out here.
Like a [refspec "foo"] node in the config file or something
that clearly states the expected namespace for an remote.

> I think the behavior in 2/2 and 3/3v2 is the best we can do, short of
> contacting all other remotes which go to the same tracking branch.
> But that may not be possible.  One reason for using two different
> remote configurations to the same tracking branches is to make
> the URL differ.  Think fetching against repo.or.cz using git://
> and also http://, where http:// is necessary when you are stuck
> behind a @#U*!@(#*!@#*!@(@!! proxy server.  We cannot contact both
> remotes to verify the branch really is safe to prune.

Didn't we settle on an alternate URL mechanism that covered
this case already?  Or was that a different case/

CRS,
jdl
