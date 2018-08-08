Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17710208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbeHHRnQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:43:16 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33109 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeHHRnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:43:16 -0400
Received: by mail-ed1-f68.google.com with SMTP id x5-v6so1470469edr.0
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HYLW1kcCasA+idvpZVC/ml6X5Kk4b+uMW3wjmxiOuPI=;
        b=lWbVInep00S4ISw86fvP2sHWtX5aqvlNlagfQ8l+8n/CnE1+B2ck7cjbRQGkNhsJ7C
         TsIAtv9rhldqoViSQFzu+wd7hBLLYHcqEEHiRCzBDKrzkd8346H3VQHJbLOkQVLZXF4F
         n2Hoa/af34s8Lb1V65gAARma0Q757aq+leOXcloPycNj2hjwSYdz0YOnLe8AN6KPowZs
         oy8c6w7wj7geJCfFyISRaT4S+aPW3aBAXfSBMTTDqvn+ogat87YZ06UK9om+qmwKO6z/
         n3MliLrPA69PRpS7fQEbirxq8NsPs+4dRbZ0cRjGEYEL23B6TVDHOfm6EuYUDIv1ghsg
         P32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HYLW1kcCasA+idvpZVC/ml6X5Kk4b+uMW3wjmxiOuPI=;
        b=cgQyZwfSwfcOhpqCVIq3SVdxSgWR4UW/Mgix47Bw8KIOVX3O+0BU+q/NI6NtgA9ZIW
         It7CQMO0aXg3DhWkuJTaXLENRUGHqkp1M2iEH//VwPlfypf25qWttANbgQx+h0ZvlDRr
         ZkTaD/lT0XtxDSrk4TRSDd/v0IwLDI/dDesw2QTzSt4xVHVzA9gKLNTSt2UPhwdroHW+
         ATjIKRIw3YZOpnOZ6CRhVwzYONxX4MvwCOTeFR51ch5cq+d4Cg7Bhwr7J07Svna2JcZG
         X/mpsu5/fcfYcy7wsA8Q4R+W8RlopctyQj5jOS4fn2nr2aVAmby/a3B2FM6H/46GWFEY
         bJRw==
X-Gm-Message-State: AOUpUlGBvi0Eaqh3F69s1iFGC1wdflSaOB9wjT5LlWFockquJ9LKIZYC
        GvydJPrUU+0S8Tw7MhK+W4w7gdpM
X-Google-Smtp-Source: AA+uWPz7uPigtRvVJ7zi5wylV2R5/5XSfjMo1oYNaH5vAG9jYKzs0RUwvgiXc9peZwQ50jpIbafZtw==
X-Received: by 2002:aa7:d2cd:: with SMTP id k13-v6mr3872358edr.311.1533741786999;
        Wed, 08 Aug 2018 08:23:06 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id v56-v6sm6058572edm.97.2018.08.08.08.23.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:23:06 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 08/18] builtin rebase: support `--autosquash`
Date:   Wed,  8 Aug 2018 21:06:30 +0545
Message-Id: <20180808152140.14585-9-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808152140.14585-1-predatoramigo@gmail.com>
References: <20180808152140.14585-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit adds support for the `--autosquash` option which is used to
automatically squash the commits marked as `squash` or `fixup` in their
messages. This is converted following `git-legacy-rebase.sh` closely.

This option can also be configured via the Git config setting
rebase.autosquash. To support this, we also add a custom
rebase_config() function in this commit that will be used instead (and
falls back to) git_default_config().

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index fd9ad8efae..79ba65fd75 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -96,6 +96,7 @@ struct rebase_options {
 	int signoff;
 	int allow_rerere_autoupdate;
 	int keep_empty;
+	int autosquash;
 };
 
 static int is_interactive(struct rebase_options *opts)
@@ -295,6 +296,7 @@ static int run_specific_rebase(struct rebase_options *opts)
 		opts->allow_rerere_autoupdate ?
 		"--rerere-autoupdate" : "--no-rerere-autoupdate");
 	add_var(&script_snippet, "keep_empty", opts->keep_empty ? "yes" : "");
+	add_var(&script_snippet, "autosquash", opts->autosquash ? "t" : "");
 
 	switch (opts->type) {
 	case REBASE_AM:
@@ -455,6 +457,11 @@ static int rebase_config(const char *var, const char *value, void *data)
 		return 0;
 	}
 
+	if (!strcmp(var, "rebase.autosquash")) {
+		opts->autosquash = git_config_bool(var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value, data);
 }
 
@@ -609,6 +616,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			    "conflict")),
 		OPT_BOOL(0, "keep-empty", &options.keep_empty,
 			 N_("preserve empty commits during rebase")),
+		OPT_BOOL(0, "autosquash", &options.autosquash,
+			 N_("move commits that begin with "
+			    "squash!/fixup! under -i")),
 		OPT_END(),
 	};
 
-- 
2.18.0

