From: Jeff King <peff@peff.net>
Subject: [PATCH 6/6] diff: run external diff helper with shell
Date: Wed, 30 Dec 2009 06:03:35 -0500
Message-ID: <20091230110335.GF22959@coredump.intra.peff.net>
References: <20091230095634.GA16349@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 12:03:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPwL8-0005OA-DZ
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 12:03:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671AbZL3LDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 06:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752564AbZL3LDi
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 06:03:38 -0500
Received: from peff.net ([208.65.91.99]:45823 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752070AbZL3LDi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 06:03:38 -0500
Received: (qmail 5272 invoked by uid 107); 30 Dec 2009 11:08:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 30 Dec 2009 06:08:20 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Dec 2009 06:03:35 -0500
Content-Disposition: inline
In-Reply-To: <20091230095634.GA16349@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135886>

This is mostly to make it more consistent with the rest of
git, which uses the shell to exec helpers.

Signed-off-by: Jeff King <peff@peff.net>
---
Consistency is the main advantage here. Though I think you can actually
do craziness like setting

  GIT_EXTERNAL_DIFF='my-command $2 $3 && true' git diff

to pick out some subset of the parameters, I can't imagine it is
actually a good idea.

 diff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index 2794238..9bb40bc 100644
--- a/diff.c
+++ b/diff.c
@@ -2294,7 +2294,7 @@ static void run_external_diff(const char *pgm,
 	}
 	*arg = NULL;
 	fflush(NULL);
-	retval = run_command_v_opt(spawn_arg, 0);
+	retval = run_command_v_opt(spawn_arg, RUN_USING_SHELL);
 	remove_tempfile();
 	if (retval) {
 		fprintf(stderr, "external diff died, stopping at %s.\n", name);
-- 
1.6.6.65.g050d2.dirty
