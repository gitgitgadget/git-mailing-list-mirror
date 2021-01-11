Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E60C433E6
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 14:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 237F0225AC
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 14:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388876AbhAKOs2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 09:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728671AbhAKOs1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 09:48:27 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAA2C061795
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 06:47:47 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id t16so60083wra.3
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 06:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZFTTpAcBqlS2wKUsha2lN/7PG2/iCGQubI6G1K7YQ8g=;
        b=XSRfospinOZ1cBkgKlX4uJwzswg7q2IZXJVPtWcU+tC3nbaWVa6tE8AYUddRXxlBJI
         gaD8Ogyy+/ArMd0pstwzeSUMeopbXrdpUdCkXobuF96oGjHJruRUXbhGw8kn4DqAEWGs
         Toi+OpK4eHDudfkxoOInl+LunBendV9lhwTfc4EkPDE9SJhnC+mzNhTIo+A0pEHZ4fDN
         PBku5ECCk6w1IiJFj37yAdMOVWL5ueuFZQh9LHe59ETQg2jyd+xF/QxUvq5jw6Gqu2r+
         P3+FEYgOZI5+LntgljYUWTw1RQ9E5Ly/gSccemz2maAMfd14iDfq5Yt6G4rZIPGEJwd0
         J7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZFTTpAcBqlS2wKUsha2lN/7PG2/iCGQubI6G1K7YQ8g=;
        b=f9CiNJiig3nlFSGvRCQU8kHwb4dvAdQZkatTIemsHIvTppB45ktBjqLk/sU6V9w7C1
         O+282FXraS6nlXh03eyUeAUsrNHngaUZwlmlehSghsR2p7U/xTEr4Hq4j0MmSD6/35T4
         GipWU8zLsMa0W/jvcmtiAJvHUdX1kbo0sMHc/4wKJ8QRuMgYBpjm5F6nX0AcHkXD3KEh
         2fZQt5YcrPuZanwEp5Zv/tx30oCHcPcDnmembGt1rzUrALvOUfd9hBFJsx9Ha51xc8S5
         LjB8LERbQ/ZiCDvCICQEzB0y0OtDa8t+EpNJV17dRvuP2ai3LVIFXnJ8at6agSZwxonI
         Mg3w==
X-Gm-Message-State: AOAM532b9RCZ5ExemcXPwhdCRT9uiNQ9/JDuo/hKvR7kutZFljK0wIxQ
        3dHCTfbrIi7S5LEvdh7dwdtvXLfYeSVSyA==
X-Google-Smtp-Source: ABdhPJximWs8o/hZAG4lQO4hJq2L9vM2Uhcju1SHs27ygaR5coHehXBujdUo7M4n2Ec2EYyfVtiGKQ==
X-Received: by 2002:adf:b519:: with SMTP id a25mr16412971wrd.263.1610376465758;
        Mon, 11 Jan 2021 06:47:45 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m5sm26132697wrz.18.2021.01.11.06.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 06:47:44 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/6] Remove GIT_TEST_GETTEXT_POISON facility
Date:   Mon, 11 Jan 2021 15:47:34 +0100
Message-Id: <20210111144740.6092-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <87pn2b6eyb.fsf@evledraar.gmail.com>
References: <87pn2b6eyb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As argued upthread and in 2/6 this test setup has outrun its
usefulness.

This series begins to remove it in a way that's very careful about not
stepping on the toes of any other in-flight patches. In particular
"master" isn't anywhere in the diff context here to avoid conflicts
with the series to do that mass-replacement in t/. 

This series merges and tests cleanly in combination with the current
"seen" branch.

At the end we're left with a bunch of tests still using
test_i18n{cmp,grep}, but I think that's preferable to having in-flight
conflicts. It'll be trivial to search-replace those at some point in
the future where we don't have another search-replacement series
amending t/ in-flight.

