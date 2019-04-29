Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 076281F453
	for <e@80x24.org>; Mon, 29 Apr 2019 06:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfD2GVT (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 02:21:19 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34205 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfD2GVS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 02:21:18 -0400
Received: by mail-io1-f65.google.com with SMTP id h26so8000960ioj.1
        for <git@vger.kernel.org>; Sun, 28 Apr 2019 23:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NeWaZKf3Ow01SuTlE7rDRsZSrmPzfHC/zeYtkG1Ifew=;
        b=rJOCIhbEz9FwI0GXltibG7Z2nFwQDeAeSiVhQ2o/n0kB2LkNlyuMpSHjSO4LyIHMZ/
         FhocGNMx0eU2EXoSSX5wqystLq47xv3JhEsubL74gxWG2KddC7V3ck/JAcWORaQaXnCs
         dvhfWF6envRAIzBx6x1mzLu62A5djumu84CZuzGO7iCXj4ahoPgZCRtE+R8J+BSqzXu7
         j5I7yLz6CECzqVdnhwBLnzU0CXAUL8fyglLqWfq7zLLSH0vFTwhUiABp2DsnT5+Gvid2
         0DSxxhoUaltWQocQZWf2DOSdlpDMAYyrW1yVA3mqM8b5zYyjcUbmHiVkQ/Zu0LcsNlNY
         Vkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NeWaZKf3Ow01SuTlE7rDRsZSrmPzfHC/zeYtkG1Ifew=;
        b=D8Q3/ZMiL1Oy7T3QpUDFFHBphCpxlU3zlwIHJPMukeMIRYIBWDFkKqDNNI4v+2Un4x
         /k2JCCEjvU9hW8spw7t84JkPc4GM62Lveg+cOkxvMjVF23UBQ3X8+YmczMGD3RbBhXD1
         QtFoS2olT9+732HwYBRUiSogG7uNa7cLWbtGDilzk80ynD8kwzUpbM060EwwZRcKRJrp
         lkBl7HTqoUoPAd2tyElKtz61EifjRmlujwuA8cSk6g4BLAnXpHc31F099maUr7ZGsNXf
         yflNgxHK0QcSvvLh+lRrN8Eye3Pjq5iW3LLGz4hCD0UN78uIciQ2WDh8L1nyjuUTEc1t
         dqww==
X-Gm-Message-State: APjAAAUjGzit1nWTvEtf2v/poiV2Z0gc7YUp8rrzvJ8DIviaiIgdGtz/
        iRNAOMyIXCDVjUzcGriSUMOk5Yf+
X-Google-Smtp-Source: APXvYqw7uK8apxnfm9m/AZlU6di3LRbSDBpCFBhcv4N7x3fc5kIsteQUU2vMVkqPQxYHbP0KLYtOqA==
X-Received: by 2002:a5d:84d9:: with SMTP id z25mr17250971ior.301.1556518877408;
        Sun, 28 Apr 2019 23:21:17 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id u26sm11834155iob.78.2019.04.28.23.21.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Apr 2019 23:21:16 -0700 (PDT)
Date:   Mon, 29 Apr 2019 02:21:14 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 5/7] mergetool: fallback to tool when guitool unavailable
Message-ID: <40413dbda11c282875811a1ddceff7542ae02aa7.1556518203.git.liu.denton@gmail.com>
References: <cover.1556185345.git.liu.denton@gmail.com>
 <cover.1556518203.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556518203.git.liu.denton@gmail.com>
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

The behavior for when difftool or mergetool are called without `--gui`
should be identical with or without this patch.

Note that the search loop could be written as

	sections="merge"
	keys="tool"
	if diff_mode
	then
		sections="diff $sections"
	fi
	if gui_mode
	then
		keys="guitool $keys"
	fi

	merge_tool=$(
		IFS=' '
		for key in $keys
		do
			for section in $sections
			do
				selected=$(git config $section.$key)
				if test -n "$selected"
				then
					echo "$selected"
					return
				fi
			done
		done)

which would make adding a mode in the future much easier. However,
adding a new mode will likely never happen as it is highly discouraged
so, as a result, it is written in its current form so that it is more
readable for future readers.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-mergetool.txt |  4 +++-
 git-mergetool--lib.sh           | 35 ++++++++++++++++++++++++---------
 t/t7610-mergetool.sh            | 19 ++++++++++++++++++
 3 files changed, 48 insertions(+), 10 deletions(-)

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
index 4ca170c8a7..696eb49160 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -354,19 +354,36 @@ guess_merge_tool () {
 }
 
 get_configured_merge_tool () {
-	if gui_mode
-	then
-		gui_prefix=gui
-	fi
-
-	# Diff mode first tries diff.(gui)tool and falls back to merge.(gui)tool.
-	# Merge mode only checks merge.(gui)tool
+	keys=
 	if diff_mode
 	then
-		merge_tool=$(git config diff.${gui_prefix}tool || git config merge.${gui_prefix}tool)
+		if gui_mode
+		then
+			keys="diff.guitool merge.guitool diff.tool merge.tool"
+		else
+			keys="diff.tool merge.tool"
+		fi
 	else
-		merge_tool=$(git config merge.${gui_prefix}tool)
+		if gui_mode
+		then
+			keys="merge.guitool merge.tool"
+		else
+			keys="merge.tool"
+		fi
 	fi
+
+	merge_tool=$(
+		IFS=' '
+		for key in $keys
+		do
+			selected=$(git config $key)
+			if test -n "$selected"
+			then
+				echo "$selected"
+				return
+			fi
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
2.21.0.1033.g0e8cc1100c

