From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH 6/6] gitweb: Highlight matched part of project description when searching projects
Date: Fri, 29 Jul 2011 13:52:59 +0200
Message-ID: <1311940379-9608-7-git-send-email-jnareb@gmail.com>
References: <1311940379-9608-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>, admin@repo.or.cz,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 13:53:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmldP-0005xQ-7Q
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 13:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755730Ab1G2Lxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 07:53:36 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65163 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755617Ab1G2Lxd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 07:53:33 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so2225343fxh.19
        for <git@vger.kernel.org>; Fri, 29 Jul 2011 04:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=HOSH/wLwbAaMlTyYPqPKL/vaE7k6DxWQue63goJUiRg=;
        b=F9OUFnfN+73bCnDxOxNp6yU6z9cGRWfgTRQkew5BKFkkvR6szdKGcNZu1x17q6gdXy
         VtbcMAxyuBFi/i8EL6r136jUUJ9kie3+mLHGY/E5NNYJ+iaShLfTG327JkaQ9bjPnAHp
         +skSBFgfIujy8MfrUNbQLydsVzwgIHwdTLHX0=
Received: by 10.223.76.17 with SMTP id a17mr1732095fak.32.1311940413075;
        Fri, 29 Jul 2011 04:53:33 -0700 (PDT)
Received: from localhost.localdomain (abwm72.neoplus.adsl.tpnet.pl [83.8.236.72])
        by mx.google.com with ESMTPS id n27sm1049500faa.4.2011.07.29.04.53.31
        (version=SSLv3 cipher=OTHER);
        Fri, 29 Jul 2011 04:53:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1311940379-9608-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178137>

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
This is slightly controversial part.

Note: some of changes is just reindent.

 gitweb/gitweb.perl |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 692a6bb..6bc68c5 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5172,7 +5172,10 @@ sub git_project_list_rows {
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
1.7.5
