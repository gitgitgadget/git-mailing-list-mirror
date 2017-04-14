Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C5FC20970
	for <e@80x24.org>; Fri, 14 Apr 2017 16:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752897AbdDNQvO (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 12:51:14 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35424 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752723AbdDNQvK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 12:51:10 -0400
Received: by mail-wr0-f196.google.com with SMTP id l44so13044571wrc.2
        for <git@vger.kernel.org>; Fri, 14 Apr 2017 09:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lk7BFyts2raMr56Ar2xvw0vpoATsDKZ5xUOtJl8vavE=;
        b=BEcwZe1FxRkJ1bAbRQezCZkGlxnnoDLrQcc2AchPSa8EA2GNndRJZGBSmH7MOxWw84
         RY4T8U6r4/gb+xjBPr/LaYS5KxRtUcCSSe2setzDJ666eAf1iTcinj845lA1DgtdJZvR
         rjL6WXPgKOgNRMgEHUN00m++mZNej5fQ0cmSIUH//2q4Xid8YVaqvgzw2jzaMBfFFdMz
         8E6rtjmEyljqz7/D4s0oYf46IR0OKn9RPoiNLcIMGTanlnwnzzTIligFzhz4qFCjGX3t
         oia7hiXKKo8jmh7afcrcDPMkK7kCrxN06BL9JITnhhjeSrniSmGX9l7qjCU+4X7rAkma
         NITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lk7BFyts2raMr56Ar2xvw0vpoATsDKZ5xUOtJl8vavE=;
        b=WMEGu5dhcJaLDfIyuAhwiX+ozTBNVMOMZ7anymaTIJ0UtIyCF7ukK4b9hEFc/7e9eM
         uBGrP+xqzwuezX9AiPec/b9waw94I7wf+XHV2OB8IiuNBHjTHIo4xUI8DDjNONGYNk1v
         v9jauXa5sferJqLFiG5Sg1wHr7Stis4HwBoiF1uT9gLOHwUYMEyeIRk2UHR1unwTmlyq
         LXPMASe5giIUYPEahpG/PlomsS1UtjmIlOL2Ikmn6nFBTUICCWSUzOh5kY9Rg1VANfM8
         qATan3yObSN92H6dtol4jbVzRqDwU+F0M1rl/wVClE+Z3iVtERTZbTuu1DORLZ/iJTn8
         hiuw==
X-Gm-Message-State: AN3rC/7WDH0ESm2mftif61LymhrNZaDm2BkNkMVaBAV3/RVJOgTay+BE
        EWgWbk/O3BQdo6PQ
X-Received: by 10.223.181.131 with SMTP id c3mr8278910wre.61.1492188669219;
        Fri, 14 Apr 2017 09:51:09 -0700 (PDT)
Received: from localhost ([151.54.23.249])
        by smtp.gmail.com with ESMTPSA id b188sm3389113wmh.6.2017.04.14.09.51.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Apr 2017 09:51:08 -0700 (PDT)
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To:     Git ML <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2] rebase: pass --[no]-signoff option to git am
Date:   Fri, 14 Apr 2017 18:50:44 +0200
Message-Id: <20170414165044.13990-1-giuseppe.bilotta@gmail.com>
X-Mailer: git-send-email 2.12.2.765.g845dc5dc05
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes it easy to sign off a whole patchset before submission.

To make things work, we also fix a design issue in git-am that made it
ignore the signoff option during rebase (specifically, signoff was
handled in parse_mail(), but not in parse_mail_rebasing()).

This is trivially fixed by moving the conditional addition of the
signoff from parse_mail() to the caller (am_run()), after either of the
parse_mail*() functions were called.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 Documentation/git-rebase.txt | 5 +++++
 builtin/am.c                 | 6 +++---
 git-rebase.sh                | 3 ++-
 3 files changed, 10 insertions(+), 4 deletions(-)

Compared to v1, we also pass --no-signoff (which is accepted by git-am to
override a preceding --signoff, so it works the same way) and make sure
that git-am actually obeys --signoff while rebasing (which was not the
case anymore since df2760a576a8d26e26a6a11aa497e347c7402fd3).

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 67d48e6883..e6f0b93337 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -385,6 +385,11 @@ have the long commit hash prepended to the format.
 	Recreate merge commits instead of flattening the history by replaying
 	commits a merge commit introduces. Merge conflict resolutions or manual
 	amendments to merge commits are not preserved.
+
+--signoff::
+	This flag is passed to 'git am' to sign off all the rebased
+	commits (see linkgit:git-am[1]).
+
 +
 This uses the `--interactive` machinery internally, but combining it
 with the `--interactive` option explicitly is generally not a good
diff --git a/builtin/am.c b/builtin/am.c
index f7a7a971fb..d072027b5a 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1321,9 +1321,6 @@ static int parse_mail(struct am_state *state, const char *mail)
 	strbuf_addbuf(&msg, &mi.log_message);
 	strbuf_stripspace(&msg, 0);
 
-	if (state->signoff)
-		am_signoff(&msg);
-
 	assert(!state->author_name);
 	state->author_name = strbuf_detach(&author_name, NULL);
 
@@ -1848,6 +1845,9 @@ static void am_run(struct am_state *state, int resume)
 			if (skip)
 				goto next; /* mail should be skipped */
 
+			if (state->signoff)
+				am_append_signoff(state);
+
 			write_author_script(state);
 			write_commit_msg(state);
 		}
diff --git a/git-rebase.sh b/git-rebase.sh
index 48d7c5ded4..e2ec5c092d 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -34,6 +34,7 @@ root!              rebase all reachable commits up to the root(s)
 autosquash         move commits that begin with squash!/fixup! under -i
 committer-date-is-author-date! passed to 'git am'
 ignore-date!       passed to 'git am'
+[no]-signoff!      passed to 'git am'
 whitespace=!       passed to 'git apply'
 ignore-whitespace! passed to 'git apply'
 C=!                passed to 'git apply'
@@ -321,7 +322,7 @@ do
 	--ignore-whitespace)
 		git_am_opt="$git_am_opt $1"
 		;;
-	--committer-date-is-author-date|--ignore-date)
+	--committer-date-is-author-date|--ignore-date|--signoff|--no-signoff)
 		git_am_opt="$git_am_opt $1"
 		force_rebase=t
 		;;
-- 
2.12.2.765.g845dc5dc05

