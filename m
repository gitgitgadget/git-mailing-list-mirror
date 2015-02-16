From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] git_push_config: drop cargo-culted wt_status pointer
Date: Mon, 16 Feb 2015 00:46:30 -0500
Message-ID: <20150216054629.GA25088@peff.net>
References: <20150216054550.GA24611@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Dave Olszewski <cxreg@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 06:46:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNEVw-0007pv-OB
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 06:46:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104AbbBPFqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 00:46:32 -0500
Received: from cloud.peff.net ([50.56.180.127]:49367 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751695AbbBPFqc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 00:46:32 -0500
Received: (qmail 8044 invoked by uid 102); 16 Feb 2015 05:46:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 15 Feb 2015 23:46:32 -0600
Received: (qmail 12234 invoked by uid 107); 16 Feb 2015 05:46:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Feb 2015 00:46:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Feb 2015 00:46:30 -0500
Content-Disposition: inline
In-Reply-To: <20150216054550.GA24611@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263871>

The push config callback does not expect any incoming data
via the void pointer. And if it did, it would certainly not
be a "struct wt_status". This probably got picked up
accidentally in b945901 (push: heed user.signingkey for
signed pushes, 2014-10-22), which copied the template for
the config callback from builtin/commit.c.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/push.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index fc771a9..aa9334c 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -473,13 +473,12 @@ static int option_parse_recurse_submodules(const struct option *opt,
 
 static int git_push_config(const char *k, const char *v, void *cb)
 {
-	struct wt_status *s = cb;
 	int status;
 
 	status = git_gpg_config(k, v, NULL);
 	if (status)
 		return status;
-	return git_default_config(k, v, s);
+	return git_default_config(k, v, NULL);
 }
 
 int cmd_push(int argc, const char **argv, const char *prefix)
-- 
2.3.0.rc1.287.g761fd19
