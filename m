Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FF3C43217
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 12:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiJQMJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 08:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiJQMJj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 08:09:39 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D8913D2E
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 05:09:37 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a10so18081569wrm.12
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 05:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71EaMSuFML1IN27lnqUKy1kwQ05naBx/BIDqss6SYWY=;
        b=dyoRcLmA07TEkiVAJzWme1BKustzI9YII3ahaxJL4VHSE8c1N+M7VL8L9E75TXJ4kx
         NX5PMsBMntu6ufyQzaM0+NsvtifHr1Iv1nmBflNZ9ZUAf2dKl5XkgfJ7Rvm4Njx0buAI
         DtBlhzSoar1m+8SpHZ9ZKD0zz8e+/M/2f176AGDk6tvbo/ojyw9ULxTEsin7bx0MZTWA
         dqpnOcWzmhj/WLBeE2wTIlZfSk0VpDI/kpQ3xkk6jOV8KH68T+F0gCmE5UoaBNYFikcu
         zYLLwe53GTopgbAp7VV1gARWdK0BPTkrSmWgJzDKDATLlaE22Xv6dNHDxrBvtE0iUKwn
         vVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71EaMSuFML1IN27lnqUKy1kwQ05naBx/BIDqss6SYWY=;
        b=O898BBTuS/tWwUGSKcgYNB8sAVDCjBI3HuioS/zJ5Mjfg0dNXUMU8CvGA4PxgSG5Pv
         sE+9ijJdNLHWCm6jbHNh5Zi91rIkG2iyD2VeU94KUUINFfqI71I1qHPejaPiX2/7tLPs
         3b7ubMCqybNimrK881sGV9wR3fk2hVMiESH9RF/9nNXIkGNBIkspxy6M+fOmj/9ZFcJJ
         xk6A5IbFRdMKX+qqNXXEhuSTsfvq2s2MXHcHyx55qY3l1GrhE75DpG5ORl9/NU9dhAeL
         as9tP1julh1/F1906B+BqLur+LgCSINqRheac+ri5MJZol9C4Og9U+WqFzHPqsveC6+F
         6vfg==
X-Gm-Message-State: ACrzQf3B1ui8TCwviWdgwAl0txDVs4ojusq3Byj5eN2ohG1BthQxMTR4
        Mr774Z2UB3RDQzqbzS2+Ds7X8/pb07z4xQ==
X-Google-Smtp-Source: AMsMyM7qg+lyjmHwjWymiB12B9u4ygC+HXHJXmmFq/tMBjy0RRX/AE1BmeNENMRsJvcyu6Ru121Z8g==
X-Received: by 2002:a05:6000:1882:b0:230:9595:4131 with SMTP id a2-20020a056000188200b0023095954131mr6207005wri.17.1666008576495;
        Mon, 17 Oct 2022 05:09:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6-20020a1cf406000000b003c6deb5c1edsm10028770wma.45.2022.10.17.05.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 05:09:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Jonas Bernoulli <jonas@bernoul.li>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/10] git-submodule.sh: don't support top-level "--cached"
Date:   Mon, 17 Oct 2022 14:09:21 +0200
Message-Id: <patch-06.10-25fadf3ffc1-20221017T115544Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1091.gf9d18265e59
In-Reply-To: <cover-00.10-00000000000-20221017T115544Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221017T115544Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the preceding commit all sub-commands of "git submodule" have
been dispatched to "git submodule--helper" directly, we therefore
don't need to emit "usage()" if we see "--cached" without the
sub-command being "status" or "summary", we can trust that
parse_options() will spot that and barf on it.

This does change one obscure aspect of undocumented behavior, for
"status" and "summary" we supported these undocumented forms:

    git submodule --cached (status | summary)

As noted in a preceding commit to git-submodule.sh which removed the
"--branch" special-case, this comes down to emergent behavior seen in
5c08dbbdf1a (git-submodule: fix subcommand parser,
2008-01-15). I.e. we wanted to support was for subcommand-less invocations like:

    git submodule --cached

To be synonymous with invocations that explicitly named the "status"
sub-command:

    git submodule status --cached

But we did not intend to mix the two, and allow "--cached" to be an
option to the top-level "submodule" command when the "status" or
"summary" sub-commands were explicitly provided.

Let's remove this undocumented edge case, which makes a subsequent
removal of git-submodule.sh easier to reason about. The test case
added here is duplicated from the existing for-loop, except for the
different and desired handling of "git submodule --cached status".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-submodule.sh           | 15 ++++++++-------
 t/t7400-submodule-basic.sh | 15 +++++++++++++--
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index ac2f95c1285..4f8f62ce981 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -43,7 +43,14 @@ do
 		quiet=1
 		;;
 	--cached)
-		cached=1
+		if test -z "$command"
+		then
+			cached=1 &&
+			shift &&
+			break
+		else
+			usage
+		fi
 		;;
 	--)
 		break
@@ -69,12 +76,6 @@ then
     fi
 fi
 
-# "--cached" is accepted only by "status" and "summary"
-if test -n "$cached" && test "$command" != status && test "$command" != summary
-then
-	usage
-fi
-
 case "$command" in
 absorbgitdirs)
 	git submodule--helper "$command" --prefix "$wt_prefix" "$@"
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index b50db3f1031..d8f7d6ee29a 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -31,7 +31,7 @@ test_expect_success 'submodule usage: status --' '
 	test_expect_code 1 git submodule --end-of-options
 '
 
-for opt in '--quiet' '--cached'
+for opt in '--quiet'
 do
 	test_expect_success "submodule usage: status $opt" '
 		git submodule $opt &&
@@ -40,6 +40,17 @@ do
 	'
 done
 
+for opt in '--cached'
+do
+	test_expect_success "submodule usage: status $opt" '
+		git submodule $opt &&
+		git submodule status $opt &&
+		test_expect_code 1 git submodule $opt status >out 2>err &&
+		grep "^usage: git submodule" err &&
+		test_must_be_empty out
+	'
+done
+
 test_expect_success 'submodule deinit works on empty repository' '
 	git submodule deinit --all
 '
@@ -576,7 +587,7 @@ test_expect_success 'status should be "modified" after submodule commit' '
 '
 
 test_expect_success 'the --cached sha1 should be rev1' '
-	git submodule --cached status >list &&
+	git submodule status --cached >list &&
 	grep "^+$rev1" list
 '
 
-- 
2.38.0.1091.gf9d18265e59

