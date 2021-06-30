Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC75C11F68
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 09:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFDA161D02
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 09:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbhF3JTG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 05:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbhF3JTE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 05:19:04 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88246C061766
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 02:16:34 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u8so2691960wrq.8
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 02:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6kObgg6KR0OuJcPS0ZBL8S6t+t5XRok3syjamTk+XZM=;
        b=WBlDsq4qy0o3YY/vTVcIAvGrCWcnTIb0fpD+Hoo1B2ANK9bTC7N5kg6MhnWGE1rv1T
         a2oBzQ5EXQzdsUCJ4g0QmDMplnKbv9eK2WqzFfqLTKvdQ2V40GeqIY1+XSogYWdIO0wq
         41ujuvtYjQ12C0fGrAcxOFPX1KeVoBQg4Lkh5K5JBrnls+DL7si2ac0JHYlp4MKuPB+a
         QHumA3h0H4zjUOcBrf4g579hpOaVPQrRibbzstQrhHOqsgzeODwf5RaC87KmbvXaNQIY
         FIBBuGVZKzKX0Qg/AEkSv2HI6AC0NIeXBQcRInFJLTBCfNdr0nSKmtqYYxKz4IKFhPuU
         fppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6kObgg6KR0OuJcPS0ZBL8S6t+t5XRok3syjamTk+XZM=;
        b=aZrSJKpXQGoGI+l6S/qFFQZIUKh7SBwsqe7BGGtYIflEQdmj+O6xrhHz3dacNtF2WX
         xCaiS7ZspJEb48J89BviUWM9ZEbfdCDqnVZ9b6U2du6RGTOMHOTdq5m4sqaMKQoB7xu7
         asVYn/vjTQNSx0QZa8mLY5LAuXh8JSAa86Dfc/NvqrkQoRJqTPictJFOS9l6cmD4Wqbv
         Miu7saMfyK9zeLSlWo1VbB3uRxbr4qfb07HXAiYGML7aMiC3qg6GhfihkYShaUPZSycr
         MSiqKSE3bfroW2p+B4n5XyhvbWBVdjnM3pXjWIdZJegxFFzgXCWQO59QQtyKvSB/kyVH
         5WYg==
X-Gm-Message-State: AOAM533VPS3Aeu89u/o1RcOJZEIwjk7zleIKvwc389mpdEvu7I3PPeWu
        grP3SgvoAkjQsW7hxoPxLFZC76azG8xblw==
X-Google-Smtp-Source: ABdhPJxHM5YmwiUc1iEVQ4D6k/TUewcqwX+YHrAsFkGFsrcTd4+13sKoASe9hcOT++Gd817qhi4qaQ==
X-Received: by 2002:a5d:6d87:: with SMTP id l7mr9229584wrs.222.1625044592954;
        Wed, 30 Jun 2021 02:16:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p2sm20372711wro.16.2021.06.30.02.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 02:16:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 3/3] bundle doc: elaborate on rev<->ref restriction
Date:   Wed, 30 Jun 2021 11:16:28 +0200
Message-Id: <patch-3.3-9a1c33cb853-20210630T091548Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.613.g8e17abc2eb
In-Reply-To: <cover-0.3-00000000000-20210630T091548Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210624T193730Z-avarab@gmail.com> <cover-0.3-00000000000-20210630T091548Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elaborate on the restriction that you cannot provide a revision that
doesn't resolve to a reference in the "SPECIFYING REFERENCES" section
with examples.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-bundle.txt | 47 ++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 3bb3b71526c..2216b9f2843 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -133,14 +133,45 @@ unbundle <file>::
 SPECIFYING REFERENCES
 ---------------------
 
-'git bundle' will only package references that are shown by
-'git show-ref': this includes heads, tags, and remote heads.  References
-such as `master~1` cannot be packaged, but are perfectly suitable for
-defining the basis.  More than one reference may be packaged, and more
-than one basis can be specified.  The objects packaged are those not
-contained in the union of the given bases.  Each basis can be
-specified explicitly (e.g. `^master~10`), or implicitly (e.g.
-`master~10..master`, `--since=10.days.ago master`).
+Revisions must accompanied by reference names to be packaged in a
+bundle, since the header of the bundle is in a format similar to 'git
+show-ref'.
+
+More than one reference may be packaged, and more than one basis can
+be specified.  The objects packaged are those not contained in the
+union of the given bases.
+
+The 'git bundle create' command resolves the reference names for you
+using the same rules as `git rev-parse --abbrev-ref=loose`. Each
+basis can be specified explicitly (e.g. `^master~10`), or implicitly
+(e.g. `master~10..master`, `--since=10.days.ago master`).
+
+All of these simple cases are OK (assuming we have a "master" and
+"next" branch):
+
+----------------
+$ git bundle create master.bundle master
+$ echo master | git bundle create master.bundle --stdin
+$ git bundle create master-and-next.bundle master next
+$ (echo master; echo next) | git bundle create master-and-next.bundle --stdin
+----------------
+
+And so are these (and the same but omitted `--stdin` examples):
+
+----------------
+$ git bundle create recent-master.bundle master~10..master
+$ git bundle create recent-updates.bundle master~10..master next~5..next
+----------------
+
+A revision name or a range whose right-hand-side cannot be resolved to
+a reference is not accepted:
+
+----------------
+$ git bundle create HEAD.bundle $(git rev-parse HEAD)
+fatal: Refusing to create empty bundle.
+$ git bundle create master-yesterday.bundle master~10..master~5
+fatal: Refusing to create empty bundle.
+----------------
 
 OPEN AND CLOSED BUNDLES
 -----------------------
-- 
2.32.0.613.g8e17abc2eb

