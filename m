Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E06F211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 20:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbeLCUIZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 15:08:25 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38237 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLCUIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 15:08:25 -0500
Received: by mail-lf1-f66.google.com with SMTP id p86so10157167lfg.5
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 12:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iWuXSfcQnsXyvLPoCZl2IhH1TQE2LdJNfWisi2orp9M=;
        b=N+czdytY80VeZJv0RJJl9biFsU7aDISEtfXX/TwoJnOpdlWNcn82hp/pjDnW6hUUbW
         vpmycSNz75DIO87s3J9KnJuVkJFd+w1RcfNMBdWpQI+5qTAD8vj42Grug368DvNWIAQZ
         OMkViTVC++g7RcUSIsPmrDSRGhgPZ46LEcJU7tYrmrKxAjg9LDz1eTn5TvgJzNgq5ZaL
         Agfbi/1duJEvmg1kjqD8Db+uy/JPgA+I01+qLJ7apAMWlMcKnyKqog1lZw/dRDuLLxHc
         3D9fTSafTdpwYDZ15hMDphTmvVYVxAJQ2zY9X4poFlXkoMYAOJNPWge7mWnrNbOzdn+Q
         3uqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iWuXSfcQnsXyvLPoCZl2IhH1TQE2LdJNfWisi2orp9M=;
        b=g6XF13jhdickBdrCgnRXx6fo2FqDnZCZZpHcCSWeh4NRtUxcOIfOyOBDzFsbwb4zVN
         WedbVN3kBSSU6fowAIJDceq/UTf8DTf/Q7g+FNXC7sXgJ3EPxs0G7h7K/OGKj3bLgab9
         EiZRfIwNQfKRaFjSTHUqbNJElj0qkwQ+gIf4LFusTu1qHM7ZfCCE0TI8WORBJ8fxkuiZ
         FZCWS0vypTmDhQaw5MPSpyENUVCA6vKYgXxZ5CiB6hWPb0jkNcn+VUvsHadvTU4UR7an
         aOrtj4KGMxgqlD9xx/DOOluVhRO0TL/ycEvF885QT2YFEtD3nNpBOIQo/7w9Cd95slWy
         CaKw==
X-Gm-Message-State: AA+aEWalTkqlKPhk17oRAtqFg55bMK0v2Vg3lrKewJmeLgZYcgjDBSII
        dvfdwdti8MmkbWvxANhAK7UJd4mY
X-Google-Smtp-Source: AFSGD/VlsF3+MDxzoyf5/b75n0P/wgSttMEE0IeKeby9Idye7sRElNXb+XwBTOyx7IUkld1sjqPHRA==
X-Received: by 2002:a19:5a05:: with SMTP id o5mr10741831lfb.140.1543867699016;
        Mon, 03 Dec 2018 12:08:19 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id v5-v6sm2696153lje.78.2018.12.03.12.08.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 12:08:18 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] range-diff: always pass at least minimal diff options
