Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676AEC4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 17:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42AF56101D
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 17:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhHBRuI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 13:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhHBRuH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 13:50:07 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C50C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 10:49:57 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id c16so5653151lfc.2
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 10:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mnhGcDduwfJ9g3cobX4eP6w3KAote3OeNO+BUnU+KX8=;
        b=PBG+ZpkbCmFTpdQeJmgu3K0PQsHwrMzdq7CmpK8l7EtEo+lTYqVFGhIuQoo77Nk6MN
         tz/KxlPFg+k3hbJhBokp6pFbVqQE+z+xyl+tzSaPKHap3N9PFJXAgnOOGNfh/KzS/wcL
         fVjMlOMUHuQPf1pi3MSkQi/UG0n2pPS+MXbyyqZ4TCo2E+36neUKvMqzexFo89Ij6MAW
         h/NtJFfMwuXZm4HirPX16sg9PCIwqv4rwJ97txJhs5bGprduxBA5Id+dOdzzG6QQjb+j
         LbiclBFN8y3D5rro60iQ46Z15GFC/C+85v1zQBwetiACifWpc6w8q/S0nwTwDsVMcDG+
         dwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mnhGcDduwfJ9g3cobX4eP6w3KAote3OeNO+BUnU+KX8=;
        b=kSrC9TeTG/6TUDJhUe8onhaPkbOhBsSzan3M6UYKnDfBNUEwzyOGyQ+pkD8XGaleNG
         yad7G03/YvF2Ns7ClHvM4etCkDp3uZTH9vuHsZiBT1cYMKI0iYmo9omMfQmjm89hxVbX
         0wrGq+ZRBC+sp6vFvvgczqsXWFl6uv1yhPxDSMNkx4rBAUMlMzSL3/a97onErxwq7Miy
         n5Zuc/HcfMbDdx4prwwhxKx4r/HSt3GTY5XFCxFP6v1+ofwhb1ZYjvTMuptwQQWTQR3W
         9CqZeol50YCC84LiWUn5Cf1U9H5Vsvy2hwd4YlZluaMeS0udoL0Heffe3wY+Y/Zcctyj
         JWzA==
X-Gm-Message-State: AOAM530GdQm3XEU2Q27KR1K5sLs0n+o56+5+JsZ+dzgF0MNGvjLaWIsj
        rnwrDjyZqt6ujWtSjPRbNDE=
X-Google-Smtp-Source: ABdhPJzR7cr5za0cY6udRqFhF57D/DWNU4dDt9RmIkaYjrajJwkDyu1Rt7Km99rh02c9xSwNceecKg==
X-Received: by 2002:ac2:5978:: with SMTP id h24mr9066304lfp.354.1627926595580;
        Mon, 02 Aug 2021 10:49:55 -0700 (PDT)
Received: from paasan.lan (150.37-191-137.fiber.lynet.no. [37.191.137.150])
        by smtp.gmail.com with ESMTPSA id a13sm1017359lfu.13.2021.08.02.10.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 10:49:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     avarab@gmail.com, gitster@pobox.com
Cc:     git@vger.kernel.org,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: [PATCH v2] clone: Allow combining --bare and --origin
Date:   Mon,  2 Aug 2021 19:49:44 +0200
Message-Id: <20210802174944.53745-1-oystwa@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <8735rsqlal.fsf@evledraar.gmail.com>
References: <8735rsqlal.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The constraint on passing both these options simultaneously has been
present since long before clone was ported to C. At the time no
configuration referencing the remote repository was written at all in
bare clones.

Since df61c88979 (clone: also configure url for bare clones, 2010-03-29)
the remote repository is mentioned in the configuration file also for
bare repos, so it makes sense to allow the user to rename it if they
wish.

Signed-off-by: Øystein Walle <oystwa@gmail.com>
---

Hi Junio and Ævar,

I investigated a bit more and updated the commit message accordingly.
Instead of just removing the test I have replaced it with one that
checks that the behavior is as intended. 

Ævar, I was a bit melodramatic when I wrote "especially useful". I have
toned the commit message down a bit :-) In truth, I don't personally
have a use-case for this (I did reach out to the person who asked about
it in #git but did't get a reply) and have no problems with seeing this
patch ultimately rejected. It's just a result of me seeing it asked
about and getting an itch from it. But in my humble opinion this is now
an "artificial" constraint (for lack of a better term) and should be
removed on the grounds that there is no reason for it to be there in the
first place.

Thanks,
Øsse

 builtin/clone.c          |  3 ---
 t/t5606-clone-options.sh | 10 +++++-----
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 66fe66679c..70ec72ea85 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1014,9 +1014,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		option_bare = 1;
 
 	if (option_bare) {
-		if (option_origin)
-			die(_("--bare and --origin %s options are incompatible."),
-			    option_origin);
 		if (real_git_dir)
 			die(_("--bare and --separate-git-dir are incompatible."));
 		option_no_checkout = 1;
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 3a595c0f82..c40dde816d 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -30,12 +30,12 @@ test_expect_success 'rejects invalid -o/--origin' '
 
 '
 
-test_expect_success 'disallows --bare with --origin' '
-
-	test_must_fail git clone -o foo --bare parent clone-bare-o 2>err &&
-	test_debug "cat err" &&
-	test_i18ngrep -e "--bare and --origin foo options are incompatible" err
+test_expect_success '--bare works with -o/--origin' '
 
+	git clone --bare --origin=somewhere parent clone-bare &&
+	url="$(git -C clone-bare config --local remote.somewhere.url)" &&
+	test -n "$url" &&
+	test_must_fail git -C clone-bare config --local remote.origin.url
 '
 
 test_expect_success 'disallows --bare with --separate-git-dir' '
-- 
2.27.0

