Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4045C4363A
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 23:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 545C020791
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 23:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="He/PKOnl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733201AbgJ1XUv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730788AbgJ1XUs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 19:20:48 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C0AC0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 16:20:47 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c16so822937wmd.2
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 16:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YFY34Sv9mxNHpZFo3ZGG6+7MPt1mRoBBhW9cIeemJ7s=;
        b=He/PKOnlapIyOZPjl887SpOxieA13ZXO0gf8ANcrjSmIQtWMqbN7Y8mZDa+WfRYMTu
         dJGbOYpc9oUq0iKhLsOqQuojsy7Gok1cHLx2RG6XyQr7aKOgzupvIoDe51sn0kL5BTwS
         ZqhWuUM3SKQ99XzfWgx17e+dXzpuk26yyQXDqbBve4HNpeTKpYwN0Ebj02XJGVED1doH
         HDfkloll2F8au24Fs9ddzv7mGsrlD4uSi6SfqemwbsNszqu3fqhJ74aOIk2j+gC3Plpg
         oGhv8V68D+MG4QoMzrlpaYoWcRiEIF77PrvSDy4gZhtxOvDzw5yLkkjsHglGO561yx4Q
         syZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YFY34Sv9mxNHpZFo3ZGG6+7MPt1mRoBBhW9cIeemJ7s=;
        b=HM3IwfGEepJMdwrD2U8hvq/WD7yK/3J6YPYW03NTy7IppfAi4ybyX3sWYW8z4OslDm
         rL1osAj0PmK6N18PG+H1T3UHVs8TtwYpfbp5VKlRRV8pEbkcrJrML8AGG73Sy/JCwBb5
         2HhdAgukqOzUnZb4+oaQI6TrPTMuqhEu0Hhos2lHCT2OdirOEiJqfka4OjU9vYyMqvqt
         OryKP8jyiGw+PKD5AdLjwYDJBAvrXzIbnEy5yufr2viBJ96I+Z2doef5gOMvTaEXYYQE
         8DSaOSIYfN/FKAe6n0HDrBWJ3Xx9h/LOLVc+gIgH0e5rLrhbZO838quLvVQPzM4+XfMJ
         dUuQ==
X-Gm-Message-State: AOAM533kjmL+yAGSgSfdrO4DlrOjDI3VSrvBACIH3lF40xihiYBbvyLa
        e+p5+PQMHLfc+EqYPfKh/zawwiSoIvE=
X-Google-Smtp-Source: ABdhPJw7gxwX1JpT4Ip1eCqj9zodiGR3jSAwbgPUshpGA8rZued9f5C6fH3gYZoryoEbgoEoZek0Aw==
X-Received: by 2002:a05:600c:2256:: with SMTP id a22mr8102553wmm.138.1603889277746;
        Wed, 28 Oct 2020 05:47:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k18sm6582769wrx.96.2020.10.28.05.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 05:47:57 -0700 (PDT)
Message-Id: <a1e1c977d0978424fb07c97be0479f43a325cbea.1603889270.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.774.git.1603889270.gitgitgadget@gmail.com>
References: <pull.774.git.1603889270.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 28 Oct 2020 12:47:50 +0000
Subject: [PATCH 6/6] blame: enable funcname blaming with userdiff driver
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Thomas Rast <tr@thomasrast.ch>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

In blame.c::cmd_blame, we send the 'path' field of the 'sb' 'struct
blame_scoreboard' as the 'path' argument to
'line-range.c::parse_range_arg', but 'sb.path' is not set yet; it's set
to the local variable 'path' a few lines later at line 1137.

This 'path' argument is only used in 'parse_range_arg' if we are blaming
a funcname, i.e. `git blame -L :<funcname> <path>`, and in that case it
is sent to 'parse_range_funcname', where it is used to determine if a
userdiff driver should be used for said <path> to match the given
funcname.

Since 'path' is yet unset, the userdiff driver is never used, so we fall
back to the default funcname regex, which is usually not appropriate for
paths that are set to use a specific userdiff driver, and thus either we
match some unrelated lines, or we die with

    fatal: -L parameter '<funcname>' starting at line 1: no match

This has been the case ever since `git blame` learned to blame a
funcname in 13b8f68c1f (log -L: :pattern:file syntax to find by
funcname, 2013-03-28).

Enable funcname blaming for paths using specific userdiff drivers by
sending the local variable 'path' to 'parse_range_arg' instead of the
yet unset 'sb.path'.

Add a regression test in 'annotate-tests.sh', which is sourced in
t8001-annotate.sh and t8002-blame.sh, leveraging an existing file used
to test the userdiff patterns in t4018-diff-funcname.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 builtin/blame.c     |  2 +-
 t/annotate-tests.sh | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 05f69211dd..917fedc635 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1104,7 +1104,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		long bottom, top;
 		if (parse_range_arg(range_list.items[range_i].string,
 				    nth_line_cb, &sb, lno, anchor,
-				    &bottom, &top, sb.path,
+				    &bottom, &top, path,
 				    the_repository->index))
 			usage(blame_usage);
 		if ((!lno && (top || bottom)) || lno < bottom)
diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index d933af5714..3aee61d2cc 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -479,6 +479,24 @@ test_expect_success 'blame -L ^:RE (absolute: end-of-file)' '
 	check_count -f hello.c -L$n -L^:ma.. F 4 G 1 H 1
 '
 
+test_expect_success 'setup -L :funcname with userdiff driver' '
+	echo "fortran-* diff=fortran" >.gitattributes &&
+	fortran_file=fortran-external-function &&
+	orig_file="$TEST_DIRECTORY/t4018/$fortran_file" &&
+	cp $orig_file . &&
+	git add $fortran_file &&
+	GIT_AUTHOR_NAME="A" GIT_AUTHOR_EMAIL="A@test.git" \
+	git commit -m "add fortran file" &&
+	sed -e "s/ChangeMe/IWasChanged/" <"$orig_file" >$fortran_file &&
+	git add $fortran_file &&
+	GIT_AUTHOR_NAME="B" GIT_AUTHOR_EMAIL="B@test.git" \
+	git commit -m "change fortran file"
+'
+
+test_expect_success 'blame -L :funcname with userdiff driver' '
+	check_count -f fortran-external-function -L:RIGHT A 7 B 1
+'
+
 test_expect_success 'setup incremental' '
 	(
 	GIT_AUTHOR_NAME=I &&
-- 
gitgitgadget
