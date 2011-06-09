From: Jeff King <peff@peff.net>
Subject: [PATCH 08/10] remote: use new OPT_STRING_LIST
Date: Thu, 9 Jun 2011 11:55:59 -0400
Message-ID: <20110609155558.GH25507@sigill.intra.peff.net>
References: <20110609155001.GA14969@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Claire Fousse <claire.fousse@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 09 17:56:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUhab-00010y-3J
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 17:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754002Ab1FIP4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 11:56:04 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38436
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753886Ab1FIP4D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 11:56:03 -0400
Received: (qmail 14122 invoked by uid 107); 9 Jun 2011 15:56:10 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 Jun 2011 11:56:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jun 2011 11:55:59 -0400
Content-Disposition: inline
In-Reply-To: <20110609155001.GA14969@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175541>

This saves us having our own callback function.

Signed-off-by: Jeff King <peff@peff.net>
---
This isn't technically related to the rest of the series, but is a
cleanup we can do because of the previous commit.

 builtin/remote.c |   14 ++------------
 1 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 9ff1cac..05b1f5b 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -88,16 +88,6 @@ static inline int postfixcmp(const char *string, const char *postfix)
 	return strcmp(string + len1 - len2, postfix);
 }
 
-static int opt_parse_track(const struct option *opt, const char *arg, int not)
-{
-	struct string_list *list = opt->value;
-	if (not)
-		string_list_clear(list, 0);
-	else
-		string_list_append(list, arg);
-	return 0;
-}
-
 static int fetch_remote(const char *name)
 {
 	const char *argv[] = { "fetch", name, NULL, NULL };
@@ -176,8 +166,8 @@ static int add(int argc, const char **argv)
 			    TAGS_SET),
 		OPT_SET_INT(0, NULL, &fetch_tags,
 			    "or do not fetch any tag at all (--no-tags)", TAGS_UNSET),
-		OPT_CALLBACK('t', "track", &track, "branch",
-			"branch(es) to track", opt_parse_track),
+		OPT_STRING_LIST('t', "track", &track, "branch",
+				"branch(es) to track"),
 		OPT_STRING('m', "master", &master, "branch", "master branch"),
 		{ OPTION_CALLBACK, 0, "mirror", &mirror, "push|fetch",
 			"set up remote as a mirror to push to or fetch from",
-- 
1.7.6.rc1.36.g91167
