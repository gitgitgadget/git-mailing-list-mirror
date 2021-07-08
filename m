Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77A3C07E96
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 15:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90E53613C1
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 15:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbhGHPGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 11:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhGHPGV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 11:06:21 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5EAC061574
        for <git@vger.kernel.org>; Thu,  8 Jul 2021 08:03:39 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x3so2079537pfc.11
        for <git@vger.kernel.org>; Thu, 08 Jul 2021 08:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fTGkXeLry6pqq8TX2OgQxc+Pioq0g45HS19E58rLFps=;
        b=TGr5+5euFq2JOc3eSRtrXEldn+FLxAR5UgxclaBzq4NI6PRfpgOCJzNcnU/kjNAQYy
         3hFecGrx6/Mik9eeGTNfiU/WlE51mTMZ5c1mglx1jYzJ6pbU9BWUOgDUvklxNlbxtFhC
         E/QM7q3I2FAxZf1quoSpdcYRORnYjwb+Kz7r2pyIW4n0iTSA5C4EkNrKpnMK1WG2i17v
         Z9KSxQqwypdlsy6rKRN577D1nGYEJ3CnPjtJ6BqBfdUWdAmnyTs7KfvHy1ABTtqx8H1m
         2lI9AaayUUrfmCYsUoYfop9ABUhff4OZYL+ABt7nXgaI63J9rOFcXvLkMtP3KHAH9z2U
         z+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fTGkXeLry6pqq8TX2OgQxc+Pioq0g45HS19E58rLFps=;
        b=lWbmigftgQnX0oM3hZFWmOqPQUWxi5w3PPHuJ4pAmo02qrTuJo7kyGDjITyHKYpge6
         CeEd4oGI1pS+SQnp+pcjLscQuik/3NCrp5K13nu/pMPdghgog1G/pc47uBXQELVjyRv4
         +jMUnIudbLwxgeaKSBY3/bmcOo+GxBeeQJfkck0E1kkN6XngAsZR/gnmU4+7PmgtRZ7f
         XJaT4S/BfZZ561yk9RU5NfqSVrDzzQpy1E7eK0hJU8IrGkBpFbjUju/YOVF1u+sO8KVl
         +1mHhYzVAnG4UXHmJVIRc1U8QyJV0zJdgbMvm4YNraM5b4q3yL9N5vOLGEWPQ0IBHIld
         visw==
X-Gm-Message-State: AOAM532HhvThMM0hL8hmI30fJHefzqNfFLNSjSjDdBIWZktuEC8B6euc
        VPlxpkVLQmDb/7i7VIboR2c=
X-Google-Smtp-Source: ABdhPJyTdJ6ADLA/80bn7mcOT5UCX5X6z4ZbECF6duPXFkR3d/O1BOSPIjvO8wI/C/HFq0nRaJ6wtw==
X-Received: by 2002:aa7:9436:0:b029:30b:30ba:5942 with SMTP id y22-20020aa794360000b029030b30ba5942mr31578648pfo.47.1625756619114;
        Thu, 08 Jul 2021 08:03:39 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id r13sm6784359pjj.9.2021.07.08.08.03.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jul 2021 08:03:38 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH] revision: allow pseudo options after --end-of-options
Date:   Thu,  8 Jul 2021 23:03:16 +0800
Message-Id: <20210708150316.10855-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Options and revisions can be seperated by the option "--end-of-options"
by introducing commit 19e8789b23 (revision: allow --end-of-options to
end option parsing, 2019-08-06).  The following command will show
revisions which have changes on file "bar" on a branch named "--foo":

    git rev-list --oneline --end-of-options --foo -- bar

If we want to see revisions between two revisions (rev1 and rev2), we
can use the following command:

    git rev-list --oneline --end-of-options rev1..rev2 --

We know that "rev1..rev2" is a shorthand for "rev2 --not rev1", but
we can not use the longer expression with option "--not" after the
"--end-of-options" option.  This is because the parser will not consume
revision pseudo options after seeing "--end-of-option".

Allow parsing revision pseudo options after "--end-of-options", the
following command is valid:

    git rev-list --oneline --end-of-options rev2 --not rev2 --

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 revision.c               |  7 ++++---
 t/t6000-rev-list-misc.sh | 45 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/revision.c b/revision.c
index 8140561b6c..0d37b5a759 100644
--- a/revision.c
+++ b/revision.c
@@ -2729,9 +2729,9 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		revarg_opt |= REVARG_CANNOT_BE_FILENAME;
 	for (left = i = 1; i < argc; i++) {
 		const char *arg = argv[i];
-		if (!seen_end_of_options && *arg == '-') {
-			int opts;
+		int opts;
 
+		if (*arg == '-') {
 			opts = handle_revision_pseudo_opt(submodule,
 						revs, argv + i,
 						&flags);
@@ -2739,7 +2739,9 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 				i += opts - 1;
 				continue;
 			}
+		}
 
+		if (!seen_end_of_options && *arg == '-') {
 			if (!strcmp(arg, "--stdin")) {
 				if (revs->disable_stdin) {
 					argv[left++] = arg;
@@ -2767,7 +2769,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			continue;
 		}
 
-
 		if (handle_revision_arg(arg, revs, flags, revarg_opt)) {
 			int j;
 			if (seen_dashdash || *arg == '^')
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index 12def7bcbf..3b2ca10456 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -169,4 +169,49 @@ test_expect_success 'rev-list --count --objects' '
 	test_line_count = $count actual
 '
 
+test_expect_success 'merge branch "--output=yikes" to main' '
+	git checkout main &&
+	git merge -m "Merge branch" \
+		--allow-unrelated-histories -- \
+		--output=yikes &&
+	echo three >> two/three &&
+	git add two/three &&
+	test_tick &&
+	git commit -m "three" &&
+	cat >expect <<-EOF &&
+	> three
+	> Merge branch
+	> another
+	> that
+	> two
+	> one
+	EOF
+	git log --pretty="%m %s" --end-of-options HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'parse pseudo option "--branches" after "--end-of-options"' '
+	cat >expect <<-EOF &&
+	> three
+	> another
+	> Merge branch
+	> that
+	> two
+	> one
+	EOF
+	git log --pretty="%m %s" --end-of-options \
+		--branches -- >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'parse pseudo option "--not" after "--end-of-options"' '
+	cat >expect <<-EOF &&
+	> three
+	EOF
+	git log --pretty="%m %s" --end-of-options \
+		HEAD --not --output=yikes -- \
+		two/three >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.32.0.rc0.27.g7b1e85181b

