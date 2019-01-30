Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E90A71F453
	for <e@80x24.org>; Wed, 30 Jan 2019 09:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbfA3Jtk (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 04:49:40 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33307 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbfA3Jtk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 04:49:40 -0500
Received: by mail-pg1-f194.google.com with SMTP id z11so10136618pgu.0
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 01:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UewprQ4gX+B/4t99mQSjvH1uai7+JIlyjm8zwujRSHY=;
        b=aDM0OV2cB9mRjwRJ+ylEkepx97Ki5PT3aTv5J4UVeqjRhESl0VazjEk9vxxhI8NvRq
         6zIC+HGK/giN//3qJb4C9dLtbIXPTO+hArElkMDH5rmo2yzovFS9K4yGECeEBsDHsyo0
         FakWk/VYS3p60uUPMBopue2P/7Uq/WtBpuxSXHPJC7EZJuyCJ4EU+ED9b05NPR0jTTmn
         3VSGv7TvPAjqcmYxjclgz2feIqs2xNJOdzGpRnwBipwNzqlwffj8GLyqUue1lGmti0Aq
         H+i3C3xqsoE/ixywa0NOBzXBMLs7/u7MYkTZWMg8Np7Nd1GKHTc7ElreUDYTkYVOvvZf
         pRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UewprQ4gX+B/4t99mQSjvH1uai7+JIlyjm8zwujRSHY=;
        b=GXT/0fs+KcFbWiZ3duCZdp21lgUiVuVdIisPDIyuPmvxLIkDMRFmmCSP9KKYb9LMox
         t2ZbZLVinNr3WYQsH8JQgNbbCAjQWiBZ+kQtaedYYUww1c8RhNPGPkyf0UVa/k2tLGJX
         iAMsnxP1ieOx4DvK5vB8IZPBMJW5FqXEUpwt2QqFFelFNnzdsONI92QS2A4cNzOFnzD5
         uAyrrPY+KiaDboqCcqb7Bq1078rGEMkvjskujQYS5FJxEqdE8jUYzi2Q+/TyINZo2i99
         zI5FQMrJTyVfKQqyqqQJERtU6LExbUX6iSDcodt3sr5hwgLEeEdjkJGYa/3P4+W3NiCi
         8Fiw==
X-Gm-Message-State: AJcUukfyd5vmS5R918a/qKzQRO8mNljbcCZMpG5v+dbdMkGROefcTaWt
        nUD/Z8rMouuoEDWv0bKB/5EvYC6M
X-Google-Smtp-Source: ALg8bN7koQ7cZEBiR4ZX6hn2L3LdGl/L6S6v+VUIPUhTkATHppjmSLfRjk0qCpT4oVPUqPCpRMvxnQ==
X-Received: by 2002:a63:1444:: with SMTP id 4mr27153539pgu.430.1548841779362;
        Wed, 30 Jan 2019 01:49:39 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id 186sm5632432pga.36.2019.01.30.01.49.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 01:49:38 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 30 Jan 2019 16:49:34 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 13/19] switch: only allow explicit detached HEAD
Date:   Wed, 30 Jan 2019 16:48:25 +0700
Message-Id: <20190130094831.10420-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190130094831.10420-1-pclouds@gmail.com>
References: <20190130094831.10420-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git checkout <commit>" will checkout the commit in question and
detach HEAD from the current branch. It is naturally a right thing to
do once you get git references. But detached HEAD is a scary concept
to new users because we show a lot of warnings and stuff, and it could
be hard to get out of (until you know better).

To keep switch a bit more friendly to new users, we only allow
entering detached HEAD mode when --detach is given. "git
switch" must take a branch (unless you create a new branch,
then of course switch can take any commit-ish)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9a58fccd71..69df3a1547 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -44,6 +44,7 @@ struct checkout_opts {
 	int merge;
 	int force;
 	int force_detach;
+	int implicit_detach;
 	int writeout_stage;
 	int overwrite_ignore;
 	int ignore_skipworktree;
@@ -1326,6 +1327,14 @@ static int checkout_branch(struct checkout_opts *opts,
 	    !opts->force_detach)
 		die(_("nothing to do"));
 
+	if (!opts->implicit_detach &&
+	    !opts->force_detach &&
+	    !opts->new_branch &&
+	    !opts->new_branch_force &&
+	    new_branch_info->name &&
+	    !new_branch_info->path)
+		die(_("a branch is expected, got %s"), new_branch_info->name);
+
 	if (new_branch_info->path && !opts->force_detach && !opts->new_branch &&
 	    !opts->ignore_other_worktrees) {
 		int flag;
@@ -1581,6 +1590,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts.no_dwim_new_local_branch = 0;
 	opts.switch_branch_doing_nothing_is_ok = 1;
 	opts.accept_pathspec = 1;
+	opts.implicit_detach = 1;
 
 	options = parse_options_dup(checkout_options);
 	options = add_common_options(&opts, options);
@@ -1610,6 +1620,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 	opts.no_dwim_new_local_branch = 0;
 	opts.accept_pathspec = 0;
 	opts.switch_branch_doing_nothing_is_ok = 0;
+	opts.implicit_detach = 0;
 
 	options = parse_options_dup(switch_options);
 	options = add_common_options(&opts, options);
-- 
2.20.1.682.gd5861c6d90

