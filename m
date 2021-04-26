Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE465C433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DBB96115C
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbhDZQV3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbhDZQV1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:21:27 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F894C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:20:46 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso50721843otb.13
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R/TvVZKpQvdPHiHieOqBXvy/cQQ9HTuFFVCq3/qawCI=;
        b=ZBImQt+P0/UyMZA20R37UkljdxdaqX4SMxI1Sy+Z2jRTNUtOo595VJBcmBAO0zuh6t
         oKLcUipGPzRhQ6ieC/fLJ4be0VYrx+Q4kGKbiXxRqWY/ru9F9TF4jqZ5QiLq1axDg5bW
         jqZboaPHMSSlJknTZ3gFmpn9YPPGZVMNUCe26Vz5n7tnnNy0I+Hposg5B5ZHZ0lmV9si
         63nxCiItrspJZ7SB6gHchH/QRXiAWIHG6LWT6CZLTG7hnTHJDt72+AddGHNeIzxMbxTW
         SEylFB2NSH3aqADB0qWI9ktRGWB/o6FxrDjZbH2Oa4OYM6Ja68vpvFkpBqAZ+1mOHqi3
         W69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R/TvVZKpQvdPHiHieOqBXvy/cQQ9HTuFFVCq3/qawCI=;
        b=dBDV7IoWBgRxPClSa+d0njBj/hBjytx4T4vRcJ2/AVIFvAS65fchUTvTrdzLfrf0uF
         9pfJTxMcJ5MqMPBpag3iTCN3fau3fU22hNhXlpkRfaVhpJIG4tRtsSbXYTiXr6yWrOA8
         wh3cvDJJ5iizu7iVGUCY/dxTvO1lf3CsYLclauoqbfPiihWbmUXAIvoI7rSs5z9PHCLz
         GbmuXcAThxO6QpYYElnvUisaBEBr9X2vT1uwiO09rmjBqp51YEJ5nigNeWYsWMpyM5I2
         a3u/k+rNh07dDebOrW75DWfW7aW9NbGVi/LRQ5mu3EEZfwroXnowNZ11VFtVx/ge2Y66
         PumA==
X-Gm-Message-State: AOAM531ghM9VoaqWTA7jvHSMsBjFplF4Xr+LEXAktRTQTUIDidLGHZ1r
        7RDeiO1xgX9adDXF21REyFBWP9jA3KdQrQ==
X-Google-Smtp-Source: ABdhPJyJb6LOG8yB2PWkag81ye+mQXyJuosMFA7qfwIXuDkiKtAPw3RpYY04YhkK1pfeoqC5QqUnSg==
X-Received: by 2002:a9d:342:: with SMTP id 60mr15406277otv.295.1619454045567;
        Mon, 26 Apr 2021 09:20:45 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id j8sm3702895otj.49.2021.04.26.09.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:20:45 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 38/43] completion: bash: simplify _get_comp_words_by_ref()
Date:   Mon, 26 Apr 2021 11:14:53 -0500
Message-Id: <20210426161458.49860-39-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't need the whole functionality of _get_comp_words_by_ref(), we
know exactly what we need from that function, so only do that.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 30 ++++++--------------------
 t/t9902-completion.sh                  | 21 ++++--------------
 2 files changed, 10 insertions(+), 41 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d760434c0c..cbea35441c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -408,30 +408,12 @@ __git_reassemble_comp_words_by_ref()
 if ! type _get_comp_words_by_ref >/dev/null 2>&1; then
 _get_comp_words_by_ref ()
 {
-	local exclude cur_ words_ cword_
-	if [ "$1" = "-n" ]; then
-		exclude=$2
-		shift 2
-	fi
-	__git_reassemble_comp_words_by_ref "$exclude"
-	cur_=${words_[cword_]}
-	while [ $# -gt 0 ]; do
-		case "$1" in
-		cur)
-			cur=$cur_
-			;;
-		prev)
-			prev=${words_[$cword_-1]}
-			;;
-		words)
-			words=("${words_[@]}")
-			;;
-		cword)
-			cword=$cword_
-			;;
-		esac
-		shift
-	done
+	local words_ cword_
+	__git_reassemble_comp_words_by_ref "=:"
+	cword=$cword_
+	cur=${words_[cword]}
+	prev=${words_[cword-1]}
+	words=("${words_[@]}")
 }
 fi
 
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 205083184a..dfa2cb3b21 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -43,23 +43,10 @@ GIT_TESTING_PORCELAIN_COMMAND_LIST='add checkout rebase'
 # So let's override it with a minimal version for testing purposes.
 _get_comp_words_by_ref ()
 {
-	while [ $# -gt 0 ]; do
-		case "$1" in
-		cur)
-			cur=${_words[_cword]}
-			;;
-		prev)
-			prev=${_words[_cword-1]}
-			;;
-		words)
-			words=("${_words[@]}")
-			;;
-		cword)
-			cword=$_cword
-			;;
-		esac
-		shift
-	done
+	cword=$_cword
+	cur=${_words[cword]}
+	prev=${_words[cword-1]}
+	words=("${_words[@]}")
 }
 
 print_comp ()
-- 
2.31.0

