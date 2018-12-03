Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A847A211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 21:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbeLCVV7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 16:21:59 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40574 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeLCVV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 16:21:59 -0500
Received: by mail-it1-f193.google.com with SMTP id h193so10947455ita.5
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 13:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KxxuA0z/ViKPAxTCThzEoK7CmLyFC+9jAugfbB9axqE=;
        b=PY7z/qN58BlW0j6ffuEQuHoi9v3DozaV0z9bBN/5WFSgy7vRgM0tk4BVcsQ8g4tAvn
         efRjvqtdF/EAQ4HCe5QgxYVD66Wr2pXV2XEl8SHj5h/Pq5hmkVRGon18/fCh/mgtObPM
         ki6PvLNkmEmoacnRuNd4q0GuBOgY6f8zYmBXOo1LR94yqKTJgtG48rh6QltmGc5AF/7O
         gdP01AKOp/iEblhgJ9lluKO0yqJA97toSGv0k4dmMmREq9gjC5ntxN+3mgf0OFpwDaaz
         xybEYu8476UEic9GvdbSNTLHcJSVRy16/EpOkFlvh8LT2fZ+9uTDrdO9zMTpHBh4V8pN
         /f1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=KxxuA0z/ViKPAxTCThzEoK7CmLyFC+9jAugfbB9axqE=;
        b=EmnVUFpJJYNK8JNiYbW6uA7sfToDvLKB4Bs06HA5k3hFc9BvpGM1VZvSPmQbNa7m3k
         Wxny+A23NdBF1XxsWHUAVK2DmnVwZQOy1QJNkChpJKXYYO5iaPFQLKjFLUyVve5OTZ9D
         cDcARe0KNzDdBNzHPc+0ufTu45QSgreZIBmpzYRQolkZnqY6zXuK4TfbC764dkQkahok
         wMZoppjdVenDtYe8DEAXmR90bvoVJcWNW9LRk1R+4n51CkedFpJxmnA68TJD9km1ZLhw
         ykedAAMt48GJVy1/7HD7wz1CUtWRLjdxLfeVEmKlX8jexgkQ41VNAUPtWoXGsJ/7EbLo
         KRVA==
X-Gm-Message-State: AA+aEWa90vCig0GG/kPCYLXEIqpp7HP+1gBw5Uz8NGqp7c1oVE8Gv69m
        DNyF07f4i3nemgVkrILCjiW5Otki
X-Google-Smtp-Source: AFSGD/V2R4XvcNZSPWn+imlKzIMWaUjLXV/3Gcw8eMOlOlNQYiXlk649+lK7QglMkNAdIaj216wRtg==
X-Received: by 2002:a05:660c:54d:: with SMTP id w13mr7469016itk.50.1543872117906;
        Mon, 03 Dec 2018 13:21:57 -0800 (PST)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id y76sm4317315ita.18.2018.12.03.13.21.56
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 03 Dec 2018 13:21:57 -0800 (PST)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3] range-diff: always pass at least minimal diff options
Date:   Mon,  3 Dec 2018 16:21:31 -0500
Message-Id: <20181203212131.11299-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805
In-Reply-To: <20181203200734.527341-1-martin.agren@gmail.com>
References: <20181203200734.527341-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Martin Ågren <martin.agren@gmail.com>

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
only fill in the fields we absolutely require, such as output file and
color.

Modify and extend the existing tests to try and verify that the right
contents end up in the right place.

Don't revert `show_range_diff()`, i.e., let it keep accepting NULL.
Rather than removing what is dead code and figuring out it isn't
actually dead and we've broken 2.20, just leave it for now.

[es: retain diff coloring when going to stdout]

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

This is a re-roll of Martin's v2[1]. The only difference from v2 is that
it retains coloring when emitting to the terminal (plus an in-code
comment was simplified).

The regression introduced by d8981c3f88, in which the range-diff only
ever gets emitted to the terminal, and never to the cover letter or
commentary section of a standalone patch, makes the --range-diff option
rather useless, so this fix probably ought to be fast-tracked. An
alternative would be to rip out all the recent "--range-diff"-related
changes and go with the --range-diff implementation which has been in
use for a few months, even if it is not perfect.

[1]: https://public-inbox.org/git/20181203200734.527341-1-martin.agren@gmail.com/

builtin/log.c         | 11 ++++++++++-
 log-tree.c            | 11 ++++++++++-
 t/t3206-range-diff.sh | 20 +++++++++++++-------
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 5ac18e2848..e8e51068bd 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1094,9 +1094,18 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	}
 
 	if (rev->rdiff1) {
+		/*
+		 * Pass minimum required diff-options to range-diff; others
+		 * can be added later if deemed desirable.
+		 */
+		struct diff_options opts;
+		diff_setup(&opts);
+		opts.file = rev->diffopt.file;
+		opts.use_color = rev->diffopt.use_color;
+		diff_setup_done(&opts);
 		fprintf_ln(rev->diffopt.file, "%s", rev->rdiff_title);
 		show_range_diff(rev->rdiff1, rev->rdiff2,
-				rev->creation_factor, 1, NULL);
+				rev->creation_factor, 1, &opts);
 	}
 }
 
diff --git a/log-tree.c b/log-tree.c
index b243779a0b..10680c139e 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -755,14 +755,23 @@ void show_log(struct rev_info *opt)
 
 	if (cmit_fmt_is_mail(ctx.fmt) && opt->rdiff1) {
 		struct diff_queue_struct dq;
+		struct diff_options opts;
 
 		memcpy(&dq, &diff_queued_diff, sizeof(diff_queued_diff));
 		DIFF_QUEUE_CLEAR(&diff_queued_diff);
 
 		next_commentary_block(opt, NULL);
 		fprintf_ln(opt->diffopt.file, "%s", opt->rdiff_title);
+		/*
+		 * Pass minimum required diff-options to range-diff; others
+		 * can be added later if deemed desirable.
+		 */
+		diff_setup(&opts);
+		opts.file = opt->diffopt.file;
+		opts.use_color = opt->diffopt.use_color;
+		diff_setup_done(&opts);
 		show_range_diff(opt->rdiff1, opt->rdiff2,
-				opt->creation_factor, 1, NULL);
+				opt->creation_factor, 1, &opts);
 
 		memcpy(&diff_queued_diff, &dq, sizeof(diff_queued_diff));
 	}
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
-- 
2.20.0.rc2.403.gdbc3b29805

