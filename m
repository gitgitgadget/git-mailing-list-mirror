Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED65EC04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbiG1QS4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiG1QSf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:18:35 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1977391A
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:18:04 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i8so2828554wro.11
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ckqrD3hH13p2qON38mod7R36gZGimi2AJfWYHCWq7fM=;
        b=IpMMhlp1i9iNq+YyDCcBZoBxWge0oaptvvgVQ/VZybLNtvEjwYLiNPeIQF40mpsJra
         iK6nKiIIqfS1Afwg6W3qYnPxB83VSrqXybCAZ5IRV+3umREJyRi07/8RYU3PdEGet53M
         ZA/1L4meE6ZmvMp4KN0EupPkGgC+kGIir4rJXQV3Qamb8rydclHPaX6KeJqO1wLO91/o
         5NkrHRyoJN/RXkawrIVUkfwk2LRoKvrU4HUTyxZFfO1yN54JrG2xfvwYxJL2OZaUPxyR
         EA21KUpWxy86t/SycGr9r0EV1JTi0c8HDjlirTJgzIuwy9iIsZR3t3kqIamiEqnW+Ugw
         chcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ckqrD3hH13p2qON38mod7R36gZGimi2AJfWYHCWq7fM=;
        b=MYexlFnqvHAqvAECumWK8RHe6DPDHnL5fcP9n4O8YGcAJ8KMquNsI/PpeFr0LM/jLr
         rqwCq5W0KY6bwOWW2s+5RVzIDIuZDA0xNaUxHyCF0pjFv4M5L3kFYGclDR6Md84aLNim
         0ec6vWj+ebEadwL3tCHEMZvA8GwpIo6NNKTu/MRN+rCy6F0ln78Oq9PDDmtZrsT1brH3
         4cSOiI6UYaJe+LxTJ+//qTk49mBKgze/PLSM3wMu2woSzxhg9JvGiMAQxp+F59FPfSMq
         341nQwZ2Q+ACLR0N3DiBz9FHpAeb9yK6AEXRTtXyzGA5BQqhdUOubV7D9hOiZuzlgRpu
         fJ4Q==
X-Gm-Message-State: AJIora9tvl9SD+yTvN4xCDEzwtTWoOJoD8wcni/KhW+K+VSeU/eFx42A
        uyiJSaDPi1ETRtK4JaHze3uXrsyl6+qhBQ==
X-Google-Smtp-Source: AGRyM1sznCOK5T6sJ6K6mi8TShMS8MnfvU2y0SqbdjwZx2dvDCHR2U5x7KcadI8u4Eh3mUWj07EirQ==
X-Received: by 2002:a5d:5403:0:b0:21e:ea93:234d with SMTP id g3-20020a5d5403000000b0021eea93234dmr3649314wrv.125.1659025082149;
        Thu, 28 Jul 2022 09:18:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w13-20020adfee4d000000b0021f0af83142sm1220117wro.91.2022.07.28.09.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:18:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 16/20] submodule--helper: refactor "errmsg_str" to be a "struct strbuf"
Date:   Thu, 28 Jul 2022 18:17:01 +0200
Message-Id: <patch-16.20-68202100d9a-20220728T161116Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1167.g38fda70d8c4
In-Reply-To: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Refactor code added in e83e3333b57 (submodule: port submodule
subcommand 'summary' from shell to C, 2020-08-13) so that "errmsg" and
"errmsg_str" are folded into one. The distinction between the empty
string and NULL is something that's tested for by
e.g. "t/t7401-submodule-summary.sh".

This is in preparation for fixing a memory leak the "struct strbuf" in
the pre-image.

Let's also pass a "const char *" to print_submodule_summary(), as it
should not be modifying the "errmsg".

Signed-off-by: Glen Choo <chooglen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index fe92c9858ce..f451704af79 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -761,7 +761,7 @@ static char *verify_submodule_committish(const char *sm_path,
 	return strbuf_detach(&result, NULL);
 }
 
-static void print_submodule_summary(struct summary_cb *info, char *errmsg,
+static void print_submodule_summary(struct summary_cb *info, const char *errmsg,
 				    int total_commits, const char *displaypath,
 				    const char *src_abbrev, const char *dst_abbrev,
 				    struct module_cb *p)
@@ -819,7 +819,7 @@ static void generate_submodule_summary(struct summary_cb *info,
 {
 	char *displaypath, *src_abbrev = NULL, *dst_abbrev;
 	int missing_src = 0, missing_dst = 0;
-	char *errmsg = NULL;
+	struct strbuf errmsg = STRBUF_INIT;
 	int total_commits = -1;
 
 	if (!info->cached && oideq(&p->oid_dst, null_oid())) {
@@ -920,23 +920,21 @@ static void generate_submodule_summary(struct summary_cb *info,
 		 * submodule, i.e., deleted or changed to blob
 		 */
 		if (S_ISGITLINK(p->mod_dst)) {
-			struct strbuf errmsg_str = STRBUF_INIT;
 			if (missing_src && missing_dst) {
-				strbuf_addf(&errmsg_str, "  Warn: %s doesn't contain commits %s and %s\n",
+				strbuf_addf(&errmsg, "  Warn: %s doesn't contain commits %s and %s\n",
 					    displaypath, oid_to_hex(&p->oid_src),
 					    oid_to_hex(&p->oid_dst));
 			} else {
-				strbuf_addf(&errmsg_str, "  Warn: %s doesn't contain commit %s\n",
+				strbuf_addf(&errmsg, "  Warn: %s doesn't contain commit %s\n",
 					    displaypath, missing_src ?
 					    oid_to_hex(&p->oid_src) :
 					    oid_to_hex(&p->oid_dst));
 			}
-			errmsg = strbuf_detach(&errmsg_str, NULL);
 		}
 	}
 
-	print_submodule_summary(info, errmsg, total_commits,
-				displaypath, src_abbrev,
+	print_submodule_summary(info, errmsg.len ? errmsg.buf : NULL,
+				total_commits, displaypath, src_abbrev,
 				dst_abbrev, p);
 
 	free(displaypath);
-- 
2.37.1.1167.g38fda70d8c4

