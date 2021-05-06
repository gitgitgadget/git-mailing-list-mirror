Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0295C43460
	for <git@archiver.kernel.org>; Thu,  6 May 2021 19:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE7FE6103E
	for <git@archiver.kernel.org>; Thu,  6 May 2021 19:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbhEFTeX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 15:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbhEFTeW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 15:34:22 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F23C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 12:33:23 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id x8so6153523qkl.2
        for <git@vger.kernel.org>; Thu, 06 May 2021 12:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r/5AhRBWeMULZLERIihILXYQ8dfustMFtEiGUuG59GQ=;
        b=eeUmpQpXR/NjOLkVZzQ+rB8E/T/LrI+zeBZaq/cNqGcURgOsvRRL/gMhWLdgTv+Spb
         vxKf25hPzGuJ0NkQ9NBGsW20eDP6qfqLn1ThFwqRLmL8hgWuQOTaJg5y4Wq5CdzQWOQi
         x+bsQIscWGYImENlu8pzmlfPcM1dbzdIXYt8KhwxTnXlhnl4/ql3S5pW1bF6m3Bd0GA5
         hWIiqohcb2Tf1VpR5uCLeuwKkoN6Ta3xI4P1thkphdfaqM0XoPkbhXbHtvM2SFG5q3ue
         vr5fJs9//gwUGl83STjA4zDVZJIgjePDAvvD5q0sDJbcMbGCNlHz4H5DkOmIKLp2DhfP
         +BdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r/5AhRBWeMULZLERIihILXYQ8dfustMFtEiGUuG59GQ=;
        b=rOHPtl7Zg+Jbw9LO13+n+oWosenIPge4ukyr2UBjV+tSMWesMTy0yLTKO9VdUc+ARu
         Mia+Ky1HoM8bXJ1viI518HYg4htJeH+315Sb/ID56fCXIt+Ps0BrZWNkMmz9lhJyK3Ez
         3mvm35E/c6zH7a1reD5kP0nS7ECzOwJsV8FZAgyh9nOg9KMXpUHkSMWVAzTbKU/Wrj0Z
         P2/QsY6yfdINmvlZElHC+tSmnWI3Iq7WY1mcjtdx8LJI4GGaHNw/cRlHuRNWSvmBM/Td
         4F5xUBBHHI+0qDWUWjV8zvN7nVD0K6j23x8F/w+2b49WDepUisnf0IGF8I3V3P0aZ3Pb
         pOdQ==
X-Gm-Message-State: AOAM533LDPEDRS6fg8/1pvfQ3O6aN4duIGAxN6uekuvvAa8DtUTGCZMf
        MybYaVb6/G1b9hZNmdIOQMDzNYAj6K8JOg==
X-Google-Smtp-Source: ABdhPJxkcKzcr+YWmhEAVbGkSmPvbsKwibYnq9q8mcv92rCa8xLBG5v3Vf5Q2KQBrqEcaTCwQgKIlA==
X-Received: by 2002:a37:558:: with SMTP id 85mr2535721qkf.173.1620329602743;
        Thu, 06 May 2021 12:33:22 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id z30sm3209019qtm.11.2021.05.06.12.33.20
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 12:33:22 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Subject: [PATCH] clean: remove unnecessary variable
Date:   Thu,  6 May 2021 16:33:15 -0300
Message-Id: <4f88ac58e46782c7cf335e13fabd14c8b4438267.1620329445.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The variable `matches` used to hold the return of a `dir_path_match()`
call that was removed in 95c11ecc73 ("Fix error-prone fill_directory()
API; make it only return matches", 2020-04-01). Now `matches` will
always hold 0, which is the value it's initialized with; and the
condition `matches != MATCHED_EXACTLY` will always evaluate to true. So
let's remove this unnecessary variable.

Interestingly, it seems that `matches != MATCHED_EXACTLY` was already
unnecessary before 95c11ecc73. That's because `remove_directories` is
always set to 1 when we have pathspecs; So, in the condition
`!remove_directories && matches != MATCHED_EXACTLY`, we would either:

- have pathspecs (or have been given `-d`) and ignore `matches` because
  `remove_directories` is 1; or

- not have pathspecs (nor `-d`) and end up just checking that
  `0 != MATCHED_EXACTLY`, as `matches` would never get reassigned
  after its zero initialization (because there is no pathspec to match).

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/clean.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 995053b791..f6d7e8119c 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -1003,7 +1003,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
 	for (i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
-		int matches = 0;
 		struct stat st;
 		const char *rel;
 
@@ -1013,8 +1012,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		if (lstat(ent->name, &st))
 			die_errno("Cannot lstat '%s'", ent->name);
 
-		if (S_ISDIR(st.st_mode) && !remove_directories &&
-		    matches != MATCHED_EXACTLY)
+		if (S_ISDIR(st.st_mode) && !remove_directories)
 			continue;
 
 		rel = relative_path(ent->name, prefix, &buf);
-- 
2.30.1

