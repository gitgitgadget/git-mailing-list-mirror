From: Jeff King <peff@peff.net>
Subject: [PATCH] remote.c: spell __attribute__ correctly
Date: Mon, 25 Apr 2016 17:15:23 -0400
Message-ID: <20160425211523.GA11227@sigill.intra.peff.net>
References: <D7C0C4062A7242B6912E56480CBB06F4@PhilipOakley>
 <20160425211030.GA10309@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 23:15:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aunqu-0006Jl-96
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 23:15:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbcDYVP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 17:15:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:56078 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933361AbcDYVP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 17:15:26 -0400
Received: (qmail 8431 invoked by uid 102); 25 Apr 2016 21:15:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Apr 2016 17:15:26 -0400
Received: (qmail 6136 invoked by uid 107); 25 Apr 2016 21:15:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 25 Apr 2016 17:15:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Apr 2016 17:15:23 -0400
Content-Disposition: inline
In-Reply-To: <20160425211030.GA10309@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292559>

On Mon, Apr 25, 2016 at 05:10:30PM -0400, Jeff King wrote:

> It should be handled in git-compat-util.h, which is included by cache.h,
> which is included by remote.c.
> 
> There we have:
> 
>   #ifndef __GNUC__
>   #ifndef __attribute__
>   #define __attribute__(x)
>   #endif
>   #endif
> 
> which should make it a noop on compilers which don't know about it. Is
> VS (or another file) setting __GNUC__?

Of course it helps if we spell the name right...

-- >8 --
Subject: remote.c: spell __attribute__ correctly

We want to tell the compiler that error_buf() uses
printf()-style arguments via the __attribute__ mechanism,
but the original commit (3a429d0), forgot the trailing "__".
This happens to work with real GNUC-compatible compilers
like gcc and clang, but confuses our fallback macro in
git-compat-util.h, which only matches the official name (and
thus the build fails on compilers like Visual Studio).

Reported-by: Philip Oakley <philipoakley@iee.org>
Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 28fd676..ddc4f8f 100644
--- a/remote.c
+++ b/remote.c
@@ -1660,7 +1660,7 @@ int branch_merge_matches(struct branch *branch,
 	return refname_match(branch->merge[i]->src, refname);
 }
 
-__attribute((format (printf,2,3)))
+__attribute__((format (printf,2,3)))
 static const char *error_buf(struct strbuf *err, const char *fmt, ...)
 {
 	if (err) {
-- 
2.8.1.562.gc7e1b3c
