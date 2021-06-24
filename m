Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB13AC49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2A89613EC
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhFXTnB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 15:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbhFXTmz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 15:42:55 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF0BC061760
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:40:34 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id a13so7919447wrf.10
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1qh1rvSpNTAGWtdVlA45nwWwTA5iQ5jldTBdt6gytmE=;
        b=Ld4p75CRfCgwuz/VMjZh8URaX+JF67O/7aebh7ge+Q5rxxgPrFUtpdeP4ml12SXTOM
         SD89/Fq/A+/q3VeX+Z/7sXahedbSUaDsLfn3d23kdVcfWPqNk8ViDyPGwx9t0HsHysv7
         rJzPJ4ffa60MnpFNR4kAHI0iFOeECC9o45XkE/CVRpCLqkulktW64J1qKJBhQ3Ve8sBL
         BafFNNo5koHiD2nEdnIsRmMdHnpx+3lo65gT46GgZa6tI600sqbkhgfbFcsZKSCq5Xyz
         yJG0VRkkDvGK4Qrm2zKZ3NhfJbuJzwZId7DeAJ0dThJGvVvbLYEHvcUTgPbgFDkqUvWS
         SbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1qh1rvSpNTAGWtdVlA45nwWwTA5iQ5jldTBdt6gytmE=;
        b=LfxCZBiSlFlN9sWIipWpqsJIRI/nYLawY6lOM4ujT9ImPDvg+Q+aqjCFPMGbU80pIL
         IQiBmkM02phxXFJ8EHwKaO0bGc1dP+1a6bH84VH7ujAn+1KJSU/zUqmBFOV97Jg2OBHZ
         q6l5lsoB9ereZZ9nM5FV+Lu6xL/rvLpEvwfpigj4VEdB74HBjOn11E9ZlvLXOoSRA+65
         IYBeO+c89iTIiPIRY/d6gKs5fufBQFlHjvscNN4GH9Oq/IYWuIxRWwBjmVITTrowznDE
         0xnAaoBfy0OexEl+JyAUHbd6lYOR9jTPikh2hM8VZcFKdCnMwSVB7u3+IyWst7uAwf7d
         QzxA==
X-Gm-Message-State: AOAM533BzjICnVokbNyUGp6ERWA4RBS1d/B6J51persHoU6uFKciiaE1
        PDbcVTWDb4tmr8Wk/KzjDzWGMym/VIvipA==
X-Google-Smtp-Source: ABdhPJy4cFv5eUm3s4WgKXOMrW+LLfon6FaHUSvMi3+Snwp7QaK1dNNh1EKU7Y7H0haf+9Un/K60ug==
X-Received: by 2002:a5d:508d:: with SMTP id a13mr6401607wrt.267.1624563632764;
        Thu, 24 Jun 2021 12:40:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y20sm9286057wmi.31.2021.06.24.12.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:40:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/3] bundle doc: elaborate on rev<->ref restriction
Date:   Thu, 24 Jun 2021 21:40:28 +0200
Message-Id: <patch-3.3-14e4a724fb2-20210624T193730Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.610.gd639e370050
In-Reply-To: <cover-0.3-00000000000-20210624T193730Z-avarab@gmail.com>
References: <patch-1.1-bc6a6d8922-20210607T165507Z-avarab@gmail.com> <cover-0.3-00000000000-20210624T193730Z-avarab@gmail.com>
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
index f231f42b12f..5674e18155a 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -131,14 +131,45 @@ unbundle <file>::
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
 
 OPEN (THIN) AND CLOSED BUNDLES
 ------------------------------
-- 
2.32.0.610.gd639e370050

