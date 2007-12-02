From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/6] builtin-commit: Add newline when showing which
	commit was created
Date: Sun, 2 Dec 2007 11:54:09 -0500
Message-ID: <20071202165409.GA30998@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0711111730580.4362@racer.site> <Pine.LNX.4.64.0711111736440.4362@racer.site> <20071201222106.GA27102@coredump.intra.peff.net> <Pine.LNX.4.64.0712012238510.27959@racer.site> <20071202054030.GA393@coredump.intra.peff.net> <Pine.LNX.4.64.0712021212490.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, krh@redhat.com, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 02 17:54:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iys5V-00043E-7l
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 17:54:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238AbXLBQyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 11:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752799AbXLBQyM
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 11:54:12 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4526 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752484AbXLBQyM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 11:54:12 -0500
Received: (qmail 21953 invoked by uid 111); 2 Dec 2007 16:54:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 02 Dec 2007 11:54:10 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Dec 2007 11:54:09 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0712021212490.27959@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66793>

On Sun, Dec 02, 2007 at 12:13:07PM +0000, Johannes Schindelin wrote:

> > It would be helpful if you could remember the test case, but perhaps
> > that is not an option at this point.
> 
> IIRC it was "git commit -m bla".

I have made several attempts to reproduce the problem, looked a bit
through the log-tree code, and checked the results of the t750* series
of tests; but I have found nothing. I think we are better off reverting,
which fixes every case I have seen; if the problem behavior comes back,
we will have figured out what causes it. And if it doesn't come back,
then the revert is the right thing. :)

-- >8 --
Revert "builtin-commit: Add newline when showing which commit was created"

This reverts commit 129fa606365c172d07a5d98bea9345277f221363.

We end up in most cases with an undesired extra newline. It
is possible that there is some corner case that requires the
newline, but there is no published test case. So let's fix
the known problem, and we can deal with the corner case if
and when there is a bug report.
---
 builtin-commit.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index f6e8e44..118853d 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -660,7 +660,6 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 	printf("Created %scommit ", initial_commit ? "initial " : "");
 
 	log_tree_commit(&rev, commit);
-	printf("\n");
 }
 
 int git_commit_config(const char *k, const char *v)
-- 
1.5.3.6.2094.g3713
