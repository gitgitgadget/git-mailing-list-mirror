Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E46BC43461
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 15:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F71D6146B
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 15:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237626AbhDVPIP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 11:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237575AbhDVPIO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 11:08:14 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5E2C06138D
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 08:07:38 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id u15so15127592plf.10
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 08:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FMG+EpTlvFFo7OB/TyBfAHmN2PP5MsjMlRMZwc2I4vU=;
        b=HomH9/rsIyvGaWFFm+6I/j7r2t9sj2I9U2wUTbqDAeKp6ECPNjhsXS8Vtoc63cuujb
         cJizFk+DIoN5esrrUHW7vyMFM4HUIEq/ERce0HMWd9jLDG6ruQK9kdnzRL0lEX97l5jV
         YMS9UtGOE/l41yDiyq5CJy8lEihbfjoe/ozqutQrgI5yKVxZi1YRlBY2FtGaHvzTV+Y5
         w7jxVK1/P8jE9GQa4uW78+TJXhdOCfJxGmG5oaPry0iJ4HuHyaO6vL+jD+PDA5JOq32R
         ekZQaWwnEYVQuz5mnMLglCYoj6TS2gpdnu1NrQRcByvMi9+Gyi71C0nEQiab1MnreoGS
         cz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FMG+EpTlvFFo7OB/TyBfAHmN2PP5MsjMlRMZwc2I4vU=;
        b=QZxLKs6oUIoyosPPSyql9icYKpfJeIstmnxh/dbiH9tWOj8l769pONYXCZTm9EXlY7
         FBp1sfa5zhrG+L2CsXzeZByJJu7ASH2ijuNCouIbCZc22EOe9++EeaesCGDdVC3tdIxf
         lfrig/yl1Mgkkpwo7AHfauCHDMNmWevdQLF2MgaIGIrBJYB660XrYDuum33M4qM0m4WA
         /DpOtamTbUFge5UchyK1GAUSi0YeJdyVInWdG2IwottWcMzs7oEuhbl3FUmVj+yEFu+o
         HDVo4mf09/VneEg3hrlakGl5DORtHpgx81J5zaVD5XhyPcz1FbmbqGejSQl12EaaSyl0
         Kw2A==
X-Gm-Message-State: AOAM532hWWbNz864KVK0DdMa0Yb7hv1XzHz8p3iFBrp4QnB01oOe2QaA
        btlj1HHvazGUjLClSlTdGo0=
X-Google-Smtp-Source: ABdhPJwnVacUiCEpz8tIo/TycVzGJYOGRDZnDffm7++LmbqDXc5ItKEfoChE1eswYn3vE6h8ioeXZA==
X-Received: by 2002:a17:90a:6585:: with SMTP id k5mr4408611pjj.40.1619104058426;
        Thu, 22 Apr 2021 08:07:38 -0700 (PDT)
Received: from localhost ([2402:800:63b8:d379:85bd:c83a:4b40:cd9b])
        by smtp.gmail.com with ESMTPSA id n25sm2420143pff.154.2021.04.22.08.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 08:07:38 -0700 (PDT)
Date:   Thu, 22 Apr 2021 22:07:36 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] t6402: check exit status of ls-files
Message-ID: <YIGROPXmNp/0wvWH@danh.dev>
References: <YIAAzJTG1UitiWyu@danh.dev>
 <20210421104102.3409-1-congdanhqx@gmail.com>
 <20210421104102.3409-2-congdanhqx@gmail.com>
 <CAPig+cSh6VNpWbGPpTqY0rmw7zf9s-kSXSOMYvW94UHOF7t80w@mail.gmail.com>
 <CAPig+cS4tkXZLPDEWgEytzEOCR7oGrXyg1CZVKVPSXuJOifLjQ@mail.gmail.com>
 <xmqq5z0fxlgn.fsf@gitster.g>
 <YIF+0BZGwpMMI1pf@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YIF+0BZGwpMMI1pf@danh.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-04-22 20:49:04+0700, Đoàn Trần Công Danh <congdanhqx@gmail.com> wrote:
