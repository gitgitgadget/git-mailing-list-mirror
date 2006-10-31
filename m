X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 6/n] gitweb: Remove redundant "blob" links from git_difftree_body
Date: Tue, 31 Oct 2006 17:07:42 +0100
Message-ID: <200610311707.43054.jnareb@gmail.com>
References: <200610301953.01875.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 31 Oct 2006 16:07:56 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=IoZOtBUOebBGTSZc2Iwe+XS9w9XSFSLnrIFUOZ/ZooyJnaj81XIPnzR/db1FyH9iX0mV46g3eTJXM5Cjg0UMNXu+PzuFxvacI3jl5oZKlrC1KZR44AN5dBFCXog7sm9YZs/otKqCRozE4dkOg3p7GjuGNkBQi+/IWe6gbRNWwFo=
User-Agent: KMail/1.9.3
In-Reply-To: <200610301953.01875.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30588>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gew9P-0004bL-El for gcvg-git@gmane.org; Tue, 31 Oct
 2006 17:07:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423529AbWJaQHj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 11:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423532AbWJaQHj
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 11:07:39 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:64872 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1423529AbWJaQHi
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 11:07:38 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1486496ugm for
 <git@vger.kernel.org>; Tue, 31 Oct 2006 08:07:37 -0800 (PST)
Received: by 10.67.30.6 with SMTP id h6mr6367493ugj; Tue, 31 Oct 2006
 08:07:37 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id 53sm5145946ugn.2006.10.31.08.07.36; Tue, 31 Oct
 2006 08:07:36 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This revert parts of commit 4777b0141a4812177390da4b6ebc9d40ac3da4b5
  "gitweb: Restore object-named links in item lists"
by Petr Baudis, which bring back "blob" links in difftree-raw like
part of "commit" and "commitdiff" views, namely in git_difftree_body
subroutine. First, it did that incompletely: it did not add "blob"
link for added files, and added block used mixture of tabs and spaces
for align. Second, in "difftree" view the "blob" link is not the most
interesting, *contrary* to "blob"/"tree" link in "tree" view, so it
should be enough to have hidden link in the form of file name entry.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
I'm still for having those object-named links in "tree" view.

But perhaps it would be better to add "blob" links for all possible
statuses, including added files... Pasky, Luben, Junio?

 gitweb/gitweb.perl |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c22fcc5..542dbca 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1967,9 +1967,6 @@ sub git_difftree_body {
 				print $cgi->a({-href => "#patch$patchno"}, "patch");
 				print " | ";
 			}
-			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'from_id'},
-			                             hash_base=>$parent, file_name=>$diff{'file'})},
-				      "blob") . " | ";
 			print $cgi->a({-href => href(action=>"blame", hash_base=>$parent,
 			                             file_name=>$diff{'file'})},
 			              "blame") . " | ";
@@ -2015,9 +2012,6 @@ sub git_difftree_body {
 				}
 				print " | ";
 			}
-			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'to_id'},
-						     hash_base=>$hash, file_name=>$diff{'file'})},
-				      "blob") . " | ";
 			print $cgi->a({-href => href(action=>"blame", hash_base=>$hash,
 			                             file_name=>$diff{'file'})},
 			              "blame") . " | ";
@@ -2058,9 +2052,6 @@ sub git_difftree_body {
 				}
 				print " | ";
 			}
-			print $cgi->a({-href => href(action=>"blob", hash=>$diff{'from_id'},
-						     hash_base=>$parent, file_name=>$diff{'from_file'})},
-				      "blob") . " | ";
 			print $cgi->a({-href => href(action=>"blame", hash_base=>$parent,
 			                             file_name=>$diff{'from_file'})},
 			              "blame") . " | ";
-- 
1.4.3.3
