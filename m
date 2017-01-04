Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3382A20754
	for <e@80x24.org>; Wed,  4 Jan 2017 18:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966844AbdADSFA (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 13:05:00 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33901 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761458AbdADSEb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 13:04:31 -0500
Received: by mail-pg0-f45.google.com with SMTP id y62so177753934pgy.1
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 10:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0sZrfW7x5cMMyzUsuDF9bLX8IB+iw4eJjXEPkdvbdWA=;
        b=QPoCL82wvWE2mZjFbEqWeggi5FOuzgkajIZT084GqUek3OG9SfY75CD07qePQpwPPp
         flgCoVcr/EZRYac41JJgiTMFldYQagHrPvQc1J/Dm0wo79AmvLVJzt79O1XEbJMcZxGS
         G8Xf9TC2dQXrhBLDVv1QCxCywp/zOEg32R5LMVUfc9aclrTKa4ZuXG3N6JzCTf/tS0lI
         0Ulnw+FevRq4K0yC2GYA1aeEXuFWbLZGyZcinxbjc5OMfakGg7NqHIoeYXFe7q4ka+R8
         EovWn+Fhv++NZw+z+m0wNdBapKNVdrWXFNZnFQ832YjHvhMVULYfGMf5mHxy9nJkdxx3
         ci+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0sZrfW7x5cMMyzUsuDF9bLX8IB+iw4eJjXEPkdvbdWA=;
        b=NPM1Q7hU2yazzmLc56kE08ppy+Wc8RhGhzRkQd7Je3HSWPDFDWIs0rcLuRd4VC8co+
         we4A2FDIf3Wdgpa6nelSMMmo2/wqrcGhvN7RR2HQB5zv626mnaFL9VkOfvHbX4lk6zFF
         YbnAvIRzyMCN7OpG1TFysmUhNkXF2Y+KN739kbKvs0dLDRBl8Jf1UOZ+EillSlR7zQ2e
         UmlCSPS0oh1mPcGEtyNCXiyriRjSb7+hxh5qiAHO0BMGccKD7ksnnaTNl8pDWCiAaYfW
         HrUQkk236OEJA1s711UldxqPcFOOCs45ODKO0bCueRjACNvKFW4hPvrkuJweAAh4ygKO
         qiAQ==
X-Gm-Message-State: AIkVDXIPHiGMXdY3YIXbzwQqR3QMFkgH0RhpOd9W5x6yvzYOaYbAxH0Sc2jH9N7U7M9rPOSi
X-Received: by 10.98.10.198 with SMTP id 67mr64434399pfk.157.1483553070838;
        Wed, 04 Jan 2017 10:04:30 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id o68sm148337150pfb.42.2017.01.04.10.04.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jan 2017 10:04:29 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v5 08/16] pathspec: always show mnemonic and name in unsupported_magic
Date:   Wed,  4 Jan 2017 10:04:03 -0800
Message-Id: <20170104180411.150000-9-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170104180411.150000-1-bmwill@google.com>
References: <20170103184241.128409-1-bmwill@google.com>
 <20170104180411.150000-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For better clarity, always show the mnemonic and name of the unsupported
magic being used.  This lets users have a more clear understanding of
what magic feature isn't supported.  And if they supplied a mnemonic,
the user will be told what its corresponding name is which will allow
them to more easily search the man pages for that magic type.

This also avoids passing an extra parameter around the pathspec
initialization code.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 pathspec.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index b9a3819d6..5df364bc6 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -101,9 +101,7 @@ static void prefix_short_magic(struct strbuf *sb, int prefixlen,
  * the prefix part must always match literally, and a single stupid
  * string cannot express such a case.
  */
-static unsigned prefix_pathspec(struct pathspec_item *item,
-				unsigned *p_short_magic,
-				unsigned flags,
+static unsigned prefix_pathspec(struct pathspec_item *item, unsigned flags,
 				const char *prefix, int prefixlen,
 				const char *elt)
 {
@@ -210,7 +208,6 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 	}
 
 	magic |= short_magic;
-	*p_short_magic = short_magic;
 
 	/* --noglob-pathspec adds :(literal) _unless_ :(glob) is specified */
 	if (noglob_global && !(magic & PATHSPEC_GLOB))
@@ -329,8 +326,7 @@ static int pathspec_item_cmp(const void *a_, const void *b_)
 }
 
 static void NORETURN unsupported_magic(const char *pattern,
-				       unsigned magic,
-				       unsigned short_magic)
+				       unsigned magic)
 {
 	struct strbuf sb = STRBUF_INIT;
 	int i;
@@ -339,9 +335,11 @@ static void NORETURN unsupported_magic(const char *pattern,
 		if (!(magic & m->bit))
 			continue;
 		if (sb.len)
-			strbuf_addch(&sb, ' ');
-		if (short_magic & m->bit)
-			strbuf_addf(&sb, "'%c'", m->mnemonic);
+			strbuf_addstr(&sb, ", ");
+
+		if (m->mnemonic)
+			strbuf_addf(&sb, _("'%s' (mnemonic: '%c')"),
+				    m->name, m->mnemonic);
 		else
 			strbuf_addf(&sb, "'%s'", m->name);
 	}
@@ -413,11 +411,9 @@ void parse_pathspec(struct pathspec *pathspec,
 	prefixlen = prefix ? strlen(prefix) : 0;
 
 	for (i = 0; i < n; i++) {
-		unsigned short_magic;
 		entry = argv[i];
 
-		item[i].magic = prefix_pathspec(item + i, &short_magic,
-						flags,
+		item[i].magic = prefix_pathspec(item + i, flags,
 						prefix, prefixlen, entry);
 		if ((flags & PATHSPEC_LITERAL_PATH) &&
 		    !(magic_mask & PATHSPEC_LITERAL))
@@ -425,9 +421,7 @@ void parse_pathspec(struct pathspec *pathspec,
 		if (item[i].magic & PATHSPEC_EXCLUDE)
 			nr_exclude++;
 		if (item[i].magic & magic_mask)
-			unsupported_magic(entry,
-					  item[i].magic & magic_mask,
-					  short_magic);
+			unsupported_magic(entry, item[i].magic & magic_mask);
 
 		if ((flags & PATHSPEC_SYMLINK_LEADING_PATH) &&
 		    has_symlink_leading_path(item[i].match, item[i].len)) {
-- 
2.11.0.390.gc69c2f50cf-goog

