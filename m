From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv3] Documentation: describe --thin more accurately
Date: Mon, 15 Feb 2010 11:33:15 -0800
Message-ID: <1266262395-11864-1-git-send-email-bebarino@gmail.com>
References: <1265961646-28585-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 20:33:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nh6hP-00066B-Jx
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 20:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756231Ab0BOTdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 14:33:21 -0500
Received: from mail-qy0-f200.google.com ([209.85.221.200]:50672 "EHLO
	mail-qy0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756227Ab0BOTdU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 14:33:20 -0500
Received: by qyk38 with SMTP id 38so615360qyk.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2010 11:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ROF6sfF++wha5aCQiyFf0bMI9Hv7ghnCfFGEqhxetJs=;
        b=GqU/3P9RIvBMvZCOr7B9+HDk2zADDdJ4eyhWHTfftA4w/p7V4VlxGR5AW7Vzo5rlTm
         2QS8owDSljJIHblspcqJrnXQ2PWc+KK+Kmg7S1vSf0d5ECKOpM2s7KqS5DMZFoeuw0Wc
         2UPVIxpBCYAVqdhgBeLqBzd5gOPSm0295RSeM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TEoCsLn+20AwK3RpwtW6ntmPK0dGk0GNQfc/C6E1YP1LzlRj+XgyXJLcdCmXHnrawD
         qdukTgDKY/K6hX0yrpPwtR/ZMjwY+cK8hUGS/tmo3J8SwCzowXEjrYJF4cBQqkkWhy4w
         9iVY+u61vKmAkrOEPz4+f/YJSsUOCplpdO49I=
Received: by 10.220.124.5 with SMTP id s5mr125617vcr.217.1266262399033;
        Mon, 15 Feb 2010 11:33:19 -0800 (PST)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 6sm2544356ywd.52.2010.02.15.11.33.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Feb 2010 11:33:18 -0800 (PST)
X-Mailer: git-send-email 1.7.0.17.g7e5eb
In-Reply-To: <1265961646-28585-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140024>

The description for --thin was misleading and downright wrong. Correct
it with some inspiration from the description of index-pack's --fix-thin
and some background information from Nicolas Pitre <nico@fluxnic.net>.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

Changes since v2:
 - Address Junio's comments

 Documentation/git-fetch-pack.txt   |    4 ++--
 Documentation/git-index-pack.txt   |   11 ++++++-----
 Documentation/git-pack-objects.txt |    9 +++++++++
 Documentation/git-push.txt         |    7 ++++---
 Documentation/git-send-pack.txt    |    4 ++--
 5 files changed, 23 insertions(+), 12 deletions(-)

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
index 65a301b..b4fa98e 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -46,14 +46,15 @@ OPTIONS
 	'git repack'.
 
 --fix-thin::
-	It is possible for 'git pack-objects' to build
+	It's possible for 'git pack-objects' to build a
 	"thin" pack, which records objects in deltified form based on
 	objects not included in the pack to reduce network traffic.
-	Those objects are expected to be present on the receiving end
+	The excluded objects are expected to be present on the receiving end
 	and they must be included in the pack for that pack to be self
-	contained and indexable. Without this option any attempt to
-	index a thin pack will fail. This option only makes sense in
-	conjunction with --stdin.
+	contained and indexable. This option fixes the "thin" pack by
+	adding the missing objects to the pack. Without this option any
+	attempt to index a "thin" pack will fail. This option only makes
+	sense in conjunction with --stdin.
 
 --keep::
 	Before moving the index into its final destination
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index ffd5025..fd9181a 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -179,6 +179,15 @@ base-name::
 	Add --no-reuse-object if you want to force a uniform compression
 	level on all data no matter the source.
 
+--thin::
+	Create a "thin" pack, which records objects in deltified form based
+	on objects not included in the pack to reduce network traffic.
+	The excluded objects are expected to be present on the receiving end
+	and eventually must be included in the pack for that pack to be self
+	contained and indexable (see the \--fix-thin option of
+	linkgit:git-index-pack[1] for more details). This option only makes
+	sense in conjunction with --stdout.
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
