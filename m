Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5848C33C9E
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 23:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94CBA207E0
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 23:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rOvBHFpb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgAGXMg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 18:12:36 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:43616 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgAGXMg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 18:12:36 -0500
Received: by mail-wr1-f53.google.com with SMTP id d16so1382947wre.10
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 15:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1IiTn+1YoXaY9CVd2qFNEdKGdWoW/zviwbOX6TXYhCk=;
        b=rOvBHFpb5xyQZvNMhUxyF3Suo8xSfA/i58U3UZCYr9bewxAsmd1lsMtJCwhhTokcmP
         2S4x/GdstZ0sFsXP5R1uOe4/afD6IWdOUbzZEvjLfSc1ZN9BNf+d8CjyWnZVn06MAw+X
         TqoqqB8hHFYUFFt4ygJ+WrmVd2RZ3m5OvsJa93Vop8hJQ8KWZhU3ZEWBJ6zs2rPMn7La
         S1kB7vK1CIr49o2fe3bzG0WhK3V8LB46cLvUjulTpAod7n/C3qx7GrGMv/jgHWfFBDk9
         joMdqYIzx3572dDE7vRNUfT5zRiHBIka4HZ1IH02byM7SiISMbSsgCtzyGP48tNoLHxA
         T5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1IiTn+1YoXaY9CVd2qFNEdKGdWoW/zviwbOX6TXYhCk=;
        b=nTM9xu/ahUS01QlXGgQn/bQUuQ64xhWpPXSYpb3j27wRKMpFbugWvqz5qh4eukJcyH
         cLMSnh/10rdeUTfSM4CS2FoHRWTgY5BDxVTyOXCTZEG9B7Kf8udY4Ryh5v31xZKK8rdd
         KnaF3XBZFALpxzkIY/3S4aWtIyRdIUrWa5H8KAJOITeeKD0Hf1Eu6sSjjsI5G1w7Jtnl
         MwFmHdEX0BGZIZFyHpl9SemkY6gqGXjlzU/5cZEIRximTIY8CKKAXHsvAbtuz+vPMI8g
         26or4b6AyZtCL5LoyxgXAA0EjKCa+OvVs7fJtOkUtRw95LNg7XDc8xJhWGsGjtyxZhLl
         +FoA==
X-Gm-Message-State: APjAAAXf4wS0F9pYCKPo9yMoNEcKvxXxSquSl8SnipurBJQ3F0pbMhIh
        s+o4f69TgmV5PCU/VWyQ/lHDDu43
X-Google-Smtp-Source: APXvYqzlJwWt1FpZWbjefy2PSGDANtMHm5aWuGEgl4QUbgplI/IMwDwQw8LqTkZBSEN1Lz2irVxZOA==
X-Received: by 2002:a5d:4807:: with SMTP id l7mr1426602wrq.64.1578438754119;
        Tue, 07 Jan 2020 15:12:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b10sm1783402wrt.90.2020.01.07.15.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 15:12:33 -0800 (PST)
Message-Id: <9f9febd3f4f7f82178fceac98fcc91cb28a1b3b9.1578438752.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.508.v2.git.1578438752.gitgitgadget@gmail.com>
References: <pull.508.git.1577934241.gitgitgadget@gmail.com>
        <pull.508.v2.git.1578438752.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jan 2020 23:12:32 +0000
Subject: [PATCH v2 1/1] add: use advise function to display hints
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

Use the advise function in advice.c to display hints to the users, as
it provides a neat and a standard format for hint messages, i.e: the
text is colored in yellow and the line starts by the word "hint:".

Also this will enable us to control the messages using advice.*
configuration variables.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 advice.c       | 2 ++
 advice.h       | 1 +
 builtin/add.c  | 6 ++++--
 t/t3700-add.sh | 2 +-
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/advice.c b/advice.c
index 249c60dcf3..098ac0abea 100644
--- a/advice.c
+++ b/advice.c
@@ -31,6 +31,7 @@ int advice_graft_file_deprecated = 1;
 int advice_checkout_ambiguous_remote_branch_name = 1;
 int advice_nested_tag = 1;
 int advice_submodule_alternate_error_strategy_die = 1;
+int advice_add_nothing = 1;
 
 static int advice_use_color = -1;
 static char advice_colors[][COLOR_MAXLEN] = {
@@ -91,6 +92,7 @@ static struct {
 	{ "checkoutAmbiguousRemoteBranchName", &advice_checkout_ambiguous_remote_branch_name },
 	{ "nestedTag", &advice_nested_tag },
 	{ "submoduleAlternateErrorStrategyDie", &advice_submodule_alternate_error_strategy_die },
+	{ "addNothing", &advice_add_nothing },
 
 	/* make this an alias for backward compatibility */
 	{ "pushNonFastForward", &advice_push_update_rejected }
diff --git a/advice.h b/advice.h
index b706780614..83287b0594 100644
--- a/advice.h
+++ b/advice.h
@@ -31,6 +31,7 @@ extern int advice_graft_file_deprecated;
 extern int advice_checkout_ambiguous_remote_branch_name;
 extern int advice_nested_tag;
 extern int advice_submodule_alternate_error_strategy_die;
+extern int advice_add_nothing;
 
 int git_default_advice_config(const char *var, const char *value);
 __attribute__((format (printf, 1, 2)))
diff --git a/builtin/add.c b/builtin/add.c
index 4c38aff419..57b3186f69 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -390,7 +390,8 @@ static int add_files(struct dir_struct *dir, int flags)
 		fprintf(stderr, _(ignore_error));
 		for (i = 0; i < dir->ignored_nr; i++)
 			fprintf(stderr, "%s\n", dir->ignored[i]->name);
-		fprintf(stderr, _("Use -f if you really want to add them.\n"));
+		if (advice_add_nothing)
+			advise(_("Use -f if you really want to add them.\n"));
 		exit_status = 1;
 	}
 
@@ -480,7 +481,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	if (require_pathspec && pathspec.nr == 0) {
 		fprintf(stderr, _("Nothing specified, nothing added.\n"));
-		fprintf(stderr, _("Maybe you wanted to say 'git add .'?\n"));
+		if (advice_add_nothing)
+			advise( _("Maybe you wanted to say 'git add .'?\n"));
 		return 0;
 	}
 
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index c325167b90..a649805369 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -326,7 +326,7 @@ test_expect_success 'git add --dry-run of an existing file output' "
 cat >expect.err <<\EOF
 The following paths are ignored by one of your .gitignore files:
 ignored-file
-Use -f if you really want to add them.
+hint: Use -f if you really want to add them.
 EOF
 cat >expect.out <<\EOF
 add 'track-this'
-- 
gitgitgadget
