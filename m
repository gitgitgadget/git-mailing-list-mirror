Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885F8C04E30
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 02:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F01A20726
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 02:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aDfGPglD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfLJCeB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 21:34:01 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:40183 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfLJCeB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 21:34:01 -0500
Received: by mail-pg1-f201.google.com with SMTP id z12so9761514pgf.7
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 18:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=K8or5ZeKpAf6ZAbE/hDuC3yP5yGtul5JFSNDQJlJ44c=;
        b=aDfGPglDRkTxbdyR8PPurABCtyhX9fu9HjuP4qcq0rWJ2SDs4sb0iBwvZEHcDibRhx
         AHVLMutbSro8aOWeefacGg56uq0KIbPA00UQGOjfqjJUbg/kWOcZ91SZ7AFiNtaOXxW3
         04t5P6FW+DncxUwD6ZWyU9XS7e5xTXmjOnJXskCp14d9mn3IJWKocrPi6vwTJFkwpGo4
         Cv3gMcp0+Lor/vgktfRmPeR6FdiQ/7YySF4b0zRvgaYDwZ7ufBWuI0dtkdjCxNGr2qpZ
         fyRl2SXiI40d3gukWNZYX2Z5vwGxQjLryMR6foQZbwLaXTaE/i27ciZNJK0AG3ynuAsR
         kFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=K8or5ZeKpAf6ZAbE/hDuC3yP5yGtul5JFSNDQJlJ44c=;
        b=gOlIgu42gnftbmeRpyZ+Y1VwHrbGr6bfCz9hyJwc2H4XaXEUymumQtKbQXY3Leqp5R
         3jlfj+XTu2QtYFN9/OwV28XCQkBi9U2EAWKyj+56hsynEz4Li8uruVBG30DYWx+VZoMV
         NFUR1WCvaisRxza0H3tSaFH4AiY3yzZWcf9vQ3hBwsylK/qeB38+juCWfdqvrtWFH/sL
         csXAgKhbFhl4iqn5LVxTjBxugdFLuCUSEKWYAgzATymbP8fUMqLL52bdXBKcgguAfWig
         4ZwZBwjR7NhDAFNyslsIbbW/b/e/oma7bAgrk6aWXoIAE8GHrjO5L+kdYakfFeALSwD6
         ywGw==
X-Gm-Message-State: APjAAAWp7GlpRqjhuOlWY/Ki5c2RNj/4dbYIAIKbaeWKs5uq8N5eEQEi
        N4RNVfpEVOBMroIZYg+Fwi3uqI7eRfTDAg+UM7NMbMzIsoWUWiwaDIVogblVXqNqMiIps2pK3ZV
        vuOHoPgAz/wzCgyJm7IFTsAZ2RJ/IXsZAIM0Blfrp8aDO/BDMJnNRsKrg0Ih2ptzNoGxrT7sFeQ
        ==
X-Google-Smtp-Source: APXvYqwdesb/UQy4Y++n5RYlzzoLZ2KCfYB2+VfGlDftcLVhKtJrrXJQrivkbCreGu4TZYexSI/vw9NIeRvaUoK90S0=
X-Received: by 2002:a63:cc02:: with SMTP id x2mr22428641pgf.114.1575945240167;
 Mon, 09 Dec 2019 18:34:00 -0800 (PST)
Date:   Mon,  9 Dec 2019 18:33:33 -0800
In-Reply-To: <20191210023335.49987-1-emilyshaffer@google.com>
Message-Id: <20191210023335.49987-5-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191210023335.49987-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH 4/6] hook: support reordering of hook list
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's possible that in most cases a user wants to run pre-commit hook
'A', but in exactly one repo that user wants to run pre-commit hook 'A'
first instead. Teach 'git hook' to support this by allowing a user to
specify a new order number for a hook after the initial hook has been
specified.

For example:

  $ grep -A2 "\[hook\]" ~/.gitconfig
  [hook]
          pre-commit = 001:~/test.sh
          pre-commit = 999:~/baz.sh
  $ grep -A2 "\[hook\]" ~/git/.git/config
  [hook]
          pre-commit = 900:~/bar.sh
          pre-commit = 050:~/baz.sh
  $ ./bin-wrappers/git hook --list pre-commit
  001     global  ~/test.sh
  050     repo    ~/baz.sh
  900     repo    ~/bar.sh

In the above example, '~/baz.sh' is provided in the global config with
order position 999. Then, in the local config, that order is overridden
to 050. Instead of running ~/baz.sh twice (at order 050 and at order
999), only run it once, in the position specified last in config order.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/git-hook.txt    |  8 ++++++++
 hook.c                        |  7 +++++++
 t/t1360-config-based-hooks.sh | 14 ++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index a141884239..0f7115f826 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -20,6 +20,14 @@ This command parses the default configuration files for lines which look like
 single hook. Hooks are sorted in ascending order by order number; in the event
 of an order number conflict, they are sorted in configuration order.
 
+The order number of a hook can be changed at a more local scope, e.g.:
+
+  git config --add --global hook.pre-commit "001:/foo.sh"
+  git config --add --local hook.pre-commit "005:/foo.sh"
+
+When the order number is respecified this way, the previously specified hook
+configuration is overridden.
+
 OPTIONS
 -------
 
diff --git a/hook.c b/hook.c
index f8d1109084..a7dcd18a2e 100644
--- a/hook.c
+++ b/hook.c
@@ -64,6 +64,13 @@ static int check_config_for_hooks(const char *var, const char *value, void *hook
 				emplace_hook(pos, order, command);
 				added = 1;
 			}
+
+			/*
+			 * if the command already exists, this entry should be
+			 * replacing it.
+			 */
+			if (!strcmp(item->command.buf, command))
+				remove_hook(pos);
 		}
 
 		if (!added)
diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
index 1434051db3..1af43ef18d 100755
--- a/t/t1360-config-based-hooks.sh
+++ b/t/t1360-config-based-hooks.sh
@@ -47,4 +47,18 @@ test_expect_success 'order number collisions resolved in config order' '
 	test_cmp expected actual
 '
 
+test_expect_success 'adding a command with a different number reorders list' '
+	cat >expected <<-\EOF &&
+	010	repo	/path/abc
+	050	repo	/path/def
+	100	repo	/path/ghi
+	990	repo	/path/rst
+	999	global	/path/uvw
+	EOF
+
+	git config --add --local hook.pre-commit "050:/path/def" &&
+	git hook --list pre-commit >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.24.0.393.g34dc348eaf-goog

