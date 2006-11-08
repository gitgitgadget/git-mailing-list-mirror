X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC] gitweb: Default to $hash_base or HEAD for $hash in "commit" and "commitdiff" views
Date: Wed, 8 Nov 2006 23:11:34 +0100
Message-ID: <200611082311.35161.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 8 Nov 2006 22:11:31 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=cLox6tMDpEjUN16VJGdL6wvoCx0VZ9u/549ZtevBfVDWC95M8+4pHvbO7lTD7kJX92ukrLP0tlKcst28Je8lNzu3mu1s4kIsSyNNBYx0YSyF/bnrRbXyhufCZzPBf24/24916UMs+2jo/WmpP5d89QucbobPe5Tpld+SVpT0GH0=
User-Agent: KMail/1.9.3
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31162>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ghvdd-0006ze-SA for gcvg-git@gmane.org; Wed, 08 Nov
 2006 23:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161733AbWKHWK4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 17:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161736AbWKHWKz
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 17:10:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:62818 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1161733AbWKHWKy
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 17:10:54 -0500
Received: by ug-out-1314.google.com with SMTP id m3so42210ugc for
 <git@vger.kernel.org>; Wed, 08 Nov 2006 14:10:50 -0800 (PST)
Received: by 10.67.26.7 with SMTP id d7mr205778ugj.1163023850497; Wed, 08 Nov
 2006 14:10:50 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id j2sm4337186ugf.2006.11.08.14.10.50; Wed, 08 Nov
 2006 14:10:50 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Set $hash parameter to $hash_base || "HEAD" if it is not set (if it is
not true to be more exact). This allows [hand-edited] URLs with 'action'
"commit" or "commitdiff" but without 'hash' parameter.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
RFC because I want to ask if we should default to HEAD if hash is not
provided for commit and commitdiff views, or should we error out with
more reasonable error message.

 gitweb/gitweb.perl |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3118cb0..8313517 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3391,6 +3391,7 @@ sub git_log {
 }
 
 sub git_commit {
+	$hash ||= $hash_base || "HEAD";
 	my %co = parse_commit($hash);
 	if (!%co) {
 		die_error(undef, "Unknown commit object");
@@ -3668,6 +3669,7 @@ sub git_blobdiff_plain {
 
 sub git_commitdiff {
 	my $format = shift || 'html';
+	$hash ||= $hash_base || "HEAD";
 	my %co = parse_commit($hash);
 	if (!%co) {
 		die_error(undef, "Unknown commit object");
-- 
1.4.3.4
