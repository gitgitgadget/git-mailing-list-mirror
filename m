Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C98F3207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 20:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967453AbdDZUuM (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 16:50:12 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36173 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967449AbdDZUuK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 16:50:10 -0400
Received: by mail-pf0-f182.google.com with SMTP id 194so5634396pfv.3
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 13:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e6+w3Sav4eS0U0XU2jSvIY+IV2QA20JwosjjvsW8HtU=;
        b=GQItO2eIi5MNJOuUsO91ZhoU0VJm25jb+OXKDLZOVS5zuRFFcpP64oZWM0SevdfMqR
         CHqTdzlVuFvC7VpdswFgpVY9KhmvFW3b8ppw7ZvFcLqJYGsrEpoKCAbPJHMsiPG3FtFU
         C8p5ocgAgJN3sj5YAoJYeeS224wE7erj2FxPW5wmtxwimzy9b+t5EbSyb+Xo42HuJuYs
         2zIr/zwGo2Apd4U/hJvGqDGXi1+ht2fJ2HTqNXkNbMkIgPonZDBheR24MNlLpLubS2Kg
         1ntvtXz3ZA+q5CAdguwmxuYYZ3uKwJEBXRXgiyL9/FkswqN9S5LL1flvodUuwmgFYZRD
         jR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e6+w3Sav4eS0U0XU2jSvIY+IV2QA20JwosjjvsW8HtU=;
        b=V9eOchLtzAvzJwwFjviZcbpSygplO9PrcpjoaGDiB2JomAeCf4eVRLE+AQDYr67gtD
         bzGeQVv34zmqWFk+9rpgeLxTtkYdp4wSMBv+G63U+XU3e4ZQ59oG/HJRzddCBVyEBL6c
         WTFAAo6JILLhcQ5K8xS4B1WbTwFHwSIRLdfdF0+1x26UOJW1+GhpGqMEjjFo1ZzvbruX
         zHZshCQRCNINv38klkH5P6xJK55TxqvR5qB1xsZ+Ie7EoPHuKtOlk61ooHanZib6cUTw
         QD+58ZlEXOdlIlAZ0iyhcOC4ZuQ7PzfmA96vzUpHoygVbLgqqC7ixl3/54uBlqC/jiKW
         gYnQ==
X-Gm-Message-State: AN3rC/5YN3U+GqFQb0fjoj+7HNuBWKy9Pl5Zdmreoz7ursc/qGGdYNMo
        GfXNAfuj92RM0imi
X-Received: by 10.84.215.218 with SMTP id g26mr2341831plj.22.1493239809618;
        Wed, 26 Apr 2017 13:50:09 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id t18sm334335pfg.31.2017.04.26.13.50.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 13:50:07 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        gitster@pobox.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v3] sequencer: add newline before adding footers
Date:   Wed, 26 Apr 2017 13:50:03 -0700
Message-Id: <20170426205003.30825-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d-goog
In-Reply-To: <20170425190651.8910-1-jonathantanmy@google.com>
References: <20170425190651.8910-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When encountering a commit message that does not end in a newline,
sequencer does not complete the line before determining if a blank line
should be added.  This causes the "(cherry picked..." and sign-off lines
to sometimes appear on the same line as the last line of the commit
message.

This behavior was introduced by commit 967dfd4 ("sequencer: use
trailer's trailer layout", 2016-11-29). However, a revert of that commit
would not resolve this issue completely: prior to that commit, a
conforming footer was deemed to be non-conforming by
has_conforming_footer() if there was no terminating newline, resulting
in both conforming and non-conforming footers being treated the same
when they should not be.

Resolve this issue, both for conforming and non-conforming footers, and
in both do_pick_commit() and append_signoff(), by always adding a
newline to the commit message if it does not end in one before checking
the footer for conformity.

Reported-by: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---

The failure in the case of non-footers not being terminated by a newline
turns out to be quite easy to fix, so I've added that fix here. I think
this makes the overall fix more obvious too.

I've used Jonathan Nieder's and Dscho's suggestions for the tests
(except for --format vs --pretty, since --format seems to add an extra
newline to the output).

 sequencer.c              | 11 ++++-------
 t/t3511-cherry-pick-x.sh | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 77afecaeb..ffac95545 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1045,6 +1045,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 			strbuf_addstr(&msgbuf, p);
 
 		if (opts->record_origin) {
+			strbuf_complete_line(&msgbuf);
 			if (!has_conforming_footer(&msgbuf, NULL, 0))
 				strbuf_addch(&msgbuf, '\n');
 			strbuf_addstr(&msgbuf, cherry_picked_prefix);
@@ -2335,6 +2336,9 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
 				getenv("GIT_COMMITTER_EMAIL")));
 	strbuf_addch(&sob, '\n');
 
