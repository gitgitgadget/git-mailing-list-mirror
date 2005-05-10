From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFD] Overlapping projects
Date: Mon, 09 May 2005 22:31:39 -0700
Message-ID: <7v8y2nsl38.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0505100040320.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 07:24:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVNEV-0004Ud-Hk
	for gcvg-git@gmane.org; Tue, 10 May 2005 07:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVEJFbx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 01:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbVEJFbx
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 01:31:53 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:65231 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261563AbVEJFbn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 01:31:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050510053138.EGOK12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 10 May 2005 01:31:38 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0505100040320.30848-100000@iabervon.org> (Daniel
 Barkalow's message of "Tue, 10 May 2005 00:56:33 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:

DB> It seems to me like projects like cogito which are based on a core which
DB> is itself a project and which is also part of other projects would benefit
DB> from some sort of support.

I personally feel supporting that kind of development directory
structure is backwards, and Cogito is a very bad example for it.

Things could have been structured in such a way to have Cogito
and core GIT in separate directories hanging from the top level,
and Cogito can borrow pieces of GIT from the neighboring
directory if it needed to build specialized binary using
libgit.a.  Unless Petr makes changes to core GIT that is _too_
specific for general use (read: does not meet Linus' taste), we
should be able to port the nicer changes made to the core GIT
for Cogito's use (like git-ls-files "-t" flag) back to core GIT
and there would not be a reason for Cogito to keep carrying its
own copy of modified core GIT.

DB> In particular, it would be nice if Linus could pull the
DB> changes to the core without getting the wrapper programs at
DB> all.

Yes, that is a very desirable arrangement.

However, that does not require to keep them in the same
repository.  Cogito _could_ have been shipped this way:

                      + (top-level)
                     / \
                    cg git
     (Cogito sources)   (copy of core GIT files)
     .git/ for Cogito   .git/ for core GIT
     only

with an instruction like:

    The tarball contains cg and git subdirectories.  cg part
    implements Cogito, and git part is a copy of recent if not
    latest core GIT.  Go to cg and type "make" to build both of
    them.  Theoretically they can be independently updated to
    the latest but preferred combination is to use at least this
    release of core GIT to use this version of Cogito ...

Maybe I am being too idealistic.  I do not deny there are people
who want to manage "projects within projects" structure and
other people like CVS, subversion and arch do support that
style.  My impression about them is that the way CVS does it via
CVSROOT/modules looked like an ugly hack bolted onto it as an
afterthought, external stuff subversion uses did not feel quite
right (although nicer than what CVS does), and what arch does
was more reasonable but the boundary between SCM and build
environment was quite blurry there.  And many people "wanting to
do so" and other people "supporting doing it" do not necessarily
make that right.

