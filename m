From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/6] tests: do not borrow from COPYING and README from the real source
Date: Sun, 15 Feb 2015 15:43:42 -0800
Message-ID: <1424043824-25242-5-git-send-email-gitster@pobox.com>
References: <1424043824-25242-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 00:44:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YN8r8-0006H3-BH
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 00:44:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755048AbbBOXoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2015 18:44:00 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57814 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754941AbbBOXn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2015 18:43:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 575DB39CF5;
	Sun, 15 Feb 2015 18:43:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=uGdI
	M23MnBcmUSruXP0yJ0l5HgQ=; b=NbVHYAvP9NQW/NKisWtpOER2o43hoKP4BMm6
	JCAa7ASzaeqaC05Yau0KBx2XP1WcLdMbqklZZ9lV6C7njpBsOIBaFWr0/fIGjajC
	TkIHrJHeLm5h6y3GSRX3vkj8AzdPbzmIV/1sjGrTRfRGEPL0Ui/aCiwBvKzsa3m3
	Mf1sdzo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=m705jq
	G2d6kbi+SUP/orzGGe/WUr08Ba9vMKiJ0rGtyam+jZh2gTykk/L5LZ2iYUi+Trc0
	XFBZwSW5EhqpgpcDcLUjrRuC8+XmpkqI8BqW/tFaOL2FzzsdXenoiPHqJj7XjpIt
	xaVspG7yetBtsA+O+YBNBg7wAmQP78OLbmCSs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E18839CF4;
	Sun, 15 Feb 2015 18:43:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D5B9B39CED;
	Sun, 15 Feb 2015 18:43:51 -0500 (EST)
X-Mailer: git-send-email 2.3.0-266-g5b48884
In-Reply-To: <1424043824-25242-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 7EF1E2D6-B56C-11E4-AF65-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263860>

These two files have been modified since the tests started using
as test input, making the exact object names they expect to be
different from what actually happens in the trash repository they
use to run tests.

Instead, take a snapshot of these two files and keep them in
t/diff-lib/ so that we can update the real ones without having to
worry about breaking tests.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/diff-lib/COPYING            | 361 ++++++++++++++++++++++++++++++++++++++++++
 t/diff-lib/README             |  46 ++++++
 t/t4003-diff-rename-1.sh      |   4 +-
 t/t4005-diff-rename-2.sh      |   4 +-
 t/t4007-rename-3.sh           |   2 +-
 t/t4008-diff-break-rewrite.sh |  38 ++---
 t/t4009-diff-rename-4.sh      |   4 +-
 7 files changed, 433 insertions(+), 26 deletions(-)
 create mode 100644 t/diff-lib/COPYING
 create mode 100644 t/diff-lib/README

