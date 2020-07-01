Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C12C433DF
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FBAF20702
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 13:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkGmYjDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbgGANXY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728399AbgGANXY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 09:23:24 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB47C08C5C1
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 06:23:23 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g75so22379129wme.5
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 06:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cofDuTYaI60XY9nEcYUOMTWwmdYx3c/S95iX7zmT1Os=;
        b=ZkGmYjDL1b00E9Lb8eiKBKRnOHZ/0CqFpuicWK6G93kzp/kQqkCt+4NbbMlMNWj3bJ
         gwrHjVOGg/hyqpmJtYieyijB9zx5on7ZyY+Qmu6pYq+YfOFcIJuBG574MigRE6Tf60Yt
         rBJDIAUGSmcbrtfxdTAqdl4IWMV0UPuKUZ5uqplqbHFl2XxHvmMF6IOVoCbhvDZxfdlq
         wridjCmr+aYUHuG/kLyxfYBaFstfBgtF7rYO8QqEs44n9e1fepE/nGMhVU+f7Iq44BrF
         khuSKKheJ6SDLOFFCk5ET5PFAUUpmWWeuX5u5y1mVFqjiwpR5RnkWQ+eMuUMQJRW2oLe
         ovWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cofDuTYaI60XY9nEcYUOMTWwmdYx3c/S95iX7zmT1Os=;
        b=mQB9eqjxBwcDmuwlvTl8BpnrOVy1ZOZXutnjFAwsyLrR8Ew76k6eh0ycSUa5tjOcwc
         Ke4xkIgJzavWTRtHCsO8HzYzdByf408Je/bBlgH/Ms18BHMpsGotshJR+L8f2Tp8t+Sr
         RnbX7dF0E6T16OvSoUYLIuPTvt99n2y3jja2tBOQFMTfXGbfnYzFplxBUrVeOB2geIOw
         BxdTuB5TrHZDcpUmKUXKzElEdQNjHSIsHxv58/yR0/QMI4pPnDHt1fUzGjop/ACuQndR
         G8V80Z+RNeHFMpVjAHMOnogGEMoUEO0VPwq8eQz0DB8+IFiUHrIJClckXgdEUc/dXSSu
         zLtA==
X-Gm-Message-State: AOAM531xUiZquqdO2A91Mizth7YFvzc4/tJ51y5cUQi9I1haw6fZnbnk
        96GZKsumU7wnEmMX9s9RTuEbD1S8H04=
X-Google-Smtp-Source: ABdhPJwtP90tnXT/62EUdxXc5Ny4r4c6VokY+dCRVAglQW+2jaMKLSXd9AjFdOky/OE3X0jOosV02Q==
X-Received: by 2002:a1c:e90a:: with SMTP id q10mr28080085wmc.140.1593609802125;
        Wed, 01 Jul 2020 06:23:22 -0700 (PDT)
Received: from localhost.localdomain ([193.56.244.51])
        by smtp.gmail.com with ESMTPSA id p17sm6871286wma.47.2020.07.01.06.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 06:23:21 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] ref-filter: add support for %(contents:size)
Date:   Wed,  1 Jul 2020 15:23:08 +0200
Message-Id: <20200701132308.16691-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.221.ga08a83db2b.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's useful and efficient to be able to get the size of the
contents directly without having to pipe through `wc -c`.

Also the result of the following:

`git for-each-ref --format='%(contents)' | wc -c`

is off by one as `git for-each-ref` appends a newline character
after the contents, which can be seen by comparing its ouput
with the output from `git cat-file`.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-for-each-ref.txt | 27 +++++++++++++++------------
 ref-filter.c                       |  7 ++++++-
 t/t6300-for-each-ref.sh            |  2 ++
 3 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 6dcd39f6f6..673ace94d1 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -232,18 +232,21 @@ Fields that have name-email-date tuple as its value (`author`,
 `committer`, and `tagger`) can be suffixed with `name`, `email`,
 and `date` to extract the named component.
 
