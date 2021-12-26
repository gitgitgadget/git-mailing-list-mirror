Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE75AC433FE
	for <git@archiver.kernel.org>; Sun, 26 Dec 2021 22:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbhLZWhb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Dec 2021 17:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234752AbhLZWh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Dec 2021 17:37:29 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7885C061757
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 14:37:28 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a9so28999173wrr.8
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 14:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ojBy2wMaXTO2+lRx7Af13v1uYyLpSAYb5DO6Tku/1sA=;
        b=g0E8y5C00VB1wUJQvz3h8GXwvkY5qhmK39DTREDZPqZY8N9vJ6iXgmZJUH5S36fK1y
         ztOB2L9YF4FNC4rvKVTOGLrMUskegPn4f4oPk1Ujil2aYfRMgDj7Vj4SNvVoaDJWs9hD
         qWg8QM8pIPaQ/6aYg8owvtiNrmqviJzbNsg7BSjaQmHDbh2lovoW6OqM+xz3kCxgGCJr
         MuvprtILf31cklxFRV5sa92nRivKxhbRpx/Fms6Lsmd6YOx86Mlk57JxReK2phulsJW8
         2MtFSRbDmv5eGHtsqqG7d/Rd6choF4VGbdG6wzrNHuRs31nkmc2qbS/vZLcEsHyUl0f5
         6f4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ojBy2wMaXTO2+lRx7Af13v1uYyLpSAYb5DO6Tku/1sA=;
        b=aE/xgEXybjJE7cTw/RyOhPNl/5qmMCmT0hLhpGIUBAnOyt35CX9L4F65JaFDCxabKQ
         hlRKu4rCVLkgtL3dN3v893WkJaZk6kPgef9ljVzCxItYBp84SzzK4hBAYuC+ArbKXGFC
         QxNEAHd9S+IlPBfMvzBYGDg+hMeGF+Gn5DeHS/O4N04A6kU1ST/9Aor75321+ZyUUrQN
         f/O/68oLCjRPV0dWfvqw29HKCsnPa5xIqxHAjT3vO6uDAnJe+tyXBDl+s3kAUYsLo+te
         OugspIV0+8wtIDdsbdt+u5MvPLY+vXcz/4sXJzbIX2ogqOVsHJdWkdbFAnynNw2Ony7u
         T7cQ==
X-Gm-Message-State: AOAM53083Wfjr0dbyG+Adne+TzgYLjTymJbR1aoYNjY2KEcQOOroorUJ
        SXFcXTbsSVOYHnsB0NlLWJpQhXxgtfx4YZqn
X-Google-Smtp-Source: ABdhPJx6GE4B1njdi4fAcGE9DP4C0VEU+ODnFm7heCj0UuedA5zSiuy3B4zYzMqCRyAmMgH+ARfOsw==
X-Received: by 2002:a05:6000:1aca:: with SMTP id i10mr10789327wry.453.1640558247056;
        Sun, 26 Dec 2021 14:37:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay29sm16289861wmb.13.2021.12.26.14.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 14:37:26 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 2/7] log tests: check if grep_config() is called by "log"-like cmds
Date:   Sun, 26 Dec 2021 23:37:14 +0100
Message-Id: <patch-v6-2.7-0edcdb50afd-20211226T223035Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1239.g84ae229c870
In-Reply-To: <cover-v6-0.7-00000000000-20211226T223035Z-avarab@gmail.com>
References: <cover-v5-0.7-00000000000-20211222T025214Z-avarab@gmail.com> <cover-v6-0.7-00000000000-20211226T223035Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the tests added in my 9df46763ef1 (log: add exhaustive tests
for pattern style options & config, 2017-05-20) to check not only
whether "git log" handles "grep.patternType", but also "git show"
etc.

It's sufficient to check whether we match a "fixed" or a "basic" regex
here to see if these codepaths correctly invoked grep_config(). We
don't need to check the details of their regular expression matching
as the "log" test does.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4202-log.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 2ced7e9d817..2490f2cd5ed 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -449,6 +449,30 @@ test_expect_success !FAIL_PREREQS 'log with various grep.patternType configurati
 	)
 '
 
+for cmd in show whatchanged reflog format-patch
+do
+	case "$cmd" in
+	format-patch) myarg="HEAD~.." ;;
+	*) myarg= ;;
+	esac
+
+	test_expect_success "$cmd: understands grep.patternType, like 'log'" '
+		git init "pattern-type-$cmd" &&
+		(
+			cd "pattern-type-$cmd" &&
+			test_commit 1 file A &&
+			test_commit "(1|2)" file B 2 &&
+
+			git -c grep.patternType=fixed $cmd --grep="..." $myarg >actual &&
+			test_must_be_empty actual &&
+
+			git -c grep.patternType=basic $cmd --grep="..." $myarg >actual &&
+			test_file_not_empty actual
+		)
+	'
+done
+test_done
+
 test_expect_success 'log --author' '
 	cat >expect <<-\EOF &&
 	Author: <BOLD;RED>A U<RESET> Thor <author@example.com>
-- 
2.34.1.1239.g84ae229c870

