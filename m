Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D766C433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 12:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22A6B206DA
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 12:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHNnncat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbgHSMwt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbgHSMwl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 08:52:41 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8CEC061342
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 05:52:38 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k8so2087231wma.2
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 05:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dhSXO96eNbE8BNCNl6hYMwdun53Sh6Cltd2mM1S05F4=;
        b=jHNnncatIW1p5/JMG3D+vbeYUG7pXeC+zXE/Ui5JLNay+MpC/+CENG221xmXuoQExG
         TPymoQFMC7xc8EXTDIXoSKzVF522Rq8BkdT1+rXbs1gnBxH/4cAfwIlewrf46UlbnDZH
         Oo2lEyYGV5UHs2Wr6R1EA0WeXmO8XP7xERoF17O0qX1OKRTf2sGe7EVBr/hpFMA8MMDc
         UMvaiP0ZPAjjGWbe+XdOFvA8caSFsgqdkJTp3lvug82Q8XXxueJ0lnY6o4zNTg2stZVS
         XUqvUV79xcRiVhX5H+3NNOrF3ULtXvX0gC77R8avMfYDqPXA2aHW95fdipWU8gvD7Mkx
         yBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dhSXO96eNbE8BNCNl6hYMwdun53Sh6Cltd2mM1S05F4=;
        b=OU4YFOJ/DZpW+0ukI5mKt7uYRTr68ZlBI5YdBAlhuWxiKPIQfT+5r/vlt9kmTpWkvh
         dXinDdFlODPhJOAIVAX5J6Y9akr2i7VjQmgMlOKvJlaHJOt4GfreUw/u0cNBOGO+Nuuy
         sDtX+zkl8C6+y6XcE9WGMpY/3oCJFmV7C4+skkkQ3CT78k+KF0KWFfWSEqh036jmzWBD
         12u+DE1YqVZgc32vWjtgGQiteZAund/4pUdiVkBKq+ee+rgZ0usKdaY4hnNHqa6KiA6+
         kO0MLVtpakmFYnxFZtQWQcNezRycOEqWN6+HpureCdXK2SDJkaSKpKJaACvrMxvCb018
         SaIw==
X-Gm-Message-State: AOAM533wKIm7QwhCaPYQJuae+TY18j/RNClXfKX2V+KEAkoG05ixcqQN
        a6TaSO66j2ffObVaWwoQtsZlapi0Rcs=
X-Google-Smtp-Source: ABdhPJys1s/+MwBzQrU5z1ZeK1MQsD4pSB5zqCoWS1igZzSkuMXSf+AMWDQrYiZ9wrGXE1JHiayMwQ==
X-Received: by 2002:a1c:f70a:: with SMTP id v10mr4797866wmh.39.1597841556554;
        Wed, 19 Aug 2020 05:52:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 6sm5481005wmf.4.2020.08.19.05.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 05:52:34 -0700 (PDT)
Message-Id: <7daf9335a501b99c29e299f72823fcb7e549e748.1597841551.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.707.git.1597841551.gitgitgadget@gmail.com>
References: <pull.707.git.1597841551.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 Aug 2020 12:52:31 +0000
Subject: [PATCH 2/2] ref-filter: 'contents:trailers' show error if `:` is
 missing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Hariom Verma <hariom18599@gmail.com>

The 'contents' atom does not show any error if used with 'trailers'
atom and semicolon is missing before trailers arguments.

e.g %(contents:trailersonly) works, while it shouldn't.

It is definitely not an expected behavior.

Let's fix this bug.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 ref-filter.c            | 21 ++++++++++++++++++---
 t/t6300-for-each-ref.sh |  9 +++++++++
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index ba85869755..dc31fbbe51 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -332,6 +332,22 @@ static int trailers_atom_parser(const struct ref_format *format, struct used_ato
 	return 0;
 }
 
+static int check_format_field(const char *arg, const char *field, const char **option)
+{
+	const char *opt;
+	if (skip_prefix(arg, field, &opt)) {
+		if (*opt == '\0') {
+			*option = NULL;
+			return 1;
+		}
+		else if (*opt == ':') {
+			*option = ++opt;
+			return 1;
+		}
+	}
+	return 0;
+}
+
 static int contents_atom_parser(const struct ref_format *format, struct used_atom *atom,
 				const char *arg, struct strbuf *err)
 {
@@ -345,9 +361,8 @@ static int contents_atom_parser(const struct ref_format *format, struct used_ato
 		atom->u.contents.option = C_SIG;
 	else if (!strcmp(arg, "subject"))
 		atom->u.contents.option = C_SUB;
-	else if (skip_prefix(arg, "trailers", &arg)) {
-		skip_prefix(arg, ":", &arg);
-		if (trailers_atom_parser(format, atom, *arg ? arg : NULL, err))
+	else if (check_format_field(arg, "trailers", &arg)) {
+		if (trailers_atom_parser(format, atom, arg, err))
 			return -1;
 	} else if (skip_prefix(arg, "lines=", &arg)) {
 		atom->u.contents.option = C_LINES;
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 495848c881..cb1508cef5 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -823,6 +823,15 @@ test_expect_success '%(trailers) rejects unknown trailers arguments' '
 	test_i18ncmp expect actual
 '
 
+test_expect_success 'if arguments, %(contents:trailers) shows error if semicolon is missing' '
+	# error message cannot be checked under i18n
+	cat >expect <<-EOF &&
+	fatal: unrecognized %(contents) argument: trailersonly
+	EOF
+	test_must_fail git for-each-ref --format="%(contents:trailersonly)" 2>actual &&
+	test_i18ncmp expect actual
+'
+
 test_expect_success 'basic atom: head contents:trailers' '
 	git for-each-ref --format="%(contents:trailers)" refs/heads/master >actual &&
 	sanitize_pgp <actual >actual.clean &&
-- 
gitgitgadget