diff --git a/t/diff-lib/COPYING b/t/diff-lib/COPYING
new file mode 100644
index 0000000..6ff87c4
--- /dev/null
+++ b/t/diff-lib/COPYING
@@ -0,0 +1,361 @@
+
+ Note that the only valid version of the GPL as far as this project
+ is concerned is _this_ particular version of the license (ie v2, not
+ v2.2 or v3.x or whatever), unless explicitly otherwise stated.
+
+ HOWEVER, in order to allow a migration to GPLv3 if that seems like
+ a good idea, I also ask that people involved with the project make
+ their preferences known. In particular, if you trust me to make that
+ decision, you might note so in your copyright message, ie something
+ like
+
+	This file is licensed under the GPL v2, or a later version
+	at the discretion of Linus.
+
+  might avoid issues. But we can also just decide to synchronize and
+  contact all copyright holders on record if/when the occasion arises.
+
+			Linus Torvalds
+
+----------------------------------------
+
+		    GNU GENERAL PUBLIC LICENSE
+		       Version 2, June 1991
+
+ Copyright (C) 1989, 1991 Free Software Foundation, Inc.
+                       59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ Everyone is permitted to copy and distribute verbatim copies
+ of this license document, but changing it is not allowed.
+
+			    Preamble
+
+  The licenses for most software are designed to take away your
+freedom to share and change it.  By contrast, the GNU General Public
+License is intended to guarantee your freedom to share and change free
+software--to make sure the software is free for all its users.  This
+General Public License applies to most of the Free Software
+Foundation's software and to any other program whose authors commit to
+using it.  (Some other Free Software Foundation software is covered by
+the GNU Library General Public License instead.)  You can apply it to
+your programs, too.
+
+  When we speak of free software, we are referring to freedom, not
+price.  Our General Public Licenses are designed to make sure that you
+have the freedom to distribute copies of free software (and charge for
+this service if you wish), that you receive source code or can get it
+if you want it, that you can change the software or use pieces of it
+in new free programs; and that you know you can do these things.
+
+  To protect your rights, we need to make restrictions that forbid
+anyone to deny you these rights or to ask you to surrender the rights.
+These restrictions translate to certain responsibilities for you if you
+distribute copies of the software, or if you modify it.
+
+  For example, if you distribute copies of such a program, whether
+gratis or for a fee, you must give the recipients all the rights that
+you have.  You must make sure that they, too, receive or can get the
+source code.  And you must show them these terms so they know their
+rights.
+
+  We protect your rights with two steps: (1) copyright the software, and
+(2) offer you this license which gives you legal permission to copy,
+distribute and/or modify the software.
+
+  Also, for each author's protection and ours, we want to make certain
+that everyone understands that there is no warranty for this free
+software.  If the software is modified by someone else and passed on, we
+want its recipients to know that what they have is not the original, so
+that any problems introduced by others will not reflect on the original
+authors' reputations.
+
+  Finally, any free program is threatened constantly by software
+patents.  We wish to avoid the danger that redistributors of a free
+program will individually obtain patent licenses, in effect making the
+program proprietary.  To prevent this, we have made it clear that any
+patent must be licensed for everyone's free use or not licensed at all.
+
+  The precise terms and conditions for copying, distribution and
+modification follow.
+
+		    GNU GENERAL PUBLIC LICENSE
+   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
+
+  0. This License applies to any program or other work which contains
+a notice placed by the copyright holder saying it may be distributed
+under the terms of this General Public License.  The "Program", below,
+refers to any such program or work, and a "work based on the Program"
+means either the Program or any derivative work under copyright law:
+that is to say, a work containing the Program or a portion of it,
+either verbatim or with modifications and/or translated into another
+language.  (Hereinafter, translation is included without limitation in
+the term "modification".)  Each licensee is addressed as "you".
+
+Activities other than copying, distribution and modification are not
+covered by this License; they are outside its scope.  The act of
+running the Program is not restricted, and the output from the Program
+is covered only if its contents constitute a work based on the
+Program (independent of having been made by running the Program).
+Whether that is true depends on what the Program does.
+
+  1. You may copy and distribute verbatim copies of the Program's
+source code as you receive it, in any medium, provided that you
+conspicuously and appropriately publish on each copy an appropriate
+copyright notice and disclaimer of warranty; keep intact all the
+notices that refer to this License and to the absence of any warranty;
+and give any other recipients of the Program a copy of this License
+along with the Program.
+
+You may charge a fee for the physical act of transferring a copy, and
+you may at your option offer warranty protection in exchange for a fee.
+
+  2. You may modify your copy or copies of the Program or any portion
+of it, thus forming a work based on the Program, and copy and
+distribute such modifications or work under the terms of Section 1
+above, provided that you also meet all of these conditions:
+
+    a) You must cause the modified files to carry prominent notices
+    stating that you changed the files and the date of any change.
+
+    b) You must cause any work that you distribute or publish, that in
+    whole or in part contains or is derived from the Program or any
+    part thereof, to be licensed as a whole at no charge to all third
+    parties under the terms of this License.
+
+    c) If the modified program normally reads commands interactively
+    when run, you must cause it, when started running for such
+    interactive use in the most ordinary way, to print or display an
+    announcement including an appropriate copyright notice and a
+    notice that there is no warranty (or else, saying that you provide
+    a warranty) and that users may redistribute the program under
+    these conditions, and telling the user how to view a copy of this
+    License.  (Exception: if the Program itself is interactive but
+    does not normally print such an announcement, your work based on
+    the Program is not required to print an announcement.)
+
+These requirements apply to the modified work as a whole.  If
+identifiable sections of that work are not derived from the Program,
+and can be reasonably considered independent and separate works in
+themselves, then this License, and its terms, do not apply to those
+sections when you distribute them as separate works.  But when you
+distribute the same sections as part of a whole which is a work based
+on the Program, the distribution of the whole must be on the terms of
+this License, whose permissions for other licensees extend to the
+entire whole, and thus to each and every part regardless of who wrote it.
+
+Thus, it is not the intent of this section to claim rights or contest
+your rights to work written entirely by you; rather, the intent is to
+exercise the right to control the distribution of derivative or
+collective works based on the Program.
+
+In addition, mere aggregation of another work not based on the Program
+with the Program (or with a work based on the Program) on a volume of
+a storage or distribution medium does not bring the other work under
+the scope of this License.
+
+  3. You may copy and distribute the Program (or a work based on it,
+under Section 2) in object code or executable form under the terms of
+Sections 1 and 2 above provided that you also do one of the following:
+
+    a) Accompany it with the complete corresponding machine-readable
+    source code, which must be distributed under the terms of Sections
+    1 and 2 above on a medium customarily used for software interchange; or,
+
+    b) Accompany it with a written offer, valid for at least three
+    years, to give any third party, for a charge no more than your
+    cost of physically performing source distribution, a complete
+    machine-readable copy of the corresponding source code, to be
+    distributed under the terms of Sections 1 and 2 above on a medium
+    customarily used for software interchange; or,
+
+    c) Accompany it with the information you received as to the offer
+    to distribute corresponding source code.  (This alternative is
+    allowed only for noncommercial distribution and only if you
+    received the program in object code or executable form with such
+    an offer, in accord with Subsection b above.)
+
+The source code for a work means the preferred form of the work for
+making modifications to it.  For an executable work, complete source
+code means all the source code for all modules it contains, plus any
+associated interface definition files, plus the scripts used to
+control compilation and installation of the executable.  However, as a
+special exception, the source code distributed need not include
+anything that is normally distributed (in either source or binary
+form) with the major components (compiler, kernel, and so on) of the
+operating system on which the executable runs, unless that component
+itself accompanies the executable.
+
+If distribution of executable or object code is made by offering
+access to copy from a designated place, then offering equivalent
+access to copy the source code from the same place counts as
+distribution of the source code, even though third parties are not
+compelled to copy the source along with the object code.
+
+  4. You may not copy, modify, sublicense, or distribute the Program
+except as expressly provided under this License.  Any attempt
+otherwise to copy, modify, sublicense or distribute the Program is
+void, and will automatically terminate your rights under this License.
+However, parties who have received copies, or rights, from you under
+this License will not have their licenses terminated so long as such
+parties remain in full compliance.
+
+  5. You are not required to accept this License, since you have not
+signed it.  However, nothing else grants you permission to modify or
+distribute the Program or its derivative works.  These actions are
+prohibited by law if you do not accept this License.  Therefore, by
+modifying or distributing the Program (or any work based on the
+Program), you indicate your acceptance of this License to do so, and
+all its terms and conditions for copying, distributing or modifying
+the Program or works based on it.
+
+  6. Each time you redistribute the Program (or any work based on the
+Program), the recipient automatically receives a license from the
+original licensor to copy, distribute or modify the Program subject to
+these terms and conditions.  You may not impose any further
+restrictions on the recipients' exercise of the rights granted herein.
+You are not responsible for enforcing compliance by third parties to
+this License.
+
+  7. If, as a consequence of a court judgment or allegation of patent
+infringement or for any other reason (not limited to patent issues),
+conditions are imposed on you (whether by court order, agreement or
+otherwise) that contradict the conditions of this License, they do not
+excuse you from the conditions of this License.  If you cannot
+distribute so as to satisfy simultaneously your obligations under this
+License and any other pertinent obligations, then as a consequence you
+may not distribute the Program at all.  For example, if a patent
+license would not permit royalty-free redistribution of the Program by
+all those who receive copies directly or indirectly through you, then
+the only way you could satisfy both it and this License would be to
+refrain entirely from distribution of the Program.
+
+If any portion of this section is held invalid or unenforceable under
+any particular circumstance, the balance of the section is intended to
+apply and the section as a whole is intended to apply in other
+circumstances.
+
+It is not the purpose of this section to induce you to infringe any
+patents or other property right claims or to contest validity of any
+such claims; this section has the sole purpose of protecting the
+integrity of the free software distribution system, which is
+implemented by public license practices.  Many people have made
+generous contributions to the wide range of software distributed
+through that system in reliance on consistent application of that
+system; it is up to the author/donor to decide if he or she is willing
+to distribute software through any other system and a licensee cannot
+impose that choice.
+
+This section is intended to make thoroughly clear what is believed to
+be a consequence of the rest of this License.
+
+  8. If the distribution and/or use of the Program is restricted in
+certain countries either by patents or by copyrighted interfaces, the
+original copyright holder who places the Program under this License
+may add an explicit geographical distribution limitation excluding
+those countries, so that distribution is permitted only in or among
+countries not thus excluded.  In such case, this License incorporates
+the limitation as if written in the body of this License.
+
+  9. The Free Software Foundation may publish revised and/or new versions
+of the General Public License from time to time.  Such new versions will
+be similar in spirit to the present version, but may differ in detail to
+address new problems or concerns.
+
+Each version is given a distinguishing version number.  If the Program
+specifies a version number of this License which applies to it and "any
+later version", you have the option of following the terms and conditions
+either of that version or of any later version published by the Free
+Software Foundation.  If the Program does not specify a version number of
+this License, you may choose any version ever published by the Free Software
+Foundation.
+
+  10. If you wish to incorporate parts of the Program into other free
+programs whose distribution conditions are different, write to the author
+to ask for permission.  For software which is copyrighted by the Free
+Software Foundation, write to the Free Software Foundation; we sometimes
+make exceptions for this.  Our decision will be guided by the two goals
+of preserving the free status of all derivatives of our free software and
+of promoting the sharing and reuse of software generally.
+
+			    NO WARRANTY
+
+  11. BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
+FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW.  EXCEPT WHEN
+OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
+PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED
+OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE ENTIRE RISK AS
+TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU.  SHOULD THE
+PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING,
+REPAIR OR CORRECTION.
+
+  12. IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
+WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
+REDISTRIBUTE THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES,
+INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING
+OUT OF THE USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED
+TO LOSS OF DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY
+YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER
+PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE
+POSSIBILITY OF SUCH DAMAGES.
+
+		     END OF TERMS AND CONDITIONS
+
+	    How to Apply These Terms to Your New Programs
+
+  If you develop a new program, and you want it to be of the greatest
+possible use to the public, the best way to achieve this is to make it
+free software which everyone can redistribute and change under these terms.
+
+  To do so, attach the following notices to the program.  It is safest
+to attach them to the start of each source file to most effectively
+convey the exclusion of warranty; and each file should have at least
+the "copyright" line and a pointer to where the full notice is found.
+
+    <one line to give the program's name and a brief idea of what it does.>
+    Copyright (C) <year>  <name of author>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+
+
+Also add information on how to contact you by electronic and paper mail.
+
+If the program is interactive, make it output a short notice like this
+when it starts in an interactive mode:
+
+    Gnomovision version 69, Copyright (C) year name of author
+    Gnomovision comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
+    This is free software, and you are welcome to redistribute it
+    under certain conditions; type `show c' for details.
+
+The hypothetical commands `show w' and `show c' should show the appropriate
+parts of the General Public License.  Of course, the commands you use may
+be called something other than `show w' and `show c'; they could even be
+mouse-clicks or menu items--whatever suits your program.
+
+You should also get your employer (if you work as a programmer) or your
+school, if any, to sign a "copyright disclaimer" for the program, if
+necessary.  Here is a sample; alter the names:
+
+  Yoyodyne, Inc., hereby disclaims all copyright interest in the program
+  `Gnomovision' (which makes passes at compilers) written by James Hacker.
+
+  <signature of Ty Coon>, 1 April 1989
+  Ty Coon, President of Vice
+
+This General Public License does not permit incorporating your program into
+proprietary programs.  If your program is a subroutine library, you may
+consider it more useful to permit linking proprietary applications with the
+library.  If this is what you want to do, use the GNU Library General
+Public License instead of this License.
diff --git a/t/diff-lib/README b/t/diff-lib/README
new file mode 100644
index 0000000..548142c
--- /dev/null
+++ b/t/diff-lib/README
@@ -0,0 +1,46 @@
+////////////////////////////////////////////////////////////////
+
+	GIT - the stupid content tracker
+
+////////////////////////////////////////////////////////////////
+
+"git" can mean anything, depending on your mood.
+
+ - random three-letter combination that is pronounceable, and not
+   actually used by any common UNIX command.  The fact that it is a
+   mispronunciation of "get" may or may not be relevant.
+ - stupid. contemptible and despicable. simple. Take your pick from the
+   dictionary of slang.
+ - "global information tracker": you're in a good mood, and it actually
+   works for you. Angels sing, and a light suddenly fills the room.
+ - "goddamn idiotic truckload of sh*t": when it breaks
+
+Git is a fast, scalable, distributed revision control system with an
+unusually rich command set that provides both high-level operations
+and full access to internals.
+
+Git is an Open Source project covered by the GNU General Public License.
+It was originally written by Linus Torvalds with help of a group of
+hackers around the net. It is currently maintained by Junio C Hamano.
+
+Please read the file INSTALL for installation instructions.
+See Documentation/tutorial.txt to get started, then see
+Documentation/everyday.txt for a useful minimum set of commands,
+and "man git-commandname" for documentation of each command.
+CVS users may also want to read Documentation/cvs-migration.txt.
+
+Many Git online resources are accessible from http://git.or.cz/
+including full documentation and Git related tools.
+
+The user discussion and development of Git take place on the Git
+mailing list -- everyone is welcome to post bug reports, feature
+requests, comments and patches to git@vger.kernel.org. To subscribe
+to the list, send an email with just "subscribe git" in the body to
+majordomo@vger.kernel.org. The mailing list archives are available at
+http://marc.theaimsgroup.com/?l=git and other archival sites.
+
+The messages titled "A note from the maintainer", "What's in
+git.git (stable)" and "What's cooking in git.git (topics)" and
+the discussion following them on the mailing list give a good
+reference for project status, development direction and
+remaining tasks.
diff --git a/t/t4003-diff-rename-1.sh b/t/t4003-diff-rename-1.sh
index bfa8835..df2accb 100755
--- a/t/t4003-diff-rename-1.sh
+++ b/t/t4003-diff-rename-1.sh
@@ -11,7 +11,7 @@ test_description='More rename detection
 
 test_expect_success \
     'prepare reference tree' \
-    'cat "$TEST_DIRECTORY"/../COPYING >COPYING &&
+    'cat "$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
      echo frotz >rezrov &&
     git update-index --add COPYING rezrov &&
     tree=$(git write-tree) &&
@@ -99,7 +99,7 @@ test_expect_success \
 
 test_expect_success \
     'prepare work tree once again' \
-    'cat "$TEST_DIRECTORY"/../COPYING >COPYING &&
+    'cat "$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
      git update-index --add --remove COPYING COPYING.1'
 
 # tree has COPYING and rezrov.  work tree has COPYING and COPYING.1,
diff --git a/t/t4005-diff-rename-2.sh b/t/t4005-diff-rename-2.sh
index 77d7f49..3b23dc4 100755
--- a/t/t4005-diff-rename-2.sh
+++ b/t/t4005-diff-rename-2.sh
@@ -11,7 +11,7 @@ test_description='Same rename detection as t4003 but testing diff-raw.
 
 test_expect_success \
     'prepare reference tree' \
-    'cat "$TEST_DIRECTORY"/../COPYING >COPYING &&
+    'cat "$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
      echo frotz >rezrov &&
     git update-index --add COPYING rezrov &&
     tree=$(git write-tree) &&
@@ -71,7 +71,7 @@ test_expect_success \
 
 test_expect_success \
     'prepare work tree once again' \
-    'cat "$TEST_DIRECTORY"/../COPYING >COPYING &&
+    'cat "$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
      git update-index --add --remove COPYING COPYING.1'
 
 git diff-index -C --find-copies-harder $tree >current
diff --git a/t/t4007-rename-3.sh b/t/t4007-rename-3.sh
index 11502b7..dae327f 100755
--- a/t/t4007-rename-3.sh
+++ b/t/t4007-rename-3.sh
@@ -11,7 +11,7 @@ test_description='Rename interaction with pathspec.
 
 test_expect_success 'prepare reference tree' '
 	mkdir path0 path1 &&
-	cp "$TEST_DIRECTORY"/../COPYING path0/COPYING &&
+	cp "$TEST_DIRECTORY"/diff-lib/COPYING path0/COPYING &&
 	git update-index --add path0/COPYING &&
 	tree=$(git write-tree) &&
 	echo $tree
diff --git a/t/t4008-diff-break-rewrite.sh b/t/t4008-diff-break-rewrite.sh
index a4e771b..718274f 100755
--- a/t/t4008-diff-break-rewrite.sh
+++ b/t/t4008-diff-break-rewrite.sh
@@ -26,8 +26,8 @@ Further, with -B and -M together, these should turn into two renames.
 
 test_expect_success \
     setup \
-    'cat "$TEST_DIRECTORY"/../README >file0 &&
-     cat "$TEST_DIRECTORY"/../COPYING >file1 &&
+    'cat "$TEST_DIRECTORY"/diff-lib/README >file0 &&
+     cat "$TEST_DIRECTORY"/diff-lib/COPYING >file1 &&
     git update-index --add file0 file1 &&
     tree=$(git write-tree) &&
     echo "$tree"'
@@ -43,8 +43,8 @@ test_expect_success \
     'git diff-index -B --cached "$tree" >current'
 
 cat >expected <<\EOF
-:100644 000000 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 0000000000000000000000000000000000000000 D	file0
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 11e331465a89c394dc25c780de230043750c1ec8 M100	file1
+:100644 000000 548142c327a6790ff8821d67c2ee1eff7a656b52 0000000000000000000000000000000000000000 D	file0
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 2fbedd0b5d4b8126e4750c3bee305e8ff79f80ec M100	file1
 EOF
 
 test_expect_success \
@@ -56,7 +56,7 @@ test_expect_success \
     'git diff-index -B -M "$tree" >current'
 
 cat >expected <<\EOF
-:100644 100644 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 08bb2fb671deff4c03a4d4a0a1315dff98d5732c R100	file0	file1
+:100644 100644 548142c327a6790ff8821d67c2ee1eff7a656b52 2fbedd0b5d4b8126e4750c3bee305e8ff79f80ec R100	file0	file1
 EOF
 
 test_expect_success \
@@ -78,8 +78,8 @@ test_expect_success \
     'git diff-index -B "$tree" >current'
 
 cat >expected <<\EOF
-:100644 100644 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 6ff87c4664981e4397625791c8ea3bbb5f2279a3 M100	file0
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 M100	file1
+:100644 100644 548142c327a6790ff8821d67c2ee1eff7a656b52 6ff87c4664981e4397625791c8ea3bbb5f2279a3 M100	file0
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 548142c327a6790ff8821d67c2ee1eff7a656b52 M100	file1
 EOF
 
 test_expect_success \
@@ -92,7 +92,7 @@ test_expect_success \
 
 cat >expected <<\EOF
 :100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 6ff87c4664981e4397625791c8ea3bbb5f2279a3 R100	file1	file0
-:100644 100644 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 R100	file0	file1
+:100644 100644 548142c327a6790ff8821d67c2ee1eff7a656b52 548142c327a6790ff8821d67c2ee1eff7a656b52 R100	file0	file1
 EOF
 
 test_expect_success \
@@ -110,8 +110,8 @@ test_expect_success \
     'git diff-index -B "$tree" >current'
 
 cat >expected <<\EOF
-:100644 120000 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 67be421f88824578857624f7b3dc75e99a8a1481 T	file0
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 M100	file1
+:100644 120000 548142c327a6790ff8821d67c2ee1eff7a656b52 67be421f88824578857624f7b3dc75e99a8a1481 T	file0
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 548142c327a6790ff8821d67c2ee1eff7a656b52 M100	file1
 EOF
 
 test_expect_success \
@@ -125,8 +125,8 @@ test_expect_success \
 # file0 changed from regular to symlink.  file1 is very close to the preimage of file0.
 # the change does not make file0 disappear, so file1 is denoted as a copy of file0
 cat >expected <<\EOF
-:100644 120000 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 67be421f88824578857624f7b3dc75e99a8a1481 T	file0
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 C	file0	file1
+:100644 120000 548142c327a6790ff8821d67c2ee1eff7a656b52 67be421f88824578857624f7b3dc75e99a8a1481 T	file0
+:100644 100644 548142c327a6790ff8821d67c2ee1eff7a656b52 548142c327a6790ff8821d67c2ee1eff7a656b52 C	file0	file1
 EOF
 
 test_expect_success \
@@ -140,8 +140,8 @@ test_expect_success \
 # This should not mistake file0 as the copy source of new file1
 # due to type differences.
 cat >expected <<\EOF
-:100644 120000 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 67be421f88824578857624f7b3dc75e99a8a1481 T	file0
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 M	file1
+:100644 120000 548142c327a6790ff8821d67c2ee1eff7a656b52 67be421f88824578857624f7b3dc75e99a8a1481 T	file0
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 548142c327a6790ff8821d67c2ee1eff7a656b52 M	file1
 EOF
 
 test_expect_success \
@@ -163,9 +163,9 @@ test_expect_success \
     'git diff-index -B "$tree" >current'
 
 cat >expected <<\EOF
-:100644 000000 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 0000000000000000000000000000000000000000 D	file0
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 08bb2fb671deff4c03a4d4a0a1315dff98d5732c M100	file1
-:000000 100644 0000000000000000000000000000000000000000 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 A	file2
+:100644 000000 548142c327a6790ff8821d67c2ee1eff7a656b52 0000000000000000000000000000000000000000 D	file0
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 2fbedd0b5d4b8126e4750c3bee305e8ff79f80ec M100	file1
+:000000 100644 0000000000000000000000000000000000000000 69a939f651686f56322566e2fd76715947a24162 A	file2
 EOF
 
 test_expect_success \
@@ -177,8 +177,8 @@ test_expect_success \
     'git diff-index -B -C "$tree" >current'
 
 cat >expected <<\EOF
-:100644 100644 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 08bb2fb671deff4c03a4d4a0a1315dff98d5732c C095	file0	file1
-:100644 100644 f5deac7be59e7eeab8657fd9ae706fd6a57daed2 59f832e5c8b3f7e486be15ad0cd3e95ba9af8998 R095	file0	file2
+:100644 100644 548142c327a6790ff8821d67c2ee1eff7a656b52 2fbedd0b5d4b8126e4750c3bee305e8ff79f80ec C095	file0	file1
+:100644 100644 548142c327a6790ff8821d67c2ee1eff7a656b52 69a939f651686f56322566e2fd76715947a24162 R095	file0	file2
 EOF
 
 test_expect_success \
diff --git a/t/t4009-diff-rename-4.sh b/t/t4009-diff-rename-4.sh
index f22c8e3..4b520d6 100755
--- a/t/t4009-diff-rename-4.sh
+++ b/t/t4009-diff-rename-4.sh
@@ -11,7 +11,7 @@ test_description='Same rename detection as t4003 but testing diff-raw -z.
 
 test_expect_success \
     'prepare reference tree' \
-    'cat "$TEST_DIRECTORY"/../COPYING >COPYING &&
+    'cat "$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
      echo frotz >rezrov &&
     git update-index --add COPYING rezrov &&
     tree=$(git write-tree) &&
@@ -78,7 +78,7 @@ test_expect_success \
 
 test_expect_success \
     'prepare work tree once again' \
-    'cat "$TEST_DIRECTORY"/../COPYING >COPYING &&
+    'cat "$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
      git update-index --add --remove COPYING COPYING.1'
 
 git diff-index -z -C --find-copies-harder $tree >current
-- 
2.3.0-266-g5b48884
