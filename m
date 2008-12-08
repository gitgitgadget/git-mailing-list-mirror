From: Jeff King <peff@peff.net>
Subject: [gitk PATCH 3/3] gitk: allow text-conversion in diffs
Date: Sun, 7 Dec 2008 22:00:46 -0500
Message-ID: <20081208030046.GC22072@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Dec 08 04:02:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9WNq-0004GO-98
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 04:02:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754772AbYLHDAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2008 22:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754589AbYLHDAs
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 22:00:48 -0500
Received: from peff.net ([208.65.91.99]:4718 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754548AbYLHDAs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2008 22:00:48 -0500
Received: (qmail 21467 invoked by uid 111); 8 Dec 2008 03:00:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 07 Dec 2008 22:00:47 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Dec 2008 22:00:46 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102523>

The "textconv" feature of git requires explicit enabling in
plumbing because the resulting diffs are not useful for
feeding to "git-apply" or "patch". Thus any callers should
make a conscious choice that they want the human-friendly
version.

Since the diffs presented by gitk are meant primarily for
human consumption, and not applying, it makes sense to allow
text conversion.
---
Paul,

I am cc'ing you only on 3/3 since it is the only gitk patch (the others
implement --textconv in git itself). Textconv is basically a feature to
show human-readable text diffs of binary files by doing a one-way binary
to text conversion (and so they can't be applied).

I think gitk would always want to support these; if not, then the
alternative is a "diff flags" option for gitk where the user could
specify this flag manually.

 gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index a5e24e4..0fb87c7 100755
--- a/gitk
+++ b/gitk
@@ -7198,7 +7198,7 @@ proc getblobdiffs {ids} {
     global limitdiffs vfilelimit curview
     global diffencoding targetline diffnparents
 
-    set cmd [diffcmd $ids "-p -C --cc --no-commit-id -U$diffcontext"]
+    set cmd [diffcmd $ids "-p -C --cc --no-commit-id -U$diffcontext --textconv"]
     if {$ignorespace} {
 	append cmd " -w"
     }
-- 
1.6.1.rc2.285.gc1cf2
