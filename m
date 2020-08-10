Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABB5C433DF
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 22:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE71120782
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 22:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zuqm5eTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgHJW3b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 18:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbgHJW33 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 18:29:29 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAB9C061756
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 15:29:29 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g75so564762wme.4
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 15:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kcIe1Ke81WWpA0CcEajHDDrvDHODyyfkiE98DE6q6Zo=;
        b=Zuqm5eTFdONKLLEaQb37IDZfuZmUnGljkQt8C97+JS2DQGdqfu3+3gdtrnyT3JFeah
         57zXWHUavdA7xk3PY56k8BUGcNjq8qt68/LBBWWs3vX1RF11Xu7r7G3nn7WU1yaoI7KS
         bFhAjViOy8FqQn2xzRbOmjSQE37ivrwk+fK1Gyu5vebg6Gc8ZOgHyneEAnyhUUC5ohYZ
         Bya8iVQe/ETgyAN4lDSKMeVkM0OFzXcB3s2WNJoBT0c95ntCoL2RD8zn26xDObYZnl6H
         euSQfOhu3HbDCAtMSfu+J7PJclWUs/O/rCevwtLtSjtM90CbHXc0l66W23+tte6EEuFZ
         zPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kcIe1Ke81WWpA0CcEajHDDrvDHODyyfkiE98DE6q6Zo=;
        b=Z0oVwUXN01T0O9XVn47CPsge+JK4YM2tur4zAZdhvmE8IfpBMF27Hh93ctxDbsiVzm
         OhdI4PxNL9ZAYOr+Wkzp8SDzpXc6iwKNakfv2HyHqSdFk4OGFpbNpLBtcNPdmHL9NRaz
         svjGb3YI7mbQWRgLooeW9iKndglSpEzkvnwI1rwyU9Ck0XJccaS8bPH9b83Tirv9/ZrJ
         FA0X+57IhEonMHnBSGwMbDsxHyoI821FzKkz0YrwydMbuuDL+zxHv23Fe72GGq3YpJxR
         PbhZGuHJsilyUP0g8GpmHy85v0H4FqkX8qrRhJeEvHPu7/YyiIPBuGkRIq1MouIzTxsp
         Nlsg==
X-Gm-Message-State: AOAM530UgEQN610DlFSi8FjBcmpjAnsnAk+kjVE9Yd2BMGb3taAJE0sd
        gjR+8UWuxUkpjV0AQlJkw6VXyl38
X-Google-Smtp-Source: ABdhPJxFrGndCTOJ/9/XffttngkNCXoFvuUQ6ykKbZEVEWPtgW8ZnQrrEwA/IcI0fRupY7R1FDyNVA==
X-Received: by 2002:a1c:b7c2:: with SMTP id h185mr1299325wmf.168.1597098567797;
        Mon, 10 Aug 2020 15:29:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a11sm25106993wrq.0.2020.08.10.15.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 15:29:27 -0700 (PDT)
Message-Id: <82e1b0e69671f16e21208b5931c54266f2f743f3.1597098559.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.827.v3.git.git.1597098559.gitgitgadget@gmail.com>
References: <pull.827.v2.git.git.1596906081.gitgitgadget@gmail.com>
        <pull.827.v3.git.git.1597098559.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Aug 2020 22:29:16 +0000
Subject: [PATCH v3 08/11] t6423: add an explanation about why one of the tests
 does not pass
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

I had long since forgotten the idea behind this test and why it failed,
and took a little while to figure it out.  To prevent others from having
to spend a similar time on it, add an explanation in the comments.
However, the reasoning in the explanation makes me question why I
considered it a failure at all.  I'm not sure if I had a better reason
when I originally wrote it, but for now just add commentary about the
possible expectations and why it behaves the way it does right now.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6423-merge-rename-directories.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index bd0f17a3be..2b4a482277 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -2843,6 +2843,14 @@ test_expect_success '9f: Renamed directory that only contained immediate subdirs
 #   Commit A: priority/{alpha,bravo}/$more_files
 #   Commit B: goal/{a,b}/$more_files, goal/c
 #   Expected: priority/{alpha,bravo}/$more_files, priority/c
+# We currently fail this test because the directory renames we detect are
+#   goal/a/ -> priority/alpha/
+#   goal/b/ -> priority/bravo/
+# We do not detect
+#   goal/   -> priority/
+# because of no files found within goal/, and the fact that "a" != "alpha"
+# and "b" != "bravo".  But I'm not sure it's really a failure given that
+# viewpoint...
 
 test_setup_9g () {
 	test_create_repo 9g &&
-- 
gitgitgadget

