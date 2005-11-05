From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: Re: GIT 0.99.9c
Date: Sat, 05 Nov 2005 15:00:08 +0100
Message-ID: <87irv7urdj.fsf@gmail.com>
References: <7vwtjp2h59.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Nov 05 15:00:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYOZb-0002kb-Tb
	for gcvg-git@gmane.org; Sat, 05 Nov 2005 14:59:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbVKEN7J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Nov 2005 08:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbVKEN7I
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Nov 2005 08:59:08 -0500
Received: from ifae-s0.ifae.es ([192.101.162.68]:57775 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S932070AbVKEN7H (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Nov 2005 08:59:07 -0500
Received: from bela (l9.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id jA5Dx3B20097
	for <git@vger.kernel.org>; Sat, 5 Nov 2005 14:59:03 +0100
To: git@vger.kernel.org
In-Reply-To: <7vwtjp2h59.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 03 Nov 2005 20:04:02 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11178>

Junio C Hamano <junkio@cox.net> writes:

>  And I would appreciate somebody who actually uses svnimport to Ack on
> Yaacov's svnimport fix.

Let's try to make a good report :)

Situation:

an svn repo created with cvs2svn, and used with svk so it has
the property svk:merge to say explicity the extra parents of a commit.

svn log -r 1:2 -v file:///repo/susy/
------------------------------------------------------------------------
r1 | (no author) | 2003-10-29 16:49:04 +0100 (Wed, 29 Oct 2003) | 1 line
Changed paths:
   A /branches
   A /tags
   A /trunk

New repository initialized by cvs2svn.
------------------------------------------------------------------------
r2 | guasch | 2003-10-29 16:49:04 +0100 (Wed, 29 Oct 2003) | 2 lines
Changed paths:
   A /trunk/includes
   A /trunk/includes/gamma_gg.F

Initial revision

------------------------------------------------------------------------

git-svnimport orig:

bela $ git-svnimport -v file:///repo/susy/
1: Unrecognized path: /branches
1: Unrecognized path: /tags
Tree ID 4b825dc642cb6eb9a060e54bf8d69288fbee4904
Committing initial tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
Committed change 1:/ 2003-10-29 15:49:04)
Commit ID caff0f3ee5bc540a264f615b000fcbd7b355586a
Writing to refs/heads/origin
DONE: 1 origin caff0f3ee5bc540a264f615b000fcbd7b355586a
... 2 /trunk/includes ...
Name does not refer to a filesystem file: Attempted to get textual contents of a *non*-file node at /home/santi/usr/bin/git-svnimport line 115
bela $ git-cat-file tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
bela $ 

and the same error for the commit r2 with "-s 2". I suppose that it
tries to chechkout the includes dir.

git-svnimport new:

I've used the one in the message
"[PATCH] Several fixes to import mono's svn tree"

bela $ git-svnimport -v file:///repo/susy/
Tree ID 4b825dc642cb6eb9a060e54bf8d69288fbee4904
Committing initial tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
Committed change 1:/ 2003-10-29 15:49:04)
Commit ID caff0f3ee5bc540a264f615b000fcbd7b355586a
Writing to refs/heads/origin
DONE: 1 origin caff0f3ee5bc540a264f615b000fcbd7b355586a
... 2 /trunk/includes/gamma_gg.F ...
Tree ID b7ea8a91831deea3a6015a17f8843be4833255bc
Merge parent branch: caff0f3ee5bc540a264f615b000fcbd7b355586a
Committed change 2:/ 2003-10-29 15:49:04)
Commit ID 6dc8146789badce6368705f9317e7f65f4526f6b
Writing to refs/heads/origin
DONE: 2 origin 6dc8146789badce6368705f9317e7f65f4526f6b

[...]

DONE: 154 SinCosAlpha 657abeb912a00d6fad9fcd4436490d81b4002bcb
Switching from 657abeb912a00d6fad9fcd4436490d81b4002bcb to 760501ff6986134eaf0ee34484af1e38e7f8b8b0 (/)
perl: /home/devel/release/subversion-1.2.3dfsg1/subversion/libsvn_subr/path.c:115: svn_path_join: Assertion `is_canonical (component, clen)' failed.
Aborted

So it worked till the revision 154. But the revision 155 is:

bela $ svn log -r 155 file:///repo/susy/
------------------------------------------------------------------------
r155 | guasch | 2005-02-25 11:19:38 +0100 (Fri, 25 Feb 2005) | 14 lines
Changed paths:
   M /
   M /trunk
   M /trunk/includes/pp.f
   A /trunk/includes/subh.F

 r157@jgi:  guasch | 2005-02-25 11:19:23 +0100
  r156@jgi:  guasch | 2005-02-25 11:17:06 +0100
  Create local branch of SVN mirror

*** Merge branch SinCosAlpha. Revisions 152:154

bela $ svn diff -r 154:155 file:///repo/susy/

[...]

Property changes on: trunk
___________________________________________________________________
Name: svk:merge
   + e2421932-edf0-0310-b7cb-9d7cda74567f:/local/branches/SinCosAlpha:156


Property changes on: .
___________________________________________________________________
Name: svk:merge
   + e2421932-edf0-0310-b7cb-9d7cda74567f:/local:157

bela $ 

This is the first revision that changes the properties of / and
/trunk, and it does not handle this situation.

A usefull thing would be if it could use this information to create a
merge commit. So it could check if this information is from the
repository we are importing, and fallback to the heuristic one if it
fails. (In the case above the "e242..." UUID is from another svn
repository).

If I do it by hand, the I get the following:
156: Unrecognized path: /Xsecfile
157: Unrecognized path: /Xsecfile/bo_Hqqp/hqqpinterface_sqcd_maximize_SSB_bsg_runningmass_prod.F
157: Unrecognized path: /Xsecfile/includes/pphtt.f
157: Unrecognized path: /Xsecfile/includes/dsig_htt.F
158: Unrecognized path: /Xsecfile/includes/dsig_htt.F
perl: /home/devel/release/subversion-1.2.3dfsg1/subversion/libsvn_subr/path.c:115: svn_path_join: Assertion `is_canonical (component, clen)' failed.
Aborted

The r159 changes the properties of /trunk too. The other thing is that
finds an "Unrecognized path" (that is logical), but I have not find any
way to tell "OK, it's my fault, but treat this as branch Xsecfile".

Hope it's usefull.


     Santi
