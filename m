Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	URIBL_BLACK,URIBL_DBL_SPAM shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 364E11F453
	for <e@80x24.org>; Fri,  2 Nov 2018 04:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeKBOFZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 10:05:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38014 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbeKBOFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 10:05:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id l2-v6so820733wmh.3
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 21:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HlxCFFWGS1jEO0MHcLe9R/K7pYZb7uAGdI2WArPVvbA=;
        b=D35rPYluM+5OEeXRftuXd+63jaHQWGhMSGc3jw1wrMzjVNWcDf6NluLHyb3Hwsy2NE
         86Qg5c4eEhRcU/cx+IMgIt+XtnBywfiec1dnhwG/5xNj9TQjLcDArLmbZspKG2e+2ZbE
         BSs60lEkg0k1+/TP+F38ZPjFeBnjbBjfKUThHBFiAe8yeqelyijPqhPzNPYBY+TIXGN7
         U58SezGuQ5Qf+dEtvegn4RgaywIfZmQMPuECBv/CIbBwlYNFi5GnGt7Ty0WH1YSdjbE3
         TSnMsxW6Pd6TiSKUKdHOk1f81AQpexnV+zjX5aaFpGbatP0mdbWZ+xfQ8naqOVnRgTwf
         9jXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HlxCFFWGS1jEO0MHcLe9R/K7pYZb7uAGdI2WArPVvbA=;
        b=p/4LubHXDoinIpwEVU/GXBICkOYp0+Hj1LzCzpLyAUwJQDPLLbj7lgMxOhsUCFe18k
         L/TYdR1OXj3gv4LwDnoDbei7zfxgqZ3XyLY2B8GfsgAr2t16v+qf48FrgSpDV32i387T
         0AygjZzbAU5P5p6QGIcFL21d3DwaXjqGpRN0ENzxFALoTCV96Aeo5HcE38CxLygfJLlh
         D9Hbav8t95T2nC5uk2Gi7M6VtGD+lF+bARxMckmWS52Dj7yv9hivLJuVzrByNSFc0SgP
         7uAtHVyeZbyvthiIcPTHIdDUO7bcvdMHMVrGXHYAbxEAPLXBHFHPPWKParG+kCRdUEnU
         yp6A==
X-Gm-Message-State: AGRZ1gI9UyuxYOA+fpM18hlWQmRwBWlPsmpTVZGVKAnIfg9wfIXm9fih
        Ah06//ggIIWhoAZkvk6MYqCVk/LmqyY=
X-Google-Smtp-Source: AJdET5c9nSW1RFb47SYOWv+vPfCMl0TLfFkNL+VxWekrSR8lb/akZnRfweEP0zchXdh6QrlxVIPnuA==
X-Received: by 2002:a1c:6c09:: with SMTP id h9-v6mr87422wmc.131.1541134771979;
        Thu, 01 Nov 2018 21:59:31 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u13-v6sm21846180wrn.11.2018.11.01.21.59.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 21:59:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, slawica92@hotmail.com,
        Slavica Djukic <slavicadj.ip2018@gmail.com>
Subject: [PATCH 2+3/3] stash: tolerate missing user identity
References: <20181101115546.13516-1-slawica92@hotmail.com>
        <20181101115834.19044-1-slawica92@hotmail.com>
Date:   Fri, 02 Nov 2018 13:59:30 +0900
In-Reply-To: <20181101115834.19044-1-slawica92@hotmail.com> (Slavica Djukic's
        message of "Thu, 1 Nov 2018 12:58:34 +0100")
Message-ID: <xmqq8t2cqdl9.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "git stash" command insists on having a usable user identity to
the same degree as the "git commit-tree" and "git commit" commands
do, because it uses the same codepath that creates commit objects
as these commands.

It is not strictly necesary to do so.  Check if we will barf before
creating commit objects and then supply fake identity to please the
machinery that creates commits.

This is not that much of usability improvement, as the users who run
"git stash" would eventually want to record their changes that are
temporarily stored in the stashes in a more permanent history by
committing, and they must do "git config user.{name,email}" at that
point anyway, so arguably this change is only delaying a step that
is necessary to work in the repository.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This time with a proposed commit log message and a flip to the
   test; this would be able to replce 2/3 and 3/3 without waiting
   for ps/stash-in-c to stabilize and become ready to be based on
   further work like this one.

   We need to extend the test so that when a reasonable identity is
   present, the stashes are created under that identity and not with
   the fallback one, which I do not think is tested with the previous
   step, so there still is a bit of room to improve [PATCH 1/3]

 git-stash.sh     | 17 +++++++++++++++++
 t/t3903-stash.sh |  2 +-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/git-stash.sh b/git-stash.sh
index 94793c1a91..789ce2f41d 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -55,6 +55,20 @@ untracked_files () {
 	git ls-files -o $z $excl_opt -- "$@"
 }
 
+prepare_fallback_ident () {
+	if ! git -c user.useconfigonly=yes var GIT_COMMITTER_IDENT >/dev/null 2>&1
+	then
+		GIT_AUTHOR_NAME="git stash"
+		GIT_AUTHOR_EMAIL=git@stash
+		GIT_COMMITTER_NAME="git stash"
+		GIT_COMMITTER_EMAIL=git@stash
+		export GIT_AUTHOR_NAME
+		export GIT_AUTHOR_EMAIL
+		export GIT_COMMITTER_NAME
+		export GIT_COMMITTER_EMAIL
+	fi
+}
+
 clear_stash () {
 	if test $# != 0
 	then
@@ -67,6 +81,9 @@ clear_stash () {
 }
 
 create_stash () {
+
+	prepare_fallback_ident
+
 	stash_msg=
 	untracked=
 	while test $# != 0
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index a9a573efa0..3dcf2f14d1 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1096,7 +1096,7 @@ test_expect_success 'stash -- <subdir> works with binary files' '
 	test_path_is_file subdir/untracked
 '
 
-test_expect_failure 'stash works when user.name and user.email are not set' '
+test_expect_success 'stash works when user.name and user.email are not set' '
 	git reset &&
 	>1 &&
 	git add 1 &&
-- 
2.19.1-801-gd582ea202b

