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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AF8C433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 011CE60FE4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 15:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbhEJPhS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 11:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236915AbhEJPgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 11:36:16 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE18C06138C
        for <git@vger.kernel.org>; Mon, 10 May 2021 08:35:01 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id y9so21343977ljn.6
        for <git@vger.kernel.org>; Mon, 10 May 2021 08:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6KhzJs/dinjnLOcbhzCxccbsE7+tAIYsSiwjLFYEEfQ=;
        b=mHzpZU8SKVypim3+fsAPrSw6jsc0DuumLc+d3jVvZGaC3oJdun5ysK6EFKyt0JPBSv
         Y/VslabjvJtRlIwFFLpHMHaz6CYHHSkMu2Euio6PpGz1KeAjpcUdg0rrPD6NKqu7E4Mw
         +Bb7/Wm7QuvqJTKqwLFW6SfKl7iq+Ia31ZUn2+xROMcy6AWHYAcmzwqzXAm+IYlyYN4Z
         NJ7XSK0TAwoUiijWuUvqgw5UKeXrkUmWY81ChWd+EtYM48okn3TVISee2cOXireDTxBg
         GupyyDOMt9sai1eeTfimbaWVeAFyNp1P+2NvYwEy7ZH+xGAok81XANXYgy3Zxw/2MUeP
         eztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6KhzJs/dinjnLOcbhzCxccbsE7+tAIYsSiwjLFYEEfQ=;
        b=qsyIxh5dDSK40UnYNm/sVxvbe2pJZx6Shfr3Q8JCgdP0rhFn22v4WgAbpQIRCzpeSq
         eXTn8ojsig7kXt8qX6+lEfeGJIIaL/h0B1OeXk/iMY5+1ZV7pJQc2ZT+aFO6nuT9qLD/
         sSYrJY77LjR21B3D+d1aRj5zT1BL6huBA5BqCMJSctB0x8r7O6fqAtkG5bk4OicYrD9S
         +CK2sXIiH15xRdlTQthcmIuYcYCHwi38xRWoXnm3qShZaLb2MoY8J7k70ZseOkZ+L5Od
         7MmVud0IAXVtU9ket3/pWZQ5I/Y6nyZ97pGZfoC45drMZAzSpS2T2xivTNgZvn79fCey
         Ze3A==
X-Gm-Message-State: AOAM531wgUrx2Wkj4GT1obEbW4vFmBJquM0Q3O7rBzBo5xu7lDv5ztvI
        0Q1J9GKmfbUHLFq7xCWUFIA=
X-Google-Smtp-Source: ABdhPJyObqb/FnDdbURC1pexFG/2F+dG1Em3TQLxJqRpFOEA+/cplchkfTrDzVAhxJUBC6HEwxL4Ug==
X-Received: by 2002:a2e:330e:: with SMTP id d14mr20537737ljc.412.1620660899603;
        Mon, 10 May 2021 08:34:59 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id p8sm1525840lfe.224.2021.05.10.08.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 08:34:59 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 6/6] diff-merges: let -m imply -p
Date:   Mon, 10 May 2021 18:34:51 +0300
Message-Id: <20210510153451.15090-7-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210510153451.15090-1-sorganov@gmail.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210510153451.15090-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix long standing inconsistency between -c/--cc that do imply -p, on
one side, and -m that did not imply -p, on the other side.

After this patch

  git log -m

will start to produce diffs without need to provide -p as well, that
improves both consistency and usability. It gets even more useful if
one sets "log.diffMerges" configuration variable to "first-parent" to
force -m produce usual diff with respect to first parent only.

Previous semantics of -m could still be accessed using
--diff-merges=separate option.

Change documentation accordingly.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/diff-options.txt | 8 ++++----
 diff-merges.c                  | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 530d1159141f..32e6dee5ac3b 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -49,10 +49,9 @@ ifdef::git-log[]
 --diff-merges=m:::
 -m:::
 	This option makes diff output for merge commits to be shown in
-	the default format. `-m` will produce the output only if `-p`
-	is given as well. The default format could be changed using
+	the default format. The default format could be changed using
 	`log.diffMerges` configuration parameter, which default value
-	is `separate`.
+	is `separate`. `-m` implies `-p`.
 +
 --diff-merges=first-parent:::
 --diff-merges=1:::
@@ -62,7 +61,8 @@ ifdef::git-log[]
 --diff-merges=separate:::
 	This makes merge commits show the full diff with respect to
 	each of the parents. Separate log entry and diff is generated
-	for each parent.
+	for each parent. This is the format that `-m` produced
+	historically.
 +
 --diff-merges=combined:::
 --diff-merges=c:::
diff --git a/diff-merges.c b/diff-merges.c
index 211c99482cac..a827482a97ff 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -98,6 +98,7 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
 
 	if (!strcmp(arg, "-m")) {
 		set_to_default(revs);
+		revs->merges_imply_patch = 1;
 	} else if (!strcmp(arg, "-c")) {
 		set_combined(revs);
 		revs->merges_imply_patch = 1;
-- 
2.25.1

