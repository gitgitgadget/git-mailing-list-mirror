Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072BCC433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 12:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386243AbiDUM4u (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 08:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386066AbiDUM4s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 08:56:48 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BBD33342
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 05:53:58 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id s25so1686177wrb.8
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 05:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=odsBtaVExLYsT2fPKURmsuncQ7MfgD+4ZDKpwOFX4/g=;
        b=HobhEkNjnV2ANDxPlcI61UuTC1RQo+Gfs7aEGLvG4OdaH76EBv1o71VZ4eVzdOFEZN
         b0JJdNVy2lBAVV/VGRDVJW6ms+MFrFBZMdo2klR63G30c84U5VVxb4jtjGM794ngapyx
         M05d3EZokZvbpJhFETojdaHVtr10tOu/sLDq1RBLxQTn1JLewTTeMb1PQzbj8GeayPVc
         Q/fqoZ5qzb9KkPmfbux3dzwYZ3Iy3N+pwbae8Yt3nEiIGC2jVlyE3ZpttGbVPMYc9VTR
         ecS5BXkJ1W+m5E4AroQ0JmsMv4/Zy67W3NXbKbBIHdNf/f4iFDx8eMrieNTIZ6D1VNpu
         SGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=odsBtaVExLYsT2fPKURmsuncQ7MfgD+4ZDKpwOFX4/g=;
        b=ZcUkPV85BmrUrWc6v50qlh2VGpyg27RobHhQC8pMhFjL0gY6Hg0J/T12RaADhAhPPt
         IS1Y2T80SNTgFOnKSfTDXr+/TdOTyBxN6iPZkbCo7U2OXepAx50kkeiQCDdyv+Xrx5+B
         Ur5x0IE0deS2tNnxsJwKhlGxIq6EmX9YOiRGO7Qko6j1EuDHXkvww5tg3p71F3o9SME6
         bVHBfFvzc2sE6MHbhFf7wkadr8tqGsjpS1JrEaIciRaJCdfOl22YZvp6nSj8LLkys+He
         OfpIBDZQC5daYJaJlIQDTalyCc9HlIPPysHwJljqFDyb9DrC3B63lbJuygTRC85HpsdG
         fy/Q==
X-Gm-Message-State: AOAM533Q95coTQ1ssQLF+WwosGA35Z3DgzPJ3ZuqEKMZ2E10n3gUPRMY
        NNuc7trVz7RPaIRqkh40+3M4nuFFqyCsRQ==
X-Google-Smtp-Source: ABdhPJyRVThHWSdsN5NXA+7nqKQeNNFP07/bA39inyI0SRSnWBT2sPXWAxdnKbBBO8oB6QdN1lfqew==
X-Received: by 2002:a05:6000:144a:b0:20a:a329:aa46 with SMTP id v10-20020a056000144a00b0020aa329aa46mr11474007wrx.36.1650545636783;
        Thu, 21 Apr 2022 05:53:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n68-20020a1c2747000000b0038e6b4d5395sm2163685wmn.16.2022.04.21.05.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 05:53:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] CI: don't fail OSX tests due to brew v.s. perforce.com mis-match
Date:   Thu, 21 Apr 2022 14:53:50 +0200
Message-Id: <cover-0.2-00000000000-20220421T124225Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.876.g4bfefc07680
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio: Despite modifying CI stuff this series merges cleanly with
"seen", and has no semantic conflicts with any outstanding CI changes.

For the past days we've again had CI failures due to "brew install"
detecting a SHA-256 mismatch when trying to install the perforce
package[1]. E.g. "seen" is now failing: https://github.com/git/git/runs/6104156856?check_suite_focus=true

This occurrence of this issue will no doubt be fixed within a few days
as the homebrew-cask repository is updated, i.e. this recipe:
https://github.com/Homebrew/homebrew-cask/commits/master/Casks/perforce.rb

But for our CI usage being this anal about the check isn't worth it,
here's a passing CI run where we simply forced the installation:
https://github.com/avar/git/runs/6092916675?check_suite_focus=true#step:3:87
and subsequently passed the git-p4 tests:
https://github.com/avar/git/runs/6092916675?check_suite_focus=true#step:4:1678

Ævar Arnfjörð Bjarmason (2):
  CI: run "brew install perforce" without past workarounds
  CI: don't care about SHA256 mismatch on upstream "perforce" package

 ci/install-dependencies.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

-- 
2.36.0.893.g80a51c675f6

