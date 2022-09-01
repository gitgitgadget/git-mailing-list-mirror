Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419C8ECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 00:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbiIAAaf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 20:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiIAAaV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 20:30:21 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7516C491CC
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:11 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b5so20260634wrr.5
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=Lkq7/33y5N60KZxpCX9WI6SuWmoIYHLJZakile9msBA=;
        b=b9NkuUwOjshd3Ygla3KOBZwim47Pm0TfyuvvPogyoZkmoMMm4d/DrtTGDjetrthjYu
         2m3NbSE98n/L9ZuTayltcnb47nacmMUnwwlNpULuVVtZzXlJp7lJmoHtRh+sV3DehlOa
         ZSSfMSKbIwGqyiJOYJcvtrdOPZ7r2BZ1socdssNQsou0XdymHDGOGSTNDEzAtKxaHDQ0
         fLpTuxZ9BbslUFm3XxUkl0ti9RduW74OqyZ9VUyjm4Amq6Yc8KLsuLZXB2dHCINyjn6F
         1+dhtnqdCJAc5ASd1KoBZf2suuWh4zcXMPAQJmvfKPtOtfhluhXYhWaHrVfqbs6TKvxZ
         VZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=Lkq7/33y5N60KZxpCX9WI6SuWmoIYHLJZakile9msBA=;
        b=RKbffJnIZdfn+KZXjgBzFai18iGvJ6i8hlCLGOpakeiD9TXIPClUJPkHiDLdi7ns6v
         BemOu1nCpTEYowk4en0zFSQTKxLlZj6NCSnn1JXZ5dALUritQ17+cO/lIpfS6W1FG2MA
         TBjVnnlijEMBnkhhfzZk3R1MGDM+3M0AWjxQ6rmtTxanMVAHSh69s5YKUh31uiERiRsG
         ieTTU+B+0oyZTi9EGatd20ZryEGAnki6nXkvibrJNqNPR9fHZ050GPR9OYpJBPn0m2Op
         CqIsQ5oYiDm67wsaMCsoro8rdN6n1Qv3L8jaOHDZbXOHfZ1Jec6cEUM+6/UnjEg8XFP4
         JUyw==
X-Gm-Message-State: ACgBeo1YAP8D4il0YKp/q69d7YwYNdlD0UIS4lHPPwwC8gwLfIYZPdEX
        RhbC1qTBkmw7O0WljdvkUoVdH+dHNZM=
X-Google-Smtp-Source: AA6agR5LS4yF4X+/2vSGwe/ZAiFVZsnJssDhiYPlfYSkvg5cVfyx2wQXmlkBD0yrgcl47AUIVdltsA==
X-Received: by 2002:a05:6000:1a42:b0:225:8b5e:e0f8 with SMTP id t2-20020a0560001a4200b002258b5ee0f8mr13909881wry.710.1661992210853;
        Wed, 31 Aug 2022 17:30:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e20-20020a05600c4e5400b003a5bd5ea215sm3497419wmq.37.2022.08.31.17.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 17:30:10 -0700 (PDT)
Message-Id: <7df396ddea4cdaf9d014bb90a38da010676c1ce8.1661992197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 00:29:48 +0000
Subject: [PATCH 10/18] chainlint.pl: don't flag broken &&-chain if `$?`
 handled explicitly
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

There are cases in which tests capture and check a command's exit code
explicitly without employing test_expect_code(). They do so by
intentionally breaking the &&-chain since it would be impossible to
capture "$?" in the failing case if the `status=$?` assignment was part
of the &&-chain. Since such constructs are manually checking the exit
code, their &&-chain breakage is legitimate and safe, thus should not be
flagged. Therefore, stop flagging &&-chain breakage in such cases.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.pl                        |  6 ++++++
 t/chainlint/chain-break-status.expect |  9 +++++++++
 t/chainlint/chain-break-status.test   | 11 +++++++++++
 3 files changed, 26 insertions(+)
 create mode 100644 t/chainlint/chain-break-status.expect
 create mode 100644 t/chainlint/chain-break-status.test

diff --git a/t/chainlint.pl b/t/chainlint.pl
index ba3fcb0c8e6..14e1db3519a 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -497,6 +497,12 @@ sub accumulate {
 	# did previous command end with "&&", "|", "|| return" or similar?
 	goto DONE if match_ending($tokens, \@safe_endings);
 
+	# if this command handles "$?" specially, then okay for previous
+	# command to be missing "&&"
+	for my $token (@$cmd) {
+		goto DONE if $token =~ /\$\?/;
+	}
+
 	# flag missing "&&" at end of previous command
 	my $n = find_non_nl($tokens);
 	splice(@$tokens, $n + 1, 0, '?!AMP?!') unless $n < 0;
diff --git a/t/chainlint/chain-break-status.expect b/t/chainlint/chain-break-status.expect
new file mode 100644
index 00000000000..f4bada94632
--- /dev/null
+++ b/t/chainlint/chain-break-status.expect
@@ -0,0 +1,9 @@
+OUT=$(( ( large_git ; echo $? 1 >& 3 ) | : ) 3 >& 1) &&
+test_match_signal 13 "$OUT" &&
+
+{ test-tool sigchain > actual ; ret=$? ; } &&
+{
+	test_match_signal 15 "$ret" ||
+	test "$ret" = 3
+} &&
+test_cmp expect actual
diff --git a/t/chainlint/chain-break-status.test b/t/chainlint/chain-break-status.test
new file mode 100644
index 00000000000..a6602a7b99c
--- /dev/null
+++ b/t/chainlint/chain-break-status.test
@@ -0,0 +1,11 @@
+# LINT: broken &&-chain okay if next command handles "$?" explicitly
+OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
+test_match_signal 13 "$OUT" &&
+
+# LINT: broken &&-chain okay if next command handles "$?" explicitly
+{ test-tool sigchain >actual; ret=$?; } &&
+{
+	test_match_signal 15 "$ret" ||
+	test "$ret" = 3
+} &&
+test_cmp expect actual
-- 
gitgitgadget

