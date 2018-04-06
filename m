Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79E201F404
	for <e@80x24.org>; Fri,  6 Apr 2018 23:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751956AbeDFXV7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 19:21:59 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43585 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751779AbeDFXV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 19:21:57 -0400
Received: by mail-pl0-f68.google.com with SMTP id a39-v6so1521643pla.10
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 16:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SHMQAo+mm/cbFMPp09/anV16R2QSi1bCGJrCEr+AWQw=;
        b=KYQSMxQZwOc12/vzNIt6lK9B4NM8vTsXZH5Mr+e8RNQp7oHUvA05NRwr1w/UAuYVPg
         dy+B0NtfWvJea9zwsM1CRAT7x5Ej/N5RJZU4trw8CC/Sb8JF5+jTqxN8MmAjmb8qNOsL
         OtniLc1Dg7+l8SUJna+JOp6QvsERkJ/CxWGdiL2IEK+mknb4TvunXiwQxneQyzfwM1eu
         A7MkOALsiRYKFKre5yEYsBzWAdizw/O1Jvzap7LzJRTdvZs/jIHYscFDpyqtxyY0mvNC
         XwqwInZ0LoJUKqcg6ry75gOQcGWqxKncAecFDFH3ALSwU41EDtYwilXBR0GGcxPk6mqP
         v0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SHMQAo+mm/cbFMPp09/anV16R2QSi1bCGJrCEr+AWQw=;
        b=emVlLLrsbLN2GAywVdrZdS/t4tkNVWzNPR2Q5Zk6OLK6lE7jZXcjQaFt2Dn0pHTRu8
         GdM2j7mifBkpoQ7IhvR+4ramhLqWcZSozJMS/SZTRCUvql95+Iri9Pxd2Z1pA9KYK6z4
         BLOn+7z0vxFcFJm9OzCkk5C1Can0je2v3z1MEFFR7wp91vyYEBfT6kFdAfBA3AXBxqyo
         xxQS+MLD+FYr/JtTgZJ2ULHOATByiWHbvKrqecaIGKKkbpldhJPZjmbKKNCeiyz6aoEy
         qQjXZ/sTSM4OFgKrYtWCywj1tfEiCAjzpyxqy3FZ376zbh+6NNpVfaLMcCXzZGvw++gt
         VBgA==
X-Gm-Message-State: AElRT7E+AXZs/+TkTwq/WBa3DCjoFTOm/aX3dMMJG2FCiWEMmJ3vG1+v
        aFrOAuvfzxECYWABZlJS6B5HfQ==
X-Google-Smtp-Source: AIpwx48p84qU9Jlf3/C3R1OBlpL95QslZyrtesNz125TEOWUnkvHlAlyEdB/LRylAOEfDiJtCSyjcA==
X-Received: by 2002:a17:902:8490:: with SMTP id c16-v6mr29541092plo.132.1523056916426;
        Fri, 06 Apr 2018 16:21:56 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id 203sm22427025pfb.50.2018.04.06.16.21.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Apr 2018 16:21:55 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 05/19] replace-object: check_replace_refs is safe in multi repo environment
Date:   Fri,  6 Apr 2018 16:21:22 -0700
Message-Id: <20180406232136.253950-6-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180406232136.253950-1-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In e1111cef23 (inline lookup_replace_object() calls, 2011-05-15) a shortcut
for checking the object replacement was added by setting check_replace_refs
to 0 once the replacements were evaluated to not exist. This works fine in
with the assumption of only one repository in existence.

The assumption won't hold true any more when we work on multiple instances
of a repository structs (e.g. one struct per submodule), as the first
repository to be inspected may have no replacements and would set the
global variable. Other repositories would then completely omit their
evaluation of replacements.

This reverts back the meaning of the flag `check_replace_refs` of
"Do we need to check with the lookup table?" to "Do we need to read
the replacement definition?", adding the bypassing logic to
lookup_replace_object after the replacement definition was read.
As with the original patch, delay the renaming of the global variable

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 environment.c    | 2 +-
 replace-object.c | 2 --
 replace-object.h | 5 ++++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/environment.c b/environment.c
index 93c9fbb0ba..29f677c650 100644
--- a/environment.c
+++ b/environment.c
@@ -50,7 +50,7 @@ const char *editor_program;
 const char *askpass_program;
 const char *excludes_file;
 enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
-int check_replace_refs = 1;
+int check_replace_refs = 1; /* NEEDSWORK: rename to read_replace_refs */
 char *git_replace_ref_base;
 enum eol core_eol = EOL_UNSET;
 int global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
diff --git a/replace-object.c b/replace-object.c
index 603d11e931..c6d08c2e17 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -78,8 +78,6 @@ static void prepare_replace_object(void)
 
 	for_each_replace_ref(register_replace_ref, NULL);
 	the_repository->objects->replacements.prepared = 1;
-	if (!the_repository->objects->replacements.nr)
-		check_replace_refs = 0;
 }
 
 /* We allow "recursive" replacement. Only within reason, though */
diff --git a/replace-object.h b/replace-object.h
index 1e3e8805b9..f2555cddb9 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -3,6 +3,7 @@
 
 #include "cache.h"
 #include "repository.h"
+#include "object-store.h"
 
 struct replace_object {
 	unsigned char original[GIT_MAX_RAWSZ];
@@ -23,7 +24,9 @@ extern const unsigned char *do_lookup_replace_object(const unsigned char *sha1);
  */
 static inline const unsigned char *lookup_replace_object(const unsigned char *sha1)
 {
-	if (!check_replace_refs)
+	if (!check_replace_refs ||
+	    (the_repository->objects->replacements.prepared &&
+	     the_repository->objects->replacements.nr == 0))
 		return sha1;
 	return do_lookup_replace_object(sha1);
 }
-- 
2.17.0.484.g0c8726318c-goog

