Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC018C2D0A8
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 03:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 823D520715
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 03:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OP5N8iSb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgI2DhH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 23:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbgI2DhB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 23:37:01 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE85C061755
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 20:37:00 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a9so3289231wmm.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 20:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=t+pghuU5Gv83eMVih7dQHTihGijXyL5XBxWL7n3ryDI=;
        b=OP5N8iSbM0BdYIBn7ijNG1En+YdQjfOubTtRK2KOCQ5J7Sma2Ub3wmA5wnDr2npgIx
         fvxUwfwl4IYZ68akse2hBUIzU+hGVD8JBaUPtJt++Da9BUVU2j7rk5M8rQy4PwhgF/Ll
         P5vSGFh5LbqiJbQusmSE9xScFJXtLQ1OE3uez6QBJczHmg/M1G0+WW0VHbduzDa5w0fQ
         PRCEx9CUP5/9G03Eh/+rh8ubwML4cgSw0z6qBQzlTkAXUNFmTD6hIXjZNnTmhAD4d862
         +cXwOmX++n1QCT7HtcTD+LLHkGgikxMaVclBqyRWTMntMJQUwCRiuihaBlcbaQxdjRh1
         7/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=t+pghuU5Gv83eMVih7dQHTihGijXyL5XBxWL7n3ryDI=;
        b=lpYa8SESF/+KyCE94W/++8rCWb0BQvUFzDHX8BFRFzEGFie7XqKILFJ5CSZidZyEfL
         3oqThbKYIlXC2a1HaQ2JyXfkJT2sjmyXh4HuraylH/f0L8wTgOokthJxBZIppLridrfB
         t0UvbClb7aqqr1n8NGV5rLA5cvN827fvqwUEsjSbGXlh4zI9is7p2fpFWSRbw1RnWdeL
         VawrvHBAIu4enMel6cBUx2ydC1HJsHBu6VUHPaL0kXo8PHzWF0/SFD9vZjba+69ghxB5
         4kFShYK20UPIuFY97m/ZGmt6qUxKyDK3ZSq2gwe8yuMD10LmQRkd/u6z2jd9/8oAjotF
         7I5g==
X-Gm-Message-State: AOAM530ovqkgp9eFQqSudic8q2x02HVqx783rstTuWTRunygQDtXPhbd
        uQWt0gon/0tHLIK9Vssk1BBnHe0RRO4=
X-Google-Smtp-Source: ABdhPJwTBQocC2oIfpI9tDrJrHhJo8doWxqw/EV2EdTCbh5Ol/uaOTQ/oQULTEXVF48tphyWDsy1LQ==
X-Received: by 2002:a05:600c:4108:: with SMTP id j8mr2196846wmi.116.1601350619036;
        Mon, 28 Sep 2020 20:36:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a11sm3419555wmm.18.2020.09.28.20.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 20:36:58 -0700 (PDT)
Message-Id: <85be780b8eff988f01461caccabd61a0ebfd8578.1601350615.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.727.v2.git.1601350615.gitgitgadget@gmail.com>
References: <pull.727.git.1599848727.gitgitgadget@gmail.com>
        <pull.727.v2.git.1601350615.gitgitgadget@gmail.com>
From:   "Sean Barag via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Sep 2020 03:36:51 +0000
Subject: [PATCH v2 3/7] remote: add tests for add and rename with invalid
 names
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>, Sean Barag <sean@barag.org>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Sean Barag <sean@barag.org>, Sean Barag <sean@barag.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sean Barag <sean@barag.org>

In preparation for a future patch that moves `builtin/remote.c`'s
remote-name validation, ensure `git remote add` and `git remote rename`
report errors when the new name isn't valid.

Signed-off-by: Sean Barag <sean@barag.org>
---
 t/t5505-remote.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 8d62edd98b..1156f52069 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -179,6 +179,13 @@ test_expect_success 'rename errors out early when deleting non-existent branch'
 	)
 '
 
+test_expect_success 'rename errors out early when when new name is invalid' '
+	test_config remote.foo.vcs bar &&
+	echo "fatal: '\''invalid...name'\'' is not a valid remote name" >expect &&
+	test_must_fail git remote rename foo invalid...name 2>actual &&
+	test_i18ncmp expect actual
+'
+
 test_expect_success 'add existing foreign_vcs remote' '
 	test_config remote.foo.vcs bar &&
 	echo "fatal: remote foo already exists." >expect &&
@@ -194,6 +201,12 @@ test_expect_success 'add existing foreign_vcs remote' '
 	test_i18ncmp expect actual
 '
 
+test_expect_success 'add invalid foreign_vcs remote' '
+	echo "fatal: '\''invalid...name'\'' is not a valid remote name" >expect &&
+	test_must_fail git remote add invalid...name bar 2>actual &&
+	test_i18ncmp expect actual
+'
+
 cat >test/expect <<EOF
 * remote origin
   Fetch URL: $(pwd)/one
-- 
gitgitgadget

