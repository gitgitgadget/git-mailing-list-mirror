Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E61C20357
	for <e@80x24.org>; Mon, 17 Jul 2017 20:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751381AbdGQULw (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 16:11:52 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36235 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751349AbdGQULs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 16:11:48 -0400
Received: by mail-lf0-f65.google.com with SMTP id c199so4973lfg.3
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 13:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rYmLcrX1RltwxQKIKHm9r2ZyLA4eSn48Wd/Cs5ftHl4=;
        b=tnmgXT5hs1W/30L1VEe5mw0h4vWZOoITsYjTd6yyO6zTyuCnebyMQNa0Mob9X/zWEv
         uHpVGUnX0BfUa0wrEKoW3P3TRXgtrXu4PAPYtAQtY/YH+9D0XcXHV0iDYFPN8d2xUxyx
         kvMRih1lqLvQmydqalo2q/2gJdylXGHQxQu/9a+Htf1DUf5GxIGRMPCG/xtVWy5gBcKz
         dlA8jmKdZN48s0FEhH7i99C+O/qIPHE4/RUrhho7/9QQBflJeccNBeK/kA+SqKNHi+MN
         t0kkYU2Vp4IctLAkuN79ZNPQWbAhggdT2nAx1q0/PeEUL6YEHomSUtYoLQ7f1jhyI3Pn
         8hPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rYmLcrX1RltwxQKIKHm9r2ZyLA4eSn48Wd/Cs5ftHl4=;
        b=EW1Ak4TYQqO4SU/pY85z6JOZnWT1r23zlzKLSERsznAJZCd6N6qojxczIjLl/DKrvi
         Yo0DXnztFvqaqfbcJIZgvJt9izvjxVH0f8jjbDaTLM5YSQ0ev+EtORu6+BUgYQP7TxjV
         3w4lChF/YAysDE5/h1TwnDBZoowOT9pWgGanKmaoaXwh9J8thTP40b9/5/Q16BPXC8PM
         qwXUG59gwWC0Apcm2xwIVOgdESdbdG5WuCzH89XHpJjGFK65U5xzRM+Y2ppaBv7U+Tqo
         O0aoVZB25kBCSFOB85WGwdB574Y8BmBpXboJUdlFf2mbdM79SPz0XTbfSje7EtJyhoWW
         /r/g==
X-Gm-Message-State: AIVw111Lws4so+hzF34fy/iuf1rvHzjkd68ooAY0hAFx2YctFu254anW
        dhItIn+ytOJ/sLRc
X-Received: by 10.46.19.25 with SMTP id 25mr4666611ljt.67.1500322306294;
        Mon, 17 Jul 2017 13:11:46 -0700 (PDT)
Received: from localhost.localdomain (c83-248-253-33.bredband.comhem.se. [83.248.253.33])
        by smtp.gmail.com with ESMTPSA id l12sm30752ljb.39.2017.07.17.13.11.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Jul 2017 13:11:45 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 08/10] tag: respect `pager.tag` in list-mode only
Date:   Mon, 17 Jul 2017 22:10:50 +0200
Message-Id: <ca309a7d46027c2804b82813600aaf96f65ca01b.1500321658.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.0.rc0
In-Reply-To: <cover.1500321657.git.martin.agren@gmail.com>
References: <cover.1499723297.git.martin.agren@gmail.com> <cover.1500321657.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using, e.g., `git -c pager.tag tag -a new-tag` results in errors such as
"Vim: Warning: Output is not to a terminal" and a garbled terminal. A
user who makes use of `git tag -a` and `git tag -l` will probably choose
not to configure `pager.tag` or to set it to "no", so that `git tag -a`
will actually work, at the cost of not getting the pager with `git tag
-l`.

Teach git tag to only respect `pager.tag` when running in list-mode.
Update the documentation and update tests.

If an alias is used to run `git tag -a`, then `pager.tag` will still be
respected. Document this known breakage. It will be fixed in a later
commit. Add a similar test for `-l`, which works as it should.

Noticed-by: Anatoly Borodin <anatoly.borodin@gmail.com>
Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-tag.txt |  3 +++
 t/t7006-pager.sh          | 25 +++++++++++++++++++++----
 builtin/tag.c             |  3 ++-
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 1eb15afa1..875d135e0 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -205,6 +205,9 @@ it in the repository configuration as follows:
     signingKey = <gpg-keyid>
 -------------------------------------
 
+`pager.tag` is only respected when listing tags, i.e., when `-l` is
+used or implied.
+See linkgit:git-config[1].
 
 DISCUSSION
 ----------
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index e7430bc93..a357436e1 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -187,18 +187,35 @@ test_expect_success TTY 'git tag -a defaults to not paging' '
 	! test -e paginated.out
 '
 
-test_expect_success TTY 'git tag -a respects pager.tag' '
+test_expect_success TTY 'git tag -a ignores pager.tag' '
 	test_when_finished "git tag -d newtag" &&
 	rm -f paginated.out &&
 	test_terminal git -c pager.tag tag -am message newtag &&
-	test -e paginated.out
+	! test -e paginated.out
 '
 
 test_expect_success TTY 'git tag -a respects --paginate' '
 	test_when_finished "git tag -d newtag" &&
 	rm -f paginated.out &&
-	test_terminal git -c pager.tag=false --paginate \
-		tag -am message newtag &&
+	test_terminal git --paginate tag -am message newtag &&
+	test -e paginated.out
+'
+
+test_expect_failure TTY 'git tag as alias ignores pager.tag with -a' '
+	# git-tag will be launched as a dashed external, which
+	# 1) is the source of a potential bug, and
+	# 2) is why we use test_config and not -c.
+	test_when_finished "git tag -d newtag" &&
+	rm -f paginated.out &&
+	test_config pager.tag true &&
+	test_terminal git -c alias.t=tag t -am message newtag &&
+	! test -e paginated.out
+'
+
+test_expect_success TTY 'git tag as alias respects pager.tag with -l' '
+	rm -f paginated.out &&
+	test_config pager.tag true &&
+	test_terminal git -c alias.t=tag t -l &&
 	test -e paginated.out
 '
 
diff --git a/builtin/tag.c b/builtin/tag.c
index 9eda434fb..5ad1af252 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -461,7 +461,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			cmdmode = 'l';
 	}
 
-	setup_auto_pager("tag", 0);
+	if (cmdmode == 'l')
+		setup_auto_pager("tag", 0);
 
 	if ((create_tag_object || force) && (cmdmode != 0))
 		usage_with_options(git_tag_usage, options);
-- 
2.14.0.rc0

