Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41C1A20A26
	for <e@80x24.org>; Wed, 27 Sep 2017 22:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752160AbdI0Wva (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 18:51:30 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:57201 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751671AbdI0Wv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 18:51:29 -0400
Received: by mail-pf0-f173.google.com with SMTP id g65so7970415pfe.13
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 15:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qG7zil80Ubt/Mxcd7ILhu+maks5zDuW0lsuLXaWW0oU=;
        b=T+BdyWB4wBdceBGY56CD9jncH5wfCOdChvMqpJnoxpuoFw46roVixyYXSfT6i2+a+h
         Up4tLNSBL8n8BGDk/G6biPFjFT27pKnfmwXd91Hn0sGiYPy73v0DAMWV4HPtePmJKOQV
         8PkcoNiycE4QoAG0GeYA8E/gmYlh3LSzVJc4UGfsMMMm7MezFQAJ2uucpfzJR64JCYHS
         kXhO61mXV3Qv/Xo36/My/yXfjQ7hIXHDGTr9tzy2tVyxGQe0glqqiamz4snqHoFdwZED
         p0hTR0VlOaVNwBZIGQTqMeWzF/9/4zh5Zh9Cpcj1px6Qp7mJRXulHWR6PeQ7SpE2DRUY
         +fxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qG7zil80Ubt/Mxcd7ILhu+maks5zDuW0lsuLXaWW0oU=;
        b=GBSKGkJ6OWgEQdZJ94kErAsNRa8Ly9CidXXNo41nLLE1VPI94a6VDpfp6KyHy4twVs
         1IGzkWdUE93vF/oIjYwVOzGsUnrz6h5FzscYOd5DplTq9McjbPi7+JQqq4C8YjsC05K7
         UToecTZPyiIuzKKI0MMOY+V4zthms88jM4rMEVUqn5fPSl1dtxNrdDlp4tHasy2DnrQQ
         N/l6qTBKlGCSkrdy6ORHi/wtuGswobkbcJG5oV7uTtfyEB9hbACKGH7cPWp2x/7fE9Ae
         qjQlXtjjpP9EIDcFfW3ISkUzet7aPdGYFpiI580O6JPDUmk2qRcAsUnhdiDTOfdz5fj6
         2FxA==
X-Gm-Message-State: AHPjjUhJXlSu0QESBrwjt35QpmixpWMTDGK4B9eP+TqzXpHJN3kOCtvZ
        lXHVEQoWfsN9wuY0h7ZYMJRcDw==
X-Google-Smtp-Source: AOwi7QB1zQBxXcwSY9xYp7ujTjYFxuoeONO7/FezloWDa+ng8V9Sl4bDe8Caw4m2BpUWUYMPHN+QYg==
X-Received: by 10.159.244.9 with SMTP id x9mr2394053plr.34.1506552688703;
        Wed, 27 Sep 2017 15:51:28 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:45a1:47cd:f4ee:d772])
        by smtp.gmail.com with ESMTPSA id g68sm68053pfc.64.2017.09.27.15.51.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 27 Sep 2017 15:51:28 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     peff@peff.net
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        torvalds@linux-foundation.org
Subject: [PATCH] diff: correct newline in summary for renamed files
Date:   Wed, 27 Sep 2017 15:51:26 -0700
Message-Id: <20170927225126.4836-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
In-Reply-To: <20170927224909.25dfojhx6wzaqwt7@sigill.intra.peff.net>
References: <20170927224909.25dfojhx6wzaqwt7@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 146fdb0dfe (diff.c: emit_diff_symbol learns about DIFF_SYMBOL_SUMMARY,
2017-06-29), the conversion from direct printing to the symbol emission
dropped the new line character for renamed, copied and rewritten files.

Add the emission of a newline, add a test for this case.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

 Peff, I am undecided about the added 'diff --stat' call as that
 uses a completely different code path and would not show the mode
 change, but I guess we can just use it to document the current state.
 
 Thanks,
 Stefan

 diff.c                                        |  1 +
 t/t4013-diff-various.sh                       | 12 ++++++++++++
 t/t4013/diff.diff-tree_--stat_initial_mode    |  4 ++++
 t/t4013/diff.diff-tree_--summary_initial_mode |  3 +++
 t/t4013/diff.diff-tree_initial_mode           |  3 +++
 t/t4013/diff.log_--decorate=full_--all        |  6 ++++++
 t/t4013/diff.log_--decorate_--all             |  6 ++++++
 7 files changed, 35 insertions(+)
 create mode 100644 t/t4013/diff.diff-tree_--stat_initial_mode
 create mode 100644 t/t4013/diff.diff-tree_--summary_initial_mode
 create mode 100644 t/t4013/diff.diff-tree_initial_mode

