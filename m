From: Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH 1/2] bugfix: segfault on git diff --output=/bad/path
Date: Mon, 15 Feb 2010 23:10:45 -0500
Message-ID: <1266293446-8092-1-git-send-email-larry@elder-gods.org>
Cc: Larry D'Anna <larry@elder-gods.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 05:10:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhEm1-0004Hi-Az
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 05:10:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932585Ab0BPEKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 23:10:52 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:58099 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932547Ab0BPEKv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 23:10:51 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 191A1822010; Mon, 15 Feb 2010 23:10:51 -0500 (EST)
X-Mailer: git-send-email 1.7.0.rc2.40.g7d8aa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140064>

The return value from fopen wasn't being checked.

Signed-off-by: Larry D'Anna <larry@elder-gods.org>
---
 diff.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 381cc8d..68def6c 100644
--- a/diff.c
+++ b/diff.c
@@ -2893,6 +2893,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		;
 	else if (!prefixcmp(arg, "--output=")) {
 		options->file = fopen(arg + strlen("--output="), "w");
+		if (!options->file)
+			die_errno("Could not open '%s'", arg + strlen("--output="));
 		options->close_file = 1;
 	} else
 		return 0;
-- 
1.7.0.rc2.40.g7d8aa
