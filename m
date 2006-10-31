X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 8/n] gitweb: Fix two issues with quoted filenames in git_patchset_body
Date: Tue, 31 Oct 2006 17:43:13 +0100
Message-ID: <200610311743.14032.jnareb@gmail.com>
References: <200610301953.01875.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 31 Oct 2006 16:43:40 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fOwb42E+EK4ojfH0wVnK2nK7Cb9U35RXiiK3pzqZTE6Pqe5hF2BWdy5vjIqjWEXEva3lpoFLe+2odkFIASB+wY2X3/PJFplGMMAJ2Gv5t8drbqQ1NxXvnvFibgzbuxj13XjwT7gUej/0W9BKK5I6/OJ79RxCCOvqeEd4Khe63Is=
User-Agent: KMail/1.9.3
In-Reply-To: <200610301953.01875.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30591>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gewhn-0003n0-Kd for gcvg-git@gmane.org; Tue, 31 Oct
 2006 17:43:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423554AbWJaQnL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 11:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423552AbWJaQnL
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 11:43:11 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:5704 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1423554AbWJaQnJ
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 11:43:09 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1496516ugm for
 <git@vger.kernel.org>; Tue, 31 Oct 2006 08:43:08 -0800 (PST)
Received: by 10.67.101.10 with SMTP id d10mr6391605ugm; Tue, 31 Oct 2006
 08:43:08 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id k2sm4542216ugf.2006.10.31.08.43.07; Tue, 31 Oct
 2006 08:43:07 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This fixes the following (minor) bugs:
* gitweb didn't remove quoted filenames from "git diff" header
* the filename in to-file +++ header used esc_html not esc_path

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e0f7a3f..837b88e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2114,7 +2114,7 @@ sub git_patchset_body {
 			$patch_idx++;
 
 			# print "git diff" header
-			$patch_line =~ s!^(diff (.*?) )a/.*$!$1!;
+			$patch_line =~ s!^(diff (.*?) )"?a/.*$!$1!;
 			if ($from{'href'}) {
 				$patch_line .= $cgi->a({-href => $from{'href'}, -class => "path"},
 				                       'a/' . esc_path($from{'file'}));
@@ -2191,7 +2191,7 @@ sub git_patchset_body {
 				if ($to{'href'}) {
 					$patch_line = '+++ b/' .
 					              $cgi->a({-href=>$to{'href'}, -class=>"path"},
-					                      esc_html($to{'file'}));
+					                      esc_path($to{'file'}));
 				}
 				print "<div class=\"diff to_file\">$patch_line</div>\n";
 
-- 
1.4.3.3
