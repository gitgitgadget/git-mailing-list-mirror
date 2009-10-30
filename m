From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] clone: detect extra arguments
Date: Fri, 30 Oct 2009 10:45:25 -0400
Message-ID: <20091030144525.GA22583@coredump.intra.peff.net>
References: <20091029081030.GA11213@progeny.tock>
 <20091029160614.GB7622@sigill.intra.peff.net>
 <20091030111919.GA13242@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 15:46:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3sjZ-0001aZ-1Y
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 15:45:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbZJ3Opb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 10:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbZJ3Opb
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 10:45:31 -0400
Received: from peff.net ([208.65.91.99]:36448 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932259AbZJ3Opa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 10:45:30 -0400
Received: (qmail 32748 invoked by uid 107); 30 Oct 2009 14:49:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 30 Oct 2009 10:49:13 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Oct 2009 10:45:25 -0400
Content-Disposition: inline
In-Reply-To: <20091030111919.GA13242@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131705>

On Fri, Oct 30, 2009 at 06:19:19AM -0500, Jonathan Nieder wrote:

> > Should we maybe be showing the usage in this case?
> 
> Sounds reasonable.  How about this patch on top?

I do think it's an improvement, but...

> -- %< --
> Subject: [PATCH] clone: print usage on wrong number of arguments
> 
> git clone's short usage string is only 22 lines, so an error
> message plus usage string still fits comfortably on an 80x24
> terminal.

The extra blank lines introduced by usage_msg_opt make it 25 lines,
scrolling the message right off of my terminal screen. ;)

But looking at the usage message, there is some potential for cleanup.
So maybe this on top (or between your 1 and 2)?

-- >8 --
Subject: [PATCH] clone: hide "naked" option from usage message

This is just a little-known synonym for bare, and there is
little point in advertising both (we don't even include it
in the manpage). Removing it also makes the usage message
one line shorter, giving just enough room for an information
message in a 24-line terminal.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-clone.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 736d9e1..ce0d79a 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -51,7 +51,9 @@ static struct option builtin_clone_options[] = {
 	OPT_BOOLEAN('n', "no-checkout", &option_no_checkout,
 		    "don't create a checkout"),
 	OPT_BOOLEAN(0, "bare", &option_bare, "create a bare repository"),
-	OPT_BOOLEAN(0, "naked", &option_bare, "create a bare repository"),
+	{ OPTION_BOOLEAN, 0, "naked", &option_bare, NULL,
+		"create a bare repository",
+		PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
 	OPT_BOOLEAN(0, "mirror", &option_mirror,
 		    "create a mirror repository (implies bare)"),
 	OPT_BOOLEAN('l', "local", &option_local,
-- 
1.6.5.1.143.g1dab74.dirty
