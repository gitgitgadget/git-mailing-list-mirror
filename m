Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C11AD1F405
	for <e@80x24.org>; Thu,  9 Aug 2018 15:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732421AbeHISV3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 14:21:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42027 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731957AbeHISV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 14:21:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id e7-v6so5561036wrs.9
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 08:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ptx6X5Kmo1IGk2NA3/rFeJgpfD/j2TRxzkqwN9YRPnc=;
        b=MtxWzy2g+RLAbIIR5bOzBWhYFuNJh1RhXpaGaINe5F7YptmcyxIQ0CASZwS3XhE7y4
         TEHjapEKWbscCwwWUS/D/wQiW1vPY9VM9QHZ1vq++mcN1mPL3wBmTCLssL734GiwjRF5
         9oCPx4IcWYFW7CSGoridgRJxIVEL/JmlNM1nS/nyVoKV4zH0R6o0oJcTkwnHmiR8yuoK
         0yujFoYETv5YdzJ85y+mL7OqMpsfEPneMpCKBE+etWVy9Bq3Af7ZFbiH84wLZN6HWpCq
         PQDf+kIJe6atDJPzOKXw+WF9/S8x13R0SjZPmQz208uh3TOkbtHlrTA364EymSooWpFN
         peqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ptx6X5Kmo1IGk2NA3/rFeJgpfD/j2TRxzkqwN9YRPnc=;
        b=IPfGSIR9qt/v3GcwrBqNKCW8TgqWonFHEkeLTc9x8LwzTRk5G6Sji4PTdilsSehPeJ
         d+R1Nz8aJa1fnkvT5Man6JVuKJWqkU72vHuu1pMDdr6Acj5+Jx/7LHaR3lLWzjxDFqpu
         O99Xkp5Kbq5SowyoevEwJpkLWuc4dQkhXlN8C4+9fXbOaG9OhMEaM7NAPim6bmB24bsX
         xNrOhgvsZZbDB10iVlvglhOs4+y2/yIFvJDh1kMygiicf2AqejDslWUwFOkoVmTFJABe
         NuTFY2T7OK/UncG7UrH4SpY+4xBVang/UeUROox+5SjTRlccm546Cgk+SNEL4+MNEH3y
         NF6w==
X-Gm-Message-State: AOUpUlFdxNXMa6jQYYpFHrzqedL3zy9fedX+L1vg74b27xBFsvXbICan
        tCqJK1qG75rQGF6cuMFtWWrgQPZr
X-Google-Smtp-Source: AA+uWPyorN9Fu8lLdpP1sNuOXrCscYoSRTHqBs6BRugJmIMyFHeJE7ENU9Oo1B3Z40cgqDhkaACS5Q==
X-Received: by 2002:a5d:6a03:: with SMTP id m3-v6mr1770447wru.192.1533830156838;
        Thu, 09 Aug 2018 08:55:56 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id t69-v6sm10913762wmt.40.2018.08.09.08.55.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 08:55:56 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 0/8] Add delta islands support
Date:   Thu,  9 Aug 2018 17:55:24 +0200
Message-Id: <20180809155532.26151-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.555.g17f9c4abba
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series is upstreaming work made by GitHub and available in:

https://github.com/peff/git/commits/jk/delta-islands

The above work has been already described in the following article:

https://githubengineering.com/counting-objects/

The above branch contains only one patch. In this patch series the
patch has been split into 5 patches (1/8, 2/8, 4/8, 5/8 and 6/8) with
their own commit message, and on top of that 3 new patches (3/8, 7/8
and 8/8) have been added. The new patches implement things that were
requested after the previous iterations.

I kept Peff as the author of the original 5 patches and took the
liberty to add his Signed-off-by to them.

As explained in details in the Counting Object article referenced
above, the goal of the delta island mechanism is for a hosting
provider to make it possible to have the "forks" of a repository share
as much storage as possible while preventing object packs to contain
deltas between different forks.

If deltas between different forks are not prevented, when users clone
or fetch a fork, preparing the pack that should be sent to them can be
very costly CPU wise, as objects from a different fork should not be
sent, which means that a lot of deltas might need to be computed
again (instead of reusing existing deltas).


The following changes have been made since the previous iteration:

* suggested by Duy: move the code computing the write order for a
  layer to a new separate function called compute_layer_order() in
  builtin/pack-objects.c in new patch 3/8

  I think that indeed this makes the following patch (4/8) shorter and
  easier to understand as well as the overall result nicer.

* suggested by Duy and Peff: rework the way the 'tree_depth' field is
  moved from 'struct object_entry' to 'struct packing_data' in
  pack-object.h in patch 7/8

* suggested by Duy and Peff: move field 'layer' from
  'struct object_entry' to 'struct packing_data' in pack-object.h in
  new patch 8/8

This patch series is also available on GitHub in:

https://github.com/chriscool/git/commits/delta-islands

The previous versions are available there:

V2: https://github.com/chriscool/git/commits/delta-islands19
V1: https://github.com/chriscool/git/commits/delta-islands6

V2: https://public-inbox.org/git/20180805172525.15278-1-chriscool@tuxfamily.org/
V1: https://public-inbox.org/git/20180722054836.28935-1-chriscool@tuxfamily.org/


Christian Couder (3):
  pack-objects: refactor code into compute_layer_order()
  pack-objects: move tree_depth into 'struct packing_data'
  pack-objects: move 'layer' into 'struct packing_data'

Jeff King (5):
  packfile: make get_delta_base() non static
  Add delta-islands.{c,h}
  pack-objects: add delta-islands support
  repack: add delta-islands support
  t: add t5319-delta-islands.sh

 Documentation/config.txt           |  19 ++
 Documentation/git-pack-objects.txt |  97 ++++++
 Documentation/git-repack.txt       |   5 +
 Makefile                           |   1 +
 builtin/pack-objects.c             | 137 +++++---
 builtin/repack.c                   |   9 +
 delta-islands.c                    | 506 +++++++++++++++++++++++++++++
 delta-islands.h                    |  11 +
 pack-objects.c                     |  12 +
 pack-objects.h                     |  39 +++
 packfile.c                         |  10 +-
 packfile.h                         |   7 +
 t/t5319-delta-islands.sh           | 143 ++++++++
 13 files changed, 948 insertions(+), 48 deletions(-)
 create mode 100644 delta-islands.c
 create mode 100644 delta-islands.h
 create mode 100755 t/t5319-delta-islands.sh

-- 
2.18.0.555.g17f9c4abba

