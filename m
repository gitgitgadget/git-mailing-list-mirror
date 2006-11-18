X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 5/5] gitweb: Add an option to href() to return full URL
Date: Sat, 18 Nov 2006 23:35:42 +0100
Message-ID: <1163889347230-git-send-email-jnareb@gmail.com>
References: <1163889342877-git-send-email-jnareb@gmail.com>
NNTP-Posting-Date: Sat, 18 Nov 2006 22:34:43 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=SFiJyWZi8CGZJ8m317aynzM6XoYL9iU4mM9niwaXUihHWhmyf23YZl0lmYperItTDzKQSN2BDT1PqkLKj06Ue4F0jKPRuguqVHm+d4J6Vr67FXLbpZSDgdWcBW6Nur+c/a0Be3IxcZfxPl+EbXU5ueSJB29AWTeXnb95lKhK3t4=
X-Mailer: git-send-email 1.4.3.4
In-Reply-To: <1163889342877-git-send-email-jnareb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31805>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlYld-0001jk-QV for gcvg-git@gmane.org; Sat, 18 Nov
 2006 23:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755277AbWKRWeZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 17:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755275AbWKRWeZ
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 17:34:25 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:19218 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1755277AbWKRWeW
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 17:34:22 -0500
Received: by ug-out-1314.google.com with SMTP id m3so953039ugc for
 <git@vger.kernel.org>; Sat, 18 Nov 2006 14:34:21 -0800 (PST)
Received: by 10.67.30.6 with SMTP id h6mr4611812ugj.1163889261284; Sat, 18
 Nov 2006 14:34:21 -0800 (PST)
Received: from roke.D-201 ( [81.190.24.209]) by mx.google.com with ESMTP id
 i39sm2080445ugd.2006.11.18.14.34.20; Sat, 18 Nov 2006 14:34:21 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1]) by roke.D-201
 (8.13.4/8.13.4) with ESMTP id kAIMZluu015396; Sat, 18 Nov 2006 23:35:47 +0100
Received: (from jnareb@localhost) by roke.D-201 (8.13.4/8.13.4/Submit) id
 kAIMZlcN015395; Sat, 18 Nov 2006 23:35:47 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

href subroutine by default generates absolute URL (generated using
CGI::url(-absolute=>1), and saved in $my_uri) using $my_uri as base;
add an option to generate full URL using $my_url as base.

New feature usage: href(..., -full=>1)

To be used in web feeds (RSS, Atom, OPML) and other places which need
full URL rather than absolute or relative.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 5875ba0..8739501 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -459,7 +459,8 @@ exit;
 
 sub href(%) {
 	my %params = @_;
-	my $href = $my_uri;
+	# default is to use -absolute url() i.e. $my_uri
+	my $href = $params{-full} ? $my_url : $my_uri;
 
 	# XXX: Warning: If you touch this, check the search form for updating,
 	# too.
-- 
1.4.3.4
