From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [REQUEST 1/1] docs: update http.<url>.* options documentation
Date: Thu, 25 Jul 2013 15:39:13 -0700
Message-ID: <ec5ecd4fe44af87e83778ce8e297afe@f74d39fa044aa309eaea14b9f57fe79>
References: <4b44f95a1b574b5d92a15254e4e8523@f74d39fa044aa309eaea14b9f57fe79>
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 26 00:39:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2UC1-0007Tx-DH
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 00:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756850Ab3GYWjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jul 2013 18:39:25 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:54644 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756768Ab3GYWjY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jul 2013 18:39:24 -0400
Received: by mail-pa0-f44.google.com with SMTP id jh10so2538606pab.3
        for <git@vger.kernel.org>; Thu, 25 Jul 2013 15:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9GPo4+hVJIYCdtLnMJhybZLxbSLdSvMbF2J1bgZvewk=;
        b=GkZz3IKAf4UAu6vyE6INbg+6Y1abVw5Bir0eMwyW0NxhJO4fV79aT+cFAvuaHox3i1
         2hcTtHN2492opxXUbeeqlmBjibaa6UtfSNgHp6rC7by4KGXuHFGyspfJCJw8p27mwGRa
         wBOmC4tHCQk+drgM98JVAxqlN4Vc0mIgXQ3AJueCgy21ZiT8r/45NpF0NuqEbxqSZ1c4
         k9fLArY1KfNClGvbaRQQU6Tji1OZZwmpJMuzWEDDFZ7Va7nPQ/k/pwjJwpY7isvWjvQ9
         3hONiKT2uifzZkIjYuR86qzsnH7A3MXPJht7oGDLA3NaIsgM6qQYifYMaCI5k+wzqMiF
         h7Tw==
X-Received: by 10.68.163.195 with SMTP id yk3mr49617328pbb.142.1374791963928;
        Thu, 25 Jul 2013 15:39:23 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id uj1sm362905pac.21.2013.07.25.15.39.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 25 Jul 2013 15:39:23 -0700 (PDT)
In-Reply-To: <4b44f95a1b574b5d92a15254e4e8523@f74d39fa044aa309eaea14b9f57fe79>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231155>

Overhaul the text of the http.<url>.* options documentation
providing a hopefully easier to understand itemized list of
matching behavior as suggested by and including text from
Jeff King.
---
 Documentation/config.txt | 60 +++++++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6b135be..8ff966d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1515,30 +1515,44 @@ http.useragent::
 
 http.<url>.*::
 	Any of the http.* options above can be applied selectively to some urls.
-	For example "http.https://example.com.useragent" would set the user
-	agent only for https connections to example.com.  The <url> value
-	matches a url if it refers to the same scheme, host and port and the
-	path portion is an exact match or a prefix that matches at a "/"
-	boundary.  If <url> does not include a user name, it will match a url
-	with any username otherwise the user name must match as well (the
-	password part, if present in the url, is always ignored).  A <url>
-	with longer path matches takes precedence over shorter matches no matter
-	what order they occur in the configuration file.
+	For a config key to match a URL, each element of the config key is
+	compared to that of the URL, in the following order:
 +
-For example, if both "https://user@example.com/path" and
-"https://example.com/path/name" are used as a config <url> value and
-then "https://user@example.com/path/name/here" is passed to a git
-command, the settings in the "https://example.com/path/name" section
-will be preferred because that <url> has a longer path length match than
-"https://user@example.com/path" even though the latter did match the
-user.  For same length matches, the last one wins except that a same
-length <url> match that includes a user name will be preferred over a
-same length <url> match that does not.  The urls are normalized before
-matching so that equivalent urls that are simply spelled differently
-will match properly.  Environment variable settings always override any
-matches.  The urls that are matched against are those given directly to
-git commands.  This means any urls visited as a result of a redirection
-do not participate in matching.
+--
+. Scheme (e.g., `https` in `https://example.com/`). This field
+  must match exactly between the config key and the URL.
+. Host/domain name (e.g., `example.com` in `https://example.com/`).
+  This field must match exactly between the config key and the URL.
+. Port number (e.g., `8080` in `http://example.com:8080/`).
+  This field must match exactly between the config key and the URL.
+  Omitted port numbers are automatically converted to the correct
+  default for the scheme before matching.
+. Path (e.g., `repo.git` in `https://example.com/repo.git`). The
+  path field of the config key must match the path field of the URL
+  either exactly or as a prefix of slash-delimited path elements.  This means
+  a config key with path `foo/` matches URL path `foo/bar`.  A prefix can only
+  match on a slash (`/`) boundary.  Longer matches take precedence (so a config
+  key with path `foo/bar` is a better match to URL path `foo/bar` than a config
+  key with just path `foo/`).
+. Exact user name match (e.g., `user` in `https://user@example.com/repo.git`).
+  If the config key has a user name it must match the user name in the URL
+  exactly.
+. Any user name match.  If a config key does not have a user name, that config
+  key will match a URL with any user name (including none).
+--
++
+The list above is ordered by decreasing precedence; a URL that matches
+a config key's path is preferred to one that matches its user name. For example,
+if the URL is `https://user@example.com/foo/bar` a config key match of
+`https://example.com/foo` will be preferred over a config key match of
+`https://user@example.com`.
++
+All URLs are normalized before attempting any matching (the password part,
+if embedded in the URL, is always ignored for matching purposes) so that
+equivalent urls that are simply spelled differently will match properly.
+Environment variable settings always override any matches.  The urls that are
+matched against are those given directly to Git commands.  This means any URLs
+visited as a result of a redirection do not participate in matching.
 
 i18n.commitEncoding::
 	Character encoding the commit messages are stored in; Git itself
-- 
1.8.3
