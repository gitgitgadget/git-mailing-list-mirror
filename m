Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C98C433FE
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 08:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbiK3Idd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 03:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235599AbiK3IdR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 03:33:17 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC859490B
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 00:28:32 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id x2so23053818edd.2
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 00:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+etyceKgJZCTo/18L+tr+FzbLhAxxscOBB068do3dzk=;
        b=cEnaWLbUUznWcC0ppjD925aCHF+RnLBRLKrhpoRs6s6yMUcgTakIE980B00YQdIEUv
         icMBnQ5OOSHDKLQm0HUMfCykNs7VJJk10fT96DkRSHVjEFEaG3XHQ1GxYIo7xjgdybnb
         eE9LArybYoqjbmawKJv2KhPLBU+McA1otQDfaI5kveQ6B40n/IFv0XN6UvF0D9BH4CXX
         756z4umQJBIRX+lPU6vL3ovgjvuvC51AmDQC/+NxnumgldmbpteisjQ0pizheVIVJ8Zj
         /naggdDzc8LylbWho9DlMoz9Hg/xBplNX/fecQRm7tAdalSckm/bCkobcl2pmrLtmdCD
         SgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+etyceKgJZCTo/18L+tr+FzbLhAxxscOBB068do3dzk=;
        b=P9vw7FBsolCNVA+ufer5C99gPYK12ywecnJ/Br858ch65mvN0SVxh91LhRxprnJZdD
         wfDoFBhVUa+WHoyVSiE6vqijwmsPcKx57nfGGopcZAFdj1ub/zx9W0IQXt05RCtgS+cX
         mgooz5S+V/uZRVf4NJ+9xt47jcWQBWY3VlIyLZk7AUpcTG3NcgqxVJOncDlV/AXbh602
         zuqkasPsR8sAEOZLCEzqS056QvR0xNHbByjmYQDkj2egoPuRKfsLLUprxgFcGqLud9QO
         BqIcKmNZNvpaOMM1/aOmV3TdmpqYI8Pz+mowr5B3/IhgN64UhT9bKZOz8pUJ6krNplin
         5how==
X-Gm-Message-State: ANoB5pl0UHxA4QI5IcE9RcvrXwxTDwEAncj+mMfT14ZBf/X+GoKaUgBu
        kt6zFyoEsENdqXGZRrj8oB1IFN9QKbPPcA==
X-Google-Smtp-Source: AA0mqf7HKHCjSKBRl04Jq0VtTnaQiZEOx0XvBb47SEx8iqVC9dlgvY6nQLrx5ZaEDPvblggISl7waA==
X-Received: by 2002:a05:6402:1045:b0:461:68e1:ced5 with SMTP id e5-20020a056402104500b0046168e1ced5mr46012740edu.142.1669796911038;
        Wed, 30 Nov 2022 00:28:31 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ju10-20020a17090798aa00b007bb751f9d10sm370095ejc.77.2022.11.30.00.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 00:28:30 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] cocci: avoid "should ... be a metavariable" warnings
Date:   Wed, 30 Nov 2022 09:28:23 +0100
Message-Id: <patch-1.1-31af153702e-20221130T082521Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc0.1028.gb88f24da998
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since [1] running "make coccicheck" has resulted in [2] being emitted
to the *.log files for the "spatch" run, and in the case of "make
coccicheck-test" we'd emit these to the user's terminal.

Nothing was broken as a result, but let's refactor the relevant rules
to eliminate the ambiguity between a possible variable and an
identifier.

1. 0e6550a2c63 (cocci: add a index-compatibility.pending.cocci,
   2022-11-19)
2. warning: line 257: should active_cache be a metavariable?
   warning: line 260: should active_cache_changed be a metavariable?
   warning: line 263: should active_cache_tree be a metavariable?
   warning: line 271: should active_nr be a metavariable?

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

This warning can be seen e.g. in "master" CI at: https://github.com/git/git/actions/runs/3580246628/jobs/6022212792#step:4:81

Junio: Sorry about missing this, this would be new in v2.39.0, so I'm
submitting it now in case you'd like to pick it up for v2.39.0, but on
the other hand there's no negative impact here other than noisy "make"
output, and noisy coccinelle logs. So it could also wait until after
the release...

 contrib/coccinelle/index-compatibility.cocci | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/contrib/coccinelle/index-compatibility.cocci b/contrib/coccinelle/index-compatibility.cocci
index 4c1b890c3ef..8520f03128a 100644
--- a/contrib/coccinelle/index-compatibility.cocci
+++ b/contrib/coccinelle/index-compatibility.cocci
@@ -1,22 +1,26 @@
 // the_index.* variables
 @@
+identifier AC = active_cache;
+identifier ACC = active_cache_changed;
+identifier ACT = active_cache_tree;
 @@
 (
-- active_cache
+- AC
 + the_index.cache
 |
-- active_cache_changed
+- ACC
 + the_index.cache_changed
 |
-- active_cache_tree
+- ACT
 + the_index.cache_tree
 )
 
 @@
+identifier AN = active_nr;
 identifier f != prepare_to_commit;
 @@
   f(...) {<...
-- active_nr
+- AN
 + the_index.cache_nr
   ...>}
 
-- 
2.39.0.rc0.1028.gb88f24da998

