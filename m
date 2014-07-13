From: Jeff King <peff@peff.net>
Subject: [PATCH v2 4/8] parse_object_buffer: do not set object type
Date: Sun, 13 Jul 2014 02:42:00 -0400
Message-ID: <20140713064159.GD4852@sigill.intra.peff.net>
References: <20140713064116.GA4768@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Jul 13 08:42:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6DU8-00006A-5a
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 08:42:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814AbaGMGmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2014 02:42:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:32935 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752391AbaGMGmC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 02:42:02 -0400
Received: (qmail 30925 invoked by uid 102); 13 Jul 2014 06:42:02 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 13 Jul 2014 01:42:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Jul 2014 02:42:00 -0400
Content-Disposition: inline
In-Reply-To: <20140713064116.GA4768@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253440>

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
