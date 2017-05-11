Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27C741FF34
	for <e@80x24.org>; Thu, 11 May 2017 07:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755129AbdEKHoq (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 03:44:46 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34346 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754785AbdEKHop (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 03:44:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id d127so4943180wmf.1
        for <git@vger.kernel.org>; Thu, 11 May 2017 00:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hoOa748kBgDzW+Ho9MX9gwEXR+ciS/s7TFMK/+1K4Xg=;
        b=qKNB3eXwTk5cH2b0NUAWeQIJRjRfKRUk1/B+1oP8sXzVOcpaUIjXp78WbYU2+YOSsW
         uTmQ9yH7prDqgIFkVrIP+12PBY6pC1mez/YUVFhTPUxVLrVv2pcn2PSFwLz9oPNoRu7/
         3hnpdxHKZwHlKiWYS3PTPcFwEvFFb0+hVNsYobg8HvWipVfYkbSlgGiAvSxIjkCtlQ+7
         BRpfLVaL9zD54I3DhAJIL5yuF+rV4waHsP58b72l8Qpbkgrq05hu3A5OX/pPgIz3rBLD
         dvt1aq7OzfR2D6iIP5cCOShKrj9yXe257BFCsT2TT6T+Skb4D2iDFxqt6SkuN5r2JjNP
         65Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hoOa748kBgDzW+Ho9MX9gwEXR+ciS/s7TFMK/+1K4Xg=;
        b=m8QyosnOCOqvO+oXbYY4DguHhhk7xiXLRFwPQPDC8XFb0K/71GsSVC4DjoV8IOzrP1
         eaWW+4elRgcse0+6fVnPXyiPjZQTov3FUy/L9oupkT4fYFLhrMCZW7/GTqfIKZKbwSHv
         tPuwzXIgkrlSnewLOV/kwPvB4GwXkPrjjaiy5Yi9+P/jDbOBmQrorEFOorimox05hEIz
         Gw+66Q32AAbStXCOdaIAL/1hzjFmUK0GEEkswo+jGn/tmF5IeSrG69meGAHCLHQ863WN
         InKAmw73Kvwi/zTWsC9UmWiT4M4aZSAg2JEeDAF7mu1P+ELMzZFjQd0Umsi+cvqu6TuR
         DFwA==
X-Gm-Message-State: AODbwcA4W2bPBMqDsBLyt97BuewpbCjiAo+nZr0VL1/S0W/G4TyXjeKD
        2S8hyohhmxqUgg==
X-Received: by 10.80.145.198 with SMTP id h6mr7407776eda.108.1494488659732;
        Thu, 11 May 2017 00:44:19 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id c35sm325071eda.55.2017.05.11.00.44.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 00:44:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/2] perf: show that wildmatch() regressed for pathological cases in v2.0
Date:   Thu, 11 May 2017 07:43:52 +0000
Message-Id: <20170511074354.11336-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fixes the issues noted in v3, see
<20170510225316.31680-1-avarab@gmail.com>
(https://public-inbox.org/git/20170510225316.31680-1-avarab@gmail.com/).

In addition I was wrong about for-each-ref not being subjected to this
slowdown, I was just screwing up the testcase. Fix that. Now:

    $ GIT_PERF_REPEAT_COUNT=1 GIT_PERF_MAKE_OPTS="-j6 NO_OPENSSL=Y NO_WILDMATCH=YesPlease" ./run v1.9.5 v2.12.0 p0100-globbing.sh
    Test                                                       v1.9.5            v2.12.0
    -------------------------------------------------------------------------------------------------
    0100.2: refglob((a*)^nb) against tag (a^100).t; n = 1      0.00(0.00+0.00)   0.00(0.00+0.00) =
    0100.3: refglob((a*)^nb) against tag (a^100).t; n = 2      0.00(0.00+0.00)   0.00(0.00+0.00) =
    0100.4: refglob((a*)^nb) against tag (a^100).t; n = 3      0.00(0.00+0.00)   0.00(0.00+0.00) =
    0100.5: refglob((a*)^nb) against tag (a^100).t; n = 4      0.00(0.00+0.00)   0.01(0.00+0.00) +inf
    0100.6: refglob((a*)^nb) against tag (a^100).t; n = 5      0.00(0.00+0.00)   0.16(0.15+0.00) +inf
    0100.7: refglob((a*)^nb) against tag (a^100).t; n = 6      0.00(0.00+0.00)   2.73(2.71+0.00) +inf
    0100.8: fileglob((a*)^nb) against file (a^100).t; n = 1    0.00(0.00+0.00)   0.00(0.00+0.00) =
    0100.9: fileglob((a*)^nb) against file (a^100).t; n = 2    0.00(0.00+0.00)   0.00(0.00+0.00) =
    0100.10: fileglob((a*)^nb) against file (a^100).t; n = 3   0.00(0.00+0.00)   0.00(0.00+0.00) =
    0100.11: fileglob((a*)^nb) against file (a^100).t; n = 4   0.00(0.00+0.00)   0.01(0.00+0.00) +inf
    0100.12: fileglob((a*)^nb) against file (a^100).t; n = 5   0.00(0.00+0.00)   0.16(0.15+0.00) +inf
    0100.13: fileglob((a*)^nb) against file (a^100).t; n = 6   0.00(0.00+0.00)   2.75(2.73+0.00) +inf

Ævar Arnfjörð Bjarmason (2):
  perf: add function to setup a fresh test repo
  perf: add test showing exponential growth in path globbing

 t/perf/README            |  1 +
 t/perf/p0100-globbing.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
 t/perf/perf-lib.sh       | 17 +++++++++++++----
 3 files changed, 57 insertions(+), 4 deletions(-)
 create mode 100755 t/perf/p0100-globbing.sh

-- 
2.11.0

