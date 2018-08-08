Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE9A6208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeHHR2u (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:28:50 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36740 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeHHR2u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:28:50 -0400
Received: by mail-ed1-f66.google.com with SMTP id k15-v6so1433347edr.3
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4T86mXkX0KHxNfq3CPNLUlZGo049qn6BVZViWOpQPLk=;
        b=UsPbeItcU9XH1VnGxvFm2ZJZzt9k936KRepbD2eINAopRtfXZ7AGOZb+uC6L4rU2zR
         rSJT9IrTs7QlYg4EKTsIkgbKiKJ+pJt0h8jZugF0Wf199q5OPV79qsvNxDLEyekCIa4N
         Tp1Id7xs2Yr6HwA8KQnIbznk4GTIpzOr8mkMiCD3YcQduvj9ZYyqy8SLwsaL6zR9stiU
         K3S6Cbj31p9EqetZiAktlYVVKPMKeYkdik5wVNdKqiaWX1meDk0OheJuMEmcTK57nLUj
         hry0DfVa+nndtPKn00z9enLtobUNWaIyzDnzOCReiGSm91pHb5Mi0VgHIRdrY5KamfSW
         lT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4T86mXkX0KHxNfq3CPNLUlZGo049qn6BVZViWOpQPLk=;
        b=WfI9ACkdJJ31owqoOhEM74jOVRdBZw646xOAhPc6ZqI0gjsKA9cLIFFwcsRJgSJtVP
         ZTryF9RDeP6LYM7I7bBNIymAK7n7hoijRyUsIYc0YciwyOgI1qDRtatXjEHxnj4jCmuo
         De/7g+aMLld0g1nB679HeKGRPTQHEPfUBVln8cKHlmp2JPkjF9pCk63goXo/fmuXWM0y
         vThqIhJAI6yx8QLvobwi+P4e86wzIEBsPy3K1sTcxHwUkaD9FR4GSVoiKUt4yFXF2q2I
         e/tipbcQQZJOFljcwHqcXzueTP9KWkeEG6V1KskM4Zj/rmJHbCEz2zfS4/NAgYIhCbrZ
         o0Dw==
X-Gm-Message-State: AOUpUlHVMy5gK9oBB7GN+J5npjt5vOsbUi5Lrl0IDV6O4IJdon4ScRKi
        bvX4cKxWPpcKhwY7N5V+VxxF94VQ
X-Google-Smtp-Source: AA+uWPxEUQFtzHGqXIFxbr3b94jURU2cyOgRqa6KjCm1RlbnDAJh5nCvgg9YcY3CzVl57cCDwhUP5w==
X-Received: by 2002:a50:80e6:: with SMTP id 93-v6mr3718100edb.252.1533740924883;
        Wed, 08 Aug 2018 08:08:44 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id w1-v6sm6771259eda.63.2018.08.08.08.08.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:08:44 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 3/7] builtin rebase: support --abort
Date:   Wed,  8 Aug 2018 20:51:18 +0545
Message-Id: <20180808150622.9614-4-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808150622.9614-1-predatoramigo@gmail.com>
References: <20180808150622.9614-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit teaches the builtin rebase the "abort" action, which a user
can call to roll back a rebase that is in progress.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 7a903838b1..8e94f6cc85 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -470,6 +470,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		NO_ACTION,
 		ACTION_CONTINUE,
 		ACTION_SKIP,
+		ACTION_ABORT,
 	} action = NO_ACTION;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
@@ -496,6 +497,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			    ACTION_CONTINUE),
 		OPT_CMDMODE(0, "skip", &action,
 			    N_("skip current patch and continue"), ACTION_SKIP),
+		OPT_CMDMODE(0, "abort", &action,
+			    N_("abort and check out the original branch"),
+			    ACTION_ABORT),
 		OPT_END(),
 	};
 
@@ -608,6 +612,22 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			exit(1);
 		goto run_rebase;
 	}
+	case ACTION_ABORT: {
+		struct string_list merge_rr = STRING_LIST_INIT_DUP;
+		options.action = "abort";
+
+		rerere_clear(&merge_rr);
+		string_list_clear(&merge_rr, 1);
+
+		if (read_basic_state(&options))
+			exit(1);
+		if (reset_head(&options.orig_head, "reset",
+			       options.head_name, 0) < 0)
+			die(_("could not move back to %s"),
+			    oid_to_hex(&options.orig_head));
+		ret = finish_rebase(&options);
+		goto cleanup;
+	}
 	default:
 		die("TODO");
 	}
-- 
2.18.0

