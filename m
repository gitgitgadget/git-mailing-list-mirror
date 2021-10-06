Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8C2C433EF
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 09:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAD7F610FC
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 09:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237757AbhJFJwe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 05:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhJFJwd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 05:52:33 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FF3C061749
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 02:50:41 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g10so7693472edj.1
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 02:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MDJjE186pnOAGQ6RzlykOnzZI5Ad0FYbXMvl0xr7JS4=;
        b=Rd2eybcq91l4hqpTTAUesvAUnv5RWD5jtgk7p5Ef6445PLay1dg0jk2sidgCQaw/Tj
         RVShS0gJ8pF/YwoUh3uwJiwCmjXe7ShA5NTOVflQRtDYbeQ9UWzscD319j1G0CEeKRCR
         Bv/achq/RsROh53XGNSyHR7yOtomfaCZmFLOjGBDwdhP04rjgfACQDJStdjEdrF1qPl7
         aChsypHrnAaKqgsQwCB9wfsFl0MosWhY26r6+/nJ5ZPZ/u2n+VgjSXxeAa0p3kQFAY4C
         AN6lXAbQ4DjPZgfSKMP2tg/G84PPVVtduhuEGwTnoTbKoOOGlxlfh6XE4IHWGVW5hUI5
         wF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MDJjE186pnOAGQ6RzlykOnzZI5Ad0FYbXMvl0xr7JS4=;
        b=j73jbmG9b47vvBetcbdHp01ROMFV0QvxhyIJ0stCjtOS2O/vxsjetIut7fWld2ltBU
         sNiYXjfMWZ99eOHtEdRa7aFF6gO9XofRrqX7Ci0EkQI84FRAWg78+cXNyIPEzxn08WjT
         jRnHJw/xK8RSZuQldObt7REaskNjh/if1wGQVhcsnbub0rRkoIugt9NE9h0SF605D7qI
         4JoMLy3Dx0Cu1eDrI+Dud0ciGqKjXsYNS1/e40hhHWMK3NNmwewimNA1IEJTEjHnIiJj
         pZVCgC9mjB/vNqgvsBmHsfg0VNe0tQa0oEV6dTTRkZJDuQFACC8+K51Dig0t5ywHmZ8e
         p6/w==
X-Gm-Message-State: AOAM532wAPWC17Dh5oPCphZGa6fZkND7N37/+98wKlBXiouft5HI6DVl
        CXe99aJ7EhV7puA2HIjexAp0svTWUiIPEA==
X-Google-Smtp-Source: ABdhPJxk1PqFmXBJLLa/aexg9PlpvbppKKyJ8a4dxGtpb/6Eb7GfpasUk/b7L0XH7MMcrxnZ8c5CCQ==
X-Received: by 2002:aa7:d802:: with SMTP id v2mr29047530edq.271.1633513839209;
        Wed, 06 Oct 2021 02:50:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i2sm9886243edu.48.2021.10.06.02.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 02:50:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/10] leak tests: mark more tests as passing
Date:   Wed,  6 Oct 2021 11:50:27 +0200
Message-Id: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1441.gbbcdb4c3c66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This goes on top of ab/sanitize-leak-ci, in that topic I introduced a
"linux-leaks" job that runs in CI and checks that we don't have
SANITIZE=leak regressions, but it just marked one test file as passing
under that mode.

That was out of an abundance of caution, and to not conflate any
potential failures with the mode itself.

This series marks up a lot of tests as passing, ensuring that they
won't regress when it comes to memory leaks.

