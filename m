Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE13C25B0C
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 18:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235625AbiHKSci (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 14:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbiHKScg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 14:32:36 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C081E9D
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 11:32:35 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z16so22188399wrh.12
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 11:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=CMR7b4r3kRXaCDXjFEdjBL4St6tPAwql87A4DDNThD4=;
        b=OTwVIidydY/PPdEDMitAJRZdoD5+o6GmYOOSCvY853G5kRw8JXHukklOLhWfNh60bG
         VS67c3ZfYxp0SGo5UoAPKGqL/l+KfkRMlwh3ra2K1UL08lp+QaR9/NtU9IwkP4zfSKcG
         D88JhDo1AnWV29zdYmpCwbAJxRJ7Pf00JkxgEX7xj6DwL69fvFqZW4rrHRAdZbal+GyC
         RZq7wdNW3puu7i6JxOZzY1jt2WU1HXh8ebOkRnJxzaHpeqaZp17Uefl4sV1mOAJmRtKL
         ssDyiWbxTgzDuwqXABzrCM+6g6CzmGFTUCO61UNPla7uw5HL4lZRq8/mNGVelqS6cFPF
         hINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=CMR7b4r3kRXaCDXjFEdjBL4St6tPAwql87A4DDNThD4=;
        b=Cqo7QgNbLhto1/94MjRSA6D8cIHF/53MoYlb51j4V79gjorfjuWYVSt52+kJg6KG0S
         0tldKtaEd4yx4ldR3Bv9TEWrNLt2rnTzbCdwp4nDbtST3VqL/xstzF65C5VN0rwX48sr
         tcyWJ/GYmZA9M+Dwz0EZBR5j0ykqb8aNQ35B1F6ehINXRywLhQwQdjXtp80aPvc98b51
         MqP12RBfd8RBQ1bsDnsrvIbiY8CVbEaS51yr3zmWaFsCc2dQ5MDC/GWocKID1SP3kENK
         qDqEAhjQYL3BXioulCskOsOlpiGPMhPnFwjSh5XuOlsm0hxD8DXMDY9A8Qs2/S96b69l
         4Tzg==
X-Gm-Message-State: ACgBeo2OnXBDdgfcH4O58KNrxhEJr3Xzm/WasQlkbP/ebiT1XR+eHl0k
        3f+bs6oVEPf4ChuKu6O0EeLf03rcfRE=
X-Google-Smtp-Source: AA6agR6F3xyVPQEdnke82E3TPpB/loHNVdUq71jTpC2A7FCu94CSNLnDJuCVR1IfVX5WMLlMJXmg9g==
X-Received: by 2002:a5d:47aa:0:b0:21e:e1aa:2542 with SMTP id 10-20020a5d47aa000000b0021ee1aa2542mr153739wrb.19.1660242753688;
        Thu, 11 Aug 2022 11:32:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c5-20020a7bc005000000b003a2d47d3051sm178753wmb.41.2022.08.11.11.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 11:32:33 -0700 (PDT)
Message-Id: <pull.1317.v3.git.1660242752495.gitgitgadget@gmail.com>
In-Reply-To: <pull.1317.v2.git.1660233432.gitgitgadget@gmail.com>
References: <pull.1317.v2.git.1660233432.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 Aug 2022 18:32:32 +0000
Subject: [PATCH v3] fsmonitor: option to allow fsmonitor to run against
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

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
    Option to allow fsmonitor to run against repos on network file systems
    
    cc: Eric D eric.decosta@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1317%2Fedecosta-mw%2Fmaster-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1317/edecosta-mw/master-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1317

Range-diff vs v2:

 1:  7e67ce8c944 ! 1:  6c5f176cbee fsmonitor: option to allow fsmonitor to run against network-mounted repos
     @@ Commit message
          true will override the default behavior (erroring-out) when a
          network-mounted repo is detected by fsmonitor.
      
     -    Additionally, as part of this first step, monitoring of network-mounted
     -    repos will be restricted to those mounted over SMB regardless of the
     -    value of 'fsmonitor.allowRemote' until more extensive testing can be
     -    performed.
     -
          Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
      
       ## compat/fsmonitor/fsm-settings-win32.c ##
     @@ compat/fsmonitor/fsm-settings-win32.c: static enum fsmonitor_reason check_vfs4gi
      +/*
      + * Check if monitoring remote working directories is allowed.
      + *
     -+ * By default monitoring remote working directories is not allowed,
     -+ * but users may override this behavior in enviroments where they
     -+ * have proper support.
     -+*/
     -+static enum fsmonitor_reason check_allow_remote(struct repository *r)
     ++ * By default, monitoring remote working directories is
     ++ * disabled unless on a network filesystem that is known to
     ++ * behave well.  Users may override this behavior in enviroments where
     ++ * they have proper support.
     ++ */
     ++static int check_config_allowremote(struct repository *r)
      +{
      +	int allow;
      +
     -+	if (repo_config_get_bool(r, "fsmonitor.allowremote", &allow) || !allow)
     -+		return FSMONITOR_REASON_REMOTE;
     ++	if (!repo_config_get_bool(r, "fsmonitor.allowremote", &allow))
     ++		return allow;
      +
     -+	return FSMONITOR_REASON_OK;
     ++	return -1; /* fsmonitor.allowremote not set */
      +}
      +
      +/*
     -+ * Check if the remote working directory is mounted via SMB
     ++ * Check remote working directory protocol.
      + *
     -+ * For now, remote working directories are only supported via SMB mounts
     -+*/
     -+static enum fsmonitor_reason check_smb(wchar_t *wpath)
     ++ * Error if client machine cannot get remote protocol information.
     ++ */
     ++static void check_remote_protocol(wchar_t *wpath)
      +{
      +	HANDLE h;
      +	FILE_REMOTE_PROTOCOL_INFO proto_info;
      +
      +	h = CreateFileW(wpath, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING,
     -+					FILE_FLAG_BACKUP_SEMANTICS, NULL);
     ++			FILE_FLAG_BACKUP_SEMANTICS, NULL);
      +
      +	if (h == INVALID_HANDLE_VALUE) {
      +		error(_("[GLE %ld] unable to open for read '%ls'"),
      +		      GetLastError(), wpath);
     -+		return FSMONITOR_REASON_ERROR;
     ++		return;
      +	}
      +
      +	if (!GetFileInformationByHandleEx(h, FileRemoteProtocolInfo,
     -+									&proto_info, sizeof(proto_info))) {
     ++		&proto_info, sizeof(proto_info))) {
      +		error(_("[GLE %ld] unable to get protocol information for '%ls'"),
      +		      GetLastError(), wpath);
      +		CloseHandle(h);
     -+		return FSMONITOR_REASON_ERROR;
     ++		return;
      +	}
      +
      +	CloseHandle(h);
      +
     -+	if (proto_info.Protocol == WNNC_NET_SMB)
     -+		return FSMONITOR_REASON_OK;
     ++	trace_printf_key(&trace_fsmonitor,
     ++				"check_remote_protocol('%ls') remote protocol %#8.8lx",
     ++				wpath, proto_info.Protocol);
      +
     -+	return FSMONITOR_REASON_ERROR;
     ++	return;
      +}
      +
       /*
        * Remote working directories are problematic for FSMonitor.
        *
     -@@ compat/fsmonitor/fsm-settings-win32.c: static enum fsmonitor_reason check_vfs4git(struct repository *r)
     -  */
     - static enum fsmonitor_reason check_remote(struct repository *r)
     - {
     -+	enum fsmonitor_reason reason;
     - 	wchar_t wpath[MAX_PATH];
     - 	wchar_t wfullpath[MAX_PATH];
     - 	size_t wlen;
      @@ compat/fsmonitor/fsm-settings-win32.c: static enum fsmonitor_reason check_remote(struct repository *r)
       		trace_printf_key(&trace_fsmonitor,
       				 "check_remote('%s') true",
       				 r->worktree);
     --		return FSMONITOR_REASON_REMOTE;
      +
     -+		reason = check_smb(wfullpath);
     -+		if (reason != FSMONITOR_REASON_OK)
     -+			return reason;
     -+		return check_allow_remote(r);
     ++		check_remote_protocol(wfullpath);
     ++
     ++		switch (check_config_allowremote(r)) {
     ++		case 0: /* config overrides and disables */
     ++			return FSMONITOR_REASON_REMOTE;
     ++		case 1: /* config overrides and enables */
     ++			return FSMONITOR_REASON_OK;
     ++		default:
     ++			break; /* config has no opinion */
     ++		}
     ++
     + 		return FSMONITOR_REASON_REMOTE;
       	}
       
     - 	return FSMONITOR_REASON_OK;
 2:  7a071c9e6be < -:  ----------- fsmonitor.allowRemote now overrides default behavior


 compat/fsmonitor/fsm-settings-win32.c | 66 +++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/compat/fsmonitor/fsm-settings-win32.c b/compat/fsmonitor/fsm-settings-win32.c