+	if (!ignore_footer)
+		strbuf_complete_line(msgbuf);
+
 	/*
 	 * If the whole message buffer is equal to the sob, pretend that we
 	 * found a conforming footer with a matching sob
@@ -2355,13 +2359,6 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
 			 * the title and body to be filled in by the user.
 			 */
 			append_newlines = "\n\n";
-		} else if (msgbuf->buf[len - 1] != '\n') {
-			/*
-			 * Incomplete line.  Complete the line and add a
-			 * blank one so that there is an empty line between
-			 * the message body and the sob.
-			 */
-			append_newlines = "\n\n";
 		} else if (len == 1) {
 			/*
 			 * Buffer contains a single newline.  Add another
diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
index bf0a5c988..9888bf34b 100755
--- a/t/t3511-cherry-pick-x.sh
+++ b/t/t3511-cherry-pick-x.sh
@@ -208,6 +208,50 @@ test_expect_success 'cherry-pick -x -s adds sob even when trailing sob exists fo
 	test_cmp expect actual
 '
 
+test_expect_success 'cherry-pick -x handles commits with no NL at end of message' '
+	pristine_detach initial &&
+	printf "title\n\nSigned-off-by: A <a@example.com>" >msg &&
+	sha1=$(git commit-tree -p initial mesg-with-footer^{tree} <msg) &&
+	git cherry-pick -x $sha1 &&
+	git log -1 --pretty=format:%B >actual &&
+
+	printf "\n(cherry picked from commit %s)\n" $sha1 >>msg &&
+	test_cmp msg actual
+'
+
+test_expect_success 'cherry-pick -x handles commits with no footer and no NL at end of message' '
+	pristine_detach initial &&
+	printf "title\n\nnot a footer" >msg &&
+	sha1=$(git commit-tree -p initial mesg-with-footer^{tree} <msg) &&
+	git cherry-pick -x $sha1 &&
+	git log -1 --pretty=format:%B >actual &&
+
+	printf "\n\n(cherry picked from commit %s)\n" $sha1 >>msg &&
+	test_cmp msg actual
+'
+
+test_expect_success 'cherry-pick -s handles commits with no NL at end of message' '
+	pristine_detach initial &&
+	printf "title\n\nSigned-off-by: A <a@example.com>" >msg &&
+	sha1=$(git commit-tree -p initial mesg-with-footer^{tree} <msg) &&
+	git cherry-pick -s $sha1 &&
+	git log -1 --pretty=format:%B >actual &&
+
+	printf "\nSigned-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>\n" >>msg &&
+	test_cmp msg actual
+'
+
+test_expect_success 'cherry-pick -s handles commits with no footer and no NL at end of message' '
+	pristine_detach initial &&
+	printf "title\n\nnot a footer" >msg &&
+	sha1=$(git commit-tree -p initial mesg-with-footer^{tree} <msg) &&
+	git cherry-pick -s $sha1 &&
+	git log -1 --pretty=format:%B >actual &&
+
+	printf "\n\nSigned-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>\n" >>msg &&
+	test_cmp msg actual
+'
+
 test_expect_success 'cherry-pick -x treats "(cherry picked from..." line as part of footer' '
 	pristine_detach initial &&
 	sha1=$(git rev-parse mesg-with-cherry-footer^0) &&
-- 
2.13.0.rc0.306.g87b477812d-goog

