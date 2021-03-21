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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A5DC4345C
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 430F161937
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhCUACb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 20:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhCUABq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 20:01:46 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D487DC061574
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:45 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id d8-20020a1c1d080000b029010f15546281so6957469wmd.4
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xx3wfUsO0pas8hkBedRW0E2y9rCzJOX14wkb+nX7VCY=;
        b=rM4ejcvJSpht1M7zJmaY+cwrKcEsx8OOT9d5jKy3BQcOUddSXHH1PssHepEw2xiFPm
         cSIv7LqyXuqZTdQ7+zA4VRCsGW8QtHJeTAeaciFIi1UWYeCHXStBNxeZO4Qs7ZkDAdhc
         odR/Hbh2HQW8yLFVSjNhYHg5h90cRNE/QMt6ScDSYMpGxoALK7Abiy4NK9rjFbGtg8b/
         EUyhXwXd6XmVwhDKAkqCYlS1nS72ZqlzekjRDMLvC0a+IXsjyuJA9LywlsQqfDnxIZ9B
         o4arYl++S58YGtJD8pyfmdm+4kut01kokApkvEkIo0JPEDT1c9K6RRTFXR3wIG2/xyaQ
         QcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xx3wfUsO0pas8hkBedRW0E2y9rCzJOX14wkb+nX7VCY=;
        b=dqclFT3He9SEMUCh+SbO+ADSMyDAkCvIDXndHwr42yggY6v3pWqbkPbOci0CKyMG5+
         1/M/ZvGbDW5kocfT47kAgZo6sDfmHh3E0MJoNsPMR1QdvS3hAzvVY3X6V8mnOsGXTmna
         RV2koGiK0cXUZirAXWrE6Ydz4yJ5bIrMuOMkjy+pJnLf1+ImRylEL3GIoSTPHl/0FqBx
         WMq5Ybz5+NPm2emSiyhbKwe/sFZqwtJQXIWrp/7f/iZVuG9Gve/3l2JLiX/5V7oIVIuo
         At0AtAiexHnYahl2qGGcBYtOPEwuW4oD4zchlYXIfPVK9e46dYgZyCDXZ1TLkMSKnQjJ
         MHxw==
X-Gm-Message-State: AOAM532f0EyIHiEGh9CmlbMSu0SUWMIFUIGDFReNTGek49r5yrmWJfbW
        zeOVaTQvcplnMMdhgfs2aNcTRbuIOKtUkA==
X-Google-Smtp-Source: ABdhPJxuSJ35TDo1YtWRQETMFIHa/5ly1/W1W4I3NAOpYlyBd/Oi+laXtvCNHieysy+VAKLt7kXsmA==
X-Received: by 2002:a1c:a958:: with SMTP id s85mr9814435wme.4.1616284904410;
        Sat, 20 Mar 2021 17:01:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g5sm15304834wrq.30.2021.03.20.17.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 17:01:43 -0700 (PDT)
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
Subject: [PATCH v4 23/29] tree-walk.h API: document and format tree_entry_extract()
Date:   Sun, 21 Mar 2021 01:00:56 +0100
Message-Id: <7ab7576cb16727d9aa9edb24a2c26b1f0b1e8880.1616282534.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.282.gcc1ec606501
In-Reply-To: <cover.1616282533.git.avarab@gmail.com>
References: <20210316155829.31242-1-avarab@gmail.com> <cover.1616282533.git.avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document and format the argument list of the tree_entry_extract()
function in preparation for adding a sister function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 tree-walk.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tree-walk.h b/tree-walk.h
index f569960c6fb..f51485250fb 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -40,11 +40,17 @@ struct tree_desc {
 
 /**
  * Decode the entry currently being visited (the one pointed to by
- * `tree_desc's` `entry` member) and return the sha1 of the entry. The
- * `pathp` and `modep` arguments are set to the entry's pathname and mode
- * respectively.
+ * `tree_desc's` `entry` member) and return the OID of the entry.
+ *
+ * There are variants of this function depending on what fields in the
+ * "struct name_entry" you'd like. You always need a pointer to an
+ * appropriate variable to fill in (NULL won't do!):
+ *
+ * tree_entry_extract_mode(): const char *path, unsigned int mode
  */
-static inline const struct object_id *tree_entry_extract(struct tree_desc *desc, const char **pathp, unsigned short *modep)
+static inline const struct object_id *tree_entry_extract(struct tree_desc *desc,
+							 const char **pathp,
+							 unsigned short *modep)
 {
 	*pathp = desc->entry.path;
 	*modep = desc->entry.mode;
-- 
2.31.0.286.gc175f2cb894

