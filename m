From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v6 1/3] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
Date: Thu, 12 May 2016 11:02:05 +0530
Message-ID: <1463031127-17718-2-git-send-email-pranit.bauva@gmail.com>
References: <1462546167-1125-1-git-send-email-pranit.bauva@gmail.com>
 <1463031127-17718-1-git-send-email-pranit.bauva@gmail.com>
Cc: Pranit Bauva <pranit.bauva@gmail.com>, christian.couder@gmail.com,
	chriscool@tuxfamily.org, larsxschneider@gmail.com,
	Johannes.Schindelin@gmx.de, sunshine@sunshineco.com,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 07:33:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0jFJ-0005S3-FT
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 07:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbcELFdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 01:33:10 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36046 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbcELFdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 01:33:09 -0400
Received: by mail-pa0-f68.google.com with SMTP id i5so5181599pag.3
        for <git@vger.kernel.org>; Wed, 11 May 2016 22:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lsPiTNhi6mOxB8d2iBEqMJKi2eKtqi/4SVkHXlaMJDs=;
        b=X8JZ9EEBq/LRdHsPc4ZqGXHYV0f0ZAUhEQGgfCVRt6lLHHXp1D/8J9L6M4wUCdscyz
         e/GGVmREqUPHtQIKsrG39a3M6E3dxXR9cX5oxNVH+npSqykHMBqAH517A/V9O3kXI3rG
         lOiJLewSbuH/FFXvWJKukESyjIXt4vcNh7Hs4PktdDHRxW6Tcvi8ij5M3TKWimy7t43Q
         Ty8mxUEEsdiDGZlz8Rm81UFbsMMfR3UwFDbvvHfPaP2ZQehJNcDemiGmAyRLh3Fiz8gX
         BAvFXnON3KFQ3ZUDgUqP1Ixoqb5GtAezLExni+2B9/KBSCr2tYxXBGWEVGym76LpHSew
         tEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lsPiTNhi6mOxB8d2iBEqMJKi2eKtqi/4SVkHXlaMJDs=;
        b=hcJlu56z1RJwokQp8NmxinjXegbHbUsWaokJ58rpVxK5jPIydeFJpuWeNOYaiRym4Y
         mHlAakZ8AmvFtA+JWIbzDtQjHK7mHJphkBTRLM+lddEhiJHcdGhwWxzS3HRWiiFOENFl
         aElWYF1iIPpn3cWLT7UEVJQ6tIuZ/aL8FOT6FubfJh89d+2q5eMziCZstrbYmJuI2iRs
         D/FlQAPFfY2KhyBcpz6dGdSjk8R7Dowq2rL2XhwJp8qFtRJDm17dIH0gh0R07aCB6eWp
         DH7OTy1J8dj7JVZslzD/0XyB0NJXSpkgIo8wBH3VtFuPF88ECSUJHOFa5T+pN0yuTCCY
         gigg==
X-Gm-Message-State: AOPr4FUyhQlQ5B3cIyQqsKMiRy2AKa1+GlwGEY2c35PRm6Z0WdNcnZ29WnzYiVzcsMMrLw==
X-Received: by 10.66.177.16 with SMTP id cm16mr10868109pac.23.1463031189007;
        Wed, 11 May 2016 22:33:09 -0700 (PDT)
Received: from localhost.localdomain ([111.119.199.22])
        by smtp.gmail.com with ESMTPSA id m86sm8585820pfj.77.2016.05.11.22.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 22:33:08 -0700 (PDT)
X-Mailer: git-send-email 2.8.2
In-Reply-To: <1463031127-17718-1-git-send-email-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294387>

`--next-all` is meant to be used as a subcommand to support multiple
"operation mode" though the current implementation does not contain any
other subcommand along side with `--next-all` but further commits will
include some more subcommands.

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 3324229..8111c91 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -10,11 +10,11 @@ static const char * const git_bisect_helper_usage[] = {
 
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
-	int next_all = 0;
+	enum { NEXT_ALL = 1 } cmdmode = 0;
 	int no_checkout = 0;
 	struct option options[] = {
-		OPT_BOOL(0, "next-all", &next_all,
-			 N_("perform 'git bisect next'")),
+		OPT_CMDMODE(0, "next-all", &cmdmode,
+			 N_("perform 'git bisect next'"), NEXT_ALL),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -23,9 +23,14 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options,
 			     git_bisect_helper_usage, 0);
 
-	if (!next_all)
+	if (!cmdmode)
 		usage_with_options(git_bisect_helper_usage, options);
 
-	/* next-all */
-	return bisect_next_all(prefix, no_checkout);
+	switch (cmdmode) {
+	case NEXT_ALL:
+		return bisect_next_all(prefix, no_checkout);
+	default:
+		die("BUG: unknown subcommand '%d'", cmdmode);
+	}
+	return 0;
 }
-- 
2.8.2
