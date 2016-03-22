From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 2/3] builtin/apply: make gitdiff_verify_name() return void
Date: Tue, 22 Mar 2016 21:58:41 +0100
Message-ID: <1458680322-17681-3-git-send-email-chriscool@tuxfamily.org>
References: <1458680322-17681-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 22 22:06:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiTVt-00013t-5M
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 22:06:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753373AbcCVVGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 17:06:44 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35240 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768AbcCVVGm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 17:06:42 -0400
Received: by mail-wm0-f47.google.com with SMTP id l68so170583650wml.0
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 14:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fURLhFClonk31BMCrlmtSN+CDIJk2+R/RlUKF8iSXMA=;
        b=LnEJJDzyP2uRVGC0l+VSdSEDoNS9I4YgQ3HJ/tEyhCEuYO37x+mxe47UjFMi4Z2ZpD
         K95En2kW8NJ+PB1P65HeSW9EG+r64ueA6lieRvazeA6QCmxOhILpRWL9XEY8nFL1mbwT
         D/6ZWzzKDvd3NgTPM8pA10Wiva/iEXyrZ2SRKprdnWqO2k63XrG5hgtLVd/JP4EHeEGx
         5C6QAHsNgHYGmslm70hqco+S3MnV/fAws3/VLnwV/eMCkiiwBEh+TWJAuBrx9sya4ZfX
         EnHMHkcoSc4sfwBtHOZPnRm/sEyvoGsErv+qThOWuOkMjMwPIe5HZl92NHhUJJDx86HL
         LzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fURLhFClonk31BMCrlmtSN+CDIJk2+R/RlUKF8iSXMA=;
        b=YmTlTSfuRhD5wt2M8YDGtrbppSNgOV8hsFPLfE4ej6/Vxc1nxG3415Os6aIm4U7Pph
         QnLmyscJ8km4b7fmTZ5NPO0FLOYGhKjY5I88wnjakxiIoBjvbJBatmM1FBFAEsaZCavp
         rN1JmEhJtlTZOV6Aucn8P1asqWt1eIspm2BrcF90wTWCRxBynKaKkVrJODNi9/FUSz4/
         mOcf44kAgXK9nWw1sULVNoOrfJcTkwDRhby0WaYozaI7PCmaeLvqGVXmbIKgz7mfzfiY
         RQrTfoLArKju8Mmid014ZvbnlxlRn8gDWe0jJCBSWitpVXlsytgGgjV7aYvkTaZWg444
         TlwQ==
X-Gm-Message-State: AD7BkJKBTfFoAtQXLQmzX6jMO9gLKEEtRqbcrdHP3PNuS1wQaQNc80OlF5lJm9hE/7/BfQ==
X-Received: by 10.28.46.132 with SMTP id u126mr23369228wmu.67.1458680800842;
        Tue, 22 Mar 2016 14:06:40 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id i5sm31920087wjx.15.2016.03.22.14.06.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Mar 2016 14:06:39 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc4.59.g21809a1
In-Reply-To: <1458680322-17681-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289562>

As the value returned by gitdiff_verify_name() is put into the
same variable that is passed as a parameter to this function,
it is simpler to pass the address of the variable and have
gitdiff_verify_name() change the variable itself.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 465f954..4cafdaf 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -925,37 +925,37 @@ static int gitdiff_hdrend(const char *line, struct patch *patch)
 #define DIFF_OLD_NAME 0
 #define DIFF_NEW_NAME 1
 
-static char *gitdiff_verify_name(const char *line, int isnull, char *orig_name, int side)
+static void gitdiff_verify_name(const char *line, int isnull, char **name, int side)
 {
-	if (!orig_name && !isnull)
-		return find_name(line, NULL, p_value, TERM_TAB);
+	if (!*name && !isnull) {
+		*name = find_name(line, NULL, p_value, TERM_TAB);
+		return;
+	}
 
-	if (orig_name) {
-		int len = strlen(orig_name);
+	if (*name) {
+		int len = strlen(*name);
 		char *another;
 		if (isnull)
 			die(_("git apply: bad git-diff - expected /dev/null, got %s on line %d"),
-			    orig_name, linenr);
+			    *name, linenr);
 		another = find_name(line, NULL, p_value, TERM_TAB);
-		if (!another || memcmp(another, orig_name, len + 1))
+		if (!another || memcmp(another, *name, len + 1))
 			die((side == DIFF_NEW_NAME) ?
 			    _("git apply: bad git-diff - inconsistent new filename on line %d") :
 			    _("git apply: bad git-diff - inconsistent old filename on line %d"), linenr);
 		free(another);
-		return orig_name;
 	} else {
 		/* expect "/dev/null" */
 		if (memcmp("/dev/null", line, 9) || line[9] != '\n')
 			die(_("git apply: bad git-diff - expected /dev/null on line %d"), linenr);
-		return NULL;
 	}
 }
 
 static int gitdiff_oldname(const char *line, struct patch *patch)
 {
 	char *orig = patch->old_name;
-	patch->old_name = gitdiff_verify_name(line, patch->is_new, patch->old_name,
-					      DIFF_OLD_NAME);
+	gitdiff_verify_name(line, patch->is_new, &patch->old_name,
+			    DIFF_OLD_NAME);
 	if (orig != patch->old_name)
 		free(orig);
 	return 0;
@@ -964,8 +964,8 @@ static int gitdiff_oldname(const char *line, struct patch *patch)
 static int gitdiff_newname(const char *line, struct patch *patch)
 {
 	char *orig = patch->new_name;
-	patch->new_name = gitdiff_verify_name(line, patch->is_delete, patch->new_name,
-					      DIFF_NEW_NAME);
+	gitdiff_verify_name(line, patch->is_delete, &patch->new_name,
+			    DIFF_NEW_NAME);
 	if (orig != patch->new_name)
 		free(orig);
 	return 0;
-- 
2.8.0.rc4.1.g302de0d.dirty
