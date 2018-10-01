Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD6561F453
	for <e@80x24.org>; Mon,  1 Oct 2018 13:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbeJAUYE (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 16:24:04 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40929 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbeJAUYD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 16:24:03 -0400
Received: by mail-qt1-f195.google.com with SMTP id e9-v6so13949616qtp.7
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 06:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ArapXiyRWKbe3jxBxv3iV24ifu1O3+MZKnbYNe43s7g=;
        b=kpMkDMrR/1JuweA+h8ugDFt8J7eOQC5q4tgXofIY4t+M1whQ1mg9R7Fzo32DQ2v+Cj
         dvlJKi51OV2yVe1UyL5ynhY4FhDCgsGUxGGOtBpkxiY8tYm0OpoqdzBIMq6EAtiOjgKS
         yxHZHzHQgoYs61FZQlB7fmk1silBBw8GCvOvw5rBJFHaPhEC6IdkE672y/9Q3Ob8+IYl
         85yuT+fFk5w0DJWin/p6Hm5OEMCwJD7ZNjHhDPQIIwDAM3YeTv9OSuVYX28tgy6Ch/Ek
         tPd3o0WLLwguHvr1gdwaK0HzzmWZPC6Goi0RXR/Xm6bdBoT193+5JL/wIxueFbUUpAfE
         +PYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ArapXiyRWKbe3jxBxv3iV24ifu1O3+MZKnbYNe43s7g=;
        b=ZlZ8c/sh1wltMxVtW4LoEbqibX3/dysoIbNEvSBSwb2t74n3T4tblQzkwFfQ47rkpL
         3ybYQlmJiuGqh6ujQTnUhQqmD/i3QE957NZ5ukJeT/2voAd9EA2B7u+eJR09bDr0nCV0
         wS0KQ+EX//ySbAmKsbUHLwCt4krEaxYaqQOzFmw7mRKc4K52itzpxgmmgD4QShZ36yW3
         HXlmNe/xtAVpq0KPGAasaFmsZXyKGesvDObjq422BOs3CJAKF/L2fbko3WxeMTj/hDzr
         GLYVMD8Uo8oM0yhLU6zalSeuUVRxD4+ECNz31RfXN/PiqSO3xm0Tvjxu40ZT4pXrgR86
         CD0Q==
X-Gm-Message-State: ABuFfoih8Lv/+inSsK7Bl7L5TH141w+k0JATXZaMiKibwSjh1n0wTACv
        zDB/EATusMENfzFLujbx6rkBpg5BSEM=
X-Google-Smtp-Source: ACcGV63FkFlNAwHHCJNM5tyuED4ehdy7ZGBMSwPUt70fWHkwko+mJROllL98ttL65GMio2+w1ssKag==
X-Received: by 2002:a0c:a482:: with SMTP id x2-v6mr8350072qvx.76.1538401569419;
        Mon, 01 Oct 2018 06:46:09 -0700 (PDT)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id f129-v6sm6763435qkb.40.2018.10.01.06.46.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 06:46:08 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com,
        Ben Peart <peartben@gmail.com>
Subject: [PATCH v7 0/7] speed up index load through parallelization
Date:   Mon,  1 Oct 2018 09:45:49 -0400
Message-Id: <20181001134556.33232-1-peartben@gmail.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20180823154053.20212-1-benpeart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for all the feedback.

The biggest change since the last version is how this patch series interacts
with the split-index feature.  With a split index, most of the cache entries
are stored in the shared index so would benefit from multi-threaded parsing.
To enable that, the EOIE and IEOT extensions are now written into the shared
index (rather than being stripped out like the other extensions).

Because of this, I can now update the tests in t1700-split-index.sh to have
updated SHA values that include the EOIE extension instead of disabling the
extension.

Using p0002-read-cache.sh to generate some performance numbers shows how
each of the various patches contribute to the overall performance win on a
particularly large repo.

Repo w/3M files      Baseline  Optimize V4   Extensions      Entries
--------------------------------------------------------------------------
0002.1: read_cache   693.29    655.65 -5.4%  470.71 -32.1%   399.62 -42.4%

Note how this cuts nearly 300ms off the index load time!

Base Ref: master
Web-Diff: https://github.com/benpeart/git/commit/c1125a5d9a
Checkout: git fetch https://github.com/benpeart/git read-index-multithread-v7 && git checkout c1125a5d9a


### Patches

Ben Peart (6):
  read-cache: clean up casting and byte decoding
  eoie: add End of Index Entry (EOIE) extension
  config: add new index.threads config setting
  read-cache: load cache extensions on a worker thread
  ieot: add Index Entry Offset Table (IEOT) extension
  read-cache: load cache entries on worker threads

Nguyễn Thái Ngọc Duy (1):
  read-cache.c: optimize reading index format v4

 Documentation/config.txt                 |   7 +
 Documentation/technical/index-format.txt |  41 ++
 config.c                                 |  18 +
 config.h                                 |   1 +
 read-cache.c                             | 749 +++++++++++++++++++----
 t/README                                 |   5 +
 t/t1700-split-index.sh                   |  13 +-
 7 files changed, 715 insertions(+), 119 deletions(-)


base-commit: fe8321ec057f9231c26c29b364721568e58040f7
-- 
2.18.0.windows.1


