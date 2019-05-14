Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7778B1F461
	for <e@80x24.org>; Tue, 14 May 2019 18:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfENSEH (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 14:04:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33117 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfENSEE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 14:04:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id d9so11879178wrx.0
        for <git@vger.kernel.org>; Tue, 14 May 2019 11:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=3cdTWHyfF2uZxinSS3hMKsNP913Nsf7W9VTMgEpQqK4=;
        b=XgzVvYLJ6zrBN7Pk9PEzwssne7aiSOVA4A3A4bu47ak/IePMHF4uf7rSjH1ImzGUm6
         JPzwzVv/8c3SuNBqe0MRVtm0wdBj+SaRmbhfsU7RsAMAGoWzy4VYbSjPlrGfHK+y4az3
         mf4AoHewBAoFpESUjD1BDR32H6FjWIq5LOJjGwo6y/DtSF/r0Ce5PqENlAmQaHh+54kv
         gbnsQUJCgGuu6IhPNATt/9UZoGZym25uEY1EKahgOtWUWHXk3xjRW4xlkpD6n5sCHYFK
         y0zSBj9csBpdYGtDUtGdPlJVpZzxsBiACV00FsY4sVH39WPrJhuwXsgOX98qjzBRfxLK
         +4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=3cdTWHyfF2uZxinSS3hMKsNP913Nsf7W9VTMgEpQqK4=;
        b=lohinG4AzHvn7WlXfyqJofVIvHo9f6chT30khjH2pwLKb+Dk7ofw4cUBmRr97YVV5M
         1Jr1jBOwiZ2zcAsgjvQKAbSX0j9B4zKwRmadCeZLqPblAmdzfrmfnePR5qYF9f88mmt0
         E8GVUm5mCelKBDbzzy1MDB0T4MyUq+LZQQaucasYDASx7/SdX2KBm4I9PB7QHLvj9wLY
         G0cgt4R6cMNvgs8tXkmL+wPTubxGk08sE5PgFjPLH7pLoo2LpJqkvwRmvjTToCJ5MS6s
         zcSFaTgPMFJsBtBq7tL3XInvZFtZgfxmT8RsJZz1I4MMns3gMjA1rR2cEUgoUn7EYMb5
         eaLw==
X-Gm-Message-State: APjAAAWZ+BOdG/aA6evc4zukDQdkMK7tugjKsXzpfQUo9WlfKJvqTp0X
        YQvWBzHLzSM/qB3uvfm80mhSVKVQ
X-Google-Smtp-Source: APXvYqzKpKxYkZGL5K/u2QlzuW/Dw7iTrD1mRr09PkEs3rY1kqmDlsaK1c1Rk+927CmPK8Nig5ggag==
X-Received: by 2002:adf:fb4a:: with SMTP id c10mr21984501wrs.309.1557857042713;
        Tue, 14 May 2019 11:04:02 -0700 (PDT)
Received: from lindisfarne.localdomain (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id a4sm4528230wmf.45.2019.05.14.11.04.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 11:04:02 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 2/4] rebase: warn if state directory cannot be removed
Date:   Tue, 14 May 2019 19:03:47 +0100
Message-Id: <20190514180349.17245-3-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514180349.17245-1-phillip.wood123@gmail.com>
References: <20190426103212.8097-1-phillip.wood123@gmail.com>
 <20190514180349.17245-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If rebase --quit cannot remove the state directory then it dies. However
when rebase finishes normally or the user runs rebase --abort any errors
that occur when removing the state directory are ignored. That is fixed
by this commit.

All of the callers of finish_rebase() except the code
that handles --abort are careful to make sure they get a postive return
value, do the same for --abort.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 90037c9c45..199cb5b81d 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -752,6 +752,7 @@ static int finish_rebase(struct rebase_options *opts)
 {
 	struct strbuf dir = STRBUF_INIT;
 	const char *argv_gc_auto[] = { "gc", "--auto", NULL };
+	int ret = 0;
 
 	delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
 	apply_autostash(opts);
@@ -762,10 +763,11 @@ static int finish_rebase(struct rebase_options *opts)
 	 */
 	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
 	strbuf_addstr(&dir, opts->state_dir);
-	remove_dir_recursively(&dir, 0);
+	if (remove_dir_recursively(&dir, 0))
+		ret = error(_("could not remove '%s'"), opts->state_dir);
 	strbuf_release(&dir);
 
-	return 0;
+	return ret;
 }
 
 static struct commit *peel_committish(const char *name)
@@ -1648,7 +1650,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			die(_("could not move back to %s"),
 			    oid_to_hex(&options.orig_head));
 		remove_branch_state(the_repository);
-		ret = finish_rebase(&options);
+		ret = !!finish_rebase(&options);
 		goto cleanup;
 	}
 	case ACTION_QUIT: {
-- 
2.21.0

