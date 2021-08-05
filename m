Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDA1C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 19:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D258A60F35
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 19:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbhHET2x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 15:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhHET2w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 15:28:52 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A97BC061765
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 12:28:37 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id a8so11350169pjk.4
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 12:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M+FcrpBv0EUcFYS3z8VwxK4Rd2iUMu/UzEgjWygBYUU=;
        b=eqX625EWjs6oR5NIWymedGv3XcWQnIEk3C1y4oJstfp36NXYUJBiMch4KjdeswYQjG
         2vEvf6vec6Y2Cs/3rif55u7hbta5iSefUXKjy1eY9eFnS6kmQQuIRfKoeXwmnvnurQve
         F8QQhSWKDlYW60ejVHcfKxWOYGnCPORGTYOKOJpBIoR68VkxpY6JX0MbtVCwQ5F9nYOC
         gqlSKIE/IP4qRalw6rOLnlRIfxM0/LqpJsr8LTZByUY22oHl9K6zR8g/GoZkh4/TnP4j
         Pcq/uIHU4NcFdBuZApdLyE7GDoZ/Bd8kHVfN7J7pHATjhTuHOkRFKEiuQ1Nml+D7BCwR
         byXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M+FcrpBv0EUcFYS3z8VwxK4Rd2iUMu/UzEgjWygBYUU=;
        b=A6A2K7W79Z3pGpg6VScR+MdU8pJVnJzv/hBkdWKsW7o8PfVeHrWnehv1bLNOyD5gpL
         U0u+A9ZJNuQQy1hBM4xICAyu3TA7dFRPiFttG50x6iyvHMTljPVRFOgtbN73lGqK/bIN
         qe2Ifeo2FI7Y72mYGqeqIo0vV+5o2Ji8/YWOA3GYnreQy7oKOCK0Pu8LCUKl6yswmUKG
         v3A+hwEWFFaFsSQrh5wqnGlDyo22BIt/32JhHRhue2Yse7v5WQQEJq/fumLcWCQtVGrj
         95MuPzATzHDbE6lq1xgJdr/j+BolP/+Gw7pzHXdJaaYAt2NIaHAbTCN9lWQTDswdqjz5
         z8cg==
X-Gm-Message-State: AOAM5318eaiQfCdJoU1Gi5qKpu61HSTqinbmlO/ryTBudlUILQfo0haQ
        1Rbl5B0MKnaATCWajS1r8VGL+s6CIGF1sg==
X-Google-Smtp-Source: ABdhPJzFFM1jHvrrsGymDjXpA280xfeG6n4bEYPJnhWvv6qVBwaKrQVQkH1DdcnFfP6piZmISVq8Ug==
X-Received: by 2002:a17:902:c651:b029:12c:1ec0:a8b8 with SMTP id s17-20020a170902c651b029012c1ec0a8b8mr5276179pls.40.1628191716951;
        Thu, 05 Aug 2021 12:28:36 -0700 (PDT)
Received: from localhost.localdomain ([183.82.191.73])
        by smtp.gmail.com with ESMTPSA id c13sm7601854pfi.71.2021.08.05.12.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 12:28:36 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
Subject: [PATCH] submodule--helper: fix incorrect newlines in an error message
Date:   Fri,  6 Aug 2021 00:58:03 +0530
Message-Id: <20210805192803.679948-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.32.0.385.g8c8534732c.dirty
In-Reply-To: <20210710074801.19917-5-raykar.ath@gmail.com>
References: <20210710074801.19917-5-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A refactoring[1] done as part of the recent conversion of
'git submodule add' to builtin, changed the error message
shown when a Git directory already exists locally for a submodule
name. Before the refactoring, the error used to appear like so:

  --- START OF OUTPUT ---
  $ git submodule add ../sub/ subm
  A git directory for 'subm' is found locally with remote(s):
    origin        /me/git-repos-for-test/sub
  If you want to reuse this local git directory instead of cloning again from
    /me/git-repos-for-test/sub
  use the '--force' option. If the local git directory is not the correct repo
  or you are unsure what this means choose another name with the '--name' option.
  ---  END OF OUTPUT  ---

After the refactoring the error started appearing like so:

 --- START OF OUTPUT ---
  $ git submodule add ../sub/ subm
  A git directory for 'subm' is found locally with remote(s):  origin     /me/git-repos-for-test/sub
  fatal: If you want to reuse this local git directory instead of cloning again from
  /me/git-repos-for-test/sub
  use the '--force' option. If the local git directory is not the correct repo
  or if you are unsure what this means, choose another name with the '--name' option.

  ---  END OF OUTPUT  ---

As one could observe the remote information is printed along with the
first line rather than on its own line. Also, there's an additional
newline following output.

Make the error message consistent with the error message that used to be
printed before the refactoring.

[1]: https://lore.kernel.org/git/20210710074801.19917-5-raykar.ath@gmail.com/#t

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---

Even with this patch, the error message is still not fully consistent with the one that
used to be printed before the refactoring. Here's the diff:

3c3
< If you want to reuse this local git directory instead of cloning again from
---
> fatal: If you want to reuse this local git directory instead of cloning again from
6c6
< or you are unsure what this means choose another name with the '--name' option.
---
> or if you are unsure what this means, choose another name with the '--name' option.


The first part shows that it is additionally prefixed with 'fatal: '. While the 'fatal :' prefix
made sense in other cases, I wonder if it's helpful in this case as the message being
printed is an informative one. Should we avoid using 'die' to print this message?

The second part of the diff shows that there's some small grammatcial tweaks in the last
line. While I appreciate the intention, I'm not very sure if this change is a strict
improvement. I wonder about this as the original sounded good enough to me and thus it
feels like the change in message is triggering unnecesssary translation work. Should
we avoid the change? Or does it actually seem like an improvement to the message?


builtin/submodule--helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 3cbde305f3..560be07091 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2824,7 +2824,7 @@ static int add_submodule(const struct add_data *add_data)
 		if (is_directory(submod_gitdir_path)) {
 			if (!add_data->force) {
 				fprintf(stderr, _("A git directory for '%s' is found "
-						  "locally with remote(s):"),
+						  "locally with remote(s):\n"),
 					add_data->sm_name);
 				show_fetch_remotes(stderr, add_data->sm_name,
 						   submod_gitdir_path);
@@ -2835,7 +2835,7 @@ static int add_submodule(const struct add_data *add_data)
 				      "use the '--force' option. If the local git "
 				      "directory is not the correct repo\n"
 				      "or if you are unsure what this means, choose "
-				      "another name with the '--name' option.\n"),
+				      "another name with the '--name' option."),
 				    add_data->realrepo);
 			} else {
 				printf(_("Reactivating local git directory for "
-- 
2.32.0.385.g8c8534732c.dirty

