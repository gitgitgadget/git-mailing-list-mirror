Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044C3C32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 08:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbiI1Imk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 04:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiI1Ikg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 04:40:36 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0474A5C72
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:40:10 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h7so6228056wru.10
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=C+hOf/8pbsL6RDdG3X5doBpdTwIkJnBfjQjGIbuzebc=;
        b=TfBVsb9em3JzU9m74TL8tjHiRSZi2pgfR1VO2QI3YDoe55K8peScMNtKvwjNiM7IMe
         Did8ErF/QVNjNRyQmeC4DMwFhFWdiCii18gqYsurBeqZ/gQIwuacw+wbsBnjsseRqo0P
         529YIJ58DwY/H/9IM1IkPLrXG/cq4CiV0DVOUf03lDcoQU/5DNEzuKuFGYnC4Y8ytZI9
         i4g+uJMI1JlOTj0hb6nP94JUTAAbZ0BLd7mjz+bA+fb0gpbC2GsnUsuPXZ1nGyP2qN6q
         HIcsdKsVNN+RdPkHEC8vnoJMoyPH9JOw4NI7TkSJg6sq9oHUTAlFZUUcCUnYsYY2SolQ
         3nYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=C+hOf/8pbsL6RDdG3X5doBpdTwIkJnBfjQjGIbuzebc=;
        b=gpZTrWkNwMS5mTpEMcC5rWXZMgzz4ksx0pGunHeHMeBOXkPRzZLbSY0e9T8ZSTklAj
         EoaCfQF5FZMpD7WDCiTpX2vejbSsCcPqJjSNn5Z8ZEyPER4h+9kx+D2dvqUElJfrL2T1
         Ekr2648uFtYyKaIn+A39rjluTMMcfhlE1LomN+KwxGDTfxVrj8of2K2gP8CHqhNBAIEb
         SEZiDf4UYoOn9PRRBeBp0TOVElk3XDwHYARldzvKKBvm1uZlBioBH3m5ehNq+jRGh26O
         QbSn9do3E2sxZpV/3ef2Hf8mnjNsSAzCOcS5pCg0t+THWkVJ6/cFQNHD1U9XYT+JM/Hl
         ONZQ==
X-Gm-Message-State: ACrzQf3i4F4NaehfE0ibnBv+rCuv4fsUgtJYGdjFFJgux1IXQIvabrFL
        mvdNafHQslr2g/y3Kpw/tf+EQrjdFM5t8g==
X-Google-Smtp-Source: AMsMyM5dBK1JMzmjR9efU9SzuE93796dh2QiFQhSRfB8f/3NmfhWbxAhspD5mbxaMyON++1KFVejZw==
X-Received: by 2002:a5d:64cd:0:b0:22a:ba05:8bcd with SMTP id f13-20020a5d64cd000000b0022aba058bcdmr20666790wri.74.1664354408301;
        Wed, 28 Sep 2022 01:40:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003b31fc77407sm1075026wmf.30.2022.09.28.01.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:40:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 30/35] doc txt & -h consistency: make "commit" consistent
Date:   Wed, 28 Sep 2022 10:39:25 +0200
Message-Id: <patch-v2-30.35-7289ab9e09b-20220928T082458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.925.gb61c5ccd7da
In-Reply-To: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com> <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the "-h" output of "git commit" consistent with the *.txt version
by exhaustively listing the options that it takes.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 21ad4ccbf87..64f420bcbf6 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -40,7 +40,14 @@
 #include "pretty.h"
 
 static const char * const builtin_commit_usage[] = {
-	N_("git commit [<options>] [--] <pathspec>..."),
+	N_("git commit [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]\n"
+	   "           [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>)]\n"
+	   "           [-F <file> | -m <msg>] [--reset-author] [--allow-empty]\n"
+	   "           [--allow-empty-message] [--no-verify] [-e] [--author=<author>]\n"
+	   "           [--date=<date>] [--cleanup=<mode>] [--[no-]status]\n"
+	   "           [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]\n"
+	   "           [(--trailer <token>[(=|:)<value>])...] [-S[<keyid>]]\n"
+	   "           [--] [<pathspec>...]"),
 	NULL
 };
 
-- 
2.38.0.rc1.925.gb61c5ccd7da

