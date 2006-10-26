X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Check git base URLs before generating URL from it
Date: Thu, 26 Oct 2006 12:26:44 +0200
Message-ID: <200610261226.44960.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 26 Oct 2006 10:26:50 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=CMgkDVFZp3kg2zJKDhdKsLlB6jFxORkKqMaYvS6khnaSoi4ULM2mi0PEHZrrx24rkQPwHoAuWnRDRcvMKXoeWhfSWHAdv64ZfhLnN4bX4E2Sq00YjDC83k7AHPoSggThnwrMELALrjdfQm24tXENw7qKjVyBHjbXb5vyv4PRcYY=
User-Agent: KMail/1.9.3
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30181>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd2Rg-0003d0-8c for gcvg-git@gmane.org; Thu, 26 Oct
 2006 12:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422942AbWJZK0N (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 06:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422931AbWJZK0N
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 06:26:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:64106 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1422942AbWJZK0L
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 06:26:11 -0400
Received: by ug-out-1314.google.com with SMTP id 32so323703ugm for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 03:26:10 -0700 (PDT)
Received: by 10.66.224.19 with SMTP id w19mr2515549ugg; Thu, 26 Oct 2006
 03:26:09 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110]) by
 mx.google.com with ESMTP id e1sm3560885ugf.2006.10.26.03.26.09; Thu, 26 Oct
 2006 03:26:09 -0700 (PDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Check if each of git base URLs in @git_base_url_list is true before
appending "/$project" to it to generate project URL.

This fixes the error that for default configuration for gitweb in
Makefile, with GITWEB_BASE_URL empty (and "++GITWEB_BASE_URL++" being
"" in gitweb.cgi), we had URL of "/$project" in the summary view.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
I don't think that anybody would want base URL of "0".

 gitweb/gitweb.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 35a9afb..0d2ea72 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2516,7 +2516,8 @@ sub git_summary {
 	# or make project git URL from git base URL and project name
 	my $url_tag = "URL";
 	my @url_list = git_get_project_url_list($project);
-	@url_list = map { "$_/$project" } @git_base_url_list unless @url_list;
+	@url_list = map { $_ ? "$_/$project" : () }
+		@git_base_url_list unless @url_list;
 	foreach my $git_url (@url_list) {
 		next unless $git_url;
 		print "<tr><td>$url_tag</td><td>$git_url</td></tr>\n";
-- 
1.4.3.3
