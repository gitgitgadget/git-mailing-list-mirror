Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6E3C433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 16:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241948AbiAEQeC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 11:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241940AbiAEQdu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 11:33:50 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3683DC061212
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 08:33:50 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id e5so84190246wrc.5
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 08:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3hFI7GNwtK74mMMIKlDZxg+ZBbwvKKlDrtBkx4EK2vs=;
        b=FRBxYotsCzTFwLJ22LPimodGdVBRDeVbB0/HfhAq/yiYSgdKlcN6g0moLBxRVRuyhk
         UIpdSfLVasESvHFFJC4p1hPg/BTaa35vBIWAei4hQ5tnGtSIFzBVt2SHDUCgONVAxboS
         kgIxhD4CCdiTtbo2stMQ0NDnESz2p4+QWO9sJUHZbHcHf9vWcOddorCBeI9Wd63sLVPE
         eeCOGdfwRNcWdhOZHQWfWsUqoHdL0Lv7QdNgT/bl+nkJsuVOYVOzf4jmgFgAOvBgc1na
         JWfK8H9nuK0qTEzNGceSxJAI2EV8UQNhZ81yzlD8E2S3zeq4WqDQhQXRoBESbiVOiJkF
         5PRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3hFI7GNwtK74mMMIKlDZxg+ZBbwvKKlDrtBkx4EK2vs=;
        b=UlizzKm45MWgoo8k8vC3G9aL1qvDRTb+4vDDcYks4x7r7l5UYdb8ZhirR9iUt5xGiE
         OQbC9/EIl6AmBA6v00hthTDjAYhdCETxMORdIxkWZ9xG7n3G/riDtVevq+Bzy0rkV05+
         HvDcpzwchMZpv6H9q5QLhwqbB/jfqRWjB75Y92olY+pBfnUuuK7H5U9BDoD2h/tDCZnP
         uXxT6R1cpQ+UW8kIaR5cnX1/ieAL+4i338mm2+eUauuQ76Zi4gGY1tz/FBxyOMdXp5rY
         f6jpcZ2VgrpSPHsLqY0G78C2k3pjAnGaS1/igpjorEKRUJkD6iMAwe7dE61gg5EizORl
         c9fQ==
X-Gm-Message-State: AOAM533XkIJz6UPcZufzzJyEzyikZmCXTwKreGbK3Y2WTfa5LVPFRoNg
        aDCgS2WlsgsDILZJkyJLi5uAXNZurls=
X-Google-Smtp-Source: ABdhPJx7sSrq0z2C+ka10cOk4gVHu/AKVIHi/1wPtrg9EkasVnY0TyxTIoXNhf/Be+rAZ21LC6exjw==
X-Received: by 2002:adf:fa87:: with SMTP id h7mr45767127wrr.561.1641400428542;
        Wed, 05 Jan 2022 08:33:48 -0800 (PST)
Received: from localhost.localdomain ([185.228.230.189])
        by smtp.gmail.com with ESMTPSA id u20sm3417515wml.45.2022.01.05.08.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 08:33:48 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 2/2] merge-ort: add t/t4310-merge-tree-ort.sh
Date:   Wed,  5 Jan 2022 17:33:24 +0100
Message-Id: <20220105163324.73369-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.34.1.433.g7bc349372a.dirty
In-Reply-To: <20220105163324.73369-1-chriscool@tuxfamily.org>
References: <20220105163324.73369-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds a few tests for the new merge-tree-ort command. They have
been copy-pasted from t4300-merge-tree.sh, and then the expected
output has been adjusted.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t4310-merge-tree-ort.sh | 162 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 162 insertions(+)
 create mode 100755 t/t4310-merge-tree-ort.sh

