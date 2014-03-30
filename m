From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH v4 2/3] parse-options: add cast to correct pointer type to OPT_SET_PTR
Date: Sun, 30 Mar 2014 15:08:22 +0400
Message-ID: <55b78495a0a171d0dbe3ec5a39d04359e1989b91.1396177208.git.marat@slonopotamus.org>
References: <cover.1396177207.git.marat@slonopotamus.org>
Cc: Marat Radchenko <marat@slonopotamus.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 30 13:09:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUDbn-0001wx-NQ
	for gcvg-git-2@plane.gmane.org; Sun, 30 Mar 2014 13:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221AbaC3LIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2014 07:08:51 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:47141 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbaC3LIo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2014 07:08:44 -0400
Received: from [176.57.72.72] (helo=noblesse.home.ru)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WUDbU-0000Hw-Ld; Sun, 30 Mar 2014 15:08:40 +0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <cover.1396177207.git.marat@slonopotamus.org>
In-Reply-To: <cover.1396177207.git.marat@slonopotamus.org>
References: <7vtxago359.fsf@alter.siamese.dyndns.org> <cover.1396177207.git.marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245462>

Do not force users of OPT_SET_PTR to cast pointer to correct
underlying pointer type by integrating cast into OPT_SET_PTR macro.

Cast is required to prevent 'initialization makes integer from pointer
without a cast' compiler warning.
---
 parse-options.h      | 2 +-
 test-parse-options.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/parse-options.h b/parse-options.h
index 8fa02dc..54099d9 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -129,7 +129,7 @@ struct option {
 #define OPT_HIDDEN_BOOL(s, l, v, h) { OPTION_SET_INT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1}
 #define OPT_SET_PTR(s, l, v, h, p)  { OPTION_SET_PTR, (s), (l), (v), NULL, \
-				      (h), PARSE_OPT_NOARG, NULL, (p) }
+				      (h), PARSE_OPT_NOARG, NULL, (intptr_t)(p) }
 #define OPT_CMDMODE(s, l, v, h, i) { OPTION_CMDMODE, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, (i) }
 #define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v), N_("n"), (h) }
diff --git a/test-parse-options.c b/test-parse-options.c
index 6f6c656..10da63e 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -60,7 +60,7 @@ int main(int argc, char **argv)
 		OPT_STRING('o', NULL, &string, "str", "get another string"),
 		OPT_NOOP_NOARG(0, "obsolete"),
 		OPT_SET_PTR(0, "default-string", &string,
-			"set string to default", (intptr_t)"default"),
+			"set string to default", "default"),
 		OPT_STRING_LIST(0, "list", &list, "str", "add str to list"),
 		OPT_GROUP("Magic arguments"),
 		OPT_ARGUMENT("quux", "means --quux"),
-- 
1.9.0
