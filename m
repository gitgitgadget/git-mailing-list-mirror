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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FC4C433F5
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 15:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D37EA61107
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 15:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238148AbhITPiA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 11:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237282AbhITPhv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 11:37:51 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75BBC061760
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 08:36:24 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i23so30941822wrb.2
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 08:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0Cl1yv7LeDWfZGdfZCfdqCe5HaL5g/B5qt/Hs8wqPpE=;
        b=kWYmE7g14+DiyNf8kmpx6GLpEQ/ecXEiSvEGb/QFW0Kn9xH1jKQsovtmfZA2Us7a6N
         XDSdPVkF/kaR1NSqFFYgoVZ4DQlqBfEmb5/nPO5Do02cPp5zfYJdimaz6ghKzuY6UzUz
         sxR1FOdnH6KPsBA/OfiMWkuCHybEakmb8EuwAj1NUcRGQJ5g504wsSutqADqAndGENl4
         WYx5NqtcDrNZ7/TcgBcKgn/ZkQpPr4qFMwGk4IYwpBiNJhgTYV65Jd6Lt2BSLsb0MEoa
         HZepQouarBaSwTu60A32vo9TUeDp8V3jb0DM/heJxzfCDny9C3v3SsPNAQM3eALMH81+
         8Ytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0Cl1yv7LeDWfZGdfZCfdqCe5HaL5g/B5qt/Hs8wqPpE=;
        b=F74utdod/vaVXOA3ozczkdWfPrMLunceDMcXcQ45ESmCfBqvOfgYdSuOch2wtaDCrE
         XOxEWe5wfI3bUGDC0vymtolwhbjVRfwnyw/eW+GWJDnPMsEbX1iWYmREeOlMYfkxJTLO
         48tUMFYVU6aysfNh44d6GVjgz+wYkJHXysMTZ0UfOOGwtecFqXAejvyku99duO7RNd1E
         ILSsDc6CmV/OQbAz1UCT/IOnju+DD1F0pOtumbXEhhRiF4amGO3wkk53qnPdqvnpS6uk
         WSSit4wfJDQCb/UH18wov/VQhVBZi9BABdYp7+ZOtPGyHqMG0wzDK+w2zXGjZ8jRNhNS
         yPHA==
X-Gm-Message-State: AOAM531WqJsHF+uDXgH1etiXmDcWGaeUx7xzoJ1rRYohj752i3a8Rc+2
        drNTl+AL1b8ao4Wc+XMLH807FWjZS8s=
X-Google-Smtp-Source: ABdhPJwv/W6uZxbKQUhNINNC15ODlawHre/TbSS5GJ+jO61k5drNesMV6RHyerw4c9M/ZDRAUjp+Bg==
X-Received: by 2002:a5d:6750:: with SMTP id l16mr28859553wrw.174.1632152183430;
        Mon, 20 Sep 2021 08:36:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g1sm466312wmk.2.2021.09.20.08.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 08:36:23 -0700 (PDT)
Message-Id: <faf6034848e78205630c64624aaeb509b505af82.1632152178.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
        <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Sep 2021 15:36:16 +0000
Subject: [PATCH v2 5/7] simple-ipc/ipc-win32: add Windows ACL to named pipe
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Carlo Arenas <carenas@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
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
index a8dd46bd922..20ea7b65e0b 100644
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
@@ -592,11 +594,132 @@ finished:
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
@@ -612,20 +735,15 @@ static HANDLE create_new_pipe(wchar_t *wpath, int is_first)
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

