X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4/5] gitweb: Default to $hash_base or HEAD for $hash in "commit" and "commitdiff"
Date: Sat, 18 Nov 2006 23:35:41 +0100
Message-ID: <11638893462704-git-send-email-jnareb@gmail.com>
References: <1163889342877-git-send-email-jnareb@gmail.com>
NNTP-Posting-Date: Sat, 18 Nov 2006 22:34:53 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VRFH+AQb4O2W2pXRVGwpalJAI/7JQYBf0URZathCZslo637AIncu8Zbb8AuaXUe7vu7nR5MAtjR0cpDT9djuqBYGDjCdL4eoa/gdk6M9OD6x4rfSNc2sH28gxaeiSXSkos+pZdHVT3hd5f+IuwwmZemSlzK0sGq786KFfjfhatk=
X-Mailer: git-send-email 1.4.3.4
In-Reply-To: <1163889342877-git-send-email-jnareb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31809>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlYlf-0001jk-2C for gcvg-git@gmane.org; Sat, 18 Nov
 2006 23:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755274AbWKRWeZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 17:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755275AbWKRWeY
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 17:34:24 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:12050 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1755274AbWKRWeV
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 17:34:21 -0500
Received: by ug-out-1314.google.com with SMTP id m3so953027ugc for
 <git@vger.kernel.org>; Sat, 18 Nov 2006 14:34:21 -0800 (PST)
Received: by 10.67.99.1 with SMTP id b1mr5177230ugm.1163889260912; Sat, 18
 Nov 2006 14:34:20 -0800 (PST)
Received: from roke.D-201 ( [81.190.24.209]) by mx.google.com with ESMTP id
 b35sm2288919ugd.2006.11.18.14.34.20; Sat, 18 Nov 2006 14:34:20 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1]) by roke.D-201
 (8.13.4/8.13.4) with ESMTP id kAIMZkfv015359; Sat, 18 Nov 2006 23:35:47 +0100
Received: (from jnareb@localhost) by roke.D-201 (8.13.4/8.13.4/Submit) id
 kAIMZkWa015358; Sat, 18 Nov 2006 23:35:46 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Set $hash parameter to $hash_base || "HEAD" if it is not set (if it is
not true to be more exact). This allows [hand-edited] URLs with 'action'
"commit" or "commitdiff" but without 'hash' parameter.

If there is 'h' (hash) parameter provided, then gitweb tries
to use this. HEAD is used _only_ if nether hash, nor hash_base
are provided, i.e. for URL like below
  URL?p=project.git;a=commit
i.e. without neither 'h' nor 'hb'.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index eadaa31..5875ba0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3450,6 +3450,7 @@ sub git_log {
 }
 
 sub git_commit {
+	$hash ||= $hash_base || "HEAD";
 	my %co = parse_commit($hash);
 	if (!%co) {
 		die_error(undef, "Unknown commit object");
@@ -3727,6 +3728,7 @@ sub git_blobdiff_plain {
 
 sub git_commitdiff {
 	my $format = shift || 'html';
+	$hash ||= $hash_base || "HEAD";
 	my %co = parse_commit($hash);
 	if (!%co) {
 		die_error(undef, "Unknown commit object");
-- 
1.4.3.4
