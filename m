From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH/RFC] parse-options: allow to define hidden synonym options
Date: Sun, 18 Nov 2007 22:09:41 -0800
Message-ID: <7v4pfircka.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Nov 19 07:10:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Itzpf-0003B9-Sx
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 07:10:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbXKSGJs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 01:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbXKSGJs
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 01:09:48 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:45395 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbXKSGJr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 01:09:47 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 9EC9B2EF;
	Mon, 19 Nov 2007 01:10:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 255CD93F84;
	Mon, 19 Nov 2007 01:10:05 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65404>

By setting the help member to NULL, you can implement an option
that is not shown in the "git-cmd -h" help output.  This is
useful to support backward compatible synonyms without
cluttering the help text.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 parse-options.c |    2 ++
 parse-options.h |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index d3e608a..1ee2c81 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -284,6 +284,8 @@ void usage_with_options(const char * const *usagestr,
 			if (*opts->help)
 				fprintf(stderr, "%s\n", opts->help);
 			continue;
+		} else if (!opts->help) {
+			continue;
 		}
 
 		pos = fprintf(stderr, "    ");
diff --git a/parse-options.h b/parse-options.h
index a8760ac..de249a0 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -49,7 +49,7 @@ typedef int parse_opt_cb(const struct option *, const char *arg, int unset);
  *
  * `help`::
  *   the short help associated to what the option does.
- *   Must never be NULL (except for OPTION_END).
+ *   option with this field set to NULL does not appear in the help listing.
  *   OPTION_GROUP uses this pointer to store the group header.
  *
  * `flags`::
-- 
1.5.3.6.1779.ga3ed
