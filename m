From: Junio C Hamano <junkio@cox.net>
Subject: Re: Add a "git-describe" command
Date: Sun, 25 Dec 2005 01:44:10 -0800
Message-ID: <7vr781o6j9.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0512241339120.14098@g5.osdl.org>
	<7v4q4yq7f2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0512241939490.14098@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 25 10:44:18 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EqSQL-0000xQ-JI
	for gcvg-git@gmane.org; Sun, 25 Dec 2005 10:44:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbVLYJoN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Dec 2005 04:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbVLYJoN
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Dec 2005 04:44:13 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:23798 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750809AbVLYJoL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Dec 2005 04:44:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051225094226.TOP26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 25 Dec 2005 04:42:26 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512241939490.14098@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 24 Dec 2005 19:46:22 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14044>

Linus Torvalds <torvalds@osdl.org> writes:

> My real goal was to see a real meaningful version when I do "git 
> --version". I just hate how it normally just says it's version "1.0.GIT", 
> and I have no idea how new/old it really is.

Hmph.  I am not so interested in "git --version", but I find
git-describe to be pretty attractive.

Last night I proposed to tighten pack naming which would promote
so-far just a convention to a rule, which would introduce an
backward incompatibility and wanted to know which released
versions are affected.  With git-whatchanged I can identify the
exact commit that changed the packname SHA1 computation with
ease:

        $ git whatchanged --abbrev --pretty=oneline \
          -S'	sorted_by_sha = create_sorted_list(sha1_sort);
                SHA1_Init(&ctx);
                list = sorted_by_sha;
                for (i = 0; i < nr_objects; i++) {
        ' HEAD -- pack-objects.c
        diff-tree 84c8d8a... (from 9cf6d33...)
        Fix packname hash generation.
        :100644 100644 3d62278... ef55cab... M	pack-objects.c

and from that I would have been able to find that the change was
between 0.99.8 and 0.99.9:

        $ git describe 84c8d8a
        refs/tags/v0.99.8-g84c8d8ae

I used "git-show-branch $that_commit tags/v0.99.?" to get that
information instead, but git describe would have been very
useful.
