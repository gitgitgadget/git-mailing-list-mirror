Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00F301F597
	for <e@80x24.org>; Mon, 30 Jul 2018 23:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbeGaAmG (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 20:42:06 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:36572 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbeGaAmG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 20:42:06 -0400
Received: by mail-io0-f201.google.com with SMTP id y13-v6so10008173iop.3
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 16:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=SiJZ8fcd0KgoL+k2XgUqb/JjOpFgfgShV6hKCNGoRP8=;
        b=FoQayFBYDElWInkvlN2QZHQADMFWOyUvEstNdPr+rsehO4EMcVsNXMGFttSJ1F/v5s
         1ebWU1ivzPyobeZZ2E0EBuCVjRIILi2Cq2rL0Vs/LJkx45mEFTfphemWN/imEzxaiVlY
         o8+Jsp17Cl6/3hZeDDrrjxwhYl2TLxmm5VIsIYNMkxaLXCdf/Vckh2iZw2hwYiaIij3i
         O4yBof3Jd7BrYMrPVA04AdStyoQ521CFOtbRL7QnbSpiFRCJk3ZkCo0d5KkySnj5blOn
         Inek3RigUgYaQVrtaaj2w90l4Jbkc8WAmyBmSAKz4I3UMvC14mBKq0ZE3Yffeh94/ICZ
         6fqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=SiJZ8fcd0KgoL+k2XgUqb/JjOpFgfgShV6hKCNGoRP8=;
        b=Hgi6oaWUTUM3w8W86VP8xK8lDyfj/um9TsGlKcfLyzpSwCqpC0XbUkyOaGJ7VzyPTG
         +6eXRmeZ3sZ7IeW0DSz3n4TX8ICtnaTGFB1zaqPZzH634GGpAg+kju4/NyutBtAECy6A
         YQf3MeQYjrNyX8My3jP2eOJ6k2Okst11j17g7IBFZ2qiikzE3HDPeaV2HFkjFyZ3uKnl
         1vr6ky9QMsf7dJnR18B9ta21SwuS9cB+p0o4zz9aQmlsCn8go/lnSPTNYbIrzLGGeeZQ
         He0WZrUzFB5xt2aTmrwY5A+BxN8UqVeyFHV0Qay/acNPhOfpR7+H/ZLDjfwzNGLzh9v0
         yXXw==
X-Gm-Message-State: AOUpUlGaFT7Z8y6gNHT1xpgaUBxULhG+p1FY22m1s5vD0ccb1WNgeyhg
        0/d4ND/TESylfD+zVmGjPix61lgspkXy
X-Google-Smtp-Source: AAOMgpenaCWT7jWF7gm9FFOOT3vakoAMv4YHAjQX41DwnPS3abFxeOHnfVoKqERs/6Opr3k9X/8AKyCFOiUC
MIME-Version: 1.0
X-Received: by 2002:a6b:3384:: with SMTP id z126-v6mr7499231ioz.61.1532991891752;
 Mon, 30 Jul 2018 16:04:51 -0700 (PDT)
Date:   Mon, 30 Jul 2018 16:04:42 -0700
In-Reply-To: <20180730230443.74416-1-sbeller@google.com>
Message-Id: <20180730230443.74416-3-sbeller@google.com>
References: <nycvar.QRO.7.76.6.1807301438440.10478@tvgsbejvaqbjf.bet> <20180730230443.74416-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.132.g195c49a2227
Subject: [PATCH 2/3] config: fix case sensitive subsection names on writing
From:   Stefan Beller <sbeller@google.com>
To:     johannes.schindelin@gmx.de
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        peff@google.com, sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A use reported a submodule issue regarding strange case indentation
issues, but it could be boiled down to the following test case:

  $ git init test  && cd test
  $ git config foo."Bar".key test
  $ git config foo."bar".key test
  $ tail -n 3 .git/config
  [foo "Bar"]
        key = test
        key = test

Sub sections are case sensitive and we have a test for correctly reading
them. However we do not have a test for writing out config correctly with
case sensitive subsection names, which is why this went unnoticed in
6ae996f2acf (git_config_set: make use of the config parser's event
stream, 2018-04-09)

Make the subsection case sensitive and provide a test for writing.
The test for reading is just above this test.

Reported-by: JP Sugarbroad <jpsugar@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 config.c          | 2 +-
 t/t1300-config.sh | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 7968ef7566a..de646d2c56f 100644
--- a/config.c
+++ b/config.c
@@ -2362,7 +2362,7 @@ static int store_aux_event(enum config_event_t type,
 		store->is_keys_section =
 			store->parsed[store->parsed_nr].is_keys_section =
 			cf->var.len - 1 == store->baselen &&
-			!strncasecmp(cf->var.buf, store->key, store->baselen);
+			!strncmp(cf->var.buf, store->key, store->baselen);
 		if (store->is_keys_section) {
 			store->section_seen = 1;
 			ALLOC_GROW(store->seen, store->seen_nr + 1,
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index ced13012409..e5d16f53ee1 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1250,6 +1250,7 @@ test_expect_success 'old-fashioned settings are case insensitive' '
 	q_to_tab >testConfig_expect <<-EOF &&
 		[V.A]
 		r = value1
+		[V "A"]
 		Qr = value2
 	EOF
 	git config -f testConfig_actual "V.A.r" value2 &&
@@ -1262,6 +1263,7 @@ test_expect_success 'old-fashioned settings are case insensitive' '
 	q_to_tab >testConfig_expect <<-EOF &&
 		[V.A]
 		r = value1
+		[v "A"]
 		Qr = value2
 	EOF
 	git config -f testConfig_actual "v.A.r" value2 &&
@@ -1290,6 +1292,7 @@ test_expect_success 'setting different case sensitive subsections ' '
 		Qc = v2
 		[d "e"]
 		f = v1
+		[d "E"]
 		Qf = v2
 	EOF
 	# exact match
-- 
2.18.0.132.g195c49a2227

