Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F128FC433E9
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 01:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D450A61A0B
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 01:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbhCXBti (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 21:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbhCXBtW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 21:49:22 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F85DC061763
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 18:49:22 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id d191so12037077wmd.2
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 18:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4JJI6mrgDrZjzjDOJ5Xy9QAPcmKnnJhej81kxHwvsTs=;
        b=N2ib4Ak4zr+nxirBkvD5IDm45wEeujusVj+T99mAnWyOYqaiB6OBALDfwbvWII+0JK
         h0sudE/9VM8CiEzFNWgJgMYN9N6HWloGYCgo7/Yb16QLc4uCvDAutt/33HgO+KUsq6S4
         fGAbGhnmHLDbK273a80JSmwl9K2sOAhdLSd3/FviUkXv+yeqYtaMQWbc8cBGbad7PRtc
         ZKCU16h0U08HBypD9ybLTBxHmZhHTIui0VThQrMdOxBxQ1tDUNhWY87CBs07XFJl5ZUB
         95WjwvBugnC4K58w0yhtr+8qYOTIoMouBqZW7d1bZP0fS10fvNllNs4/bagbs+fFJSON
         yF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4JJI6mrgDrZjzjDOJ5Xy9QAPcmKnnJhej81kxHwvsTs=;
        b=BBwimyvvvPqPoNICpXEm0PKWJCcQZ9uOXuKlSUiwQNTnA+txCaJVwYcuG4TcsoJzbt
         Z6vHA6MCfqCk5Td5WXgmQyxmEnl93od+O77QBWckkvA98sYhRYhf9LXbkt7QtNt2NKD5
         XGn+L+cFVLYSVRKRhMU2seDTcb//wSx2UDJWjIieispFrbTgtqljnzOp8bEN0JmBfXlr
         m88NIbRSY8fTPtB0eD/VpKw9BFxvxFsKfPn59pIIbzh6GAnvilQaDKm18QVR3ZHGaTvp
         CLCGxAfMGoICMjGwsQysJlHNtz7bSkoF6c16muLk7d6mV094UfO+vcr1372tkecd2Cqd
         y4qw==
X-Gm-Message-State: AOAM531aqhJXX6vLQWHiNZuwVUgiGXptufFts/VAqjztrIW6q3TtaS7y
        ibY19ODFMfxBMUCUcTYUKTO3n78PnzLB/w==
X-Google-Smtp-Source: ABdhPJzXRJ6La0AYSgMhT8gqZ48I8CK+DX0BZpPSBNuDzjoRMQtstNobMrNI/XRHA0x0x4OR0uXR9A==
X-Received: by 2002:a05:600c:2f08:: with SMTP id r8mr571204wmn.95.1616550560700;
        Tue, 23 Mar 2021 18:49:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y205sm598177wmc.18.2021.03.23.18.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 18:49:20 -0700 (PDT)
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
Subject: [PATCH v4 08/10] userdiff: remove support for "broken" tests
Date:   Wed, 24 Mar 2021 02:48:50 +0100
Message-Id: <patch-08.11-7755db95014-20210324T014604Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.366.ga80606b22c1
In-Reply-To: <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
References: <20210224195129.4004-1-avarab@gmail.com> <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There have been no "broken" tests since 75c3b6b2e8 (userdiff: improve
Fortran xfuncname regex, 2020-08-12). Let's remove the test support
for them.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018-diff-funcname.sh | 8 +-------
 t/t4018/README           | 3 ---
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 5bd82e09ab3..9aec9f8e6de 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -86,13 +86,7 @@ test_expect_success 'setup hunk header tests' '
 # check each individual file
 for i in $(git ls-files)
 do
-	if grep broken "$i" >/dev/null 2>&1
-	then
-		result=failure
-	else
-		result=success
-	fi
-	test_expect_$result "hunk header: $i" "
+	test_expect_success "hunk header: $i" "
 		git diff -U1 $i >actual &&
 		grep '@@ .* @@.*RIGHT' actual
 	"
diff --git a/t/t4018/README b/t/t4018/README
index 283e01cca1a..2d25b2b4fc9 100644
--- a/t/t4018/README
+++ b/t/t4018/README
@@ -7,9 +7,6 @@ at least two lines from the line that must appear in the hunk header.
 The text that must appear in the hunk header must contain the word
 "right", but in all upper-case, like in the title above.
 
-To mark a test case that highlights a malfunction, insert the word
-BROKEN in all lower-case somewhere in the file.
-
 This text is a bit twisted and out of order, but it is itself a
 test case for the default hunk header pattern. Know what you are doing
 if you change it.
-- 
2.31.0.366.ga80606b22c1

