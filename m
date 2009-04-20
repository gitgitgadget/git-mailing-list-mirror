From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] grep: don't support "grep.color"-like config options
Date: Tue, 21 Apr 2009 00:58:15 +0200
Message-ID: <1240268295-10296-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 01:00:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw2TC-0004Mq-6w
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 01:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757204AbZDTW6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 18:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755725AbZDTW6P
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 18:58:15 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:39488 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753450AbZDTW6O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 18:58:14 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id C7CF010045A0F;
	Tue, 21 Apr 2009 00:58:12 +0200 (CEST)
Received: from [89.59.65.183] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1Lw2RH-0002tk-00; Tue, 21 Apr 2009 00:58:11 +0200
X-Mailer: git-send-email 1.6.3.rc1.44.g269729
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX191p+c45M+d5XSpywOwIlsW5bjF9V4pCLc4q7lY
	AtZv1JecsNc594fTYTgh1g6yBhH19asegjEaDfZikgyskwx9wa
	u9qovMg8B4gdK3ndMb5g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117047>

color.grep and color.grep.* is the official and documented way to
highlight grep matches. Comparable options like diff.color.* and
status.color.* exist for backward compatibility reasons only and are not
documented any more.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 builtin-grep.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 89489dd..f88a912 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -26,16 +26,13 @@ static int grep_config(const char *var, const char *value, void *cb)
 {
 	struct grep_opt *opt = cb;
 
-	if (!strcmp(var, "grep.color") || !strcmp(var, "color.grep")) {
+	if (!strcmp(var, "color.grep")) {
 		opt->color = git_config_colorbool(var, value, -1);
 		return 0;
 	}
-	if (!strcmp(var, "grep.color.external") ||
-	    !strcmp(var, "color.grep.external")) {
+	if (!strcmp(var, "color.grep.external"))
 		return git_config_string(&(opt->color_external), var, value);
-	}
-	if (!strcmp(var, "grep.color.match") ||
-	    !strcmp(var, "color.grep.match")) {
+	if (!strcmp(var, "color.grep.match")) {
 		if (!value)
 			return config_error_nonbool(var);
 		color_parse(value, var, opt->color_match);
-- 
1.6.3.rc1.44.g269729
