From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.5.3
Date: Mon, 03 Sep 2007 01:35:31 -0700
Message-ID: <7vfy1wm9ik.fsf@gitster.siamese.dyndns.org>
References: <7vodglr32i.fsf@gitster.siamese.dyndns.org>
	<46DA5F33.2020005@zytor.com> <85odgltrtj.fsf@lola.goethe.zz>
	<46DA88EF.7080103@zytor.com>
	<20070902133803.1b46f599.seanlkml@sympatico.ca>
	<7v4picpvgq.fsf@gitster.siamese.dyndns.org>
	<20070902191644.29d46cd2.seanlkml@sympatico.ca>
	<46DBBD00.5090308@zytor.com>
	<7vr6lgmao5.fsf@gitster.siamese.dyndns.org>
	<46DBC1EE.3020009@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, David Kastrup <dak@gnu.org>,
	git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 10:35:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS7PL-0003g3-5L
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 10:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164AbXICIfi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 04:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751939AbXICIfi
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 04:35:38 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:47293 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbXICIfh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 04:35:37 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id C284D12D862;
	Mon,  3 Sep 2007 04:35:54 -0400 (EDT)
In-Reply-To: <46DBC1EE.3020009@zytor.com> (H. Peter Anvin's message of "Mon,
	03 Sep 2007 09:12:30 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57446>

"H. Peter Anvin" <hpa@zytor.com> writes:

>> Ok, should I then do that single change, cut 1.5.3.1 with it and
>> ping you?
>
> Sounds good to me.

Thanks, and sorry for the trouble.  I am building one on k.org,
and after placing the result in the RPMS/x86-64 and running the
yummy script, I'll ping you again.  If it installs fine for you,
I'll boot my wife's machine to do i386 as well, but it is
getting a bit late now, so it might have to be tomorrow.

-- >8 -- snipsnap -- >8 -- clipcrap -- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Sun, 2 Sep 2007 15:16:44 -0700
Subject: [PATCH] GIT 1.5.3.1: obsolete git-p4 in RPM spec file.

HPA noticed that yum does not like the newer git RPM set; it turns out
that we do not ship git-p4 anymore but existing installations do not
realize the package is gone if we do not tell anything about it.

David Kastrup suggests using Obsoletes in the spec file of the new
RPM to replace the old package, so here is a try.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git.spec.in                        |    1 +
 Documentation/RelNotes-1.5.3.1.txt |   10 ++++++++++
 Documentation/git.txt              |    5 ++++-
 GIT-VERSION-GEN                    |    2 +-
 RelNotes                           |    2 +-
 5 files changed, 17 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/RelNotes-1.5.3.1.txt

diff --git a/git.spec.in b/git.spec.in
index fe7b3d8..bdb293d 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -25,6 +25,7 @@ This is a dummy package which brings in all subpackages.
 Summary:	Core git tools
 Group:		Development/Tools
 Requires:	zlib >= 1.2, rsync, curl, less, openssh-clients, expat
+Obsoletes:	git-p4
 %description core
 Git is a fast, scalable, distributed revision control system with an
 unusually rich command set that provides both high-level operations
diff --git a/Documentation/RelNotes-1.5.3.1.txt b/Documentation/RelNotes-1.5.3.1.txt
new file mode 100644
index 0000000..7ff546c
--- /dev/null
+++ b/Documentation/RelNotes-1.5.3.1.txt
@@ -0,0 +1,10 @@
+GIT v1.5.3.1 Release Notes
+==========================
+
+Fixes since v1.5.3
+------------------
+
+This is solely to fix the generated RPM's dependencies.  We used
+to have git-p4 package but we do not anymore.  As suggested on
+the mailing list, this release makes git-core "Obsolete" git-p4,
+so that yum update would not complain.
diff --git a/Documentation/git.txt b/Documentation/git.txt
index ceca892..6f7db29 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -43,7 +43,10 @@ unreleased) version of git, that is available from 'master'
 branch of the `git.git` repository.
 Documentation for older releases are available here:
 
-* link:v1.5.2.5/git.html[documentation for release 1.5.2.5]
+* link:v1.5.3/git.html[documentation for release 1.5.3]
+
+* release notes for
+  link:RelNotes-1.5.3.1.txt[1.5.3.1].
 
 * release notes for
   link:RelNotes-1.5.2.5.txt[1.5.2.5],
diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 3c0032c..3835fb3 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 GVF=GIT-VERSION-FILE
-DEF_VER=v1.5.3.GIT
+DEF_VER=v1.5.3.1.GIT
 
 LF='
 '
diff --git a/RelNotes b/RelNotes
index 0de5e66..ea8f800 120000
--- a/RelNotes
+++ b/RelNotes
@@ -1 +1 @@
-Documentation/RelNotes-1.5.3.txt
\ No newline at end of file
+Documentation/RelNotes-1.5.3.1.txt
\ No newline at end of file
-- 
1.5.3
