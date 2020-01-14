Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7B2C33CB3
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 18:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628C624670
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 18:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFpW6oM/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgANSoF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 13:44:05 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42619 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728765AbgANSn7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 13:43:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id q6so13198923wro.9
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 10:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Wts3H8nhhEz2jG17zS1qC1FJL1l+mQIfLvzo4D7CRNg=;
        b=NFpW6oM/h1wN24Ch8sDQQAVZ7EFWjp9RsdSlIAOAT0/Uex6i9PhRqHU5ibnHHNVgJv
         XtUn9Nt9oYSCMegn2bc+RK8MfEZHHcYy0C32Y+MAzEUCcQyMgiFT7SG301FvNG3C75NJ
         F7tb2Ft/YRnn8sJw4R9w1Hig0i9BNfXKl/IXRmB+d4cqg3/B6dgMwoWMZB86a0uzcKMK
         yl/wvx0QzaKHI5Kg5yYN+z3srxwz2zqf4/ByEUSm29PyqxPUYQ/v654Yfuf3/ODUovJE
         bqYNCGnrJnaYah6diz8Bk4lzo8XH+AHpa6dioKDs0L4VszQCONQRTanuqtL0tS9Wkj4K
         XOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Wts3H8nhhEz2jG17zS1qC1FJL1l+mQIfLvzo4D7CRNg=;
        b=lgTMmHxLcFLr1+01T9zjDGfaWMGIDG6i1c/NUX8SmBL/GR1E3+ahyG8SbDbfdZAmeW
         2PWNQORz1fecrcQm9/16WqnDFR7P5LI8+DxYxVCRDHJusPlEC694AGHcFxq2rzZYPRx0
         Z5Ur7TTB5iAkbeqTnTjJRC0OWSbQVlr8g25My6BTCeoOJku1/pLXcF7Cipd6rfVcmD0R
         N0UXdHYYTTTjUREQVtdtXEpeuHQv1r4heqI8CsBZNr0KeII21izMkDZ1t2X/yijUw2h6
         XywJg5Kj7e/PrauwNE5N6H/P39fLI0Qke8MNgIzE8H1lxYD2ky6rQ8jFV3Rz0RxfneSS
         hlIg==
X-Gm-Message-State: APjAAAWvvX4/ZAIlA53gOEZrd7RjLKKw6CxSbMUrY9wy51wyi7qmV9ll
        E7ct8PKZryBBRsmZMRgjlF7k/aOu
X-Google-Smtp-Source: APXvYqwDH0OhVgKCLUU/AU1Gxb2EYqGDs83c1dtWPdBwXuxRbnCLYawX7+hKLMv//ItLzUTt8ib8Dg==
X-Received: by 2002:a5d:5044:: with SMTP id h4mr26067672wrt.4.1579027437599;
        Tue, 14 Jan 2020 10:43:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d8sm21240953wre.13.2020.01.14.10.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 10:43:57 -0800 (PST)
Message-Id: <062c6245477b23b9c13a6324e677e7a2be62dd65.1579027433.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.v4.git.1579027433.gitgitgadget@gmail.com>
References: <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
        <pull.175.v4.git.1579027433.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Jan 2020 18:43:46 +0000
Subject: [PATCH v4 03/10] built-in add -p: handle diff.algorithm
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The Perl version of `git add -p` reads the config setting
`diff.algorithm` and if set, uses it to generate the diff using the
specified algorithm.

This patch ports that functionality to the C version.

Note: just like `git-add--interactive.perl`, we do _not_ respect this
config setting in `git add -i`'s `diff` command, but _only_ in the
`patch` command.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 5 +++++
 add-interactive.h | 2 +-
 add-patch.c       | 3 +++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/add-interactive.c b/add-interactive.c
index 1786ea29c4..9e4bcb382c 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -56,11 +56,16 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
 	FREE_AND_NULL(s->interactive_diff_filter);
 	git_config_get_string("interactive.difffilter",
 			      &s->interactive_diff_filter);
+
+	FREE_AND_NULL(s->interactive_diff_algorithm);
+	git_config_get_string("diff.algorithm",
+			      &s->interactive_diff_algorithm);
 }
 
 void clear_add_i_state(struct add_i_state *s)
 {
 	FREE_AND_NULL(s->interactive_diff_filter);
+	FREE_AND_NULL(s->interactive_diff_algorithm);
 	memset(s, 0, sizeof(*s));
 	s->use_color = -1;
 }
diff --git a/add-interactive.h b/add-interactive.h
index 46c73867ad..923efaf527 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -16,7 +16,7 @@ struct add_i_state {
 	char file_old_color[COLOR_MAXLEN];
 	char file_new_color[COLOR_MAXLEN];
 
-	char *interactive_diff_filter;
+	char *interactive_diff_filter, *interactive_diff_algorithm;
 };
 
 void init_add_i_state(struct add_i_state *s, struct repository *r);
diff --git a/add-patch.c b/add-patch.c
index 78bde41df0..8f2ee8688b 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -360,6 +360,7 @@ static int is_octal(const char *p, size_t len)
 static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 {
 	struct argv_array args = ARGV_ARRAY_INIT;
+	const char *diff_algorithm = s->s.interactive_diff_algorithm;
 	struct strbuf *plain = &s->plain, *colored = NULL;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *p, *pend, *colored_p = NULL, *colored_pend = NULL, marker = '\0';
@@ -369,6 +370,8 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 	int res;
 
 	argv_array_pushv(&args, s->mode->diff_cmd);
+	if (diff_algorithm)
+		argv_array_pushf(&args, "--diff-algorithm=%s", diff_algorithm);
 	if (s->revision) {
 		struct object_id oid;
 		argv_array_push(&args,
-- 
gitgitgadget

