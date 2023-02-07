Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E847C64EC6
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 18:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjBGSSD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 13:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjBGSRd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 13:17:33 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4285F3B3D5
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 10:17:17 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-52a8f97c8ccso41191827b3.6
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 10:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VyIuBkDorXqSJdDLcgTF8OtdFr4+CnX2drLa4LHFN/k=;
        b=RDQTGGMFM5oj/UPasLigKggwCLgzrWgY5Crj+yuvFTY5nuLn1ECE/F+A9HHeTOOepl
         x+Jl4Y/czgRa1IPO4tskUm1xcWilbOcKzIO7F1VZbgX6rfDrs/ziKVzNGeo/zB/O26AN
         b2XGorKXUcpvVujePp2e6sDOfD3uvBCoIPwVvB4ji5cWAq1W6gcaGrxsebvBbS6YV39F
         uMRQtiuIfZYmfYreO5Lto9rcOCF3J1/2+36LMy3pPL8Xdj9Sl2VzcBCf/SGXNSWTqOyX
         QlzXk+OpBr2GfVUuekhFv4f+30Vr8DoLofOVDdw51H4Z1ALXSe0RaSvFFPEvjXvA95Xl
         nDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VyIuBkDorXqSJdDLcgTF8OtdFr4+CnX2drLa4LHFN/k=;
        b=KRsY/Tm4Sdh9Xg2p56KUzdWWkxsDMBmSjGzNdw201MdsoshxDji3o/sivwJKTmKL5L
         PSPWW79JmqtIZlGZD6JDP4socJMIC5SNqAtwPS4ng6LLGc3TKa0oxQlCkCKoOSTu4LT6
         HGiv4UyY30MWfIfkm+DREQ12L0RlYq7ZtRL6/z+S++wBue5CoG6cWj/IbSoAYXtrBP+v
         MexaK1aHxKwh2YHslIbDSIUMqK5Riu5nIFeiiEbU/AhEwAvbUG8N8C0Wr7Xqsg+6g+AO
         vQIybfev8/LOduvORLIqM3VPM4jTxIAXj8cf09FQ+jz5TOfyhi4A5KgalEvXF4rbUg6f
         wKww==
X-Gm-Message-State: AO0yUKUa8c9C5qL/6eYMiemHAS1GNwizaEoUDXr1xcY4IeAHd3Q9N5R8
        xDr8ukIHbwzBaS80DNz6CscFwF4SDRnVrM3hlvimg8EXeQzKiH19yNg4ZuMn/Sh1p1CGKbvpLwp
        yoHP3b/qDUxahR0oLYmLoJCUptyA+n7U6uEOl+R9qjzdotFVUVROeiuDCzOcKv2cVmg==
X-Google-Smtp-Source: AK7set/VovPNoriHghAkBAssdlzor8f4P+R7DPIicWS19zu6mYaQDT+eNAxxk2F+V3nrGINYD3SQd0KUhAn/hKA=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a25:9101:0:b0:80b:5988:2042 with SMTP id
 v1-20020a259101000000b0080b59882042mr511662ybl.54.1675793835225; Tue, 07 Feb
 2023 10:17:15 -0800 (PST)
Date:   Tue,  7 Feb 2023 18:16:59 +0000
In-Reply-To: <20230117193041.708692-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230117193041.708692-1-calvinwan@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230207181706.363453-1-calvinwan@google.com>
Subject: [PATCH v7 0/7] submodule: parallelize diff
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, avarab@gmail.com,
        chooglen@google.com, newren@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Original cover letter for context:
https://lore.kernel.org/git/20221011232604.839941-1-calvinwan@google.com/

Changes since v6

Added patches 4 and 5 to refactor out more functionality so that it is
clear what changes my final patch makes. Since the large majority of
the functionality between the serial and parallel implementation is now
shared, I no longer remove the serial implementation.

Added additional tests to verify setting parallelism doesn't alter
output

Calvin Wan (7):
  run-command: add duplicate_output_fn to run_processes_parallel_opts
  submodule: strbuf variable rename
  submodule: move status parsing into function
  submodule: refactor is_submodule_modified()
  diff-lib: refactor out diff_change logic
  diff-lib: refactor match_stat_with_submodule
  diff-lib: parallelize run_diff_files for submodules

 Documentation/config/submodule.txt |  12 ++
 diff-lib.c                         | 133 +++++++++++---
 run-command.c                      |  16 +-
 run-command.h                      |  27 +++
 submodule.c                        | 274 ++++++++++++++++++++++++-----
 submodule.h                        |   9 +
 t/helper/test-run-command.c        |  21 +++
 t/t0061-run-command.sh             |  39 ++++
 t/t4027-diff-submodule.sh          |  31 ++++
 t/t7506-status-submodule.sh        |  25 +++
 10 files changed, 508 insertions(+), 79 deletions(-)

-- 
2.39.1.519.gcb327c4b5f-goog

