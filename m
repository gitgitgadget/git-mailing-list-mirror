Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2245C35242
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 23:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26702086A
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 23:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sYG7oK3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgBNX3j (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:29:39 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:48945 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbgBNX3j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 18:29:39 -0500
Received: by mail-pl1-f202.google.com with SMTP id d20so6042382pls.15
        for <git@vger.kernel.org>; Fri, 14 Feb 2020 15:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=wgj/BAayUUNkxM5pCbN7k+HJ8nTUtoqZJn5HmdHrdKg=;
        b=sYG7oK3QKMNDrsidhy56/kuFpfVXQNZBdxxHcLTRkhtLYCnjJHre6DE8hSfdrtZbFY
         lM+BBVg9i1US9UTsUv6rFQmettXT1iYMI0BxMt9xpLgRvN7imNqwXwSeXLK3qW981BNb
         wMYJwq/DLfgf2YMXequ1tAOr/3NwOwkphweHt5L5/lum2CGwmPjQQyyrcyNnYlGeG4jx
         3Nt1utmbo2B+bozYqIhlodaKPwAfUzGEvCCu95PuDwuAucyUGfaDYMv9LgW+KNjiCwq1
         PvqE4XGjamfxyK18oOpEIUcrIBMPHKHr86NheF04ONPW0kly8QFjkoQooOSb6dwH7JR8
         0E1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=wgj/BAayUUNkxM5pCbN7k+HJ8nTUtoqZJn5HmdHrdKg=;
        b=jQwhpLqJA7zuD8lk1kBQn2vkewyN6m4sW7lpYsw0KutF4Pg0tL266saIX7LrXit+rq
         WQPXe1XaAh+LOSLR4GVzMmQRo9By7a1AJKCUD8TXs5fDLt2HJUmrP+AH3Z3wclYWUy12
         92O/ULtNix4vm8E5XikKt3GiBZ+SBWDSS3H1lSG9Q9YWXsAqieC2LGOAY6ugFq5YmE1L
         MtCSeK/VJdJDYZtYa5b8KvHhggkBb40aZxmPkbpyZsv1/C+dGUaHnPyBmEmr2jfeTcEb
         7qTMIUIEZpAW0SREHQ5X4ejgogd9a5B898z6LolfL58IKPHry7dlSXL1kOUCdbyeN1+n
         Y+Rw==
X-Gm-Message-State: APjAAAUfGMC3ELEyIWukrdpPMcwpTIYn9meTajYWi6sXa/9ojlq0WbnY
        SgqForgKPm9NnTuKmARZB6UOvbRMAESk7K27SRXOsxShNIAjyOmVg8q7C3+8rWWAIIxZjqN7BwK
        5M98je2K6+WBHcKL9blkGIjHl+L8tJBWhGgAH969VLRla3OK3xxOTQyZMhkzXtgvSwILBUMFB2A
        ==
X-Google-Smtp-Source: APXvYqywBqw/D0l7Vtov+tMxVpECSQWwfPC+L9nMkNaGEfZEMhwNM//lAaR0cVGltOzx9YDHs90lZp3Wo1BG+ZPY5lw=
X-Received: by 2002:a63:650:: with SMTP id 77mr5816630pgg.102.1581722978552;
 Fri, 14 Feb 2020 15:29:38 -0800 (PST)
Date:   Fri, 14 Feb 2020 15:29:33 -0800
Message-Id: <20200214232933.243520-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [RFC PATCH] prefix_path: show gitdir when arg is outside repo
From:   emilyshaffer@google.com
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

When developing a script, it can be painful to understand why Git thinks
something is outside the current repo, if the current repo isn't what
the user thinks it is. Since this can be tricky to diagnose, especially
in cases like submodules or nested worktrees, let's give the user a hint
about which repository is offended about that path.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
This one comes from a user feature request. This user is running some
Git client commands on a build machine somewhere and finding it hard to
reason about the cause of the "outside repo" error.

I see two arguments:

For:
 - A user checking their own `pwd` might still not come to the same
   conclusion Git does about the current repo, if their filesystem is in
   some weird state
 - This warning is intended for human eyes (die(), stderr) so it's reasonable
   to give some info to make the human's life easier

Against:
 - It's chatty, especially given the absolute directory. This may be a
   pretty common mistake ('git add' with thumbfingers?) so it could be
   chatty, frequently - not great.
   (Sidebar: Just including the relative directory is really not very
   useful - since you're still left thinking, "relative to where?")

I also dug around a little to see whether I could consolidate the
pathspec.c logic, which is nearly identical to setup.c, into another
helper in setup.c (a la prefix_path_1()). But since the die() message is
somewhat different, and init_pathspec_item() is the _only_ place which
uses prefix_path_gently() in this way, it wasn't feasible. (The other
caller of prefix_path_gently() is immediately below prefix_path(), and
doesn't die at all, print errors, or capture out-params from
prefix_path_gently().)

 - Emily

 pathspec.c | 3 ++-
 setup.c    | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 128f27fcb7..5d661df5cf 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -439,7 +439,8 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
 		match = prefix_path_gently(prefix, prefixlen,
 					   &prefixlen, copyfrom);
 		if (!match)
-			die(_("%s: '%s' is outside repository"), elt, copyfrom);
+			die(_("%s: '%s' is outside repository at '%s'"), elt,
+			    copyfrom, absolute_path(get_git_dir()));
 	}
 
 	item->match = match;
diff --git a/setup.c b/setup.c
index 12228c0d9c..48cc2320cb 100644
--- a/setup.c
+++ b/setup.c
@@ -121,7 +121,8 @@ char *prefix_path(const char *prefix, int len, const char *path)
 {
 	char *r = prefix_path_gently(prefix, len, NULL, path);
 	if (!r)
-		die(_("'%s' is outside repository"), path);
+		die(_("'%s' is outside repository at '%s'"), path,
+		    absolute_path(get_git_dir()));
 	return r;
 }
 
-- 
2.25.0.265.gbab2e86ba0-goog

