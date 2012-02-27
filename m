From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv3 2/4] gitweb: Highlight matched part of project name when searching projects
Date: Mon, 27 Feb 2012 02:55:20 +0100
Message-ID: <1330307722-25351-3-git-send-email-jnareb@gmail.com>
References: <1330307722-25351-1-git-send-email-jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 02:56:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1pos-0007pJ-Be
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 02:56:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753515Ab2B0Bzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Feb 2012 20:55:43 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63081 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483Ab2B0Bzf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2012 20:55:35 -0500
Received: by mail-ey0-f174.google.com with SMTP id h12so2006941eaa.19
        for <git@vger.kernel.org>; Sun, 26 Feb 2012 17:55:34 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.14.94.202 as permitted sender) client-ip=10.14.94.202;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.14.94.202 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.14.94.202])
        by 10.14.94.202 with SMTP id n50mr6661409eef.65.1330307734604 (num_hops = 1);
        Sun, 26 Feb 2012 17:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=9ruYJYF4vvPiMs36wRHURHkpKgM4dwSQ0Pu1W0PiPeQ=;
        b=CytSuzVPEZ51NXEBLNbzk8obdR3Vtm/pMAnE1rxQ8joIhe4JNzsjeQp+4GhtytS9H5
         MqqR8zRJOCqGpNkO09eFhBUGLDnXi+PaiYwZivOKXxnzIw/uloYH40arK3uxqay+tZaX
         kNSpjzwM4TKc51TCEd6Zvxm5zd6Lno2J3n3ts=
Received: by 10.14.94.202 with SMTP id n50mr5035554eef.65.1330307734511;
        Sun, 26 Feb 2012 17:55:34 -0800 (PST)
Received: from localhost.localdomain (abvv154.neoplus.adsl.tpnet.pl. [83.8.219.154])
        by mx.google.com with ESMTPS id n17sm52112996eei.3.2012.02.26.17.55.33
        (version=SSLv3 cipher=OTHER);
        Sun, 26 Feb 2012 17:55:34 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1330307722-25351-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191595>

Use esc_html_match_hl() introduced in previous commit to escape HTML
and mark match, using span element with 'match' class.  Currently only
the 'path' part (i.e. the project name) is highlighted; match might be
on the project description.  Highlighting match in description is left
for next commit.

The code makes use of the fact that defined $search_regexp means that
there was search going on.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Changes from v2:
* Introducing esc_html_match_hl() had been put together with
  introduction of esc_html_hl_regions() in previuos commit.
  Commit message got updated accordingly.

Changes from v1:
* Main part of esc_html_match_hl() got split into esc_html_hl_regions(),
  which was introduced in previous commit.

 gitweb/gitweb.perl |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b790f67..829526f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5407,7 +5407,9 @@ sub git_project_list_rows {
 			print "</td>\n";
 		}
 		print "<td>" . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary"),
-		                        -class => "list"}, esc_html($pr->{'path'})) . "</td>\n" .
+		                        -class => "list"},
+		                       esc_html_match_hl($pr->{'path'}, $search_regexp)) .
+		      "</td>\n" .
 		      "<td>" . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary"),
 		                        -class => "list", -title => $pr->{'descr_long'}},
 		                        esc_html($pr->{'descr'})) . "</td>\n" .
-- 
1.7.9
