Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34E521F453
	for <e@80x24.org>; Wed, 24 Apr 2019 22:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfDXWrF (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 18:47:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40815 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfDXWrE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 18:47:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id d31so10123072pgl.7
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 15:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EHQRy47EInZUikXScYEE7BNiN2A7hVEVlc3fBZW5soA=;
        b=bnejggjGHP1s9OKmhgEvaMEZpPoxcHy87Tq0Q4q9v/Gpvn7esNq+7vGb4hlUZKeATp
         SF3gWDa9cH0BnoYb8rsnFKXz/4D+Rb9tJS0xn5IrmsDUG08E4h4ArvvBceITqr7yYlyr
         357NZ/0tnZmQ9aC1yTgPSZNPV0jrqsazGWOVm5nH0w0Qy2iVVl63V/zaEnPmaBPjwJ1T
         cXdMLdAnnulywdrIyfZDMxm4fvfztxHhf3HMj9a/TiqbnAheiJsroDuUW2RpelZPqRdA
         mlB76Jcooeh1ypwHiFUc0HbcC8QVLrPoAmSh49A5umH8bj6YTFMK5cNFggsyTFMb14K5
         UGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EHQRy47EInZUikXScYEE7BNiN2A7hVEVlc3fBZW5soA=;
        b=LKn5PeKX+jtOMvTCXwOnDZHzk9kvWYJgzxxF8jznfKxfMobzRrHc8GktclELpuJOgM
         Jpcd/p1GcNrV/ZX112lL0IpBe16zf9lLboyIrd3jrYwiFXNU6poaZ9+Tq5bSQ+XqlboZ
         dXLLfIyMSMG1LDK+VZCOCmqTCrq4m7sZQa0OVtcsjtOU8uc5HRQvtF8pMsSBFWzltfnS
         Kq1oh5lumnKf9tOLftxDCuSgsP7m8vIPhpBTYxWET66if8Q/xfkfd4iiDrlHSmm4y90B
         nP9PUtjsk2YqyRo4XYvEzMpHJPyUpDKFED4maSrj27RtWsIhOZVQ+byIYn45ZmXo0O9o
         UwxA==
X-Gm-Message-State: APjAAAUrxlG7qxGIRqn/AfD3WZ0p08AoiAhm1B5pGSVKchhMgoVlEUrz
        CTNdzyF8PVDhwP6N+67gK+jYy2VW
X-Google-Smtp-Source: APXvYqyuoIiQmpfqfjSYeb9Sq+aq9xtd9FKB+UgdM4CvgQ+HCb7YXuB4FIivjzV+iRS0ihhBqUqdTg==
X-Received: by 2002:a65:6282:: with SMTP id f2mr11382139pgv.152.1556146023084;
        Wed, 24 Apr 2019 15:47:03 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id n1sm20610917pgv.19.2019.04.24.15.47.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 15:47:02 -0700 (PDT)
Date:   Wed, 24 Apr 2019 15:47:01 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/6] mergetool: fallback to tool when guitool unavailable
Message-ID: <e975fe4a8b206d8e40f9c4d7cd278fdb5c7358f0.1556142510.git.liu.denton@gmail.com>
References: <cover.1556009181.git.liu.denton@gmail.com>
 <cover.1556142510.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556142510.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In git-difftool, if the tool is called with --gui but `diff.guitool` is
not set, it falls back to `diff.tool`. Make git-mergetool also fallback
from `merge.guitool` to `merge.tool` if the former is undefined.

If git-difftool were to use `get_configured_mergetool`, it would also
get the fallback behaviour in the following precedence:

1. diff.guitool
2. merge.guitool
3. diff.tool
4. merge.tool

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-mergetool.txt |  4 +++-
 git-mergetool--lib.sh           | 27 ++++++++++++++++++---------
 t/t7610-mergetool.sh            | 19 +++++++++++++++++++
 3 files changed, 40 insertions(+), 10 deletions(-)

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
index 68ff26a0f7..ada16acffc 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -350,20 +350,29 @@ guess_merge_tool () {
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
+	IFS=' '
+	for key in $keys
+	do
+		for section in $sections
+		do
+			merge_tool=$(git config $section.$key) && break 2
+		done
+	done
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
2.21.0.1000.g7817e26e80

