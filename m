Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70ED8C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344720AbiCWUeP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344705AbiCWUeC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:34:02 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D6F8C7F6
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:31 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id m30so3805175wrb.1
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AuDtuBxEZKcy/V6RdbohYB96LiiLZCkqD+ilyV85cME=;
        b=o3R3TUqWskSVRTT5bE0L03ULcGrmTSRJwH7cZ+lRwgJz71Mpb/YKM+e72R4GY1rP6+
         grnV6f7131YB1yN4n9cTbyvNZw1l2TpQ2q+VWsCtczD4lwP4nW5IBqERgfGr9agUFifi
         Xydcq4FIqYOoBHD9ILQU13npoR/2eZwweaP61SIcpnZB0O4GIc750UH4h+VJHCmAnC7e
         KJNMhft8GWwtMQW/NkyaQ5VmdPRMX1WZqAbTi3/Y1TZlXL/FhyRobkz7mxxTpInDi7RV
         Dg2t+eljFZVOJvSemFCZorBztjN5KQNMX4izw9hTHAXtboeIWe8XnEgNciQnPyZ85EO7
         ky2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AuDtuBxEZKcy/V6RdbohYB96LiiLZCkqD+ilyV85cME=;
        b=k2WvL/dR+jFv5O35tu+o7and0csSdatCkksh5LzEiRF9W3XdxuAkedbG85n7HAaEc2
         s3jwz2M4lwa/4/JHwgGmIq/f5lTbjn4DKPMYWMMkAmKLLuUIItNoJ+xglseD7fwXXZUh
         /3E30mi1XrkUZQBQ/AmRzsPNXqW/PZJvNgx5KNoi0On4Y4Ep5YtDyWK+uswCrZ1bXsiN
         9g1kH5QBhsFpc4kZQxb5vJxr69aTO3zi8gTpsImuzJcv/29r/kQT1RgAQ2jx51ZbQixN
         v0Iu1JZUZWXazT3wkb71zZv2nYQc7P/GdQZcs1zhZv0EOSOEEswPeB7P16XTO49EQ65L
         1Etg==
X-Gm-Message-State: AOAM532vJ/1RjnEQ/JTvJvG8zlDISVdTi57GXUGBKe/BWoU9NNLXSxmc
        N8zxUNdmIx8ip2V+oKk4MMSUeooXIvBcDg==
X-Google-Smtp-Source: ABdhPJyOaQo5aYuT+KYF+Dx9/McbA3Ii7wOgDEP/GgLBVnONRfOuqHkYTEYjprlU7Yk33qvSQU3PfQ==
X-Received: by 2002:a5d:460c:0:b0:204:62a:210c with SMTP id t12-20020a5d460c000000b00204062a210cmr1557823wrq.460.1648067550340;
        Wed, 23 Mar 2022 13:32:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d6dac000000b00204119d37d0sm849843wrs.26.2022.03.23.13.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:32:29 -0700 (PDT)
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
Subject: [PATCH v2 04/27] format-patch: don't leak "extra_headers" or "ref_message_ids"
Date:   Wed, 23 Mar 2022 21:31:54 +0100
Message-Id: <patch-v2-04.27-64a76629e23-20220323T203149Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1452.ga7cfc89151f
In-Reply-To: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com> <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
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
2.35.1.1452.ga7cfc89151f

