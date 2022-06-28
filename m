Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4227DC433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 10:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344718AbiF1KGR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 06:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344666AbiF1KGM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 06:06:12 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEE9B78
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:06:11 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i25so11391599wrc.13
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8RkEeuNcgA106GnboT2kf6jZh6qclVic8rYXy+0Ntv4=;
        b=p/49C3Eox4EA8MrO+1ltw7YGLYZCeEIkV3uvXj9VVEaBmpJD8U8GCYcztxE6y3UHxv
         LK4XmxW84YhzN/Wd9bKV/1Dr8G0eNo797q0lmvPK7BwRb81nsQlGU3sCkzS9IsmlDRWx
         ZAMFr0TEUx4ROLVOkHM5yS9WkJtT99LBb1+JsjkimalcZQzJftKtC1mSYVwDN+KkfUwj
         mDha6d29Dg2LV0hlmShcBLLMgrHqIiwSmXcBQNjTr8dBvOhBL9oUrFA2cB+rc1NTG8ZR
         5qw4luVGUolLGkOSS90jAcIzTitWlHw0jhX59t8yOlIgTfOQRh++aBwSMh7hvQWQF7Zx
         OysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8RkEeuNcgA106GnboT2kf6jZh6qclVic8rYXy+0Ntv4=;
        b=Q2PNtozSdlIwbj+QCm2Gbsx9TbEIt5yp4kGZ+2+DurcMhoa8Ad5d7GRtNPYDP9mWMz
         GImXd/Q2MQ3oif1cETilvM4G8klPG1nMgZDZrnao4EXrF0uP+waDX4QeBxrX2JaGW9de
         K4vj7ualA9LVaRPW7uDT7/OTt2Q3hT9bOH3DMCIcCgiotHLO9l1k8wBZFb7EXgm/VdEv
         JUAutEkGrbKiZibcERsriIIS+txapnt1q7awd2S1Hh0BmjllNU8JxqAS0plskG1PBsmP
         WQ0YMwaLflj1Ev8brvSoYlsqasgoFZW1O9GSgVGzOtx170QLhhUqZcuy1n5i41gSK0b4
         pAJQ==
X-Gm-Message-State: AJIora8KyJZ6i3LV7+Lp4hZYZFnay40Gy71FXYreGnRbxTy6KTPbIgC/
        F5f+IvUSpnGYs9L0ahTKZPEW5bOdFUU=
X-Google-Smtp-Source: AGRyM1vkpdZTtEmy3K+reYxmVAyEi5lEOq4P5j45vfFNKzJ6lWBoMOKIjgwmofILXQC4POurFVzN4Q==
X-Received: by 2002:a5d:688e:0:b0:21b:9d51:25d2 with SMTP id h14-20020a5d688e000000b0021b9d5125d2mr17308364wru.286.1656410770014;
        Tue, 28 Jun 2022 03:06:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e16-20020a5d4e90000000b0021b91d1ddbfsm12914430wru.21.2022.06.28.03.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 03:06:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 02/12] git-submodule.sh: remove unused $prefix variable
Date:   Tue, 28 Jun 2022 12:05:24 +0200
Message-Id: <patch-v4-02.12-7bf62497c54-20220628T095914Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.880.gf07d56b18ba
In-Reply-To: <cover-v4-00.12-00000000000-20220628T095914Z-avarab@gmail.com>
References: <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com> <cover-v4-00.12-00000000000-20220628T095914Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the $prefix variable which isn't used anymore, and hasn't been
since b3c5f5cb048 (submodule: move core cmd_update() logic to C,
2022-03-15).

Before that we'd use it to invoke "git submodule--helper" with the
"--recursive-prefix" option, but since b3c5f5cb048 that "git
submodule--helper" option is only used when it invokes itself.

So the "--recursive-prefix" option is still in use, but at this point
only when the helper invokes itself during submodule recursion. See
the "--recursive-prefix" option added in
c51f8f94e5b (submodule--helper: run update procedures from C,
2021-08-24).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-submodule.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index bc436c4ca47..53847bbf6e2 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -41,7 +41,6 @@ files=
 remote=
 nofetch=
 update=
-prefix=
 custom_name=
 depth=
 progress=
@@ -127,7 +126,7 @@ cmd_add()
 		usage
 	fi
 
-	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper add ${GIT_QUIET:+--quiet} ${force:+--force} ${progress:+"--progress"} ${branch:+--branch "$branch"} ${reference_path:+--reference "$reference_path"} ${dissociate:+--dissociate} ${custom_name:+--name "$custom_name"} ${depth:+"$depth"} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper add ${GIT_QUIET:+--quiet} ${force:+--force} ${progress:+"--progress"} ${branch:+--branch "$branch"} ${reference_path:+--reference "$reference_path"} ${dissociate:+--dissociate} ${custom_name:+--name "$custom_name"} ${depth:+"$depth"} -- "$@"
 }
 
 #
@@ -189,7 +188,7 @@ cmd_init()
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper init ${GIT_QUIET:+--quiet} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper init ${GIT_QUIET:+--quiet} -- "$@"
 }
 
 #
@@ -346,7 +345,6 @@ cmd_update()
 		${init:+--init} \
 		${nofetch:+--no-fetch} \
 		${wt_prefix:+--prefix "$wt_prefix"} \
-		${prefix:+--recursive-prefix "$prefix"} \
 		${update:+--update "$update"} \
 		${reference:+"$reference"} \
 		${dissociate:+"--dissociate"} \
-- 
2.37.0.880.gf07d56b18ba

