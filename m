From: Heikki Hokkanen <hoxu@users.sf.net>
Subject: [PATCH] git show-ref: add --remotes option.
Date: Mon, 13 Oct 2008 22:23:47 +0300
Message-ID: <48F3A043.5070406@users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 13 21:25:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpT2T-0001K5-H9
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 21:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757374AbYJMTXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 15:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757212AbYJMTXz
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 15:23:55 -0400
Received: from gv-out-0910.google.com ([216.239.58.186]:35763 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756829AbYJMTXy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 15:23:54 -0400
Received: by gv-out-0910.google.com with SMTP id e6so394683gvc.37
        for <git@vger.kernel.org>; Mon, 13 Oct 2008 12:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding:sender;
        bh=ZUbYTqWbGEqI1wkDh0/7VJjJOZPgpMGoxPtDs6p8S3k=;
        b=FUqALZETRa2BZsizaWlXhbVK3ffs0ALYv0Ug4HyLohcAr90W59yenED/MIlk52YtoM
         3/yTCtqPW+4xKbo/s3GtxH7cdXGV6jI83khqswtO1CqIXE2K6fVw4B/2EjugIXG17RWe
         snHDyJRvRJbuyqL672KdKt1PAKDw43TIucs0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding:sender;
        b=auMrc+//KOtZxnxq4+GyN6MS4IOd7eTXm+S+a3lDoUxnSo8ywNB+mwV4mF59P2unBQ
         oXEG2gkytpUIwEjkW+xoFkVbWINdQF2zXhfqMmPslC4M1uIBRphUAZ9OqA7zEpyEw/9Q
         RrP4mEJQ9ouxLTUKQF4fHfzorRFIWZ0Vr9dr4=
Received: by 10.86.80.17 with SMTP id d17mr5652237fgb.47.1223925831362;
        Mon, 13 Oct 2008 12:23:51 -0700 (PDT)
Received: from ?91.155.182.187? (a91-155-182-187.elisa-laajakaista.fi [91.155.182.187])
        by mx.google.com with ESMTPS id d4sm8663355fga.5.2008.10.13.12.23.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Oct 2008 12:23:50 -0700 (PDT)
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98140>

This works as --tags and --heads, limiting the outputted ref types.
Any combination of the three can be used.

Signed-off-by: Heikki Hokkanen <hoxu@users.sf.net>
---
 Documentation/git-show-ref.txt |   10 ++++++----
 builtin-show-ref.c             |   12 +++++++++---
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index 2f173ff..5aea2de 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -9,7 +9,8 @@ SYNOPSIS
 --------
 [verse]
 'git show-ref' [-q|--quiet] [--verify] [-h|--head] [-d|--dereference]
-	     [-s|--hash] [--abbrev] [--tags] [--heads] [--] <pattern>...
+	     [-s|--hash] [--abbrev] [--tags] [--heads] [--remotes]
+	     [--] <pattern>...
 'git show-ref' --exclude-existing[=pattern]
 
 DESCRIPTION
@@ -36,10 +37,11 @@ OPTIONS
 
 --tags::
 --heads::
+--remotes::
 
-	Limit to only "refs/heads" and "refs/tags", respectively.  These
-	options are not mutually exclusive; when given both, references stored
-	in "refs/heads" and "refs/tags" are displayed.
+	Limit to only "refs/heads", "refs/tags" and "refs/remotes" respectively.
+	These options are not mutually exclusive; when given all, references
+	stored in "refs/heads", "refs/tags" and "refs/remotes" are displayed.
 
 -d::
 --dereference::
diff --git a/builtin-show-ref.c b/builtin-show-ref.c
index 572b114..d2362c2 100644
--- a/builtin-show-ref.c
+++ b/builtin-show-ref.c
@@ -5,10 +5,11 @@
 #include "tag.h"
 #include "string-list.h"
 
-static const char show_ref_usage[] = "git show-ref [-q|--quiet] [--verify] [-h|--head] [-d|--dereference] [-s|--hash[=<length>]] [--abbrev[=<length>]] [--tags] [--heads] [--] [pattern*] < ref-list";
+static const char show_ref_usage[] = "git show-ref [-q|--quiet] [--verify] [-h|--head] [-d|--dereference] [-s|--hash[=<length>]] [--abbrev[=<length>]] [--tags] [--heads] [--remotes] [--] [pattern*] < ref-list";
 
 static int deref_tags = 0, show_head = 0, tags_only = 0, heads_only = 0,
-	found_match = 0, verify = 0, quiet = 0, hash_only = 0, abbrev = 0;
+	remotes_only = 0, found_match = 0, verify = 0, quiet = 0, hash_only = 0,
+	abbrev = 0;
 static const char **pattern;
 
 static void show_one(const char *refname, const unsigned char *sha1)
@@ -26,11 +27,12 @@ static int show_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	const char *hex;
 	unsigned char peeled[20];
 
-	if (tags_only || heads_only) {
+	if (tags_only || heads_only || remotes_only) {
 		int match;
 
 		match = heads_only && !prefixcmp(refname, "refs/heads/");
 		match |= tags_only && !prefixcmp(refname, "refs/tags/");
+		match |= remotes_only && !prefixcmp(refname, "refs/remotes/");
 		if (!match)
 			return 0;
 	}
@@ -217,6 +219,10 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)
 			heads_only = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--remotes")) {
+			remotes_only = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--exclude-existing"))
 			return exclude_existing(NULL);
 		if (!prefixcmp(arg, "--exclude-existing="))
-- 
1.6.0.2.526.g5c283.dirty
