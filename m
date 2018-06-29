Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C00D31F516
	for <e@80x24.org>; Fri, 29 Jun 2018 00:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030285AbeF2AU2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 20:20:28 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:44597 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030243AbeF2AU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 20:20:26 -0400
Received: by mail-qk0-f202.google.com with SMTP id d66-v6so3284756qkf.11
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 17:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=qttFKaV2bVQY+4DooPqNIpw3LTl3CdWVMkjRa+1Ap9k=;
        b=rPYqMEgePCLRmjtDCsDYKv7edKNRNYbulSf5tLenLIJ1eJuFZ+QogMiDGBk6Z501sR
         3L55G6J0Ysu8M87Fbz0QFbvUr7zHPBs7tvFkAbE/YlKxGC6l1G5L3nWjOKzpY5AWZ4KL
         qg6kfSsNV6KVEaGnQ35zANASiEubBpOniEduUEGr9r4F46Le4cWC6Co9NwEERiXKF5+v
         r/xVcIaPx8uu/NdSGc3fmkNcIl08RLFC2evEF0YcN9CDgvJJusC3+hyBeOjakg8ec1Dk
         8dv5G/8aja+19fp/Lu+u0PU4rd5DUUBtUzrATcYQgyjAtO3wFyjXIZwBG7564ZtAxId5
         80Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=qttFKaV2bVQY+4DooPqNIpw3LTl3CdWVMkjRa+1Ap9k=;
        b=iEXbj7zUcp0Ukpn9SB4FM8K9n/4LNjYuF/4LfW8ghpdSiGUdDEhd44sstiFnt4ieO0
         EBoABiQmlvExscpjyb4olarTpyoFOiuXTXfvj6hSFxDPeZd6f7ZZ2sk/gif4x27KcbfC
         herZHOiPk3xTrJfcqwvfvMtO+M4WGUKake1tyrAd0QwUAFVLuYM7FkJ/FOCXZPceMYI/
         cuRVVsfeGDks9d+2IRP1rzLI/PzpPUJYUnzhVI+nh7b0k4xGhAc3Qwf9X6kwfnmrjvo9
         U9CrNcd+a1OSFtYifyDAsq/wtF6rXs+tJbTnBDxBI0AxoCR5n3SpgvI3qcYIlfBvFtt0
         kBuw==
X-Gm-Message-State: APt69E2BLn7jsy2SH4kXpVQggj72buZFFNE6C6bxLa1ubsuDSStS2rc6
        txCyA5IclWYWvqQLnhZgi3UENK/GrASJ
X-Google-Smtp-Source: AAOMgpdGOgrB2EtnUAbOJyn4G22tE94/tw0Rmr6jhSGHRQlmBfgImwS5XfmZQlhspU8sozaUbknSx7+iik7g
X-Received: by 2002:a0c:d2da:: with SMTP id x26-v6mr6516216qvh.36.1530231625719;
 Thu, 28 Jun 2018 17:20:25 -0700 (PDT)
Date:   Thu, 28 Jun 2018 17:19:55 -0700
In-Reply-To: <20180629001958.85143-1-sbeller@google.com>
Message-Id: <20180629001958.85143-7-sbeller@google.com>
Mime-Version: 1.0
References: <20180622015725.219575-1-sbeller@google.com> <20180629001958.85143-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v4 6/9] diff.c: add a blocks mode for moved code detection
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jacob.keller@gmail.com,
        jonathantanmy@google.com, simon@ruderich.org, bmwill@google.com,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new "blocks" mode provides a middle ground between plain and zebra.
It is as intuitive (few colors) as plain, but still has the requirement
for a minimum of lines/characters to count a block as moved.

