From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/9] git commit --dry-run -v: show diff in color when asked
Date: Sat, 15 Aug 2009 15:39:50 -0700
Message-ID: <1250375997-10657-3-git-send-email-gitster@pobox.com>
References: <1250375997-10657-1-git-send-email-gitster@pobox.com>
 <1250375997-10657-2-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 16 00:40:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McRv4-0003Yf-K4
	for gcvg-git-2@gmane.org; Sun, 16 Aug 2009 00:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668AbZHOWkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 18:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752658AbZHOWkF
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 18:40:05 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53132 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbZHOWkE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 18:40:04 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 58240C4F7
	for <git@vger.kernel.org>; Sat, 15 Aug 2009 18:40:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E778EC4F6 for
 <git@vger.kernel.org>; Sat, 15 Aug 2009 18:40:04 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.227.g1d720
In-Reply-To: <1250375997-10657-2-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 93D96F40-89EC-11DE-BD47-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126036>

The earlier implementation of --dry-run didn't duplicate the use of color
"git status -v" set up for diff output.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Unchanged since the last round.

 builtin-commit.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 1c200eb..200ffda 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -979,9 +979,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	argc = parse_and_validate_options(argc, argv, builtin_commit_usage,
 					  prefix, &s);
-	if (dry_run)
+	if (dry_run) {
+		if (diff_use_color_default == -1)
+			diff_use_color_default = git_use_color_default;
 		return dry_run_commit(argc, argv, prefix, &s);
-
+	}
 	index_file = prepare_index(argc, argv, prefix, 0);
 
 	/* Set up everything for writing the commit object.  This includes
-- 
1.6.4.224.g3be84
