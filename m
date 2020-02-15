Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA09C35242
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 01:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840702083B
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 01:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hvgk4DB+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbgBOBAT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 20:00:19 -0500
Received: from mail-vk1-f202.google.com ([209.85.221.202]:47333 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgBOBAT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 20:00:19 -0500
Received: by mail-vk1-f202.google.com with SMTP id n9so4002218vkc.14
        for <git@vger.kernel.org>; Fri, 14 Feb 2020 17:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=BEthHZBZO6fs0yZNHH8fpAfNXa7v6KHWeAi5mt+j7N8=;
        b=hvgk4DB+ujs3PflDqhBY/l6Qwyx868C9ZH1BgDmjm3Yo8bBgZAl7g1d28e9fyfRy+6
         Dp2F1ppCaecL3b+VCI60513HY7li4pnb0+fi+hC6TfSe79mxJO0NFgqUgbFrgXlYeFkU
         VdSfFl6mufmmmuFdOBK/35VBzubAFv1mGoERvyoIbHw5TSjDVV9RenXHaWiXnTdixSV4
         I+QkYYEh2Vk3TYbAfgBROQfnLt4P5C7sk2MhRcuIMxQC1R27bWkyBMlzLYOXwwJpfsHG
         Qd+aJ0fxEheeIUtr41Dx4H3lp3ZO2FR/5kjeURugYWnYnc0LEDu7kDYmcTgu/Q95Vsj1
         N1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=BEthHZBZO6fs0yZNHH8fpAfNXa7v6KHWeAi5mt+j7N8=;
        b=THyKCpK0LtnvlrxJ+7pvn177+z68f5xR7lw7CUbgGyM/mA5cPoMTzBFMkvN4zvR1dZ
         +sA+3APAkAKe3PBxq7Jen7IC56eewAHY+IcFwRoPAp/NBas9yu77PQuogkeI+142Q83T
         4QlzCLXttiDzSK2XzxPz+HRIegymdCg5IM+JlLDm7RMXfFwhB8cIhrXUwL2EF9qQRXr5
         156CCnuXw+r1A6qrtJDDFyuyB01E6I5CXxIxVQrWx5/gMhXQ5cLjYSyf3qjybg7gM3dr
         eITnq9jq5eNS80XWfiR23fZcAK/oqtj7f1GY90+IHiLcSJRPBvevEmcSM4j+ggRrPlF+
         GB+g==
X-Gm-Message-State: APjAAAXVOqbuPtYv3byK15vgU2QWfKLV9hHvNpbvBVwK9OXhb7Bjw0KS
        k8MOBMZuW+VGtpRXD2f+7hzY177dbV+Lv4V0plCdtgKTfIvbMZpvjtwHhoGeSYk+b/2Io3pYCps
        O2jb7fkhSsKSOFlPPD2sI2PhIKy2SB8eq4rM+PRVVb1NGNvhaUByohYjH2bnCym1oHwYkQ0DCsA
        ==
X-Google-Smtp-Source: APXvYqxw4Ir4/NxbbZAB3cJLDXNxGO1SETmZHF8epF6PMDnVcAzEM31pq+XqS5N97CBEoAl58obzV40GXpsp16l78VA=
X-Received: by 2002:a1f:9e86:: with SMTP id h128mr873745vke.44.1581728417821;
 Fri, 14 Feb 2020 17:00:17 -0800 (PST)
Date:   Fri, 14 Feb 2020 17:00:13 -0800
In-Reply-To: <20200214232933.243520-1-emilyshaffer@google.com>
Message-Id: <20200215010013.190528-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [RFC PATCH v2] prefix_path: show gitdir when arg is outside repo
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When developing a script, it can be painful to understand why Git thinks
something is outside the current repo, if the current repo isn't what
the user thinks it is. Since this can be tricky to diagnose, especially
in cases like submodules or nested worktrees, let's give the user a hint
about which repository is offended about that path.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
As suggested by brian, print the worktree instead. See
https://lore.kernel.org/git/20200215004606.GM190927@google.com.

 pathspec.c | 3 ++-
 setup.c    | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 128f27fcb7..166d255642 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -439,7 +439,8 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
 		match = prefix_path_gently(prefix, prefixlen,
 					   &prefixlen, copyfrom);
 		if (!match)
-			die(_("%s: '%s' is outside repository"), elt, copyfrom);
+			die(_("%s: '%s' is outside repository at '%s'"), elt,
+			    copyfrom, absolute_path(get_git_work_tree()));
 	}
 
 	item->match = match;
diff --git a/setup.c b/setup.c
index 12228c0d9c..4ea7a0b081 100644
--- a/setup.c
+++ b/setup.c
@@ -121,7 +121,8 @@ char *prefix_path(const char *prefix, int len, const char *path)
 {
 	char *r = prefix_path_gently(prefix, len, NULL, path);
 	if (!r)
-		die(_("'%s' is outside repository"), path);
+		die(_("'%s' is outside repository at '%s'"), path,
+		    absolute_path(get_git_work_tree()));
 	return r;
 }
 
-- 
2.25.0.265.gbab2e86ba0-goog