index 907655720bb..32c0695c6c1 100644
--- a/compat/fsmonitor/fsm-settings-win32.c
+++ b/compat/fsmonitor/fsm-settings-win32.c
@@ -24,6 +24,60 @@ static enum fsmonitor_reason check_vfs4git(struct repository *r)
 	return FSMONITOR_REASON_OK;
 }
 
+/*
+ * Check if monitoring remote working directories is allowed.
+ *
+ * By default, monitoring remote working directories is
+ * disabled unless on a network filesystem that is known to
+ * behave well.  Users may override this behavior in enviroments where
+ * they have proper support.
+ */
+static int check_config_allowremote(struct repository *r)
+{
+	int allow;
+
+	if (!repo_config_get_bool(r, "fsmonitor.allowremote", &allow))
+		return allow;
+
+	return -1; /* fsmonitor.allowremote not set */
+}
+
+/*
+ * Check remote working directory protocol.
+ *
+ * Error if client machine cannot get remote protocol information.
+ */
+static void check_remote_protocol(wchar_t *wpath)
+{
+	HANDLE h;
+	FILE_REMOTE_PROTOCOL_INFO proto_info;
+
+	h = CreateFileW(wpath, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING,
+			FILE_FLAG_BACKUP_SEMANTICS, NULL);
+
+	if (h == INVALID_HANDLE_VALUE) {
+		error(_("[GLE %ld] unable to open for read '%ls'"),
+		      GetLastError(), wpath);
+		return;
+	}
+
+	if (!GetFileInformationByHandleEx(h, FileRemoteProtocolInfo,
+		&proto_info, sizeof(proto_info))) {
+		error(_("[GLE %ld] unable to get protocol information for '%ls'"),
+		      GetLastError(), wpath);
+		CloseHandle(h);
+		return;
+	}
+
+	CloseHandle(h);
+
+	trace_printf_key(&trace_fsmonitor,
+				"check_remote_protocol('%ls') remote protocol %#8.8lx",
+				wpath, proto_info.Protocol);
+
+	return;
+}
+
 /*
  * Remote working directories are problematic for FSMonitor.
  *
@@ -115,6 +169,18 @@ static enum fsmonitor_reason check_remote(struct repository *r)
 		trace_printf_key(&trace_fsmonitor,
 				 "check_remote('%s') true",
 				 r->worktree);
+
+		check_remote_protocol(wfullpath);
+
+		switch (check_config_allowremote(r)) {
+		case 0: /* config overrides and disables */
+			return FSMONITOR_REASON_REMOTE;
+		case 1: /* config overrides and enables */
+			return FSMONITOR_REASON_OK;
+		default:
+			break; /* config has no opinion */
+		}
+
 		return FSMONITOR_REASON_REMOTE;
 	}
 

base-commit: c50926e1f48891e2671e1830dbcd2912a4563450
-- 
gitgitgadget
