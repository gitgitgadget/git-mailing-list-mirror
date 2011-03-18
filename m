From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/3 (alternate)] gitweb: Mark "atnight" author/committer times also for 'localtime'
Date: Fri, 18 Mar 2011 18:46:02 +0100
Message-ID: <201103181846.04979.jnareb@gmail.com>
References: <c8621826e0576e3e31240b0205e7e3d0@localhost> <64c70e95e767572e5be732dc7e17815b@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 18:48:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0dmj-0003cZ-CR
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 18:48:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486Ab1CRRro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 13:47:44 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38865 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932398Ab1CRRrj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 13:47:39 -0400
Received: by fxm17 with SMTP id 17so3928712fxm.19
        for <git@vger.kernel.org>; Fri, 18 Mar 2011 10:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=RZ2dPHQ+9Be2Jf8S5LK7/PWtr4pDCqslCZYPZ+hEiV8=;
        b=KsvmYtM9Yo0UQ5/GLlUZO4CmWW5U/qcQOnJ9+plW8FB1kBPyA1cfZpwJdK4bC2w3Z1
         cocOV3z6qg85DgfDpkSWc4NpOTJUCET79wJk2aDGtyskpk+8peHyKdz309m6hI4v/5vr
         nd95jWlKLzJLd4gTrPQnGMnmBTYzmFyO/Cnak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=oSJPXN9kEGKJWRLddlBKjrpKFIVsTJl/uFS461r+kD74Q7fQIQELccRmivWgJcHXf/
         KVdtlBI1i8vaKyQ5GsObpXcAthyHcQxqar+nYZXuNm+slTtBX/9tGKj8by1/G4270U3B
         cWBkwXHV+EInnv+lOXHXvPVnvYAR+MHZ8SCsg=
Received: by 10.223.2.205 with SMTP id 13mr1569711fak.138.1300470376357;
        Fri, 18 Mar 2011 10:46:16 -0700 (PDT)
Received: from [192.168.1.13] (abuz4.neoplus.adsl.tpnet.pl [83.8.197.4])
        by mx.google.com with ESMTPS id o17sm1488986fal.1.2011.03.18.10.46.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Mar 2011 10:46:15 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <64c70e95e767572e5be732dc7e17815b@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169342>

From: Kevin Cernekee <cernekee@gmail.com>

By default, with 'localtime' feature disabled, the dates in 'commit',
'commitdiff' and 'tag' views show both GMT time, and localtime in
recorded author/committer/tagger timezone, marking localtime with
"atnight" class to notify times between 0 and 6 AM local time.

An example output can look like this:

  author   A U Thor <author@example.com>
           Wed, 16 Mar 2011 07:02:42 +0000 (02:02 -0500)
                                            ^^^^^

where underlined part is marked with "atnight" class (in red with
default stylesheet).

If $feature{'localtime'} is enabled, we display the RFC 2822 date/time
in the author's/committer's/tagger's local timezone; previous commit
removed marking "atnight" times, because there wasn't separate local
time to mark up after GMT time.

This commit makes gitweb mark _whole_ RFC 2822 date/time with
"atnight" class for times between 0 and 6 AM.

An example output can look like this:

  author   A U Thor <author@example.com>
           Wed, 16 Mar 2011 02:02:42 -0500
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

where again underlined part is marked with "atnight".

We probably should mark only time part of RFC 2822 date/time with
"atnight" class, but such solution would be more involved.

While at it fix whitespace, using spaces for align, tabs for indent.


NOTE that git_print_authorship subroutine is for now left as is; there
is no caller in gitweb that uses it with -localtime=>1.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Kevin, how about something like this instead?  This preserves _intent_
for why there is local time beside GMT time when 'localtime' is disabled
better, I think.

Junio and Kevin, I am not sure if authorship should remain with Kevin,
or should it revert to me; the solution is quite different.

About no-change to git_print_authorship: alternate solution would be
to remove support for -localtime option, like in original patches.

 gitweb/gitweb.perl |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index cdc2a96..5bda0a8 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4003,15 +4003,23 @@ sub git_print_authorship_rows {
 		my %wd = parse_date($co->{"${who}_epoch"}, $co->{"${who}_tz"});
 		print "<tr><td>$who</td><td>" .
 		      format_search_author($co->{"${who}_name"}, $who,
-			       esc_html($co->{"${who}_name"})) . " " .
+		                           esc_html($co->{"${who}_name"})) . " " .
 		      format_search_author($co->{"${who}_email"}, $who,
-			       esc_html("<" . $co->{"${who}_email"} . ">")) .
+		                           esc_html("<" . $co->{"${who}_email"} . ">")) .
 		      "</td><td rowspan=\"2\">" .
 		      git_get_avatar($co->{"${who}_email"}, -size => 'double') .
 		      "</td></tr>\n" .
 		      "<tr>" .
-		      "<td></td><td> $wd{'rfc2822'}";
-		print_local_time(%wd) if !gitweb_check_feature('localtime');
+		      "<td></td><td> ";
+		if (gitweb_check_feature('localtime')) {
+			if ($wd{'hour_local'} < 6) {
+				print "<span class=\"atnight\">$wd{'rfc2822'}</span>";
+			} else {
+				print $wd{'rfc2822'};
+			}
+		} else {
+			print $wd{'rfc2822'} . format_local_time(%wd);
+		}
 		print "</td>" .
 		      "</tr>\n";
 	}
-- 
1.7.3
