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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FCFC4320A
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 00:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86A1160F91
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 00:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbhGZXoE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 19:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234335AbhGZXoC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 19:44:02 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0A8C061760
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 17:24:29 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l4-20020a05600c1d04b02902506f89ad2dso905887wms.1
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 17:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8zwJJhksFQ5yRI33eYjk6PQt/07LTtw4z6X0N7XcQZA=;
        b=bfvJNqld9xoYgNZqy7DX/jr6Ct9l0vnhsFTbbQcCFzJUpcnkU4A+kiJJgr+P1hoR30
         5lJVEh0iLpXewOKLyNHeulkyYw6av58oP24rNiAuxy80PDRH4eR0VqP6b5i9fJJNApf1
         pZbA0O7QPYcYh//CMNs1AA/qFzf7YY1A4wahiRQ4E7k09FWkemPEPkAaaEd/EXXgXgwE
         7MFnFP3m0CxDsKzrgRBaasUx/NisCgzt8IZezmk8M/FzYxi3T2gWdSJx2vkKKJGbi0nP
         LpgXWTPGQh8AQuxdLrzaJ/H1xAcO28T0zrTAlUGZzjsX2hJ7GeJM2i5oc3s086e9XKCx
         yqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8zwJJhksFQ5yRI33eYjk6PQt/07LTtw4z6X0N7XcQZA=;
        b=I+4DvQvDJsFb7gDzYohukGyyl0oVGECAk6yjcnCWz8CdJszlAAenUPyTi0MAT+fh8T
         XH4fqiIcv4EiNiUWFx8rC1TivKqwDI2asoVfycSqw7TJshD2Y/2eIFTr88tswpjEIKXz
         J6ePDCDJ38UlIKowurzzX+4aBt0HdlBJ8ag8QtKKcphsh/PQBOexpkA61iaeJKzPfHYk
         eIH6LMQyJVkt3KPMaQFVDeZR5GUm3MOdhUit5G6gDM6yaW+v61QpdyAqOOzsTMGNyb4x
         U6TxiG7zdqPRLsnOUu360WG+mojVDi7gRlxLyQC4Bdcp5cFd1Y3KqRKq41TwQtP8XYoY
         dGeA==
X-Gm-Message-State: AOAM5328o8QfeM1M5LAlpYupp7YF6ngfm6vbYWONhaEUO9tK51Q1aztr
        Y8vQr2aX5FQAeGHWu+qDOE0RVcg1yth/Hw==
X-Google-Smtp-Source: ABdhPJz+m0s7GxnHYxC+6xnk6vyKT9KUiKXLdDTZjq0xrbKnTQLqrZDhstIgtjnM28mJqVUTdLtYbw==
X-Received: by 2002:a7b:c045:: with SMTP id u5mr1312225wmc.158.1627345468084;
        Mon, 26 Jul 2021 17:24:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l2sm1115872wmq.0.2021.07.26.17.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 17:24:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 2/3] bundle doc: elaborate on object prerequisites
Date:   Tue, 27 Jul 2021 02:24:20 +0200
Message-Id: <patch-2.3-5f344bd24a-20210727T002001Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.988.g1a6a4b2c5f
In-Reply-To: <cover-0.3-0000000000-20210727T002001Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210702T112254Z-avarab@gmail.com> <cover-0.3-0000000000-20210727T002001Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split out the discussion bout "object prerequisites" into its own
section, and add some more examples of the common cases.

See 2e0afafebd (Add git-bundle: move objects and references by
archive, 2007-02-22) for the introduction of the documentation being
changed here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-bundle.txt | 37 +++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 339c5b4727..f1f84ce2c4 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -44,6 +44,7 @@ header indicating what references are contained within the bundle.
 
 Like the the packed archive format itself bundles can either be
 self-contained, or be created using exclusions.
+See the "OBJECT PREREQUISITES" section below.
 
 Bundles created using revision exclusions are "thin packs" created
 using the `--thin` option to linkgit:git-pack-objects[1], and
@@ -152,19 +153,49 @@ contained in the union of the given bases.  Each basis can be
 specified explicitly (e.g. `^master~10`), or implicitly (e.g.
 `master~10..master`, `--since=10.days.ago master`).
 
-It is very important that the basis used be held by the destination.
+OBJECT PREREQUISITES
+--------------------
+
+When creating bundles it is possible to create a self-contained bundle
+that can be unbundled in a repository with no common history, as well
+as providing negative revisions to exclude objects needed in the
+earlier parts of the history.
+
+Feeding a revision such as `new` to `git bundle create` will create a
+bundle file that contains all the objects reachable from the revision
+`new`. That bundle can be unbundled in any repository to obtain a full
+history that leads to the revision `new`:
+
+----------------
+$ git bundle create full.bundle new
+----------------
+
+A revision range such as `old..new` will produce a bundle file that
+will require the revision `old` (and any objects reachable from it)
+to exist for the bundle to be "unbundle"-able:
+
+----------------
+$ git bundle create full.bundle old..new
+----------------
+
+A self-contained bundle without any prerequisites can be extracted
+into anywhere, even into an empty repository, or be cloned from
+(i.e., `new`, but not `old..new`).
+
 It is okay to err on the side of caution, causing the bundle file
 to contain objects already in the destination, as these are ignored
 when unpacking at the destination.
 
-`git clone` can use any bundle created without negative refspecs
-(e.g., `new`, but not `old..new`).
 If you want to match `git clone --mirror`, which would include your
 refs such as `refs/remotes/*`, use `--all`.
 If you want to provide the same set of refs that a clone directly
 from the source repository would get, use `--branches --tags` for
 the `<git-rev-list-args>`.
 
+The 'git bundle verify' command can be used to check whether your
+recipient repository has the required prerequisite commits for a
+bundle.
+
 EXAMPLES
 --------
 
-- 
2.32.0.988.g1a6a4b2c5f