diff --git a/diff.c b/diff.c
index 3c6a3e0faa..653bb2e72e 100644
--- a/diff.c
+++ b/diff.c
@@ -5272,6 +5272,7 @@ static void show_mode_change(struct diff_options *opt, struct diff_filepair *p,
 			strbuf_addch(&sb, ' ');
 			quote_c_style(p->two->path, &sb, NULL, 0);
 		}
+		strbuf_addch(&sb, '\n');
 		emit_diff_symbol(opt, DIFF_SYMBOL_SUMMARY,
 				 sb.buf, sb.len, 0);
 		strbuf_release(&sb);
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index d09acfe48e..c515e3e53f 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -90,6 +90,14 @@ test_expect_success setup '
 	git commit -m "Rearranged lines in dir/sub" &&
 	git checkout master &&
 
+	GIT_AUTHOR_DATE="2006-06-26 00:06:00 +0000" &&
+	GIT_COMMITTER_DATE="2006-06-26 00:06:00 +0000" &&
+	export GIT_AUTHOR_DATE GIT_COMMITTER_DATE &&
+	git checkout -b mode initial &&
+	git update-index --chmod=+x file0 &&
+	git commit -m "update mode" &&
+	git checkout -f master &&
+
 	git config diff.renames false &&
 
 	git show-branch
@@ -192,6 +200,10 @@ diff-tree --pretty side
 diff-tree --pretty -p side
 diff-tree --pretty --patch-with-stat side
 
+diff-tree initial mode
+diff-tree --stat initial mode
+diff-tree --summary initial mode
+
 diff-tree master
 diff-tree -p master
 diff-tree -p -m master
diff --git a/t/t4013/diff.diff-tree_--stat_initial_mode b/t/t4013/diff.diff-tree_--stat_initial_mode
new file mode 100644
index 0000000000..0e5943c2c6
--- /dev/null
+++ b/t/t4013/diff.diff-tree_--stat_initial_mode
@@ -0,0 +1,4 @@
+$ git diff-tree --stat initial mode
+ file0 | 0
+ 1 file changed, 0 insertions(+), 0 deletions(-)
+$
diff --git a/t/t4013/diff.diff-tree_--summary_initial_mode b/t/t4013/diff.diff-tree_--summary_initial_mode
new file mode 100644
index 0000000000..25846b6af8
--- /dev/null
+++ b/t/t4013/diff.diff-tree_--summary_initial_mode
@@ -0,0 +1,3 @@
+$ git diff-tree --summary initial mode
+ mode change 100644 => 100755 file0
+$
diff --git a/t/t4013/diff.diff-tree_initial_mode b/t/t4013/diff.diff-tree_initial_mode
new file mode 100644
index 0000000000..c47c09423e
--- /dev/null
+++ b/t/t4013/diff.diff-tree_initial_mode
@@ -0,0 +1,3 @@
+$ git diff-tree initial mode
+:100644 100755 01e79c32a8c99c557f0757da7cb6d65b3414466d 01e79c32a8c99c557f0757da7cb6d65b3414466d M	file0
+$
diff --git a/t/t4013/diff.log_--decorate=full_--all b/t/t4013/diff.log_--decorate=full_--all
index b345b2ebfa..2afe91f116 100644
--- a/t/t4013/diff.log_--decorate=full_--all
+++ b/t/t4013/diff.log_--decorate=full_--all
@@ -1,4 +1,10 @@
 $ git log --decorate=full --all
+commit b7e0bc69303b488b47deca799a7d723971dfa6cd (refs/heads/mode)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:06:00 2006 +0000
+
+    update mode
+
 commit cd4e72fd96faed3f0ba949dc42967430374e2290 (refs/heads/rearrange)
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:06:00 2006 +0000
diff --git a/t/t4013/diff.log_--decorate_--all b/t/t4013/diff.log_--decorate_--all
index 3aa16a9e42..d0f308ab2b 100644
--- a/t/t4013/diff.log_--decorate_--all
+++ b/t/t4013/diff.log_--decorate_--all
@@ -1,4 +1,10 @@
 $ git log --decorate --all
+commit b7e0bc69303b488b47deca799a7d723971dfa6cd (mode)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:06:00 2006 +0000
+
+    update mode
+
 commit cd4e72fd96faed3f0ba949dc42967430374e2290 (rearrange)
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:06:00 2006 +0000
-- 
2.14.0.rc0.3.g6c2e499285

