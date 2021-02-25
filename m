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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66748C433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 10:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FF6B64EAF
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 10:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbhBYKTo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 05:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbhBYKQo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 05:16:44 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93822C06178A
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 02:16:07 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id v200so3312870pfc.0
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 02:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SqQrGuVVK0QVgjTLKr/KFAt9mbI9viDTuKuR5+CufaU=;
        b=ijDdVLMZg8AWccPTB7yKBJp1MsyEQKevK6CGrYwsS4hEyoADEwYvXfAMrDq/qe/Ryh
         iRrQtPIsNSQ4KU9U5+812qNycmTYI/+dUs1c/tenPipS0kyTYItosYFqi1Ci5xU85CWX
         eUDXnVmjEdN2TxJ9IL377byO55MMJCWQFVjIflzGBj9Qj+qqU8tABTDcjRcQN/NStHUE
         7s1gyx7n7Aie/DrqZL/hLHE1zcf8rXHNP7cFB0PD7tVAOxjWog8GNfg3MqPzaIR0lLju
         aS3bjzrbHytJif14tlk4ZUEn6yvNGro5XiINjxESVi/hie4XhLfIr3LK0rNqF8ZFbPJ+
         W7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SqQrGuVVK0QVgjTLKr/KFAt9mbI9viDTuKuR5+CufaU=;
        b=fxtAEQ4yQj0HmtQGakALpZcg3xH4TnHBSJsZRCgBjTQrdqmsKOxW+4IFIcb2yB6WjO
         ZiBaGNSdH15IJZSdTnv0JEEbdf7yRdjDW9nWfOpJl1YplReR212ug/YFmo9VqRysEaSH
         vZxp4WtEoWrXq8rkZVNqVjcMnQILYD+cVFW9MRXOSl3HhHT4IvtOEOcl7dO+eavbyW3E
         XIgiLU2QT7TkCfT+TfCCNehepTr7oweS1i+ZFJ5/utUDCuO3DisY6ozURI8twI2q06Hn
         xMtbtG+SvsKbNOLffgTgFeG0jvF1S2pGlGK1Xt4zJ/Wbj44twOHaACxD9rtHOKl/hfDJ
         hwoA==
X-Gm-Message-State: AOAM531UHdU8dBAcUYJJABjc/J06I2xgytwlp0g3maWqKS/1OXmXQMK/
        HDew08hoHBBTNKGr9b+g4onCwGPbVxobPg==
X-Google-Smtp-Source: ABdhPJw+F85/F5r2lBgl5E4V00PVgEnl4YvIWJCj25pUMdfLO1rp0He1AgahDMRnM5ZiP5tmKtckmA==
X-Received: by 2002:a63:234f:: with SMTP id u15mr2372021pgm.360.1614248166944;
        Thu, 25 Feb 2021 02:16:06 -0800 (PST)
Received: from localhost.localdomain ([223.233.90.42])
        by smtp.googlemail.com with ESMTPSA id 67sm5941188pfb.43.2021.02.25.02.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 02:16:06 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 3/6] commit: add a reword suboption to --fixup
Date:   Thu, 25 Feb 2021 15:38:58 +0530
Message-Id: <20210225100855.25530-4-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210217072904.16257-1-charvi077@gmail.com>
References: <20210217072904.16257-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git commit --fixup=reword:<commit>` creates an empty "amend!" commit
that will reword <commit> without changing its contents when it is
rebased with --autosquash.

Apart from ignoring staged changes it works similarly to
`--fixup=amend:<commit>`.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 builtin/commit.c | 46 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 56ae15a762..82e77aa61d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1177,6 +1177,27 @@ static void finalize_deferred_config(struct wt_status *s)
 		s->ahead_behind_flags = AHEAD_BEHIND_FULL;
 }
 
+static void check_fixup_reword_options(int argc) {
+	if (whence != FROM_COMMIT) {
+		if (whence == FROM_MERGE)
+			die(_("You are in the middle of a merge -- cannot reword."));
+		else if (is_from_cherry_pick(whence))
+			die(_("You are in the middle of a cherry-pick -- cannot reword."));
+	}
+	if (argc)
+		die(_("cannot combine reword option of --fixup with paths"));
+	if (patch_interactive)
+		die(_("cannot combine reword option of --fixup with --patch"));
+	if (interactive)
+		die(_("cannot combine reword option of --fixup with --interactive"));
+	if (all)
+		die(_("cannot combine reword option of --fixup with --all"));
+	if (also)
+		die(_("cannot combine reword option of --fixup with --include"));
+	if (only)
+		die(_("cannot combine reword option of --fixup with --only"));
+}
+
 /* returns the length of intial segment of alpha characters only */
 static size_t get_alpha_len(char *fixup_message) {
 	const char alphas[] = "abcdefghijklmnopqrstuvwxyz";
@@ -1261,18 +1282,25 @@ static int parse_and_validate_options(int argc, const char *argv[],
 
 	if (fixup_message) {
 		/*
-		 * As `amend` suboption contains only alpha
-		 * character. So check if first non alpha
-		 * character in fixup_message is ':'.
+		 * As `amend`/`reword` suboptions contains only alpha
+		 * characters. So check if first non alpha character
+		 * in fixup_message is ':'.
 		 */
 		size_t len = get_alpha_len(fixup_message);
 		if (len && fixup_message[len] == ':') {
 			fixup_message[len] = '\0';
 			fixup_commit = fixup_message + ++len;
-			if (starts_with("amend", fixup_message))
+			if (starts_with("amend", fixup_message) ||
+				starts_with("reword", fixup_message)) {
 				fixup_prefix = "amend";
-			else
+				if (*fixup_message == 'r') {
+					check_fixup_reword_options(argc);
+					allow_empty = 1;
+					only = 1;
+				}
+			} else {
 				die(_("unknown option: --fixup=%s:%s"), fixup_message, fixup_commit);
+			}
 		} else {
 			fixup_commit = fixup_message;
 			fixup_prefix = "fixup";
@@ -1558,11 +1586,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_STRING('c', "reedit-message", &edit_message, N_("commit"), N_("reuse and edit message from specified commit")),
 		OPT_STRING('C', "reuse-message", &use_message, N_("commit"), N_("reuse message from specified commit")),
 		/*
-		 * TRANSLATORS: please do not translate [amend:]
-		 * Here "amend" is an option to the --fixup command
-		 * line flag, that creates amend! commit.
+		 * TRANSLATORS: please do not translate [(amend|reword):]
+		 * Here "amend" and "reword" are options to the --fixup
+		 * command line flag, that creates amend! commit.
 		 */
-		OPT_STRING(0, "fixup", &fixup_message, N_("[amend:]commit"), N_("use autosquash formatted message to fixup or amend specified commit")),
+		OPT_STRING(0, "fixup", &fixup_message, N_("[(amend|reword):]commit"), N_("use autosquash formatted message to fixup or amend/reword specified commit")),
 		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
 		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
 		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
-- 
2.29.0.rc1

