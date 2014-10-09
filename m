From: Alexandre Erwin Ittner <alexandre@ittner.com.br>
Subject: [PATCH] gitweb: add HTML ids for categories and projects
Date: Wed, 8 Oct 2014 23:16:31 -0300
Message-ID: <20141008231631.8466676f4f808cb919c677e4@ittner.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 09 04:16:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xc3Hm-0005Ut-2J
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 04:16:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbaJICQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 22:16:51 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:55719 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbaJICQu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 22:16:50 -0400
Received: by mail-qg0-f46.google.com with SMTP id z60so247973qgd.33
        for <git@vger.kernel.org>; Wed, 08 Oct 2014 19:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ittner.com.br; s=google;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=DlxAB2ta0mYw6EaXnQbCqb/IQbJninc6bWsH5FtdBR4=;
        b=NtSyfQGf1GvFh99bWACQlKctKymnlq+R0+OItnQ38En+unBA29+wIG1KfJacZW/BJ1
         uXuzSXmzXu0AnHK1Jy4HdLaP8SWp2+Q9YBdy9Ea6MixjWsbMgzIGcHtHKBh/1C+e9X+o
         wcgw0EZqPj7oB868Loua5B7pnDecArXkyGIRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=DlxAB2ta0mYw6EaXnQbCqb/IQbJninc6bWsH5FtdBR4=;
        b=F1UaHftzqaSv05pYZM4qjGntcQRi5juD5XIOcFtZg2G7u4+fMSUlITkKGmeFNE7CpA
         BrexchdhR18Z4DbAMkIwIYkT4inM3+b6IdjLgB9tsA2+x5jF0cpm3wKW918nH/aqFWUz
         XZjmiU0UdeNzS20W2kwA4MFphwTFZWQ2NWAPm+nb7XrpNcQV7pIbEeqGHMQeNPn6rugj
         AEwwiFuYhJ1UYOAiX3Jx3XdFrXd5EDvalYkyZcrpecF+/cZmUEneMMsmlA4n8WlZbU8r
         0JAYC6vc5z1ItDdoTbLQYHgoV2i+W+66LTZlWI9cexbUdzCRl9NY23B4ykMz1GXq0g1v
         RFdA==
X-Gm-Message-State: ALoCoQlsZ/KdIDI639L1Qx0qV1/i/6jpQNwbQy2uTBCzrfHUZ2GXGrKTVVTPu8mOwMhilyTt+Vh7
X-Received: by 10.224.32.70 with SMTP id b6mr18865168qad.14.1412821009338;
        Wed, 08 Oct 2014 19:16:49 -0700 (PDT)
Received: from elendil (179.176.236.117.dynamic.adsl.gvt.net.br. [179.176.236.117])
        by mx.google.com with ESMTPSA id y9sm1350184qaf.15.2014.10.08.19.16.47
        for <git@vger.kernel.org>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 08 Oct 2014 19:16:48 -0700 (PDT)
X-Mailer: Sylpheed 3.4.0beta4 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the attribute "id" to category headers and project rows in the
web interface. These ids are intended to work as anchors, allowing
links with the fragment component pointing to a given category, which
may be useful when dealing with long project lists.

IDs are generated from the category name and project paths prefixed
with "category-" and "project-", respectively, so links may follow
the format http://example.com/gitweb/#category-drivers. Spaces are
replaced by an "-" and special characters are escaped but, to ensure
uniqueness, no other changes are made.

Signed-off-by: Alexandre Erwin Ittner <alexandre@ittner.com.br>
---
 gitweb/gitweb.perl |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a9f57d6..07f03b1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1718,6 +1718,19 @@ sub project_in_list {
 	return @list && scalar(grep { $_->{'path'} eq $project } @list);
 }
 
+
+# Make a XHTML entity ID from the given string(s).
+# All arguments are concatenated with an "-", spaces are replaced by "-",
+# and other characters are escaped so the name can be used within a XML
+# attribute.
+# Eg. make_xhtml_id("project", "foo.git")   -->  "project-foo.git"
+sub make_xhtml_id {
+	my $id = join("-", @_);
+	$id =~ s/\s/-/g;
+	return esc_attr($id);
+}
+
+
 ## ----------------------------------------------------------------------
 ## HTML aware string manipulation
 
@@ -5681,11 +5694,12 @@ sub git_project_list_rows {
 	my $alternate = 1;
 	for (my $i = $from; $i <= $to; $i++) {
 		my $pr = $projlist->[$i];
+		my $pr_id = make_xhtml_id("project", $pr->{'path'});
 
 		if ($alternate) {
-			print "<tr class=\"dark\">\n";
+			print "<tr id=\"$pr_id\" class=\"dark\">\n";
 		} else {
-			print "<tr class=\"light\">\n";
+			print "<tr id=\"$pr_id\" class=\"light\">\n";
 		}
 		$alternate ^= 1;
 
@@ -5802,7 +5816,8 @@ sub git_project_list_body {
 				if ($check_forks) {
 					print "<td></td>\n";
 				}
-				print "<td class=\"category\" colspan=\"5\">".esc_html($cat)."</td>\n";
+				my $cat_id = make_xhtml_id("category", $cat);
+				print "<td id=\"$cat_id\" class=\"category\" colspan=\"5\">".esc_html($cat)."</td>\n";
 				print "</tr>\n";
 			}
 
-- 
1.7.9.5
