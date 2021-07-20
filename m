Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A90CC07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8469F610F7
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbhGTJ7I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 05:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235613AbhGTJ4D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 05:56:03 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66762C0613E4
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:36:37 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id c12so7436196wrt.3
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uEWYiN3zMagJGskhmrwR0avZIR39YtJZYgnhZg5J5eg=;
        b=MuKRa98pQuqwEp2sbqvu78KQ4vpUoB99phjzKE1iwLC1q99IfMWEg3dfZN5E5Z+ZWE
         lNxW9soMyNvEI8rxOMeW2Q/ggCiFy3NDr0DfMAhcqKCuF/uZ0v1O8CNnXzSxKyTqVr+A
         +gFF1nQDQh1YVhVwGL7R0VODuSPbdF/gUP3aYy1ST/EUPo3dC4lLmjNxqOySe7H3U9RK
         Vu6ASNeOU6jmfJnDziIO9OZEzorJLhC2gKXMeqJXcicP66z3FIbXkSnKGmffrvZ0sc7q
         NZp+EeBSiSPNG6pCrF32nK9npqyd4CAVZTgjy/hw5nTeOptNfpe1Qg2Hk/HzPpF/ipIY
         SMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uEWYiN3zMagJGskhmrwR0avZIR39YtJZYgnhZg5J5eg=;
        b=lfduc9PCTbu5DMqk0NmoIVOkkNg0nyp4jDMeBPrPU7G+Nhpfs3yIAoMOj4GJr9MdOc
         TenLJ03KdsXXyuxug0ezW/+YMoE/SZuLnIcymjfs+pJIKhl4Fs3m1f9K7IHCSOpd570T
         XbouaRJn9mr1gmA1Jcmt7bufO3Xb8xVDmIvc4AXd0UNfq3wSfJeQN8WPEKS5HT2xRBs3
         WYeCrItcQ03peWNHre0CBCkpMq3FIeQ6Xk1RT5eBCeuWEXDVofiixY99yIQ4MOvI2Nj3
         KUvGrvlcBDJ2l7Ms3toYeNilKlD7pekHF9wKQ/3zdcNzsnHhiWbb9dWny06Etvv6yxv5
         OamA==
X-Gm-Message-State: AOAM532J9CrdODEaP939yqcRiXBLl5jVkCwF5j5Sggy7yvtaV8cwpo8O
        r3rv00FObk6UqiCMjkqHENBJuwByJwA=
X-Google-Smtp-Source: ABdhPJytEmJodjjLdzxGzLblv5bBRVi12Upph/SI7ihwjW+JuklwDYnCrSlesJAya063s7HDtXrkMw==
X-Received: by 2002:a5d:4048:: with SMTP id w8mr35311196wrp.82.1626777396042;
        Tue, 20 Jul 2021 03:36:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y3sm23551559wrh.16.2021.07.20.03.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:36:35 -0700 (PDT)
Message-Id: <8fc8914a37b3c343cd92bb0255088f7b000ff7f7.1626777393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
References: <pull.981.git.1623675888.gitgitgadget@gmail.com>
        <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 10:36:22 +0000
Subject: [PATCH v2 01/12] diff --color-moved: add perf tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Add some tests so we can monitor changes to the performance of the
move detection code. The tests record the performance of a single
large diff and a sequence of smaller diffs.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/perf/p4002-diff-color-moved.sh | 45 ++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100755 t/perf/p4002-diff-color-moved.sh

diff --git a/t/perf/p4002-diff-color-moved.sh b/t/perf/p4002-diff-color-moved.sh
new file mode 100755
index 00000000000..ad56bcb71e4
--- /dev/null
+++ b/t/perf/p4002-diff-color-moved.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+
+test_description='Tests diff --color-moved performance'
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+if ! git rev-parse --verify v2.29.0^{commit} >/dev/null
+then
+	skip_all='skipping because tag v2.29.0 was not found'
+	test_done
+fi
+
+GIT_PAGER_IN_USE=1
+test_export GIT_PAGER_IN_USE
+
+test_perf 'diff --no-color-moved --no-color-moved-ws large change' '
+	git diff --no-color-moved --no-color-moved-ws v2.28.0 v2.29.0
+'
+
+test_perf 'diff --color-moved --no-color-moved-ws large change' '
+	git diff --color-moved=zebra --no-color-moved-ws v2.28.0 v2.29.0
+'
+
+test_perf 'diff --color-moved-ws=allow-indentation-change large change' '
+	git diff --color-moved=zebra --color-moved-ws=allow-indentation-change \
+		v2.28.0 v2.29.0
+'
+
+test_perf 'log --no-color-moved --no-color-moved-ws' '
+	git log --no-color-moved --no-color-moved-ws --no-merges --patch \
+		-n1000 v2.29.0
+'
+
+test_perf 'log --color-moved --no-color-moved-ws' '
+	git log --color-moved=zebra --no-color-moved-ws --no-merges --patch \
+		-n1000 v2.29.0
+'
+
+test_perf 'log --color-moved-ws=allow-indentation-change' '
+	git log --color-moved=zebra --color-moved-ws=allow-indentation-change \
+		--no-merges --patch -n1000 v2.29.0
+'
+
+test_done
-- 
gitgitgadget

