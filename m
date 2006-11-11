X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH] Print progress message to stderr, not stdout
Date: Sat, 11 Nov 2006 13:16:25 +0100
Message-ID: <20061111121625.8988.45195.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 11 Nov 2006 12:18:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: StGIT/0.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31217>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Giroa-00019D-05 for gcvg-git@gmane.org; Sat, 11 Nov
 2006 13:18:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424570AbWKKMSW convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 11 Nov 2006 07:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424571AbWKKMSW
 (ORCPT <rfc822;git-outgoing>); Sat, 11 Nov 2006 07:18:22 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:24575 "EHLO
 mxfep01.bredband.com") by vger.kernel.org with ESMTP id S1424570AbWKKMSV
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 11 Nov 2006 07:18:21 -0500
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82]) by
 mxfep01.bredband.com with ESMTP id
 <20061111121820.UBRI9747.mxfep01.bredband.com@ironport.bredband.com> for
 <git@vger.kernel.org>; Sat, 11 Nov 2006 13:18:20 +0100
Received: from ua-83-227-180-148.cust.bredbandsbolaget.se (HELO
 yoghurt.hemma.treskal.com) ([83.227.180.148]) by ironport.bredband.com with
 ESMTP; 11 Nov 2006 13:18:20 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by
 yoghurt.hemma.treskal.com (Postfix) with ESMTP id 6CBD84C04D; Sat, 11 Nov
 2006 13:18:19 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

Printing progress messages to stdout causes them to get mixed up with
the actual output of the program. Using stderr is much better, since
the user can then redirect the two components separately.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

I noticed this when creating a patch with "stg export -s" for the
import regression test.

 stgit/git.py |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/stgit/git.py b/stgit/git.py
index 2a6ae91..8d88769 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -186,8 +186,8 @@ def __tree_status(files =3D None, tree_id
     """Returns a list of pairs - [status, filename]
     """
     if verbose:
-        print 'Checking for changes in the working directory...',
-        sys.stdout.flush()
+        sys.stderr.write('Checking for changes in the working director=
y...')
+        sys.stderr.flush()
=20
     refresh_index()
=20
@@ -226,7 +226,7 @@ def __tree_status(files =3D None, tree_id
             cache_files.append(fs)
=20
     if verbose:
-        print 'done'
+        print >> sys.stderr, 'done'
=20
     return cache_files
