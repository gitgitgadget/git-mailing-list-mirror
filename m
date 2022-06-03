Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78169C43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 18:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345709AbiFCSjU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 14:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347499AbiFCSjA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 14:39:00 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AC713EB4
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 11:38:04 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id m26so18303wrb.4
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 11:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Mhctn5kYJQ082mzR0HtUxB+5kUYU8ydqKsBXQzJ6nE=;
        b=Mh3w9f5Oo7X2s3qps27IfBhcgUH178azn2/SHpqcoNhZtLscv/XcQ4Mqu5IN6by5KC
         HZZIn9N0Ru8CoWX6bZtEp9xpyp092ewO73A5GFqvF7nqSvpkVtr33n+SCF9R6qr5hYSo
         ghU8PiEAyaflG6meBYRqe/gElwvy2bxD5Jt9evGdf+OYjJ2w+vDAGJWd0Qu3ODdE3RKv
         zIvIHewUXy6CLkTbdbaN40E6nO5luhEE/cM5aJPgd8vAT/NC8YI37IaWS3yWGWKdf6EL
         ptSPEZmgCobxT+snbVTmPh26d4C7ArIDhNeAL0oQKpyGjqBiWLPqQwsv2LIA1eGzVSeJ
         Jgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Mhctn5kYJQ082mzR0HtUxB+5kUYU8ydqKsBXQzJ6nE=;
        b=MRezADBKe38R+YJjM05V1j+/XLx/ISEoHxC1TbgvFGCg/XoYv9WttcCdMMCsRRRtuX
         qBhwCzHwOyscfwpVcZLYKXYHUy2ht5yH91efLiwmp3XlutwVVwm+n1elkvNaAqOwOkBn
         8EYC0J4hzXeqN0llVCiLMO0A+7qDkGN0GgQA9LH5N/Boo/xEiEU/3+XQMLoJ0cPABclA
         b6/kt2EH+cwilJct8AmblvtddMD8DVZZmmXcdsM/jPy96S9Yk7wWoggGqiKtoIrsxWlB
         R8Wc6h52S1hELFmXkyhZS5Y5Z2qhduOegxVdJODYyCO2MWo8Wmn/JvBsUckklhy4zi+3
         8fTg==
X-Gm-Message-State: AOAM532YR5skPYVrPSDV8fxsLRrKUngXdrtIqwQ+cl/tPhX16/Qxj8u0
        lHo98/izQ4UDMaxaxFW+dteOVBU4Nyaj4Q==
X-Google-Smtp-Source: ABdhPJxWW7BRM5KIxYf/i6TvH8BA4xpw3YQQocjasHKZ7Q2yFkB+Iwk3+GA6OZJ5XLSTiZXyhjRRJQ==
X-Received: by 2002:adf:dc92:0:b0:20f:e1a9:9d92 with SMTP id r18-20020adfdc92000000b0020fe1a99d92mr9289691wrj.199.1654281482351;
        Fri, 03 Jun 2022 11:38:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y5-20020adff6c5000000b0020c5253d926sm8232636wrp.114.2022.06.03.11.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 11:38:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jinoh Kang <luke1337@theori.io>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 02/15] pull.c: don't feed NULL to strcmp() on get_rebase_fork_point() path
Date:   Fri,  3 Jun 2022 20:37:39 +0200
Message-Id: <RFC-patch-02.15-4a055969ea5-20220603T183608Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1124.g577fa9c2ebd
In-Reply-To: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix an issue with feeding NULL to strcmp() noted by GCC's -fanalyzer,
this fixes a bug in 1678b81ecce (pull: teach git pull about --rebase,
2015-06-18).

In cmd_pull() we could go through the function without initializing
the "repo" argument (the -fanalyzer output shows how exactly), we'd
then call get_rebase_fork_point (), which would in turn call
get_tracking_branch() with that "NULL" repo argument.

Let's avoid this potential issue by returning NULL in this case, which
will have get_rebase_fork_point() return -1 in turn.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/pull.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 01155ba67b2..ed8df004028 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -756,14 +756,16 @@ static const char *get_tracking_branch(const char *remote, const char *refspec)
 		starts_with(spec_src, "remotes/"))
 		spec_src = "";
 
-	if (*spec_src) {
-		if (!strcmp(remote, "."))
-			merge_branch = mkpath("refs/heads/%s", spec_src);
-		else
-			merge_branch = mkpath("refs/remotes/%s/%s", remote, spec_src);
-	} else
+	if ((*spec_src && !remote) || !*spec_src) {
 		merge_branch = NULL;
+		goto cleanup;
+	}
 
+	if (!strcmp(remote, "."))
+		merge_branch = mkpath("refs/heads/%s", spec_src);
+	else
+		merge_branch = mkpath("refs/remotes/%s/%s", remote, spec_src);
+cleanup:
 	refspec_item_clear(&spec);
 	return merge_branch;
 }
-- 
2.36.1.1124.g577fa9c2ebd

