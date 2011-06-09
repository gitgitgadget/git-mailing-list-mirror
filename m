From: Jeff King <peff@peff.net>
Subject: [PATCH 06/10] config: use strbuf_split_str instead of a temporary
 strbuf
Date: Thu, 9 Jun 2011 11:55:09 -0400
Message-ID: <20110609155509.GF25507@sigill.intra.peff.net>
References: <20110609155001.GA14969@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Claire Fousse <claire.fousse@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 09 17:55:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUhZm-0000SZ-Iq
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 17:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754056Ab1FIPzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 11:55:13 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38424
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754013Ab1FIPzM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 11:55:12 -0400
Received: (qmail 14058 invoked by uid 107); 9 Jun 2011 15:55:20 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 Jun 2011 11:55:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jun 2011 11:55:09 -0400
Content-Disposition: inline
In-Reply-To: <20110609155001.GA14969@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175539>

This saves an allocation and copy, and also fixes a minor
memory leak.

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index 2517b62..189b766 100644
--- a/config.c
+++ b/config.c
@@ -42,10 +42,8 @@ void git_config_push_parameter(const char *text)
 static int git_config_parse_parameter(const char *text,
 				      config_fn_t fn, void *data)
 {
-	struct strbuf tmp = STRBUF_INIT;
 	struct strbuf **pair;
-	strbuf_addstr(&tmp, text);
-	pair = strbuf_split_max(&tmp, '=', 2);
+	pair = strbuf_split_str(text, '=', 2);
 	if (!pair[0])
 		return error("bogus config parameter: %s", text);
 	if (pair[0]->len && pair[0]->buf[pair[0]->len - 1] == '=')
-- 
1.7.6.rc1.36.g91167