> On 2021-04-21 16:32:40-0700, Junio C Hamano <gitster@pobox.com> wrote:
> > Eric Sunshine <sunshine@sunshineco.com> writes:
> > 
> > > On Wed, Apr 21, 2021 at 12:55 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > >>     count_ls_files 5 -s &&
> > >>     count_ls_files 3 -u &&
> > >>     count_ls_files 1 -u one~HEAD &&
> > >>     ...
> > >>
> > >> The nice thing about having a helper function is that it can clean up
> > >> after itself by not leaving a new file lying around, thus you wouldn't
> > >> have to make adjustments to the expected number of untracked files (as
> > >> mentioned in the commit message). If this is the sort of thing which
> > >> comes up often enough (if there are more such cases beyond the two
> > >> scripts you changed in this series), then it might make sense to
> > >> promote the helper function to test-lib-functions.sh.
> > >
> > > The frequency with which this idiom crops up with commands beyond
> > > git-ls-files suggests the more general solution of supporting it
> > > directly in test-lib-functions.sh for any command. For instance:
> > >
> > >     test_cmd_line_count = 3 git ls-files -u &&
> > >
> > > Or, perhaps, a new mode of test_line_count():
> > >
> > >     test_line_count = 3 -c git ls-files -u &&
> 
> Hm, I'm not sure how would we implement such mode:
> 
> * Will we run such command in a subprocess and and pipe to "wc -l"
>   directly to avoid a temporary file, but we will lose the exit code
>   of running command in process?
> * Will we run in a separated chain? Thus, a temporary file would be
>   created, skimming over test-lib-functions.sh, I couldn't find any
>   convention for creating such files, except for specific use cases,
>   let's say "*.config".
> * Another clever hacks that I don't know *shrug*

Hm, I figured out, just a bit insane for reviewing.
-----8<--------
Subject: [PATCH] test-lib-functions: add test_line_count_in helper

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t0000-basic.sh        |  7 +++++
 t/test-lib-functions.sh | 62 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 705d62cc27..2ddb50e919 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -60,6 +60,13 @@ test_expect_success '.git/objects should have 3 subdirectories' '
 	test_line_count = 3 full-of-directories
 '
 
+test_expect_success 'check test_line_count_in' '
+	test_line_count_in --stdout = 4 --stderr = 3 -- sh -c "
+		printf \"%s\\n\" 1 2 3 4
+		printf >&2 \"%s\\n\" a b c
+		"
+'
+
 ################################################################
 # Test harness
 test_expect_success 'success is reported like this' '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 6348e8d733..3b3dc3020a 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -817,6 +817,68 @@ test_line_count () {
 	fi
 }
 
+# test_line_count_in checks if stdout and/or stderr has the number of lines it
+# ought to. E.g.
+#
+# 	test_expect_success 'product 1 line in stdout and 2 lines in stderr' '
+# 		test_line_count_in --stdout = 1 --stderr = 3 do_something
+# 	'
+test_line_count_in () {
+	local out_ops=-ge
+	local out_val=0
+	local err_ops=-ge
+	local err_val=0
+	local opt_set=
+
+	while test $# != 0
+	do
+		case "$1" in
+		--stdout)
+			if test $# -lt 3
+			then
+				BUG "need ops and value for --stdout"
+			fi
+			out_ops=$2
+			out_val=$3
+			opt_set=yes
+			shift 3
+			;;
+		--stderr)
+			if test $# -lt 3
+			then
+				BUG "need ops and value for --stderr"
+			fi
+			err_ops=$2
+			err_val=$3
+			opt_set=yes
+			shift 3
+			;;
+		--)
+			shift
+			break
+			;;
+		esac
+	done
+
+	if test -z "$opt_set"
+	then
+		BUG "need check ops for test_line_count_in"
+	else
+		! (
+		test $(
+			(
+			test $(
+				( "$@" || echo "'$*' run into failure" >&3) |
+				wc -l
+				) "$out_ops" "$out_val" ||
+			echo "test_line_count_in --stdout: !$out_ops $out_val '$*'" >&3
+			) 2>&1 | wc -l
+		) "$err_ops" "$err_val" ||
+		echo "test_line_count_in --stderr: !$out_ops $out_val '$*'" >&3
+		) 3>&1 | grep .
+	fi
+}
+
 test_file_size () {
 	test "$#" -ne 1 && BUG "1 param"
 	test-tool path-utils file-size "$1"
-- 
2.31.1.500.gbc6bbdd36b

