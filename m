Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE462C433EF
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 22:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343800AbhKYWKg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 17:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244637AbhKYWIe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 17:08:34 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313EFC0613F3
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 14:03:51 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id j3so14476778wrp.1
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 14:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MxZO659F/jc1O/8N41y7xZjjvsE3WuhW3BXnwTTNTHA=;
        b=i0AY/dxhvJ9LHvGRHC0Kkx5cxpun5uZfrd5vWC8UZSTj+er394fCtXZXDKDamh/DZ8
         KZ36d2IA4DsmZAD57V1sJ8jR/gGy53mV64fIzuM2XPTSQIcUVfuP6d/suJoV5kT7iRDI
         5acvqFtG7o5wX5G4ymEKC1Oap6cAVCgsP5uVxlWDDV8Y+m4jHk/eM13eyv/3gWJEtTah
         gWBzqZ5LmkbnWzASlFF99C/FAt3XbexubFj5C6RKFxAU8X5yJQUXpDaOEWrynMjzvjYP
         +/U4e2NPAYaI7No4S+u93zNLFOmEeuuXg9PyKm5e2cL1jMd9/vETq9+53+HQBu3uqHqQ
         KyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MxZO659F/jc1O/8N41y7xZjjvsE3WuhW3BXnwTTNTHA=;
        b=ct6Ym49d4J5nTPuajYxqEynkXpeTRnFd/t3+5WavWKV4whk2jxhFOH9M1VypDpn4fK
         muuzBShOzfsTlrtanrSSX3XIifmZzSq+wON2wzx7rbWOTFz2YP7xpCu3zoLbJSyfjNmi
         M+oXX/tECPTiOdMhHkXQaBLsB5sSugM41OnRUrSBoMx/zPUVfpZhDrjX08xVT6IZpQ24
         ciRAsTyAjekmZSjs0MSMykIbo3B/jq55h57mW1f8mJrxcZaChe0L7+J4uomFNFqIpFO+
         zwerolmeZH1tpfAvTDaTUMcILuIRCNhrw+TKFXcXY1HwkkS3kg26Sv4YUPb55RsdCrbf
         aidw==
X-Gm-Message-State: AOAM5305dvuBr2t9qKKMfMQMLBLTr6WvoAiTgVZC/moWNIOkLyBXZisr
        cXyufD7AR0yvOZMDFo8JOUZjnCoHV7W1/g==
X-Google-Smtp-Source: ABdhPJyn6/pFsmicfF15PYGrSvoi9fu3EGc+/YND95u9HTTGyFXgOs4MJxGzpneVB7b3MOlF/OrstA==
X-Received: by 2002:a5d:59aa:: with SMTP id p10mr10374509wrr.210.1637877829460;
        Thu, 25 Nov 2021 14:03:49 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2sm8883726wmi.36.2021.11.25.14.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 14:03:48 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 3/6] object-name: make ambiguous object output translatable
Date:   Thu, 25 Nov 2021 23:03:41 +0100
Message-Id: <patch-v5-3.6-b79964483e8-20211125T215529Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.838.g779e9098efb
In-Reply-To: <cover-v5-0.6-00000000000-20211125T215529Z-avarab@gmail.com>
References: <cover-v4-0.3-00000000000-20211122T175219Z-avarab@gmail.com> <cover-v5-0.6-00000000000-20211125T215529Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the output of show_ambiguous_object() added in [1] and last
tweaked in [2] and the preceding commit to be more friendly to
translators.

By being able to customize the "<SP><SP>%s\n" format we're even ready
for RTL languages, who'd presumably like to change that to
"%s<SP><SP>\n".

1. 1ffa26c461 (get_short_sha1: list ambiguous objects on error,
   2016-09-26)
2. 5cc044e0257 (get_short_oid: sort ambiguous objects by type,
   then SHA-1, 2018-05-10)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-name.c | 64 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 57 insertions(+), 7 deletions(-)

