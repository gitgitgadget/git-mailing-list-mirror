Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273E2ECAAD4
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 00:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiIAAal (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 20:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbiIAAaV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 20:30:21 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BA67FE41
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:11 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k9so20313662wri.0
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=oqUh3cjpNmKm4FAaZzlli3XUOmHrKMdNuCJ7vI/P/a4=;
        b=FF14YGpiaYO1Op6FiX7laXOMSGKfPFJB5s1P/rp16sbvgXai7J6RwQeLhEtOhHJSOs
         fLYCkeKh0dz80yRgyCNAXg6RhmlXhWTwePikwP6DPmRRyJtWu+1GXzqP8b3ZUqAHIkTF
         x9rJcW8+/29QNk50jRaLa0rEbt4n1SOML/Ua1nvbNNIBKv2+aJF3+9jQyuEkS7Bg0Xfd
         fyTNDWS5o/KQZVV/5T/iTP83nWyW6x1daZh6KiJUmnElUS5saRxjhu60TKY41FfzuKFS
         nlB9OzF4pFib8XAObFs0nkyhXCcHPoCyvAvhltGUlgltbsoyhUrHSpYfo0pQv+ARLJ1W
         5JgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=oqUh3cjpNmKm4FAaZzlli3XUOmHrKMdNuCJ7vI/P/a4=;
        b=fkFQRnBMRJoo3nQNO7WbR8EC8LjAyOF6oKwn/xuOrXMhBP9MVvbXlulV1reOAgnWed
         TBeSREq05t49/y6c6ysAAHz1UtRVAMypaw7IM/LfkCbil2JUCdaXGiU1D1wBEYhBCQ2I
         vO+42MLb8xes0aOHme/g6aPhmLREDOInfKYpgXfdI7Py1ZznL0/ibta7y/6GLAkkALOz
         blJNp0IZrwv9m7sfzU49i/aMAb/3hD+eNHd/nxWIgkBZvjy+RgaoFN/LiI5bNKbMd7di
         spDcfVFgtdKTKtNsJIEc8lYci32I8YKk8893xWCIstciZevc177T3L3YEYa/ZOHQHNi4
         M/DA==
X-Gm-Message-State: ACgBeo1+7WeG8teIpYeRSCfnHMB68qeM/xpR+0YEkV1AikWJJFiCurXT
        ONQq9yVl/DKZ86+L9YkEbkbwdFgVgK4=
X-Google-Smtp-Source: AA6agR5XdVlNksn+dhhQ+ZyULjpxXPOCsPzV4bTscZvcJLHwHDQwgWUfBJJ2pRPwuYV1ySX9NXklAA==
X-Received: by 2002:a5d:6a01:0:b0:21a:338c:4862 with SMTP id m1-20020a5d6a01000000b0021a338c4862mr12561239wru.631.1661992209853;
        Wed, 31 Aug 2022 17:30:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r6-20020a5d4946000000b00226d2462b32sm12290086wrs.52.2022.08.31.17.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 17:30:08 -0700 (PDT)
Message-Id: <86a718bfa5585c826fc98f8844a52faabb45fa55.1661992197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 00:29:47 +0000
Subject: [PATCH 09/18] chainlint.pl: don't require `&` background command to
 end with `&&`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fabian Stelzer <fs@gigacodes.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

The exit status of the `&` asynchronous operator which starts a command
in the background is unconditionally zero, and the few places in the
test scripts which launch commands asynchronously are not interested in
the exit status of the `&` operator (though they often capture the
background command's PID). As such, there is little value in complaining
about broken &&-chain for a command launched in the background, and
doing so would only make busy-work for test authors. Therefore, take
this special case into account when checking for &&-chain breakage.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.pl                            |  2 +-
 t/chainlint/chain-break-background.expect |  9 +++++++++
 t/chainlint/chain-break-background.test   | 10 ++++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)
 create mode 100644 t/chainlint/chain-break-background.expect
 create mode 100644 t/chainlint/chain-break-background.test

diff --git a/t/chainlint.pl b/t/chainlint.pl
index 31c444067ce..ba3fcb0c8e6 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -483,7 +483,7 @@ sub match_ending {
 }
 
 my @safe_endings = (
-	[qr/^(?:&&|\|\||\|)$/],
+	[qr/^(?:&&|\|\||\||&)$/],
 	[qr/^(?:exit|return)$/, qr/^(?:\d+|\$\?)$/],
 	[qr/^(?:exit|return)$/, qr/^(?:\d+|\$\?)$/, qr/^;$/],
 	[qr/^(?:exit|return|continue)$/],
diff --git a/t/chainlint/chain-break-background.expect b/t/chainlint/chain-break-background.expect
new file mode 100644
index 00000000000..28f9114f42d
--- /dev/null
+++ b/t/chainlint/chain-break-background.expect
@@ -0,0 +1,9 @@
+JGIT_DAEMON_PID= &&
+git init --bare empty.git &&
+> empty.git/git-daemon-export-ok &&
+mkfifo jgit_daemon_output &&
+{
+	jgit daemon --port="$JGIT_DAEMON_PORT" . > jgit_daemon_output &
+	JGIT_DAEMON_PID=$!
+} &&
+test_expect_code 2 git ls-remote --exit-code git://localhost:$JGIT_DAEMON_PORT/empty.git
diff --git a/t/chainlint/chain-break-background.test b/t/chainlint/chain-break-background.test
new file mode 100644
index 00000000000..e10f656b055
--- /dev/null
+++ b/t/chainlint/chain-break-background.test
@@ -0,0 +1,10 @@
+JGIT_DAEMON_PID= &&
+git init --bare empty.git &&
+>empty.git/git-daemon-export-ok &&
+mkfifo jgit_daemon_output &&
+{
+# LINT: exit status of "&" is always 0 so &&-chaining immaterial
+	jgit daemon --port="$JGIT_DAEMON_PORT" . >jgit_daemon_output &
+	JGIT_DAEMON_PID=$!
+} &&
+test_expect_code 2 git ls-remote --exit-code git://localhost:$JGIT_DAEMON_PORT/empty.git
-- 
gitgitgadget

