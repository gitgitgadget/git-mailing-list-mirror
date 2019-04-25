Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E1621F453
	for <e@80x24.org>; Thu, 25 Apr 2019 09:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfDYJyr (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 05:54:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34899 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbfDYJyp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 05:54:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id h1so668574pgs.2
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 02:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jSGjDqg6H4RXodxcuBunJGLalRidYZTF6HY4l5Ijv+w=;
        b=nzuBHy0heX1oxzl4B2/9iQPNC3QIL3smvbeZ+kkzFZ2469GxiTWdjHPRs/Aywycg/9
         DFEUVJHf51FZaW44qS7+pJ47DBICokvOyfkZMK3nn+gNuuJMuyBgOwXF4Aok2OO/PAl/
         RyWNJnXG3kMczGUR4dT5e87s2LDgNjXdocqIadgpko7LhKab77JGU1AhMsEoEmXV27NK
         hcWSn4fFjL6bg84JkG2NhdCqBr/E6H9aZhWB8KWVKuHNZSgB+LpwPGPSANKsBfugMeno
         J4vXyp5JeDavqoUBsro/ED/V9RxrUIgDfylisgjPx4k7cKJvFbyHOPCw56xZWdlfMZdA
         wmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jSGjDqg6H4RXodxcuBunJGLalRidYZTF6HY4l5Ijv+w=;
        b=dhz0X9C/38vpCAuLJqxTYJTPYHYknyJ+p514bPH3MDPXP6PjqzXcZUWHRyA5c3g+lB
         PDxq4UjJkvbFMbgaDnXuAnn9C2KAHgUKlLjY969wlTtX46zMDhbMZrRD6fBvPlAGN6ra
         wOcGyRCLKRL0mlj7fjQRTfYVe0Pia4LLXpyv3KEOR+tXSzVETnyy3R1i3+oKfbLoTetk
         tv2+KIaV9sPQLw4PYk2SZ9Aq61/AT+5u5xmNSW1fKIEwfchhBaWIc/hhVYI+4KcCR8HF
         JW5kpB4c4KeZsEy/69/iUhJv8vGuAHHw7TIO9moM6lrR77R6c9SopNjME5Vo8wJvMWGZ
         tICg==
X-Gm-Message-State: APjAAAWgRYs9zcZeGV+OAUHgnCLm2Wjhw9VOMP0RCiYfejZQmwgUIdXC
        VzLqxkQdrs5nqPxmTvi3H9yb/e65
X-Google-Smtp-Source: APXvYqwpCy6IUtjas2BI+jAGKXCtyj9UAAyxoyTjUTjM7hpWanHcMiZZidvX1TwJ5hbKVFRnnS2rZw==
X-Received: by 2002:a65:6205:: with SMTP id d5mr736648pgv.61.1556186084402;
        Thu, 25 Apr 2019 02:54:44 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id j16sm29690813pfi.58.2019.04.25.02.54.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 02:54:43 -0700 (PDT)
Date:   Thu, 25 Apr 2019 02:54:41 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 4/6] mergetool: fallback to tool when guitool unavailable
Message-ID: <c799e871e2a6a6a7fcca45aad71f5a0c406ba3d7.1556185345.git.liu.denton@gmail.com>
References: <cover.1556185345.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556185345.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In git-difftool, if the tool is called with --gui but `diff.guitool` is
not set, it falls back to `diff.tool`. Make git-mergetool also fallback
from `merge.guitool` to `merge.tool` if the former is undefined.

If git-difftool, when called with `--gui`, were to use
`get_configured_mergetool` in a future patch, it would also get the
fallback behavior in the following precedence:

1. diff.guitool
2. merge.guitool
3. diff.tool
4. merge.tool

Note that the behavior for when difftool or mergetool are called without
`--gui` should be identical with or without this patch.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-mergetool.txt |  4 +++-
 git-mergetool--lib.sh           | 32 +++++++++++++++++++++++---------
 t/t7610-mergetool.sh            | 19 +++++++++++++++++++
 3 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 0c7975a050..6b14702e78 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -83,7 +83,9 @@ success of the resolution after the custom tool has exited.
 --gui::
 	When 'git-mergetool' is invoked with the `-g` or `--gui` option
 	the default merge tool will be read from the configured
-	`merge.guitool` variable instead of `merge.tool`.
+	`merge.guitool` variable instead of `merge.tool`. If
+	`merge.guitool` is not set, we will fallback to the tool
+	configured under `merge.tool`.
 
 --no-gui::
 	This overrides a previous `-g` or `--gui` setting and reads the
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 68ff26a0f7..c4b16c5e59 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -350,20 +350,34 @@ guess_merge_tool () {
 }
 
 get_configured_merge_tool () {
-	# If first argument is true, find the guitool instead
-	if test "$1" = true
+	is_gui="$1"
+	sections="merge"
+	keys="tool"
+
+	if diff_mode
 	then
-		gui_prefix=gui
+		sections="diff $sections"
 	fi
 
-	# Diff mode first tries diff.(gui)tool and falls back to merge.(gui)tool.
-	# Merge mode only checks merge.(gui)tool
-	if diff_mode
+	if "$is_gui" = true
 	then
-		merge_tool=$(git config diff.${gui_prefix}tool || git config merge.${gui_prefix}tool)
-	else
-		merge_tool=$(git config merge.${gui_prefix}tool)
+		keys="guitool $keys"
 	fi
+
+	merge_tool=$(
+		IFS=' '
+		for key in $keys
+		do
+			for section in $sections
+			do
+				if selected=$(git config $section.$key)
+				then
+					echo "$selected"
+					return
+				fi
+			done
+		done)
+
 	if test -n "$merge_tool" && ! valid_tool "$merge_tool"
 	then
 		echo >&2 "git config option $TOOL_MODE.${gui_prefix}tool set to unknown tool: $merge_tool"
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index dad607e186..5b61c10a9c 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -167,6 +167,25 @@ test_expect_success 'gui mergetool' '
 	git commit -m "branch1 resolved with mergetool"
 '
 
+test_expect_success 'gui mergetool without merge.guitool set falls back to merge.tool' '
+	test_when_finished "git reset --hard" &&
+	git checkout -b test$test_count branch1 &&
+	git submodule update -N &&
+	test_must_fail git merge master &&
+	( yes "" | git mergetool --gui both ) &&
+	( yes "" | git mergetool -g file1 file1 ) &&
+	( yes "" | git mergetool --gui file2 "spaced name" ) &&
+	( yes "" | git mergetool --gui subdir/file3 ) &&
+	( yes "d" | git mergetool --gui file11 ) &&
+	( yes "d" | git mergetool --gui file12 ) &&
+	( yes "l" | git mergetool --gui submod ) &&
+	test "$(cat file1)" = "master updated" &&
+	test "$(cat file2)" = "master new" &&
+	test "$(cat subdir/file3)" = "master new sub" &&
+	test "$(cat submod/bar)" = "branch1 submodule" &&
+	git commit -m "branch1 resolved with mergetool"
+'
+
 test_expect_success 'mergetool crlf' '
 	test_when_finished "git reset --hard" &&
 	# This test_config line must go after the above reset line so that
-- 
2.21.0.1000.g11cd861522

