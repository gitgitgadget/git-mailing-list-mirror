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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1690BC636C8
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 14:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 005AC6121E
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 14:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239213AbhGTNqu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 09:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237662AbhGTNlB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 09:41:01 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3BBC0613E3
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 07:20:34 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u1so26259696wrs.1
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 07:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sa2iNz7KJt+fEbBJpuVsGvV2BzwQTJkb3u7b/7Xfkdw=;
        b=JyGbOE3zDE5PCXiOQpjSE8ajJIRXtisLu4Mp9ov6PrBngpBRBkMCkh6byoFNwsW18U
         IeAMEoPXJriofdxyG8htGTeaxCI4jmUoAVHYSZLVEyOiDTdI1qSwMSYKMRIZJHp69unt
         kQOyFeRHxVbdzRNPGxHiW7MTh0yMPbflKLiqJFDhP2NNAOQT20q0qbwFNP82JwFb85CF
         qtKZuRLMk0QnmBx/eD9dTdYPGrioBx/AfzYS3cNz5HXKLdh2M5PnklzOLyyEDo8LPTtY
         eQVo5wLS0x0GvfU1JeeBNsdqJDDU0pqdpAorZurTMoWXmIQbHhucyWO/oH3VPliQU5fT
         to9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sa2iNz7KJt+fEbBJpuVsGvV2BzwQTJkb3u7b/7Xfkdw=;
        b=qXXV9L8KiadXm6TJeDfl4W/ep73C3IZfEDpcko3fXY7fSTOrsRF+O/qBARvKOZz372
         whlkR2cogEvjC0M+gF55S4cvcEuGXK6rgWI2+dMMcFdFdedekYEBslR9vRa8wQklAx+n
         thKgUA0B0ljFmGdfkPj1bTaMPgDXtGEKP7n38bJD0WX7nAro5mMN7/uRREDJxOhVwwP6
         MVXMFBijQlaBbWw2wFAqnvZxPaQUGO3Fq+wbsn2WjbAdkJeTx0juUnQSr6nBp95a2ewg
         EPT9XAr+QDTjP/QP2j4/1Xl3OJWb41gQbX7bYugyrf8ZznH67yLSXDzfQo+AU9RhRrhb
         oJwg==
X-Gm-Message-State: AOAM530/OTNuyHvruAzB8RTivFghoQIeZur71jWB8CuMvSW4kSOodxuy
        4DhJSc19Gn2F9wnt4f0X6R3k2cJ9ZIyeHg==
X-Google-Smtp-Source: ABdhPJyUbQl36u0aEkFpMPLfqqD3dJ5CAwOAZ2zsBLnRaq1qfv/abCKJnvUGtU9v+WTSy6NaWU32aQ==
X-Received: by 2002:a5d:4a4c:: with SMTP id v12mr35766296wrs.256.1626790832354;
        Tue, 20 Jul 2021 07:20:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c2sm23785370wrn.28.2021.07.20.07.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 07:20:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 2/3] bundle doc: elaborate on object prerequisites
Date:   Tue, 20 Jul 2021 16:20:25 +0200
Message-Id: <patch-2.3-a0f95ce3a1d-20210720T141611Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.ge7a9d58bfcf
In-Reply-To: <cover-0.3-00000000000-20210720T141611Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210702T112254Z-avarab@gmail.com> <cover-0.3-00000000000-20210720T141611Z-avarab@gmail.com>
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
index 9c743aed49f..d5627b8cc51 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -45,6 +45,7 @@ header is (mostly) in the format emitted by linkgit:git-show-ref[1].
 
 Like the the packed archive format itself bundles can either be
 self-contained, or be created using exclusions.
+See the "OBJECT PREREQUISITES" section below.
 
 Bundles created using revision exclusions are "thin packs" created
 using the `--thin` option to linkgit:git-pack-objects[1], and
@@ -153,19 +154,49 @@ contained in the union of the given bases.  Each basis can be
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
+A revision range such as `old..new` will produce a bundle tip that'll
+that'll require the revision `old` (and any objects reachable from it)
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
2.32.0.874.ge7a9d58bfcf

