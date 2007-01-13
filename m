From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] merge-recursive: do not report the resulting tree object name
Date: Fri, 12 Jan 2007 16:32:59 -0800
Message-ID: <7vbql3pxz8.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0701040247k47e398e6q34dd5233bb5706f6@mail.gmail.com>
	<Pine.LNX.4.63.0701041327490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<81b0412b0701040447u329dcf9bvcd7adb9e9d199f18@mail.gmail.com>
	<7v8xgileza.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0701050322u67131900xea969b2da9981a94@mail.gmail.com>
	<20070107163112.GA9336@steel.home>
	<7vr6u2adgx.fsf@assigned-by-dhcp.cox.net>
	<20070112184839.9431ddff.vsu@altlinux.ru>
	<7vr6u0t87q.fsf@assigned-by-dhcp.cox.net>
	<7v8xg8t3aj.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701130034000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 01:33:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5WpY-0004bH-Ls
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 01:33:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161141AbXAMAdB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 19:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030459AbXAMAdB
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 19:33:01 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:45234 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030331AbXAMAdA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 19:33:00 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070113003300.IGAC97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Fri, 12 Jan 2007 19:33:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id AQY81W00K1kojtg0000000; Fri, 12 Jan 2007 19:32:08 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701130034000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 13 Jan 2007 00:36:09 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36732>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I like this patch. merge-recursive is very talkative, to the intimidating 
> astonishment of unsuspecting users.

This is a smallish example:

        $ git merge jc/merge-base
     1	Trying really trivial in-index merge...
     2	fatal: Merge requires file-level merging
     3	Nope.
     4	Merging HEAD with jc/merge-base
     5	Merging:
     6	b60daf0 Make git-prune-packed a bit more chatty.
     7	5b75a55 Teach "git-merge-base --check-ancestry" about refs.
     8	found 1 common ancestor(s):
     9	1c23d79 Don't die in git-http-fetch when fetching packs.
    10	Auto-merging Makefile
    11	Auto-merging builtin-branch.c
    12	Auto-merging builtin-reflog.c
    13	CONFLICT (content): Merge conflict in builtin-reflog.c
    14	Auto-merging builtin.h
    15	Auto-merging git.c
    16	Removing merge-base.c
    17	Resolved 'builtin-reflog.c' using previous resolution.
    18	Automatic merge failed; fix conflicts and then commit the result.

Among these, I think lines 2..3 are somewhat confusing but I am
used to seeing them and do not mind them too much.

Lines 4..9 do not have any real information that helps the end
user (even though it would be a very good debugging aid for
merge-recursive developers).

Lines 10..16 are useful, but I think we probably should show
them only for outermost merges.

An multi-base example:

        $ git merge 82560983997c961d9deafe0074b787c8484c2e1d
     1	Merging HEAD with 82560983997c961d9deafe0074b787c8484c2e1d
     2	Merging:
     3	9ee93dc Merge for-each-ref to sync gitweb fully with 'next'...
     4	8256098 gitweb: Print commit message without title in commi...
     5	found 2 common ancestor(s):
     6	b2d3476 Gitweb - provide site headers and footers
     7	1259404 Merge branch 'maint'
     8	  Merging:
     9	  b2d3476 Gitweb - provide site headers and footers
    10	  1259404 Merge branch 'maint'
    11	  found 1 common ancestor(s):
    12	  128eead gitweb: document webserver configuration for comm...
    13	  Auto-merging Makefile
    14	  Auto-merging gitweb/gitweb.perl
    15	  CONFLICT (content): Merge conflict in gitweb/gitweb.perl
    16	Auto-merging gitweb/gitweb.perl
    17	Merge made by recursive.
    18	 gitweb/gitweb.css  |    2 +
    19	 gitweb/gitweb.perl |  165 ++++++++++++++++++++++++++++++++...
    20	 2 files changed, 117 insertions(+), 50 deletions(-)

I do not think we need to show 1..15 at all, perhaps without
"export GIT_MERGE_BASE_DEBUG=YesPlease".
