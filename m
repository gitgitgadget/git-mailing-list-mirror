Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C03C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 10:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbhLIKdw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 05:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbhLIKdr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 05:33:47 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D977EC061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 02:30:13 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso6161649wms.3
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 02:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=196Fzi9pWJNNoy0fcJITLBwaY4nVQto3zq+DfxxjTpI=;
        b=Pt3ikzE9/30zKgUQTJSETzNPc8HN2gMYb2xbfL5tNZPVK1ZYxP5YcPQpPdejG2Kqiz
         0bvqlmQ8qgLEx4IqqxGTC9gyiALWEyuS2/QM25m7QgZBGOrrxrEyeifp4EguMOQg0bsY
         v1+pQLcfAQ98YARdCEqjjWz9B4+3/uRPWmrxdrpLDURCSlIhF1aL9efsH3PPmfvPXk4z
         wGBANI+z9KiQd7uiTqq3csbxUyk1ATLJxISDJWMDXwfL+nPw3cdmQ/8C6ngBHyeVQDP7
         bt22X154kfIGI+R52zMQXWp6W23NcmBDIRNfm1uRaA39dIWoL3r0tredy7g1r4Vp5tVN
         5Z4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=196Fzi9pWJNNoy0fcJITLBwaY4nVQto3zq+DfxxjTpI=;
        b=bRq1KUarF4GGA5m3RJb6wrTx4QtBaaE2O3tcGWziLV1PC+0CD5hCwgaR2aFnWm796E
         7Rwcjtf0jRbDwgp+c8JbQRhkzMn46x+5XeyH0HtNBLfCr7+p5KRrr5rUU7z6Kxmx49jJ
         dNMln9hHw8uiWpUNrDs4d6EB8nBrmtfdsUgBygAXMCPFZtzDASf2oaPHQa0BKE9m0Mvp
         EoOTZKLrI8HoMcMYAgmm6HmwQN1IBzWqWb/UQdzEBtzQmUuQxTqI1BhN5PlnjPJ5XI9x
         LjclWJ9S7XkMzF2rtcdRim0Ey0E56N+4dR23H3G9ggsrUj6QEzgplV95Obe2QF6KwG+e
         1KRw==
X-Gm-Message-State: AOAM53121O9sfmJ+NaXXxFbtCdOqNvZdhdwviKg6Jmw5VmuA/cxxXD90
        n/+rxM7ialPnV0csyfZzT4HJNGWOT8w=
X-Google-Smtp-Source: ABdhPJwAGnn4QWbeMDOwFsQ2CI/YloNREoMOIpaIdS9+aBPdAKUyavRdfFsqiFJQtFFNp0fX9axX7A==
X-Received: by 2002:a1c:ed0a:: with SMTP id l10mr5975870wmh.104.1639045812312;
        Thu, 09 Dec 2021 02:30:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d9sm5293406wre.52.2021.12.09.02.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 02:30:11 -0800 (PST)
Message-Id: <48ee03cf52a619d22d7ee7b1958dd59872bf721f.1639045809.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v5.git.1639045809.gitgitgadget@gmail.com>
References: <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
        <pull.981.v5.git.1639045809.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 10:29:55 +0000
Subject: [PATCH v5 01/15] diff --color-moved: add perf tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Add some tests so we can monitor changes to the performance of the
move detection code. The tests record the performance --color-moved
and --color-moved-ws=allow-indentation-change for a large diff and a
sequence of smaller diffs. The range of commits used for the large
diff can be customized by exporting TEST_REV_A and TEST_REV_B when
running the test.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/perf/p4002-diff-color-moved.sh | 57 ++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100755 t/perf/p4002-diff-color-moved.sh

diff --git a/t/perf/p4002-diff-color-moved.sh b/t/perf/p4002-diff-color-moved.sh
new file mode 100755
index 00000000000..ab2af931c04
--- /dev/null
+++ b/t/perf/p4002-diff-color-moved.sh
@@ -0,0 +1,57 @@
+#!/bin/sh
+
+test_description='Tests diff --color-moved performance'
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+# The endpoints of the diff can be customized by setting TEST_REV_A
+# and TEST_REV_B in the environment when running this test.
+
+rev="${TEST_REV_A:-v2.28.0}"
+if ! rev_a="$(git rev-parse --quiet --verify "$rev")"
+then
+	skip_all="skipping because '$rev' was not found. \
+		  Use TEST_REV_A and TEST_REV_B to set the revs to use"
+	test_done
+fi
+rev="${TEST_REV_B:-v2.29.0}"
+if ! rev_b="$(git rev-parse --quiet --verify "$rev")"
+then
+	skip_all="skipping because '$rev' was not found. \
+		  Use TEST_REV_A and TEST_REV_B to set the revs to use"
+	test_done
+fi
+
+GIT_PAGER_IN_USE=1
+test_export GIT_PAGER_IN_USE rev_a rev_b
+
+test_perf 'diff --no-color-moved --no-color-moved-ws large change' '
+	git diff --no-color-moved --no-color-moved-ws $rev_a $rev_b
+'
+
+test_perf 'diff --color-moved --no-color-moved-ws large change' '
+	git diff --color-moved=zebra --no-color-moved-ws $rev_a $rev_b
+'
+
+test_perf 'diff --color-moved-ws=allow-indentation-change large change' '
+	git diff --color-moved=zebra --color-moved-ws=allow-indentation-change \
+		$rev_a $rev_b
+'
+
+test_perf 'log --no-color-moved --no-color-moved-ws' '
+	git log --no-color-moved --no-color-moved-ws --no-merges --patch \
+		-n1000 $rev_b
+'
+
+test_perf 'log --color-moved --no-color-moved-ws' '
+	git log --color-moved=zebra --no-color-moved-ws --no-merges --patch \
+		-n1000 $rev_b
+'
+
+test_perf 'log --color-moved-ws=allow-indentation-change' '
+	git log --color-moved=zebra --color-moved-ws=allow-indentation-change \
+		--no-merges --patch -n1000 $rev_b
+'
+
+test_done
-- 
gitgitgadget

