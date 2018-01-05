Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC03F1F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751857AbeAEUDK (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:03:10 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:40278 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751676AbeAEUDJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:03:09 -0500
Received: by mail-pg0-f44.google.com with SMTP id q12so2368734pgt.7
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q71mnNSWnzxqr0um4zcim6yrG0sBFRTIi4htnO+2Le0=;
        b=Su1noJx0amNcQO3SYafi3jmOnnr0wOY7L6r3As08QYt5k1gulRsn2qe+erUhljWCHF
         W6DVT74O/R4OwL+H0FH3Uz5uIkOztgcD4NjrRBRpzktkIv/c68A5Bt3FZo9Iba+d0zMQ
         Dw+cunFlA07C5JnCFCnAgvp90hSuBe+6nUSUC3JQVHZz1r2Iajoh0J1/H/xEyAh4YCoP
         E5PMfx5LX5eAG+u3jp3BrjkwAGVkvkhP/e3ChCF7mdS8lPpMrD8iOofi4t2GqqtS/NcS
         c0KB+Rc5p7oBgZAZ4zaMD2KhmNNUM6Hxx4g+XoJZMT7DCUm5oIiml+T5zLMTpK8UVrWY
         iUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q71mnNSWnzxqr0um4zcim6yrG0sBFRTIi4htnO+2Le0=;
        b=Mm9m4zsZYbTU6sRm0OkemYKMjUr4tU9ldHoXUmFAHw/sxJJMpxtnYwQSQi4uVVqsVD
         30W+QyCSCsxYh54lpNy23Uu6YrDX+DxjIiLBivWc+Cs7YhLLuIom3gVFajlQBST9wmsR
         Tz0W1r3g6ofJsy58v9ISJj58Z8FYA1ivlwxf+XJ3WQyXR99JlUqQMnGmWn1CtzaZVgL9
         RCxYw5ybJOnbnCcKqcj3oP2EBPXSrcHLAKzKJJq5LA9H4HBkXyd9Tn7NWkt05lBEfpxw
         gp3QpJt5sBumeKtF5DqHyUQT/yRd1xCkUvLiVQ+ABGXjCuAfDLw4UUERjZ4Yu/9s9mRP
         Fy6g==
X-Gm-Message-State: AKGB3mK80tCsHUDuVnjISyK4mAVf8Jz7LWY9W9gx1KGexjb3HlsUnAeM
        VLE55JlEdQhuxLeXu8Qi19MFRQ==
X-Google-Smtp-Source: ACJfBovMVeKYYiZHrjteGi9SXp+MzYJ9lmgFR25ddB0CpdCrLzlto64i4UInjpkQCDfmm+lpmryD1w==
X-Received: by 10.101.96.136 with SMTP id t8mr3412623pgu.36.1515182588830;
        Fri, 05 Jan 2018 12:03:08 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id n128sm2747275pga.57.2018.01.05.12.03.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Jan 2018 12:03:07 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 0/4] Fix --recurse-submodules for submodule worktree changes
Date:   Fri,  5 Jan 2018 12:03:00 -0800
Message-Id: <20180105200304.34173-1-sbeller@google.com>
X-Mailer: git-send-email 2.16.0.rc0.223.g4a4ac83678-goog
In-Reply-To: <xmqqo9mahdll.fsf@gitster.mtv.corp.google.com>
References: <xmqqo9mahdll.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v4:
* dropped the patch "t/helper/test-lazy-name-hash: fix compilation"
  (that snuck into v3 by accident, it is already present at
   remotes/origin/jh/memihash-opt, but I am carrying it locally in
   most branches currently.)
* Junio pointed out the micro-optimisation below, both in terms of readability
  as well as performance

diff --git a/unpack-trees.c b/unpack-trees.c
index 7657d6ecdd..96c3327f19 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2139,8 +2139,8 @@ int oneway_merge(const struct cache_entry * const *src,
 			    ie_match_stat(o->src_index, old, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE))
 				update |= CE_UPDATE;
 		}
-		if (S_ISGITLINK(old->ce_mode) && should_update_submodules() &&
-		    o->update && !verify_uptodate(old, o))
+		if (o->update && S_ISGITLINK(old->ce_mode) &&
+		    should_update_submodules() && !verify_uptodate(old, o))
 			update |= CE_UPDATE;
 		add_entry(o, old, update, 0);
 		return 0;

v3:
Thanks Junio for review of this series!
The only change in this version of the series is

--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2140,7 +2140,7 @@ int oneway_merge(const struct cache_entry * const *src,
                                update |= CE_UPDATE;
                }
                if (S_ISGITLINK(old->ce_mode) && should_update_submodules() &&
-                   !verify_uptodate(old, o))
+                   o->update && !verify_uptodate(old, o))
                        update |= CE_UPDATE;
                add_entry(o, old, update, 0);


v2:
I dropped the patch to `same()` as I realized we only need to fix the
oneway_merge function, the others (two, three way merge) are fine as
they have the checks already in place.

The test added in the last patch got slightly larger as now we also test for
newly staged files to be blown away in the submodule.

v1:

The fix is in the last patch, the first patches are just massaging the code
base to make the fix easy.

The second patch fixes a bug in the test, which was ineffective at testing.
The third patch shows the problem this series addresses,
the fourth patch is a little refactoring, which I want to keep separate
as I would expect it to be a performance regression[1].
The first patch is unrelated, but improves the readability of submodule test
cases, which we'd want to improve further.

Thanks,
Stefan

Stefan Beller (4):
  t/lib-submodule-update.sh: clarify test
  t/lib-submodule-update.sh: Fix test ignoring ignored files in
    submodules
  unpack-trees: oneway_merge to update submodules
  submodule: submodule_move_head omits old argument in forced case

 submodule.c               |  4 +++-
 t/lib-submodule-update.sh | 19 +++++++++++++++++--
 unpack-trees.c            |  3 +++
 3 files changed, 23 insertions(+), 3 deletions(-)

-- 
2.16.0.rc0.223.g4a4ac83678-goog

