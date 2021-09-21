Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEFFC433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 11:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D734E60ED5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 11:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbhIULTL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 07:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbhIULTL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 07:19:11 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081E5C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 04:17:43 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id j14so5993094plx.4
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 04:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I++FkWNtGNM5ERq0D5mTw6CTdEV5m5aHl5HLEfa8ZOc=;
        b=nZm28BINR6edTfau8ztoiS7AgcD1BTQi/cetkXSDjcGAQJ28nxPnY31Z13J4FeBHhy
         mosppimBVbPvdO1VVLH46fBvU1SB2aA+pnAXwMauc9x29H+iRUsvjFSIIdhYCUm/n9iH
         mjHkN5oKdsnOAXrMb6RWb65G5M/sQH50QzUvvP9IfPlOgFp+50P9s1dHsJ+oYy6IFMTa
         IqarbE+oHlSiyuYmSXRvQusER8tg90zQde4DUxFOyvmS1DZUwMy6WUbvgLYWvcnqxAdX
         XCt9OZEZpZfnuY/6CwGauqi1owKV0rUKfRHshU3GUzrnhqjGEaDm+IN2gZyEZ7gjmXKs
         xkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I++FkWNtGNM5ERq0D5mTw6CTdEV5m5aHl5HLEfa8ZOc=;
        b=VzRKODMvMhH1gLQbNS42GBDUXeCYYqDaYQhrrxQyGAc5ex6oGPsUjiPbYQus++bvk2
         sQzfdqPoAtVTXYuJICnieMJR28PcJIknvoqVUW45qS4iTJ4M8/yxrsqhwYj+CgDrN/B0
         gu5tG+KU+jVpwrUFLVht4uQFfBSz8MbTZqelQSnBECdNOMbvNMEooEF3vDiyiiw76vzi
         3DOmuDBi9TVyZPgvdLfdCDfZIU+ypzRB8VyQqPWb4YsHkInyyNCcnt/m7pKZaKIOwZki
         rrUOwe4YfjQCTmOHbHU0Lhu8xlxtQoW3Xk0uYhlDzfsU4Yw1g/xzCtqeEB1Dhc6/R9Ql
         e+Xw==
X-Gm-Message-State: AOAM533w8zydnbaqLv1Hqz/03okKVrKjfb+/bTuHPB751MtuXiFNkuvW
        Mj+XAFbmbFNssDf0TAMalZKSuiWPHh7V3Q==
X-Google-Smtp-Source: ABdhPJyATNiPluo5R5PUysbrYIRaHJykpiviVnrKfhSvmOSRmSNU7EAxa+4Z8FMhvOvEV70ugUN/yQ==
X-Received: by 2002:a17:90a:1a19:: with SMTP id 25mr4706484pjk.34.1632223062404;
        Tue, 21 Sep 2021 04:17:42 -0700 (PDT)
Received: from ubuntu.mate (subs28-116-206-12-33.three.co.id. [116.206.12.33])
        by smtp.gmail.com with ESMTPSA id s15sm16291481pfu.67.2021.09.21.04.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 04:17:42 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2] difftool: fix word spacing in the usage strings
Date:   Tue, 21 Sep 2021 18:17:13 +0700
Message-Id: <20210921111712.894245-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove spaces in `non - zero` and add a space between the diff
format/mode and option parentheses in difftool's usage strings.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---

Changes since v1 [1]:
  - Touch up commit message to imperative tone (suggested by David
    Aguilar)

Range-diff against v1 [1]:
1:  d27159f7c9 ! 1:  18d5034c80 difftool: word spacing fix
    @@ Metadata
     Author: Bagas Sanjaya <bagasdotme@gmail.com>
     
      ## Commit message ##
    -    difftool: word spacing fix
    +    difftool: fix word spacing in the usage strings
     
    -    Two grammar fixes related to word spacing:
    -
    -      - delete space in `non - zero`
    -      - add space between diff formats/mode and option parentheses
    +    Remove spaces in `non - zero` and add a space between the diff
    +    format/mode and option parentheses in difftool's usage strings.
     
         Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
     
[1]:
https://lore.kernel.org/git/c536bd3a-d1ae-a617-c284-dabc9f8c1c0f@gmail.com/T/#t

 builtin/difftool.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 6a9242a803..ad9187761e 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -410,9 +410,9 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 		const char *src_path, *dst_path;
 
 		if (starts_with(info.buf, "::"))
-			die(N_("combined diff formats('-c' and '--cc') are "
+			die(N_("combined diff formats ('-c' and '--cc') are "
 			       "not supported in\n"
-			       "directory diff mode('-d' and '--dir-diff')."));
+			       "directory diff mode ('-d' and '--dir-diff')."));
 
 		if (parse_index_info(info.buf, &lmode, &rmode, &loid, &roid,
 				     &status))
@@ -713,7 +713,7 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 			    "`--tool`")),
 		OPT_BOOL(0, "trust-exit-code", &trust_exit_code,
 			 N_("make 'git-difftool' exit when an invoked diff "
-			    "tool returns a non - zero exit code")),
+			    "tool returns a non-zero exit code")),
 		OPT_STRING('x', "extcmd", &extcmd, N_("command"),
 			   N_("specify a custom command for viewing diffs")),
 		OPT_ARGUMENT("no-index", &no_index, N_("passed to `diff`")),

base-commit: 4c719308ce59dc70e606f910f40801f2c6051b24
-- 
2.25.1

