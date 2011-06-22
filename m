From: Jeff King <peff@peff.net>
Subject: [PATCHv2 2/9] archive-tar: don't reload default config options
Date: Tue, 21 Jun 2011 21:22:20 -0400
Message-ID: <20110622012220.GB30604@sigill.intra.peff.net>
References: <20110622011923.GA30370@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 22 03:22:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZC9E-0004Bx-Rb
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 03:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757792Ab1FVBWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 21:22:23 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56452
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757545Ab1FVBWW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 21:22:22 -0400
Received: (qmail 7356 invoked by uid 107); 22 Jun 2011 01:22:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 21 Jun 2011 21:22:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Jun 2011 21:22:20 -0400
Content-Disposition: inline
In-Reply-To: <20110622011923.GA30370@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176205>

We load our own tar-specific config, and then chain to
git_default_config. This is pointless, as our caller should
already have loaded the default config. It also introduces a
needless inconsistency with the zip archiver, which does not
look at the config files at all (and therefore relies on the
caller to have loaded config).

Signed-off-by: Jeff King <peff@peff.net>
---
Last time the tar-filter code was not integrated with the tar code.
Since we are now under tar.*, and since the tar code reads the config
anyway, it makes sense for us to use that config callback. This was just
a little nit I noticed while changing it.

 archive-tar.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index cee06ce..1ab1a2c 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -231,7 +231,7 @@ static int git_tar_config(const char *var, const char *value, void *cb)
 		}
 		return 0;
 	}
-	return git_default_config(var, value, cb);
+	return 0;
 }
 
 int write_tar_archive(struct archiver_args *args)
-- 
1.7.5.4.44.g4b107
