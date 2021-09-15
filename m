Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA497C433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 20:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A05AE61101
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 20:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhIOUhs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 16:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbhIOUho (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 16:37:44 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E92C061768
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 13:36:23 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id e26so3181215wmk.2
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 13:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xH8KHPZqTUyNqvPLgX0jLXAWPh9eatde8fJJ9xbOwYY=;
        b=UNOuTP8j7FIF/xvbaKr3m6UH1HSqqVcRxOzBQjhI77gSHxFkicr4NvHjBYW+afhN68
         UlKzAp8V+eWfqz1h8VXuUxqZOq/hBHoKhSfiiawz7nQQwRf5FxzgM+Ilf3st0aKTmfwz
         B6cu+SHpXOr5rOflMETy8LAbRBYLowo2Y67zmdLgLSSvL2VVTZY9Cp4EJSJL3wKsSsER
         c03V+9QT4ycZvFOl67ReMXrIQSCFtXoUFlPzUT8Ol+EYUSBiuWRRfAqrS1hjsyGo53Cn
         9mSt6D2rv8FIMIfxVxU3tQBumJWP78gElKOOvPBxuFMu1fA9AlImmxW/t8VQF1YqW3qA
         nnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xH8KHPZqTUyNqvPLgX0jLXAWPh9eatde8fJJ9xbOwYY=;
        b=Yz8PM9gxon1/Pi/9W0J2U2UIpEa/9Ujr2Osgw/Fa6h6PhfxeCDO5ePTX0xDdLoJLzO
         Nz1uRMwW29JKWv0kD58L1hK8MczokbM2ajRh7hx6md8TeV72iUDglJAhBL1LDV/XEhDo
         5ytMrdgo5SYppQtq/CGKJVxQRjmS3eIx9XxJbdQ6b9SBO1rUPdNmQ0euBsT4wx+CW31p
         LMq10kXSXYltwnKFgIAfJEw3PzFTcW2s0CFoAf3Y967iQbdmxRxJn79VVOYVjDvhstcI
         CS89zCNvPOr3/XmgCa7hTFsOefH+cUk7RBrng55OkFhaCclkfCRXija6uv8srS8Vgjco
         25Pg==
X-Gm-Message-State: AOAM532+wwVq1oBkvjXPZySrIyCYeRfGAhs0Vrs5XUcfPoMMoKzMQppS
        IKnpAw5z0L2jjVuz/YSgQmegbOs96NU=
X-Google-Smtp-Source: ABdhPJxZlpwC21yNhjYzo0oix8EqYhFZM8GgIvdjFluX2E+YSp2Bnnlgbg4WbyCnjDtiSaL8AnmDsA==
X-Received: by 2002:a1c:7e85:: with SMTP id z127mr1581341wmc.141.1631738181910;
        Wed, 15 Sep 2021 13:36:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l19sm816256wrc.16.2021.09.15.13.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 13:36:21 -0700 (PDT)
Message-Id: <5eadf71929559968cafa18d03c3a623b1adff926.1631738177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Sep 2021 20:36:15 +0000
Subject: [PATCH 5/7] simple-ipc/ipc-win32: add Windows ACL to named pipe
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Set an ACL on the named pipe to allow the well-known group EVERYONE
to read and write to the IPC server's named pipe.  In the event that
the daemon was started with elevation, allow non-elevated clients
to communicate with the daemon.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/simple-ipc/ipc-win32.c | 140 +++++++++++++++++++++++++++++++---
 1 file changed, 129 insertions(+), 11 deletions(-)

diff --git a/compat/simple-ipc/ipc-win32.c b/compat/simple-ipc/ipc-win32.c
index 6c8a308de13..374ae2f81c7 100644
--- a/compat/simple-ipc/ipc-win32.c
+++ b/compat/simple-ipc/ipc-win32.c
@@ -3,6 +3,8 @@
 #include "strbuf.h"
 #include "pkt-line.h"
 #include "thread-utils.h"
+#include "accctrl.h"
+#include "aclapi.h"
 
 #ifndef SUPPORTS_SIMPLE_IPC
 /*
@@ -591,11 +593,132 @@ finished:
 	return NULL;
 }
 
+/*
+ * We need to build a Windows "SECURITY_ATTRIBUTES" object and use it
+ * to apply an ACL when we create the initial instance of the Named
+ * Pipe.  The construction is somewhat involved and consists of
+ * several sequential steps and intermediate objects.
+ *
+ * We use this structure to hold these intermediate pointers so that
+ * we can free them as a group.  (It is unclear from the docs whether
+ * some of these intermediate pointers can be freed before we are
+ * finished using the "lpSA" member.)
+ */
+struct my_sa_data
+{
+	PSID pEveryoneSID;
+	PACL pACL;
+	PSECURITY_DESCRIPTOR pSD;
+	LPSECURITY_ATTRIBUTES lpSA;
+};
+
+static void init_sa(struct my_sa_data *d)
+{
+	memset(d, 0, sizeof(*d));
+}
+
+static void release_sa(struct my_sa_data *d)
+{
+	if (d->pEveryoneSID)
+		FreeSid(d->pEveryoneSID);
+	if (d->pACL)
+		LocalFree(d->pACL);
+	if (d->pSD)
+		LocalFree(d->pSD);
+	if (d->lpSA)
+		LocalFree(d->lpSA);
+
+	memset(d, 0, sizeof(*d));
+}
+
+/*
+ * Create SECURITY_ATTRIBUTES to apply to the initial named pipe.  The
+ * creator of the first server instance gets to set the ACLs on it.
+ *
+ * We allow the well-known group `EVERYONE` to have read+write access
+ * to the named pipe so that clients can send queries to the daemon
+ * and receive the response.
+ *
+ * Normally, this is not necessary since the daemon is usually
+ * automatically started by a foreground command like `git status`,
+ * but in those cases where an elevated Git command started the daemon
+ * (such that the daemon itself runs with elevation), we need to add
+ * the ACL so that non-elevated commands can write to it.
+ *
+ * The following document was helpful:
+ * https://docs.microsoft.com/en-us/windows/win32/secauthz/creating-a-security-descriptor-for-a-new-object-in-c--
+ *
+ * Returns d->lpSA set to a SA or NULL.
+ */
+static LPSECURITY_ATTRIBUTES get_sa(struct my_sa_data *d)
+{
+	SID_IDENTIFIER_AUTHORITY sid_auth_world = SECURITY_WORLD_SID_AUTHORITY;
+#define NR_EA (1)
+	EXPLICIT_ACCESS ea[NR_EA];
+	DWORD dwResult;
+
+	if (!AllocateAndInitializeSid(&sid_auth_world, 1,
+				      SECURITY_WORLD_RID, 0,0,0,0,0,0,0,
+				      &d->pEveryoneSID)) {
+		DWORD gle = GetLastError();
+		trace2_data_intmax("ipc-debug", NULL, "alloc-world-sid/gle",
+				   (intmax_t)gle);
+		goto fail;
+	}
+
+	memset(ea, 0, NR_EA * sizeof(EXPLICIT_ACCESS));
+
+	ea[0].grfAccessPermissions = GENERIC_READ | GENERIC_WRITE;
+	ea[0].grfAccessMode = SET_ACCESS;
+	ea[0].grfInheritance = NO_INHERITANCE;
+	ea[0].Trustee.MultipleTrusteeOperation = NO_MULTIPLE_TRUSTEE;
+	ea[0].Trustee.TrusteeForm = TRUSTEE_IS_SID;
+	ea[0].Trustee.TrusteeType = TRUSTEE_IS_WELL_KNOWN_GROUP;
+	ea[0].Trustee.ptstrName = (LPTSTR)d->pEveryoneSID;
+
+	dwResult = SetEntriesInAcl(NR_EA, ea, NULL, &d->pACL);
+	if (dwResult != ERROR_SUCCESS) {
+		DWORD gle = GetLastError();
+		trace2_data_intmax("ipc-debug", NULL, "set-acl-entry/gle",
+				   (intmax_t)gle);
+		trace2_data_intmax("ipc-debug", NULL, "set-acl-entry/dw",
+				   (intmax_t)dwResult);
+		goto fail;
+	}
+
+	d->pSD = (PSECURITY_DESCRIPTOR)LocalAlloc(
+		LPTR, SECURITY_DESCRIPTOR_MIN_LENGTH);
+	if (!InitializeSecurityDescriptor(d->pSD, SECURITY_DESCRIPTOR_REVISION)) {
+		DWORD gle = GetLastError();
+		trace2_data_intmax("ipc-debug", NULL, "init-sd/gle", (intmax_t)gle);
+		goto fail;
+	}
+
+	if (!SetSecurityDescriptorDacl(d->pSD, TRUE, d->pACL, FALSE)) {
+		DWORD gle = GetLastError();
+		trace2_data_intmax("ipc-debug", NULL, "set-sd-dacl/gle", (intmax_t)gle);
+		goto fail;
+	}
+
+	d->lpSA = (LPSECURITY_ATTRIBUTES)LocalAlloc(LPTR, sizeof(SECURITY_ATTRIBUTES));
+	d->lpSA->nLength = sizeof(SECURITY_ATTRIBUTES);
+	d->lpSA->lpSecurityDescriptor = d->pSD;
+	d->lpSA->bInheritHandle = FALSE;
+
+	return d->lpSA;
+
+fail:
+	release_sa(d);
+	return NULL;
+}
+
 static HANDLE create_new_pipe(wchar_t *wpath, int is_first)
 {
 	HANDLE hPipe;
 	DWORD dwOpenMode, dwPipeMode;
-	LPSECURITY_ATTRIBUTES lpsa = NULL;
+	struct my_sa_data my_sa_data;
+
+	init_sa(&my_sa_data);
 
 	dwOpenMode = PIPE_ACCESS_INBOUND | PIPE_ACCESS_OUTBOUND |
 		FILE_FLAG_OVERLAPPED;
@@ -611,20 +734,15 @@ static HANDLE create_new_pipe(wchar_t *wpath, int is_first)
 		 * set the ACL / Security Attributes on the named
 		 * pipe; subsequent instances inherit and cannot
 		 * change them.
-		 *
-		 * TODO Should we allow the application layer to
-		 * specify security attributes, such as `LocalService`
-		 * or `LocalSystem`, when we create the named pipe?
-		 * This question is probably not important when the
-		 * daemon is started by a foreground user process and
-		 * only needs to talk to the current user, but may be
-		 * if the daemon is run via the Control Panel as a
-		 * System Service.
 		 */
+		get_sa(&my_sa_data);
 	}
 
 	hPipe = CreateNamedPipeW(wpath, dwOpenMode, dwPipeMode,
-				 PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0, lpsa);
+				 PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0,
+				 my_sa_data.lpSA);
+
+	release_sa(&my_sa_data);
 
 	return hPipe;
 }
-- 
gitgitgadget

