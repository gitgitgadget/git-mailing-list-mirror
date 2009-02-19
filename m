From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] http-push: using error() and warning() as appropriate
Date: Thu, 19 Feb 2009 13:07:08 +0100
Message-ID: <20090219120708.GM4371@genesis.frugalware.org>
References: <200902190736.49161.johnflux@gmail.com> <20090219081725.GB7774@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 13:08:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La7i1-0001ne-ND
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 13:08:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757968AbZBSMHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 07:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757449AbZBSMHQ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 07:07:16 -0500
Received: from virgo.iok.hu ([212.40.97.103]:50217 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755752AbZBSMHO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 07:07:14 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 9D2E3580D9;
	Thu, 19 Feb 2009 13:07:10 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id D61FA446A6;
	Thu, 19 Feb 2009 13:07:08 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id B55D911B877C; Thu, 19 Feb 2009 13:07:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090219081725.GB7774@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110682>

Change three occurrences of using inconsistent error/warning reporting
by using the relevant error() / warning() calls to be consistent with
the rest of the code.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Thu, Feb 19, 2009 at 03:17:25AM -0500, Jeff King <peff@peff.net> wrote:
> http-push seems to be the odd man out. It contains one fprintf(stderr,
> "Error: ...") and one totally bogus error("Error: ..."), which will
> print "error: Error: ...". Perhaps it would be better to scan through
> the code and switch to using error() and warning() as appropriate.

I found these 3 occurrences.

 http-push.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/http-push.c b/http-push.c
index 30d2d34..3a41d36 100644
--- a/http-push.c
+++ b/http-push.c
@@ -759,7 +759,7 @@ static void finish_request(struct transfer_request *request)
 			}
 		} else {
 			if (request->http_code == 416)
-				fprintf(stderr, "Warning: requested range invalid; we may already have all the data.\n");
+				warning("requested range invalid; we may already have all the data.");
 
 			git_inflate_end(&request->stream);
 			git_SHA1_Final(request->real_sha1, &request->c);
@@ -1616,7 +1616,7 @@ static int locking_available(void)
 			}
 			XML_ParserFree(parser);
 			if (!lock_flags)
-				error("Error: no DAV locking support on %s",
+				error("no DAV locking support on %s",
 				      remote->url);
 
 		} else {
@@ -2293,7 +2293,7 @@ int main(int argc, char **argv)
 		if (info_ref_lock)
 			remote->can_update_info_refs = 1;
 		else {
-			fprintf(stderr, "Error: cannot lock existing info/refs\n");
+			error("cannot lock existing info/refs");
 			rc = 1;
 			goto cleanup;
 		}
-- 
1.6.1
