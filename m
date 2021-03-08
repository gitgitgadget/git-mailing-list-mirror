Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92688C4332B
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 721AD6522F
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 15:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbhCHPHo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 10:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbhCHPHO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 10:07:14 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D6CC06175F
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 07:07:13 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h98so11772302wrh.11
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 07:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B+iRuURr+afdNjDjp/7XcvgdMkhCWEtNJRJ7P/VPoLE=;
        b=o6VWtkIvaaKrR+TJlL9ODGUNDSMbdVhi2hvc9D7pT5oyZbJ2+MA1c4nNiHSXFjFJYi
         TwtopzolqXkPtD5QgdDT7YFVgjVX3XxfVxalhKvJ4fgnVZPnPH/V0kzWvbZxChtageB8
         F/xedhjC0/JUxF6YPpvXEVagq68O03+uKeHOFRs8rgTC79WRFkgLnstt2+xmmO6KxNEr
         akqeDVoG1tgK8i6fFrpjSVOebrnLCtW25DR5RfXZJRA5o4ESlZaFc6wQsBv1eGuyLGhw
         tyUPLWwmCHafuWjY71FAD+/3CKIRTjEaBD1j8OiAzqdOb5mEFKYYkZ3Pwq0nOFfeH9Cl
         Hy5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B+iRuURr+afdNjDjp/7XcvgdMkhCWEtNJRJ7P/VPoLE=;
        b=FcbEc106bIHp81R5oD3UYJhlImWOEmDrMZHnepur75Y4bwfPa/qUFLxTkRDXwonm+P
         KPwXIOZpvjB1HWdhieFk3f0vubcM+NpLp59NKQY7dn0B988N9d8md3evXzVTeOFhOIwf
         KRJu81Mh71LFO+A8SQ4OEfRn1pyAkvhMbW4ek2ppCsnwrFE6Asr5hAClh7foKpbkyMTG
         K6XYYKiwg09S7+d2N/SQe8phYy/X6K9KuS6HzjGdHANVNGtYjdyBGlznp86WUpiHaIYA
         YPUw2ZKAKlaqEp5mtDchexggyovphFvKWrzi//LouXyf6V1b6Vga4emzLvPDaiwclYgv
         Rc2g==
X-Gm-Message-State: AOAM533AgthjmJ2hdIQvy6LA6fM5Ca7Bp3JUNODUkme46kgPCf9xopAP
        lcqC4MAFBKEWlO7zr6EKlDd2eyayssorWw==
X-Google-Smtp-Source: ABdhPJw3SHUXiHF70bq8Qyl2MxFwu0cshcVzyzoyNZT4M+3SRAUufzWXgBJGKT0P8UrPGtbL6qEL0g==
X-Received: by 2002:a5d:6304:: with SMTP id i4mr22884667wru.155.1615216032277;
        Mon, 08 Mar 2021 07:07:12 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j13sm3820488wrt.29.2021.03.08.07.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 07:07:11 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/30] tree-walk.h: add object_type member to name_entry
Date:   Mon,  8 Mar 2021 16:06:24 +0100
Message-Id: <20210308150650.18626-5-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
References: <20210308022138.28166-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most users of the tree walking API don't care what the specific mode
of an object in a tree is (e.g. if it's executable), they care if it's
one of OBJ_{TREE,BLOB,COMMIT}.

Let's add an "object_type" enum to the "name_entry" struct to help
such callers.

Ideally we'd have some subset of "enum object_type" here with just
those three entries, so we could rely on the C compiler to
exhaustively check our "switch" statements, but I don't know how to
create such a enum subset without re-labeling OBJ_{TREE,BLOB,COMMIT}
to e.g. "NE_OBJ_*" (an enum is just an int under the hood, so you can
use such a struct with "OBJ_*", but the compiler will complain...).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 tree-walk.c | 4 +++-
 tree-walk.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tree-walk.c b/tree-walk.c
index 2d6226d5f18..b210967b73b 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -47,7 +47,9 @@ static int decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned l
 
 	/* Initialize the descriptor entry */
 	desc->entry.path = path;
-	desc->entry.mode = canon_mode(mode);
+	mode = canon_mode(mode);
+	desc->entry.mode = mode;
+	desc->entry.object_type = object_type(mode);
 	desc->entry.pathlen = len - 1;
 	hashcpy(desc->entry.oid.hash, (const unsigned char *)path + len);
 
diff --git a/tree-walk.h b/tree-walk.h
index a5058469e9b..9f3825d2773 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -17,6 +17,8 @@ struct name_entry {
 	const char *path;
 	int pathlen;
 	unsigned int mode;
+	/* simple 'mode': Only OBJ_{BLOB,TREE,COMMIT} */
+	enum object_type object_type;
 };
 
 /**
-- 
2.31.0.rc0.126.g04f22c5b82

