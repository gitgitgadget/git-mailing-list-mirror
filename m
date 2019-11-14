Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C0CD1F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 16:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfKNQf4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 11:35:56 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42213 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfKNQfz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 11:35:55 -0500
Received: by mail-wr1-f67.google.com with SMTP id a15so7205056wrf.9
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 08:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Xfw6NIVm7XcexxZzOvAmBleqLry/YbbhNL0p4h8jcNo=;
        b=FAm9ko/gcN1vBmrUH6P0zVeLxjRs/r+It7PdGccKpiU8s5ImLQ2z4nUqRkbaKo5bCX
         +1/xuhIdkdItdpJUURHLrVBG1tieFx1/GVkXo1YLLeNKYfHUMu3imbMgnNOT6VAv9bVF
         6dRZROQFALy9T3A2R96HPapKsHY3gDaLMqJpKBs8NEAIqRDCHeZxT//4AZwRQpTdL5qx
         3cqIATL+o8TW8XaEF8VB1ZJu71S7PjfYOdykj7wcnCRV1gadfkWNYBGhsvE36jTLRq3b
         ZDIPrqMbCu6hF6Wo98bBx7JvqTTcPPf5ZxJ9R56niEZSz1E7wbIL+HqCOSu354AyWKvg
         p6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xfw6NIVm7XcexxZzOvAmBleqLry/YbbhNL0p4h8jcNo=;
        b=d7VsSw7qmeleVfydZeTNQ0hNSIpckF7k4t3prHxI0hLCyks8UdA+xMV5Ih1ru1wfQP
         CnsgUqjl4KkUON0XM7i+gIK8+EgqtKmT4q3OLgoOtDm+mKwzTeajQPm2jDMgrFl08z0l
         rqoVgA1ciofXRArday9KfB/52ails4xz9oDxSV5VtRoyqFJhJqlgbmINM90V9oCtbfse
         mRNL3VEbxrjv19KtlSTBNdo2MfnmjWafB1DD3VqeO64LT5SngZKhEWQ47UzAG0wajhyj
         oJ7gkxWCC1juf9hLNAKn6cJk2qFVnL/F10GjhTh+p9PsyLIXaq1aYQsV5SkiU90KDWrd
         VtCw==
X-Gm-Message-State: APjAAAWeY+x0VeIGoHhsxyWHVSFqtodj2R4AS7eD5X79rUG4TX/nFBiN
        Jnm9e1woxAHqB54b3TfwvyEc+28Vtjw=
X-Google-Smtp-Source: APXvYqxZFGxX7AmTFAqDJQaobQNTQw/pPQ9YYC+t1sq9f6o6Zw9TLHgEYLkkjMAEPYpZPiB98serFg==
X-Received: by 2002:a5d:4608:: with SMTP id t8mr9361723wrq.91.1573749353701;
        Thu, 14 Nov 2019 08:35:53 -0800 (PST)
Received: from rybak.office.devexperts.com ([185.79.217.61])
        by smtp.googlemail.com with ESMTPSA id h124sm7429008wme.30.2019.11.14.08.35.52
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 08:35:52 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/3] rebase: extract add_exec()
Date:   Thu, 14 Nov 2019 17:35:48 +0100
Message-Id: <20191114163549.7648-3-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.24.0.windows.2
In-Reply-To: <20191114163549.7648-1-rybak.a.v@gmail.com>
References: <20191114163549.7648-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In following commit addition of commands to the todo file will be
implemented for the --edit-todo action.  So extract a function to avoid
duplicating the code for splitting of opts->cmd into list of commands.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 builtin/rebase.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 9457912f9d..27507d3cf6 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -299,6 +299,17 @@ static void split_exec_commands(const char *cmd, struct string_list *commands)
 	}
 }
 
+static int add_exec(const char *cmd)
+{
+	struct string_list commands = STRING_LIST_INIT_DUP;
+	int ret;
+
+	split_exec_commands(cmd, &commands);
+	ret = add_exec_commands(&commands);
+	string_list_clear(&commands, 0);
+	return ret;
+}
+
 static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 {
 	int ret;
@@ -420,11 +431,7 @@ static int run_rebase_interactive(struct rebase_options *opts,
 		ret = rearrange_squash_in_todo_file();
 		break;
 	case ACTION_ADD_EXEC: {
-		struct string_list commands = STRING_LIST_INIT_DUP;
-
-		split_exec_commands(opts->cmd, &commands);
-		ret = add_exec_commands(&commands);
-		string_list_clear(&commands, 0);
+		ret = add_exec(opts->cmd);
 		break;
 	}
 	default:
-- 
2.24.0.windows.2

