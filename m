From: Jeff King <peff@peff.net>
Subject: [PATCH 1/4] config: make environment parsing routines static
Date: Tue, 24 May 2011 18:49:36 -0400
Message-ID: <20110524224936.GA24527@sigill.intra.peff.net>
References: <20110524224903.GA16265@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 25 00:49:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QP0Q4-00049X-8E
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 00:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161Ab1EXWtj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 18:49:39 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36208
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752177Ab1EXWti (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 18:49:38 -0400
Received: (qmail 22714 invoked by uid 107); 24 May 2011 22:49:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 May 2011 18:49:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 May 2011 18:49:36 -0400
Content-Disposition: inline
In-Reply-To: <20110524224903.GA16265@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174355>

Nobody outside of git_config_from_parameters should need
to use the GIT_CONFIG_PARAMETERS parsing functions, so let's
make them private.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h  |    2 --
 config.c |    4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 28a921d..69e09a1 100644
--- a/cache.h
+++ b/cache.h
@@ -1037,8 +1037,6 @@ typedef int (*config_fn_t)(const char *, const char *, void *);
 extern int git_default_config(const char *, const char *, void *);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
 extern void git_config_push_parameter(const char *text);
-extern int git_config_parse_parameter(const char *text);
-extern int git_config_parse_environment(void);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
 extern int git_config(config_fn_t fn, void *);
 extern int git_config_early(config_fn_t fn, void *, const char *repo_config);
diff --git a/config.c b/config.c
index 9d36848..46aeb9c 100644
--- a/config.c
+++ b/config.c
@@ -47,7 +47,7 @@ void git_config_push_parameter(const char *text)
 	strbuf_release(&env);
 }
 
-int git_config_parse_parameter(const char *text)
+static int git_config_parse_parameter(const char *text)
 {
 	struct config_item *ct;
 	struct strbuf tmp = STRBUF_INIT;
@@ -74,7 +74,7 @@ int git_config_parse_parameter(const char *text)
 	return 0;
 }
 
-int git_config_parse_environment(void) {
+static int git_config_parse_environment(void) {
 	const char *env = getenv(CONFIG_DATA_ENVIRONMENT);
 	char *envw;
 	const char **argv = NULL;
-- 
1.7.4.5.7.g2e01
