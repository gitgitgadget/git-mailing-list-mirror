From: "John J. Franey" <jjfraney@gmail.com>
Subject: [DOC-PATCH v2] Clarify description of <repository> argument to
	pull/fetch for naming remotes.
Date: Thu, 29 May 2008 13:32:31 -0400
Message-ID: <1212082351.12242.6.camel@isidore.myhome.westell.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 29 19:33:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1m0I-0002r3-7P
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 19:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387AbYE2Rch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 13:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753733AbYE2Rch
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 13:32:37 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:25504 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923AbYE2Rcg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 13:32:36 -0400
Received: by an-out-0708.google.com with SMTP id d40so87094and.103
        for <git@vger.kernel.org>; Thu, 29 May 2008 10:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=D1JgeNBgHISFmZSwW/WU8QRBCdZRDH80v5LID+pMSsU=;
        b=VsLnaUbF3kNY6gbE4AqANAxHJPXena4GGH13Wv3D5mTMQLsNekujiL5tDyOzoYRLCQ5z3o96GvqGeJF3YL/g0drBzxFKU8BuNGMA5HT8uttbyPwCYySWDwnTAazAVbe0q7NE7pj8SUouk9vIYArYNoQcbk68eaRKpg7wWhFBS5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=KXtacmP0OsicE5UyWmPJ9K9LIxA6ENGEIOdghrRYLDuuTw+4hBS4yWagOg2mk4+x90NImCiz7PpA/9LNU8tTTGB5kWF7ePDjlhJt17d8ezy1ZZatmB+n2nHFqDsS6ENYL4r8m5J9kUAPmPnmNdMQ185bi5aAqxTCmVtT3yy4AZA=
Received: by 10.100.125.12 with SMTP id x12mr3283506anc.159.1212082355404;
        Thu, 29 May 2008 10:32:35 -0700 (PDT)
Received: from ?192.168.2.102? ( [70.21.168.140])
        by mx.google.com with ESMTPS id 20sm1116116agb.12.2008.05.29.10.32.30
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 29 May 2008 10:32:31 -0700 (PDT)
X-Mailer: Evolution 2.22.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83223>


Alter the description of <repository> in OPTIONS section to
explicitly state that a 'remote name' is accepted.
Rewrite REMOTES section to more directly identify the
different kinds of remote-name permitted.

Signed-off-by: John J. Franey <jjfraney@gmail.com>
---

 Here is a second version of a proposal to change the
 wording in git-pull/git-fetch.  I believe I have addressed all
 of Junio's comments.

 Documentation/pull-fetch-param.txt |    4 +-
 Documentation/urls-remotes.txt     |   93 +++++++++++++++++++++++-------------
 2 files changed, 63 insertions(+), 34 deletions(-)

diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index b6eb7fc..cbee369 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -1,6 +1,8 @@
 <repository>::
 	The "remote" repository that is the source of a fetch
-	or pull operation.  See the section <<URLS,GIT URLS>> below.
+	or pull operation.  This parameter can be either a URL
+	(see the section <<URLS,GIT URLS>> below) or the name
+	of a remote (see the section <<REMOTES,REMOTES>> below).
 
 <refspec>::
 	The canonical format of a <refspec> parameter is
diff --git a/Documentation/urls-remotes.txt b/Documentation/urls-remotes.txt
index 5dd1f83..9975300 100644
--- a/Documentation/urls-remotes.txt
+++ b/Documentation/urls-remotes.txt
@@ -1,55 +1,82 @@
 include::urls.txt[]
 
-REMOTES
--------
+REMOTES[[REMOTES]]
+------------------
 
-In addition to the above, as a short-hand, the name of a
-file in `$GIT_DIR/remotes` directory can be given; the
-named file should be in the following format:
+The name of one of the following can be used instead
+of a URL as `<repository>` argument:
 
-------------
-	URL: one of the above URL format
-	Push: <refspec>
-	Pull: <refspec>
+* a remote in the git configuration file: `$GIT_DIR/config`,
+* a file in the `$GIT_DIR/remotes` directory, or
+* a file in the `$GIT_DIR/branches` directory.
 
-------------
+All of these also allow you to omit the refspec from the command line
+because they each contain a refspec which git will use by default.
 
-Then such a short-hand is specified in place of
-<repository> without <refspec> parameters on the command
-line, <refspec> specified on `Push:` lines or `Pull:`
-lines are used for `git-push` and `git-fetch`/`git-pull`,
-respectively.  Multiple `Push:` and `Pull:` lines may
-be specified for additional branch mappings.
+Named remote in configuration file
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Or, equivalently, in the `$GIT_DIR/config` (note the use
-of `fetch` instead of `Pull:`):
+You can choose to provide the name of a remote which you had previously
+configured using linkgit:git-remote[1], linkgit:git-config[1]
+or even by a manual edit to the `$GIT_DIR/config` file.  The URL of
+this remote will be used to access the repository.  The refspec
+of this remote will be used by default when you do
+not provide a refspec on the command line.  The entry in the
+config file would appear like this:
 
 ------------
-	[remote "<remote>"]
+	[remote "<name>"]
 		url = <url>
 		push = <refspec>
 		fetch = <refspec>
-
 ------------
 
-The name of a file in `$GIT_DIR/branches` directory can be
-specified as an older notation short-hand; the named
-file should contain a single line, a URL in one of the
-above formats, optionally followed by a hash `#` and the
-name of remote head (URL fragment notation).
-`$GIT_DIR/branches/<remote>` file that stores a <url>
-without the fragment is equivalent to have this in the
-corresponding file in the `$GIT_DIR/remotes/` directory.
+
+Named file in `$GIT_DIR/remotes`
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+You can choose to provide the name of a
+file in `$GIT_DIR/remotes`.  The URL
+in this file will be used to access the repository.  The refspec
+in this file will be used as default when you do not
+provide a refspec on the command line.  This file should have the
+following format:
+
+------------
+	URL: one of the above URL format
+	Push: <refspec>
+	Pull: <refspec>
 
 ------------
-	URL: <url>
-	Pull: refs/heads/master:<remote>
 
+`Push:` lines are used by `git-push` and
+`Pull:` lines are used by `git-pull` and `git-fetch`.
+Multiple `Push:` and `Pull:` lines may
+be specified for additional branch mappings.
+
+Named file in `$GIT_DIR/branches`
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+You can choose to provide the name of a
+file in `$GIT_DIR/branches`.
+The URL in this file will be used to access the repository.
+This file should have the following format:
+
+
+------------
+	<url>#<head>
 ------------
 
-while having `<url>#<head>` is equivalent to
+`<url>` is required; `#<head>` is optional.
+When you do not provide a refspec on the command line,
+git will use the following refspec, where `<head>` defaults to `master`,
+and `<repository>` is the name of this file
+you provided in the command line.
 
 ------------
-	URL: <url>
-	Pull: refs/heads/<head>:<remote>
+	refs/heads/<head>:<repository>
 ------------
+
+
+
+
-- 
1.5.4.3
