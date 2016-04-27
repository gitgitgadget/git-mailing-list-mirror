From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] submodule-config: don't shadow `cache`
Date: Wed, 27 Apr 2016 14:30:40 -0700
Message-ID: <1461792640-18898-2-git-send-email-sbeller@google.com>
References: <1461792640-18898-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Apr 27 23:31:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avX2x-0004eb-5M
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 23:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753787AbcD0Vas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 17:30:48 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34031 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775AbcD0Var (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 17:30:47 -0400
Received: by mail-pa0-f51.google.com with SMTP id r5so24234658pag.1
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 14:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fc54TkOpCm2Vs5PSwqHEYmDCPbaltL5RjdExilsUCtg=;
        b=L5Y7odQ2Zxxah27pgp5iCj3T+ODgrT0McPmCnmJ7lLYnbPUWlEDaRXaRfuFQWZCFLE
         A/oI0ItM4XeskzGv/un9M6GLImN4kERkqyB/7Ug+ElDj0tMBkHZ5Tqr8JMfuFRzoIu+w
         ue35y79mxdmuEijWGGTOR/P1p8lKSGeQZhbPcF0haeIjpslAgY1/MR2d7GIL2la7M8fs
         7pPaM87Awlf4YzRnIY6yiFAPw3At6zA9/eR7UgIp1g6w3sspGUGshMdrQc/H/89LycHx
         ml28mi5xTsCxB2TWjw7GCX7dM6W+E5/TNbWq+eBCmt6GoY9/VT7Du8pzVPbdYSE1Ncsc
         CCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fc54TkOpCm2Vs5PSwqHEYmDCPbaltL5RjdExilsUCtg=;
        b=MS75evCakCA77Y4j46dsG/NhedgHOnYErs0qGRxCfx14GOohaxCd/3JU6SZOP5wk8F
         Hn9SAr3YYLPpEeGjgEXfl6amiyBLUj4KqzZKRghGzOIJqfPZczlrDKaCIvDAT0l3LSKg
         VqsQsy7PAGVc1VX61aRr6ZyFBl37Je/KjuaQIzI/EIhugswDeKHL2gR8ucoacYGhrdpV
         D+tyPOGqaYWknPWpEGoVCg78pOGOndiYp+mjMMaEw0s+OgDiDhhzAZwgTeoHVb8DA21o
         3tRsJ0F02Vh7hiyVCVVFsCMPMzDFPIa5I5/D5NBAR3TiPfYe58WyOfwig3x1Dombd8ti
         D+WA==
X-Gm-Message-State: AOPr4FUOl7S915MRCnJGLNeeRT0OycXkG3IW4OUtn47dXbljYsXQaAg1DpFQC75gT3BYNAfQ
X-Received: by 10.66.65.169 with SMTP id y9mr15394643pas.102.1461792646023;
        Wed, 27 Apr 2016 14:30:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:95db:80a2:4fac:5374])
        by smtp.gmail.com with ESMTPSA id 133sm8998421pfw.35.2016.04.27.14.30.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 27 Apr 2016 14:30:45 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.41.g0ac0153.dirty
In-Reply-To: <1461792640-18898-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292829>

Lots of internal functions in submodule-confic.c have a first parameter
`struct submodule_cache *cache`, which currently always refers to the
global variable `cache` in the file. To avoid confusion rename the
global `cache` variable.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 8ac5031..debab29 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -30,7 +30,7 @@ enum lookup_type {
 	lookup_path
 };
 
-static struct submodule_cache cache;
+static struct submodule_cache the_submodule_cache;
 static int is_cache_init;
 
 static int config_path_cmp(const struct submodule_entry *a,
@@ -470,14 +470,14 @@ static void ensure_cache_init(void)
 	if (is_cache_init)
 		return;
 
-	cache_init(&cache);
+	cache_init(&the_submodule_cache);
 	is_cache_init = 1;
 }
 
 int parse_submodule_config_option(const char *var, const char *value)
 {
 	struct parse_config_parameter parameter;
-	parameter.cache = &cache;
+	parameter.cache = &the_submodule_cache;
 	parameter.commit_sha1 = NULL;
 	parameter.gitmodules_sha1 = null_sha1;
 	parameter.overwrite = 1;
@@ -490,18 +490,18 @@ const struct submodule *submodule_from_name(const unsigned char *commit_sha1,
 		const char *name)
 {
 	ensure_cache_init();
-	return config_from_name(&cache, commit_sha1, name);
+	return config_from_name(&the_submodule_cache, commit_sha1, name);
 }
 
 const struct submodule *submodule_from_path(const unsigned char *commit_sha1,
 		const char *path)
 {
 	ensure_cache_init();
-	return config_from_path(&cache, commit_sha1, path);
+	return config_from_path(&the_submodule_cache, commit_sha1, path);
 }
 
 void submodule_free(void)
 {
-	cache_free(&cache);
+	cache_free(&the_submodule_cache);
 	is_cache_init = 0;
 }
-- 
2.8.0.41.g0ac0153.dirty
