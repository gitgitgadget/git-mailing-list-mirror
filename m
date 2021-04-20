Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889F0C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5370C613C7
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbhDTMvc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 08:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbhDTMv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 08:51:27 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125B8C06138C
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:50:55 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id k17so5413752edr.7
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WNXBKBCpDh3zQETF+Lcuxi3nXPZZk77ccGSZH2v1lK8=;
        b=p/HBS86ftZph6qoIQQlvh0MwVuYnFdiScT2uu67Z5K7oe1Hjk9OHkGN5UoWgk7vIBF
         Xdh9GkAhDXUqqDFcq3b0KnWzMfif/Si1FBodkBOteyXU0maFAbob8JnYuhyTZ8WsXgtA
         Yt8BaR/bY75PWrGMXYlOZTi8WXdTTvQ+74Hi9VaQlSlWsXKjA8IGDQ9Oxc06De3erPFN
         RYV2PHurd3hCpv9E0DsO8I8VAb6g88tz3tMtFZmwFGoMAOCuvNKUWlNKhngr9/xTL+c2
         9Lermo6KVtRTFIwVec4lGYnPiqOBrzqolJTlEjsNHghMYp7iEUeGzRTS/MoXD0Rq+nwW
         kWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WNXBKBCpDh3zQETF+Lcuxi3nXPZZk77ccGSZH2v1lK8=;
        b=ta+gFIZqA2Fqzw7R4RqT4ugCqFnOdyZMbFZrVTkaLD/S9IF+LRMp3paRu/RSRV0sal
         sk3HggrwkLkErM+TOf15bY0qVn/Ik2KcGIz1MIwmVQVJrOtac3p2Pw2d4dJ/1FZTId9V
         ilxgGXy7xNquIpXmufptkm+L8YHbeuohlYWtyXGIn1AN2DFxmXI4F0MNkCsYNmeFAt4M
         BAefiAyOwOM5gFO/emDvHV+fpwGBIvEkZM1FPv+AgD2vz+fUHmJhflxYaZMr5ehrBiNv
         Qtxbr3z7FRaKpWPXj3nSbHpein6Oir3YhMVUXN16GMmAwmn/CLSkCYRoM0iUxEFnPfVN
         je8A==
X-Gm-Message-State: AOAM532CChefkJpBXfOGwkGnmJt0tWfT37JeLT9qUg0h01FLFlmI5qpe
        lNCtFhJePqmrfz/fYEBbKEzn6TY+T+SDVw==
X-Google-Smtp-Source: ABdhPJzckcB0lJqogpTvhUNjKWZJ5njjb0YZUciDY/h/w4VuzwvN28x6CKxy/6HLFJtpdS3W+DAgAQ==
X-Received: by 2002:a05:6402:254f:: with SMTP id l15mr32342213edb.189.1618923053595;
        Tue, 20 Apr 2021 05:50:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f3sm12630900eje.45.2021.04.20.05.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 05:50:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/10] mktree: emit a more detailed error when the <type> is invalid
Date:   Tue, 20 Apr 2021 14:50:43 +0200
Message-Id: <patch-10.10-fe75526a65-20210420T124428Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.ga5d7868e4a
In-Reply-To: <cover-00.10-0000000000-20210420T124428Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com> <cover-00.10-0000000000-20210420T124428Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When given an invalid <type> as part of a "<mode> SP [...]" line (see
the added comment) we'd use the generic die() message in
type_from_string_gently().

Let's do a bit better in that case and emit a message at the same
level of detail as the existing die() message if the type was valid,
but didn't match the mode.

In preceding commits we fixed the type_from_string_gently() function
for cases where gentle=0, now there are no more callers of it that
pass "gentle=0" that aren't type_from_string() itself.

So that fixing of a bug wasn't strictly needed for this end-state, but
helps to incrementally explain and test the changes we're making, and
of course leaves type_from_string_gently() in a good state for any
future gently=0 callers.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/mktree.c  | 20 ++++++++++++++++----
 t/t1010-mktree.sh |  2 +-
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index 7a27cfa2e0..67e11d8562 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -72,8 +72,17 @@ static void mktree_line(char *buf, int nul_term_line, int allow_missing)
 	char *ptr, *ntr;
 	const char *p;
 	unsigned mode;
-	enum object_type mode_type; /* object type derived from mode */
-	enum object_type obj_type; /* object type derived from sha */
+	/*
+	 * For a line like:
+	 *
+	 *     <mode> SP <type> SP <object> SP <object size> TAB <file>"
+	 *
+	 * We'll discover and validate the type from all of <mode>,
+	 * <type> and <object>
+	 */
+	enum object_type mode_type;
+	enum object_type type_type;
+	enum object_type obj_type;
 	char *path, *to_free = NULL;
 	struct object_id oid;
 
@@ -108,10 +117,13 @@ static void mktree_line(char *buf, int nul_term_line, int allow_missing)
 	 * These should all agree.
 	 */
 	mode_type = object_type(mode);
-	if (mode_type != type_from_string_gently(ptr, ntr - ptr, 0)) {
+	type_type = type_from_string_gently(ptr, ntr - ptr, 1);
+	if (type_type < 0)
+		die("entry '%s' object type '%.*s' is invalid (our derived mode type is '%s')",
+			path, (int)(ntr - ptr), ptr, type_name(mode_type));
+	else if (mode_type != type_type)
 		die("entry '%s' object type (%s) doesn't match mode type (%s)",
 			path, ptr, type_name(mode_type));
-	}
 
 	/* Check the type of object identified by sha1 */
 	obj_type = oid_object_info(the_repository, &oid, NULL);
diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
index 2a7b04aed8..fe8601e7bb 100755
--- a/t/t1010-mktree.sh
+++ b/t/t1010-mktree.sh
@@ -63,7 +63,7 @@ test_expect_success 'invalid object type' '
 	test_must_fail git mktree <bad-type >out 2>err &&
 	test_must_be_empty out &&
 	cat >expected <<-\EOF &&
-	fatal: invalid object type "whee"
+	fatal: entry '"'"'a.'"'"' object type '"'"'whee'"'"' is invalid (our derived mode type is '"'"'tree'"'"')
 	EOF
 	test_cmp expected err
 '
-- 
2.31.1.723.ga5d7868e4a

