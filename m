Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB29D1FF30
	for <e@80x24.org>; Tue, 23 May 2017 09:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762352AbdEWJSj (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 05:18:39 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34734 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753078AbdEWJSh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 05:18:37 -0400
Received: by mail-qk0-f196.google.com with SMTP id u75so22099531qka.1
        for <git@vger.kernel.org>; Tue, 23 May 2017 02:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/oJacIioIyh67/M/X602Y9ibXDWAMjakQ0VQIPOAejY=;
        b=nsBr4gNaNjt0WKJoHBlAnB7M02b+PburawSJuJ/gbTH4IhM5SKZ0q7Uivzx55o+feq
         CCAcvfsVcXOgE4BKlek9dbxbu2RfYzv1DSmZlWGHqocVfs803aDmKsfVpxnnlS54Eucf
         zUv2HeMzs81j3nUgse0jk69xumKOpzl0knKbGUY06BmczZHo2XqVb1+VvcTp5nzsfgUY
         kEvXd7iBFR9maFBn+Um7JLq9rIjvjb4u4SkSmjM9x31Q5VKFf6pl9rLm2DmodL3ZMAz8
         u1b0cmdDeBDgySpr8ENy0w845xhOi9qTnbGdBg4NrSSCmIAEUUBuiNfwqVCom6p+hc6r
         SixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/oJacIioIyh67/M/X602Y9ibXDWAMjakQ0VQIPOAejY=;
        b=GsVUpB2ywG+LgRYEhrtEClBT4V0dGQ86Gk5XS8sFbHSD3qPJhNgKh9UnkZB0RTrt2H
         ul0fVcRhB5wLeb9cwtDXwVyoTXU0Nlp1gAxyDvmbkADmARjRuvah2CMbee+VuOhxCwMb
         3U9YDln5ycgl4P9BePaS6NFZUZFM1mOSm8HVVmQZKt6maTTb7dBMl3z+1ElXSWVna0FS
         K5KYVwT+2FqJpZnTpPbf7mReBSowDL/yFB/o5sewAKPD/tUGcPeNSq6G4ZJyHr7xbI/w
         uhdRU+1tbCUeCl3Ud32gMPqtFU4EEDDTdRcVkGzQIgfhyziqAoGBHN7SgwX6bDnEc7s+
         xaWA==
X-Gm-Message-State: AODbwcDCLpa/KDC7J4pHqni1iEUXsGd/u/ywLSlhsoGUaN6wS+tYFcQD
        7olSIHesm3QEwNGftQw=
X-Received: by 10.55.156.11 with SMTP id f11mr26621038qke.8.1495531116042;
        Tue, 23 May 2017 02:18:36 -0700 (PDT)
Received: from localhost.localdomain (cpe-98-14-117-223.nyc.res.rr.com. [98.14.117.223])
        by smtp.gmail.com with ESMTPSA id a45sm83105qta.39.2017.05.23.02.18.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 02:18:35 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v5 0/6] Fix clean -d and status --ignored
Date:   Tue, 23 May 2017 05:18:23 -0400
Message-Id: <20170523091829.1746-1-sxlijin@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170518082154.28643-1-sxlijin@gmail.com>
References: <20170518082154.28643-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Incorporates latest round of feedback from Junio about how to best structure
the changes to cmd_clean() for maintainability.

Samuel Lijin (6):
  t7300: clean -d should skip dirs with ignored files
  t7061: status --ignored should search untracked dirs
  dir: recurse into untracked dirs for ignored files
  dir: hide untracked contents of untracked dirs
  dir: expose cmp_name() and check_contains()
  clean: teach clean -d to preserve ignored paths

 Documentation/technical/api-directory-listing.txt |  6 ++++
 builtin/clean.c                                   | 31 ++++++++++++++++
 dir.c                                             | 43 ++++++++++++++++++++---
 dir.h                                             |  6 +++-
 t/t7061-wtstatus-ignore.sh                        |  1 +
 t/t7300-clean.sh                                  | 16 +++++++++
 6 files changed, 98 insertions(+), 5 deletions(-)

-- 
2.13.0

