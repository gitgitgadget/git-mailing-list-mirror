Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA1E8207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 21:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428461AbdDXVNH (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 17:13:07 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37251 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1174060AbdDXVNB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 17:13:01 -0400
Received: by mail-wm0-f51.google.com with SMTP id m123so79509855wma.0
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 14:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RRfjyrD/WrU5wfWcWlZbawRpLDKtPkBmwsg0EGznXpc=;
        b=EsDRmFKjymzsvc7PlanUc6kjL8nlCdWYEsT7eGVjC3hO99UpVaWZ8aXfuZ3R9U+osM
         f/BkJFwSUD+rGW52PJ+u9IoMPMJLB8SVwZczWuK4gZMVrWuBPkkyoVJI+0wXcgA+5e/D
         59YW717Pmmeenpw1gCDsC6tE2YzPruQXCrM/GHMgiTljTMeVvUZANSeXAOmY2Cu+qSgH
         wvyWSr0v3gbzGe8XrpFowTSMogGEBSoDnJ2M1VfqBZ8l1zO+Ac9lWhrOwBI1AtzZjVpV
         MkkZl260Pp6os/Wu8OI2+p4k7SO2uuw2J4QNoHRrdTv6scZ74klk7xojhfxjmCTBVtdx
         enIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RRfjyrD/WrU5wfWcWlZbawRpLDKtPkBmwsg0EGznXpc=;
        b=CkWBRPpK54MTYllIQXk/2CEMd7ACmZL1sVanEV03zzbyOID5ym1std+sCKE5I3a7cl
         ssVPRtpEGiYe5JtCRbqS0V1NiqN0qjJ6vldvlh2+cUZcPlz5Jphceh0yuWEEQ22qaP+V
         3f2dvzWQP8SvfPoBZLzILo18AT8FJ5x2QwfCyD9lliORA1P1+yJnZG/TsWJUchm5hleV
         qROrPRccUs0uG0YqmFYiIUaQiLq3oOI2G2DiFBUETJ5yChA2P9hb1/hM+3/aLjz/acll
         E27ViJX+Z9jhGoNAlCc8GHgqaC3HqJlKOwyR4BquKTP+ZrOQqlhlPinnt4aFfJaWKqPs
         hSmQ==
X-Gm-Message-State: AN3rC/4fYaIgXs1kPO9YRQcgaIDmVKrgiVoJYlsTggQCFSDDehhDx3VT
        kXIDRdbt+IFZIg==
X-Received: by 10.28.24.71 with SMTP id 68mr10897390wmy.64.1493068379516;
        Mon, 24 Apr 2017 14:12:59 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id p107sm12911027wrb.64.2017.04.24.14.12.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Apr 2017 14:12:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] perf: show that wildmatch() regressed for pathological cases in v2.0
Date:   Mon, 24 Apr 2017 21:12:47 +0000
Message-Id: <20170424211249.28553-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Russ Cox just published an article about how various glob()
implementations suffer from pathological performance when fed certain
pathological patterns like "a*a*a*a*b" given a file like "aaaaaaa...":
https://research.swtch.com/glob

I was curious to see if this impacted git. It turns out it does. This
used to be a per-platform issue with git, since globbing was
implemented via fnmatch() by default before v1.8.4, and support for
using the OS fnmatch() was removed entirely in v2.0.0.

This performance test shows the regression:

    $ GIT_PERF_REPEAT_COUNT=1 GIT_PERF_MAKE_OPTS="[...]NO_WILDMATCH=YesPlease[...]" ./run v1.9.5 v2.0.0 v2.12.0 p0100-globbing.sh
    [...]
    Test                                                       v1.9.5            v2.0.0                    v2.12.0
    ------------------------------------------------------------------------------------------------------------------------------
    [...]
    0100.7: fileglob((a*)^nb) against file (a^100).t; n = 1    0.01(0.00+0.00)   0.00(0.00+0.00) -100.0%   0.01(0.00+0.00) +0.0%
    0100.8: fileglob((a*)^nb) against file (a^100).t; n = 2    0.01(0.00+0.00)   0.00(0.00+0.00) -100.0%   0.01(0.00+0.00) +0.0%
    0100.9: fileglob((a*)^nb) against file (a^100).t; n = 3    0.00(0.00+0.00)   0.00(0.00+0.00) =         0.01(0.00+0.00) +inf
    0100.10: fileglob((a*)^nb) against file (a^100).t; n = 4   0.00(0.00+0.00)   0.01(0.01+0.00) +inf      0.02(0.02+0.00) +inf
    0100.11: fileglob((a*)^nb) against file (a^100).t; n = 5   0.00(0.00+0.00)   0.20(0.19+0.00) +inf      0.24(0.23+0.00) +inf
    0100.12: fileglob((a*)^nb) against file (a^100).t; n = 6   0.00(0.00+0.00)   3.03(3.00+0.00) +inf      3.08(3.05+0.00) +inf

And here's a one-liner to do the same:

    $ time (rm -rf test; git init -q test && (cd test && touch $(perl -e 'print "a" x 100').t && git add a* && git commit -q -m"test" && git ls-files 'a*a*a*a*a*a*a*b'))

Add or remove "a*"'s to adjust the runtime. With 6 that executes in 3
seconds on my system, 40 seconds with 7 etc.

I don't think this is something we need to worry much about, if you
have a file like this and feed Git insane patterns you probably
deserve what you get.

The real concern is if we have behavior like this and ever e.g. expose
globbing over the network, e.g. in some future upload-pack protocol.

There are probably some web-based programs built on top of git that
are vulnerable to DoS attacks as a result of this, e.g. if they take
user-supplied globs and feed them to ls-files.

Ævar Arnfjörð Bjarmason (2):
  perf: add function to setup a fresh test repo
  perf: add test showing exponential growth in path globbing

 t/perf/README            |  1 +
 t/perf/p0100-globbing.sh | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 t/perf/perf-lib.sh       | 17 +++++++++++++----
 3 files changed, 62 insertions(+), 4 deletions(-)
 create mode 100755 t/perf/p0100-globbing.sh

-- 
2.11.0

