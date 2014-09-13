From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] prune-packed: fix minor memory leak
Date: Sat, 13 Sep 2014 16:16:53 -0400
Message-ID: <20140913201653.GA27082@peff.net>
References: <20140913201538.GA24854@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <stefanbeller@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 13 22:17:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XStkh-0002lB-MQ
	for gcvg-git-2@plane.gmane.org; Sat, 13 Sep 2014 22:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244AbaIMUQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2014 16:16:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:47797 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752227AbaIMUQz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2014 16:16:55 -0400
Received: (qmail 8732 invoked by uid 102); 13 Sep 2014 20:16:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Sep 2014 15:16:55 -0500
Received: (qmail 10259 invoked by uid 107); 13 Sep 2014 20:17:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Sep 2014 16:17:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Sep 2014 16:16:53 -0400
Content-Disposition: inline
In-Reply-To: <20140913201538.GA24854@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256973>

We form all of our directories in a strbuf, but never release it.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/prune-packed.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index 6879468..d430731 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -68,6 +68,7 @@ void prune_packed_objects(int opts)
 		rmdir(pathname.buf);
 	}
 	stop_progress(&progress);
+	strbuf_release(&pathname);
 }
 
 int cmd_prune_packed(int argc, const char **argv, const char *prefix)
-- 
2.1.0.373.g91ca799
