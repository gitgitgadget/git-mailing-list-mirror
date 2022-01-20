Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197C0C433EF
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 18:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243589AbiATSzy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 13:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbiATSzy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 13:55:54 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6550C061574
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 10:55:53 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id v8-20020a17090a778800b001b2e6d08cd1so4606118pjk.8
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 10:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eUi5TexFzT6VVGNG0h875KAX9p4hL6z7Evcn3/Zqzfg=;
        b=RCj5VY+z2CGTXKjZPo2SKzzGXiamLTVRwR/OW4UUDzVpQOkEINZMmtsUtGmT023DJa
         ftMAR7QxWP0IXMh5cz+H00XhZ6jpoSYQbP26kIlXfi3vLucnTbVDJZ+E5H0Apf3RnT4z
         CE2NvLV8TtYZPOHQM2lLbLHgofgVd55sB0TCyQ2dhhQA11zEcRjBkEeEdBZX8zSLFRNJ
         T04xix/qpv6qgkzxtiOeX5Rthy3vxSwVr2r0K87XTJMvC+pcToko+gnGIzZnpYAEoRE/
         863Ti5h/ypDXWcmu0OtAd+XUuidwFjCV85ZiGKrMn4/RPBOEYwZjwxoOiEuisO/nYuDH
         O3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eUi5TexFzT6VVGNG0h875KAX9p4hL6z7Evcn3/Zqzfg=;
        b=W6IYc/gHVt71vE08//v5UQ7ZWyckS8MAi2qHlkXFtkfizQ33mFTkmD/vjkQ1aMNllX
         Iep0aCtZ9CGnNV9UNe/UBy22T0flnFDF1arKRD+unTA7O2zSINY56hXN5udKbnU2K2Xq
         8ncateyZ3hMkgZ9sf8Y161c6ByDZ3hzNOnV8jG9ITwP3hBAZXwM2FGEIos4v//cDedAM
         9oiMDGD0khprjLCW3EH6aIoVuM+caM6mXB7wCxno3P/Qt4of7xLjj2xdQtOIfdbbEn5m
         BEhTAc6HXJnPc9psQ839BFoJ29SZ9Q/z2QMEnc8aH0FqyzYFoYJbDT+dG2lNeWfS9zHC
         DsgA==
X-Gm-Message-State: AOAM531NjTEGjyKnj8OCPlw/rEiUOIKo6TJYR6j+xL0fcBYR0X+u52Fy
        QGL77v/FvrBXPUvlVnoV4iBPUvGioXFx1xC2U07F/IGK2ojBuAycurL4eOadYaIeKUN6ua508HR
        fAJ2I3AXa4WTXcyCI90OmjjTRYaB++/RX2WhZXoLUowaTwRMbVtViqHp7q9oMCeeoC40+lSrI1V
        VJ
X-Google-Smtp-Source: ABdhPJy1ftXGaC+SY/cFPVrNlu+7PAstQOMdAI1sXspAT4FGdfoKJZZKuLbZ8j4zsPIjHOs+qRga1U0rDjiH9Ohc7MAx
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:87c6:0:b0:4c5:5f18:ea6f with
 SMTP id i6-20020aa787c6000000b004c55f18ea6fmr342250pfo.24.1642704953235; Thu,
 20 Jan 2022 10:55:53 -0800 (PST)
Date:   Thu, 20 Jan 2022 10:55:48 -0800
Message-Id: <20220120185548.3648549-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH] sparse-checkout: create leading directory
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        stolee@gmail.com, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When creating the sparse-checkout file, Git does not create the leading
directory, "$GIT_DIR/info", if it does not exist. This causes problems
if the repository does not have that directory. Therefore, ensure that
the leading directory is created.

This is the only "open" in builtin/sparse-checkout.c that does not have
a leading directory check. (The other one in write_patterns_and_update()
does.)

Note that the test needs to explicitly specify a template when running
"git init" because the default template used in the tests has the
"info/" directory included.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
This problem is being discussed in [1], and we also noticed this problem
internally at $DAYJOB. Here's a fix.

[1] https://lore.kernel.org/git/db6f47a3-0df3-505b-b391-6ca289fd61b5@gmail.com/
---
 builtin/sparse-checkout.c          | 3 +++
 t/t1091-sparse-checkout-builtin.sh | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 679c107036..2b0e1db2d2 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -471,6 +471,9 @@ static int sparse_checkout_init(int argc, const char **argv)
 		FILE *fp;
 
 		/* assume we are in a fresh repo, but update the sparse-checkout file */
+		if (safe_create_leading_directories(sparse_filename))
+			die(_("unable to create leading directories of %s"),
+			    sparse_filename);
 		fp = xfopen(sparse_filename, "w");
 		if (!fp)
 			die(_("failed to open '%s'"), sparse_filename);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 42776984fe..dba0737599 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -79,6 +79,13 @@ test_expect_success 'git sparse-checkout init' '
 	check_files repo a
 '
 
+test_expect_success 'git sparse-checkout init in empty repo' '
+	test_when_finished rm -rf empty-repo blank-template &&
+	mkdir blank-template &&
+	git init --template=blank-template empty-repo &&
+	git -C empty-repo sparse-checkout init
+'
+
 test_expect_success 'git sparse-checkout list after init' '
 	git -C repo sparse-checkout list >actual &&
 	cat >expect <<-\EOF &&
-- 
2.34.1.703.g22d0c6ccf7-goog