diff --git a/object-name.c b/object-name.c
index 9750634ee76..1dcbba7fa76 100644
--- a/object-name.c
+++ b/object-name.c
@@ -356,38 +356,88 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 	const struct disambiguate_state *ds = data;
 	struct strbuf desc = STRBUF_INIT;
 	int type;
+	const char *hash;
 
 	if (ds->fn && !ds->fn(ds->repo, oid, ds->cb_data))
 		return 0;
 
+	hash = repo_find_unique_abbrev(ds->repo, oid, DEFAULT_ABBREV);
 	type = oid_object_info(ds->repo, oid, NULL);
 
 	if (type < 0) {
-		strbuf_addstr(&desc, "[bad object]");
+		/*
+		 * TRANSLATORS: This is a line of ambiguous object
+		 * output shown when we cannot look up or parse the
+		 * object in question. E.g. "deadbeef [bad object]".
+		 */
+		strbuf_addf(&desc, _("%s [bad object]"), hash);
 		goto out;
 	}
 
 	assert(type == OBJ_TREE || type == OBJ_COMMIT ||
 	       type == OBJ_BLOB || type == OBJ_TAG);
-	strbuf_addstr(&desc, type_name(type));
 
 	if (type == OBJ_COMMIT) {
+		struct strbuf ad = STRBUF_INIT;
+		struct strbuf s = STRBUF_INIT;
 		struct commit *commit = lookup_commit(ds->repo, oid);
+
 		if (commit) {
 			struct pretty_print_context pp = {0};
 			pp.date_mode.type = DATE_SHORT;
-			format_commit_message(commit, " %ad - %s", &desc, &pp);
+			format_commit_message(commit, "%ad", &ad, &pp);
+			format_commit_message(commit, "%s", &s, &pp);
 		}
+
+		/*
+		 * TRANSLATORS: This is a line of ambiguous commit
+		 * object output. E.g.:
+		 *
+		 *    "deadbeef commit 2021-01-01 - Some Commit Message"
+		 */
+		strbuf_addf(&desc, _("%s commit %s - %s"), hash, ad.buf, s.buf);
+
+		strbuf_release(&ad);
+		strbuf_release(&s);
 	} else if (type == OBJ_TAG) {
 		struct tag *tag = lookup_tag(ds->repo, oid);
+		const char *tag_tag = "";
+
 		if (!parse_tag(tag) && tag->tag)
-			strbuf_addf(&desc, " %s", tag->tag);
+			tag_tag = tag->tag;
+
+		/*
+		 * TRANSLATORS: This is a line of
+		 * ambiguous tag object output. E.g.:
+		 *
+		 *    "deadbeef tag Some Tag Message"
+		 *
+		 * The second argument is the "tag" string from
+		 * object.c, it should (hopefully) already be
+		 * translated.
+		 */
+		strbuf_addf(&desc, _("%s tag %s"), hash, tag_tag);
+	} else if (type == OBJ_TREE) {
+		/*
+		 * TRANSLATORS: This is a line of ambiguous <type>
+		 * object output. E.g. "deadbeef tree".
+		 */
+		strbuf_addf(&desc, _("%s tree"), hash);
+	} else if (type == OBJ_BLOB) {
+		/*
+		 * TRANSLATORS: This is a line of ambiguous <type>
+		 * object output. E.g. "deadbeef blob".
+		 */
+		strbuf_addf(&desc, _("%s blob"), hash);
 	}
 
+
 out:
-	advise("  %s %s",
-	       repo_find_unique_abbrev(ds->repo, oid, DEFAULT_ABBREV),
-	       desc.buf);
+	/*
+	 * TRANSLATORS: This is line item of ambiguous object output
+	 * from describe_ambiguous_object() above.
+	 */
+	advise(_("  %s"), desc.buf);
 
 	strbuf_release(&desc);
 	return 0;
-- 
2.34.1.838.g779e9098efb

