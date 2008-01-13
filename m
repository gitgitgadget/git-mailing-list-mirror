From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] builtin-commit.c: remove useless check added by faulty cut and paste
Date: Sun, 13 Jan 2008 02:38:46 -0800
Message-ID: <7v8x2uqabt.fsf_-_@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0801121426510.2806@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801121735020.2806@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801121949180.2806@woody.linux-foundation.org>
	<7vtzliqh3u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Kristian H?gsberg <krh@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 13 11:39:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JE0FZ-0004br-LA
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 11:39:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbYAMKi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 05:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbYAMKi4
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 05:38:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63645 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274AbYAMKi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 05:38:56 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B08673F68;
	Sun, 13 Jan 2008 05:38:54 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C8173F67;
	Sun, 13 Jan 2008 05:38:51 -0500 (EST)
In-Reply-To: <7vtzliqh3u.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 13 Jan 2008 00:12:21 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70377>

When I did 2888605c649ccd423232161186d72c0e6c458a48
(builtin-commit: fix partial-commit support), I mindlessly cut
and pasted from builtin-ls-files.c, and included the part that
was meant to exclude redundant path after "ls-files --with-tree"
overlayed the HEAD commit on top of the index.  This logic does
not apply to what git-commit does and should not have been
copied, even though it would not hurt.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-commit.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 6d2ca80..265ba6b 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -156,8 +156,6 @@ static int list_paths(struct path_list *list, const char *with_tree,
 
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
-		if (ce->ce_flags & htons(CE_UPDATE))
-			continue;
 		if (!pathspec_match(pattern, m, ce->name, 0))
 			continue;
 		path_list_insert(ce->name, list);
