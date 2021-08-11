Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38198C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 23:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DEA360F46
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 23:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbhHKXoJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 19:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbhHKXoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 19:44:09 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20EEC061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 16:43:44 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id c9so5430097wri.8
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 16:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gyNMu2t/2JabPA7dKjJCark6KsDn5QTjGSwKamubvgk=;
        b=Na5ZnXO4AbmiL195XtKhbQ55ztDlhSXPNa7Dv5SuAukEsV37ZobpFB/cvAPnXzqYJh
         De5b4OY3sp2vMlXndGOssPie1bjxSvxhxHeGMeD6hS8NDuPF2bIunQD49jSJFNM7JL2C
         TztoTTA2B3lh7hVI6A/fkbdbMJ1T4WSawE8hSD4FcmBQwgp7t/Z7xfvkk+tcG6y8JvPP
         b5GzxkZCLrtCZ0J9bJbc7Top96q6SYVkQgYgDQJy4IpTGQOVVOcUpSHSSONA9XA4V25O
         Pb6VzvtHFPy8cuA2M+25IwmSL+tiFNaAVhFsRNaU2KtpfRi208VTHxJ6UQnD5ZAPogSr
         RmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gyNMu2t/2JabPA7dKjJCark6KsDn5QTjGSwKamubvgk=;
        b=IOZGSlEdwCykLTdOQbyHvDd0cmejHFt8vvPAVtPFO5rcljN+OYyqFapSPvVD3gW7Ho
         D8/9rSJLz0fiOIrtA03y/UTn4ZQGh+LTC/69EnYEkWnMkeNfktGKe+KpRTaJhdF9YErk
         oc39rbOCYKLc+DYI/WIWSExstNROowrWZyQl8ipnjI8CyZnXut2BvY8/vc0b4rD8Mr5Q
         NgA3i6ik9jxkeIEJL8eEZAQZeTGNlXD9GTrHSioj3SqCJfN/h6FftCLO25KbXADlhRKZ
         I0l8Hch7272GOFMWBM7jXG2sC8UaIqRGOX22pnuvNbfiHBMO/VXiGYl2WEAMgeEHu8iJ
         09yw==
X-Gm-Message-State: AOAM5305gDOc3U/aOu+xDh3q8ibVwwhBqtgEVrVx3FwdY33yt1dhxHqx
        PiWCo1M+CRUm41esq5YqLTtP4aXt2xc=
X-Google-Smtp-Source: ABdhPJyqcgIFHYQ2xXRbyq61UN/eKyc+8oN/9VkspYHec8SNUXgasVGmxnF8folPuAPzJLYS7WoDfA==
X-Received: by 2002:a5d:4d4b:: with SMTP id a11mr776220wru.411.1628725423229;
        Wed, 11 Aug 2021 16:43:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e11sm784433wrm.80.2021.08.11.16.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 16:43:42 -0700 (PDT)
Message-Id: <pull.1014.v2.git.1628725421868.gitgitgadget@gmail.com>
In-Reply-To: <pull.1014.git.1628689758413.gitgitgadget@gmail.com>
References: <pull.1014.git.1628689758413.gitgitgadget@gmail.com>
From:   "Joel Klinghed via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Aug 2021 23:43:41 +0000
Subject: [PATCH v2] commit: restore --edit when combined with --fixup
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Joel Klinghed <the_jk@spawned.biz>,
        Joel Klinghed <the_jk@spawned.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Joel Klinghed <the_jk@spawned.biz>

Recent changes to --fixup, adding amend suboption, caused the
--edit flag to be ignored as use_editor was always set to zero.

Restore edit_flag having higher priority than fixup_message when
deciding the value of use_editor by only changing the default
if edit_flag is not set.

Signed-off-by: Joel Klinghed <the_jk@spawned.biz>
---
    commit: restore --edit when combined with --fixup
    
    Recent changes to --fixup, adding amend suboption, caused the --edit
    flag to be ignored as use_editor was always set to zero.
    
    Restore edit_flag having higher priority than fixup_message when
    deciding the value of use_editor by only changing the default if
    edit_flag is not set.
    
    Changes since v1: Added test verifying that --fixup --edit brings up
    editor.
    
    Signed-off-by: Joel Klinghed the_jk@spawned.biz

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1014%2Fthejk%2Ffixup_edit-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1014/thejk/fixup_edit-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1014

Range-diff vs v1:

 1:  b3e44c6ccde ! 1:  0ee926d4149 commit: restore --edit when combined with --fixup
     @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *ar
       		}
       	}
       
     +
     + ## t/t7500-commit-template-squash-signoff.sh ##
     +@@ t/t7500-commit-template-squash-signoff.sh: test_expect_success 'commit --fixup -m"something" -m"extra"' '
     + 
     + extra"
     + '
     ++test_expect_success 'commit --fixup --edit' '
     ++	commit_for_rebase_autosquash_setup &&
     ++	cat >e-append <<-\EOF &&
     ++	#!/bin/sh
     ++	sed -e "2a\\
     ++something\\
     ++extra" <"$1" >"$1-"
     ++	mv "$1-" "$1"
     ++	EOF
     ++	chmod 755 e-append &&
     ++	EDITOR="./e-append" git commit --fixup HEAD~1 --edit &&
     ++	commit_msg_is "fixup! target message subject linesomething
     ++extra"
     ++'
     ++
     + get_commit_msg () {
     + 	rev="$1" &&
     + 	git log -1 --pretty=format:"%B" "$rev"


 builtin/commit.c                          |  3 ++-
 t/t7500-commit-template-squash-signoff.sh | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 190d215d43b..4c5286840c5 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1333,7 +1333,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		} else {
 			fixup_commit = fixup_message;
 			fixup_prefix = "fixup";
-			use_editor = 0;
+			if (0 > edit_flag)
+				use_editor = 0;
 		}
 	}
 
diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 7d02f79c0de..d71c7812180 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -281,6 +281,21 @@ test_expect_success 'commit --fixup -m"something" -m"extra"' '
 
 extra"
 '
+test_expect_success 'commit --fixup --edit' '
+	commit_for_rebase_autosquash_setup &&
+	cat >e-append <<-\EOF &&
+	#!/bin/sh
+	sed -e "2a\\
+something\\
+extra" <"$1" >"$1-"
+	mv "$1-" "$1"
+	EOF
+	chmod 755 e-append &&
+	EDITOR="./e-append" git commit --fixup HEAD~1 --edit &&
+	commit_msg_is "fixup! target message subject linesomething
+extra"
+'
+
 get_commit_msg () {
 	rev="$1" &&
 	git log -1 --pretty=format:"%B" "$rev"

base-commit: ebf3c04b262aa27fbb97f8a0156c2347fecafafb
-- 
gitgitgadget
