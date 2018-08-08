Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8985208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 15:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbeHHR26 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 13:28:58 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46695 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbeHHR26 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 13:28:58 -0400
Received: by mail-ed1-f66.google.com with SMTP id o8-v6so1403585edt.13
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 08:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L3O8EYNisoqg/mkSItYPDc9MH/YnQ7QUP/SjqDsacnY=;
        b=P5d2T9p0jG+UOK6yKZUmsEjzAjIuRwbVsj5QGfeSm6ti1wakZafaCncsyHK7UbhCZY
         IY7L9XGRFdd+sYIFqY+YXC/NNTQAjuiSMZR/nlmJUQwKcADu17bcSAvIWx6ibQHjlKk2
         KnIUQwRhgT1hnJKjMdECjkpcrFBui8m8DiTvXyYmaytXRtl1hg0Ep88rGr/TUSvuhZqC
         s3ZPGxcgie9myjcR+lwtYndEObUcYhyuWXmhaQLGDE9EfEbNJKwFLw0h1KJhh7ZgOHXQ
         b41XRC00HCGLtu31HWc0Gy6H+NXEEkKDDn7WwA6m2bB4E5rg/SiZ6wiugfOg7E8tutsz
         15nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L3O8EYNisoqg/mkSItYPDc9MH/YnQ7QUP/SjqDsacnY=;
        b=Aw/kGka0xWpTm0B3DUnFGOHkLW38NwbL72335+LP9zevPImb4s6eMR4hZk12fSqreR
         S9M1I3UvlU5Ql6sW0CbxspcoFA4teYjuUxair0UK8vTdMU97h4bzaFzwKEseI+d+8sqf
         vP+RYVMO34Ue9vTjVjndzB9rOSoxJ1syC4U1L1Kkiak3Bbx0ktfpYo+i47qyOWJVarQR
         EAgKT6RepJLgQ0F8MBbkcYblFJeshhAZPJl0v9c4QbwQrGWysMxh41B0xnNaZ88SN8Yw
         mqOhrI0zExvlZRdE29gDswZ1azXfffvRMUjY3juZH+IS84eQojW98illenXY86o/a4wP
         qQ4Q==
X-Gm-Message-State: AOUpUlEDXtmsB5SlM60+PWC/BZAXfiku/WZ1mk4Ckml3Oswdpn/j5Lp4
        9z5iU8bixY8VXK1AxUD7D5XWOUWW
X-Google-Smtp-Source: AA+uWPxStBPY8T1EmIrBvHNjsVtq/3WqzSJJqIuD8DjW5KOeiz6sE9k0gh7UFC6RzHGgnyiWbIUR3Q==
X-Received: by 2002:a50:b206:: with SMTP id o6-v6mr3695167edd.160.1533740932387;
        Wed, 08 Aug 2018 08:08:52 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id w1-v6sm6771259eda.63.2018.08.08.08.08.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:08:51 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 5/7] builtin rebase: support --edit-todo and --show-current-patch
Date:   Wed,  8 Aug 2018 20:51:20 +0545
Message-Id: <20180808150622.9614-6-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808150622.9614-1-predatoramigo@gmail.com>
References: <20180808150622.9614-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While these sub-commands are very different in spirit, their
implementation is almost identical, so we convert them in one go.

And since those are the last sub-commands that needed to be converted,
now we can also turn that `default:` case into a bug (because we should
now handle all the actions).

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 0d805480a1..e3dd2f511e 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -472,6 +472,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		ACTION_SKIP,
 		ACTION_ABORT,
 		ACTION_QUIT,
+		ACTION_EDIT_TODO,
+		ACTION_SHOW_CURRENT_PATCH,
 	} action = NO_ACTION;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
@@ -503,6 +505,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			    ACTION_ABORT),
 		OPT_CMDMODE(0, "quit", &action,
 			    N_("abort but keep HEAD where it is"), ACTION_QUIT),
+		OPT_CMDMODE(0, "edit-todo", &action, N_("edit the todo list "
+			    "during an interactive rebase"), ACTION_EDIT_TODO),
+		OPT_CMDMODE(0, "show-current-patch", &action,
+			    N_("show the patch file being applied or merged"),
+			    ACTION_SHOW_CURRENT_PATCH),
 		OPT_END(),
 	};
 
@@ -570,6 +577,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_rebase_usage,
 				   builtin_rebase_options);
 
+	if (action == ACTION_EDIT_TODO && !is_interactive(&options))
+		die(_("The --edit-todo action can only be used during "
+		      "interactive rebase."));
+
 	switch (action) {
 	case ACTION_CONTINUE: {
 		struct object_id head;
@@ -639,8 +650,18 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			die(_("could not remove '%s'"), options.state_dir);
 		goto cleanup;
 	}
+	case ACTION_EDIT_TODO:
+		options.action = "edit-todo";
+		options.dont_finish_rebase = 1;
+		goto run_rebase;
+	case ACTION_SHOW_CURRENT_PATCH:
+		options.action = "show-current-patch";
+		options.dont_finish_rebase = 1;
+		goto run_rebase;
+	case NO_ACTION:
+		break;
 	default:
-		die("TODO");
+		BUG("action: %d", action);
 	}
 
 	/* Make sure no rebase is in progress */
-- 
2.18.0

