Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0410C1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 18:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935984AbdCXSlh (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 14:41:37 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36149 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935940AbdCXSl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 14:41:26 -0400
Received: by mail-wm0-f66.google.com with SMTP id x124so2252715wmf.3
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 11:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kGFgc4YydJ3Dqht2Jpej3uqMckTis9ukCqhdU82qLtA=;
        b=iwpuj1lI2+CLZFRk9CIov2PdOWyJUgKBqIs28/Hz26uGAAo8JMD/Lh0aYwMXr3KLW5
         mfSk9e6IMaEhNJW0C3SnP3XeczTeYvoU76FLhcJBF170jDTK+Tl3hfTPjweCR8T1fpBV
         ststWJ8FrCkBTEfay9C800/V4kuO30wpV7eoJjoTU/U7p583g4Jf02QGtUFLwsq3psMC
         0Eb7YDFMhwfSOslaST/esn0+kvV01yqA6VxyuVagp/oDx6rW5GIUasAdPbRNHnIEKCdT
         Q/TuJKw/VU++3Z7z8Fzr+tGzaU/2gcNp+Xp30dRk9EmOAySfXALeZMLWl16RKq2OfP5n
         TXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kGFgc4YydJ3Dqht2Jpej3uqMckTis9ukCqhdU82qLtA=;
        b=jLGOhWw+6ljtWo6qyagVlbtjkJh6dRs+Eby/ba0VpsCmIiNFx7ax3WCFZdZ02nnCop
         4vAPJLLD3KODTADWvD6ZPGza+WdOwaQN5MKf9TSrv/TIK3Vp2V107+waTCQoNrKzOEbF
         b+qdKkBFxOLerPo7CS7myNut1xAhvQ3gmJN11hPEG7uiKn5Dxn3TILPjmPrQl7RuN6JO
         IYG6itBxRBoCYpr1pNvwJfBNlQmCXrthBI3+VOtdZrQ2JN44XRQ1ZHiMBr7FfUjaGr18
         ofdHtMMmR13uqfK6gPgufztIU6xD2IZnJUk/XCsfZWJcTAlrEb2JCq+4pVYufW4BGVTR
         KM1Q==
X-Gm-Message-State: AFeK/H0K+QcIqiWg/v7bndBrB56CZXUcuC6TujZlUKq063REJGaIDevylZtedZlP5ifrnA==
X-Received: by 10.28.71.87 with SMTP id u84mr4422804wma.101.1490380884636;
        Fri, 24 Mar 2017 11:41:24 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j77sm3440560wmj.3.2017.03.24.11.41.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Mar 2017 11:41:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 04/16] ref-filter: make combining --merged & --no-merged an error
Date:   Fri, 24 Mar 2017 18:40:47 +0000
Message-Id: <20170324184059.5374-5-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170324184059.5374-1-avarab@gmail.com>
References: <20170324184059.5374-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the behavior of specifying --merged & --no-merged to be an
error, instead of silently picking the option that was provided last.

Subsequent changes of mine add a --no-contains option in addition to
the existing --contains. Providing both of those isn't an error, and
has actual meaning.

Making its cousins have different behavior in this regard would be
confusing to the user, especially since we'd be silently disregarding
some of their command-line input.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-branch.txt       |  6 ++++--
 Documentation/git-for-each-ref.txt |  6 ++++--
 Documentation/git-tag.txt          |  4 ++--
 ref-filter.c                       | 11 ++++++++++-
 t/t3200-branch.sh                  |  4 ++++
 t/t6302-for-each-ref-filter.sh     |  4 ++++
 t/t7004-tag.sh                     |  4 ++++
 7 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 092f1bcf9f..e465298571 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -215,11 +215,13 @@ start-point is either a local or remote-tracking branch.
 
 --merged [<commit>]::
 	Only list branches whose tips are reachable from the
-	specified commit (HEAD if not specified). Implies `--list`.
+	specified commit (HEAD if not specified). Implies `--list`,
+	incompatible with `--no-merged`.
 
 --no-merged [<commit>]::
 	Only list branches whose tips are not reachable from the
-	specified commit (HEAD if not specified). Implies `--list`.
+	specified commit (HEAD if not specified). Implies `--list`,
+	incompatible with `--merged`.
 
 <branchname>::
 	The name of the branch to create or delete.
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 111e1be6f5..4d55893712 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -69,11 +69,13 @@ OPTIONS
 
 --merged [<object>]::
 	Only list refs whose tips are reachable from the
-	specified commit (HEAD if not specified).
+	specified commit (HEAD if not specified),
+	incompatible with `--no-merged`.
 
 --no-merged [<object>]::
 	Only list refs whose tips are not reachable from the
-	specified commit (HEAD if not specified).
+	specified commit (HEAD if not specified),
+	incompatible with `--merged`.
 
 --contains [<object>]::
 	Only list refs which contain the specified commit (HEAD if not
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 3abf912782..448fdf3743 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -126,11 +126,11 @@ This option is only applicable when listing tags without annotation lines.
 
 --merged [<commit>]::
 	Only list tags whose commits are reachable from the specified
-	commit (`HEAD` if not specified).
+	commit (`HEAD` if not specified), incompatible with `--no-merged`.
 
 --no-merged [<commit>]::
 	Only list tags whose commits are not reachable from the specified
-	commit (`HEAD` if not specified).
+	commit (`HEAD` if not specified), incompatible with `--merged`.
 
 --points-at <object>::
 	Only list tags of the given object.
diff --git a/ref-filter.c b/ref-filter.c
index 9c82b5b9d6..d7efae7b53 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2084,8 +2084,17 @@ int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset)
 {
 	struct ref_filter *rf = opt->value;
 	unsigned char sha1[20];
+	int no_merged = starts_with(opt->long_name, "no");
 
-	rf->merge = starts_with(opt->long_name, "no")
+	if (rf->merge) {
+		if (no_merged) {
+			return opterror(opt, "is incompatible with --merged", 0);
+		} else {
+			return opterror(opt, "is incompatible with --no-merged", 0);
+		}
+	}
+
+	rf->merge = no_merged
 		? REF_FILTER_MERGED_OMIT
 		: REF_FILTER_MERGED_INCLUDE;
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 9f353c0efc..fe62e7c775 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -978,6 +978,10 @@ test_expect_success '--merged catches invalid object names' '
 	test_must_fail git branch --merged 0000000000000000000000000000000000000000
 '
 
+test_expect_success '--merged is incompatible with --no-merged' '
+	test_must_fail git branch --merged HEAD --no-merged HEAD
+'
+
 test_expect_success 'tracking with unexpected .fetch refspec' '
 	rm -rf a b c d &&
 	git init a &&
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index a09a1a46ef..d36d5dc124 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -421,4 +421,8 @@ test_expect_success 'check %(if:notequals=<string>)' '
 	test_cmp expect actual
 '
 
+test_expect_success '--merged is incompatible with --no-merged' '
+	test_must_fail git for-each-ref --merged HEAD --no-merged HEAD
+'
+
 test_done
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index b4698ab5f5..45790664c1 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1748,6 +1748,10 @@ test_expect_success '--merged cannot be used in non-list mode' '
 	test_must_fail git tag --merged=mergetest-2 foo
 '
 
+test_expect_success '--merged is incompatible with --no-merged' '
+	test_must_fail git tag --merged HEAD --no-merged HEAD
+'
+
 test_expect_success '--merged shows merged tags' '
 	cat >expect <<-\EOF &&
 	mergetest-1
-- 
2.11.0

