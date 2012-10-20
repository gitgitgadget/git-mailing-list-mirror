From: David Soria Parra <dsp@php.net>
Subject: [PATCH] grep: remove tautological check
Date: Sat, 20 Oct 2012 19:26:04 +0200
Message-ID: <1350753964-29346-1-git-send-email-dsp@php.net>
Cc: David Soria Parra <dsp@php.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 20 19:33:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPcvQ-0003kU-Cu
	for gcvg-git-2@plane.gmane.org; Sat, 20 Oct 2012 19:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756505Ab2JTRdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2012 13:33:16 -0400
Received: from config.schlueters.de ([217.114.211.66]:65489 "EHLO
	config.schlueters.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756441Ab2JTRdP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2012 13:33:15 -0400
X-Greylist: delayed 415 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Oct 2012 13:33:15 EDT
Received: from Achird.local (HSI-KBW-149-172-196-164.hsi13.kabel-badenwuerttemberg.de [149.172.196.164])
	by config.schlueters.de (Postfix) with ESMTPA id 7C55065078;
	Sat, 20 Oct 2012 19:26:12 +0200 (CEST)
X-Mailer: git-send-email 1.8.0.rc3.332.g181c802
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208090>

The enum grep_header_field is unsigned. Therefore the field part of the
grep_pat structure is unsigned and cannot be less then 0. We remove the
tautological check for p->field < 0.

Signed-off-by: David Soria Parra <dsp@php.net>
---
 grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index 4bd1b8b..db177ef 100644
--- a/grep.c
+++ b/grep.c
@@ -625,7 +625,7 @@ static struct grep_expr *prep_header_patterns(struct grep_opt *opt)
 	for (p = opt->header_list; p; p = p->next) {
 		if (p->token != GREP_PATTERN_HEAD)
 			die("bug: a non-header pattern in grep header list.");
-		if (p->field < 0 || GREP_HEADER_FIELD_MAX <= p->field)
+		if (GREP_HEADER_FIELD_MAX <= p->field)
 			die("bug: unknown header field %d", p->field);
 		compile_regexp(p, opt);
 	}
-- 
1.8.0.rc3.332.g181c802
