From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: gitosis-lite
Date: Mon, 24 Aug 2009 08:10:51 -0700
Message-ID: <20090824151051.GB1033@spearce.org>
References: <2e24e5b90908240528v56fdf30cq4c046fca321a3b17@mail.gmail.com> <m3ab1pmk1c.fsf@localhost.localdomain> <2e24e5b90908240735n5f754c87u960493c92769c0a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Tommi Virtanen <tv@eagain.net>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 17:11:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfbCF-0007ME-9J
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 17:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487AbZHXPKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 11:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752243AbZHXPKu
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 11:10:50 -0400
Received: from george.spearce.org ([209.20.77.23]:35076 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbZHXPKt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 11:10:49 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A537B381FD; Mon, 24 Aug 2009 15:10:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <2e24e5b90908240735n5f754c87u960493c92769c0a8@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126938>

Sitaram Chamarty <sitaramc@gmail.com> wrote:
> On Mon, Aug 24, 2009 at 6:43 PM, Jakub Narebski<jnareb@gmail.com> wrote:
> > Why not contrib/hooks/update-paranoid (which is written in Perl)?
> 
> Hmmm several reasons.  To start with, it appears to me that
> update-paranoid assumes each user has his own ACL file, and
> I'm going the other way -- you'll notice I have exactly one
> file as a single ACL source for many *projects*, leave alone
> users.

That is true, update-paranoid uses an ACL file per user, because
we approached it from the perspective of "what can this user do"
rather than "what is allowed in this project".

We later ran into needing groups, which meant that in practice the
per-user ACL files really just enumerated what groups they were
a member of, and the group ACL files enumerated what they were
allowed to do in projects.

I can certainly see how this might be backwards, and someone would
prefer the other direction, a per-project listing or something.
 
> Secondly, I want to stick to the gitosis philosophy -- it
> has served very well, and I'm not sure how "in use"
> update-paranoid is.

Well, my prior job used it heavily, and I think is still using it,
a year after I left.  My current job would use it, except that we
went and wrote Gerrit Code Review instead.  :-)
 
> Thirdly, I'm not comfortable having a hook be so complex.
> The whole thing is 10 lines shorter than all my code put
> together :)

Yes, update-paranoid is a big script.  It does a lot.  It not only
checks "can you write in this repository, on this branch" but it
also checks that every commit matches your own email address(es),
and it can also check file path edits, to see if you can modify
the files that were changed.
 
> And finally, it's far too complex for me, leave alone some
> of my users.  I count 6 pipe opens in there,

Not surprised, it needs to read a lot of data from git to do its
job correctly.  It has to enumerate all new commits, any commits
which may be discarded by the update (non-fast-forward), as well
as scan the diff to see which paths were affected.

> and the ACLs
> are read by git cat-file or something

Because I didn't want to check out a copy of the ACLs to the local
disk just to read them into the hook.  The hook pulls them directly
out of a bare "admin" repository, making it easier to push changes
into the repository and have them take effect immediately.

I know Gitosis handles this by having a magic hook in the admin
repository that copies the file out.  update-paranoid just reads
it from git.

> I'll be honest: I
> came away feeling very stupid after trying to read and
> understand that program.  It was... humbling :(

*sigh* That's not good, the hook is meant as a practical example,
if it was too complex to understand, I did a poor job of writing it.
 
-- 
Shawn.