I did a "git rebase -i --exec" of each of these commits where I merged
with origin/seen, ran all tests under
GIT_TEST_PASSING_SANITIZE_LEAK=true. They all pass, so hopefully these
won't cause any disruption. I was careful to leave out any areas that
are actively being worked on (e.g. I had to eject a test in the
"sparse" area, since it would pass on master+ab/sanitize-leak-ci, but
has a regression in "seen". I didn't look into why).

Ævar Arnfjörð Bjarmason (10):
  leak tests: run various built-in tests in t00*.sh SANITIZE=leak
  leak tests: run various "test-tool" tests in t00*.sh SANITIZE=leak
  leak tests: mark t0000-init.sh as passing with SANITIZE=leak
  leak tests: mark all ls-tree tests as passing with SANITIZE=leak
  leak tests: mark all trace2 tests as passing with SANITIZE=leak
  leak tests: mark all checkout-index tests as passing with
    SANITIZE=leak
  leak tests: mark some ls-files tests as passing with SANITIZE=leak
  leak tests: mark some read-tree tests as passing with SANITIZE=leak
  leak tests: mark various "generic" tests as passing with SANITIZE=leak
  leak tests: mark some misc tests as passing with SANITIZE=leak

 t/t0001-init.sh                         | 1 +
 t/t0002-gitfile.sh                      | 1 +
 t/t0003-attributes.sh                   | 1 +
 t/t0005-signals.sh                      | 2 ++
 t/t0007-git-var.sh                      | 2 ++
 t/t0008-ignores.sh                      | 1 +
 t/t0010-racy-git.sh                     | 1 +
 t/t0013-sha1dc.sh                       | 2 ++
 t/t0022-crlf-rename.sh                  | 1 +
 t/t0024-crlf-archive.sh                 | 1 +
 t/t0025-crlf-renormalize.sh             | 1 +
 t/t0026-eol-config.sh                   | 1 +
 t/t0029-core-unsetenvvars.sh            | 1 +
 t/t0052-simple-ipc.sh                   | 1 +
 t/t0055-beyond-symlinks.sh              | 1 +
 t/t0061-run-command.sh                  | 1 +
 t/t0065-strcmp-offset.sh                | 1 +
 t/t0066-dir-iterator.sh                 | 1 +
 t/t0067-parse_pathspec_file.sh          | 1 +
 t/t0210-trace2-normal.sh                | 2 ++
 t/t0211-trace2-perf.sh                  | 2 ++
 t/t0212-trace2-event.sh                 | 2 ++
 t/t1000-read-tree-m-3way.sh             | 2 ++
 t/t1003-read-tree-prefix.sh             | 1 +
 t/t1009-read-tree-new-index.sh          | 1 +
 t/t1010-mktree.sh                       | 1 +
 t/t1012-read-tree-df.sh                 | 1 +
 t/t1014-read-tree-confusing.sh          | 2 ++
 t/t1100-commit-tree-options.sh          | 1 +
 t/t1430-bad-ref-name.sh                 | 1 +
 t/t1504-ceiling-dirs.sh                 | 2 ++
 t/t1510-repo-setup.sh                   | 1 +
 t/t2002-checkout-cache-u.sh             | 1 +
 t/t2003-checkout-cache-mkdir.sh         | 1 +
 t/t2004-checkout-cache-temp.sh          | 1 +
 t/t2005-checkout-index-symlinks.sh      | 1 +
 t/t2050-git-dir-relative.sh             | 1 +
 t/t2081-parallel-checkout-collisions.sh | 1 +
 t/t2300-cd-to-toplevel.sh               | 1 +
 t/t3000-ls-files-others.sh              | 2 ++
 t/t3002-ls-files-dashpath.sh            | 2 ++
 t/t3003-ls-files-exclude.sh             | 2 ++
 t/t3004-ls-files-basic.sh               | 1 +
 t/t3006-ls-files-long.sh                | 2 ++
 t/t3008-ls-files-lazy-init-name-hash.sh | 1 +
 t/t3070-wildmatch.sh                    | 1 +
 t/t3100-ls-tree-restrict.sh             | 2 ++
 t/t3101-ls-tree-dirname.sh              | 2 ++
 t/t3102-ls-tree-wildcards.sh            | 1 +
 t/t3103-ls-tree-misc.sh                 | 1 +
 t/t3205-branch-color.sh                 | 1 +
 t/t3211-peel-ref.sh                     | 1 +
 t/t3300-funny-names.sh                  | 1 +
 t/t3601-rm-pathspec-file.sh             | 1 +
 t/t3902-quoted.sh                       | 1 +
 t/t4002-diff-basic.sh                   | 2 ++
 t/t4016-diff-quote.sh                   | 1 +
 t/t4019-diff-wserror.sh                 | 1 +
 t/t4025-hunk-header.sh                  | 1 +
 t/t4026-color.sh                        | 2 ++
 t/t4300-merge-tree.sh                   | 2 ++
 t/t5580-unc-paths.sh                    | 1 +
 t/t5615-alternate-env.sh                | 2 ++
 t/t7518-ident-corner-cases.sh           | 2 ++
 t/t7812-grep-icase-non-ascii.sh         | 1 +
 t/t7813-grep-icase-iso.sh               | 1 +
 t/t7816-grep-binary-pattern.sh          | 1 +
 67 files changed, 87 insertions(+)

-- 
2.33.0.1441.gbbcdb4c3c66