Date:   Mon,  3 Dec 2018 21:07:34 +0100
Message-Id: <20181203200734.527341-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.1.gfcc5f94f1e
In-Reply-To: <CAN0heSrfH39-37KDU3XDhxiYs1_3eUMdjbdAm37cPAmnOYUZMA@mail.gmail.com>
References: <CAN0heSrfH39-37KDU3XDhxiYs1_3eUMdjbdAm37cPAmnOYUZMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit d8981c3f88 ("format-patch: do not let its diff-options affect
--range-diff", 2018-11-30) taught `show_range_diff()` to accept a
NULL-pointer as an indication that it should use its own "reasonable
default". That fixed a regression from a5170794 ("Merge branch
'ab/range-diff-no-patch'", 2018-11-18), but unfortunately it introduced
a regression of its own.

In particular, it means we forget the `file` member of the diff options,
so rather than placing a range-diff in the cover-letter, we write it to
stdout. In order to fix this, rewrite the two callers adjusted by
d8981c3f88 to instead create a "dummy" set of diff options where they
only fill in which file to use.

Plus, turn off coloring to make sure we don't write any color codes.
Maybe we could do `opts.use_color = opts.file != stdout`, but for now,
I'd much rather always write uncolored output than write color codes
where there shouldn't be any.

Modify and extend the existing tests to try and verify that the right
contents end up in the right place.

Don't revert `show_range_diff()`, i.e., let it keep accepting NULL.
Rather than removing what is dead code and figuring out it isn't
actually dead and we've broken 2.20, just leave it for now.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
Here's another attempt at fixing this recent regression.

 t/t3206-range-diff.sh | 20 +++++++++++++-------
 builtin/log.c         | 13 ++++++++++++-
 log-tree.c            | 13 ++++++++++++-
 3 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index e497c1358f..048feaf6dd 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -248,18 +248,24 @@ test_expect_success 'dual-coloring' '
 for prev in topic master..topic
 do
 	test_expect_success "format-patch --range-diff=$prev" '
-		git format-patch --stdout --cover-letter --range-diff=$prev \
+		git format-patch --cover-letter --range-diff=$prev \
 			master..unmodified >actual &&
-		grep "= 1: .* s/5/A" actual &&
-		grep "= 2: .* s/4/A" actual &&
-		grep "= 3: .* s/11/B" actual &&
-		grep "= 4: .* s/12/B" actual
+		test_when_finished "rm 000?-*" &&
+		test_line_count = 5 actual &&
+		test_i18ngrep "^Range-diff:$" 0000-* &&
+		grep "= 1: .* s/5/A" 0000-* &&
+		grep "= 2: .* s/4/A" 0000-* &&
+		grep "= 3: .* s/11/B" 0000-* &&
+		grep "= 4: .* s/12/B" 0000-*
 	'
 done
 
 test_expect_success 'format-patch --range-diff as commentary' '
-	git format-patch --stdout --range-diff=HEAD~1 HEAD~1 >actual &&
-	test_i18ngrep "^Range-diff:$" actual
+	git format-patch --range-diff=HEAD~1 HEAD~1 >actual &&
+	test_when_finished "rm 0001-*" &&
+	test_line_count = 1 actual &&
+	test_i18ngrep "^Range-diff:$" 0001-* &&
+	grep "> 1: .* new message" 0001-*
 '
 
 test_done
diff --git a/builtin/log.c b/builtin/log.c
index 5ac18e2848..e42487b46d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1094,9 +1094,20 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	}
 
 	if (rev->rdiff1) {
+		/*
+		 * (At least for now) we only want to pass down
+		 * the file handle where we want the range-diff
+		 * to appear. Avoid any other diff options until
+		 * we know how we want to handle them.
+		 */
+		struct diff_options opts;
+		diff_setup(&opts);
+		opts.file = rev->diffopt.file;
+		opts.use_color = 0;
+		diff_setup_done(&opts);
 		fprintf_ln(rev->diffopt.file, "%s", rev->rdiff_title);
 		show_range_diff(rev->rdiff1, rev->rdiff2,
-				rev->creation_factor, 1, NULL);
+				rev->creation_factor, 1, &opts);
 	}
 }
 
diff --git a/log-tree.c b/log-tree.c
index b243779a0b..fd79a3ec37 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -755,14 +755,25 @@ void show_log(struct rev_info *opt)
 
 	if (cmit_fmt_is_mail(ctx.fmt) && opt->rdiff1) {
 		struct diff_queue_struct dq;
+		struct diff_options opts;
 
 		memcpy(&dq, &diff_queued_diff, sizeof(diff_queued_diff));
 		DIFF_QUEUE_CLEAR(&diff_queued_diff);
 
 		next_commentary_block(opt, NULL);
 		fprintf_ln(opt->diffopt.file, "%s", opt->rdiff_title);
+		/*
+		 * (At least for now) we only want to pass down
+		 * the file handle where we want the range-diff
+		 * to appear. Avoid any other diff options until
+		 * we know how we want to handle them.
+		 */
+		diff_setup(&opts);
+		opts.file = opt->diffopt.file;
+		opts.use_color = 0;
+		diff_setup_done(&opts);
 		show_range_diff(opt->rdiff1, opt->rdiff2,
-				opt->creation_factor, 1, NULL);
+				opt->creation_factor, 1, &opts);
 
 		memcpy(&diff_queued_diff, &dq, sizeof(diff_queued_diff));
 	}
-- 
2.20.0.rc2.1.gfcc5f94f1e

