From: Matt McCutchen <hashproduct@gmail.com>
Subject: [PATCH] gitweb: make "No commits" in project list gray, not bold
	green
Date: Thu, 28 Jun 2007 18:15:22 -0400
Message-ID: <1183068922.6108.8.camel@mattlaptop2>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jun 29 00:15:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I42Gu-0000Sg-H4
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 00:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764411AbXF1WP0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 18:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764725AbXF1WP0
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 18:15:26 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:30276 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763702AbXF1WPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 18:15:25 -0400
Received: by wx-out-0506.google.com with SMTP id h31so664383wxd
        for <git@vger.kernel.org>; Thu, 28 Jun 2007 15:15:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:subject:from:to:cc:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=JGYJJ9MuvjVmZJ0+MZeupqsfKhQ02wClRdGuzMjkQwx2uf5GNr/XGGKzk5UyUwb9c3zdVI1v2hX00GX2fa2gYu4dYCF78oECeQjOc/aavm+HqYj7/Hiq07Ny6CS0ZuVaZ8dVDHrIdSA7Chc06Iu/PgwLqqFilYiZynPbEufEOYY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:subject:from:to:cc:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=MimBa2XnV2PMbGSxnco/du1aF2HXxxW1ahmkMkeC9RbjN3fE+fXdwusmlWxj9Ir1gwGMiGCFeLZHujwX8pGj/dxacHA28ZGTQXAb0NteTRBolmqK8kvil3DBpZp7MUAbgtkRlf3jRl6AdJhjl3w9g31cJMVsowe5kJKtMDI3AI0=
Received: by 10.90.113.18 with SMTP id l18mr2603297agc.1183068925117;
        Thu, 28 Jun 2007 15:15:25 -0700 (PDT)
Received: from ?192.168.1.10? ( [71.163.72.121])
        by mx.google.com with ESMTP id 8sm4735721agd.2007.06.28.15.15.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Jun 2007 15:15:24 -0700 (PDT)
X-Mailer: Evolution 2.10.2 (2.10.2-2.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51134>

A missing return statement in git_get_last_activity made gitweb think
a project with no commits was in age class "age0", so the "No commits"
appeared in bold green, which was ridiculous.  I added the return so
those projects get "noage" and added a block to gitweb.css to format
the "No commits" text gray.

Signed-off-by: Matt McCutchen <hashproduct@gmail.com>
---

When I visited http://repo.or.cz/ , this bug jumped out at me!

 gitweb/gitweb.css  |    6 ++++++
 gitweb/gitweb.perl |    1 +
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 7908fe3..096313b 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -281,6 +281,12 @@ table.diff_tree span.file_status.copied {
   color: #70a070;
 }
 
+/* noage: "No commits" */
+table.project_list td.noage {
+	color: #808080;
+	font-style: italic;
+}
+
 /* age2: 60*60*24*2 <= age */
 table.project_list td.age2, table.blame td.age2 {
 	font-style: italic;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7b0e110..b251c44 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1528,6 +1528,7 @@ sub git_get_last_activity {
 		my $age = time - $timestamp;
 		return ($age, age_string($age));
 	}
+	return (undef, undef);
 }
 
 sub git_get_references {
-- 
1.5.2.2.552.gc32f
