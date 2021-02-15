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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825A4C43331
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 16:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 621A164E05
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 16:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbhBOQDD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 11:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbhBOPr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 10:47:57 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7570FC0611C3
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:45:04 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id x4so9744275wmi.3
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nPNOqMz4S+pE9Qli5ol4JODkRcz2ECFn+OB6PQTdy2M=;
        b=DVbu/i74bEgzKQkVmc4xxuvHw1pFel4+EgGh5c6R/li82XuS3ntJb/lMeKfWnwacD5
         xSA/R2R0y4tKPddi03ASWJ7Ng8dsythIrwBK1At2SLbqZX9h47vwOw747tNLA8l0hvcY
         mGz12mZ/o0fyn+2xhQhBA2o550OCbMEeG/8zRC+cVuzxx5zqyH9lonW5fHjn8a0wGM+S
         QFQowZsWDgE36ylQITwW9fsZGuB+14SPHSzMfYHPYKF2OmwRJmuDbUwkvB+9EyUZrrJD
         MI8fq9ttrId6wUl8uWYEKKDy/EUbEb2nTNCvdty9ri92RsWwoqTZ1y4hbws3/U87Q0wR
         p5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nPNOqMz4S+pE9Qli5ol4JODkRcz2ECFn+OB6PQTdy2M=;
        b=Te6LZh9ZWkE5C7afniAPU2bJHmXLPDVZ91ka0vZdJ5nKlXcvwmKD5yyduwZ6l4k2TH
         KSFxUk1iQiuKCvHrXbAoE0h5OLyoMZa6Nieno1BEDiXzNE1A7OxTB7+RxBkgKfZH6+sm
         3mzwfOr7RsAwYkLMPPORKTtDQtUUJb0efGQnrvHiw/WuA9xCMBE4NNbGLb0DQczyJEGf
         aoqRE2fLWY/DFIctuCOPVQQREyEUEZHY0JvGRMprkCC29f8JLazN5ho+3N3hX/cdWAC6
         jDh8kIJE9KZXjrdBegXGBZ/HdNgl5Is2DGCcTll4gIUZaN7VE+AB1Szos4RKdvPqim0x
         fhGA==
X-Gm-Message-State: AOAM532PzYYcdiFl+NQJEhpG3cQlG1oeXdigUgW1cOljtLV6XIMoztw+
        TQKPzBUwxgNtvEnEdtKY0FcFO+1LEoObxA==
X-Google-Smtp-Source: ABdhPJxoHpbwThqumCuqWIkqr7CEX01YfrwvxNMsg1ZDHV42NBeeTMXM+I3mG0t/tIjSZ8pfgYLt2w==
X-Received: by 2002:a05:600c:2155:: with SMTP id v21mr13943665wml.23.1613403902962;
        Mon, 15 Feb 2021 07:45:02 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm23562757wrx.57.2021.02.15.07.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 07:45:02 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 20/27] userdiff tests: remove "funcname" from custom3 test
Date:   Mon, 15 Feb 2021 16:44:20 +0100
Message-Id: <20210215154427.32693-21-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215005236.11313-1-avarab@gmail.com>
References: <20210215005236.11313-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We can only have one "funcname" or "xfuncname", any later definition
overrides the earlier one, so this configuration wasn't doing
anything.

When this test was originally added in 3632cfc248 (Use compatibility
regex library for OSX/Darwin, 2008-09-07) we had no such definition of
two patters for this test. Back then this was setting the
"diff.java.funcname" configuration variable.

The stage for that second pattern being set got set later. In
45d9414fa5 (diff.*.xfuncname which uses "extended" regex's for hunk
header selection, 2008-09-18) the pattern got converted from
"funcname" to "xfuncname".

Soon after in b19d288b4d (t4018-diff-funcname: demonstrate end of line
funcname matching flaw, 2008-10-15) another test immediately preceding
this one got added, using "diff.java.funcname" for its configuration.

Then f792a0b88e (t4018 (funcname patterns): make configuration easier
to track, 2011-05-21) came along and codified this whole thing when
converting the two tests from "git config" to "test_config".

Since this was never the intent of the test let's just remove this,
the rationale in f792a0b88e for having some test for the clobbering
behavior makes sense, but I'll do that in another follow-up test, not
as a hard to read side-effect of this one.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018/custom.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t4018/custom.sh b/t/t4018/custom.sh
index 30df13d8b2..886de9cddb 100755
--- a/t/t4018/custom.sh
+++ b/t/t4018/custom.sh
@@ -51,7 +51,6 @@ public class Beer
 EOF_TEST
 
 test_expect_success 'custom: setup alternation in pattern' '
-	git config diff.custom.funcname "Beer$" &&
 	git config diff.custom.xfuncname "^[ 	]*((public|static).*)$"
 '
 
-- 
2.30.0.284.gd98b1dd5eaa7

