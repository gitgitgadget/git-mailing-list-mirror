Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CDD220259
	for <e@80x24.org>; Thu,  8 Dec 2016 14:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932270AbcLHOYo (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 09:24:44 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34107 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752340AbcLHOYc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 09:24:32 -0500
Received: by mail-wm0-f66.google.com with SMTP id g23so3878962wme.1
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 06:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IPyH+obOZXMXdIzhbSIf1ZnZLeAF6BCXx8x04PZInEk=;
        b=tywGxFGRZqgIOFV/eud/WLatySlRKOzfLUbv6mFXJQkk5X7dwK54Bh0g83kcpYSy5r
         0KwKCPaFHSukHcqBMjcqmLuXUaG0sfUIZRnpxOT+pjdxQcLh/bYMgIxKfQ1oP3FNUCZ7
         OvFvhiX5AD2+4qWJIqwABpMHlkhlU2AJrsqINLzOyJnPd+N4kjv8n7x5xSi4QeGDyVBU
         j9nfUpESVAqDmKOTeZ3aQB8dF5yjPAuFpY7Cz63VrTPFyL0Cx1YYgqsm5d5k48O0Zxre
         rjpccIJjiJP1NKVhRNkKS8OmqbAjfPozBoqpfaVUzkc3Q7+SumugttCjW53wSAOHzQ+Z
         iSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IPyH+obOZXMXdIzhbSIf1ZnZLeAF6BCXx8x04PZInEk=;
        b=DQitda6BSHSqVe9H19MURyUoQegRHPJvNx+T7mggaq3Hr925s2k9LsMVFlwTk20hkR
         T9hUHF3xA4KNePsAGLBrIDFIX9SlXz7PguywehXvQ/QNSfMQ1KHxR0g2H9g91NORwnRM
         5RJm9G0Bb4Zaz8Q/oEGXpMvvVRToltQpc4eDq6YZxVpEIt9wE4XLDaZP/zQXt3F2fed0
         q/5CdU/MRyotSw0o3A5PUbq95GHtRaegBDwcq4J1wUqbULi2iYRfyo7VlTCFGd7b2Akd
         nRUraILZfQ5u8w0SU4uQx8T3sQvr9zG0YuFDvxaVyKA2fy+IjVtDKXucExJ9/y24Apka
         51Dw==
X-Gm-Message-State: AKaTC02wvYoe4/5PMkvTeZEVZ7G7d/49yTKoDq4JJ+BBhl1ZGEhNy0qO3nScz410CgcENQ==
X-Received: by 10.28.208.203 with SMTP id h194mr2371108wmg.45.1481207070999;
        Thu, 08 Dec 2016 06:24:30 -0800 (PST)
Received: from localhost.localdomain (x590d68ae.dyn.telefonica.de. [89.13.104.174])
        by smtp.gmail.com with ESMTPSA id l67sm15464028wmf.20.2016.12.08.06.24.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 06:24:30 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Leho Kraav <leho@conversionready.com>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 4/7] versioncmp: pass full tagnames to swap_prereleases()
Date:   Thu,  8 Dec 2016 15:23:58 +0100
Message-Id: <20161208142401.1329-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.78.g5a2d011
In-Reply-To: <20161208142401.1329-1-szeder.dev@gmail.com>
References: <20161005033353.Horde.33pf2naqnF4HgwPWSy9DaHV@webmail.informatik.kit.edu>
 <20161208142401.1329-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The swap_prereleases() helper function is responsible for finding
configured prerelease suffixes in a pair of tagnames to be compared,
but this function currently gets to see only the parts of those two
tagnames starting at the first different character.  To fix some
issues related to the common part of two tagnames overlapping with
leading part of a prerelease suffix, this helper function must see
both full tagnames.

In preparation for the fix in the following patch, refactor
swap_prereleases() and its caller to pass two full tagnames and an
additional offset indicating the position of the first different
character.

While updating the comment describing that function, remove the
sentence about not dealing with both tagnames having the same suffix.
Currently it doesn't add much value (we know that there is a different
character, so it's obvious that it can't possibly be the same suffix
in both), and at the end of this patch series it won't even be true
anymore.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 versioncmp.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/versioncmp.c b/versioncmp.c
index 80bfd109f..a55c23ad5 100644
--- a/versioncmp.c
+++ b/versioncmp.c
@@ -25,32 +25,28 @@ static const struct string_list *prereleases;
 static int initialized;
 
 /*
- * p1 and p2 point to the first different character in two strings. If
- * either p1 or p2 starts with a prerelease suffix, it will be forced
- * to be on top.
+ * off is the offset of the first different character in the two strings
+ * s1 and s2. If either s1 or s2 contains a prerelease suffix starting
+ * at that offset, it will be forced to be on top.
  *
- * If both p1 and p2 start with (different) suffix, the order is
- * determined by config file.
- *
- * Note that we don't have to deal with the situation when both p1 and
- * p2 start with the same suffix because the common part is already
- * consumed by the caller.
+ * If both s1 and s2 contain a (different) suffix at that position,
+ * their order is determined by the order of those two suffixes in the
+ * configuration.
  *
  * Return non-zero if *diff contains the return value for versioncmp()
  */
-static int swap_prereleases(const void *p1_,
-			    const void *p2_,
+static int swap_prereleases(const char *s1,
+			    const char *s2,
+			    int off,
 			    int *diff)
 {
-	const char *p1 = p1_;
-	const char *p2 = p2_;
 	int i, i1 = -1, i2 = -1;
 
 	for (i = 0; i < prereleases->nr; i++) {
 		const char *suffix = prereleases->items[i].string;
-		if (i1 == -1 && starts_with(p1, suffix))
+		if (i1 == -1 && starts_with(s1 + off, suffix))
 			i1 = i;
-		if (i2 == -1 && starts_with(p2, suffix))
+		if (i2 == -1 && starts_with(s2 + off, suffix))
 			i2 = i;
 	}
 	if (i1 == -1 && i2 == -1)
@@ -121,7 +117,8 @@ int versioncmp(const char *s1, const char *s2)
 		initialized = 1;
 		prereleases = git_config_get_value_multi("versionsort.prereleasesuffix");
 	}
-	if (prereleases && swap_prereleases(p1 - 1, p2 - 1, &diff))
+	if (prereleases && swap_prereleases(s1, s2, (const char *) p1 - s1 - 1,
+					    &diff))
 		return diff;
 
 	state = result_type[state * 3 + (((c2 == '0') + (isdigit (c2) != 0)))];
-- 
2.11.0.78.g5a2d011

