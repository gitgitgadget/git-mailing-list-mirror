Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666EEEC873E
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 16:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243590AbjIGQur (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 12:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243038AbjIGQuq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 12:50:46 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25DD171C
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 09:50:19 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so148532666b.3
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 09:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694105027; x=1694709827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CudVLzGFJgo4zZ4d2+8qJM8WR7188itEz7HYc1E4dLE=;
        b=cPne/t3IFv7HJkS1kPOUyDgb0TPicYbmUbEKOoKw/HV+ZP+994gn9R5B6711ghI/qd
         16fxUYK9vF2DzbfiaqpxvHP3qgkKOX+s4sj3KCSNoX7xZc3DzpetM1OauQm0Px2UNhGZ
         AS2fAEt+4GBRddclUPhnnO6JXtNOq61IjyRkxDVf7s+f2Zrbn4vLGaKgiI1ALzFkapU6
         eJJtf2L0vyalW33/oUGY/Y4C72FJ5rAttB17CCe2WIy1OCB613x5b6LqnHInIXfbf5VY
         Bn/O3vqKsxShhvik6CN059f4LoC8Kp/dRdtR+8idmNOuUKLIwXFs0NhxN8x8NoVkrTXu
         dtrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694105027; x=1694709827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CudVLzGFJgo4zZ4d2+8qJM8WR7188itEz7HYc1E4dLE=;
        b=O/N3iykwT1DgRcISCiI5/QSg08O1w5TRCJh1cUWeWUYex80qsiUQ5aqxM7DeYy4x/L
         ENyxQEXRzRpylZmd3+qrOu9iLSdzYjQ0lnXwGpj1goF5qGhu0gZ1zwxzuvIDgJDVih/I
         22XAVrx0r44Qe+pSOyIvmZGC+j8ewPscXs8By1qqoao9HnaQv8xVvNa10/dHBDwlF19x
         XM3rTn+DNZcqz7fONv+UJh91fquXpDlrV3COtYnh9Yxq1iJH9kn1WiY2Rv5XPeOrxUj+
         TVYTmxc7BR0c8aLCVjEGrSCJU7QcsmCDkjHsCmZZGjv2Su+8om4TIK3oQZ2qH8CDUjqX
         2EWQ==
X-Gm-Message-State: AOJu0YyRgnv38zZpr8rNjhD3w5i5v+onzJucykwfKXCq353yOoOIHqli
        H8t9SIN+uFk3u+aYM57mcC6vsKg0IsQ=
X-Google-Smtp-Source: AGHT+IFqc7I0JuU8pKNofJPkCjijygPm29THxWJcLstGus38EDysfYwWEGtxUGTIMDdOV2aw15xuAg==
X-Received: by 2002:adf:f38e:0:b0:315:8a13:ef17 with SMTP id m14-20020adff38e000000b003158a13ef17mr4474149wro.65.1694078935600;
        Thu, 07 Sep 2023 02:28:55 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:3385:ce2d:69dd:303e])
        by smtp.gmail.com with ESMTPSA id y8-20020adff148000000b00317c742ca9asm22491522wro.43.2023.09.07.02.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 02:28:55 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>,
        Christian Couder <christian.couder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 12/15] replay: disallow revision specific options and pathspecs
Date:   Thu,  7 Sep 2023 11:25:18 +0200
Message-ID: <20230907092521.733746-13-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.126.gcf8c984877
In-Reply-To: <20230907092521.733746-1-christian.couder@gmail.com>
References: <20230602102533.876905-1-christian.couder@gmail.com>
 <20230907092521.733746-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A previous commit changed `git replay` to make it accept standard
revision ranges using the setup_revisions() function. While this is a
good thing to make this command more standard and more flexible, it has
the downside of enabling many revision related options accepted and eaten
by setup_revisions().

Some of these options might make sense, but others, like those
generating non-contiguous history, might not. Anyway those we might want
to allow should probably be tested and perhaps documented a bit, which
could be done in future work.

For now it is just simpler and safer to just disallow all of them, so
let's do that.

Other commands, like `git fast-export`, currently allow all these
revision specific options even though some of them might not make sense,
as these commands also use setup_revisions() but do not check the
options that might be passed to this function.

So a way to fix those commands as well as git replay could be to improve
or refactor the setup_revisions() mechanism to let callers allow and
disallow options in a relevant way for them. Such improvements are
outside the scope of this work though.

Pathspecs, which are also accepted and eaten by setup_revisions(), are
likely to result in disconnected history. That could perhaps be useful,
but that would need tests and documentation, which can be added in
future work. So, while at it, let's disallow them too.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c         | 26 +++++++++++++++++++++++++-
 t/t3650-replay-basics.sh | 16 ++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index de2ddeae3e..60abdaee9e 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -121,7 +121,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	struct commit *commit;
 	struct merge_options merge_opt;
 	struct merge_result result;
-	int ret = 0;
+	int ret = 0, i;
 
 	const char * const replay_usage[] = {
 		N_("git replay --onto <newbase> <revision-range>..."),
@@ -137,6 +137,20 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, replay_options, replay_usage,
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT);
 
+	/*
+	 * TODO: For now, we reject any unknown or invalid option,
+	 * including revision related ones, like --not,
+	 * --first-parent, etc that would be allowed and eaten by
+	 * setup_revisions() below. In the future we should definitely
+	 * accept those that make sense and add related tests and doc
+	 * though.
+	 */
+	for (i = 0; i < argc; i++)
+		if (argv[i][0] == '-') {
+			error(_("invalid option: %s"), argv[i]);
+			usage_with_options(replay_usage, replay_options);
+		}
+
 	if (!onto_name) {
 		error(_("option --onto is mandatory"));
 		usage_with_options(replay_usage, replay_options);
@@ -152,6 +166,16 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 		goto cleanup;
 	}
 
+	/*
+	 * Reject any pathspec. (They are allowed and eaten by
+	 * setup_revisions() above.) In the future we might accept
+	 * them, after adding related tests and doc though.
+	 */
+	if (revs.prune_data.nr) {
+		error(_("no pathspec is allowed: '%s'"), revs.prune_data.items[0].match);
+		usage_with_options(replay_usage, replay_options);
+	}
+
 	/* requirements/overrides for revs */
 	revs.reverse = 1;
 	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index a1da4f9ef9..de6e40950e 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -80,4 +80,20 @@ test_expect_success 'using replay on bare repo to rebase with a conflict' '
 	test_expect_code 1 git -C bare replay --onto topic1 B..conflict
 '
 
+test_expect_success 'using replay with (for now) disallowed revision specific option --not' '
+	test_must_fail git replay --onto main topic2 --not topic1
+'
+
+test_expect_success 'using replay on bare repo with (for now) disallowed revision specific option --first-parent' '
+	test_must_fail git -C bare replay --onto main --first-parent topic1..topic2
+'
+
+test_expect_success 'using replay with disallowed pathspec' '
+	test_must_fail git replay --onto main topic1..topic2 A.t
+'
+
+test_expect_success 'using replay on bare repo with disallowed pathspec' '
+	test_must_fail git -C bare replay --onto main topic1..topic2 -- A.t
+'
+
 test_done
-- 
2.42.0.126.gcf8c984877

