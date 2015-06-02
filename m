From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v4 0/4] submodule config lookup API
Date: Tue, 2 Jun 2015 16:24:36 +0200
Message-ID: <20150602142436.GA7713@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, "W. Trevor King" <wking@tremily.us>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 16:24:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yzn7J-0001Pw-2E
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 16:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758868AbbFBOY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 10:24:29 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.43]:57358 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755833AbbFBOY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 10:24:28 -0400
Received: from [31.17.191.210] (helo=book.hvoigt.net)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Yzn79-0004fJ-VC; Tue, 02 Jun 2015 16:24:24 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270545>

Since there were no other comments than style fixes here is another
iteration. The last iteration can be found here:

http://article.gmane.org/gmane.comp.version-control.git/269611

I found there is a merge conflict with master so I rebased this series
to master.

The interdiff to last iteration contains nothing spectacular:

diff --git a/submodule-config.c b/submodule-config.c
index 177767d..199692b 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -27,7 +27,7 @@ struct submodule_entry {
 
 enum lookup_type {
 	lookup_name,
-	lookup_path,
+	lookup_path
 };
 
 static struct submodule_cache cache;
@@ -390,12 +390,12 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 		return submodule;
 
 	switch (lookup_type) {
-		case lookup_name:
-			submodule = cache_lookup_name(cache, sha1, key);
-			break;
-		case lookup_path:
-			submodule = cache_lookup_path(cache, sha1, key);
-			break;
+	case lookup_name:
+		submodule = cache_lookup_name(cache, sha1, key);
+		break;
+	case lookup_path:
+		submodule = cache_lookup_path(cache, sha1, key);
+		break;
 	}
 	if (submodule)
 		return submodule;
@@ -419,12 +419,12 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	free(config);
 
 	switch (lookup_type) {
-		case lookup_name:
-			submodule = cache_lookup_name(cache, sha1, key);
-			break;
-		case lookup_path:
-			submodule = cache_lookup_path(cache, sha1, key);
-			break;
+	case lookup_name:
+		submodule = cache_lookup_name(cache, sha1, key);
+		break;
+	case lookup_path:
+		submodule = cache_lookup_path(cache, sha1, key);
+		break;
 	}
 
 	return submodule;
diff --git a/submodule-config.h b/submodule-config.h
index 58afc83..9061e4e 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -24,6 +24,6 @@ const struct submodule *submodule_from_name(const unsigned char *commit_sha1,
 		const char *name);
 const struct submodule *submodule_from_path(const unsigned char *commit_sha1,
 		const char *path);
-void submodule_free();
+void submodule_free(void);
 
 #endif /* SUBMODULE_CONFIG_H */


Heiko Voigt (4):
  implement submodule config cache for lookup of submodule names
  extract functions for submodule config set and lookup
  use new config API for worktree configurations of submodules
  do not die on error of parsing fetchrecursesubmodules option

 .gitignore                                       |   1 +
 Documentation/technical/api-submodule-config.txt |  63 +++
 Makefile                                         |   2 +
 builtin/checkout.c                               |   1 +
 builtin/fetch.c                                  |   1 +
 diff.c                                           |   1 +
 submodule-config.c                               | 484 +++++++++++++++++++++++
 submodule-config.h                               |  29 ++
 submodule.c                                      | 122 ++----
 submodule.h                                      |   4 +-
 t/t7411-submodule-config.sh                      | 153 +++++++
 test-submodule-config.c                          |  76 ++++
 12 files changed, 839 insertions(+), 98 deletions(-)
 create mode 100644 Documentation/technical/api-submodule-config.txt
 create mode 100644 submodule-config.c
 create mode 100644 submodule-config.h
 create mode 100755 t/t7411-submodule-config.sh
 create mode 100644 test-submodule-config.c

-- 
2.4.2.391.g2979c89
