Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD397C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 20:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238578AbiDMUEf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238149AbiDMUE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 16:04:28 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325687521D
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:06 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso4664106wme.5
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7SPqvZdYHZt5Nxmnf5XURbVO1MvBp/Z62eGn0dbICqk=;
        b=XYfKS2VY3YULxUdGhgc2XOaglsA9LrCwX7spGMcqXSPi/N0GSPLyKrtZWYBMOBJV/9
         SqHF8TxuA7h4zapdQpf3YtrXUzSzw4Fapm4+6JBr0NXNHZAC/QB+XWr1/UJV8R7CVxOR
         k1rkUJbsE7/8RAqenvCC8Smi7542LLockSWSOQkvoxA6ygIYpKekgBOBOny6FAp3yRAS
         SI+McIyMGEz8kzcJ63K4v6LJn3Q6vPFb6EH+8RqD7uR4DellC4cSZDr1bgEq+VhDx5I2
         xkYlGZVmGaWp1yhtMzX7NpESvEgSICEaujWrCkx2CqtfpNHGwmbyqe7vAllmr+MrP9S9
         HZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7SPqvZdYHZt5Nxmnf5XURbVO1MvBp/Z62eGn0dbICqk=;
        b=klmw16ODJWAgfm+zHXq9i2sownAV0G/IVH1dWDnymZSkBh4rN1bOAGdJH4c9my6Epm
         ykRKtFjeZAhiC+V9P9Szi2XsAD0c2hxcDR7X/ZYgQnYGfduDyimVGx1Q4QbLQbDqL6D7
         Hqd9TydgKcpl1ZSG0Gk5WToDSyQcoTDs+D8BRnPgPYbFuFUGNUIXgcpY9giyIt7W1l4r
         vljRQdmqAB+PPl6j1hgohQgFh7+7q9jYs5Dl5OO8sDtbPIsUckexlhrSuZijYPD2Li98
         XGyJhxIYbs0OqKoPl2psvpXsZMm/0T7RAI/clDb5rkZmTyxZhQ6jH0nt8qA1LkikiAMk
         WiXA==
X-Gm-Message-State: AOAM530M7/QkdSMRMWTB6MMkNJGBCAcKpuAdJ4cly1OSVvoyV2lsQRI9
        0McGORyWozzPbfQ6SNFduQAICkzTqiUI/Q==
X-Google-Smtp-Source: ABdhPJyu7XUgAHJhiUtfDnbhLit7pKXTGe8uB0B3A7h2oTC49hvWiR4kg6A30MPpLNRWGKmsfKyTUQ==
X-Received: by 2002:a05:600c:3ba9:b0:38e:c8c6:ae0d with SMTP id n41-20020a05600c3ba900b0038ec8c6ae0dmr316693wms.120.1649880124493;
        Wed, 13 Apr 2022 13:02:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d6484000000b002057ad822d4sm35220498wri.48.2022.04.13.13.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 13:02:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 04/27] format-patch: don't leak "extra_headers" or "ref_message_ids"
Date:   Wed, 13 Apr 2022 22:01:33 +0200
Message-Id: <patch-v6-04.27-f7fb26752b9-20220413T195935Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
References: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com> <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix two memory leaks in "struct rev_info" by freeing that memory in
cmd_format_patch(). These two are unusual special-cases in being in
the "struct rev_info", but not being "owned" by the code in
revision.c. I.e. they're members of the struct so that this code in
"builtin/log.c" can conveniently pass information code in
"log-tree.c".

See e.g. the make_cover_letter() caller of log_write_email_headers()
here in "builtin/log.c", and [1] for a demonstration of where the
"extra_headers" and "ref_message_ids" struct members are used.

See 20ff06805c6 (format-patch: resurrect extra headers from config,
2006-06-02) and d1566f7883f (git-format-patch: Make the second and
subsequent mails replies to the first, 2006-07-14) for the initial
introduction of "extra_headers" and "ref_message_ids".

We can count on repo_init_revisions() memset()-ing this data to 0
however, so we can count on it being either NULL or something we
allocated. In the case of "extra_headers" let's add a local "char *"
variable to hold it, to avoid the eventual cast from "const char *"
when we free() it.

1. https://lore.kernel.org/git/220401.868rsoogxf.gmgdl@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/log.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 634dc782cce..6f9928fabfe 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1747,6 +1747,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	struct commit *commit;
 	struct commit **list = NULL;
 	struct rev_info rev;
+	char *to_free = NULL;
 	struct setup_revision_opt s_r_opt;
 	int nr = 0, total, i;
 	int use_stdout = 0;
@@ -1947,7 +1948,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		strbuf_addch(&buf, '\n');
 	}
 
-	rev.extra_headers = strbuf_detach(&buf, NULL);
+	rev.extra_headers = to_free = strbuf_detach(&buf, NULL);
 
 	if (from) {
 		if (split_ident_line(&rev.from_ident, from, strlen(from)))
@@ -2284,6 +2285,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	strbuf_release(&rdiff1);
 	strbuf_release(&rdiff2);
 	strbuf_release(&rdiff_title);
+	free(to_free);
+	if (rev.ref_message_ids)
+		string_list_clear(rev.ref_message_ids, 0);
+	free(rev.ref_message_ids);
 	UNLEAK(rev);
 	return 0;
 }
-- 
2.36.0.rc2.843.g193535c2aa7

