From: Jeff King <peff@peff.net>
Subject: [PATCH 1/5] receive-pack: don't copy "dir" parameter
Date: Thu, 24 Jul 2014 00:40:43 -0400
Message-ID: <20140724044042.GA32355@peff.net>
References: <20140724043940.GA31282@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <stefanbeller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 24 06:40:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAApr-0002Lb-47
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 06:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934061AbaGXEkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 00:40:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:39353 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934043AbaGXEkv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 00:40:51 -0400
Received: (qmail 20501 invoked by uid 102); 24 Jul 2014 04:40:51 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Jul 2014 23:40:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jul 2014 00:40:43 -0400
Content-Disposition: inline
In-Reply-To: <20140724043940.GA31282@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254144>

We used to do this so could pass a mutable string to
enter_repo. But since 1c64b48 (enter_repo: do not modify
input, 2011-10-04), this is not necessary.

The resulting code is simpler, and it fixes a minor leak.

Signed-off-by: Jeff King <peff@peff.net>
---
If you are wondering whether upload-pack needs the same treatment, we
already did it in 6379dd0.

 builtin/receive-pack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 92561bf..f93ac45 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1122,7 +1122,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	int advertise_refs = 0;
 	int stateless_rpc = 0;
 	int i;
-	char *dir = NULL;
+	const char *dir = NULL;
 	struct command *commands;
 	struct sha1_array shallow = SHA1_ARRAY_INIT;
 	struct sha1_array ref = SHA1_ARRAY_INIT;
@@ -1157,7 +1157,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		}
 		if (dir)
 			usage(receive_pack_usage);
-		dir = xstrdup(arg);
+		dir = arg;
 	}
 	if (!dir)
 		usage(receive_pack_usage);
-- 
2.0.0.566.gfe3e6b2
