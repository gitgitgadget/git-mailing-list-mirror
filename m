Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E207C4332B
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 21:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F039206C3
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 21:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvEyN0uu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgCWVNO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 17:13:14 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41022 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgCWVNN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 17:13:13 -0400
Received: by mail-ed1-f68.google.com with SMTP id v1so3905990edq.8
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 14:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=AfBScQfR4jkvrJKbXgUqN4Adfc+/De5HYUthqqdBN50=;
        b=TvEyN0uupYumY3C3L2uCXei5yv6H5PHOyzLGs1J16wJ3fVdt89A89JsW/o2QXNwtuH
         2AfZrFAuxnyVccFUXnfwlE+9O3ARF6g6W1GaPq+Xvt7pknAlFW7jVSmKo8QSnhdOMVg3
         RkbY6bf3QDeR+AI1KTmsPHqQjJiDypZAgwF854u45arBZB4mNfdJTiVkcDoKNRGlJ+/I
         Ul/MmCLZAfDWG5AoIMp0n5SL5lK48cffCzTNPkNoSjVRK0TiF3yV4K7hYD2DfJpTHpCv
         No+PyiebvH/fYeNut/PMvb5NUplr56zb7EK79OlDZviJrpkH3dDIDpW7qfNYrLdXe3hY
         o3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AfBScQfR4jkvrJKbXgUqN4Adfc+/De5HYUthqqdBN50=;
        b=oTVP7U+ts+dtnhHTHMBhi0jsQPIfpNOKaNSxSCbszSC4Amj0pJF0TSxOdxK/96NUI8
         PxuS2p4uT85OzBfs7Vt8z93W018m0Vs0S5JmYYraaB8XOiOwOh3F+1mCw3GKC3oNWsWD
         ooDTACJJ5vJaPgywMncft6iBFsTlphzfcf8os75LB211snyVY+2oVfBFXfbArGf2GUJm
         AocaQZjEcjowFy8945UsZqzGitajqgmvGbve+6phOfiiuxUD382qIddfzpvxU0LIZKPW
         qVvazStW/L783BRA1zbwJa2w3/0kxuvLLnRkNaJCWuTspjGitGhaewbBjRYYoFH1PkcH
         thOg==
X-Gm-Message-State: ANhLgQ0BLEgGKqa7cPUVm2MEr1nQ9Kjz6eZjyD09DAhMX3h1pyQiNkw+
        aEEHY5EClcDPG/PzV1y7gbb+XKho
X-Google-Smtp-Source: ADFU+vsDSy2mRESuXsIMTRGz9Kj+wW/woAwQMZOuLRYLCIkUmgz8r3mSOzq3owL1iSbjeQAcP+CqQQ==
X-Received: by 2002:a17:906:7b8d:: with SMTP id s13mr20936284ejo.77.1584997991641;
        Mon, 23 Mar 2020 14:13:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 19sm1133135edv.60.2020.03.23.14.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 14:13:11 -0700 (PDT)
Message-Id: <pull.587.git.1584997990694.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?Andr=C3=A1s?= Kucsma via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 23 Mar 2020 21:13:10 +0000
Subject: [PATCH] Fix dir sep handling of GIT_ASKPASS on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Andr=C3=A1s?= Kucsma <r0maikx02b@gmail.com>,
        Andras Kucsma <r0maikx02b@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andras Kucsma <r0maikx02b@gmail.com>

On Windows with git installed through cygwin, GIT_ASKPASS failed to run
for relative and absolute paths containing only backslashes as directory
separators.

The reason was that git assumed that if there are no forward slashes in
the executable path, it has to search for the executable on the PATH.

The fix is to look for OS specific directory separators, not just
forward slashes.

Signed-off-by: Andras Kucsma <r0maikx02b@gmail.com>
---
    Fix dir sep handling of GIT_ASKPASS on Windows
    
    On Windows with git installed through cygwin, GIT_ASKPASS failed to run
    for relative and absolute paths containing only backslashes as directory
    separators.
    
    The reason was that git assumed that if there are no forward slashes in
    the executable path, it has to search for the executable on the PATH.
    
    The fix is to look for OS specific directory separators, not just
    forward slashes.
    
    Signed-off-by: Andras Kucsma r0maikx02b@gmail.com [r0maikx02b@gmail.com]
    
    CC: Torsten Bögershausen tboegi@web.de [tboegi@web.de]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-587%2Fr0mai%2Ffix-prepare_cmd-windows-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-587/r0mai/fix-prepare_cmd-windows-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/587

 run-command.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/run-command.c b/run-command.c
index f5e1149f9b3..9fcc12ebf9c 100644
--- a/run-command.c
+++ b/run-command.c
@@ -421,12 +421,12 @@ static int prepare_cmd(struct argv_array *out, const struct child_process *cmd)
 	}
 
 	/*
-	 * If there are no '/' characters in the command then perform a path
-	 * lookup and use the resolved path as the command to exec.  If there
-	 * are '/' characters, we have exec attempt to invoke the command
-	 * directly.
+	 * If there are no dir separator characters in the command then perform
+	 * a path lookup and use the resolved path as the command to exec. If
+	 * there are dir separator characters, we have exec attempt to invoke
+	 * the command directly.
 	 */
-	if (!strchr(out->argv[1], '/')) {
+	if (find_last_dir_sep(out->argv[1]) == NULL) {
 		char *program = locate_in_PATH(out->argv[1]);
 		if (program) {
 			free((char *)out->argv[1]);

base-commit: 274b9cc25322d9ee79aa8e6d4e86f0ffe5ced925
-- 
gitgitgadget
