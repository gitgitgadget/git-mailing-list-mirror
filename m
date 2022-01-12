Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0E2C433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 12:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353233AbiALMkQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 07:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353219AbiALMkL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 07:40:11 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F5FC06173F
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 04:40:10 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 25-20020a05600c231900b003497473a9c4so3358452wmo.5
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 04:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TZsHFENS1R3wplNmfdHre/NG8Plj2qTY9cGycXBRoaY=;
        b=TrChJnZ2bB9282Nid1vsTYtqKebMIsjfmOLvYsAN70oFvIX04xaH2sSbBnrvAlgdtn
         WtHpnjFraKgNy1sRyr+LUSXWG3iksAZqBgxwHgtXmrNVP/Q3LNHEJDJUwrM6P6qBQqTN
         lcweBHGzaXwhv0/fBXLIDatRbObJp91tAo6f48rYAU31bpOX7BJfdtalINij5SjfMFGM
         CIa8/iwT/AVPKfhST5F+IVPfxS20hUnWDaxbsb8l6oEPv3DL4qrht4rTe8yBdn7zshce
         aKLTxbYIccNmxTjI+4TSXDnpk5/Kz1CcvvFMoiYv2/nLqS2+cJqDDN53LYmm3HOmg9aS
         WJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TZsHFENS1R3wplNmfdHre/NG8Plj2qTY9cGycXBRoaY=;
        b=QSVpDBDho3rBIAzK/F79bLz6XOnRxZUY5QP+89uoQ4qZnqmVZpdJnfSp0SHX5WKUrf
         pui04D1+q/NTsLX0T7Vi3+uOvFe1an/u5G889LH51Mz9tTQLuwCk5HUlnWGwvTqb65zk
         Zhwm4cFhNxcjYIPS/kr7xTB6hcBCInGjtNq6WN5nfA9tzyn0NSLkSWCnRNMpgJShvsk4
         ML/VOcUptdDzwoFyb86jG73UdcjsIrEExxIUAc/jU8tMbXcPNX1t63nph9xvxfnktdPj
         frUXUfPmkV20+Q03YFKZImMNxWkCLNuOY0exWU68SQjWGcjTUZh0kJGHP+3cd2RFa6eL
         O6/w==
X-Gm-Message-State: AOAM532cgzIwdA+ejfc9dwS4eUoaiQYf7PvvmdSBiZivJeNSlH2x4ZlK
        PdEkyC0+y3pR0Nzp0wMwCUZ7RTonAHKUJQ==
X-Google-Smtp-Source: ABdhPJyGilTDcLzYGZ1gP+THl4Z/bgRUG1ecRrLg6G1Z9qhkd4ZlxeSgVScQAdFBS3nX/KdT8+K4kQ==
X-Received: by 2002:a1c:4d09:: with SMTP id o9mr6680050wmh.22.1641991209023;
        Wed, 12 Jan 2022 04:40:09 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j13sm5174242wmq.11.2022.01.12.04.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 04:40:08 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 5/6] object-name: iterate ambiguous objects before showing header
Date:   Wed, 12 Jan 2022 13:39:24 +0100
Message-Id: <patch-v7-5.6-2c03cdd3c1e-20220111T130811Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.848.gb9d3879eb1d
In-Reply-To: <cover-v7-0.6-00000000000-20220111T130811Z-avarab@gmail.com>
References: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com> <cover-v7-0.6-00000000000-20220111T130811Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "The candidates are" header that's shown for ambiguous
objects to be shown after we've iterated over all of the objects.

If we get any errors while doing so we don't want to split up the the
header and the list as a result. The two will now be printed together,
as shown in the updated testcase.

As we're accumulating the lines into as "struct strbuf" before
emitting them we need to add a trailing newline to the call in
show_ambiguous_object(). This and the change from "The candidates
are:" to "The candidates are:\n%s" helps to give translators more
context.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-name.c                       | 27 +++++++++++++++++++++++----
 t/t1512-rev-parse-disambiguation.sh |  3 +--
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/object-name.c b/object-name.c
index 7c6cb60ceff..71236ed1c16 100644
--- a/object-name.c
+++ b/object-name.c
@@ -351,9 +351,16 @@ static int init_object_disambiguation(struct repository *r,
 	return 0;
 }
 
+struct ambiguous_output {
+	const struct disambiguate_state *ds;
+	struct strbuf advice;
+};
+
 static int show_ambiguous_object(const struct object_id *oid, void *data)
 {
-	const struct disambiguate_state *ds = data;
+	struct ambiguous_output *state = data;
+	const struct disambiguate_state *ds = state->ds;
+	struct strbuf *advice = &state->advice;
 	struct strbuf desc = STRBUF_INIT;
 	int type;
 	const char *hash;
@@ -444,7 +451,7 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 	 * you'll probably want to swap the "%s" and leading " " space
 	 * around.
 	 */
-	advise(_("  %s"), desc.buf);
+	strbuf_addf(advice, _("  %s\n"), desc.buf);
 
 	strbuf_release(&desc);
 	return 0;
@@ -543,6 +550,10 @@ static enum get_oid_result get_short_oid(struct repository *r,
 
 	if (!quietly && (status == SHORT_NAME_AMBIGUOUS)) {
 		struct oid_array collect = OID_ARRAY_INIT;
+		struct ambiguous_output out = {
+			.ds = &ds,
+			.advice = STRBUF_INIT,
+		};
 
 		error(_("short object ID %s is ambiguous"), ds.hex_pfx);
 
@@ -555,13 +566,21 @@ static enum get_oid_result get_short_oid(struct repository *r,
 		if (!ds.ambiguous)
 			ds.fn = NULL;
 
-		advise(_("The candidates are:"));
 		repo_for_each_abbrev(r, ds.hex_pfx, collect_ambiguous, &collect);
 		sort_ambiguous_oid_array(r, &collect);
 
-		if (oid_array_for_each(&collect, show_ambiguous_object, &ds))
+		if (oid_array_for_each(&collect, show_ambiguous_object, &out))
 			BUG("show_ambiguous_object shouldn't return non-zero");
+
+		/*
+		 * TRANSLATORS: The argument is the list of ambiguous
+		 * objects composed in show_ambiguous_object(). See
+		 * its "TRANSLATORS" comments for details.
+		 */
+		advise(_("The candidates are:\n%s"), out.advice.buf);
+
 		oid_array_clear(&collect);
+		strbuf_release(&out.advice);
 	}
 
 	return status;
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 5ed7e49edc7..9c43699d3ae 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -70,7 +70,6 @@ test_expect_success 'ambiguous loose bad object parsed as OBJ_BAD' '
 
 	test_cmp_failed_rev_parse blob.bad bad0 <<-\EOF
 	error: short object ID bad0... is ambiguous
-	hint: The candidates are:
 	fatal: invalid object type
 	EOF
 '
@@ -91,11 +90,11 @@ test_expect_success POSIXPERM 'ambigous zlib corrupt loose blob' '
 
 	test_cmp_failed_rev_parse blob.corrupt cafe <<-\EOF
 	error: short object ID cafe... is ambiguous
-	hint: The candidates are:
 	error: inflate: data stream error (incorrect header check)
 	error: unable to unpack cafe... header
 	error: inflate: data stream error (incorrect header check)
 	error: unable to unpack cafe... header
+	hint: The candidates are:
 	hint:   cafe... [bad object]
 	hint:   cafe... blob
 	fatal: ambiguous argument '\''cafe...'\'': unknown revision or path not in the working tree.
-- 
2.34.1.1373.g062f5534af2

