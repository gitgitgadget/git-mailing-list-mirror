From: Jeff King <peff@peff.net>
Subject: [PATCH 3/7] parse_object_buffer: do not set object type
Date: Fri, 11 Jul 2014 04:46:25 -0400
Message-ID: <20140711084625.GC5625@sigill.intra.peff.net>
References: <20140711084141.GA5521@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Jul 11 10:46:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5WTQ-0002ZX-F7
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 10:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbaGKIq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 04:46:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:59958 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751042AbaGKIq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 04:46:27 -0400
Received: (qmail 18500 invoked by uid 102); 11 Jul 2014 08:46:27 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Jul 2014 03:46:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jul 2014 04:46:25 -0400
Content-Disposition: inline
In-Reply-To: <20140711084141.GA5521@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253258>

The only way that "obj" can be non-NULL is if it came from
one of the lookup_* functions. These functions always ensure
that the object has the expected type (and return NULL
otherwise), so there is no need for us to set the type.

Signed-off-by: Jeff King <peff@peff.net>
---
 object.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/object.c b/object.c
index a950b85..472aa8d 100644
--- a/object.c
+++ b/object.c
@@ -213,8 +213,6 @@ struct object *parse_object_buffer(const unsigned char *sha1, enum object_type t
 		warning("object %s has unknown type id %d", sha1_to_hex(sha1), type);
 		obj = NULL;
 	}
-	if (obj && obj->type == OBJ_NONE)
-		obj->type = type;
 	return obj;
 }
 
-- 
2.0.0.566.gfe3e6b2
