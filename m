From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv4] Documentation: describe --thin more accurately
Date: Thu, 18 Feb 2010 01:10:28 -0800
Message-ID: <1266484228-25787-1-git-send-email-bebarino@gmail.com>
References: <1266262395-11864-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 18 10:10:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni2PE-00088I-Mv
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 10:10:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754126Ab0BRJKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 04:10:36 -0500
Received: from mail-pz0-f187.google.com ([209.85.222.187]:39895 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735Ab0BRJKd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 04:10:33 -0500
Received: by pzk17 with SMTP id 17so7404315pzk.4
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 01:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=LY017hqYkA0eRBHQcmAary5bJH216CEq6CccXSREIU4=;
        b=eSsT0e2O1XHRvYo4GRXVsYuZ5nYErCEExQuB0CIlUb5HsczWv7Tp4GvmwGUyMVsAIQ
         qlsfgNvDqjxI9CHBhgytsnh/p2p63X8grYqUCUcFDGbkLBbwNtjISyTAjU3UEkVgnBWu
         Mr+T3OwhBkIokwjkdhaW51RA6xvKJo3q1PJjk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=N0GeqxIis/nvLoqBuyiYmukoQOgPjBd3R+1P1ykWlPaOuUjZGD+P9Cpo6ee+dWR6zs
         mZgeX75s4Z38nO4R1DDg6UhsGvMoLPPRI3iiWf/5KCPZ5uYn7iPWiIVqyuGRlH2A8hG7
         cAAZQTfBD3DQ+DAmyU5fBWE4Wl4852r/trYNQ=
Received: by 10.143.21.25 with SMTP id y25mr2636281wfi.206.1266484230914;
        Thu, 18 Feb 2010 01:10:30 -0800 (PST)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 22sm9588175pzk.1.2010.02.18.01.10.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Feb 2010 01:10:30 -0800 (PST)
X-Mailer: git-send-email 1.7.0.17.g7e5eb
In-Reply-To: <1266262395-11864-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140306>

The description for --thin was misleading and downright wrong. Correct
it with some inspiration from the description of index-pack's --fix-thin
and some background information from Nicolas Pitre <nico@fluxnic.net>.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

Changes since v3:
 - More heavily reworked git-pack-objects.txt
 - git-index-pack.txt got inspiration from Junio in round 3

 Documentation/git-fetch-pack.txt   |    4 +-
 Documentation/git-index-pack.txt   |   12 +++-------
 Documentation/git-pack-objects.txt |   37 +++++++++++++++++++++++------------
 Documentation/git-push.txt         |    7 +++--
 Documentation/git-send-pack.txt    |    4 +-
 5 files changed, 36 insertions(+), 28 deletions(-)

diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index e9952e8..0ad94e3 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -44,8 +44,8 @@ OPTIONS
 	locked against repacking.
 
 --thin::
-	Spend extra cycles to minimize the number of objects to be sent.
-	Use it on slower connection.
+	Fetch a "thin" pack, which records objects in deltified form based
+	on objects not included in the pack to reduce network traffic.
 
 --include-tag::
 	If the remote side supports it, annotated tags objects will
diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 65a301b..f3ccc72 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -46,14 +46,10 @@ OPTIONS
 	'git repack'.
 
 --fix-thin::
-	It is possible for 'git pack-objects' to build
-	"thin" pack, which records objects in deltified form based on
-	objects not included in the pack to reduce network traffic.
-	Those objects are expected to be present on the receiving end
-	and they must be included in the pack for that pack to be self
-	contained and indexable. Without this option any attempt to
-	index a thin pack will fail. This option only makes sense in
-	conjunction with --stdin.
+	Fix a "thin" pack produced by `git pack-objects --thin` (see
+	linkgit:git-pack-objects[1] for details) by adding the
+	excluded objects the deltified objects are based on to the
+	pack. This option only makes sense in conjunction with --stdin.
 
 --keep::
 	Before moving the index into its final destination
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index ffd5025..1fe5a54 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -21,16 +21,21 @@ DESCRIPTION
 Reads list of objects from the standard input, and writes a packed
 archive with specified base-name, or to the standard output.
 
-A packed archive is an efficient way to transfer set of objects
-between two repositories, and also is an archival format which
-is efficient to access.  The packed archive format (.pack) is
-designed to be self contained so that it can be unpacked without
-any further information, but for fast, random access to the objects
-in the pack, a pack index file (.idx) will be generated.
-
-Placing both in the pack/ subdirectory of $GIT_OBJECT_DIRECTORY (or
+A packed archive is an efficient way to transfer a set of objects
+between two repositories as well as an access efficient archival
+format.  In a packed archive, an object is either stored as a
+compressed whole or as a difference from some other object.
+The latter is often called a delta.
+
+The packed archive format (.pack) is designed to be self-contained
+so that it can be unpacked without any further information. Therefore,
+each object that a delta depends upon must be present within the pack.
+
+A pack index file (.idx) is generated for fast, random access to the
+objects in the pack. Placing both the index file (.idx) and the packed
+archive (.pack) in the pack/ subdirectory of $GIT_OBJECT_DIRECTORY (or
 any of the directories on $GIT_ALTERNATE_OBJECT_DIRECTORIES)
-enables git to read from such an archive.
+enables git to read from the pack archive.
 
 The 'git unpack-objects' command can read the packed archive and
 expand the objects contained in the pack into "one-file
@@ -38,10 +43,6 @@ one-object" format; this is typically done by the smart-pull
 commands when a pack is created on-the-fly for efficient network
 transport by their peers.
 
-In a packed archive, an object is either stored as a compressed
-whole, or as a difference from some other object.  The latter is
-often called a delta.
-
 
 OPTIONS
 -------
@@ -179,6 +180,16 @@ base-name::
 	Add --no-reuse-object if you want to force a uniform compression
 	level on all data no matter the source.
 
+--thin::
+	Create a "thin" pack by omitting the common objects between a
+	sender and a receiver in order to reduce network transfer. This
+	option only makes sense in conjunction with --stdout.
++
+Note: A thin pack violates the packed archive format by omitting
+required objects and is thus unusable by git without making it
+self-contained. Use `git index-pack --fix-thin`
+(see linkgit:git-index-pack[1]) to restore the self-contained property.
+
 --delta-base-offset::
 	A packed archive can express base object of a delta as
 	either 20-byte object name or as an offset in the
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index bd79119..c86ad29 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -141,9 +141,10 @@ useful if you write an alias or script around 'git push'.
 
 --thin::
 --no-thin::
-	These options are passed to 'git send-pack'.  Thin
-	transfer spends extra cycles to minimize the number of
-	objects to be sent and meant to be used on slower connection.
+	These options are passed to linkgit:git-send-pack[1]. A thin transfer
+	significantly reduces the amount of sent data when the sender and
+	receiver share many of the same objects in common. The default is
+	\--thin.
 
 -v::
 --verbose::
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index 8178d92..deaa7d9 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -48,8 +48,8 @@ OPTIONS
 	Run verbosely.
 
 --thin::
-	Spend extra cycles to minimize the number of objects to be sent.
-	Use it on slower connection.
+	Send a "thin" pack, which records objects in deltified form based
+	on objects not included in the pack to reduce network traffic.
 
 <host>::
 	A remote host to house the repository.  When this
-- 
1.7.0.17.g7e5eb
