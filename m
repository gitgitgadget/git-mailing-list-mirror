Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0558DC4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 15:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiJNPkc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 11:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiJNPk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 11:40:29 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DB1B517B
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:40:28 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bv10so8163514wrb.4
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+6vZTdjEbNADDSXEtMHRR2EklfWVXq/O2Qp7fVfPg6s=;
        b=NtLopwavFrqOXZ2JKVXA/3Ehf38Al01cZrJG57PWt5titrrHJh9D4m+d90o2lhlCK3
         AZiPO+EnWpZ82LjQatpqO+lF8VqoQ+IuY17eossVlOceYL35ERRlAFIxL7kO7CaHbL9C
         oX1UI6fDMLd06JTo6Q33z9s4Prq3GGCHuz7PJU7AhRwt7sK93Nwd5YFY+5HmuD9SF9ie
         k/ZncwxytzEcuvAEv6zmiF3pAiR/IYCXIoZtE3dRTIhjQHOIwkAEurbVrmajB0fNl5FS
         I2CuNW4z0z89sa9O1dpe77Fp2mUapcjorb63jjN54naZKYZ60d68fYyFYW4uep0Iw0Ym
         drbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+6vZTdjEbNADDSXEtMHRR2EklfWVXq/O2Qp7fVfPg6s=;
        b=cb+OCWW8l9KkpbNClAPlhnaPc1bSl1fZSlInJFuzhervYM3/nQcIa9Uyk/Flia2iva
         uJM9mYystcOc5cOgup+xq3VK7Pi1NQI2P/czEEPjhFVvPT9Uixv+tP24FqGvzrbVfb3G
         SosDLHlK6ApfZoOBqxDTvNuqW9Hfg5mtKCEq1WWLUqqbWerAz9vs0IwkcKyj1Rk3T0M9
         JZteGSycWM+IxONGnfE8SekqHncN+DrO4vwqre5JMpI+reECpUvEBYipCp/qc9KjFMDO
         fAxjz54yR3trlwhATPDgVF4gzxAzM0kV1eXioQtf/7fPknfaQjHM0z87v61MN4tvxBJp
         wctw==
X-Gm-Message-State: ACrzQf0kxsngCiZSYsHx6lHe5PjHV/nd9UT3XYIwbrfZX7Ht5DwRNadv
        Op3YfznqaJipIRi+JI8akOQDRi6m5yan4A==
X-Google-Smtp-Source: AMsMyM5Hje8GYB5407MbbdjHHYNi23fBHam2tQkOF2cBOvZFD7hwfjmONZJOZog4YPrFufMP+MxAXg==
X-Received: by 2002:a05:6000:144d:b0:231:51d2:e67a with SMTP id v13-20020a056000144d00b0023151d2e67amr4023403wrx.294.1665762026179;
        Fri, 14 Oct 2022 08:40:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 123-20020a1c1981000000b003c6c4639ac6sm2385391wmz.34.2022.10.14.08.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 08:40:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/10] run-command API: add run_command_{l,sv}_opt()
Date:   Fri, 14 Oct 2022 17:40:12 +0200
Message-Id: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1092.g8c0298861b0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series starts out by addressing the issue Jeff King noted in
https://lore.kernel.org/git/Y0TXTl0gSBOFQa9B@coredump.intra.peff.net/;
I.e. that by moving away from a "struct strvec" for run_command()
variants we lose out on the "warn_unused_result" checking we'd get
with the strvec_pushl() (ensuring the last element is NULL).

The 3/10 here adds a run_command_l_opt() function, which provides an
easy & safe one-shot API using warn_unused_result.

The 10/10 here then adds a run_command_sv_opt(), which is a
run_command_v_opt() taking a "struct strvec" that the API clears for
the user after it's called. This makes a lot of one-shot "run this and
free the strvec" users less verbose.

Then, having converted to these helpers we had 1-2 users of other
run_command_*() variants, which could be moved to using run_command()
directly, and thus getting rid of supporting so much shorthand API
variation.

At the end of this series the in-tree use of the 3x helpers is (by
number of *.c file occurances):

     19 run_command_l_opt
     15 run_command_v_opt
     12 run_command_sv_opt

More can be converted to run_command_{l,sv}_opt(), but I left out
e.g. bisect--helper.c to avoid conflicts with anything in-flight.

Ævar Arnfjörð Bjarmason (10):
  run-command.c: refactor run_command_*_tr2() to internal helpers
  merge: remove always-the-same "verbose" arguments
  run-command API: add and use a run_command_l_opt()
  am: use run_command_l_opt() for show_patch()
  run-command API docs: clarify & fleshen out run_command_v_opt*() docs
  run-command API: remove RUN_COMMAND_STDOUT_TO_STDERR flag
  run-command API & diff.c: remove run_command_v_opt_cd_env()
  run-command API & users: remove run_command_v_opt_tr2()
  gc: use strvec_pushf(), avoid redundant strbuf_detach()
  run-command API: add and use a run_command_sv_opt()

 add-interactive.c        |  3 +-
 bisect.c                 | 19 +++++------
 builtin/add.c            |  6 ++--
 builtin/am.c             | 14 +++-----
 builtin/clone.c          | 19 ++++-------
 builtin/difftool.c       | 14 ++++----
 builtin/gc.c             | 49 +++++++++-----------------
 builtin/merge.c          | 46 ++++++-------------------
 builtin/pull.c           | 15 ++------
 builtin/remote.c         | 15 +++-----
 compat/mingw.c           |  8 ++---
 diff.c                   | 26 +++++++-------
 fsmonitor-ipc.c          | 10 ++++--
 git.c                    | 15 ++++----
 ll-merge.c               |  4 +--
 merge.c                  |  3 +-
 run-command.c            | 43 ++++++++++++-----------
 run-command.h            | 74 +++++++++++++++++++++++++++-------------
 scalar.c                 |  6 +---
 sequencer.c              | 15 ++------
 t/helper/test-fake-ssh.c |  4 +--
 tmp-objdir.h             |  6 ++--
 22 files changed, 177 insertions(+), 237 deletions(-)

-- 
2.38.0.1092.g8c0298861b0

