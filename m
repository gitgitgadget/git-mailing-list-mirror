From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Problems setting up bare repository (git 1.5.3.3)
Date: Mon, 1 Oct 2007 19:35:46 -0400
Message-ID: <20071001233546.GG2137@spearce.org>
References: <m3fy0u7bk3.fsf@barry_fishman.acm.org> <7vejgeqxd1.fsf@gitster.siamese.dyndns.org> <87bqbisae6.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Barry Fishman <barry_fishman@acm.org>, git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Tue Oct 02 01:36:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcUnv-0004NQ-PZ
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 01:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996AbXJAXfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 19:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751985AbXJAXfw
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 19:35:52 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53641 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbXJAXfv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 19:35:51 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IcUnf-0004ft-NM; Mon, 01 Oct 2007 19:35:43 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A100C20FBAE; Mon,  1 Oct 2007 19:35:46 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <87bqbisae6.wl%cworth@cworth.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59651>

Carl Worth <cworth@cworth.org> wrote:
> $ git push /pub/git/foo.git master
> 
> Is there any reason that that shouldn't be interpreted as
> "master:master" and that that would in turn be interpreted as "create
> a remote refs/heads/master" ?

This is actually read more as:

 1) Expand "master" to "refs/heads/master"
 2) Expand "refs/heads/master" to "refs/heads/master:refs/heads/master"

We first try to expand the local name to an "absolute" local name,
then if the remote name is missing default it to the same as the
(now expanded) local name.  So "push origin master" is not read as
"push origin refs/haeds/master:master".

> PS. As someone who has written some new-user documentation for git,
> there are a few low-level git notions that I would like to avoid in
> that documentation. For example, one is FETCH_HEAD. In my first
> attempt at porting hgbook-chapter2 to git I found myself using
> FETCH_HEAD to simulate "hg incoming". Thankfully, I was able to
> rewrite it by taking advantage of remotes and using "master..origin"
> instead.

How about:

  git config alias.incoming 'log ..FETCH_HEAD'

?  Or do we need --reverse in there too to simulate "hg incoming"?
The thing is, FETCH_HEAD is a lot more powerful than a tracking
branch.  It can contain objects randomly pulled from another
repository (e.g. one shot pulls).
 
> Another example is "refs/heads". I avoided this partially by inly
> documenting how to push all branches with "--all", but I'd much rather
> be able to say that the user could git push URL branch
> another-branch..." or "git push URL --all" for convenience. Finally,
> git-push itself spews quite a bit of output with "refs/heads" in it
> that I don't think is useful at all. For talking with the user, git
> should say "branch master" not "refs/heads/master".

Agreed.  We do that in fetch.  We should do that in push.  We should
only mention "refs/*" if the user is pushing something funny, e.g.
pushing into the remote tracking branch space.  Or the stash.  Etc.
Tags and normal branches should be denoted as such.

-- 
Shawn.
