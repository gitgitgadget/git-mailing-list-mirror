From: Jeff King <peff@peff.net>
Subject: Re: BUG: Git command causes crash
Date: Sun, 18 Dec 2011 00:03:22 -0500
Message-ID: <20111218050322.GA1787@sigill.intra.peff.net>
References: <CAOgd6zFr5LorTK6X5o6NQE3L61KhaUZG9tX4LEB4_Na_YKPPpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ryan O'Hara <minitech.me@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 18 06:03:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rc8uJ-0001du-M2
	for gcvg-git-2@lo.gmane.org; Sun, 18 Dec 2011 06:03:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876Ab1LRFD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Dec 2011 00:03:28 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45225
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750695Ab1LRFDY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Dec 2011 00:03:24 -0500
Received: (qmail 18325 invoked by uid 107); 18 Dec 2011 05:10:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 18 Dec 2011 00:10:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Dec 2011 00:03:22 -0500
Content-Disposition: inline
In-Reply-To: <CAOgd6zFr5LorTK6X5o6NQE3L61KhaUZG9tX4LEB4_Na_YKPPpA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187412>

On Sat, Dec 17, 2011 at 07:13:53PM -0800, Ryan O'Hara wrote:

> On Git for Windows (MinGW), at least, this command causes git to crash:
> 
> git commit -a --no-message --dry-run

On Linux, too, using just "git commit --no-message" (whether there is
something to commit or not). This fixes it for me.

-- >8 --
Subject: [PATCH] commit: initialize static strbuf

Strbufs cannot rely on static all-zero initialization;
instead, they must use STRBUF_INIT to point to the
"slopbuf".

Without this patch, "git commit --no-message" segfaults
reliably.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/commit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d0f27f9..336faff 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -104,7 +104,7 @@
 static int use_editor = 1, include_status = 1;
 static int show_ignored_in_status;
 static const char *only_include_assumed;
-static struct strbuf message;
+static struct strbuf message = STRBUF_INIT;
 
 static int null_termination;
 static enum {
-- 
1.7.8.rc3.14.gd2470