Ævar Arnfjörð Bjarmason (6):
  ci: remove GETTEXT_POISON jobs
  tests: remove support for GIT_TEST_GETTEXT_POISON
  tests: remove misc use of test_i18n{cmp,grep}
  tests: (almost) remove use of "test_i18ngrep !"
  tests: (almost) remove C_LOCALE_OUTPUT prerequisites
  tests: remove uses of GIT_TEST_GETTEXT_POISON=false

 .github/workflows/main.yml                    |  2 +-
 .travis.yml                                   |  2 +-
 Documentation/MyFirstContribution.txt         |  2 +-
 ci/install-dependencies.sh                    |  2 +-
 ci/lib.sh                                     |  3 +-
 config.c                                      |  9 -----
 .../t/t9363-mw-to-git-export-import.sh        |  2 +-
 gettext.c                                     | 10 -----
 gettext.h                                     |  7 +---
 git-sh-i18n.sh                                | 22 +----------
 po/README                                     | 34 +++++++++-------
 t/README                                      |  6 ---
 t/lib-credential.sh                           |  2 +-
 t/lib-gettext.sh                              |  2 +-
 t/lib-httpd.sh                                |  2 +-
 t/lib-log-graph.sh                            |  4 +-
 t/lib-submodule-update.sh                     |  2 +-
 t/t0000-basic.sh                              |  2 +-
 t/t0017-env-helper.sh                         |  8 ++--
 t/t0020-crlf.sh                               |  6 +--
 t/t0041-usage.sh                              | 12 +++---
 t/t0201-gettext-fallbacks.sh                  |  2 +-
 t/t0205-gettext-poison.sh                     | 39 -------------------
 t/t1060-object-corruption.sh                  |  2 +-
 t/t1091-sparse-checkout-builtin.sh            | 10 ++---
 t/t1305-config-include.sh                     |  4 +-
 t/t1430-bad-ref-name.sh                       |  2 +-
 t/t1450-fsck.sh                               |  4 +-
 t/t1506-rev-parse-diagnosis.sh                |  2 +-
 t/t1512-rev-parse-disambiguation.sh           | 14 +++----
 t/t2019-checkout-ambiguous-ref.sh             |  4 +-
 t/t2020-checkout-detach.sh                    |  4 +-
 t/t2024-checkout-dwim.sh                      |  2 +-
 t/t3404-rebase-interactive.sh                 | 14 +++----
 t/t3415-rebase-autosquash.sh                  | 10 ++---
 t/t3418-rebase-continue.sh                    |  2 +-
 t/t3507-cherry-pick-conflict.sh               |  2 +-
 t/t3600-rm.sh                                 |  2 +-
 t/t3701-add-interactive.sh                    |  2 +-
 t/t4001-diff-rename.sh                        |  2 +-
 t/t4012-diff-binary.sh                        |  4 +-
 t/t4014-format-patch.sh                       |  2 +-
 t/t4018-diff-funcname.sh                      |  8 ++--
 t/t4153-am-resume-override-opts.sh            |  2 +-
 t/t4205-log-pretty-formats.sh                 |  2 +-
 t/t5300-pack-object.sh                        |  4 +-
 t/t5324-split-commit-graph.sh                 |  2 +-
 t/t5411/common-functions.sh                   |  5 +--
 t/t5411/test-0026-push-options.sh             |  3 +-
 t/t5411/test-0027-push-options--porcelain.sh  |  3 +-
 t/t5505-remote.sh                             |  8 ++--
 t/t5510-fetch.sh                              |  6 +--
 t/t5534-push-signed.sh                        |  2 +-
 t/t5541-http-push-smart.sh                    |  4 +-
 t/t5580-unc-paths.sh                          |  2 +-
 t/t5601-clone.sh                              |  2 +-
 t/t5606-clone-options.sh                      |  2 +-
 t/t6001-rev-list-graft.sh                     |  2 +-
 t/t6050-replace.sh                            |  2 +-
 t/t6423-merge-rename-directories.sh           | 14 +++----
 t/t6433-merge-toplevel.sh                     |  2 +-
 t/t6437-submodule-merge.sh                    |  2 +-
 t/t6500-gc.sh                                 |  2 +-
 t/t7201-co.sh                                 |  2 +-
 t/t7300-clean.sh                              |  6 +--
 t/t7400-submodule-basic.sh                    | 16 ++++----
 t/t7414-submodule-mistakes.sh                 |  6 +--
 t/t7415-submodule-names.sh                    |  2 +-
 t/t7416-submodule-dash-url.sh                 |  2 +-
 t/t7502-commit-porcelain.sh                   | 10 ++---
 t/t7508-status.sh                             |  8 ++--
 t/t7518-ident-corner-cases.sh                 |  2 +-
 t/t7519-status-fsmonitor.sh                   |  4 +-
 t/t7520-ignored-hook-warning.sh               |  6 +--
 t/t7601-merge-pull-config.sh                  | 34 ++++++++--------
 t/t7810-grep.sh                               |  4 +-
 t/t7816-grep-binary-pattern.sh                |  2 +-
 t/t9003-help-autocorrect.sh                   |  7 +---
 t/t9800-git-p4-basic.sh                       |  2 +-
 t/t9807-git-p4-submit.sh                      |  2 +-
 t/t9902-completion.sh                         |  1 -
 t/test-lib-functions.sh                       | 23 ++++-------
 t/test-lib.sh                                 | 23 ++---------
 83 files changed, 195 insertions(+), 316 deletions(-)
 delete mode 100755 t/t0205-gettext-poison.sh

-- 
2.29.2.222.g5d2a92d10f8

