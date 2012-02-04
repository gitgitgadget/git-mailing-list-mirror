From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4/5] gitweb: Highlight matched part of project description when searching projects
Date: Sat,  4 Feb 2012 13:47:27 +0100
Message-ID: <1328359648-29511-5-git-send-email-jnareb@gmail.com>
References: <1328359648-29511-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 13:47:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rtf1v-0003Yi-FL
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 13:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253Ab2BDMrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 07:47:42 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:38040 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754098Ab2BDMrl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 07:47:41 -0500
Received: by mail-ee0-f46.google.com with SMTP id c14so1494818eek.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 04:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=zbQ+E4hoCd/homgI8GJS/M9MRU2utSMyyNsSAghAU7A=;
        b=ZFrKprOOvQkkB7mbJHuXIwznZWBu0FIwFuIeLDK9ZnTOeNfoRYu6uHy5czblGaOKzY
         qtAJIdRyaxTKiRTcHzSA6On9BWcvDxYtOXXo2l07RQDJuGknsX4dxBRR9iFsJJNbdt4M
         G6Yzz0otmDGUUWOW6b7ckH0KDj26g+Xh+Icrc=
Received: by 10.14.28.140 with SMTP id g12mr1618420eea.85.1328359660507;
        Sat, 04 Feb 2012 04:47:40 -0800 (PST)
Received: from localhost.localdomain (abwn75.neoplus.adsl.tpnet.pl. [83.8.237.75])
        by mx.google.com with ESMTPS id z47sm26890568eeh.9.2012.02.04.04.47.39
        (version=SSLv3 cipher=OTHER);
        Sat, 04 Feb 2012 04:47:40 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1328359648-29511-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189866>

Use esc_html_match_hl() from previous commit to mark match in the
_whole_ description when searching projects.

Currently, with this commit, when searching projects there is always
shown full description of a project, and not a shortened one (like for
ordinary projects list view), even if the match is on project name and
not project description.

Showing full description when there is match on it is useful to avoid
situation where match is in shortened, invisible part... well, perhaps
that could be solved (showing shortened description), but it would
require some extra code.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
The part about showing match using shortened description no longer
applies after the following patch... though it is an RFC for now.

 gitweb/gitweb.perl |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index aef15c8..c650268 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5371,7 +5371,10 @@ sub git_project_list_rows {
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
