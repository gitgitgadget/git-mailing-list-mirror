From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv7 08/11] gitweb: refactor repository URL printing
Date: Thu, 11 Nov 2010 13:26:15 +0100
Message-ID: <1289478378-15604-9-git-send-email-giuseppe.bilotta@gmail.com>
References: <1289478378-15604-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 11 13:28:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGWG0-0000sF-7x
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 13:28:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756522Ab0KKM0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 07:26:51 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43993 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756482Ab0KKM0u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 07:26:50 -0500
Received: by mail-wy0-f174.google.com with SMTP id 28so630026wyb.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 04:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=QB8JTBenMsLMuKGgYErAoj6lKUoHVy0eYC9Y1x3iTcs=;
        b=CPjjgUr1nBj3axxt2p8ESgQflqeeoVL9ZY9SG6RD8JeEpC7XKkw64CvRk2wqEhRZRt
         ZRRG98oke4wuvsw/sGTAk95rZTRaiE84fL1zGg/gqq+zQwr90cnXAOYReYbEy+z958gC
         wWYQ6ZsahNx1QxYBjJXRUznAKQSjJQ82+AsME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wpBvL23+Ttk+mifFtJWh/U5mTUmTjhn069ilL1SPrugPxrh37CcEGN1uKzSdIvmv0Y
         bNDfDCJJw4bduxrQZHxu3WPgrq/3G5SoHw0KiC1z9j29VmtYBU8vj46SnlTqqKMR9ZnZ
         ucba4W4pVNxtaA/9/YqeGLUPR5pX1H+bjizgM=
Received: by 10.227.127.199 with SMTP id h7mr728027wbs.187.1289478410124;
        Thu, 11 Nov 2010 04:26:50 -0800 (PST)
Received: from localhost ([151.60.176.40])
        by mx.google.com with ESMTPS id o43sm1239327weq.47.2010.11.11.04.26.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 04:26:49 -0800 (PST)
X-Mailer: git-send-email 1.7.3.68.g6ec8
In-Reply-To: <1289478378-15604-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161242>

Factor out the code to display the repository URL(s) from summary view
into a format_rep_url() routine.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index bf38757..6e7a663 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3797,6 +3797,11 @@ sub git_print_header_div {
 	      "\n</div>\n";
 }
 
+sub format_repo_url {
+	my ($name, $url) = @_;
+	return "<tr class=\"metadata_url\"><td>$name</td><td>$url</td></tr>\n";
+}
+
 sub print_local_time {
 	print format_local_time(@_);
 }
@@ -5180,7 +5185,7 @@ sub git_summary {
 	@url_list = map { "$_/$project" } @git_base_url_list unless @url_list;
 	foreach my $git_url (@url_list) {
 		next unless $git_url;
-		print "<tr class=\"metadata_url\"><td>$url_tag</td><td>$git_url</td></tr>\n";
+		print format_repo_url($url_tag, $git_url);
 		$url_tag = "";
 	}
 
-- 
1.7.3.68.g6ec8
