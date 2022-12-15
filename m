Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B317C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 08:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiLOIwo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 03:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLOIwb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 03:52:31 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEBD1D64D
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 00:52:29 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h10so2307911wrx.3
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 00:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjKghlCm2715h/Z/Ni1lV80lLwuQoZsFvimgdqNo1TE=;
        b=JsBB6bRcnimXT+yayZA4pHOEj3y6B32ec68DHWa9sEsQJvnYV6Esr6VETfWYGlUc4Z
         ZcWY5TSQd5U0cBFTk/K/7UMWmvfBLm0pH9I07iAVUalk2ThxO82IG8nPgR8EFi49SBIN
         cI++saxqbED1oW+8N2goedO/L8OZDld/LPXM6oJlfW/VPdUyuR6TP83A5HMdHZEk7u5b
         WlLcXHH42ofR3UOqPVrM5WCBZSQ4aPHYvgM9yy5zQlg30iKrIK1p4H1ZVLHR3XhyIsEW
         iiENaahyuw+nxEoW4ycC3stvqqtRNegG24eOM8JKnjxZZPyQxUt+6/qNLKw70td9auoS
         kS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjKghlCm2715h/Z/Ni1lV80lLwuQoZsFvimgdqNo1TE=;
        b=R+TW5KUqybhJZPzw/f2xsNuyNydajPkg+QhD6VZO/jjG4ZpAYDymdzx1l/7ggZVdVn
         j72CPlyFrSsL18cicbAYQvBT1GJqusApjoaB/8XZwCGWghn3FAUwVLumQ14DpBAA+uAB
         L+kmwo2dRsQ/zlRC6Qz4PAECe0FFBJQkxC+HWEC/iM/VNJcbs+1Z3ICX2aXYcLIK/ZI+
         v8Sldio8Xl0xTg2cYSTXpxcFFBJiJfBiMXpSWSCCkVoT4HWGabLF+zgUQruP2+2oPeQV
         ZRzWNiU9nzDq64iIzoAW0xEKwDjSUbalGPDESAaR/35tAzVu7FdN0OhUUwf3vcHdg23M
         bOpg==
X-Gm-Message-State: ANoB5pnHcw8M2fyXwij5g0gXEwJGCdPDS8cTnYEmGnoEWHmaPdW0YrwD
        rO94cQdmeNWk33kKw+81A2vwgtju2KC/ZQ==
X-Google-Smtp-Source: AA0mqf6ZDF61aH1SrQOYNHBKCkhK2BhVTlXoSl7xs+taT/oVTvLROWHaL8EaDqGccp4ioe/Y/pQCTA==
X-Received: by 2002:a5d:4e06:0:b0:242:4f56:6b4b with SMTP id p6-20020a5d4e06000000b002424f566b4bmr16727316wrt.38.1671094347404;
        Thu, 15 Dec 2022 00:52:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r10-20020a0560001b8a00b0024274a5db0asm5464905wru.2.2022.12.15.00.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 00:52:26 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 03/12] t6060: add tests for removed files
Date:   Thu, 15 Dec 2022 09:52:07 +0100
Message-Id: <patch-v10-03.12-5edc8132329-20221215T084803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
In-Reply-To: <cover-v10-00.12-00000000000-20221215T084803Z-avarab@gmail.com>
References: <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com> <cover-v10-00.12-00000000000-20221215T084803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alban Gruin <alban.gruin@gmail.com>

Until now, t6060 did not not check git-merge-one-file's behaviour when a
file is deleted in a branch.  To avoid regressions on this during the
conversion from shell to C, this adds a new file, `file3', in the commit
tagged as `base', and deletes it in the commit tagged as `two'.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6060-merge-index.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t6060-merge-index.sh b/t/t6060-merge-index.sh
index 30513351c23..079151ee06d 100755
--- a/t/t6060-merge-index.sh
+++ b/t/t6060-merge-index.sh
@@ -8,12 +8,14 @@ TEST_PASSES_SANITIZE_LEAK=true
 test_expect_success 'setup diverging branches' '
 	test_write_lines 1 2 3 4 5 6 7 8 9 10 >file &&
 	cp file file2 &&
-	git add file file2 &&
+	cp file file3 &&
+	git add file file2 file3 &&
 	git commit -m base &&
 	git tag base &&
 	sed s/2/two/ <file >tmp &&
 	mv tmp file &&
 	cp file file2 &&
+	git rm file3 &&
 	git commit -a -m two &&
 	git tag two &&
 	git checkout -b other HEAD^ &&
@@ -41,6 +43,7 @@ test_expect_success 'read-tree does not resolve content merge' '
 	cat >expect <<-\EOF &&
 	file
 	file2
+	file3
 	EOF
 	git read-tree -i -m base ten two &&
 	git diff-files --name-only --diff-filter=U >unmerged &&
-- 
2.39.0.rc2.1048.g0e5493b8d5b

