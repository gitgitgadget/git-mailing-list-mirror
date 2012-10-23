From: Jeff King <peff@peff.net>
Subject: [PATCH 4/8] git-config: remove memory leak of key regexp
Date: Tue, 23 Oct 2012 18:36:50 -0400
Message-ID: <20121023223650.GD17392@sigill.intra.peff.net>
References: <20121023223502.GA23194@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 00:37:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQn6A-0000nX-GB
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 00:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757457Ab2JWWgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 18:36:55 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51684 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933603Ab2JWWgy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 18:36:54 -0400
Received: (qmail 23315 invoked by uid 107); 23 Oct 2012 22:37:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 23 Oct 2012 18:37:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Oct 2012 18:36:50 -0400
Content-Disposition: inline
In-Reply-To: <20121023223502.GA23194@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208265>

This is only called once per invocation, so it's not a major
leak, but it's easy to fix.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/config.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/config.c b/builtin/config.c
index e1c33e0..e660d48 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -248,6 +248,10 @@ static int get_value(const char *key_, const char *regex_)
 		git_config_from_file(fn, system_wide, data);
 
 	free(key);
+	if (key_regexp) {
+		regfree(key_regexp);
+		free(key_regexp);
+	}
 	if (regexp) {
 		regfree(regexp);
 		free(regexp);
-- 
1.8.0.3.g3456896
