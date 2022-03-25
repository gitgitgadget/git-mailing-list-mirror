Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88617C433FE
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 17:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiCYRaN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 13:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242249AbiCYR3E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 13:29:04 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22458FD6CC
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:27:30 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u16so11798492wru.4
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8IgGTX3t7zuAa0Bhlug2+Edl0xSVAPXkphvCcwsU+Z8=;
        b=NVcOh6zvLEp86YBcweA7bViAiaNg6yo/vMVUr1N0jMAvgfXnLvy6ZYARbskevtXBhx
         NKM5aT0nGodb/59tcDQYYeYKWV/3PWzmTeyXje/4+Ugq74RoLBVEPlIxJRgqOddZ27Dg
         XV5KXLG0LgBIoSNKLuRj8RGLsmi4+aI51c65nvz5EsronQVAHhRlF/Z/rxzKfXp2RPox
         gQBkKXM9FsMTMNpRuQrkXv4MvD1xZStPtI49E0baEPBOFR9LDCHc32uNdXLhKiCIRyp0
         jCrar1dKRsLwLMbhYAgBAcFV2T+MRc3gFbdhYBZ2RaTNzhQqg8HAoJ7VI9Pyb9riuxCo
         jR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8IgGTX3t7zuAa0Bhlug2+Edl0xSVAPXkphvCcwsU+Z8=;
        b=x47S7HklEDEEfUfO2jeQFE+fTaK5Je+oPkjinHEYIRazdyAH9c2tvbLt8KdV93mhyI
         OCUHgeHJ3FcU0aWzfCqDFtdoQ/1Qob6fNcDKtxAVhScVsYxwbKgZwatuT1oUObZr+dAX
         nLizLbbkRGuvmaYYjJ5IURiRyL3jIy350vg3/OjCGTBDTHMma7KAjTLxJZP18ZxVKy/o
         W/miPivgYrc6ryREU8Kxoo1L4rUOmsGqqEVpwHIBClzVUeTOZB9nBDh7ZKIsjqX7IuYS
         FaiVXztG9H0EEZ8YBw1q3pXIPVNJq3Yu/ZG/WEo5yDHVUXUMF4TIazQcKRbJ827UDlHG
         pNZA==
X-Gm-Message-State: AOAM532zi/ujQojJY3eIT/nAWkqfLjhL0ynJJhR+R54Lj9bE+ujSsjPe
        G/9nADDS22UCfOfwH5MiYV04HjPCeIR+pg==
X-Google-Smtp-Source: ABdhPJwGHfFS2YoDNxNsLaPk94hUDlfap+THQ8MX2XF3EKknfpeqgA1TwcaDxlxRtxfqsS1LUimHbw==
X-Received: by 2002:a5d:64ad:0:b0:204:2f7:b904 with SMTP id m13-20020a5d64ad000000b0020402f7b904mr9984512wrp.458.1648228772102;
        Fri, 25 Mar 2022 10:19:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b00203ffebddf3sm7554165wru.99.2022.03.25.10.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:19:31 -0700 (PDT)
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
Subject: [PATCH v3 01/27] t/helper/test-fast-rebase.c: don't leak "struct strbuf"
Date:   Fri, 25 Mar 2022 18:18:25 +0100
Message-Id: <patch-v3-01.27-7c8298f564f-20220325T171340Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1509.ge4eeb5bd39e
In-Reply-To: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
References: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com> <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak that's been with us since f9500261e0a (fast-rebase:
write conflict state to working tree, index, and HEAD, 2021-05-20)
changed this code to move these strbuf_release() into an if/else
block.

We'll also add to "reflog_msg" in the "else" arm of the "if" block
being modified here, and we'll append to "branch_msg" in both
cases. But after f9500261e0a only the "if" block would free these two
"struct strbuf".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-fast-rebase.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-fast-rebase.c b/t/helper/test-fast-rebase.c
index fc2d4609043..993b90eaedd 100644
--- a/t/helper/test-fast-rebase.c
+++ b/t/helper/test-fast-rebase.c
@@ -201,8 +201,6 @@ int cmd__fast_rebase(int argc, const char **argv)
 		}
 		if (create_symref("HEAD", branch_name.buf, reflog_msg.buf) < 0)
 			die(_("unable to update HEAD"));
-		strbuf_release(&reflog_msg);
-		strbuf_release(&branch_name);
 
 		prime_cache_tree(the_repository, the_repository->index,
 				 result.tree);
@@ -221,5 +219,8 @@ int cmd__fast_rebase(int argc, const char **argv)
 	if (write_locked_index(&the_index, &lock,
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		die(_("unable to write %s"), get_index_file());
+
+	strbuf_release(&reflog_msg);
+	strbuf_release(&branch_name);
 	return (result.clean == 0);
 }
-- 
2.35.1.1509.ge4eeb5bd39e

