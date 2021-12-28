Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A9CC433FE
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 01:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbhL1BHv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 20:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbhL1BHu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 20:07:50 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D9FC061401
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 17:07:50 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id g132so10649513wmg.2
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 17:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m3gvcz6MZkxKuiit6yCJXexCEQo+AEs2KX5d0zdtU+g=;
        b=InEVBSMT2Rnwllqke1/24U8M7OHLc95OOL8fUsDijqM7YkKL+xuqA5VQep8jEu1hji
         +Y1UGyh/YOyFRamh936pPvbObdvEL+C6rc9OWT/KM/TNf3VsldJOBn3+wtFnxeDyObVb
         AlF/QPD7IAJmFYJ8YmnNO4CDjdSVc1tPAWSgWo9Ft/epkU1VCVr/2OSDisc8HXXUkGrJ
         m8zKZjRegIpcTgh/6De26f207otD5lld9f5jSKo9MSyOPNrS2R/Ti++xs1qm3z/X6f9m
         qH45Y5CripXGk3AjMoUAQIbjbUYji+YYtyBmbBQQ2+cjw5J+frcJEViZoRu9mqwBCpPq
         wleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m3gvcz6MZkxKuiit6yCJXexCEQo+AEs2KX5d0zdtU+g=;
        b=K8EpoqDkdFygjZlGT4pZg8qhOpUa9hcOeLIPzNrm9MJF5wEwTFLkKOxdlqHdx9BSfj
         gwEcPe8tdOPsmTPVGYvlft5AkPAorxDVAQrj+hygHXmnKXRm2vvsVMJtl2gq6o/YVVtr
         NCeERiT4BKAOm6z6BqujYJn6nDepPsmrxgCzEIB1ndG8dwIrkILOb1L+6Vx0CcDgHCvF
         wzirXzrWrqFAb3jc4+BAiTNKsyqHmfrN6KAh0ChpX1Mj092YLagNfYZFw1/cNDR6ee7C
         JILg6Ay6atcc6T3Y2TXFPJ5lU2Z0t8neqvq3f6NLBL3oQsObfLU74ab7CZ+KFRYE+FT5
         vEgQ==
X-Gm-Message-State: AOAM533uUqZmD1VKLTsCygJg+A4ZLucf3RLkYElRFDgpSxMMlu3czSBZ
        9+KDQ5FtQYLNsBc25//vpxUWZrZX3TQXcrGj
X-Google-Smtp-Source: ABdhPJySLqvFrn+tkUXFfknrK8DUIpq0Ap+oFcvPVVYvEZNv/avqWP+s+PitQRHKa2oL48K6uXu8MA==
X-Received: by 2002:a7b:c7c5:: with SMTP id z5mr15100587wmk.173.1640653668824;
        Mon, 27 Dec 2021 17:07:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b197sm16910973wmb.24.2021.12.27.17.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 17:07:48 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 01/10] grep.h: remove unused "regex_t regexp" from grep_opt
Date:   Tue, 28 Dec 2021 02:07:36 +0100
Message-Id: <patch-v7-01.10-b62e6b6162a-20211228T004707Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1250.g6a242c1e9ad
In-Reply-To: <cover-v7-00.10-00000000000-20211228T004707Z-avarab@gmail.com>
References: <cover-v6-0.7-00000000000-20211226T223035Z-avarab@gmail.com> <cover-v7-00.10-00000000000-20211228T004707Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This "regex_t" in grep_opt has not been used since
f9b9faf6f8a (builtin-grep: allow more than one patterns., 2006-05-02),
we still use a "regex_t" for compiling regexes, but that's in the
"grep_pat" struct".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/grep.h b/grep.h
index 3e8815c347b..95cccb670f9 100644
--- a/grep.h
+++ b/grep.h
@@ -136,7 +136,6 @@ struct grep_opt {
 
 	const char *prefix;
 	int prefix_length;
-	regex_t regexp;
 	int linenum;
 	int columnnum;
 	int invert;
-- 
2.34.1.1250.g6a242c1e9ad

