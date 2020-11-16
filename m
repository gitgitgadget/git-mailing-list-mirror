Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1245C64E75
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 16:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A87C221F9
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 16:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4fXo8Ur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731716AbgKPQIs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 11:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731696AbgKPQIq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 11:08:46 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34668C0613D1
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 08:08:45 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id l1so19252627wrb.9
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 08:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZZUqMQkE4pHLIgP6YPbr6smpy1FSBQAOH0ZoELDA6jk=;
        b=q4fXo8Ur41fPR1ivbsjo2qAcGG5zSJ6KpssR3Ryp05el/UVRE8VjtnnhMKxfmreIkt
         gIWf5yGY194ylFQRs59emTrD5uD2hLjs4bCzdgvJaWKwkyEKWy3W+U1Wfk1ylyghP1tP
         DbIuju5tvyZX/eKz0Wyg4HNYslqQiIHmNK5lJcc+a/r6HicK6PPFk/SkPTGUbyrYRbFW
         Ng35wgpnNuwpJrxwcuITAfGLRLfpIMOj8htDMiEyWa4Ink6KCv+d5BpX0Hf+WHCoJL6t
         gckwUj40c0hGLxQ2WRV9ZtXBoQYMO1i0uM1bKBH8Is5PIXIIb2OZuQIxoPCx+p9CMCyT
         WiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZZUqMQkE4pHLIgP6YPbr6smpy1FSBQAOH0ZoELDA6jk=;
        b=b8VKedrPeF99YwKFajGZj7HU6St2N73TITbYEBXE8g0Z4JZrxuhNep0MaqdDMkgT3S
         YJAuXjjkyuUnHfpW1w3EJnfnd/RCnD8RgcWypO/6ZLt/7XhVi8vSRwEAnvM5X6KXUl5h
         j/ZHWvIMcTtijS/iSJM6BfuIhdbTMUx8gORSVvF3cHnHx7Hiju08OXqP23MGG2sfN2OJ
         xlkuy56dDSdxN4DSkxNd2K4ZCrfVzL0RuTqyGUp14sKyMyRolUFDSh04niYKbYk5OKdR
         5TKkk0PpYDXZcrOH4NUvFughDNXaMUtTWFSU9vWvy2OCOBU2ongoHGg7nPinRVZL2sUD
         R0Dg==
X-Gm-Message-State: AOAM533U427B+2pPxbiEJHmy6CJMR/caql3YIX31KwsaiI81+f46Ic9E
        jA08EHEgqWGih+rkQSzVq+lF0ZojV8k=
X-Google-Smtp-Source: ABdhPJzpfko9d9mncfT49ir+9j4nmm3Xkps77UQI3tNxOZPLjK6BzeHAzLmBGrypsmg/4khfFRKqag==
X-Received: by 2002:adf:b74d:: with SMTP id n13mr3176658wre.101.1605542923706;
        Mon, 16 Nov 2020 08:08:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w10sm24099417wra.34.2020.11.16.08.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 08:08:43 -0800 (PST)
Message-Id: <492f46833a3fee22cef4e1ecfb341f20b5471e9c.1605542912.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.785.v3.git.1605542912.gitgitgadget@gmail.com>
References: <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
        <pull.785.v3.git.1605542912.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Nov 2020 16:08:32 +0000
Subject: [PATCH v3 11/11] add -i: verify in the tests that colors can be
 overridden
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Now that the Perl version produces the same output as the built-in
version (mostly fixing bugs in the latter), let's add a regression test
to verify that it stays this way.

Note that we only `grep` for the colored error message instead of
verifying that the entire `stderr` consists of just this one line: when
running the test script using the `-x` option to trace the
commands, the sub-shell in `force_color` causes those commands to be
traced into `err.raw` (unless running in Bash where we set the
`BASH_XTRACEFD` variable to avoid that).

Also note that the color reset in the `<BLUE>+<RESET><BLUE>new<RESET>`
line might look funny and unnecessary, as the corresponding `old` line
does not reset the color after the diff marker only to turn the color
back on right away.

However, this is a (necessary) side effect of the white-space check: in
`emit_line_ws_markup()`, we first emit the diff marker via
`emit_line_0()` and then the rest of the line via `ws_check_emit()`. To
leave them somewhat decoupled, the color has to be reset after the diff
marker to allow for the rest of the line to start with another color (or
inverted, in case of white-space issues).

Finally, we have to simulate hunk editing: the `git add -p` command
cannot rely on the internal diff machinery for coloring after letting
the user edit a hunk; It has to "re-color" the edited hunk. This is the
primary reason why that command is interested in the exact values of the
`color.diff.*` settings in the first place. To test this re-coloring, we
therefore have to pretend to edit a hunk and then show that hunk in the
regression test.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3701-add-interactive.sh | 84 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index ca04fac417..cc3f434a97 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -589,6 +589,90 @@ test_expect_success 'diffs can be colorized' '
 	grep "$(printf "\\033")" output
 '
 