Suggested-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
 (https://public-inbox.org/git/87o9j0uljo.fsf@evledraar.gmail.com/)
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-options.txt |  8 ++++--
 diff.c                         |  6 +++--
 diff.h                         |  5 ++--
 t/t4015-diff-whitespace.sh     | 49 ++++++++++++++++++++++++++++++++--
 4 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.tx=
t
index e3a44f03cdc..ba56169de31 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -276,10 +276,14 @@ plain::
 	that are added somewhere else in the diff. This mode picks up any
 	moved line, but it is not very useful in a review to determine
 	if a block of code was moved without permutation.
-zebra::
+blocks::
 	Blocks of moved text of at least 20 alphanumeric characters
 	are detected greedily. The detected blocks are
-	painted using either the 'color.diff.{old,new}Moved' color or
+	painted using either the 'color.diff.{old,new}Moved' color.
+	Adjacent blocks cannot be told apart.
+zebra::
+	Blocks of moved text are detected as in 'blocks' mode. The blocks
+	are painted using either the 'color.diff.{old,new}Moved' color or
 	'color.diff.{old,new}MovedAlternative'. The change between
 	the two colors indicates that a new block was detected.
 dimmed_zebra::
diff --git a/diff.c b/diff.c
index d1bae900cdc..95c51c0b7df 100644
--- a/diff.c
+++ b/diff.c
@@ -271,6 +271,8 @@ static int parse_color_moved(const char *arg)
 		return COLOR_MOVED_NO;
 	else if (!strcmp(arg, "plain"))
 		return COLOR_MOVED_PLAIN;
+	else if (!strcmp(arg, "blocks"))
+		return COLOR_MOVED_BLOCKS;
 	else if (!strcmp(arg, "zebra"))
 		return COLOR_MOVED_ZEBRA;
 	else if (!strcmp(arg, "default"))
@@ -278,7 +280,7 @@ static int parse_color_moved(const char *arg)
 	else if (!strcmp(arg, "dimmed_zebra"))
 		return COLOR_MOVED_ZEBRA_DIM;
 	else
-		return error(_("color moved setting must be one of 'no', 'default', 'zeb=
ra', 'dimmed_zebra', 'plain'"));
+		return error(_("color moved setting must be one of 'no', 'default', 'blo=
cks', 'zebra', 'dimmed_zebra', 'plain'"));
 }
=20
 int git_diff_ui_config(const char *var, const char *value, void *cb)
@@ -903,7 +905,7 @@ static void mark_color_as_moved(struct diff_options *o,
=20
 		block_length++;
=20
-		if (flipped_block)
+		if (flipped_block && o->color_moved !=3D COLOR_MOVED_BLOCKS)
 			l->flags |=3D DIFF_SYMBOL_MOVED_LINE_ALT;
 	}
 	adjust_last_block(o, n, block_length);
diff --git a/diff.h b/diff.h
index d29560f822c..7bd4f182c33 100644
--- a/diff.h
+++ b/diff.h
@@ -208,8 +208,9 @@ struct diff_options {
 	enum {
 		COLOR_MOVED_NO =3D 0,
 		COLOR_MOVED_PLAIN =3D 1,
-		COLOR_MOVED_ZEBRA =3D 2,
-		COLOR_MOVED_ZEBRA_DIM =3D 3,
+		COLOR_MOVED_BLOCKS =3D 2,
+		COLOR_MOVED_ZEBRA =3D 3,
+		COLOR_MOVED_ZEBRA_DIM =3D 4,
 	} color_moved;
 	#define COLOR_MOVED_DEFAULT COLOR_MOVED_ZEBRA
 	#define COLOR_MOVED_MIN_ALNUM_COUNT 20
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index ddbc3901385..e54529f026d 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1223,7 +1223,7 @@ test_expect_success 'plain moved code, inside file' '
 	test_cmp expected actual
 '
=20
-test_expect_success 'detect permutations inside moved code -- dimmed_zebra=
' '
+test_expect_success 'detect blocks of moved code' '
 	git reset --hard &&
 	cat <<-\EOF >lines.txt &&
 		long line 1
@@ -1271,6 +1271,50 @@ test_expect_success 'detect permutations inside move=
d code -- dimmed_zebra' '
 	test_config color.diff.newMovedDimmed "normal cyan" &&
 	test_config color.diff.oldMovedAlternativeDimmed "normal blue" &&
 	test_config color.diff.newMovedAlternativeDimmed "normal yellow" &&
+	git diff HEAD --no-renames --color-moved=3Dblocks --color >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
+	cat <<-\EOF >expected &&
+	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
+	<BOLD>--- a/lines.txt<RESET>
+	<BOLD>+++ b/lines.txt<RESET>
+	<CYAN>@@ -1,16 +1,16 @@<RESET>
+	<MAGENTA>-long line 1<RESET>
+	<MAGENTA>-long line 2<RESET>
+	<MAGENTA>-long line 3<RESET>
+	 line 4<RESET>
+	 line 5<RESET>
+	 line 6<RESET>
+	 line 7<RESET>
+	 line 8<RESET>
+	 line 9<RESET>
+	<CYAN>+<RESET><CYAN>long line 1<RESET>
+	<CYAN>+<RESET><CYAN>long line 2<RESET>
+	<CYAN>+<RESET><CYAN>long line 3<RESET>
+	<CYAN>+<RESET><CYAN>long line 14<RESET>
+	<CYAN>+<RESET><CYAN>long line 15<RESET>
+	<CYAN>+<RESET><CYAN>long line 16<RESET>
+	 line 10<RESET>
+	 line 11<RESET>
+	 line 12<RESET>
+	 line 13<RESET>
+	<MAGENTA>-long line 14<RESET>
+	<MAGENTA>-long line 15<RESET>
+	<MAGENTA>-long line 16<RESET>
+	EOF
+	test_cmp expected actual
+
+'
+
+test_expect_success 'detect permutations inside moved code -- dimmed_zebra=
' '
+	# reuse setup from test before!
+	test_config color.diff.oldMoved "magenta" &&
+	test_config color.diff.newMoved "cyan" &&
+	test_config color.diff.oldMovedAlternative "blue" &&
+	test_config color.diff.newMovedAlternative "yellow" &&
+	test_config color.diff.oldMovedDimmed "normal magenta" &&
+	test_config color.diff.newMovedDimmed "normal cyan" &&
+	test_config color.diff.oldMovedAlternativeDimmed "normal blue" &&
+	test_config color.diff.newMovedAlternativeDimmed "normal yellow" &&
 	git diff HEAD --no-renames --color-moved=3Ddimmed_zebra --color >actual.r=
aw &&
 	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat <<-\EOF >expected &&
@@ -1669,7 +1713,8 @@ test_expect_success '--color-moved treats adjacent bl=
ocks as separate for MIN_AL
 	7charsA
 	EOF
=20
-	git diff HEAD --color-moved=3Dzebra --color --no-renames | grep -v "index=
" | test_decode_color >actual &&
+	git diff HEAD --color-moved=3Dzebra --color --no-renames >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
 	cat >expected <<-\EOF &&
 	<BOLD>diff --git a/bar b/bar<RESET>
 	<BOLD>--- a/bar<RESET>
--=20
2.18.0.399.gad0ab374a1-goog

