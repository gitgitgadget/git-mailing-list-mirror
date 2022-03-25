Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1043EC433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbiCYTwt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbiCYTwk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:52:40 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CEB20034A
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:38:52 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id u3so11642310ljd.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OBVXdcW33JyYtAZl94V7B9Gxy3v6PpmNnHYx1VP6WrE=;
        b=WzkUGU2MsCLoAZl1Rbh5TcRCDXg12cL7JqCTvTYz7Yqa4I/CKzuVqTnPyCY8G5lMKJ
         Oe883f2lcmcfRUxjVOho5cbmrZ15YNjGA0ogJGOaFDN0tRlfei1yL8QCU1V4eYuUuhAA
         9FshoO6KAtlt8FXSV9vaFetyb5XFtBLN/skNA99stK5Co/OKWEPYkmhmKwwyAYCeqpN4
         Po50VCbS88HLHJtDYwdhss73KOsJvgb5BJaDXAAcJIKZlBG0jmFuC/L5+BWos1PJLc8P
         J9UbAKObea5auq3LQhVW9J+s04JrJoSqZe6UmxcQO0/PELoVwXzfHS0vid6OB8PfkVK3
         tgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OBVXdcW33JyYtAZl94V7B9Gxy3v6PpmNnHYx1VP6WrE=;
        b=F1s2YeGiB5sEWmJetEupH0HWg9HbZV4ISMrZJWg6oOeiN7xLhkff4Hgh8bp4pjMt8V
         klOusKCwwKWZZMZ7vC45it8PNA8tiZuoqgaIogsVJMbFgoBGjW3eeAYwmFqmmGxDa+m/
         st9kbeJxvrb+l0eFV90pBUG3nxNDlpEGS/9XESRk6BJS692oE8gzkpTJvfGoH2kse36D
         HIRdcINx8b78VOPDtq5dtarc3jugjb5ZVHJjlR+bdhmu24+1B5ubghkSzcgLzYyhHsAL
         rL0jWD018Uu8MLEAXelwQV2Xil/KIGN6VsoK5FjuWQx1wN2izfWDejxw/veZ9YwVK3zr
         TfUQ==
X-Gm-Message-State: AOAM532ht0UkqYPJjI1tcOckGPe+m6lXFNmsuuzwxddKhQgM9e57DEXU
        egLNTjjMmMkGzmSSlU+k4D9AKMLbP5A1Rw==
X-Google-Smtp-Source: ABdhPJzpoF8lxicSys3Ef7JAdkX5J899BC4zgq29bd58ag7QIbWG9MvcPKAK6s5tHj+O96KyfDwLjg==
X-Received: by 2002:a5d:4149:0:b0:203:e064:2571 with SMTP id c9-20020a5d4149000000b00203e0642571mr10128409wrq.62.1648228775317;
        Fri, 25 Mar 2022 10:19:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b00203ffebddf3sm7554165wru.99.2022.03.25.10.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:19:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 04/27] format-patch: don't leak "extra_headers" or "ref_message_ids"
Date:   Fri, 25 Mar 2022 18:18:28 +0100
Message-Id: <patch-v3-04.27-71495dfd073-20220325T171340Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1509.ge4eeb5bd39e
In-Reply-To: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
References: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com> <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
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
"builtin/log.c" can pass information code in log-tree.c.

See 20ff06805c6 (format-patch: resurrect extra headers from config,
2006-06-02) and d1566f7883f (git-format-patch: Make the second and
subsequent mails replies to the first, 2006-07-14) for the initial
introduction of "extra_headers" and "ref_message_ids".

We can count on repo_init_revisions() memset()-ing this data to 0
however, so we can count on it being either NULL or something we
allocated. In the case of "extra_headers" let's add a local "char *"
variable to hold it, to avoid the eventual cast from "const char *"
when we free() it.

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
2.35.1.1509.ge4eeb5bd39e

