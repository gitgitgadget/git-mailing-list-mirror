From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/6] builtin-checkout.c: check error return from read_cache()
Date: Fri,  5 Dec 2008 17:54:10 -0800
Message-ID: <1228528455-3089-2-git-send-email-gitster@pobox.com>
References: <1228528455-3089-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 06 02:55:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8mOb-0005h5-Cl
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 02:55:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbYLFBye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2008 20:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755216AbYLFBy3
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Dec 2008 20:54:29 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63544 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755139AbYLFBy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2008 20:54:27 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EFD8184EE9
	for <git@vger.kernel.org>; Fri,  5 Dec 2008 20:54:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5C34684EE7 for
 <git@vger.kernel.org>; Fri,  5 Dec 2008 20:54:21 -0500 (EST)
X-Mailer: git-send-email 1.6.1.rc1.72.ga5ce6
In-Reply-To: <1228528455-3089-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: CD39D5CA-C338-11DD-82CA-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102434>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-checkout.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 7f3bd7b..c2c0561 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -228,7 +228,8 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec,
 	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
 
 	newfd = hold_locked_index(lock_file, 1);
-	read_cache();
+	if (read_cache() < 0)
+		return error("corrupt index file");
 
 	if (source_tree)
 		read_tree_some(source_tree, pathspec);
@@ -371,7 +372,9 @@ static int merge_working_tree(struct checkout_opts *opts,
 	int ret;
 	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
 	int newfd = hold_locked_index(lock_file, 1);
-	read_cache();
+
+	if (read_cache() < 0)
+		return error("corrupt index file");
 
 	if (opts->force) {
 		ret = reset_tree(new->commit->tree, opts, 1);
-- 
1.6.1.rc1.72.ga5ce6
