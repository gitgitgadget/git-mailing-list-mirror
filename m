Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952FFC433E1
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 14:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72B1520702
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 14:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdRqz7MN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403814AbgFXOqn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391165AbgFXOql (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 10:46:41 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4147C0613ED
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 07:46:40 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f139so2783836wmf.5
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 07:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/RkcaLH+FOI7K3NGSfKesvnyE2JyBJA3eXSOgEW0Wqw=;
        b=qdRqz7MNQZ7+YopdNJNCYiFYGgbJIAKnP7OKWH5QTEFi/MrCbJX7y5xCNlNO7/vOyD
         Y5VOe5C0u2F38Shlw5TA/f3wbTvYxzlVTzx6SP26WAYg35KighoiM4Ha22xB6WfculfM
         gKVPmaZuCKLnmrMubl5/ioaFqiApMbcoVpQHySiMagO9VMIV/FG0i4dOTxRJWqMjlO+f
         kNeAsmM8NG7JkEXhLw97Ev/9sI55nWCmb1nm3LQh4jE+GAGSxzuQ4AYeB5dwxf9cxnfa
         RfLw4j9RrOOodUKrrYlrr9IOqfv2HqGE2zprtOuV4y9pBSkxYA1JosREzZIqu8vKxSb3
         V8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/RkcaLH+FOI7K3NGSfKesvnyE2JyBJA3eXSOgEW0Wqw=;
        b=ejtJ1Ml5h9ZTIdBe5SjwiBTYldZIHqklpx4orkS7fDbPOVFOOKUiCQZJk0Xc4pnYo8
         U258V0/zvc1aP/x8ymRDz6OdxYFwyt9Hl3b8MsxI6YQ8FT+VR0qw8U1hZT3rNqbXxOa5
         LXe/rgXZ0J+o3W8K3odSUSnaSVXyfDFsQG4ulceKaqNHGCaQRcbcj++V+pLvL0X9TAEz
         kj0JrBQcw6uAxQ8aeuC3Ebvl9R4QRFqRcJ2dqPfiDaH5KZiCnwy2JbcjPgBQraPmPivL
         KKiEmzopaxczagYcsgy3/w6iQL6wIIOjQ0OR5Wn9jXtRglRS0ELtJVq4eeqOGIVtbzOP
         PM5g==
X-Gm-Message-State: AOAM532ZegGDqIFMGenC1y/pO2erVtiRdnr3pW/PpqJ1oJOY2f399UHE
        T4KelISRtaY2DnpPQQI85cQxfs43hlo=
X-Google-Smtp-Source: ABdhPJww2LR2/PavUt08r0DLaC6U67+FQ2Gnr++qHtcmYiMAh4NyvtXKf0Oe9cEzyi9jcvkcK/zcNQ==
X-Received: by 2002:a7b:c5c1:: with SMTP id n1mr29753915wmk.21.1593009999495;
        Wed, 24 Jun 2020 07:46:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 65sm7821931wma.48.2020.06.24.07.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 07:46:39 -0700 (PDT)
Message-Id: <1216de51abee7f5614c4d639e42fce3308100830.1593009996.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.v4.git.1593009996.gitgitgadget@gmail.com>
References: <pull.656.v3.git.1592951611.gitgitgadget@gmail.com>
        <pull.656.v4.git.1593009996.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 24 Jun 2020 14:46:29 +0000
Subject: [PATCH v4 2/9] send-pack/transport-helper: avoid mentioning a
 particular branch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     don@goodman-wilson.com, stolee@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When trying to push all matching branches, but none match, we offer a
message suggesting to push the `master` branch.

However, we want to step away from making that branch any more special
than any other branch, so let's reword that message to mention no branch
in particular.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 send-pack.c             | 2 +-
 t/t5528-push-default.sh | 6 ++++++
 transport-helper.c      | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 0abee22283..19eb9b04e4 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -406,7 +406,7 @@ int send_pack(struct send_pack_args *args,
 
 	if (!remote_refs) {
 		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
-			"Perhaps you should specify a branch such as 'master'.\n");
+			"Perhaps you should specify a branch.\n");
 		return 0;
 	}
 	if (args->atomic && !atomic_supported)
diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index 4d1e0c363e..f0a287d97d 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -98,6 +98,12 @@ test_expect_success 'push from/to new branch with upstream, matching and simple'
 	test_push_failure upstream
 '
 
+test_expect_success '"matching" fails if none match' '
+	git init --bare empty &&
+	test_must_fail git push empty : 2>actual &&
+	test_i18ngrep "Perhaps you should specify a branch" actual
+'
+
 test_expect_success 'push ambiguously named branch with upstream, matching and simple' '
 	git checkout -b ambiguous &&
 	test_config branch.ambiguous.remote parent1 &&
diff --git a/transport-helper.c b/transport-helper.c
index a46afcb69d..8a711cda29 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1046,7 +1046,7 @@ static int push_refs(struct transport *transport,
 	if (!remote_refs) {
 		fprintf(stderr,
 			_("No refs in common and none specified; doing nothing.\n"
-			  "Perhaps you should specify a branch such as 'master'.\n"));
+			  "Perhaps you should specify a branch.\n"));
 		return 0;
 	}
 
-- 
gitgitgadget

