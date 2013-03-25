From: Brad King <brad.king@kitware.com>
Subject: [PATCH v2] commit-tree: document -S option consistently
Date: Mon, 25 Mar 2013 17:00:07 -0400
Message-ID: <caae961c52f65d96b0476b3d85739d1989fa1602.1364244915.git.brad.king@kitware.com>
References: <7vy5dbw6w2.fsf@alter.siamese.dyndns.org>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 25 22:00:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKEVd-0006G8-Hb
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 22:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758915Ab3CYVAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 17:00:19 -0400
Received: from 66-194-253-20.static.twtelecom.net ([66.194.253.20]:48993 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754418Ab3CYVAT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 17:00:19 -0400
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id ADCB69AA7; Mon, 25 Mar 2013 17:00:07 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <7vy5dbw6w2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219089>

Commit ba3c69a9 (commit: teach --gpg-sign option, 2011-10-05) added the
-S option but documented it in the command usage without indicating that
the value is optional and forgot to mention it in the manpage.  Later
commit 098bbdc3 (Add -S, --gpg-sign option to manpage of "git commit",
2012-10-21) documented the option in the porcelain manpage.

Use wording from the porcelain manpage to document the option in the
plumbing manpage.  Also update the commit-tree usage summary to indicate
that the -S value is optional to be consistent with the manpage and with
the implementation.

Signed-off-by: Brad King <brad.king@kitware.com>
---

On 03/25/2013 04:39 PM, Junio C Hamano wrote:
> This does not seem to use the same wording, though.
> 
> 	git commit -S
> 
> will pick up the signing key by calling get_signing_key() the same
> way "git tag -s" would, iow, <keyid> part is optional.

Ahh, I was fooled by the commit-tree usage synopsis and didn't
read deeply enough into the implementation.  Here is an updated
patch to cover that too.

 Documentation/git-commit-tree.txt |    7 ++++++-
 builtin/commit-tree.c             |    2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index 86ef56e..cafdc96 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -10,7 +10,9 @@ SYNOPSIS
 --------
 [verse]
 'git commit-tree' <tree> [(-p <parent>)...] < changelog
-'git commit-tree' [(-p <parent>)...] [(-m <message>)...] [(-F <file>)...] <tree>
+'git commit-tree' [(-p <parent>)...] [-S[<keyid>]] [(-m <message>)...]
+		  [(-F <file>)...] <tree>
+
 
 DESCRIPTION
 -----------
@@ -52,6 +54,9 @@ OPTIONS
 	Read the commit log message from the given file. Use `-` to read
 	from the standard input.
 
+-S[<keyid>]::
+	GPG-sign commit.
+
 
 Commit Information
 ------------------
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index eac901a..f641ff2 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -10,7 +10,7 @@
 #include "utf8.h"
 #include "gpg-interface.h"
 
-static const char commit_tree_usage[] = "git commit-tree [(-p <sha1>)...] [-S<signer>] [-m <message>] [-F <file>] <sha1> <changelog";
+static const char commit_tree_usage[] = "git commit-tree [(-p <sha1>)...] [-S[<keyid>]] [-m <message>] [-F <file>] <sha1> <changelog";
 
 static void new_parent(struct commit *parent, struct commit_list **parents_p)
 {
-- 
1.7.10.4
