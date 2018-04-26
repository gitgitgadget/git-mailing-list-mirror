Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.3 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EA02215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 15:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754802AbeD3P4b (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 11:56:31 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38953 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754690AbeD3P43 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 11:56:29 -0400
Received: by mail-pg0-f65.google.com with SMTP id b9-v6so6582436pgf.6
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 08:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=b3Qiqn1hAtng4nx6hsyMme98CcD1kCaPsotV/deSTgQ=;
        b=Makbab7bcq3327maMglpkPRVL31EnmDF6bNs1p3LAC0MELDICswWoY7mS902zL19B+
         vlvjAFHgv2XM9eJS3L8POaVmQHTPDzdcqI9yxbkuZFUlHHU9FOtIAaZFlVTo4RWKeuTD
         YsqUUXP+EDUii5kHVTjMBct/1D30QU6GIrRFX+c3bRAs+nHthn5JTRZfOAlIJydMZkFC
         4DJe8O+2qmKvObLWQ8SkXv3Ji6LYRypwjI9xu5/MdIdaSDYDQyxNdoFaelY/SZEhkY6K
         IrnG77ZUkk++rZQ4XxY6vjJ8GAeoxf4F62gd5L1skloeOVDA+0nyX/J5xwWfCBuy+K9/
         ygog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=b3Qiqn1hAtng4nx6hsyMme98CcD1kCaPsotV/deSTgQ=;
        b=WlMFAUpEun9nPqy5CqDkd16yX1Nyyvwc6mOdM9STm709coByH3t9de2mWtMc4SWe16
         OW/ZzntQ3zTCely40hSAbtgZxc84hw2K1h01XFXp0T6ga6qNyiLjAvdrAAm12qgh/k74
         O9yABMqcJbmbn3niug0Q7OSMXfDtqVy82U7hheebTrmv+960VclIpCzWntquY7LSjYhV
         SIg7yoUFA0NoU3eIMbB1ScN1wZgdxay2hSHJz0ajNq3RBk5BsEdTDuUiFYmI2UkIW5ex
         ZqtnTjrbmDjOCiL5WcIYXBMj8uJWklOF6nLt2Nkj7YhYg7KG2Wbtw5y6oFJxSGmvTOUt
         65og==
X-Gm-Message-State: ALQs6tAscSKAyefwZ1B8aiI/CCjhldYuKCpdZdjX7jw3i+Y4EnNwTiwX
        XRYQdr1CajsTBEUiVuwTujJ5nF8L
X-Google-Smtp-Source: AB8JxZq9xpISp/AbSsRZv5olQogxFt+3AZb1ZzthLONCs2O9eNz8QJka/IxeGro4uVhP28UvXFsu2Q==
X-Received: by 2002:a17:902:64d0:: with SMTP id y16-v6mr12711678pli.349.1525103788648;
        Mon, 30 Apr 2018 08:56:28 -0700 (PDT)
Received: from localhost.localdomain (adsl-76-236-28-204.dsl.chi2ca.sbcglobal.net. [76.236.28.204])
        by smtp.gmail.com with ESMTPSA id a12sm19392146pfe.78.2018.04.30.08.56.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Apr 2018 08:56:28 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v2 1/2] commit: fix --short and --porcelain options
Date:   Thu, 26 Apr 2018 05:25:23 -0400
Message-Id: <20180426092524.25264-2-sxlijin@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180426092524.25264-1-sxlijin@gmail.com>
References: <20180426092524.25264-1-sxlijin@gmail.com>
In-Reply-To: <20180418030655.19378-1-sxlijin@gmail.com>
References: <20180418030655.19378-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark the commitable flag in the wt_status object in the call to
`wt_status_collect()`, instead of in `wt_longstatus_print_updated()`,
and simplify the logic in the latter function to take advantage of the
logic shifted to the former. This means that callers do not need to use
`wt_longstatus_print_updated()` to collect the `commitable` flag;
calling `wt_status_collect()` is sufficient.

As a result, invoking `git commit` with `--short` or `--porcelain`
(which imply `--dry-run`, but previously returned an inconsistent error
code inconsistent with dry run behavior) correctly returns status code
zero when there is something to commit. This fixes two bugs documented
in the test suite.

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
 t/t7501-commit.sh |  4 ++--
 wt-status.c       | 38 +++++++++++++++++++++++++++-----------
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index fa61b1a4e..85a8217fd 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -87,12 +87,12 @@ test_expect_success '--dry-run with stuff to commit returns ok' '
 	git commit -m next -a --dry-run
 '
 
-test_expect_failure '--short with stuff to commit returns ok' '
+test_expect_success '--short with stuff to commit returns ok' '
 	echo bongo bongo bongo >>file &&
 	git commit -m next -a --short
 '
 
-test_expect_failure '--porcelain with stuff to commit returns ok' '
+test_expect_success '--porcelain with stuff to commit returns ok' '
 	echo bongo bongo bongo >>file &&
 	git commit -m next -a --porcelain
 '
diff --git a/wt-status.c b/wt-status.c
index 50815e5fa..2e5452731 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -718,6 +718,19 @@ static void wt_status_collect_untracked(struct wt_status *s)
 		s->untracked_in_ms = (getnanotime() - t_begin) / 1000000;
 }
 
+static void wt_status_mark_commitable(struct wt_status *s) {
+	int i;
+
+	for (i = 0; i < s->change.nr; i++) {
+		struct wt_status_change_data *d = (s->change.items[i]).util;
+
+		if (d->index_status && d->index_status != DIFF_STATUS_UNMERGED) {
+			s->commitable = 1;
+			return;
+		}
+	}
+}
+
 void wt_status_collect(struct wt_status *s)
 {
 	wt_status_collect_changes_worktree(s);
@@ -726,7 +739,10 @@ void wt_status_collect(struct wt_status *s)
 		wt_status_collect_changes_initial(s);
 	else
 		wt_status_collect_changes_index(s);
+
 	wt_status_collect_untracked(s);
+
+	wt_status_mark_commitable(s);
 }
 
 static void wt_longstatus_print_unmerged(struct wt_status *s)
@@ -754,26 +770,26 @@ static void wt_longstatus_print_unmerged(struct wt_status *s)
 
 static void wt_longstatus_print_updated(struct wt_status *s)
 {
-	int shown_header = 0;
 	int i;
 
+	if (!s->commitable) {
+		return;
+	}
+
+	wt_longstatus_print_cached_header(s);
+
 	for (i = 0; i < s->change.nr; i++) {
 		struct wt_status_change_data *d;
 		struct string_list_item *it;
 		it = &(s->change.items[i]);
 		d = it->util;
-		if (!d->index_status ||
-		    d->index_status == DIFF_STATUS_UNMERGED)
-			continue;
-		if (!shown_header) {
-			wt_longstatus_print_cached_header(s);
-			s->commitable = 1;
-			shown_header = 1;
+		if (d->index_status &&
+		    d->index_status != DIFF_STATUS_UNMERGED) {
+			wt_longstatus_print_change_data(s, WT_STATUS_UPDATED, it);
 		}
-		wt_longstatus_print_change_data(s, WT_STATUS_UPDATED, it);
 	}
-	if (shown_header)
-		wt_longstatus_print_trailer(s);
+
+	wt_longstatus_print_trailer(s);
 }
 
 /*
-- 
2.17.0