+test_expect_success 'colors can be overridden' '
+	git reset --hard &&
+	test_when_finished "git rm -f color-test" &&
+	test_write_lines context old more-context >color-test &&
+	git add color-test &&
+	test_write_lines context new more-context another-one >color-test &&
+
+	echo trigger an error message >input &&
+	force_color git \
+		-c color.interactive.error=blue \
+		add -i 2>err.raw <input &&
+	test_decode_color <err.raw >err &&
+	grep "<BLUE>Huh (trigger)?<RESET>" err &&
+
+	test_write_lines help quit >input &&
+	force_color git \
+		-c color.interactive.header=red \
+		-c color.interactive.help=green \
+		-c color.interactive.prompt=yellow \
+		add -i >actual.raw <input &&
+	test_decode_color <actual.raw >actual &&
+	cat >expect <<-\EOF &&
+	<RED>           staged     unstaged path<RESET>
+	  1:        +3/-0        +2/-1 color-test
+
+	<RED>*** Commands ***<RESET>
+	  1: <YELLOW>s<RESET>tatus	  2: <YELLOW>u<RESET>pdate	  3: <YELLOW>r<RESET>evert	  4: <YELLOW>a<RESET>dd untracked
+	  5: <YELLOW>p<RESET>atch	  6: <YELLOW>d<RESET>iff	  7: <YELLOW>q<RESET>uit	  8: <YELLOW>h<RESET>elp
+	<YELLOW>What now<RESET>> <GREEN>status        - show paths with changes<RESET>
+	<GREEN>update        - add working tree state to the staged set of changes<RESET>
+	<GREEN>revert        - revert staged set of changes back to the HEAD version<RESET>
+	<GREEN>patch         - pick hunks and update selectively<RESET>
+	<GREEN>diff          - view diff between HEAD and index<RESET>
+	<GREEN>add untracked - add contents of untracked files to the staged set of changes<RESET>
+	<RED>*** Commands ***<RESET>
+	  1: <YELLOW>s<RESET>tatus	  2: <YELLOW>u<RESET>pdate	  3: <YELLOW>r<RESET>evert	  4: <YELLOW>a<RESET>dd untracked
+	  5: <YELLOW>p<RESET>atch	  6: <YELLOW>d<RESET>iff	  7: <YELLOW>q<RESET>uit	  8: <YELLOW>h<RESET>elp
+	<YELLOW>What now<RESET>> Bye.
+	EOF
+	test_cmp expect actual &&
+
+	: exercise recolor_hunk by editing and then look at the hunk again &&
+	test_write_lines s e K q >input &&
+	force_color git \
+		-c color.interactive.prompt=yellow \
+		-c color.diff.meta=italic \
+		-c color.diff.frag=magenta \
+		-c color.diff.context=cyan \
+		-c color.diff.old=bold \
+		-c color.diff.new=blue \
+		-c core.editor=touch \
+		add -p >actual.raw <input &&
+	test_decode_color <actual.raw >actual.decoded &&
+	sed "s/index [0-9a-f]*\\.\\.[0-9a-f]* 100644/<INDEX-LINE>/" <actual.decoded >actual &&
+	cat >expect <<-\EOF &&
+	<ITALIC>diff --git a/color-test b/color-test<RESET>
+	<ITALIC><INDEX-LINE><RESET>
+	<ITALIC>--- a/color-test<RESET>
+	<ITALIC>+++ b/color-test<RESET>
+	<MAGENTA>@@ -1,3 +1,4 @@<RESET>
+	<CYAN> context<RESET>
+	<BOLD>-old<RESET>
+	<BLUE>+<RESET><BLUE>new<RESET>
+	<CYAN> more-context<RESET>
+	<BLUE>+<RESET><BLUE>another-one<RESET>
+	<YELLOW>(1/1) Stage this hunk [y,n,q,a,d,s,e,?]? <RESET><BOLD>Split into 2 hunks.<RESET>
+	<MAGENTA>@@ -1,3 +1,3 @@<RESET>
+	<CYAN> context<RESET>
+	<BOLD>-old<RESET>
+	<BLUE>+<RESET><BLUE>new<RESET>
+	<CYAN> more-context<RESET>
+	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,?]? <RESET><MAGENTA>@@ -3 +3,2 @@<RESET>
+	<CYAN> more-context<RESET>
+	<BLUE>+<RESET><BLUE>another-one<RESET>
+	<YELLOW>(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,?]? <RESET><MAGENTA>@@ -1,3 +1,3 @@<RESET>
+	<CYAN> context<RESET>
+	<BOLD>-old<RESET>
+	<BLUE>+new<RESET>
+	<CYAN> more-context<RESET>
+	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,?]? <RESET>
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'colorized diffs respect diff.wsErrorHighlight' '
 	git reset --hard &&
 
-- 
gitgitgadget
