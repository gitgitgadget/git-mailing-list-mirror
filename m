Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB3DC207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 23:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1955420AbdDYX6U (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 19:58:20 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34545 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1955417AbdDYX6S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 19:58:18 -0400
Received: by mail-pf0-f174.google.com with SMTP id c198so33279295pfc.1
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 16:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RyISEtVNn8nsmrBoNqU7iwA/hkHy2aHkdy9o5iNBpgQ=;
        b=i62DYw4LEWvSs0XGm3ybrB+82GcUZ19rCm/Kj3G2NIhFUxq573i3+kTzV426HiHww0
         3XbDQcNd8tWReA5U74G1xAu2azbuBFz+Xelzp2tT8v4SWBMCMh9AKa7nI0SNomOr9zuC
         OG8oOImlCAWyaqdC7Zl69byLml+Wi10dxOWUqEbmMZ55XTPA37UnzcqxcuvR/q3snduT
         bHnq5xUNkof/jyWZD4gl3LlGUIh1XMbU07kaAQxcivIeqc0MJL8UR1L6ZhIvM34RRTjf
         WtWfZE4KUMD7YDQYs+oiSp5lbSK/4tGNwpBPyn+jkLTqtAf2eXWzSerAUtsnyKQd70gE
         DlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RyISEtVNn8nsmrBoNqU7iwA/hkHy2aHkdy9o5iNBpgQ=;
        b=UYNQtGjDkIKMDFKdQwhzzEWL1ndjoZ0WiI5ynEyJZuAmWTXME96i5R8Qq3yW9ogINu
         j0WuKAJqfjM5vyKVMxhxhn7+ERpnXaC7oynfl+fpRyWPmFmliBt0xheUrHmRtfPyKGnq
         dT0YwUFWalWs0wmZIBis1wLk6ZIyENcuRQfFQ7+h+dK4e4/5nrbKmp2tiI0prEUjeIYI
         aMdNsKHQP5dSj7TvLIKuhccHA6xDdPNM4QYnuneYmd3xnfdoGshRMefk29DGe3F2Ou4s
         mHIvqm4u4NtHUhgKLLJhV683N3Yg3iuoqpwPsty0ZrYlGhn2MhDTk/uYHB0D2EUcfqqR
         EVTA==
X-Gm-Message-State: AN3rC/654S6kKqSw/eiPT4C1x15FH2v8qcZX44A1Ela2JuRhTZ1Jdnox
        Tj7KLRoXY06m3yRN
X-Received: by 10.84.233.203 with SMTP id m11mr39949515pln.177.1493164674180;
        Tue, 25 Apr 2017 16:57:54 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id m4sm38440323pgm.25.2017.04.25.16.57.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 16:57:52 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        sbeller@google.com, computersforpeace@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: [PATCH v2] sequencer: require trailing NL in footers
Date:   Tue, 25 Apr 2017 16:57:41 -0700
Message-Id: <20170425235741.32546-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d-goog
In-Reply-To: <20170425190651.8910-1-jonathantanmy@google.com>
References: <20170425190651.8910-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit 967dfd4 ("sequencer: use trailer's trailer layout",
2016-11-29), sequencer was taught to use the same mechanism as
interpret-trailers to determine the nature of the trailer of a commit
message (referred to as the "footer" in sequencer.c). However, the
requirement that a footer end in a newline character was inadvertently
removed. Restore that requirement.

While writing this commit, I noticed that if the "ignore_footer"
parameter in "has_conforming_footer" is greater than the distance
between the trailer start and sb->len, "has_conforming_footer" will
return an unexpected result. This does not occur in practice, because
"ignore_footer" is either zero or the return value of an invocation to
"ignore_non_trailer", which only skips empty lines and comment lines.
This commit contains a comment explaining this in the function's
documentation.

Reported-by: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---

jrnieder pointed out the existence of commit-tree to me, which I have
used to write the test below.

Changes from v1:
 - added test
 - used one of sbeller's documentation suggestions

 sequencer.c              | 11 +++++++++++
 t/t3511-cherry-pick-x.sh | 14 ++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 77afecaeb..500a76260 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -151,6 +151,12 @@ static const char *get_todo_path(const struct replay_opts *opts)
  * Returns 1 for conforming footer
  * Returns 2 when sob exists within conforming footer
  * Returns 3 when sob exists within conforming footer as last entry
+ *
+ * A footer that does not end in a newline is considered non-conforming.
+ *
+ * ignore_footer, if not zero, should be the return value of an invocation to
+ * ignore_non_trailer(). See the documentation of that function for more
+ * information.
  */
 static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
 	int ignore_footer)
@@ -159,6 +165,11 @@ static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
 	int i;
 	int found_sob = 0, found_sob_last = 0;
 
+	if (sb->len <= ignore_footer)
+		return 0;
+	if (sb->buf[sb->len - ignore_footer - 1] != '\n')
+		return 0;
+
 	trailer_info_get(&info, sb->buf);
 
 	if (info.trailer_start == info.trailer_end)
diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
index bf0a5c988..6f518020b 100755
--- a/t/t3511-cherry-pick-x.sh
+++ b/t/t3511-cherry-pick-x.sh
@@ -208,6 +208,20 @@ test_expect_success 'cherry-pick -x -s adds sob even when trailing sob exists fo
 	test_cmp expect actual
 '
 
+test_expect_success 'cherry-pick -x handles commits with no NL at end of message' '
+	pristine_detach initial &&
+	sha1=$(printf "title\n\nSigned-off-by: a" | git commit-tree -p initial mesg-with-footer^{tree}) &&
+	git cherry-pick -x $sha1 &&
+	cat <<-EOF >expect &&
+		title
+
+		Signed-off-by: a
+		(cherry picked from commit $sha1)
+	EOF
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'cherry-pick -x treats "(cherry picked from..." line as part of footer' '
 	pristine_detach initial &&
 	sha1=$(git rev-parse mesg-with-cherry-footer^0) &&
-- 
2.13.0.rc0.306.g87b477812d-goog

