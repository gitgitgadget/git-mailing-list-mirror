From: Jeff King <peff@peff.net>
Subject: [PATCH 09/10] config: make git_config_parse_parameter a public
 function
Date: Thu, 9 Jun 2011 11:56:42 -0400
Message-ID: <20110609155642.GI25507@sigill.intra.peff.net>
References: <20110609155001.GA14969@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Claire Fousse <claire.fousse@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 09 17:56:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUhbG-0001Wn-Re
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 17:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119Ab1FIP4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 11:56:46 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38443
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753886Ab1FIP4q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 11:56:46 -0400
Received: (qmail 14156 invoked by uid 107); 9 Jun 2011 15:56:53 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 Jun 2011 11:56:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jun 2011 11:56:42 -0400
Content-Disposition: inline
In-Reply-To: <20110609155001.GA14969@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175542>

We use this internally to parse "git -c core.foo=bar", but
the general format of "key=value" is useful for other
places.

Signed-off-by: Jeff King <peff@peff.net>
---
This could perhaps have a better name than "parameter". I dunno.

 cache.h  |    2 ++
 config.c |    4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index e11cf6a..933be72 100644
--- a/cache.h
+++ b/cache.h
@@ -1063,6 +1063,8 @@ extern int config_error_nonbool(const char *);
 extern const char *get_log_output_encoding(void);
 extern const char *get_commit_output_encoding(void);
 
+extern int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
+
 extern const char *config_exclusive_filename;
 
 #define MAX_GITNAME (1000)
diff --git a/config.c b/config.c
index 189b766..25d998c 100644
--- a/config.c
+++ b/config.c
@@ -39,8 +39,8 @@ void git_config_push_parameter(const char *text)
 	strbuf_release(&env);
 }
 
-static int git_config_parse_parameter(const char *text,
-				      config_fn_t fn, void *data)
+int git_config_parse_parameter(const char *text,
+			       config_fn_t fn, void *data)
 {
 	struct strbuf **pair;
 	pair = strbuf_split_str(text, '=', 2);
-- 
1.7.6.rc1.36.g91167
