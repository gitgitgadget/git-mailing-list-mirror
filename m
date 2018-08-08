Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A49E5208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeHHRm5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:42:57 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39638 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeHHRm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:42:57 -0400
Received: by mail-ed1-f68.google.com with SMTP id h4-v6so1448178edi.6
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ndIy9Akn3CmevbDrJg7WdrgVTxVYicfK+cIYxy5LHks=;
        b=u/HKgTXo0xf6ygEcJWdljBMsyxBks+HVKfDn8r4s0M8DAGS1g0PoSMDTmibPOd/9pT
         062dwJgMXs/ozHCbK2MPaF1FBtCRR3SisgS/Aj8ozOMcUUickhoGqmDY3+arGIWfqYO3
         X6AvMOyjE/V+xGH95F7Ag9Gt2quCNXVNSlDEVAXgbG7LKzpbNiYGfOKwfhj5QAZxOr8j
         J+j9RbavuvlBN2i2bSQ/dDeqPcOQXh/MikqRlc1FUvFRMBXgULqUJfOMtxLQca103xN/
         phqsIXtRp0oq/URXheFHnKxMKlBfiWaw7IvJhI1T2tlxL6e+FXiEq5WAYjAgga4tKwGL
         kxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ndIy9Akn3CmevbDrJg7WdrgVTxVYicfK+cIYxy5LHks=;
        b=nmBqPyoIIc7i6W2k/7h5uvfaf11Ju44O2Q9qY2XOXJgYdUx1QjvMo99u6xXQxQLvcl
         dsFtOkbaoK4GfJ6hvXVi2+pJGq9yi1DLi7hXUt4r3/W6Oo0MjmCJTNz2rEGTLquYLOlm
         Fhe1HVtlGt3IxcYWLR5uQUb8Cw/gZhyWgAsv7Lqlfk/M3z/FYjrXMI3L+g2sDR0SDS2h
         5GDH+QiRqlyCP4cWUZkxnkbdpp2TA6OC4mpjlw7bg9dg+AZifoQ4ne/uw5TxDIy3BWVL
         vPMTl4wdNhOHA2Ol3JZgPWMyGD0hN21mUdoTVM2/xMo25SrcvV6JNJ4A91xomQGMX08W
         KPmA==
X-Gm-Message-State: AOUpUlE4nYq2XyxyBjd/Q23W/QitAfoV+NUBR0UpxuRLqJUUDRujKwfG
        55aGukJnVOCyqbqXJwb5CpbRLy9l
X-Google-Smtp-Source: AA+uWPxjrsF7jsBGXCrfzxkONW1N7uZ9rbQu+FGaWSvCKf8VC/GQSo5KmaBuX0dTcQPhTENUsVAsvA==
X-Received: by 2002:a50:f31a:: with SMTP id p26-v6mr3880571edm.68.1533741768496;
        Wed, 08 Aug 2018 08:22:48 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id v56-v6sm6058572edm.97.2018.08.08.08.22.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:22:47 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 03/18] builtin rebase: support --rerere-autoupdate
Date:   Wed,  8 Aug 2018 21:06:25 +0545
Message-Id: <20180808152140.14585-4-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808152140.14585-1-predatoramigo@gmail.com>
References: <20180808152140.14585-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `--rerere-autoupdate` option allows rerere to update the index with
resolved conflicts. This commit follows closely the equivalent part of
`git-legacy-rebase.sh`.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index a491481120..1729d2d9e2 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -94,6 +94,7 @@ struct rebase_options {
 	struct strbuf git_am_opt;
 	const char *action;
 	int signoff;
+	int allow_rerere_autoupdate;
 };
 
 static int is_interactive(struct rebase_options *opts)
@@ -174,6 +175,21 @@ static int read_basic_state(struct rebase_options *opts)
 		opts->flags |= REBASE_FORCE;
 	}
 
+	if (file_exists(state_dir_path("allow_rerere_autoupdate", opts))) {
+		strbuf_reset(&buf);
+		if (read_one(state_dir_path("allow_rerere_autoupdate", opts),
+			    &buf))
+			return -1;
+		if (!strcmp(buf.buf, "--rerere-autoupdate"))
+			opts->allow_rerere_autoupdate = 1;
+		else if (!strcmp(buf.buf, "--no-rerere-autoupdate"))
+			opts->allow_rerere_autoupdate = 0;
+		else
+			warning(_("ignoring invalid allow_rerere_autoupdate: "
+				  "'%s'"), buf.buf);
+	} else
+		opts->allow_rerere_autoupdate = -1;
+
 	strbuf_release(&buf);
 
 	return 0;
@@ -256,6 +272,10 @@ static int run_specific_rebase(struct rebase_options *opts)
 		add_var(&script_snippet, "switch_to", opts->switch_to);
 	add_var(&script_snippet, "action", opts->action ? opts->action : "");
 	add_var(&script_snippet, "signoff", opts->signoff ? "--signoff" : "");
+	add_var(&script_snippet, "allow_rerere_autoupdate",
+		opts->allow_rerere_autoupdate < 0 ? "" :
+		opts->allow_rerere_autoupdate ?
+		"--rerere-autoupdate" : "--no-rerere-autoupdate");
 
 	switch (opts->type) {
 	case REBASE_AM:
@@ -488,6 +508,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		.type = REBASE_UNSPECIFIED,
 		.flags = REBASE_NO_QUIET,
 		.git_am_opt = STRBUF_INIT,
+		.allow_rerere_autoupdate  = -1,
 	};
 	const char *branch_name;
 	int ret, flags, total_argc, in_progress = 0;
@@ -553,6 +574,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT('p', "preserve-merges", &options.type,
 			    N_("try to recreate merges instead of ignoring "
 			       "them"), REBASE_PRESERVE_MERGES),
+		OPT_BOOL(0, "rerere-autoupdate",
+			 &options.allow_rerere_autoupdate,
+			 N_("allow rerere to update index  with resolved "
+			    "conflict")),
 		OPT_END(),
 	};
 
-- 
2.18.0

