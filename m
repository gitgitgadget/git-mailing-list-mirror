From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation/git-diff: remove -r from --name-status
	example
Date: Sun, 29 Jul 2007 05:49:56 -0400
Message-ID: <20070729094955.GA14915@coredump.intra.peff.net>
References: <20070729002427.GA1566@coredump.intra.peff.net> <alpine.LFD.0.999.0707281905050.3442@woody.linux-foundation.org> <20070729041159.GA5544@coredump.intra.peff.net> <alpine.LFD.0.999.0707282119010.3442@woody.linux-foundation.org> <7vbqdvolww.fsf@assigned-by-dhcp.cox.net> <7vwswjmu08.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 29 11:50:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF5PX-000666-DS
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 11:50:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761131AbXG2Jt7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 05:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761132AbXG2Jt7
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 05:49:59 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2303 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761081AbXG2Jt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 05:49:58 -0400
Received: (qmail 26369 invoked from network); 29 Jul 2007 09:49:58 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 29 Jul 2007 09:49:58 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 29 Jul 2007 05:49:56 -0400
Content-Disposition: inline
In-Reply-To: <7vwswjmu08.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54102>

On Sun, Jul 29, 2007 at 02:36:23AM -0700, Junio C Hamano wrote:

> In short, I think recursive behaviour by default makes sense for
> "git diff".

Your reasoning sounds sane to me.

Here is the patch with a commit message more succint than all of these
emails.

-- >8 --
git-diff: turn on recursion by default

The tree recursion behavior of git-diff may appear
inconsistent to the user because it depends on the format of
the patch as well as whether one is diffing between trees or
against the index.

Since git-diff is a porcelain wrapper for low-level diff
commands, it makes sense for its behavior to be consistent
no matter what is being diffed.  This patch turns on
recursion in all cases.

diff --git a/builtin-diff.c b/builtin-diff.c
index 7f367b6..b48121e 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -233,6 +233,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 			die("diff_setup_done failed");
 	}
 	rev.diffopt.allow_external = 1;
+	rev.diffopt.recursive = 1;
 
 	/* Do we have --cached and not have a pending object, then
 	 * default to HEAD by hand.  Eek.