diff --git a/t/t4310-merge-tree-ort.sh b/t/t4310-merge-tree-ort.sh
new file mode 100755
index 0000000000..9a54508e82
--- /dev/null
+++ b/t/t4310-merge-tree-ort.sh
@@ -0,0 +1,162 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Will Palmer
+# Copyright (c) 2021 Christian Couder
+#
+
+test_description='git merge-tree-ort'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_commit "initial" "initial-file" "initial"
+'
+
+test_expect_success 'file add A, !B' '
+	git reset --hard initial &&
+	test_commit "add-a-not-b" "ONE" "AAA" &&
+	git merge-tree-ort initial initial add-a-not-b >actual &&
+	cat >expected <<EXPECTED &&
+result tree: ee38e20a5c0e1698539ac99d55616079a04fce26
+clean: 1
+diff with branch1:
+:000000 100644 0000000 43d5a8e A	ONE
+
+diff --git a/ONE b/ONE
+new file mode 100644
+index 0000000..43d5a8e
+--- /dev/null
++++ b/ONE
+@@ -0,0 +1 @@
++AAA
+diff with branch2:
+diff with base:
+:000000 100644 0000000 43d5a8e A	ONE
+
+diff --git a/ONE b/ONE
+new file mode 100644
+index 0000000..43d5a8e
+--- /dev/null
++++ b/ONE
+@@ -0,0 +1 @@
++AAA
+EXPECTED
+
+	test_cmp expected actual
+'
+
+test_expect_success 'file add !A, B' '
+	git reset --hard initial &&
+	test_commit "add-not-a-b" "ONE" "AAA" &&
+	git merge-tree-ort initial add-not-a-b initial >actual &&
+	cat >expected <<EXPECTED &&
+result tree: ee38e20a5c0e1698539ac99d55616079a04fce26
+clean: 1
+diff with branch1:
+diff with branch2:
+:000000 100644 0000000 43d5a8e A	ONE
+
+diff --git a/ONE b/ONE
+new file mode 100644
+index 0000000..43d5a8e
+--- /dev/null
++++ b/ONE
+@@ -0,0 +1 @@
++AAA
+diff with base:
+:000000 100644 0000000 43d5a8e A	ONE
+
+diff --git a/ONE b/ONE
+new file mode 100644
+index 0000000..43d5a8e
+--- /dev/null
++++ b/ONE
+@@ -0,0 +1 @@
++AAA
+EXPECTED
+
+	test_cmp expected actual
+'
+
+test_expect_success 'file add A, B (same)' '
+	git reset --hard initial &&
+	test_commit "add-a-b-same-A" "ONE" "AAA" &&
+	git reset --hard initial &&
+	test_commit "add-a-b-same-B" "ONE" "AAA" &&
+	git merge-tree-ort initial add-a-b-same-A add-a-b-same-B >actual &&
+	cat >expected <<EXPECTED &&
+result tree: ee38e20a5c0e1698539ac99d55616079a04fce26
+clean: 1
+diff with branch1:
+diff with branch2:
+diff with base:
+:000000 100644 0000000 43d5a8e A	ONE
+
+diff --git a/ONE b/ONE
+new file mode 100644
+index 0000000..43d5a8e
+--- /dev/null
++++ b/ONE
+@@ -0,0 +1 @@
++AAA
+EXPECTED
+
+	test_cmp expected actual
+'
+
+test_expect_success 'file add A, B (different)' '
+	git reset --hard initial &&
+	test_commit "add-a-b-diff-A" "ONE" "AAA" &&
+	git reset --hard initial &&
+	test_commit "add-a-b-diff-B" "ONE" "BBB" &&
+	git merge-tree-ort initial add-a-b-diff-A add-a-b-diff-B >actual &&
+	cat >expected <<EXPECTED &&
+result tree: 3aa938e8cc8be73c81cbaf629ea55a16e7c39319
+clean: 0
+diff with branch1:
+:100644 100644 43d5a8e 1e462bc M	ONE
+
+diff --git a/ONE b/ONE
+index 43d5a8e..1e462bc 100644
+--- a/ONE
++++ b/ONE
+@@ -1 +1,5 @@
++<<<<<<< add-a-b-diff-A
+ AAA
++=======
++BBB
++>>>>>>> add-a-b-diff-B
+diff with branch2:
+:100644 100644 ba62923 1e462bc M	ONE
+
+diff --git a/ONE b/ONE
+index ba62923..1e462bc 100644
+--- a/ONE
++++ b/ONE
+@@ -1 +1,5 @@
++<<<<<<< add-a-b-diff-A
++AAA
++=======
+ BBB
++>>>>>>> add-a-b-diff-B
+diff with base:
+:000000 100644 0000000 1e462bc A	ONE
+
+diff --git a/ONE b/ONE
+new file mode 100644
+index 0000000..1e462bc
+--- /dev/null
++++ b/ONE
+@@ -0,0 +1,5 @@
++<<<<<<< add-a-b-diff-A
++AAA
++=======
++BBB
++>>>>>>> add-a-b-diff-B
+EXPECTED
+
+	test_cmp expected actual
+'
+
+test_done
-- 
2.34.1.433.g7bc349372a.dirty

