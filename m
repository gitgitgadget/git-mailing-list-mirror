Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3BCC433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 11:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbiAMLik (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 06:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbiAMLij (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 06:38:39 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAA9C06173F
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 03:38:38 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id x4so9541664wru.7
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 03:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/kg686CorJ5Mbm0bxzIUZVP65H/HnC2AnC1ACtGo4Ro=;
        b=klzld4iHgyURv0ii1ouSqqJNimrsNqc6IrTSorjrxnxUfrJLTfie94iPKtrU8TjUY1
         TCUEHeqgmeB5IeREvbKmghdyPXpALAJPftZZ+O+j29arwUbpWVdGiCud32XMM2uv+AXR
         AOEj0MiHS6ml+Hc2ug7GyzCWwuSTAnFyY01iySRs5fbwJVo69ww2cyCF/wD+DPmyvrXZ
         ELZkRtWcDXBO4HGVAxAVlbf8VMrERtW0yqADobZzQL/Qm4gOeJOvMjJdcnqSnoVpfPls
         8WrO0QtOHDCA8JjSVFnNKrmEMaN5RI8yot+jYq9lZY2mEMGh3Rz4VpRqbcyQAs6b2CAF
         9TpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/kg686CorJ5Mbm0bxzIUZVP65H/HnC2AnC1ACtGo4Ro=;
        b=oIFRZ4O5R/NmhwrEQ9eOSLbsq9a2czL/3K5YUGN5AGAU/ZHl4AoxjFhTeYVS+Sxerf
         4zTGCrQkS31kXH/W+QZG1TK+YLuLFdtN4WuL3jNo80ZTvqrkP8Vg+EEC5Gt0ZjFXcnoN
         PtC7lGQ6qsOPSnACkaR3pKFfRLvyQSHPHglIyHpohgdWiApmU7+1C+J4aZPKuvXic+Dh
         B8jdeYlcKad1/j9QzMaRt63RJKsOoWk1Phvc/eR+OzPSzO6motkq4J7FYcZJHlUrXn1e
         RdAWZLP3G64BEETIB0E+wbDV/TVFXDrqPiFLPdUm6swtkzUMjNz/JBm2AzYmNS18qlMI
         ERIQ==
X-Gm-Message-State: AOAM531sOFM6mKFG1DazVAwB77TkX1doCYcNN9mBKnXY1ykmpXE2LdD2
        WKvW7ktAjffILwJaOwtYcrIL1VINakCHTw==
X-Google-Smtp-Source: ABdhPJzxKZ5tk6qeSCcA3Fr5E3h8MuLiMz8HFkvbCHCEih7NYqklxruj3XvyMOsQhCuiPZyjgU2Szw==
X-Received: by 2002:a5d:4e51:: with SMTP id r17mr3639975wrt.444.1642073917319;
        Thu, 13 Jan 2022 03:38:37 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m1sm3485599wrp.81.2022.01.13.03.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 03:38:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] reftable tests: use C syntax compatible with old xlc
Date:   Thu, 13 Jan 2022 12:38:35 +0100
Message-Id: <patch-1.1-7425b64c0a0-20220113T113821Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.850.gcc6bf5af6b1
In-Reply-To: <0b86f6c2327b88886ad8667d28e0fa8382791499.1633638316.git.gitgitgadget@gmail.com>
References: <0b86f6c2327b88886ad8667d28e0fa8382791499.1633638316.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code added in 1ae2b8cda84 (reftable: add merged table view,
2021-10-07) to be compatible with older versions of AIX's IBM xlc
compiler. Version V12.1 of it (on gcc111.fsffrance.org) will hard
error with:

    "reftable/merged_test.c", line 211.19: 1506-196 (S) Initialization between types "char*" and "struct reftable_ref_record" is not allowed.
    "reftable/merged_test.c", line 212.19: 1506-196 (S) Initialization between types "unsigned long long" and "struct reftable_ref_record" is not allowed.
    "reftable/merged_test.c", line 213.19: 1506-196 (S) Initialization between types "enum {...}" and "struct reftable_ref_record" is not allowed.
    "reftable/merged_test.c", line 214.19: 1506-196 (S) Initialization between types "unsigned char*" and "struct reftable_ref_record" is not allowed.
    "reftable/merged_test.c", line 349.19: 1506-196 (S) Initialization between types "char*" and "struct reftable_log_record" is not allowed.
    "reftable/merged_test.c", line 350.19: 1506-196 (S) Initialization between types "unsigned long long" and "struct reftable_log_record" is not allowed.
    "reftable/merged_test.c", line 351.19: 1506-196 (S) Initialization between types "enum {...}" and "struct reftable_log_record" is not allowed.

Its newer V13.1.3 sibling (on gcc119.fsffrance.org, a AIX 7.2 box)
will compile the pre-image without issues. Let's not make git's
sources incompatible with this older AIX 7.1 compiler.

Perhaps there's a better way to do this, but just duplicating the
earlier struct values declared earlier in these functions works, and
is probably the least bad solution.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 reftable/merged_test.c | 74 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 66 insertions(+), 8 deletions(-)

diff --git a/reftable/merged_test.c b/reftable/merged_test.c
index 24461e8a802..bf231990a84 100644
--- a/reftable/merged_test.c
+++ b/reftable/merged_test.c
@@ -206,12 +206,38 @@ static void test_merged(void)
 			.value.val1 = hash1,
 		},
 	};
-
+	/*
+	 * We don't use { r2[0], r3[0], ... } for compatibility with
+	 * older IBM xlc.
+	 */
 	struct reftable_ref_record want[] = {
-		r2[0],
-		r1[1],
-		r3[0],
-		r3[1],
+		/* Same as r2[0] */
+		{
+			.refname = "a",
+			.update_index = 2,
+			.value_type = REFTABLE_REF_DELETION,
+		},
+		/* Same as r1[1] */
+		{
+
+			.refname = "b",
+			.update_index = 1,
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = hash1,
+		},
+		/* Same as r3[0..1] */
+		{
+			.refname = "c",
+			.update_index = 3,
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = hash2,
+		},
+		{
+			.refname = "d",
+			.update_index = 3,
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = hash1,
+		},
 	};
 
 	struct reftable_ref_record *refs[] = { r1, r2, r3 };
@@ -345,10 +371,42 @@ static void test_merged_logs(void)
 			.value_type = REFTABLE_LOG_DELETION,
 		},
 	};
+	/*
+	 * We don't use { r2[0], r3[0], ... } for compatibility with
+	 * older IBM xlc.
+	 */
 	struct reftable_log_record want[] = {
-		r2[0],
-		r3[0],
-		r1[1],
+		/* Same as r2[0] */
+		{
+			.refname = "a",
+			.update_index = 3,
+			.value_type = REFTABLE_LOG_UPDATE,
+			.value.update = {
+				.new_hash = hash3,
+				.name = "jane doe",
+				.email = "jane@invalid",
+				.message = "message3",
+			}
+		},
+		/* Same as r3[0] */
+		{
+			.refname = "a",
+			.update_index = 2,
+			.value_type = REFTABLE_LOG_DELETION,
+		},
+		/* Same as r1[1] */
+		{
+			.refname = "a",
+			.update_index = 1,
+			.value_type = REFTABLE_LOG_UPDATE,
+			.value.update = {
+				.old_hash = hash1,
+				.new_hash = hash2,
+				.name = "jane doe",
+				.email = "jane@invalid",
+				.message = "message1",
+			}
+		},
 	};
 
 	struct reftable_log_record *logs[] = { r1, r2, r3 };
-- 
2.35.0.rc0.850.gcc6bf5af6b1

