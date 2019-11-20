Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00E6C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 09:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7684C21939
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 09:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOY11bzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbfKTJwu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 04:52:50 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53663 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbfKTJwt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 04:52:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id u18so6290527wmc.3
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 01:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HNgCrFw9kp26NWP0uyvYwapf2hNA+t6o/nPPGrwNz6E=;
        b=BOY11bzEg0IdkCeidcmMRJZmNryKdYDwGBw8SPS1w//EKdz416a9Dzc5sF5qOmYkdG
         AFjQVPjbvnNCIdIkQfdqYsaM+EcCtRU/gzBVIMDeahdIqJUZQ234ON6LZtbTitMlxytH
         1XdsjC/+jVFuOydIL+ciY8aK3uXBJAZxEZ0Et5lgNDb0XdkXDYer2vAkq6ooPbsSra4E
         UcfcfIhwb6VUYcBoG/gMfx0AxVuidjmKBMYcSHNUjKNPrXMF+kinwZGNK0Er6ctyWNRu
         W60L9Z17bOMG5lKIpgEFsAjVqfwuiEDCEiM2gkr3NziyYYS0K4ktN+B+toc1gZonPfXa
         cZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HNgCrFw9kp26NWP0uyvYwapf2hNA+t6o/nPPGrwNz6E=;
        b=UL/mrmbDM6/cNycc3lhr4s0ctfioxxnyhuMDxumQGzuI8waUi3IHwc9OI9RU3MHmMf
         3WaTEfUwLwmttlKihM8rRfKA6o2/4/qhrnfPE9eppKmrRhbMXAbuhmwgF8uB1tfxz5y+
         cxXJ/8mIit9f/b5BLR5ZlI0+s9wpma3tB7CwwGjsbSNksnFrN8TLXKs20QBpXtFL7ZRm
         OlbLALx135uuyugJC1OY+7HOCnpWT+Tuaqnzj3ZYkO2GSqSXf/Oj3H88UaP0MVOC+BnT
         /hzqwL8PEi8tKITJ2aP8UGDPhBL4rilusWK6+gQe68IcN801Foa9xkrpLIDVAfrWGdfm
         Pdng==
X-Gm-Message-State: APjAAAX80Q7ph9vDp/KxexF+E425FF3l2QeqCHrtsgZq6JVGHRkJOaiG
        lPNvN+ULFVOfn4Du/CTFfsjZNVVpqZXNgA==
X-Google-Smtp-Source: APXvYqwHfr1cuROydjGUamhWohnhMbjfZwm1BSTeLw0zhXB7YveKDmMC7IwbHfxJFweZgm9ElEPqVA==
X-Received: by 2002:a1c:4d11:: with SMTP id o17mr2034612wmh.170.1574243565417;
        Wed, 20 Nov 2019 01:52:45 -0800 (PST)
Received: from rybak.office.devexperts.com ([185.79.217.61])
        by smtp.googlemail.com with ESMTPSA id p25sm5992516wma.20.2019.11.20.01.52.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 01:52:44 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        predatoramigo@gmail.com
Subject: [RFC PATCH v2 3/4] rebase: extract add_exec()
Date:   Wed, 20 Nov 2019 10:52:37 +0100
Message-Id: <20191120095238.4349-4-rybak.a.v@gmail.com>
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
index fa27f7b439..8a6ac7439b 100644
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

