Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C65C433E0
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 05:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B00C22CB8
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 05:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgLUFVd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 00:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgLUFVd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 00:21:33 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2772C0613D3
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 21:20:52 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id ce23so11692937ejb.8
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 21:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HsX38x3guYJjqUzpNA0ygfVw5UoIG0mDU0pbQXzHWVM=;
        b=bQWw29wT3G7r8QYRIWYByEEBpZM5znKLrQtPXKGCEB6ZFXvy1dVbgN5LjBYeVMtzQW
         TL+3KdXPcPyBYxpcXgV9QpJSVTEn8d/mDKS53MpNaXIuhfqflKJ7ew/gRKa3f/d2YsCr
         TU1fBSMIkiXSGSDyXxBPcMknSpxMsOotJWeBInW6+yw/glBllIPNSgoUY0nu2DBoHRkv
         fHIMlNsZblRwQzVmZYo3d2blpcuTx2WI+lLdO1a6lsX1Xl0w2dRefJ7dR9ip0qBhBZ8A
         Li+/ygU14sjbjNUkWsIrnKtdBDMxuV/lRPuUyId6M3lLcNNr05AxAeFEEol4IQGbayoT
         S61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HsX38x3guYJjqUzpNA0ygfVw5UoIG0mDU0pbQXzHWVM=;
        b=C8tLdIRiVidoIzdjO9AJVUC2y+WpLQQsnEKb7H7kHrrZmw1fBjwpTt5718MexNlE2g
         wZzJxxToLHs3k4LXDOE5Rxbzts7UVtqM7kGNlpX/6xAWkx9eUxxVeQtPbbZgXuZ2WFFp
         VxDdV0zJOEndp8ccvxytC2SOwMpLW0/Ig6CVzziIJE4/927NH47XzxAllSq8+iHU3NWP
         JcZ3JowTlxu5zj91jN2so2qpHPQ2dStP20pB9RduvJzQ2h9XPV48I2ARczcxx8iygWp3
         5AIhUKDD07CeVw99y3n6rLe5BTo4pOFijscKUHk8HSohh31CIejV4WljzHdMSvKTH/id
         0TQA==
X-Gm-Message-State: AOAM531kYmB10c101+iESwaTec/hXFgRuUC5LdhSEZvO9kOJwqgqh6JN
        rFvOVtxsekrgoe10I9hjUh6MN7p4zx0=
X-Google-Smtp-Source: ABdhPJwLU2H42Nn28kKwZVllEbRIqsdUNPS73BUQ4fPqtiqgWz8ZkYd498paQKvR9J/yETN2/TzaCg==
X-Received: by 2002:a5d:69c2:: with SMTP id s2mr15843419wrw.36.1608516323125;
        Sun, 20 Dec 2020 18:05:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h16sm11033128wmb.41.2020.12.20.18.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 18:05:22 -0800 (PST)
Message-Id: <733c674bd1901c931a8917045eb72f661872f462.1608516320.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.820.v3.git.1608516320.gitgitgadget@gmail.com>
References: <pull.820.v2.git.1608415117.gitgitgadget@gmail.com>
        <pull.820.v3.git.1608516320.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Dec 2020 02:05:18 +0000
Subject: [PATCH v3 1/3] test-lib-functions: handle --add in test_config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nipunn Koorapati <nipunn@dropbox.com>

test_config fails to unset the configuration variable when
using --add, as it tries to run git config --unset-all --add

Tell test_config to invoke test_unconfig with the arg $2 when
the arg $1 is --add

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 t/test-lib-functions.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 999982fe4a9..1fdd7129d51 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -381,6 +381,7 @@ test_unconfig () {
 		config_dir=$1
 		shift
 	fi
+	echo git ${config_dir:+-C "$config_dir"} config --unset-all "$@"
 	git ${config_dir:+-C "$config_dir"} config --unset-all "$@"
 	config_status=$?
 	case "$config_status" in
@@ -400,7 +401,13 @@ test_config () {
 		config_dir=$1
 		shift
 	fi
-	test_when_finished "test_unconfig ${config_dir:+-C '$config_dir'} '$1'" &&
+
+	first_arg=$1
+	if test "$1" = --add; then
+		first_arg=$2
+	fi
+
+	test_when_finished "test_unconfig ${config_dir:+-C '$config_dir'} '$first_arg'" &&
 	git ${config_dir:+-C "$config_dir"} config "$@"
 }
 
-- 
gitgitgadget

