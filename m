Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 958921F404
	for <e@80x24.org>; Wed, 28 Feb 2018 22:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935255AbeB1WOL (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 17:14:11 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40173 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935237AbeB1WOK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 17:14:10 -0500
Received: by mail-wm0-f68.google.com with SMTP id t6so7957821wmt.5
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 14:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y5JBNB0+NzPM/Mdys3sZVtnkxLi602PGwlU88PgeHiY=;
        b=PJj3e8SsL6G7V23IUkc35GasIrfx1eXajsq2M7M9qPsWPP56z6/HlwU50hISYh+jm7
         mZ6WG316G0z8I6CNlXZufOtjp3hApdkcN3102Uyc1UnaJVLQiFt+t1rrHh5PjSHSm87U
         RniqD5Rf2humnSguFgArjGuZ0R2dhetfcgCTQbyfkMtKywB+382+1CojDStV2J3ZpfUh
         Ko6lTDIXyOvXHrYafjp+WjZdBu9bBMlA/ILGvXmoqyVlyZWrs9JdFCbR746wR/XD+BIR
         DN8sAcbh2XaLtOfH9t0HBOutNrjnMa4U7sEgMpmdUQxDBWFoLK5HwQRUBq8TBmid1IZk
         ztSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y5JBNB0+NzPM/Mdys3sZVtnkxLi602PGwlU88PgeHiY=;
        b=f/m3e/7xuqfma+45zlnqIc6OG88Csqy1UIwlPclsiowvYbg6hLH8+Kj4kPrKUbkotN
         pJ3GwhM4qcgQy7XgLtfwh3ZamD6s8xSsTOo34PR4Baw/e1Th8sFB+AkTS5wq+S7/y5oI
         fwNgiZ2UzSE1ETHL8Z+S4nvyXmGHr66ze1pfdgaYjrWnf/60dEjIjDbi5fhDH1frLYuk
         s5wDejINXy/b/B51B+zQzmaiZyazbyprOpm2girXbe4mWwf1C4FBbrSwZQSd1k3J6bDT
         M37iqsrWc2ogklCpI7psiOEuQ85UGrfoZzq5vxSfaxoQ1JDMJ7PQnPqlzXSi3ROKh8HB
         rmdw==
X-Gm-Message-State: AElRT7HRvvRu4LE2TFKz8caUQjvdSv7MjdPXg7XxnOAnVvwyNu9inTvV
        yzoN4Ri00nIG8rshldtVu0bdDrPG
X-Google-Smtp-Source: AG47ELvxUMvL0z+o1h5ycMP9LxekR180Alb/jvi7M3NylsGQ5ubzqAyu93qdXGjl+dZmjyZC3zLgaQ==
X-Received: by 10.28.122.11 with SMTP id v11mr39491wmc.38.1519856048599;
        Wed, 28 Feb 2018 14:14:08 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 8sm3565669wmf.13.2018.02.28.14.14.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Feb 2018 14:14:07 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] commit: run git gc --auto just before the pre-commit hook
Date:   Wed, 28 Feb 2018 22:13:58 +0000
Message-Id: <20180228221358.16286-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the behavior of git-commit back to what it was back in
d4bb43ee27 ("Invoke "git gc --auto" from commit, merge, am and
rebase.", 2007-09-05) when it was git-commit.sh.

Shortly afterwards in f5bbc3225c ("Port git commit to C.", 2007-11-08)
when it was ported to C the "git gc --auto" invocation went away.

Before this git gc --auto only ran for
git-{am,merge,fetch,receive-pack}, therefore it was possible to write
a script that would "git commit" a lot of data locally, and gc would
never run.

One such repository that was locally committing generated zone file
changes had grown to a size of ~60GB before a daily cronjob was added
to "git gc", bringing it down to less than 1GB. This will make such
cases work transparently.

I think fixing such pathological cases where the repository will grow
forever is a worthwhile trade-off for spending a couple of
milliseconds calling "git gc --auto" (in the common cases where it
doesn't do anything).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index e8e8d13be4..b671367840 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1402,6 +1402,7 @@ int run_commit_hook(int editor_is_used, const char *index_file, const char *name
 
 int cmd_commit(int argc, const char **argv, const char *prefix)
 {
+	const char *argv_gc_auto[] = {"gc", "--auto", NULL};
 	static struct wt_status s;
 	static struct option builtin_commit_options[] = {
 		OPT__QUIET(&quiet, N_("suppress summary after successful commit")),
@@ -1608,6 +1609,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	rerere(0);
 	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
+	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
 	if (amend && !no_post_rewrite) {
 		commit_post_rewrite(current_head, &oid);
 	}
-- 
2.15.1.424.g9478a66081

