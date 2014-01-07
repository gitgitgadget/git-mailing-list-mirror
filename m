From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] cat-file: fix a minor memory leak in batch_objects
Date: Tue, 7 Jan 2014 17:10:35 -0500
Message-ID: <20140107221035.GB10161@sigill.intra.peff.net>
References: <20140107220856.GA10074@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brodie Rao <brodie@sf.io>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 23:10:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0erD-0006BF-8C
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 23:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774AbaAGWKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 17:10:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:56758 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753783AbaAGWKi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 17:10:38 -0500
Received: (qmail 27856 invoked by uid 102); 7 Jan 2014 22:10:38 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jan 2014 16:10:38 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jan 2014 17:10:35 -0500
Content-Disposition: inline
In-Reply-To: <20140107220856.GA10074@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240170>

We should always have been freeing our strbuf, but doing so
consistently was annoying until the refactoring in the
previous patch.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 971cdde..ce79103 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -314,6 +314,7 @@ static int batch_objects(struct batch_options *opt)
 			break;
 	}
 
+	strbuf_release(&buf);
 	return retval;
 }
 
-- 
1.8.5.2.500.g8060133
