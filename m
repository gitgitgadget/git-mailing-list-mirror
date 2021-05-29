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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EABC47082
	for <git@archiver.kernel.org>; Sat, 29 May 2021 12:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B76206108D
	for <git@archiver.kernel.org>; Sat, 29 May 2021 12:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhE2MKt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 08:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhE2MKs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 08:10:48 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A098C061574
        for <git@vger.kernel.org>; Sat, 29 May 2021 05:09:12 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id kr9so4016393pjb.5
        for <git@vger.kernel.org>; Sat, 29 May 2021 05:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7F7iP4cznfPM/hmbShsbEwruD1oSjZIWTjlWORX41Kk=;
        b=WO2rEsJJlSFHLXqDsjJBSHYl7ioC7b0gTJNkfBI9ecnLqOgR1VWrJRDSGgbzqI2fgY
         wdxOkMr1Hwr5DqIqMH6RH9U34Te3IqWVOS5zfwxSpKIHapqDvBlyy1P1wy72ciETWQ5I
         zWtSAQRFmtUPLOPcYSD7ol+2mQqXXRVWBMYdCoGz3Qnb6Q4MaSX67IJAyUfVEGQrOHzm
         f6aoUheYgCpQBr+k33ja/Ck+OhsY89qTRjNvZ6pngR+hb8YLNHs/o5tSuhBXbaq5fqxZ
         7o3jx9zCVZEAxUqXE1dtyVDzwS83OBikWRFOiTCtTTzNgg8g7uc+Hc1Cl/dLpgrxT6in
         WteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7F7iP4cznfPM/hmbShsbEwruD1oSjZIWTjlWORX41Kk=;
        b=ERij3QpPYnFpe+qMMbIWrLZHEwT2eU+56AtPjw4zFanQWGV3dXPkwMJYsFCTWRefUQ
         4ktrarKwvzVPZCuqkA9mj9NKVTgUAVEVhQe4bjEbgfqSzUwJlA1WIdJRHcO2srvXsyVz
         g0utwxPSHaNnXijqYVpdEoYNPj1DTFau107wXYP1Vulc9hVM2PHCg7KwA5ngot9bMdLu
         shAS55JhCgHxRxFMqDl4XkuQYp9uDPdSHWcH8BKBVMo1Br357zu9DX6UyExMy1ge+2bS
         xud4hStNl0op7eChI6eSL8R6a38P6+Ke7QmkqIkauam5EIH1o5lryMS72cFnqXM9tA35
         fNZw==
X-Gm-Message-State: AOAM532iArja/B5FJ7vI64MY7PJvdsZS41gjtA3TP6CGXoIvIhNIt6Gn
        PV+6lNfy1DSoegO7KeUup75ZrMhury/zI/8w
X-Google-Smtp-Source: ABdhPJx3JIJWyloPW+QVmS/tH3n/cD+cAMRJV6/FDy3aVahPTgnvIAkkg2/aDJYaVCY1VlD5M0qzgQ==
X-Received: by 2002:a17:90b:128d:: with SMTP id fw13mr9899110pjb.211.1622290151400;
        Sat, 29 May 2021 05:09:11 -0700 (PDT)
Received: from ubuntu.mate (subs32-116-206-28-39.three.co.id. [116.206.28.39])
        by smtp.gmail.com with ESMTPSA id x3sm786907pfo.145.2021.05.29.05.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 05:09:11 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     dyroneteng@gmail.com, levraiphilippeblain@gmail.com,
        stolee@gmail.com, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] clone: caveat note on converting partial clone
Date:   Sat, 29 May 2021 19:07:31 +0700
Message-Id: <20210529120730.38472-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently partial clones can't be converted into full clones, because
there is an issue where the remote can't send all missing objects
required.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 This patch is based on "clone: document partial clone section" by Teng
 Long [1].

 [1]:
https://lore.kernel.org/git/pull.745.v5.git.git.1614695133486.gitgitgadget@gmail.com/

 Documentation/git-clone.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 15495675a8..551d8fd141 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -377,6 +377,10 @@ only reading commits. `git log -p -- <path>` will download blobs to
 generate the patch output and git log --raw will download all blobs
 that changed at recent commits in order to compute renames.
 
+It is currently not possible to convert partial clones into full clones,
+because there is an issue where the remote can't send all missing
+objects required. See discussion at [1].
+
 :git-clone: 1
 include::urls.txt[]
 
@@ -417,6 +421,11 @@ $ cd my-linux
 $ git clone --bare -l /home/proj/.git /pub/scm/proj.git
 ------------
 
+FOOTNOTES
+---------
+
+[1]: https://lore.kernel.org/git/6422f505-29c4-bee9-e28c-b77dd831c246@gmail.com/T/#u
+
 
 GIT
 ---
-- 
2.25.1

