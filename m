Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BADF20357
	for <e@80x24.org>; Fri, 14 Jul 2017 13:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754142AbdGNN1U (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 09:27:20 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33319 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754024AbdGNN1S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 09:27:18 -0400
Received: by mail-qk0-f196.google.com with SMTP id a66so11045259qkb.0
        for <git@vger.kernel.org>; Fri, 14 Jul 2017 06:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sc083+WvWpEwyTlLgO/oMQoj0Cy0lmbAeuOO41Cpl3c=;
        b=PQQjOShz4a7UOL6BUb6iu+4HFk0/V7FpT2D2DfP1yG+wxcfA9QtiqsiaMco0aKzaTB
         PEcf8thzLkYnkvT/RrXilYzf/FNv6VWWgL9u30xuMpPo/uHGw0atKL0Lz2R+mjraUo/Q
         fP/rv7bFX5pGt+m1lZjIbIZOjnW2QI2/PrpKpceWAaWd1V0o+RJiYgh6UL8UPcJSTMKq
         L6Pjy+noGu01FvnTNJWqRW4OzVTkm6OP6uJntTADl4E2aoUwDv3XtQfmQqjjgoJAFJRt
         3v5lYjwrwfRmcx2/gQTnen1cO4KPxuMk6o0kOW4JCDqwCXRsv8mNQzfHHLfLWIvOXoil
         nPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sc083+WvWpEwyTlLgO/oMQoj0Cy0lmbAeuOO41Cpl3c=;
        b=EFQ+Uu30IrIwupUS4S39mpUkA80MXbJDWksZ6mu2aPh4vmt0HzP2KsnHi3k/R+CTar
         4n2mBEzQZo4RqKVJSpjw1aZF/R94PBLmw6hg8OE62lfmBE9VPwX55FjaS3sWlA6gsf9p
         yluEjeDDH3XR3Fb1D1+vFFXCHFanOM9mE9eSj8oBekh3zdbcJATpTrpezRtHcEeVy2Qj
         yke2x+2PYMMaxAOqplltUbzzLBwjaOrxONgBYF80TmsmuSXjVvvpT3MiBSAQynzx0hs4
         81zqqIlrjkuDlNpqJnzKR9fe+yf0HfzgL3VxByoTfN49vrpKh9VS7G9Dv8G9DtUmg2Rt
         +zFg==
X-Gm-Message-State: AIVw111/GAATQHImuLA151YA5Li16VKhoXWBSEbyBT+567sAJf17k1h1
        6k37xdljxPvCovL/9eA=
X-Received: by 10.55.17.198 with SMTP id 67mr12253970qkr.42.1500038837460;
        Fri, 14 Jul 2017 06:27:17 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id t43sm7044820qth.30.2017.07.14.06.27.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Jul 2017 06:27:16 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, pclouds@gmail.com,
        christian.couder@gmail.com, git@jeffhostetler.com,
        jonathantanmy@google.com
Subject: [RFC/PATCH v2 0/1] Add support for downloading blobs on demand
Date:   Fri, 14 Jul 2017 09:26:50 -0400
Message-Id: <20170714132651.170708-1-benpeart@microsoft.com>
X-Mailer: git-send-email 2.13.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series enables git to request missing objects when they are
not found in the object store. This is a fault-in model where the
"read-object" sub-process will fetch the missing object and store it in
the object store as a loose, alternate, or pack file. On success, git
will retry the operation and find the requested object.

It utilizes the recent sub-process refactoring to spawn a "read-object"
hook as a sub-process on the first request and then all subsequent
requests are made to that existing sub-process. This significantly
reduces the cost of making multiple request within a single git command.

An earlier version [1] of this patch series is pulled into [2] which
enables registering multiple ODB handlers which can be a simple command
or a sub-process. My hope is that this patch series can be completed to
meet the needs of the various efforts where faulting in missing objects
is required.

In the meantime, now that the sub-process refactoring has made it to
master, I’ve refactored this patch series to be as small and focused as
possible so it can be easily incorporated in other patch series where it
makes sense.

[3] has a need for faulting in missing objects and will be reworked to
take advantage of this patch series for its next iteration.

[4] has a similar function that uses a registered command instead of a
sub-process. Spawning a separate process for every missing object only
works if there are very few missing objects.  It does not scale well
when there are many missing objects (especially small objects like
commits and trees).

Patch is available here:
https://github.com/benpeart/git-for-windows/commits/read-object-process


[RFC] Add support for downloading blobs on demand 
[1] https://public-inbox.org/git/20170113155253.1644-1-benpeart@microsoft.com/

[RFC/PATCH v4 00/49] Add initial experimental external ODB support 
[2] https://public-inbox.org/git/20170620075523.26961-1-chriscool@tuxfamily.org/

[PATCH v2 00/19] WIP object filtering for partial clone
[3] https://public-inbox.org/git/20170713173459.3559-1-git@jeffhostetler.com/

[RFC PATCH 0/3] Partial clone: promised blobs (formerly "missing blobs")
[4] https://public-inbox.org/git/cover.1499800530.git.jonathantanmy@google.com/

Ben Peart (1):
  sha1_file: Add support for downloading blobs on demand

 Documentation/technical/read-object-protocol.txt | 102 ++++++++++++
 cache.h                                          |   1 +
 config.c                                         |   5 +
 contrib/long-running-read-object/example.pl      | 114 +++++++++++++
 environment.c                                    |   1 +
 sha1_file.c                                      | 193 ++++++++++++++++++++++-
 t/t0410-read-object.sh                           |  27 ++++
 t/t0410/read-object                              | 114 +++++++++++++
 8 files changed, 550 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/technical/read-object-protocol.txt
 create mode 100755 contrib/long-running-read-object/example.pl
 create mode 100755 t/t0410-read-object.sh
 create mode 100755 t/t0410/read-object

-- 
2.13.2.windows.1

