Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45713C636D3
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 23:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjBFXJK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 18:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjBFXIt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 18:08:49 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E25B32E5C
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 15:08:26 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id hx15so38654772ejc.11
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 15:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PF7bzyqaW8jm5FlQ7+3qLTyxZs0RECAcIL3a6+EzHI=;
        b=Mdty0SzviG8Wlj0ks6l/OEEU726DwnKBHGPajN+SNu7RFlEcR3PfdA/Cs/jjN+G8Ov
         vMJuTL4L7LJy+egfxdASlHh/KNi4K/6cS/16xSdTPmJPXRbr/aTxYsMMpIMe99wgqc1V
         BSYfa2UIT+rFqnQnSKgatmX2ffwN8LgaP+VVBizahRMnXfPyI7mWzAaNuECyWJAC7B59
         ZBs9hfBQisJ9t6dTZLVJf7a0zrsyhj6SQ4DXh8sVhaATvGH3DTDTTtvz5pjfVF11TlH5
         iXbFdEOuF6uNYsoF8ENlfrxhfCeIVD6mTvRJSPjByZKUB93MM5SpwDxU2FmtVx0epjCQ
         C9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/PF7bzyqaW8jm5FlQ7+3qLTyxZs0RECAcIL3a6+EzHI=;
        b=hOMUoX0SSN/YENYfn7Xa8tWXUuPQBFB5vpxgxnv8iIXGPNSzoQfYB7ArOqHC6mBhlJ
         f6PNovIdT8oTtNPr91093LqXJ1vikAiVuVgLyPNppV4KVXj6GKM7jSI1dVJFeDr4te2v
         QPjB8mYuRVHBw51z8F2QSEg1Bidc19R+kEBL2cw1ulLqa+8tUAZoBcc+ysIsSqjNJQvz
         VCz4AQz9e0hcnAjuJK4wr9+a3OMHfBZZvOUnrx+e/69WtSVABe0OPSKhGgE1cRDCTW+T
         jD9qxwcrsQ799pFxVBWHR/JIInO1F8M64oxcVhzDM5Cg48fsV4wWMNMOXCuGF8jxweB5
         Fx4A==
X-Gm-Message-State: AO0yUKVi9hST029raw4EpqYiDWhc9kEqm6F6hFWxC6E3r/FAgRHKTH5/
        vjtYvV2sNSVbiZWATJ8NF21JzzmCHN+2zQeD
X-Google-Smtp-Source: AK7set+S8wEk7i+sNl4PYvEs46QsDJmezLeaz0myiWNIBTxexjRSWTdioap1mZdaaW9nPsrRMuEZIQ==
X-Received: by 2002:a17:906:1b1a:b0:885:23bc:3174 with SMTP id o26-20020a1709061b1a00b0088523bc3174mr1132723ejg.70.1675724904870;
        Mon, 06 Feb 2023 15:08:24 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906a18f00b0089d5aaf85besm2673586ejy.219.2023.02.06.15.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 15:08:24 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 16/19] grep API: plug memory leaks by freeing "header_list"
Date:   Tue,  7 Feb 2023 00:07:51 +0100
Message-Id: <patch-v7-16.19-2aea4017491-20230206T230142Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1425.gac85d95d48c
In-Reply-To: <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
References: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com> <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the "header_list" struct member was added in [1], freeing this
field was neglected. Fix that now, so that commands like

	./git -P log -1 --color=always --author=A origin/master

will run leak-free.

1. 80235ba79ef ("log --author=me --grep=it" should find intersection,
   not union, 2010-01-17)

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/grep.c b/grep.c
index f8708e1fd20..92ece4b7fa3 100644
--- a/grep.c
+++ b/grep.c
@@ -795,6 +795,7 @@ static void free_grep_pat(struct grep_pat *pattern)
 void free_grep_patterns(struct grep_opt *opt)
 {
 	free_grep_pat(opt->pattern_list);
+	free_grep_pat(opt->header_list);
 
 	if (opt->pattern_expression)
 		free_pattern_expr(opt->pattern_expression);
-- 
2.39.1.1425.gac85d95d48c

