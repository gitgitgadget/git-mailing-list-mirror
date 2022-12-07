Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D4BC3A5A7
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 01:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiLGBtb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 20:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiLGBt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 20:49:29 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B2252891
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 17:49:28 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id a16so22884788edb.9
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 17:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJlyw7/2tRtVBWt5MPpioiYLtMykVDrNty5EFizifQw=;
        b=jQYO3siJVImqbqR7y7NEij8uiTNZ2P+Aj4jfS1Nn/vZ1L5S4zumfAfvne7ETqBvg0+
         ghNBbQqe0lRSgqlv0duKogqrFguv4h8IzBDdLMn4rJRk4ZaKFFKHipR5pYgtUnHUCKgZ
         PaTdQm0K3z+PS2AwzZX9j5TwPUJPCAIyfpHsLUBfwBRJSwvRmmFD+vWbklj+Jy+eUdZN
         sX6aBTLOnN5aZrKJ29pvFVIpOYwzNJvlzIAsgw7SaW+6WtkrOprEIVlFdSGq2uf2kHLZ
         HwL2MxyUSlveso2oTT0JRM+Jx3NvkCslJxKMOg3RsQnYpucqso6yj2g1J3o70nEL1kzN
         46eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJlyw7/2tRtVBWt5MPpioiYLtMykVDrNty5EFizifQw=;
        b=OZQbI1dKl2R3vfGCswmwC50czBjUaSTHDRKSQQQDZWT+gb8mfveQ8O7cFkwXT14CT8
         SqVsiOW9NT9DWCJJpSoy11Avb+9H4+l6QwwpWUfNAmOiaDjUwiSKnn77dDxpf4oxDFFn
         nyOKnbRdN4UyYUHKZnOjTiuP0cKeWvH+pgW/A1WsXrGJhuVbcgKvuwx4U+3VuTg3IfSf
         BwMzPOkSG+5FdDNXIjW/YRpVYYQhZrlbS345OVofKvPgyLIXCxVTcaeIZ+ZkdnAt+esJ
         3lvERK3iJMnFekhDlYR3Btgnw/RA6QLCVvHyMHzXIAAtcmnV+/dOE4C6vTw6bZJE3mRt
         wmng==
X-Gm-Message-State: ANoB5pnOZuk+N5wcLHzQRXgSj+okpCZANGmTTvq3FPn8T0tuQJTnQXr4
        ICHV0VE5VAZAlFqUi4/MxNSE5hvDzUbdKQ==
X-Google-Smtp-Source: AA0mqf4zZLYM/iRvsN+k8XvQxATb8oe4HoNQabJEa2FGE2N8vmUcWLAy2lWAspqnP2mr1j2OiU0qoA==
X-Received: by 2002:a05:6402:541a:b0:463:be84:5283 with SMTP id ev26-20020a056402541a00b00463be845283mr37923121edb.7.1670377766227;
        Tue, 06 Dec 2022 17:49:26 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j10-20020a17090623ea00b00782ee6b34f2sm7888311ejg.183.2022.12.06.17.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 17:49:25 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] CI: migrate away from deprecated "set-output" syntax
Date:   Wed,  7 Dec 2022 02:49:18 +0100
Message-Id: <patch-v2-1.1-4e7db0db3be-20221207T014848Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1019.gce04d262ea9
In-Reply-To: <patch-1.1-deb65805345-20221206T195811Z-avarab@gmail.com>
References: <patch-1.1-deb65805345-20221206T195811Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in [1] and the warnings the CI itself is spewing echoing
outputs to stdout is deprecated, and they should be written to
"$GITHUB_OUTPUT" instead.

1. https://github.blog/changelog/2022-10-11-github-actions-deprecating-save-state-and-set-output-commands/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
Range-diff against v1:
1:  deb65805345 ! 1:  4e7db0db3be CI: migrate away from deprecated "set-output" syntax
    @@ Commit message
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    + ## .github/workflows/l10n.yml ##
    +@@ .github/workflows/l10n.yml: jobs:
    +             base=${{ github.event.before }}
    +             head=${{ github.event.after }}
    +           fi
    +-          echo "::set-output name=base::$base"
    +-          echo "::set-output name=head::$head"
    ++          cat >>$GITHUB_OUTPUT <<-EOF
    ++          base=$base
    ++          head=$head
    ++          EOF
    +       - name: Run partial clone
    +         run: |
    +           git -c init.defaultBranch=master init --bare .
    +
      ## .github/workflows/main.yml ##
     @@ .github/workflows/main.yml: jobs:
                then

 .github/workflows/l10n.yml | 6 ++++--
 .github/workflows/main.yml | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/l10n.yml b/.github/workflows/l10n.yml
index 27f72f0ff34..8fa073db2dc 100644
--- a/.github/workflows/l10n.yml
+++ b/.github/workflows/l10n.yml
@@ -23,8 +23,10 @@ jobs:
             base=${{ github.event.before }}
             head=${{ github.event.after }}
           fi
-          echo "::set-output name=base::$base"
-          echo "::set-output name=head::$head"
+          cat >>$GITHUB_OUTPUT <<-EOF
+          base=$base
+          head=$head
+          EOF
       - name: Run partial clone
         run: |
           git -c init.defaultBranch=master init --bare .
diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 9afacfa0b33..d1e16009b11 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -34,7 +34,7 @@ jobs:
           then
             enabled=no
           fi
-          echo "::set-output name=enabled::$enabled"
+          echo "enabled=$enabled" >>$GITHUB_OUTPUT
       - name: skip if the commit or tree was already tested
         id: skip-if-redundant
         uses: actions/github-script@v6
-- 
2.39.0.rc2.1019.gce04d262ea9

