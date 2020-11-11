Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECCCC388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 12:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8297820795
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 12:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGCzkcD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgKKM2b (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 07:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgKKM22 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 07:28:28 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17E8C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 04:28:27 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id d142so2084453wmd.4
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 04:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8GgCsHZVpyX2Gp5h2jVV8G7gTYw+twh0DfyDGUcsViU=;
        b=jGCzkcD72oSdy7op0Ay0lUlPohxBURYhiA89RLQXq2quVuTbX8FU/MCFetOlUc57Uo
         5aDrW2dQWqBGBw1nkJ5TUU1dMQs+OR7FiRrOJQA8qN3FzK07NJ2Knfkbver2wSpjKyR7
         1rEzKApjIXrqmtJcqa5hdGdZKXX7ijRP1OuTtmKUlGuJarkAo7JWNdWXizqgJRXzRY+0
         1lKEN2Wb4ln8P3yA2Fv5WdGQqeQk5bLJF0hR0wxXMCmPYSUOoZe5kHKKGFqSW8Gm//D8
         SRujjeXRJruZYdUanqZJi5wn9Lbow5CvWshqZktsjhleKm3Ajxjg+jvc+bREs/GV6KAb
         3CPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8GgCsHZVpyX2Gp5h2jVV8G7gTYw+twh0DfyDGUcsViU=;
        b=m7kkTr9FB6+JsagWhIje557SVHXavLA/i9EFGbd8YNvyx2B2aXyfIA0KgZM9VEGzEz
         xjOqBMwyLH9qaQinP08+A1Dpktxu89Al870dVBMENYdkikGG2SIui/WVwssiDvxgrN1+
         gz8hvhuOurPXCDBICBb3E84IhOMHPYkmle2S4ZVr9YWhxOtenuO6nucLo8xK25AgyL4C
         38mtz1DsIPQs7+FzKLgUWxU3HOl4oiJqnUMOUPlU0xBva5SdUUCrue3mrbj7bp4ewogR
         Y2B2yBnhijSbjWdHsbKw4/w1VboCd98AYpdNcoc8UIGBWpIWs9oKgWb7nJ/rU/sWmWC+
         MJvg==
X-Gm-Message-State: AOAM5323/SbCUAJgbUvNncWxs7/P2reMFrWDRvB4MReGwMTjKLSGK2GC
        zoNwNsTGGia5wOWD0aljQ1IbBPu/0xY=
X-Google-Smtp-Source: ABdhPJxkRE4RqC+vOO93grQzcKeGx1fJvpyWmqrPlyB4+m/Oc2+tBqpZYM5kJij8p7Y/Q5r4CooJTw==
X-Received: by 2002:a7b:cf31:: with SMTP id m17mr3804858wmg.62.1605097705910;
        Wed, 11 Nov 2020 04:28:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f17sm2382341wmf.41.2020.11.11.04.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 04:28:25 -0800 (PST)
Message-Id: <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
In-Reply-To: <pull.785.git.1605051739.gitgitgadget@gmail.com>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Nov 2020 12:28:13 +0000
Subject: [PATCH v2 00/11] Fix color handling in git add -i
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series started out as a tiny fix for a bug reported by Philippe
Blain in 
https://lore.kernel.org/git/313B8999-1E99-4695-A20D-E48840C30879@gmail.com/.
And then I only wanted to add a regression test to make sure that this does
not regress. And then I just wanted to ensure that it passes both with the
Perl version of git add -i as well as with the built-in version.

And in no time I was looking at a real patch series.

Changes since v1:

 * The regression test now actually exercises the re-coloring (that is the
   primary purpose of git add -p looking at the color.diff.* variables).
 * The way the built-in git add -p renders hunk headers of split hunks was
   aligned with how the Perl version does things.
 * We now consistently prefer color.diff.context over color.diff.plain, no
   matter whether using the Perl or the built-in version of git add -p.
 * The commit message for the regression test no longer confuses readers by
   mentioning dash.
 * The regression test was structured a bit better, first testing error
   message coloring, then the menu in git add -i and then the diff coloring
   in git add -p.

Johannes Schindelin (11):
  add -i (built-in): do show an error message for incorrect inputs
  add -i (built-in): send error messages to stderr
  add -p (built-in): imitate `xdl_format_hunk_hdr()` generating hunk
    headers
  add -i: use `reset_color` consistently
  add -i (built-in): prevent the `reset` "color" from being configured
  add -i (built-in): use correct names to load color.diff.* config
  add -p (built-in): do not color the progress indicator separately
  add -i (built-in): use the same indentation as the Perl version
  add -i (Perl version): include indentation in the colored header
  add -p: prefer color.diff.context over color.diff.plain
  add -i: verify in the tests that colors can be overridden

 add-interactive.c          | 38 ++++++++++-------
 add-patch.c                | 25 +++++++-----
 git-add--interactive.perl  | 12 +++---
 t/t3701-add-interactive.sh | 84 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 127 insertions(+), 32 deletions(-)


base-commit: e4d83eee9239207622e2b1cc43967da5051c189c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-785%2Fdscho%2Ffix-add-i-colors-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-785/dscho/fix-add-i-colors-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/785

Range-diff vs v1:

  1:  6152122c04 =  1:  6152122c04 add -i (built-in): do show an error message for incorrect inputs
  2:  068813912b =  2:  068813912b add -i (built-in): send error messages to stderr
  -:  ---------- >  3:  98deb538d9 add -p (built-in): imitate `xdl_format_hunk_hdr()` generating hunk headers
  3:  9a1ba71977 =  4:  c857c44932 add -i: use `reset_color` consistently
  4:  b48c878fad =  5:  337b45cad8 add -i (built-in): prevent the `reset` "color" from being configured
  5:  85b0d27d76 =  6:  dcd2ffc458 add -i (built-in): use correct names to load color.diff.* config
  6:  059344bfaf =  7:  73b6d60a80 add -p (built-in): do not color the progress indicator separately
  7:  8df87e6395 =  8:  91ded2fbbe add -i (built-in): use the same indentation as the Perl version
  8:  42113e20dd =  9:  304614751e add -i (Perl version): include indentation in the colored header
  -:  ---------- > 10:  48d8e0badf add -p: prefer color.diff.context over color.diff.plain
  9:  38355ec98f ! 11:  c94abff72f add -i: verify in the tests that colors can be overridden
     @@ Commit message
      
          Note that we only `grep` for the colored error message instead of
          verifying that the entire `stderr` consists of just this one line: when
     -    running the test script via `dash`, using the `-x` option to trace the
     +    running the test script using the `-x` option to trace the
          commands, the sub-shell in `force_color` causes those commands to be
     -    traced into `err.raw` because we set, but do not export
     -    `BASH_XTRACEFD`).
     +    traced into `err.raw` (unless running in Bash where we set the
     +    `BASH_XTRACEFD` variable to avoid that).
      
     +    Also note that the color reset in the `<BLUE>+<RESET><BLUE>new<RESET>`
     +    line might look funny and unnecessary, as the corresponding `old` line
     +    does not reset the color after the diff marker only to turn the color
     +    back on right away.
     +
     +    However, this is a (necessary) side effect of the white-space check: in
     +    `emit_line_ws_markup()`, we first emit the diff marker via
     +    `emit_line_0()` and then the rest of the line via `ws_check_emit()`. To
     +    leave them somewhat decoupled, the color has to be reset after the diff
     +    marker to allow for the rest of the line to start with another color (or
     +    inverted, in case of white-space issues).
     +
     +    Finally, we have to simulate hunk editing: the `git add -p` command
     +    cannot rely on the internal diff machinery for coloring after letting
     +    the user edit a hunk; It has to "re-color" the edited hunk. This is the
     +    primary reason why that command is interested in the exact values of the
     +    `color.diff.*` settings in the first place. To test this re-coloring, we
     +    therefore have to pretend to edit a hunk and then show that hunk in the
     +    regression test.
     +
     +    Co-authored-by: Jeff King <peff@peff.net>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## t/t3701-add-interactive.sh ##
     @@ t/t3701-add-interactive.sh: test_expect_success 'diffs can be colorized' '
       '
       
      +test_expect_success 'colors can be overridden' '
     -+	test_config color.interactive.header red &&
     -+	test_config color.interactive.help green &&
     -+	test_config color.interactive.prompt yellow &&
     -+	test_config color.interactive.error blue &&
     -+	test_config color.diff.frag magenta &&
     -+	test_config color.diff.context cyan &&
     -+	test_config color.diff.old bold &&
     -+	test_config color.diff.new "bold red" &&
     -+
      +	git reset --hard &&
      +	test_when_finished "git rm -f color-test" &&
      +	test_write_lines context old more-context >color-test &&
      +	git add color-test &&
     -+	test_write_lines context new more-context >color-test &&
     ++	test_write_lines context new more-context another-one >color-test &&
      +
      +	echo trigger an error message >input &&
     -+	force_color git add -i 2>err.raw <input &&
     ++	force_color git \
     ++		-c color.interactive.error=blue \
     ++		add -i 2>err.raw <input &&
      +	test_decode_color <err.raw >err &&
      +	grep "<BLUE>Huh (trigger)?<RESET>" err &&
      +
     -+	test_write_lines patch color-test "" y quit >input &&
     -+	force_color git add -i >actual.raw <input &&
     -+	test_decode_color <actual.raw >actual.decoded &&
     -+	sed "/index [0-9a-f]*\\.\\.[0-9a-f]* 100644/d" <actual.decoded >actual &&
     ++	test_write_lines help quit >input &&
     ++	force_color git \
     ++		-c color.interactive.header=red \
     ++		-c color.interactive.help=green \
     ++		-c color.interactive.prompt=yellow \
     ++		add -i >actual.raw <input &&
     ++	test_decode_color <actual.raw >actual &&
      +	cat >expect <<-\EOF &&
      +	<RED>           staged     unstaged path<RESET>
     -+	  1:        +3/-0        +1/-1 color-test
     ++	  1:        +3/-0        +2/-1 color-test
      +
      +	<RED>*** Commands ***<RESET>
      +	  1: <YELLOW>s<RESET>tatus	  2: <YELLOW>u<RESET>pdate	  3: <YELLOW>r<RESET>evert	  4: <YELLOW>a<RESET>dd untracked
      +	  5: <YELLOW>p<RESET>atch	  6: <YELLOW>d<RESET>iff	  7: <YELLOW>q<RESET>uit	  8: <YELLOW>h<RESET>elp
     -+	<YELLOW>What now<RESET>> <RED>           staged     unstaged path<RESET>
     -+	  1:        +3/-0        +1/-1 <YELLOW>c<RESET>olor-test
     -+	<YELLOW>Patch update<RESET>>> <RED>           staged     unstaged path<RESET>
     -+	* 1:        +3/-0        +1/-1 <YELLOW>c<RESET>olor-test
     -+	<YELLOW>Patch update<RESET>>> <BOLD>diff --git a/color-test b/color-test<RESET>
     -+	<BOLD>--- a/color-test<RESET>
     -+	<BOLD>+++ b/color-test<RESET>
     -+	<MAGENTA>@@ -1,3 +1,3 @@<RESET>
     -+	<CYAN> context<RESET>
     -+	<BOLD>-old<RESET>
     -+	<BOLD;RED>+<RESET><BOLD;RED>new<RESET>
     -+	<CYAN> more-context<RESET>
     -+	<YELLOW>(1/1) Stage this hunk [y,n,q,a,d,e,?]? <RESET>
     ++	<YELLOW>What now<RESET>> <GREEN>status        - show paths with changes<RESET>
     ++	<GREEN>update        - add working tree state to the staged set of changes<RESET>
     ++	<GREEN>revert        - revert staged set of changes back to the HEAD version<RESET>
     ++	<GREEN>patch         - pick hunks and update selectively<RESET>
     ++	<GREEN>diff          - view diff between HEAD and index<RESET>
     ++	<GREEN>add untracked - add contents of untracked files to the staged set of changes<RESET>
      +	<RED>*** Commands ***<RESET>
      +	  1: <YELLOW>s<RESET>tatus	  2: <YELLOW>u<RESET>pdate	  3: <YELLOW>r<RESET>evert	  4: <YELLOW>a<RESET>dd untracked
      +	  5: <YELLOW>p<RESET>atch	  6: <YELLOW>d<RESET>iff	  7: <YELLOW>q<RESET>uit	  8: <YELLOW>h<RESET>elp
      +	<YELLOW>What now<RESET>> Bye.
      +	EOF
     ++	test_cmp expect actual &&
     ++
     ++	: exercise recolor_hunk by editing and then look at the hunk again &&
     ++	test_write_lines s e K q >input &&
     ++	force_color git \
     ++		-c color.interactive.prompt=yellow \
     ++		-c color.diff.meta=italic \
     ++		-c color.diff.frag=magenta \
     ++		-c color.diff.context=cyan \
     ++		-c color.diff.old=bold \
     ++		-c color.diff.new=blue \
     ++		-c core.editor=touch \
     ++		add -p >actual.raw <input &&
     ++	test_decode_color <actual.raw >actual.decoded &&
     ++	sed "s/index [0-9a-f]*\\.\\.[0-9a-f]* 100644/<INDEX-LINE>/" <actual.decoded >actual &&
     ++	cat >expect <<-\EOF &&
     ++	<ITALIC>diff --git a/color-test b/color-test<RESET>
     ++	<ITALIC><INDEX-LINE><RESET>
     ++	<ITALIC>--- a/color-test<RESET>
     ++	<ITALIC>+++ b/color-test<RESET>
     ++	<MAGENTA>@@ -1,3 +1,4 @@<RESET>
     ++	<CYAN> context<RESET>
     ++	<BOLD>-old<RESET>
     ++	<BLUE>+<RESET><BLUE>new<RESET>
     ++	<CYAN> more-context<RESET>
     ++	<BLUE>+<RESET><BLUE>another-one<RESET>
     ++	<YELLOW>(1/1) Stage this hunk [y,n,q,a,d,s,e,?]? <RESET><BOLD>Split into 2 hunks.<RESET>
     ++	<MAGENTA>@@ -1,3 +1,3 @@<RESET>
     ++	<CYAN> context<RESET>
     ++	<BOLD>-old<RESET>
     ++	<BLUE>+<RESET><BLUE>new<RESET>
     ++	<CYAN> more-context<RESET>
     ++	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,?]? <RESET><MAGENTA>@@ -3 +3,2 @@<RESET>
     ++	<CYAN> more-context<RESET>
     ++	<BLUE>+<RESET><BLUE>another-one<RESET>
     ++	<YELLOW>(2/2) Stage this hunk [y,n,q,a,d,K,g,/,e,?]? <RESET><MAGENTA>@@ -1,3 +1,3 @@<RESET>
     ++	<CYAN> context<RESET>
     ++	<BOLD>-old<RESET>
     ++	<BLUE>+new<RESET>
     ++	<CYAN> more-context<RESET>
     ++	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,?]? <RESET>
     ++	EOF
      +	test_cmp expect actual
      +'
      +

-- 
gitgitgadget
