From: Jeff King <peff@peff.net>
Subject: [PATCH v3 06/14] remote.c: hoist read_config into remote_get_1
Date: Thu, 21 May 2015 00:45:23 -0400
Message-ID: <20150521044523.GF23409@peff.net>
References: <20150521044429.GA5857@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 06:45:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvIMR-0008U4-Ep
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 06:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753318AbbEUEp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 00:45:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:33685 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751750AbbEUEpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 00:45:25 -0400
Received: (qmail 2345 invoked by uid 102); 21 May 2015 04:45:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 23:45:26 -0500
Received: (qmail 31196 invoked by uid 107); 21 May 2015 04:45:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 May 2015 00:45:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 May 2015 00:45:23 -0400
Content-Disposition: inline
In-Reply-To: <20150521044429.GA5857@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269547>

Before the previous commit, we had to make sure that
read_config() was called before entering remote_get_1,
because we needed to pass pushremote_name by value. But now
that we pass a function, we can let remote_get_1 handle
loading the config itself, turning our wrappers into true
one-liners.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index a91d063..e6b29b3 100644
--- a/remote.c
+++ b/remote.c
@@ -718,6 +718,8 @@ static struct remote *remote_get_1(const char *name,
 	struct remote *ret;
 	int name_given = 0;
 
+	read_config();
+
 	if (name)
 		name_given = 1;
 	else
@@ -741,13 +743,11 @@ static struct remote *remote_get_1(const char *name,
 
 struct remote *remote_get(const char *name)
 {
-	read_config();
 	return remote_get_1(name, remote_for_branch);
 }
 
 struct remote *pushremote_get(const char *name)
 {
-	read_config();
 	return remote_get_1(name, pushremote_for_branch);
 }
 
-- 
2.4.1.528.g00591e3
