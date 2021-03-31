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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98511C43618
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82E216101E
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbhCaTKc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 15:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbhCaTKR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 15:10:17 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D18C061762
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 12:10:05 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k8so20731281wrc.3
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 12:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GCbl2rVABtsV4dddLtM5ybaHdfu1dwL7iDs2zWd0Wiw=;
        b=jRtC5e+S6A8Q7LssoET33yvoVllsewu6fZAoWHCW4BXu1HhOYizSlrqK3gsTHdg3J2
         2+Ku+Oh3iX8PNJpwhvOcxfhITyzowEAqn5Ag/jz31q3FWqRsmZzBo4GsJiWV0rzIhkGE
         aDb8byjxsxV/7arPbCxTdBgSgnunm/oXD5FaWmg/0TllE/5Ox+pkLe2gpgQXcVHS6j8a
         GGUiP9J/kOQzxu0pyBS1cAHGYB7qmSm+bQIlcBaqtCXutIouGzlo20Sx2iRrsl2giN+h
         E/PgU1v/waVGPqdaHxLmTm2LYME8jUlNkq4tVVkES0Xfn8oN/mzKH1T4ognELEYeOuIV
         jlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GCbl2rVABtsV4dddLtM5ybaHdfu1dwL7iDs2zWd0Wiw=;
        b=VOBYUb5bOHLTtrstyt2FVZARfByutf4bjq8Y5fHVPuJ6yzCxPPksNNmp9A36sVri+9
         0ymfHkBdRzR4YnnGXAAUWzHLJlhwxA7hIBAGfXRM1T8AJYWFPuZi4bJuq6fV+/9H+tgt
         7iMLJ811KluvCsXVO9JA6Djqs2VXM5m79gKVD/g70U56RAw+6UwieKW6tuVW+BqEomju
         vd+O8g+Lm37yOU3Ern1X/9sqWhlErrUXevSVrY3a9Dwc6hEDW9mxtREE9FYa9pCBSmM/
         H8521vEwF79E/VqnOx/C3arDq5/MG08JKBirktFJ68A7WWxOknmUKB8/LNHaRaBBoh0x
         AUZQ==
X-Gm-Message-State: AOAM533pwq0rU+tgaZ9B+GGIUcw2fhK//2iEYXq3wlLJQ4QgIJ/QrT7t
        dClRfUf26u4R+Hf2cnSD7WpCMDcoDbYjxg==
X-Google-Smtp-Source: ABdhPJyvbQ2YMg69hkt7wJi/h07oyisSSLZ/M1qwTXH6fx0MLt4EwQksi5/xd/wc3kzGhIfAYnDKJw==
X-Received: by 2002:a5d:6945:: with SMTP id r5mr5225943wrw.367.1617217804461;
        Wed, 31 Mar 2021 12:10:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l8sm6019268wrx.83.2021.03.31.12.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 12:10:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 17/18] tree-walk.h API: document and format tree_entry_extract()
Date:   Wed, 31 Mar 2021 21:09:45 +0200
Message-Id: <patch-17.19-dc895822828-20210331T190531Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.474.g72d45d12706
In-Reply-To: <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
References: <87o8fcqrg8.fsf@evledraar.gmail.com> <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document and format the argument list of the tree_entry_extract()
function in preparation for eventually adding a sister function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 tree-walk.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tree-walk.h b/tree-walk.h
index c60667cba8f..52eb0d6b5b3 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -38,11 +38,17 @@ struct tree_desc {
 
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
+ * tree_entry_extract(): const char *path, unsigned int mode
  */
-static inline const struct object_id *tree_entry_extract(struct tree_desc *desc, const char **pathp, unsigned short *modep)
+static inline const struct object_id *tree_entry_extract(struct tree_desc *desc,
+							 const char **pathp,
+							 unsigned short *modep)
 {
 	*pathp = desc->entry.path;
 	*modep = desc->entry.mode;
-- 
2.31.1.474.g72d45d12706

