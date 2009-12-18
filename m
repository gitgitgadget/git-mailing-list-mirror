From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2 3/6] gitweb: Optionally add "git" links in project list page
Date: Fri, 18 Dec 2009 22:02:46 +0100
Message-ID: <1261170166-14088-1-git-send-email-jnareb@gmail.com>
References: <m3tyvxd3pr.fsf@localhost.localdomain>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 18 22:03:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLjyZ-00068A-CY
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 22:03:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932738AbZLRVC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 16:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932686AbZLRVC5
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 16:02:57 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:22843 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932703AbZLRVC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 16:02:56 -0500
Received: by fg-out-1718.google.com with SMTP id 22so1337727fge.1
        for <git@vger.kernel.org>; Fri, 18 Dec 2009 13:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=kSDTI25mLflHdu092u5O9crG8sgaDJmm6HN2J75h5WA=;
        b=pGuftnsVaBkGQnDl1/Lh3uoN9PTgltQ0dHYOQyqWzYBZ+bdO2iyJP5LBzYtdfWsVy8
         ZFClMYQP23ra9qcANohvdvULAX0UJ4dR1yb/Y6DEj7yhjoT30mTMS1sYHPC+i1wgoyDZ
         JNiqK5TDJQtWldHwk3oJqeFRpUxM0+gJynJoY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dYc4cFizASSVBKHhPMzmpYmWl6TWU1gm+m8SXrSsunoao07BdVe8Zv9U3T/T2M6Di3
         hKJQClV5Froz5JCeUFudpoFnmPS6161qnncLQMbglAyscfdENLw7u9xP5rKmeO2MyexL
         7+77mgZsOWsHsilKXLIsG6HXxXYc3ITZ/uFcI=
Received: by 10.103.64.28 with SMTP id r28mr2030242muk.11.1261170175067;
        Fri, 18 Dec 2009 13:02:55 -0800 (PST)
Received: from localhost.localdomain (abwt9.neoplus.adsl.tpnet.pl [83.8.243.9])
        by mx.google.com with ESMTPS id j2sm11112450mue.35.2009.12.18.13.02.53
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 18 Dec 2009 13:02:54 -0800 (PST)
X-Mailer: git-send-email 1.6.5.3
In-Reply-To: <m3tyvxd3pr.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135437>

From: John 'Warthog9' Hawley <warthog9@kernel.org>

This adds a "git" link for each project in the project list page,
should a common $gitlinkurl_base be defined and not empty.  The full
URL of each link is composed of $gitlinkurl_base and project name.
It is intended for git:// links, and in fact GITWEB_BASE_URL build
variable is used as its default value only if it starts with git://

This does make the assumption that the git repositories share a common
path.  Nothing to date is known to actually make use of introduced
link.

Created "git" link follows rel=vcs-* microformat specification:
  http://kitenet.net/~joey/rfc/rel-vcs/

Signed-off-by: John 'Warthog9' Hawley <warthog9@kernel.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
I think it might be good idea... but for the fact "Nothing to date is
known to actually make use of introduced link".  What's its intended
use?

Differences to original version by John 'Warthog9' Hawley (J.H.):
* It doesn't cause syntax error ;-)
* Escaping of attribute value is left to CGI.pm
* $gitlinkurl got renamed to $gitlinkurl_base, now includes git://
  prefix, and defaults to GITWEB_BASE_URL if it begins with git://
* Added description to gitweb/README
* Uses rel=vcs-* microformat by Joey Hess

I assume that nobody sane would define $gitlinkurl_base to "0"...

 gitweb/README      |    4 ++++
 gitweb/gitweb.perl |    8 ++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index 608b0f8..36fb059 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -71,6 +71,7 @@ You can specify the following configuration variables when building GIT:
  * GITWEB_BASE_URL
    Git base URLs used for URL to where fetch project from, i.e. full
    URL is "$git_base_url/$project".  Shown on projects summary page.
+   If it begins with "git://" it is also used for $gitlinkurl_base, see below.
    Repository URL for project can be also configured per repository; this
    takes precedence over URLs composed from base URL and a project name.
    Note that you can setup multiple base URLs (for example one for
@@ -204,6 +205,9 @@ not include variables usually directly set during build):
    access, and one for http:// "dumb" protocol access).  Note that per
    repository configuration in 'cloneurl' file, or as values of gitweb.url
    project config.
+ * $gitlinkurl_base
+   Git base URL used (if it is defined and not empty) for "git" link in
+   projects list, for each project.  Full URL is "$gitlinkurl_base/$project".
  * $default_blob_plain_mimetype
    Default mimetype for blob_plain (raw) view, if mimetype checking
    doesn't result in some other type; by default 'text/plain'.
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b9bd865..efb6471 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -224,6 +224,10 @@ our %avatar_size = (
 # If it is true, exit if gitweb version and git binary version don't match
 our $git_versions_must_match = 0;
 
+# If this variable is set and not empty, add an extra link called "git"
+# for each project in project list.  Full URL is "$gitlinkurl_base/$project".
+our $gitlinkurl_base = ("++GITWEB_BASE_URL++" =~ m!^(git://.*)$!) ? $1 : '';
+
 # Used to set the maximum load that we will still respond to gitweb queries.
 # If server load exceed this value then return "503 server busy" error.
 # If gitweb cannot determined server load, it is taken to be 0.
@@ -4472,6 +4476,10 @@ sub git_project_list_body {
 		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"log")}, "log") . " | " .
 		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"tree")}, "tree") .
 		      ($pr->{'forks'} ? " | " . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"forks")}, "forks") : '') .
+		      ($gitlinkurl_base ?
+		       " | " . $cgi->a({-href=>"$gitlinkurl_base/$pr->{'path'}",
+		                        -rel=>"vcs-git"}, "git")
+		      : '') .
 		      "</td>\n" .
 		      "</tr>\n";
 	}
-- 
1.6.5.3
