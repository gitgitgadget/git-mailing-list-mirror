From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] merge: indicate remote tracking branches in merge
 message
Date: Sun, 9 Aug 2009 06:07:12 -0400
Message-ID: <20090809100712.GA26250@coredump.intra.peff.net>
References: <20090809065936.GA24112@coredump.intra.peff.net>
 <7vab29a1fr.fsf@alter.siamese.dyndns.org>
 <20090809074035.GA4778@coredump.intra.peff.net>
 <20090809091443.GA676@coredump.intra.peff.net>
 <20090809100045.GA25197@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 12:07:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ma5JE-0006VG-6h
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 12:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753748AbZHIKHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 06:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753699AbZHIKHO
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 06:07:14 -0400
Received: from peff.net ([208.65.91.99]:41628 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753673AbZHIKHN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 06:07:13 -0400
Received: (qmail 3177 invoked by uid 107); 9 Aug 2009 10:09:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 09 Aug 2009 06:09:27 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Aug 2009 06:07:12 -0400
Content-Disposition: inline
In-Reply-To: <20090809100045.GA25197@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125341>

On Sun, Aug 09, 2009 at 06:00:45AM -0400, Jeff King wrote:

>   [1/3] add tests for merge message headings
>   [2/3] merge: fix incorrect merge message for ambiguous tag/branch
>   [3/3] merge: indicate remote tracking branches in merge message

And here is the 4/3 you mentioned earlier:

-- >8 --
Subject: [PATCH] merge: describe tags as such in merge message

Previously, merging a tag directly via "git merge tag" would
get you the message "Merge commit 'tag'". It is a little
more descriptive to note that it was actually a tag (i.e.,
"Merge tag 'tag'").

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-merge.c           |    5 +++++
 t/t7608-merge-messages.sh |    4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index f4de73f..db74901 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -380,6 +380,11 @@ static void merge_name(const char *remote, struct strbuf *msg)
 				    sha1_to_hex(branch_head), remote);
 			goto cleanup;
 		}
+		if (!prefixcmp(found_ref, "refs/tags/")) {
+			strbuf_addf(msg, "%s\t\ttag '%s' of .\n",
+				    sha1_to_hex(branch_head), remote);
+			goto cleanup;
+		}
 	}
 
 	/* See if remote matches <name>^^^.. or <name>~<number> */
diff --git a/t/t7608-merge-messages.sh b/t/t7608-merge-messages.sh
index 28d5679..3ee0983 100755
--- a/t/t7608-merge-messages.sh
+++ b/t/t7608-merge-messages.sh
@@ -35,7 +35,7 @@ test_expect_success 'merge tag' '
 	git checkout master &&
 	test_commit master-3 &&
 	git merge tag-1 &&
-	check_oneline "Merge commit Qtag-1Q"
+	check_oneline "Merge tag Qtag-1Q"
 '
 
 test_expect_success 'ambiguous tag' '
@@ -44,7 +44,7 @@ test_expect_success 'ambiguous tag' '
 	git checkout master &&
 	test_commit master-4 &&
 	git merge ambiguous &&
-	check_oneline "Merge commit QambiguousQ"
+	check_oneline "Merge tag QambiguousQ"
 '
 
 test_expect_success 'remote branch' '
-- 
1.6.4.178.g7a987
