Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48897C4332F
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 10:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354488AbiDBKvs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 06:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354468AbiDBKvm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 06:51:42 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853891403EA
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 03:49:50 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bh17so10681851ejb.8
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 03:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DpY+DiBP+IhDe3vXfDBSj6K4uYXpAJu/rkWWzaGkTM4=;
        b=q1bWjbhdsNdy666WMjDQXPASOwuRDWsja3QijTz+k08wa7G/OdNThbcpy3UnbsWJ8q
         c97OvYClBgmsdvdDj5d4K2D498Vu4WNFvjF/bh5osv5qKVcFGqVgTEAvgoA+B4dG/FfF
         6p3dXQgCVEQ6aluUVXDvazK1Hl4couoqnSjrBAkBd7pMwEIg3MIkXDV+cOkL/W1CAnhG
         WZJmH/tNpkR4vvnawmL15S5Pd3N8E7Ffd1JWNHPHJbnLEcuWaWXvaohN2FQpdYlb/E3K
         mRsaKWE7C3jsaxrHytFRxT88eb+UIWlh/kMzsTT7v+M4fiF9+adpJeKpiESm6AxLOz3U
         3zlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DpY+DiBP+IhDe3vXfDBSj6K4uYXpAJu/rkWWzaGkTM4=;
        b=XKY6M3TxcrZbEIXopWvdBvjxiIyj5snAfU/nPssDtM1A0bl3Gp+DpqfUYsjPKdYcrZ
         nVvhxoCderAfDHxq9BhQH/Ln0l1ZBMhLrwd7BW4htG8CILrH9V4+/c4H40VLew/0wJR3
         i2OlVXynQLNQqvH7j/lOBWUXw9nZdZITQ6RQvBkSKcCdrMpTLP+INsMCPs/HpcCiqLAC
         Nw7De4TWddJ8cfgOaMRULzw6may16aYjtGynKM4WeJpbjZ8qDPtufkxwH/bi0dwCv/o4
         ccH3Ca7Zs8mR3pXbSkrCnWLcfJYu8Odc9Oo7hKNZNZQmS6dwaQpc+VSKZ9FKLqHajb2e
         G4Mg==
X-Gm-Message-State: AOAM532Vd7+tXhbV0sDZCqHk5RUD4bOFauav26faEkISJnTNX8zlKRdD
        whH7H9vpMwMrmzn3cze7gUOZCZSQW1f0OQ==
X-Google-Smtp-Source: ABdhPJxDO4x7csoxL1Xc2K4JDVRNQfDfhSFbv1baXgY6WmgmrauWOxDE5IwlE3wTVNsm52vVUR0gNw==
X-Received: by 2002:a17:906:60d4:b0:6db:f0a8:f39e with SMTP id f20-20020a17090660d400b006dbf0a8f39emr3385714ejk.54.1648896588873;
        Sat, 02 Apr 2022 03:49:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r23-20020a056402235700b00419171bc571sm2366137eda.59.2022.04.02.03.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 03:49:48 -0700 (PDT)
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
Subject: [PATCH v5 04/27] format-patch: don't leak "extra_headers" or "ref_message_ids"
Date:   Sat,  2 Apr 2022 12:49:18 +0200
Message-Id: <patch-v5-04.27-5d4ad92d47b-20220402T102002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1584.g2aeb20a6519
In-Reply-To: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
References: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com> <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
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
2.35.1.1585.gd85f8dcb745

