Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06167208E9
	for <e@80x24.org>; Sun,  5 Aug 2018 17:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbeHETbC (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 15:31:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40310 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbeHETbC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 15:31:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id h15-v6so10135180wrs.7
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 10:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y8vba+Y+PWy8HpcBNNBJmlqfhmMQutm9NXKNll1qZp8=;
        b=YhuoBDP6O+iJzCZeLw+C1RQKDW016XtHZ6SgCCkMMrqMEWepO0TA6NaTvo1xMA/+3Z
         dQ6y/drHOTO9LYKGx/SgDjSR/EerPnxCbc/J4VGrH6j9U/Ce2xcOsrRjB/8pcU5iBDid
         sDUI+Kr0URbux20iit58rHQ3tOUwUwFlh6/guaApDHi6v6RLOEM7xTaCxqo5Sx3qjhEH
         jXFc9t9QtDakklcNJG/TLn7w09W+guBsQETmGNEW967kD74RT8aP+0SqIM2wh4n840xK
         9ArXPRRft78hATp54rHm9A2aK5i2a8kqARe6Byv/7Nru0nFXiKYN9r7TVCtA1HVAAoCw
         wNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y8vba+Y+PWy8HpcBNNBJmlqfhmMQutm9NXKNll1qZp8=;
        b=lyG8V78UmSpgLrWAUlEJqRCbDIr9ICb14sJBuzaeZDZngBSrUCCauLXeAhBeaFmq25
         O1+yM9GIBOylDuk/DpD95CyyhH1ANW7mRZZxEX/w/szJ6rHAohzAwkJBuEfArIl7ZB/Z
         c1XbJHPXbZC4Ye+6s8a0kZfoz24RQKb2zP8+xPH+RtRQBOsDA2r1OCNoTXjSZhpmHzpi
         n9lhS3spI/zW4rxvrWnZNOrwCZMqxnQHE6/7fDZ+F2TzGhqXrMraTW8YnPsTEb7O7xx9
         s0rU9zl6TAM2Z912v3FGBbvFJJGp7Yg/jwENhaIRe/AsrShxz5d8JmSaZIjmdp354IEy
         Zu+Q==
X-Gm-Message-State: AOUpUlHVfTFhkLnPEtzT3K7vajDwMY5n+bMRtlVjP2VGGLI+elk7vAfJ
        ZnVpVPv5wbj6OzWcevmGrK4JrnZM
X-Google-Smtp-Source: AAOMgpc1Wgs2h73FTjBJr0fl+cLX4lHRl4DEJMHJETjZM15GGKALzV01jpLePQBsnk2RSe1kVY8psg==
X-Received: by 2002:adf:ea0a:: with SMTP id q10-v6mr7556777wrm.224.1533489942770;
        Sun, 05 Aug 2018 10:25:42 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id x62-v6sm7523228wmg.1.2018.08.05.10.25.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 10:25:42 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 0/6] Add delta islands support
Date:   Sun,  5 Aug 2018 19:25:19 +0200
Message-Id: <20180805172525.15278-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.327.ga7d188ab43
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
patch has been split into 5 patches (1/6 to 5/6) with their own commit
message, and on top of that one patch (6/6) has been added. This patch
implements something that was requested following the previous
iteration.

I kept Peff as the author of the first 5 patches and took the liberty
to add his Signed-off-by to them.

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

* suggested Dscho: explain in the cover letter what the patches are
  all about

* suggested by Peff and Junio: improve the commit messages

* suggested by Junio: add comment before get_delta_base() in
  "packfile.h" in patch 1/6

* suggested by Duy: move 'pack.island' documentation (in
  "Documentation/config.txt") from patch 2/6 to patch 3/6

* suggested by Junio: improve pack.island documentation (in
  "Documentation/config.txt") to tell that it is an ERE in patch 3/6

* suggested by Peff: add doc about 'pack.islandCore' in patch 3/6

* suggested by Peff: add info about repacking with a big --window to
  avoid the delta window being clogged
  "Documentation/git-pack-objects.txt" in patch 3/6

* suggested by Duy: remove `#include "builtin.h"` from delta-islands.c
  in patch 2/6

* suggested by Duy: mark strings for translation in patch 2/6

* suggested by Peff: modernize code using ALLOC_ARRAY, QSORT() and
  free_tree_buffer() in patch 2/6

* suggested by Peff: use "respect islands during delta compression" as
  help text for --delta-islands in "builtin/pack-objects.c" in patch
  3/6

* suggested by Junio: improve documentation explaining how capture groups from
  the pack.island regexes are concatenated in
  Documentation/git-pack-objects.txt in patch 3/6

* suggested by Junio: add that only up to 7 capture groups are supported in
  the pack.island regexes in Documentation/git-pack-objects.txt in patch
  3/6

* suggested by Peff: move test script from the t99XX range to the t53XX range
  in commit 5/6

* suggested by Duy: move field 'tree_depth' from 'struct object_entry'
  to 'struct packing_data' in pack-object.h in new patch 6/6


The following changes have been suggested in the previous iteration,
but have not been implemented:

* suggested by Peff: rename get_delta_base() in patch 1/6

I am not sure which name to use, especially as there are a number of
other functions static to "packfile.c" with a name that starts with
"get_delta_base" and they should probably be renamed too.

* suggested by Duy: move field 'layer' from 'struct object_entry' to 'struct
  packing_data' in pack-object.h

I will respond in the original email about this.

* suggested by Peff: using FLEX_ALLOC_MEM() in island_bitmap_new() in
  patch 2/6

In his email Peff says that'd waste 4 bytes per struct, so it's not
worth it in my opinion.


This patch series is also available on GitHub in:

https://github.com/chriscool/git/commits/delta-islands

The previous version is available there:

https://github.com/chriscool/git/commits/delta-islands6
https://public-inbox.org/git/20180722054836.28935-1-chriscool@tuxfamily.org/

Christian Couder (1):
  pack-objects: move tree_depth into 'struct packing_data'

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
 builtin/pack-objects.c             | 142 ++++++---
 builtin/repack.c                   |   9 +
 delta-islands.c                    | 496 +++++++++++++++++++++++++++++
 delta-islands.h                    |  11 +
 pack-objects.h                     |   6 +
 packfile.c                         |  10 +-
 packfile.h                         |   7 +
 t/t5319-delta-islands.sh           | 143 +++++++++
 12 files changed, 900 insertions(+), 46 deletions(-)
 create mode 100644 delta-islands.c
 create mode 100644 delta-islands.h
 create mode 100755 t/t5319-delta-islands.sh

-- 
2.18.0.327.ga7d188ab43

