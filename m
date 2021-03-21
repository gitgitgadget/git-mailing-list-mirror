Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8DCC433E3
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 16:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1508361920
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 16:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhCUQ7P (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 12:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhCUQ6o (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 12:58:44 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAFDC061574
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 09:58:44 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id x13so14217830wrs.9
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 09:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+9wIkNaZUclrgqntftFA9bP3wLy769DmOL70Y+eUFk8=;
        b=HH6lYJHmRXbKU5TEX6VcSBw/OpzhlSDFhdp5aoGAJw4/c8Ply/2JjqrCWEll7IVbBs
         sz+QiCQ5COunBUBRhA1FF+29P0QinJvU62qn9c4npEPB9o2l14PSrj5I8V30Afjo/rK5
         JHFM3QgfJ5dxpMRX7TTTvWBuXECtd8n83BU7O9/aRHBc2OszgOQbPkyt/ouNVPKCDiCE
         3ydoGaba+CUNYimDsiDF/nUwjNRRMUMKEyzmnTg5mApt0uburU0gC/FY/SpFjqEx+eDt
         1WUE8tbZKmCC8osTLkJC2liFqhMZjm/TAOP/LC8xhW4Nw3ZNtCnQ2u6qrsTCIEVtl0BJ
         27UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+9wIkNaZUclrgqntftFA9bP3wLy769DmOL70Y+eUFk8=;
        b=lhLnh1DJXaYuWC9jGElb/5DiA6XchOPIyxn8vsH6Qoo9wv56/wCxry/jIJxOV+LkDg
         5PHtiZuy4GZxQOTL1Y0WEeQm7CPy5lqBgqp82fKWftlmJUTGJ9wHgglD779hXxC+ttmS
         TQAw0fqGOWN7Ez64u50FzBRPmrxMDYeIalfIc+ZSGNB4gliyUGKwCHeitROKBtRmw/BV
         hlDkqfGUPhqkqBHBVTR/Rblpd0hB+2ixCWwARaeFCO53cJZFZbhQFYXABJLhZTjdKm5D
         Czwa/OWvddg/xevQzUBlrWuNFrnH+SkkxenQJ9Q4dpOfX5BdZdLXoGgbnGdvgPVpb9DB
         Xl5A==
X-Gm-Message-State: AOAM533yMORVxnkprxsED1mpmqWnmoJkpH03U1Eyvx40YMNr9WI2FOmX
        nl9X/Ywo6DCjbEDX6JLifqferrYRR4o=
X-Google-Smtp-Source: ABdhPJx+T2AuXRstlfJhJBhKjdeWmGZkbLQuwIK0IVj8ayn1GQBoFkia8/KvZi3HFtIlQqIdggtcnQ==
X-Received: by 2002:a5d:5744:: with SMTP id q4mr14706596wrw.390.1616345922889;
        Sun, 21 Mar 2021 09:58:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g11sm16507188wrw.89.2021.03.21.09.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 09:58:42 -0700 (PDT)
Message-Id: <c2220434ab2ca5e3ef21285e26680f28dbbd4338.1616345918.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.899.v3.git.1616345918.gitgitgadget@gmail.com>
References: <pull.899.v2.git.1615747662.gitgitgadget@gmail.com>
        <pull.899.v3.git.1616345918.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 21 Mar 2021 16:58:35 +0000
Subject: [PATCH v3 7/9] parse-options: convert bitfield values to use binary
 shift
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

Because it's easier to read, but also likely to be easier to maintain.
I am making this change because I need to add a new flag in a later
commit.

Also add a trailing comma to the last enum entry to simplify addition of
new flags.

This change was originally suggested by Peff in:
https://public-inbox.org/git/YEZ%2FBWWbpfVwl6nO@coredump.intra.peff.net/

Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
 parse-options.h | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/parse-options.h b/parse-options.h
index ff6506a50470..f2ddef18f7b0 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -28,26 +28,26 @@ enum parse_opt_type {
 };
 
 enum parse_opt_flags {
-	PARSE_OPT_KEEP_DASHDASH = 1,
-	PARSE_OPT_STOP_AT_NON_OPTION = 2,
-	PARSE_OPT_KEEP_ARGV0 = 4,
-	PARSE_OPT_KEEP_UNKNOWN = 8,
-	PARSE_OPT_NO_INTERNAL_HELP = 16,
-	PARSE_OPT_ONE_SHOT = 32
+	PARSE_OPT_KEEP_DASHDASH = 1 << 0,
+	PARSE_OPT_STOP_AT_NON_OPTION = 1 << 1,
+	PARSE_OPT_KEEP_ARGV0 = 1 << 2,
+	PARSE_OPT_KEEP_UNKNOWN = 1 << 3,
+	PARSE_OPT_NO_INTERNAL_HELP = 1 << 4,
+	PARSE_OPT_ONE_SHOT = 1 << 5,
 };
 
 enum parse_opt_option_flags {
-	PARSE_OPT_OPTARG  = 1,
-	PARSE_OPT_NOARG   = 2,
-	PARSE_OPT_NONEG   = 4,
-	PARSE_OPT_HIDDEN  = 8,
-	PARSE_OPT_LASTARG_DEFAULT = 16,
-	PARSE_OPT_NODASH = 32,
-	PARSE_OPT_LITERAL_ARGHELP = 64,
-	PARSE_OPT_SHELL_EVAL = 256,
-	PARSE_OPT_NOCOMPLETE = 512,
-	PARSE_OPT_COMP_ARG = 1024,
-	PARSE_OPT_CMDMODE = 2048
+	PARSE_OPT_OPTARG  = 1 << 0,
+	PARSE_OPT_NOARG   = 1 << 1,
+	PARSE_OPT_NONEG   = 1 << 2,
+	PARSE_OPT_HIDDEN  = 1 << 3,
+	PARSE_OPT_LASTARG_DEFAULT = 1 << 4,
+	PARSE_OPT_NODASH = 1 << 5,
+	PARSE_OPT_LITERAL_ARGHELP = 1 << 6,
+	PARSE_OPT_SHELL_EVAL = 1 << 8,
+	PARSE_OPT_NOCOMPLETE = 1 << 9,
+	PARSE_OPT_COMP_ARG = 1 << 10,
+	PARSE_OPT_CMDMODE = 1 << 11,
 };
 
 enum parse_opt_result {
-- 
gitgitgadget

