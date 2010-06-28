From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add known breakage for 'git notes copy'
Date: Mon, 28 Jun 2010 04:59:07 -0400
Message-ID: <20100628085907.GA14014@coredump.intra.peff.net>
References: <41768aafce7a581e8b601e70826ce77381458a23.1277708369.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Jun 28 10:59:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTABX-0003H4-7N
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 10:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755303Ab0F1I7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 04:59:17 -0400
Received: from peff.net ([208.65.91.99]:36398 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754792Ab0F1I7R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 04:59:17 -0400
Received: (qmail 18057 invoked by uid 107); 28 Jun 2010 09:00:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 28 Jun 2010 05:00:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Jun 2010 04:59:07 -0400
Content-Disposition: inline
In-Reply-To: <41768aafce7a581e8b601e70826ce77381458a23.1277708369.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149822>

On Mon, Jun 28, 2010 at 09:01:57AM +0200, Bert Wesarg wrote:

> 'git notes copy' dumps core when no arguments are given.

How about:

-- >8 --
Subject: [PATCH] notes: check number of parameters to "git notes copy"

Otherwise we may segfault with too few parameters.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/notes.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index f1f53a8..190005f 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -613,8 +613,12 @@ static int copy(int argc, const char **argv, const char *prefix)
 			return notes_copy_from_stdin(force, rewrite_cmd);
 		}
 	}
 
+	if (argc < 2) {
+		error("too few parameters");
+		usage_with_options(git_notes_copy_usage, options);
+	}
 	if (2 < argc) {
 		error("too many parameters");
 		usage_with_options(git_notes_copy_usage, options);
 	}
-- 
1.7.1.777.gd07fd
