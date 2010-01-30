From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 6/8 v6] gitweb: add a get function to compliment print_sort_th
Date: Sat, 30 Jan 2010 23:30:43 +0100
Message-ID: <1264890645-28310-7-git-send-email-jnareb@gmail.com>
References: <1264890645-28310-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 23:31:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbLqo-0008Ua-PW
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 23:31:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754586Ab0A3Wb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 17:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754270Ab0A3WbJ
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 17:31:09 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:61073 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754129Ab0A3WbI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 17:31:08 -0500
Received: by mail-fx0-f220.google.com with SMTP id 20so3058017fxm.21
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 14:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=x27Rta91roqNRbpAtiXmV526O9Ub830QTBVnj8FbjM0=;
        b=nJex+12yG8J/wmFIJAc5gl/Ab76htFlxY8UzxdF2jwWXxv6i7w+Tm8ctJ55n50vqOh
         V012+tQeoYDuWqoTTcTaJ+HXGGPKH/PdfOVjochywaxReerDT51jIV06QcTOQZ+BC7ZB
         5OiaYkEF0i76UXiUsL6MXDMD9R6qZi1DMhF5s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DIW25DHpE2zhPxc5JZBEHc6E2Wnh3qojp09LW0IGczYJEzSBK6zTn9bYVGEN5qFUB7
         lztZkRMv3A75dSy6Gn3DqVXxgBCfcVgnzXcw7kr5M4PgUTR3GvUw9ii04AjWTLVnxBkk
         Ohe7lGJqxlePRYfgyerTRkhj6iNtMlBPibCOY=
Received: by 10.223.15.86 with SMTP id j22mr2384329faa.47.1264890667450;
        Sat, 30 Jan 2010 14:31:07 -0800 (PST)
Received: from localhost.localdomain (abwu191.neoplus.adsl.tpnet.pl [83.8.244.191])
        by mx.google.com with ESMTPS id 15sm1157284fxm.6.2010.01.30.14.31.05
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 30 Jan 2010 14:31:06 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1264890645-28310-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138509>

From: John 'Warthog9' Hawley <warthog9@kernel.org>

This adds a get function (named format_sort_th) for print_sort_th,
so that the basic function can be used outside of their straight
printing operation.

Signed-off-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Changes from version from 'Gitweb caching v5' and
  git://git.kernel.org/pub/scm/git/warthog9/gitweb.git gitweb-ml-v5

* Change function name from get_* to format_*, following gitweb
  subroutine naming convention.

 gitweb/gitweb.perl |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index debaf55..466fa8a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4347,17 +4347,24 @@ sub fill_project_list_info {
 # print 'sort by' <th> element, generating 'sort by $name' replay link
 # if that order is not selected
 sub print_sort_th {
+	print format_sort_th(@_);
+}
+
+sub format_sort_th {
 	my ($name, $order, $header) = @_;
+	my $sort_th = "";
 	$header ||= ucfirst($name);
 
 	if ($order eq $name) {
-		print "<th>$header</th>\n";
+		$sort_th .= "<th>$header</th>\n";
 	} else {
-		print "<th>" .
-		      $cgi->a({-href => href(-replay=>1, order=>$name),
-		               -class => "header"}, $header) .
-		      "</th>\n";
+		$sort_th .= "<th>" .
+		            $cgi->a({-href => href(-replay=>1, order=>$name),
+		                     -class => "header"}, $header) .
+		            "</th>\n";
 	}
+
+	return $sort_th;
 }
 
 sub git_project_list_body {
-- 
1.6.6.1
