Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E7B720188
	for <e@80x24.org>; Wed, 10 May 2017 22:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753155AbdEJWx3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 18:53:29 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33316 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbdEJWx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 18:53:28 -0400
Received: by mail-wm0-f68.google.com with SMTP id y10so2989282wmh.0
        for <git@vger.kernel.org>; Wed, 10 May 2017 15:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m/SSeJqHwBMHTFQoTwUE4/w8W4x6s67On/za7oQBYgg=;
        b=QwGQq2NDDlF+XsxgsBrqMDmxkKlArqhEvpXQiBJ/vGsw+uzyv4skdYCCroPN1HYRvW
         PNqWAH6CH5pRjuYSAPVWbsSJy30e5F7sXwc9pcrDUQSqbYGefDq9ePmCVA87A3JlcSsd
         +IRy2I7uzoKZQhx6av9OJixnsk/t5eCz8yk/WM2CUfClso47rDJ8m9tzwUpNmAY3RC7j
         fi033rVE2gDAQr+QG8jcTitjzTVehZTdltCwMqLyVw/HMxc1EA692EF9tSxnn5fsOFb8
         MgGOF1pmqy0UJ4y5h0a7YWcictsyNHJrYj+WDeOYu1RnnOIQ0433jThfKa/F65lgfX1t
         +TsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m/SSeJqHwBMHTFQoTwUE4/w8W4x6s67On/za7oQBYgg=;
        b=YLrJo/aYSQhOp/NW+88De+KuJmPZmWhAMYzrVo0cYvBd1U4HDYePnGDnBnbgyhhn7r
         eeQ5PcRPO8YEx/oVc0zeJXi3nMqVFihDP3TSS0+m0Qj39pP858yFAJbgyL9J9+tAOatI
         0/M3cB92t0/IfcQz6dXhBaq8BpbHPOHDXGfgtdEx+ZAeznKuyUkisDrUrA9evC1C8PF+
         Hfh5jtPCLyFfKJBaSykCkQuloQP+lfU5va0JxNEk33+/FPHI2NKXFneFVHUkET9MUsbz
         KOGd/m0AyA4A20FODLTYmMeEAkwX37OWD1D0Iwp2xLiG05ueMYpzwJ3/vKy5AmF9odkq
         nDhQ==
X-Gm-Message-State: AODbwcDIRX2/0O9SEmKz2/62Dy/uIzpcKgGtuQ23fdCMFnX4Eu/+SB2P
        uR3GWyYzKBx42pCS+bs=
X-Received: by 10.80.176.102 with SMTP id i93mr6004526edd.97.1494456806656;
        Wed, 10 May 2017 15:53:26 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id x26sm86722edx.60.2017.05.10.15.53.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 May 2017 15:53:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/2] perf: show that wildmatch() regressed for pathological cases in v2.0
Date:   Wed, 10 May 2017 22:53:14 +0000
Message-Id: <20170510225316.31680-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a re-send of <20170424211249.28553-1-avarab@gmail.com>
(https://public-inbox.org/git/20170424211249.28553-1-avarab@gmail.com/)
which fell through the cracks at the time.

The only change is a typo fix in the description of the test in 2/2.

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

