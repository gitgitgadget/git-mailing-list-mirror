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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190D7C433E0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1ED764DBA
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhBOAyv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 19:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhBOAy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 19:54:26 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F366C0617AA
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:11 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id t15so7106731wrx.13
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7iKluFb5SRGhJLywSaY/QGqQZ/w9hMtFJ5UPGRP+ZL8=;
        b=StlfIBaS3ONf2hT+Wz1edYrgYBBxaFnf12yULeEpMtE9gE/5tvJUrqLzNZxX0UaMRH
         EF8/XgbTBqIQxqti2qG1j5o4OVBOy1lVQuULJEw1C/KgvncTuEZw39F4ZPGZFehc2dYC
         Fd+dADFRNftG6Z7I+qC5uFkOTWaWRCNnrOj79uhW/+qzuTHdbev87TjpJZqpxC+sy2l4
         F/srnXeKZI/nKb/SuCJc5nxLyQqJXJl6BjirYCW1Z7EumJkMiP3KDn/eQMkuBpVhjYR7
         nzsaO6VZszQNPHlbRrDETrhNEUuwd1UEJON9G7DnPmtqdX3GhCMkdg6vp2VmE3KnVV7F
         WBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7iKluFb5SRGhJLywSaY/QGqQZ/w9hMtFJ5UPGRP+ZL8=;
        b=ACCjp1y5vHqgNyV/5o90PTswINi1Ua2JxdQca8YD42BZICx+ETYnGS1S0SCJrFyDgT
         MM1RODwKxCiLQxk8jjSyJYTVhbQrWjOsABZEvPcQjBAjXMCZs0JFCf+pfY4irM+obtal
         xyv17nDBLDe8DQAdqOaKsjIiYcuyiO8TK/u9XgTWbuVuhlSWbZWID8b8/q+gDE5HR6GR
         qXy8kcElAG8wwR3Dts7FdCfBRl/hiLwfX8pHFCnrH7NTMnL6ABogr34S+8EgkvJ8oMtO
         L8BByskQ/z6luriyk2yrIRJJ6lbrcuASGHa6GqEKJu4uMuZGP0T3jPnnlc5L3L7mnl/4
         dw9w==
X-Gm-Message-State: AOAM532ln/tyeFK5uskmdh38SvXzZiUPZqhdrsVj2DvWjK26KAKXn3Mx
        +CUYINs26jN6gusimr22zPJTEpBi/qdtQg==
X-Google-Smtp-Source: ABdhPJwl7Mbkr4AP7BxOxtX4Zb62BVbi/mb+Iov4IKQAFlIVw3o3YL7hd+3gkMCbLZ/coGwVtp6ULQ==
X-Received: by 2002:a05:6000:1788:: with SMTP id e8mr16322539wrg.171.1613350389553;
        Sun, 14 Feb 2021 16:53:09 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 3sm5209832wmi.2.2021.02.14.16.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 16:53:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 13/20] userdiff tests + docs: document & test "diff.<driver>.x?funcname"
Date:   Mon, 15 Feb 2021 01:52:29 +0100
Message-Id: <20210215005236.11313-14-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87tuqebj6m.fsf@evledraar.gmail.com>
References: <87tuqebj6m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the missing documentation for "diff.<driver>.funcname" and test
for how it and "diff.<driver>.xfuncname" interact.

Between the introduction of the "diff.<driver>.xfuncname" form in
45d9414fa5 (diff.*.xfuncname which uses "extended" regex's for hunk
header selection, 2008-09-18) and when this documentation was written
in 90b94c26f7 (Documentation: Add diff.<driver>.* to config,
2011-04-07) we forgot to document the existence of
"diff.<driver>.funcname".

Let's make a mention of it here, we could also partially revert the
former commit and discuss the more verbose form in gitattributes(5),
but let's stop short of that. It makes sense to guide users towards
ERE over BRE whenever possible.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/diff.txt | 12 +++++++++++
 t/t4018/custom.sh             | 40 +++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index 2d3331f55c..5fce8021de 100644
--- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -153,10 +153,22 @@ diff.<driver>.command::
 	The custom diff driver command.  See linkgit:gitattributes[5]
 	for details.
 
+diff.<driver>.funcname::
 diff.<driver>.xfuncname::
 	The regular expression that the diff driver should use to
 	recognize the hunk header.  A built-in pattern may also be used.
 	See linkgit:gitattributes[5] for details.
++
+When provided as `diff.<driver>.funcname` the regular expression is
+interpreted as a basic regular expression, with
+`diff.<driver>.xfuncname` it's interpreted as an extended regular
+expression.
++
+
+The `*.funcname` and `*.xfuncname` variables behave as if though they
+were one configuration variable for the purposes of what value
+eventually gets used. Setting `*.funcname` will override an earlier
+`*.xfuncname` and vice-versa.
 
 diff.<driver>.binary::
 	Set this option to true to make the diff driver treat files as
diff --git a/t/t4018/custom.sh b/t/t4018/custom.sh
index 20abb38451..b68d96a8af 100755
--- a/t/t4018/custom.sh
+++ b/t/t4018/custom.sh
@@ -78,6 +78,46 @@ public class Beer
 }
 EOF_TEST
 
+test_expect_success 'custom; setup config precedence' '
+	git config diff.custom.funcname "foo" &&
+	git config diff.custom.xfuncname "bar"
+'
+
+test_diff_funcname 'custom: config precedence' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+bar
+EOF_HUNK
+foo
+bar
+
+ChangeMe
+
+baz
+EOF_TEST
+
+test_expect_success 'custom: teardown' '
+	test_unconfig diff.custom.funcname &&
+	test_unconfig diff.custom.xfuncname
+'
+
+test_expect_success 'custom; setup config precedence' '
+	git config diff.custom.xfuncname "bar" &&
+	git config diff.custom.funcname "foo"
+
+'
+
+test_diff_funcname 'custom: config precedence' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+foo
+EOF_HUNK
+foo
+bar
+
+ChangeMe
+
+baz
+EOF_TEST
+
 test_expect_success 'custom: teardown' '
 	test_unconfig diff.custom.funcname &&
 	test_unconfig diff.custom.xfuncname
-- 
2.30.0.284.gd98b1dd5eaa7

