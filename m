Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F31C19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 17:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245088AbiHIRoP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 13:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiHIRoO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 13:44:14 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36ACEF18
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 10:44:13 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n185so6657547wmn.4
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 10:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc;
        bh=8BC7oDCbZ3QosmsGrHQATt1nj5qtWdseLYi0nUcCcFE=;
        b=jJdLnEpSYmlJ1oLz+HJyjhgBvddmsK/5nQavp1u9GmRncdF/t6URhiZHSbQD1fRTJi
         DidgkPk33GvXr8QjZemW1tadQfVbL2jFP/sd2yGFyfPwbXvtS6idLWyVPq+vdE7o8XwC
         0tDw1aktsNlVaAtI9WsHkyPbxFoiALozCgmD+d01ihMhE8IR9uINa8EP+O7ai+qNWBJv
         bc2Agy2HgcCJ1xtI6uG1Lx6QHnahHH+iDGK4Mo6SYW5ELOvkqXBrEJfyj2X89dwCZOVK
         MbtQSjHLmUTvZXR9obAbF9AwMMXNgd153BYqnt6U9UZPvxlyDDlgxvpUcbwWVbwzQ4Wl
         B+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc;
        bh=8BC7oDCbZ3QosmsGrHQATt1nj5qtWdseLYi0nUcCcFE=;
        b=aAStMF5WRxuU+M4hzeS2RdkoX/CXXYgM+6Are57OpUApMZgUG+syj8EhukyEsvalB6
         XP4ANMVBbqtJuY5bfi6RkTnwaUjaAZpfDOiG3D/OITHq8vmuuO7KG77yKLjKzlRJOD+s
         s+HsA4qBpf1OqpUXpXk5Kcvrwta4h5VmLq2lL7Z2aMTgmrlqIE7a/DeP3XXAggA1VzoI
         6R4+m9M7IRhQiTfWVKWvdeRHMX3OrmbTq/xFHzYwItjJuN4gEdjrd2pOemgN2AiyogKg
         rtyWFOom5QxyrEB7b6WIZGWXGS1lFBK3/yxLSFx4j8oo7eqpygp9MXOQrbxF5fTcxcmg
         aC4A==
X-Gm-Message-State: ACgBeo3AkZzbzJ3psja5nTAUn+q5ku6oH8wdUUUkjCM7JFkG1SdltV0J
        e2oZJUwnrGAZv2omE7KZav0kmYoiPbg=
X-Google-Smtp-Source: AA6agR4aVas0+KFCELLDBV/w7BN2fAUKdrh6zrtN+ohvzvvVELF1Be3WkZVy7DLasKfhOwLGcepRqQ==
X-Received: by 2002:a05:600c:4c06:b0:3a5:4eec:eb4b with SMTP id d6-20020a05600c4c0600b003a54eeceb4bmr5618926wmp.151.1660067051372;
        Tue, 09 Aug 2022 10:44:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b18-20020a5d4b92000000b0021d6924b777sm13682741wrt.115.2022.08.09.10.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 10:44:10 -0700 (PDT)
Message-Id: <pull.1317.git.1660067049965.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Aug 2022 17:44:09 +0000
Subject: [PATCH] fsmonitor: option to allow fsmonitor to run against
 network-mounted repos
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric DeCosta <edecosta@mathworks.com>

Though perhaps not common, there are uses cases where users have large,
network-mounted repos. Having the ability to run fsmonitor against
network paths would benefit those users.

Most modern Samba-based filers have the necessary support to enable
fsmonitor on network-mounted repos. As a first step towards enabling
fsmonitor to work against network-mounted repos, introduce a
configuration option, 'fsmonitor.allowRemote'. Setting this option to
true will override the default behavior (erroring-out) when a
network-mounted repo is detected by fsmonitor.

Additionally, as part of this first step, monitoring of network-mounted
repos will be restricted to those mounted over SMB regardless of the
value of 'fsmonitor.allowRemote' until more extensive testing can be
performed.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
    Option to allow fsmonitor to run against repos on network file systems

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1317%2Fedecosta-mw%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1317/edecosta-mw/master-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1317

 compat/fsmonitor/fsm-settings-win32.c | 59 ++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/compat/fsmonitor/fsm-settings-win32.c b/compat/fsmonitor/fsm-settings-win32.c
index 907655720bb..d120e4710cf 100644
--- a/compat/fsmonitor/fsm-settings-win32.c
+++ b/compat/fsmonitor/fsm-settings-win32.c
@@ -24,6 +24,58 @@ static enum fsmonitor_reason check_vfs4git(struct repository *r)
 	return FSMONITOR_REASON_OK;
 }
 
+/*
+ * Check if monitoring remote working directories is allowed.
+ *
+ * By default monitoring remote working directories is not allowed,
+ * but users may override this behavior in enviroments where they
+ * have proper support.
+*/
+static enum fsmonitor_reason check_allow_remote(struct repository *r)
+{
+	int allow;
+
+	if (repo_config_get_bool(r, "fsmonitor.allowremote", &allow) || !allow)
+		return FSMONITOR_REASON_REMOTE;
+
+	return FSMONITOR_REASON_OK;
+}
+
+/*
+ * Check if the remote working directory is mounted via SMB
+ *
+ * For now, remote working directories are only supported via SMB mounts
+*/
+static enum fsmonitor_reason check_smb(wchar_t *wpath)
+{
+	HANDLE h;
+	FILE_REMOTE_PROTOCOL_INFO proto_info;
+
+	h = CreateFileW(wpath, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING,
+					FILE_FLAG_BACKUP_SEMANTICS, NULL);
+
+	if (h == INVALID_HANDLE_VALUE) {
+		error(_("[GLE %ld] unable to open for read '%ls'"),
+		      GetLastError(), wpath);
+		return FSMONITOR_REASON_ERROR;
+	}
+
+	if (!GetFileInformationByHandleEx(h, FileRemoteProtocolInfo,
+									&proto_info, sizeof(proto_info))) {
+		error(_("[GLE %ld] unable to get protocol information for '%ls'"),
+		      GetLastError(), wpath);
+		CloseHandle(h);
+		return FSMONITOR_REASON_ERROR;
+	}
+
+	CloseHandle(h);
+
+	if (proto_info.Protocol == WNNC_NET_SMB)
+		return FSMONITOR_REASON_OK;
+
+	return FSMONITOR_REASON_ERROR;
+}
+
 /*
  * Remote working directories are problematic for FSMonitor.
  *
@@ -76,6 +128,7 @@ static enum fsmonitor_reason check_vfs4git(struct repository *r)
  */
 static enum fsmonitor_reason check_remote(struct repository *r)
 {
+	enum fsmonitor_reason reason;
 	wchar_t wpath[MAX_PATH];
 	wchar_t wfullpath[MAX_PATH];
 	size_t wlen;
@@ -115,7 +168,11 @@ static enum fsmonitor_reason check_remote(struct repository *r)
 		trace_printf_key(&trace_fsmonitor,
 				 "check_remote('%s') true",
 				 r->worktree);
-		return FSMONITOR_REASON_REMOTE;
+
+		reason = check_smb(wfullpath);
+		if (reason != FSMONITOR_REASON_OK)
+			return reason;
+		return check_allow_remote(r);
 	}
 
 	return FSMONITOR_REASON_OK;

base-commit: c50926e1f48891e2671e1830dbcd2912a4563450
-- 
gitgitgadget
