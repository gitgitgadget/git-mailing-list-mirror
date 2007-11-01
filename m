From: shd@jolt.modeemi.cs.tut.fi (Heikki Orsila)
Subject: [PATCH] Make git-clone obey "--" (end argument parsing)
Date: Thu,  1 Nov 2007 21:54:18 +0200 (EET)
Message-ID: <20071101195418.607DA4F95F@jolt.modeemi.cs.tut.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 01 20:54:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ing7e-0006J5-Ad
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 20:54:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758817AbXKATyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 15:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758769AbXKATyW
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 15:54:22 -0400
Received: from mail.cs.tut.fi ([130.230.4.42]:63433 "EHLO mail.cs.tut.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758697AbXKATyV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 15:54:21 -0400
Received: from amavis1.cs.tut.fi (amavis1.cs.tut.fi [130.230.4.69])
	by mail.cs.tut.fi (Postfix) with ESMTP id 4DD2912514
	for <git@vger.kernel.org>; Thu,  1 Nov 2007 21:54:19 +0200 (EET)
Received: from mail.cs.tut.fi ([130.230.4.42])
 by amavis1.cs.tut.fi (amavis1.cs.tut.fi [130.230.4.69]) (amavisd-maia, port 10024)
 with ESMTP id 08688-08-5 for <git@vger.kernel.org>;
 Thu,  1 Nov 2007 21:54:18 +0200 (EET)
Received: from modeemi.modeemi.cs.tut.fi (modeemi.modeemi.cs.tut.fi [130.230.72.134])
	by mail.cs.tut.fi (Postfix) with ESMTP id D8A1312511
	for <git@vger.kernel.org>; Thu,  1 Nov 2007 21:54:18 +0200 (EET)
Received: from jolt.modeemi.cs.tut.fi (jolt.modeemi.cs.tut.fi [130.230.72.144])
	by modeemi.modeemi.cs.tut.fi (Postfix) with ESMTP id 9C5E54E34B
	for <git@vger.kernel.org>; Thu,  1 Nov 2007 21:54:18 +0200 (EET)
Received: by jolt.modeemi.cs.tut.fi (Postfix, from userid 16311)
	id 607DA4F95F; Thu,  1 Nov 2007 21:54:18 +0200 (EET)
X-Virus-Scanned: Maia Mailguard 1.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62986>

Oops. Reposting the patch.

This patch handles "--" argument for git-clone.

Signed-off-by: Heikki Orsila <heikki.orsila@iki.fi>

>From bd2d661c565062eacc80dda90f3978303308f9bb Mon Sep 17 00:00:00 2001
From: Heikki Orsila <heikki.orsila@iki.fi>
Date: Thu, 1 Nov 2007 16:21:39 +0200
Subject: [PATCH] Make git-clone obey "--" (end argument parsing)

---
 Documentation/git-clone.txt |    2 +-
 git-clone.sh                |    5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 253f4f0..7fdcd42 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git-clone' [--template=<template_directory>]
 	  [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare]
 	  [-o <name>] [-u <upload-pack>] [--reference <repository>]
-	  [--depth <depth>] <repository> [<directory>]
+	  [--depth <depth>] [--] <repository> [<directory>]
 
 DESCRIPTION
 -----------
diff --git a/git-clone.sh b/git-clone.sh
index 0ea3c24..3f00693 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -14,7 +14,7 @@ die() {
 }
 
 usage() {
-	die "Usage: $0 [--template=<template_directory>] [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [--origin <name>] [--depth <n>] [-n] <repo> [<dir>]"
+	die "Usage: $0 [--template=<template_directory>] [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [--origin <name>] [--depth <n>] [-n] [--] <repo> [<dir>]"
 }
 
 get_repo_base() {
@@ -160,6 +160,9 @@ while
 	*,--depth)
 		shift
 		depth="--depth=$1";;
+	*,--)
+		shift
+		break ;;
 	*,-*) usage ;;
 	*) break ;;
 	esac
-- 
1.5.3.4.498.g9c514-dirty