-The complete message in a commit and tag object is `contents`.
-Its first line is `contents:subject`, where subject is the concatenation
-of all lines of the commit message up to the first blank line.  The next
-line is `contents:body`, where body is all of the lines after the first
-blank line.  The optional GPG signature is `contents:signature`.  The
-first `N` lines of the message is obtained using `contents:lines=N`.
-Additionally, the trailers as interpreted by linkgit:git-interpret-trailers[1]
-are obtained as `trailers` (or by using the historical alias
-`contents:trailers`).  Non-trailer lines from the trailer block can be omitted
-with `trailers:only`. Whitespace-continuations can be removed from trailers so
-that each trailer appears on a line by itself with its full content with
-`trailers:unfold`. Both can be used together as `trailers:unfold,only`.
+The complete message in a commit and tag object is `contents`.  Its
+size in bytes is `contents:size`.  Its first line is
+`contents:subject`, where subject is the concatenation of all lines of
+the commit message up to the first blank line.  The next line is
+`contents:body`, where body is all of the lines after the first blank
+line.  The optional GPG signature is `contents:signature`.  The first
+`N` lines of the message is obtained using `contents:lines=N`.
+Additionally, the trailers as interpreted by
+linkgit:git-interpret-trailers[1] are obtained as `trailers` (or by
+using the historical alias `contents:trailers`).  Non-trailer lines
+from the trailer block can be omitted with
+`trailers:only`. Whitespace-continuations can be removed from trailers
+so that each trailer appears on a line by itself with its full content
+with `trailers:unfold`. Both can be used together as
+`trailers:unfold,only`.
 
 For sorting purposes, fields with numeric values sort in numeric order
 (`objectsize`, `authordate`, `committerdate`, `creatordate`, `taggerdate`).
diff --git a/ref-filter.c b/ref-filter.c
index bf7b70299b..036a95d0d2 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -127,7 +127,8 @@ static struct used_atom {
 			unsigned int nobracket : 1, push : 1, push_remote : 1;
 		} remote_ref;
 		struct {
-			enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB, C_TRAILERS } option;
+			enum { C_BARE, C_BODY, C_BODY_DEP, C_LENGTH,
+			       C_LINES, C_SIG, C_SUB, C_TRAILERS } option;
 			struct process_trailer_options trailer_opts;
 			unsigned int nlines;
 		} contents;
@@ -338,6 +339,8 @@ static int contents_atom_parser(const struct ref_format *format, struct used_ato
 		atom->u.contents.option = C_BARE;
 	else if (!strcmp(arg, "body"))
 		atom->u.contents.option = C_BODY;
+	else if (!strcmp(arg, "size"))
+		atom->u.contents.option = C_LENGTH;
 	else if (!strcmp(arg, "signature"))
 		atom->u.contents.option = C_SIG;
 	else if (!strcmp(arg, "subject"))
@@ -1253,6 +1256,8 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
 			v->s = copy_subject(subpos, sublen);
 		else if (atom->u.contents.option == C_BODY_DEP)
 			v->s = xmemdupz(bodypos, bodylen);
+		else if (atom->u.contents.option == C_LENGTH)
+			v->s = xstrfmt("%ld", strlen(subpos));
 		else if (atom->u.contents.option == C_BODY)
 			v->s = xmemdupz(bodypos, nonsiglen);
 		else if (atom->u.contents.option == C_SIG)
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index da59fadc5d..4f730acd48 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -125,6 +125,7 @@ test_atom head contents:body ''
 test_atom head contents:signature ''
 test_atom head contents 'Initial
 '
+test_atom head contents:size '8'
 test_atom head HEAD '*'
 
 test_atom tag refname refs/tags/testtag
@@ -170,6 +171,7 @@ test_atom tag contents:body ''
 test_atom tag contents:signature ''
 test_atom tag contents 'Tagging at 1151968727
 '
+test_atom tag contents:size '22'
 test_atom tag HEAD ' '
 
 test_expect_success 'Check invalid atoms names are errors' '
-- 
2.27.0.221.ga08a83db2b.dirty

