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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B787DC433EA
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EB90619A1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhC1CO5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 22:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbhC1COL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 22:14:11 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA41CC0613B1
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:14:10 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id x13so9313831wrs.9
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gwU/mvPYOEEswqTANmgH3jXtpov8OiBjZS30Vi5PNPM=;
        b=eLO/W5/L/JHw4LbXYy95mZG+BTHG1jXeYtRWqPeqfsz4+RacVtIoNrtcBpTfacYL0f
         ziOiKpUEh4d8SIkjDSs+v0AVtz0joy2LTKhXlCZmdgaZBLPSAj7Pqlc27S4TYpumdBJL
         0aObM4CxURubAQAgv3T1sj/qfrGP3yMFQW+K1DgdbN+4I8aWQVQjbjR08lWnykoyYNNK
         NBTIrdYQz6yIAw4V9SzeKPh939gabAmSb1fo1qaWw1vG3H+4BZzTAADJU2gtB/m4TxvJ
         DoHAkRuAljSZYiSNgMn7M8/zzMBdWFrrdOmQDMR2zyjZV3d4IEyf1+jx8q07/xp0bJzm
         i1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gwU/mvPYOEEswqTANmgH3jXtpov8OiBjZS30Vi5PNPM=;
        b=Se1s+RcvXko1J0c26K5U8DtuxQj2CtHD5aH6ZaaYezVz8RF7pQfVprgMVoku4uoY8P
         Z/JoEHv1V0039DGAb+CLNIGqM2vn/3TxfLlU3uYzJIxpzvSD2+QCOk3somjDUCgAz7k2
         ZMxMnL2iQUlOenQ0X1+z1TwJ+H2VufhVTu+f6lgLAYDY8mAG2B2pvsj//Je1cNDxj5/V
         xN8W+CuwWHKtNYnCpNXxm70ikm9N+yIIdyy0yIJQlZcOJgeVP2NfNIkA44Zs0c7bLYJQ
         vGdvSaWNoVaGad2Aj9iguJLG1EhR4oVDd7ZncDMKI6mfmXDpm8+O6+AtIpGceU+JrUX4
         RwxA==
X-Gm-Message-State: AOAM533eBpMgcRHSFzp+DxgSsaWeyrPs7HmUcKk8I3+QWbxPiE4Id5jh
        JQx69jvjgHK9KyBC1f7seBo+9luUhJ7FBQ==
X-Google-Smtp-Source: ABdhPJzscSIIDNYuG4SXPeC6eeTXzpkrWE8QMz0qpZuCUuVf5kvMp0wUQvQmRxG9U8fFdPChy/dcew==
X-Received: by 2002:a5d:604b:: with SMTP id j11mr12383654wrt.424.1616897649127;
        Sat, 27 Mar 2021 19:14:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c2sm11291524wrt.47.2021.03.27.19.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 19:14:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/10] tree.c: fix misindentation in parse_tree_gently()
Date:   Sun, 28 Mar 2021 04:13:36 +0200
Message-Id: <patch-06.11-464c9e35256-20210328T021238Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.442.g6c06c9fe35c
In-Reply-To: <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
References: <20210308200426.21824-1-avarab@gmail.com> <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The variables declared in parse_tree_gently() had a single space after
the TAB. This dates back to their introduction in bd2c39f58f9 ([PATCH]
don't load and decompress objects twice with parse_object(),
2005-05-06). Let's fix them to follow the style of the rest of the
file.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tree.c b/tree.c
index a52479812ce..4820d66a10c 100644
--- a/tree.c
+++ b/tree.c
@@ -216,9 +216,9 @@ int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size)
 
 int parse_tree_gently(struct tree *item, int quiet_on_missing)
 {
-	 enum object_type type;
-	 void *buffer;
-	 unsigned long size;
+	enum object_type type;
+	void *buffer;
+	unsigned long size;
 
 	if (item->object.parsed)
 		return 0;
-- 
2.31.1.442.g6c06c9fe35c

