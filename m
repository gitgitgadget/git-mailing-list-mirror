Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C00721F453
	for <e@80x24.org>; Wed, 26 Sep 2018 19:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbeI0CJ3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 22:09:29 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34323 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeI0CJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 22:09:28 -0400
Received: by mail-qt1-f195.google.com with SMTP id x23-v6so280045qtr.1
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 12:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j2XnxiGba6Qjmpjy2W/qsrlZvswoHxsTFu9xrz9lf44=;
        b=rGzBo6xAfDM35qRUGFgDzkmrfMUx6KEI2myEtHOasrCvrBvfLwSnU59gTeApQoYSzV
         X/wl3NzBlVNl/M2n4G+kerV+aTOwehM+X4EJPoMG3WfO3jr9ZJhK17BBOxfRlpPfuHMk
         yJwpQNx3mZyjxD33CAoQbYKdwT/Pt2mQj8H+Hx13BZR5OK8n4FKsMNwA0YZsaeL5W95k
         qoc4+JvrYqP/b93j5+2HxSzjOFAaIXaO+jccelc4TN2AcP0vYfUl60TnB6s7r3yDiR4q
         UZTgELWP9pAjxmWZsUxbNQJw4msWeqP0bbQz8QamgmaP/zn1e2wJB9PKEWUp2KDjoXLQ
         bIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j2XnxiGba6Qjmpjy2W/qsrlZvswoHxsTFu9xrz9lf44=;
        b=mIWxq2vhkiYFILLEJkY+szL10zx09LHZMIdOAfDjg4I5mxRnxuwJ2hsa0OSzfLvH23
         c7Kq4/sWbdaj02f7o64E2dx03DtIpbF7yvs3T44EQeGd11CbLAeEbIZCI14UN9pssthv
         rAHHz4dGbr+WdBSxdSCft5F8nL8G0G6cTLS7Qv7jUbAozdw1aybGb28z+HOtM7IXEsMm
         Z9S/FENkOWLSo64x5vo9/iSgw3OwY2NAogJRTJ9aIExMNwWFx8r4J8mZW/Ph6v+Cegar
         eLBiWY+giPo+a/AgtRatndoHwObiSGYY9ntG4FFG8QpTIFI5+mE/3L7SnTZp2+6WymAH
         7bHA==
X-Gm-Message-State: ABuFfog+kCEpgcLv36EyC5X0T/PIoRzFcvkTX9My2GaVBeZQMQrnhsVs
        AeRrccsMpvU38fpX7IyW60hPAOKaxG0=
X-Google-Smtp-Source: ACcGV60MIeQXpHujKidA31aSSKn4HXgLri+ffBSA/3+LG8KpUuHtu6w0ASwIyM6Na2GcyqJ5hjNstQ==
X-Received: by 2002:ac8:1644:: with SMTP id x4-v6mr5736561qtk.67.1537991693358;
        Wed, 26 Sep 2018 12:54:53 -0700 (PDT)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id 23-v6sm3314922qkn.11.2018.09.26.12.54.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 12:54:52 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>
Subject: [PATCH v6 0/7] speed up index load through parallelization
Date:   Wed, 26 Sep 2018 15:54:35 -0400
Message-Id: <20180926195442.1380-1-benpeart@microsoft.com>
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


Base Ref: master
Web-Diff: https://github.com/benpeart/git/commit/a0300882d4
Checkout: git fetch https://github.com/benpeart/git read-index-multithread-v6 && git checkout a0300882d4


This iteration brings back the Index Entry Offset Table (IEOT) extension
which enables us to multi-thread the cache entry parsing without having
the primary thread have to scan all the entries first.  In cases where the
cache entry parsing is the most expensive part, this yields some additional
savings.

Using p0002-read-cache.sh to generate some performance numbers shows how
each of the various patches contribute to the overall performance win.


Test w/100,000 files    Baseline  Optimize V4    Extensions     Entries
----------------------------------------------------------------------------
0002.1: read_cache      22.36     18.74 -16.2%   18.64 -16.6%   12.63 -43.5%

Test w/1,000,000 files  Baseline  Optimize V4    Extensions     Entries
-----------------------------------------------------------------------------
0002.1: read_cache      304.40    270.70 -11.1%  195.50 -35.8%  204.82 -32.7%

Note that on the 1,000,000 files case, multi-threading the cache entry parsing
does not yield a performance win.  This is because the cost to parse the
index extensions in this repo, far outweigh the cost of loading the cache
entries.

Name                            First    Last	  Elapsed	
load_index_extensions()		629.001  870.244  241.243	
load_cache_entries_thread()	683.911  723.199  39.288	
load_cache_entries_thread()	686.206  723.512  37.306	
load_cache_entries_thread()	686.43   722.596  36.166	
load_cache_entries_thread()	684.998  718.74   33.742	
load_cache_entries_thread()	685.035  718.698  33.663	
load_cache_entries_thread()	686.557  709.545  22.988	
load_cache_entries_thread()	684.533  703.536  19.003	
load_cache_entries_thread()	684.537  703.521  18.984	
load_cache_entries_thread()	685.062  703.774  18.712	
load_cache_entries_thread()	685.42   703.416  17.996	
load_cache_entries_thread()	648.604  664.496  15.892	
				
293.74 Total load_cache_entries_thread()

The high cost of parsing the index extensions is driven by the cache tree
and the untracked cache extensions. As this is currently the longest pole,
any reduction in this time will reduce the overall index load times so is
worth further investigation in another patch series.

Name                                    First    Last     Elapsed
|   + git!read_index_extension     	684.052  870.244  186.192
|    + git!cache_tree_read         	684.052  797.801  113.749
|    + git!read_untracked_extension	797.801  870.244  72.443

One option would be to load each extension on a separate thread but I
believe that is overkill for the vast majority of repos.  Instead, some
optimization of the loading code for these two extensions is probably worth
looking into as a quick examination shows that the bulk of the time for both
of them is spent in xcalloc().


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
 read-cache.c                             | 741 +++++++++++++++++++----
 t/README                                 |  10 +
 t/t1700-split-index.sh                   |   2 +
 7 files changed, 705 insertions(+), 115 deletions(-)


base-commit: fe8321ec057f9231c26c29b364721568e58040f7
-- 
2.18.0.windows.1


