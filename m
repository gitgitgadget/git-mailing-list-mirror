From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2 6/8] gitweb: Highlight matched part of project description when searching projects
Date: Wed, 15 Feb 2012 21:38:50 +0100
Message-ID: <1329338332-30358-7-git-send-email-jnareb@gmail.com>
References: <1329338332-30358-1-git-send-email-jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 21:42:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rxlfr-0006XA-WE
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 21:42:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755522Ab2BOUlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 15:41:47 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:58575 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755388Ab2BOUlg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 15:41:36 -0500
Received: by mail-ee0-f46.google.com with SMTP id c14so521741eek.19
        for <git@vger.kernel.org>; Wed, 15 Feb 2012 12:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jaxeT0NAfyim+T8eIYRTvh1+uyVB2uai0FDsrtttgyE=;
        b=pmnSF6G/rhBkJdfd1S+1Yn5LxwHCg1XSsxB+AIM6DoQWb7ysNE5NhJZ06kaQ7/CBQv
         ct8IAAQEmUPKxxytgpsLHk2ctdhEMUwG4gp6rof77FBr44YAfK4vzMKB/rMI/iVPPOPw
         KVDmcvvQA3V4RuKtyyMz1XKuzvnZGaoYNqg/8=
Received: by 10.213.28.75 with SMTP id l11mr454029ebc.47.1329338495522;
        Wed, 15 Feb 2012 12:41:35 -0800 (PST)
Received: from localhost.localdomain (abwo207.neoplus.adsl.tpnet.pl. [83.8.238.207])
        by mx.google.com with ESMTPS id c16sm14922307eei.1.2012.02.15.12.41.34
        (version=SSLv3 cipher=OTHER);
        Wed, 15 Feb 2012 12:41:35 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1329338332-30358-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190858>

Use esc_html_match_hl() from previous commit to mark match in the
_whole_ description when searching projects.

Currently, with this commit, when searching projects there is always
shown full description of a project, and not a shortened one (like for
ordinary projects list view), even if the match is on project name and
not project description.

Showing full description when there is match on it is useful to avoid
situation where match is in shortened, invisible part... well, perhaps
that could be solved (showing shortened description), but it would
require much more complicated code.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
The part about showing match using shortened description no longer
applies after the following patch... though it is an RFC for now,
that is why it is not mentioned in the commit message.

NOTE that we are actually always showing full description, so having
full description in "title" attribute to show on mouseover over
shortened title is no longer necessary, and should probably be
fixed... that is unless the next patch that highlights matches in
shortened description is accepted.

No changes from previous version (but see paragraph above about
possible changes).

 gitweb/gitweb.perl |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 5596701..a109ebb 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5408,7 +5408,10 @@ sub git_project_list_rows {
 		      "</td>\n" .
 		      "<td>" . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary"),
 		                        -class => "list", -title => $pr->{'descr_long'}},
-		                        esc_html($pr->{'descr'})) . "</td>\n" .
+		                        $search_regexp
+		                        ? esc_html_match_hl($pr->{'descr_long'}, $search_regexp)
+		                        : esc_html($pr->{'descr'})) .
+		      "</td>\n" .
 		      "<td><i>" . chop_and_escape_str($pr->{'owner'}, 15) . "</i></td>\n";
 		print "<td class=\"". age_class($pr->{'age'}) . "\">" .
 		      (defined $pr->{'age_string'} ? $pr->{'age_string'} : "No commits") . "</td>\n" .
-- 
1.7.9
