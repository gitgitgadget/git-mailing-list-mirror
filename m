Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1384DC433F5
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 15:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346102AbiARPzi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 10:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346079AbiARPzg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 10:55:36 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6145C06173F
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 07:55:35 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id d18-20020a05600c251200b0034974323cfaso6880768wma.4
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 07:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Ft9tXQgPoU/SG9CvZK2TUDKGHqxEj46b1nQVDCP1bk=;
        b=TqcRY5wBBcup8mfHoRn27KNCiMwwy50VRUb58jfaxWBm01sqScNeoQtzOqMzT6DdVE
         T2D90LBmLGfM0mmGt0aMokeT2rHuR6Cptgou3nINDQTNYMna7SPQImHoPPR34N3KDkZ3
         7O5QHknfmmhJnh1LmeQB2FrCGf67vfT7AIUqlEIPIUmgZdQ4OR4cLlgy4lZjiWce5csV
         9GbTqrQ8ZXBP96eBEGwSGbVzvh8ia0Ge+4wRzgil4K4vc+KAgUPpQqVJWsyWugzuWn6F
         CZb130fgKrAr5LU2482VxgKtu1gHnzRsZh5zwdbidn/91wUPEbYJrQ9sAHlktEawbHix
         dwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Ft9tXQgPoU/SG9CvZK2TUDKGHqxEj46b1nQVDCP1bk=;
        b=42TBLaaOm1BzTW60+cbtHVKF1AWltSdFOsdiS/CxSaOp1TM/qMo+9G978j9scydpx8
         QVK5r5JWnElGW1GlEn9gOnOBlBnHAchAMypd61zoa6+DkrqTPm5u4HWa+Fl10FLCJHGF
         p35kLkVv+yrG/BLtgi/zDgOt0CkKknvVi06siWLeaanX2owiYBOTVrV6xShhTZF5576f
         uK4EiUpItgRU0nylYvx58sBIifM5+nBpTVzXVHeqWpzWLxjlR/MulY8Qqf+4/m85VD8x
         OQVURaxJ9RHAE21Zz1N224nefzYjFjlgowgr0zuxO328RXwmCnnaNgtEOCWef8qSKs0D
         hAug==
X-Gm-Message-State: AOAM530UmpJHvcvysrgyzGmgu4xcz6fOFHbstfmdrspblTLwT0Gw1j/U
        AcFODcPZKcuJtae1R43Xk1A2uflQ3bDk0g==
X-Google-Smtp-Source: ABdhPJxGuZrpYXVdTzRke1d7Wib0KVRT3h+7QRT1Aswt9CmC24210/UgGnBPkxnX1LC3FX2D0W+Fag==
X-Received: by 2002:adf:df84:: with SMTP id z4mr4165497wrl.519.1642521334152;
        Tue, 18 Jan 2022 07:55:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f15sm1220522wrd.45.2022.01.18.07.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 07:55:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 05/10] grep.c: don't pass along NULL callback value
Date:   Tue, 18 Jan 2022 16:55:17 +0100
Message-Id: <patch-v8-05.10-25dd327b653-20220118T155211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.rc1.864.g57621b115b6
In-Reply-To: <cover-v8-00.10-00000000000-20220118T155211Z-avarab@gmail.com>
References: <cover-v7-00.10-00000000000-20211228T004707Z-avarab@gmail.com> <cover-v8-00.10-00000000000-20220118T155211Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change grep_cmd_config() to stop passing around the always-NULL "cb"
value. When this code was added in 7e8f59d577e (grep: color patterns
in output, 2009-03-07) it was non-NULL, but when that changed in
15fabd1bbd4 (builtin/grep.c: make configuration callback more
reusable, 2012-10-09) this code was left behind.

In a subsequent change I'll start using the "cb" value, this will make
it clear which functions we call need it, and which don't.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index d85cbabea67..5ec4cecae45 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -285,8 +285,8 @@ static int wait_all(void)
 
 static int grep_cmd_config(const char *var, const char *value, void *cb)
 {
-	int st = grep_config(var, value, cb);
-	if (git_color_default_config(var, value, cb) < 0)
+	int st = grep_config(var, value, NULL);
+	if (git_color_default_config(var, value, NULL) < 0)
 		st = -1;
 
 	if (!strcmp(var, "grep.threads")) {
-- 
2.35.0.rc1.864.g57621b115b6

