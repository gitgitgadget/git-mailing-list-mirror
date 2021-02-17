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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCD8C433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 07:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9691D64D9F
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 07:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbhBQHkJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 02:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbhBQHjU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 02:39:20 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8EEC0613D6
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 23:38:36 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id x136so7899395pfc.2
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 23:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d0Kbuo9JkTRY9s0JJ6koBc532qGV35H/YsOW2Fiec+8=;
        b=r3TmXxsUymqXzzqqrtOpBllPkQDCq+9hsYXsD5RNLmlmVUoUXXuqFJ73+s7mf+W6Ju
         gh+Y1yRHJlFqqxy80IrNv2umGuW028rIO6+6GOK6GJ889bgnsd/lDa9TS6G+877uNdrT
         j0YbBymOFaxcIa5iXM8YoPYPy2R+SbQqesLlSHUgxPdsURMJ5W5imNV0vDJwhc+3AufK
         ERfDXwHCv+tcRernBFD+69QF7czm1GRGN7XcqHXcf3B2R2uvEv7LGdwfbObvrzzoMMb4
         GySRbghg7bcynKxAw46ZAsu/a5lQ6c1SGrHyHueDVwyAVhtNLnLANGzk886nCitmbsBh
         VCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d0Kbuo9JkTRY9s0JJ6koBc532qGV35H/YsOW2Fiec+8=;
        b=YYeTVB8z7utm/EbOax0G4Em72cHsYW8E11gHwGlC0+fhvosaW99v9lsc8iKxO0A41h
         c3pPM9bpKqLSWnui/D0VHOztCtzypccBfSwk9mD0UrYysFjPye78knUxPIpGi5CpYfxT
         /2f9T/aga/CanoWAq/QBq1zINQzSOxYBYEfQwHRgLKCGt7ooPd5Dm1w9r+HBjIazkg6P
         qfjX0IiUZcxE5eSeFarPNvkrEw9GBV5DwpHhvZBEWGPqvVhZ8U/n7h5+FOXSjyVoeq+N
         XYjaDfXXtx03YCqQI4EM4YLb+gnqecZTiPCRuaSHCUGnd+db2dj4iyECME0jHnRUsxpR
         cjlQ==
X-Gm-Message-State: AOAM532m3poqXyAxDmA7L9TrPZaeJlBRdKsvKuGE5KHgUOCA6yI5Ag26
        IRhceMCNZy5D2mAA3OMi9wyDz9+MBdoRog==
X-Google-Smtp-Source: ABdhPJyhp8hivUkcMgX8NyFIjFlnNZHcdQESk+LXZIU6rKZpokiel03SZM8Cdx2tY3pGqVUAQTmTOQ==
X-Received: by 2002:a63:906:: with SMTP id 6mr6315592pgj.387.1613547515966;
        Tue, 16 Feb 2021 23:38:35 -0800 (PST)
Received: from localhost.localdomain ([106.201.18.198])
        by smtp.googlemail.com with ESMTPSA id b3sm1352615pgd.48.2021.02.16.23.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 23:38:35 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 3/6] commit: add a reword suboption to --fixup
Date:   Wed, 17 Feb 2021 13:07:22 +0530
Message-Id: <20210217073725.16656-3-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210217073725.16656-1-charvi077@gmail.com>
References: <20210217072904.16257-1-charvi077@gmail.com>
 <20210217073725.16656-1-charvi077@gmail.com>
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

Example usage:
$ git commit --fixup=reword:HEAD~3
$ git commit --fixup=reword:HEAD~3 -m "new commit message"

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 builtin/commit.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index f2c5ad2e62..b5293f46d2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1171,6 +1171,21 @@ static void finalize_deferred_config(struct wt_status *s)
 		s->ahead_behind_flags = AHEAD_BEHIND_FULL;
 }
 
+static void check_fixup_reword_options(void) {
+	if (whence != FROM_COMMIT) {
+		if (whence == FROM_MERGE)
+			die(_("You are in the middle of a merge -- cannot reword."));
+		else if (is_from_cherry_pick(whence))
+			die(_("You are in the middle of a cherry-pick -- cannot reword."));
+	}
+	if (all)
+		die(_("cannot combine reword option of --fixup with --all"));
+	if (also)
+		die(_("cannot combine reword option of --fixup with --include"));
+	if (only)
+		die(_("cannot combine reword option of --fixup with --only"));
+}
+
 static int parse_and_validate_options(int argc, const char *argv[],
 				      const struct option *options,
 				      const char * const usage[],
@@ -1256,11 +1271,17 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		if (fixup_commit && *fixup_commit == ':' &&
 		    fixup_commit != fixup_message) {
 			*fixup_commit = '\0';
-			if (starts_with("amend", fixup_message)) {
+			if (starts_with("amend", fixup_message) ||
+			    starts_with("reword", fixup_message)) {
 				fixup_prefix = "amend";
 				fixup_commit++;
+				if (*fixup_message == 'r') {
+					check_fixup_reword_options();
+					allow_empty = 1;
+					only = 1;
+				}
 			} else {
-				die(_("only amend option can be used with --fixup"));
+				die(_("only `amend` or `reword` options can be used with --fixup"));
 			}
 		} else {
 			fixup_commit = fixup_message;
@@ -1547,11 +1568,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
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

