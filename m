Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18B4C4708D
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 00:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiLHAdW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 19:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiLHAdR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 19:33:17 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89758D672
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 16:33:10 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id n21so184096ejb.9
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 16:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWSsKWWmm6IxvO2hTVmM0Nocb+nKcavBMcaqwZJ7xOs=;
        b=Jcuhu2P8yOCE0llSRFuY9Zr3NglUZyA2fjC6DFSQ9jWqwFsW0KZge8C1eF6IMcEkOz
         iiQnup+tI9DA8Y/mShdwlEJgRPTNud69JLpH8ISZrPkqGLdVPRiNZSuA+0pC1eIDc2qv
         /s34PXWsrynQWL1LUSqQV0vUyUw/KtisNMRg9Td56VWlSL7vzsHixV3xBcWpSc5xX5fy
         IOiHZiugaZc0twtwDfHjw0e6nIC9ngGQsxv5MXi2gLxopr/3MppMAK2g2QxSrjavBaEF
         1LgvYShIdt+q4o2xPtgYpYm/5ACrMENyMzbb+tk+tdCHrfzX10Ihj+/RUSkYXBzCMD0Y
         k6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWSsKWWmm6IxvO2hTVmM0Nocb+nKcavBMcaqwZJ7xOs=;
        b=lYQCcm9Kl61jUqpKkGRR9Oo3Td4NDaXUaDDJKSsQgZfUuF3I7xUC//8WPEskAMsVeT
         FnEY4vi0zq7KTKZFgLIC30kb5K3SULwJmqX3FOsW2j0ZMrVFjW4g08wQr9mlNb14b6fa
         w33x6d8V8qZrTD7RJZ++7r2XVyTHBZD+2orklfjSpqou328PiOqNSzXOtcBsdDGa6dok
         wp+FXR4j7XF56snr/EB6DymtLpUKDwkws4SZVsJ1sDIfkc+vqUIl1Hq8P9Kpq0XzVXcl
         xD+GoHvc/8gSQpPZoPWcBOF9eWkxlDNwzeyDFngkA644lyGPM2IutZ0aJoDViMCMGRRX
         6/0A==
X-Gm-Message-State: ANoB5pltY1N9FaPRnmGyWLhyM14zg8DPwSdB9dPkWuhFV8miZGXKqeeW
        huzUizwyyxDkYqOBrlFBaRp38vlMefFUag==
X-Google-Smtp-Source: AA0mqf6gVynUNNc87obl2W6iVYlABL4l8ABeW0VRKnVFbsC/Uv3+O0FU607wq+z5CVy3KPSpqVIWng==
X-Received: by 2002:a17:906:2552:b0:7ae:5e5f:58b1 with SMTP id j18-20020a170906255200b007ae5e5f58b1mr868695ejb.53.1670459589237;
        Wed, 07 Dec 2022 16:33:09 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a170906768300b007c099174a12sm9263565ejm.178.2022.12.07.16.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 16:33:08 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3] CI: migrate away from deprecated "set-output" syntax
Date:   Thu,  8 Dec 2022 01:33:06 +0100
Message-Id: <patch-v3-1.1-0519cc1105a-20221208T003233Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1019.gce04d262ea9
In-Reply-To: <patch-v2-1.1-4e7db0db3be-20221207T014848Z-avarab@gmail.com>
References: <patch-v2-1.1-4e7db0db3be-20221207T014848Z-avarab@gmail.com>
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
Range-diff against v2:
1:  4e7db0db3be ! 1:  0519cc1105a CI: migrate away from deprecated "set-output" syntax
    @@ .github/workflows/l10n.yml: jobs:
                fi
     -          echo "::set-output name=base::$base"
     -          echo "::set-output name=head::$head"
    -+          cat >>$GITHUB_OUTPUT <<-EOF
    -+          base=$base
    -+          head=$head
    -+          EOF
    ++          echo "base=$base" >>$GITHUB_OUTPUT
    ++          echo "head=$head" >>$GITHUB_OUTPUT
            - name: Run partial clone
              run: |
                git -c init.defaultBranch=master init --bare .

 .github/workflows/l10n.yml | 4 ++--
 .github/workflows/main.yml | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/l10n.yml b/.github/workflows/l10n.yml
index 27f72f0ff34..2915c595b4f 100644
--- a/.github/workflows/l10n.yml
+++ b/.github/workflows/l10n.yml
@@ -23,8 +23,8 @@ jobs:
             base=${{ github.event.before }}
             head=${{ github.event.after }}
           fi
-          echo "::set-output name=base::$base"
-          echo "::set-output name=head::$head"
+          echo "base=$base" >>$GITHUB_OUTPUT
+          echo "head=$head" >>$GITHUB_OUTPUT
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

