Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77EAC433E1
	for <git@archiver.kernel.org>; Mon, 18 May 2020 09:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B08DA2067D
	for <git@archiver.kernel.org>; Mon, 18 May 2020 09:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r1o1vehs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgERJlD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 05:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbgERJk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 05:40:59 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45097C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 02:40:59 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k19so4006902pll.9
        for <git@vger.kernel.org>; Mon, 18 May 2020 02:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VcMJW9Ij2XJfpfNxyw6YxAYf3X+xPooVJqFKD1+f/p0=;
        b=r1o1vehsNlX+/H5WL+/l/bpQYhBt1lCNhdOtr4dBD/w6LzhRO+UeSbNRNfRz70/vev
         +PJSNay1wQicxmkxaVEr9TeMxwMufZ+e35/USK95K+9Mp9lui32Fadn9AlfRyYfEbWR/
         g2eIEwzwKJPvBYkDAVgOvIt4TrST9k/21hygu/WU9tLlWAgTkuNYclQ/i3RIB8pgTO9x
         ROdqQ8SkX2VdzJIDQhikg9leuH3NAYEpbyz3UvHpEOjje7+ezd19LJztTtxXmxqbxVjN
         c/h/X8F2neKO8sqVsKVc0u6VEoFaxI8es9JkJd+b4yHsgVxQUFUL3T/ACQNjOS3dO4LK
         TpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VcMJW9Ij2XJfpfNxyw6YxAYf3X+xPooVJqFKD1+f/p0=;
        b=mOSF9HXtxdQNf4DBoEIevo7XkG0qy402rVS/N8xCnDjTcpdHp0LfaQCm9r3g7fEsze
         aBClo65Hw703uGOvkeK2zytvb8rJVXD58MkjLZpnLH02FdZvbQq00atH0eSteO3gCVLn
         j6ovj+afKjKXcRuTecTCSybPBrKCJcu9xGTNbMLqL4WiCfYNrEwF2QvgGNUqDD301vgH
         DpQvZUUGxUKIqv6YanJcLAvnjrjf1oNOuIv5j3wXUYPo44oEzhSpsbPHuva9HmO07eJ6
         /qagOLNc0xav0/FMjSurfqlpWcd8fxnle+cxoUYJp1dYx/XoCaC1R8pqYtwY8V1nfc4s
         czqA==
X-Gm-Message-State: AOAM531Bxyx+b19QUAPOxN/I4/Qstaw2lGf9p9KYQRD94A1Jbmg6r/ys
        iM0BrzKp4QvuztBvpvNaQS0h65m7
X-Google-Smtp-Source: ABdhPJzaI2lq+FFziSF7dR+aOWDLOGDmmogQEykuM52Oe7x4M+SggNRaIOkc6Gk6MYvMLBodT9m/2Q==
X-Received: by 2002:a17:90a:7105:: with SMTP id h5mr19170295pjk.3.1589794858842;
        Mon, 18 May 2020 02:40:58 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id e1sm8119867pjv.54.2020.05.18.02.40.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 02:40:58 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v16 09/11] t5411: test updates of remote-tracking branches
Date:   Mon, 18 May 2020 05:40:37 -0400
Message-Id: <20200518094039.757-10-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200507161057.12690-1-worldhello.net@gmail.com>
References: <20200507161057.12690-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

In order to test update of remote-tracking branches for special refs,
add new "remote.origin.fetch" settings and test cases.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 ...t-0036-report-multi-rewrite-for-one-ref.sh | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh b/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
index 27d58edd14..8eec3a1ed8 100644
--- a/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
+++ b/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
@@ -1,3 +1,18 @@
+test_expect_success "setup git config for remote-tracking of special refs" '
+	(
+		cd workbench &&
+		if ! git config --get-all remote.origin.fetch | grep refs/for/
+		then
+			git config --add remote.origin.fetch \
+				"+refs/for/*:refs/t/for/*" &&
+			git config --add remote.origin.fetch \
+				"+refs/pull/*:refs/t/pull/*" &&
+			git config --add remote.origin.fetch \
+				"+refs/changes/*:refs/t/changes/*"
+		fi
+	)
+'
+
 test_expect_success "setup proc-receive hook (multiple rewrites for one ref, no refname for the 1st rewrite, $PROTOCOL)" '
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
@@ -58,6 +73,17 @@ test_expect_success "proc-receive: multiple rewrite for one ref, no refname for
 	test_cmp expect actual
 '
 
+test_expect_success "proc-receive: check remote-tracking #1 ($PROTOCOL)" '
+	git -C workbench show-ref |
+		grep -v -e refs/remotes -e refs/heads -e refs/tags >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/t/for/master/topic
+	EOF
+	test_cmp expect actual &&
+	git -C workbench update-ref -d refs/t/for/master/topic
+'
+
 test_expect_success "setup proc-receive hook (multiple rewrites for one ref, no refname for the 2nd rewrite, $PROTOCOL)" '
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
@@ -120,6 +146,17 @@ test_expect_success "proc-receive: multiple rewrites for one ref, no refname for
 	test_cmp expect actual
 '
 
+test_expect_success "proc-receive: check remote-tracking #2 ($PROTOCOL)" '
+	git -C workbench show-ref |
+		grep -v -e refs/remotes -e refs/heads -e refs/tags >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/t/for/master/topic
+	EOF
+	test_cmp expect actual &&
+	git -C workbench update-ref -d refs/t/for/master/topic
+'
+
 test_expect_success "setup proc-receive hook (multiple rewrites for one ref, $PROTOCOL)" '
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
@@ -167,3 +204,14 @@ test_expect_success "proc-receive: multiple rewrites for one ref ($PROTOCOL)" '
 	EOF
 	test_cmp expect actual
 '
+
+test_expect_success "proc-receive: check remote-tracking #3 ($PROTOCOL)" '
+	git -C workbench show-ref |
+		grep -v -e refs/remotes -e refs/heads -e refs/tags >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/t/for/master/topic
+	EOF
+	test_cmp expect actual &&
+	git -C workbench update-ref -d refs/t/for/master/topic
+'
-- 
2.26.1.120.g98702cf3e9

