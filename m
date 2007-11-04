Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 16616 invoked by uid 111); 4 Nov 2007 10:31:46 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 04 Nov 2007 05:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756231AbXKDKb0 (ORCPT <rfc822;peff@peff.net>);
	Sun, 4 Nov 2007 05:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755750AbXKDKbZ
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 05:31:25 -0500
Received: from pan.madism.org ([88.191.52.104]:42930 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755777AbXKDKbG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 05:31:06 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 1D18428614;
	Sun,  4 Nov 2007 11:31:04 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 901463F1D2; Sun,  4 Nov 2007 11:31:02 +0100 (CET)
From:	Pierre Habouzit <madcoder@debian.org>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 09/10] Migrate git-quiltimport.sh to use git-rev-parse --parseopt
Date:	Sun,  4 Nov 2007 11:31:01 +0100
Message-Id: <1194172262-1563-10-git-send-email-madcoder@debian.org>
X-Mailer: git-send-email 1.5.3.5.1498.g0c64
In-Reply-To: <1194172262-1563-9-git-send-email-madcoder@debian.org>
References: <1194172262-1563-1-git-send-email-madcoder@debian.org>
 <1194172262-1563-2-git-send-email-madcoder@debian.org>
 <1194172262-1563-3-git-send-email-madcoder@debian.org>
 <1194172262-1563-4-git-send-email-madcoder@debian.org>
 <1194172262-1563-5-git-send-email-madcoder@debian.org>
 <1194172262-1563-6-git-send-email-madcoder@debian.org>
 <1194172262-1563-7-git-send-email-madcoder@debian.org>
 <1194172262-1563-8-git-send-email-madcoder@debian.org>
 <1194172262-1563-9-git-send-email-madcoder@debian.org>
To:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 git-quiltimport.sh |   38 +++++++++++++++-----------------------
 1 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 880c81d..b6c24c8 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -1,5 +1,11 @@
 #!/bin/sh
-USAGE='--dry-run --author <author> --patches </path/to/quilt/patch/directory>'
+OPTIONS_SPEC="\
+git-quiltimport [options]
+--
+n,dry-run     dry run
+author=       author name and email address for patches without any
+patches=      path to the quilt series and patches
+"
 SUBDIRECTORY_ON=Yes
 . git-sh-setup
 
@@ -8,39 +14,25 @@ quilt_author=""
 while test $# != 0
 do
 	case "$1" in
-	--au=*|--aut=*|--auth=*|--autho=*|--author=*)
-		quilt_author=$(expr "z$1" : 'z-[^=]*\(.*\)')
-		shift
-		;;
-
-	--au|--aut|--auth|--autho|--author)
-		case "$#" in 1) usage ;; esac
+	--author)
 		shift
 		quilt_author="$1"
-		shift
 		;;
-
-	--dry-run)
-		shift
+	-n|--dry-run)
 		dry_run=1
 		;;
-
-	--pa=*|--pat=*|--patc=*|--patch=*|--patche=*|--patches=*)
-		QUILT_PATCHES=$(expr "z$1" : 'z-[^=]*\(.*\)')
-		shift
-		;;
-
-	--pa|--pat|--patc|--patch|--patche|--patches)
-		case "$#" in 1) usage ;; esac
-		shift
+	--patches)
 		QUILT_PATCHES="$1"
 		shift
 		;;
-
+	--)
+		shift
+		break;;
 	*)
-		break
+		usage
 		;;
 	esac
+	shift
 done
 
 # Quilt Author
-- 
1.5.3.5.1509.g66d41

