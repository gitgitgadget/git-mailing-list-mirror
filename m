From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH 4/4] Disallow working directory commands in a bare repository.
Date: Sun, 31 Dec 2006 00:01:01 -0800
Message-ID: <7vk608fq9u.fsf@assigned-by-dhcp.cox.net>
References: <3ffc8ddd9b500c2a34d2bd6ba147dc750d951bcd.1167539318.git.spearce@spearce.org>
	<20061231043238.GD5823@spearce.org>
	<7virfsk4sd.fsf@assigned-by-dhcp.cox.net>
	<20061231061122.GB6106@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 09:01:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0vd8-00050y-5E
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 09:01:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933089AbWLaIBF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 03:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933087AbWLaIBF
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 03:01:05 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:35179 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933089AbWLaIBD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 03:01:03 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061231080102.QADY25875.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Sun, 31 Dec 2006 03:01:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5L0G1W00B1kojtg0000000; Sun, 31 Dec 2006 03:00:17 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20061231061122.GB6106@spearce.org> (Shawn O. Pearce's message of
	"Sun, 31 Dec 2006 01:11:22 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35686>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Agreed.  But as you point out...
>  
>> If we could outlaw $GIT_DIR/index in a bare repository, then
>> ...
>> Alas, many public repositories you would see (e.g. check
>> kernel.org) have been primed with rsync of .git/ from
>> developer's working repository and have leftover index that is
>> otherwise unused.  Because of this heavy historical baggage, I
>> suspect that it is rather hard to convince people to allow us to
>> use this technique.
>
> I almost coded the require_not_bare() to look for $GIT_DIR/index
> but didn't for the reasons you point out above.  It is too bad that
> we didn't enforce the existance of the index file better in the past.

This, and this,...

>> ...
>> If we outlawed working-tree commands when $GIT_DIR environment
>> exists, how much hurt are we talking about, I wonder.
>
> I wouldn't be hurt, but I don't call Porcelain-ish unless I'm
> entering commands directly on the command line, and I never set
> GIT_DIR except in scripts, and even then its very rare and is more
> to point at a bare repository than one with a working directory.
> I suspect that probably isn't true for everyone.
> ...
> Why not just tell these users to setup the working directories with
> local .git directories and not use GIT_DIR?

suggest that we might want to bite the bullet and declare that
these things are not supported anymore in v1.5.0.

So far, especially after fixing the i18n issue in response to
qgit problem report, I do not think we have any serious backward
incompatibility that the users cannot opt out of that we need to
mention in v1.5.0 announcement.  Even not the incompatibilities
the 'old news' section talks about are.

I think an index file in a bare repository is not what the user
wanted to have because it was useful, but is left there because
it does not hurt.  So in that sense, I do not think we need to
ask users' permission to do this change, as long as we make sure
we give them enough advance warning.

I do not offhand think of a valid workflow that relies on
setting GIT_DIR in the environment and being able to run
working-tree commands, that cannot be worked around if we declar
that GIT_DIR is for our internal use (and no, naming the
directory other people call .git to .svn does not count as a
valid workflow), but I think this may be a bit more serious
change than the index file one.

Comments?
