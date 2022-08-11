Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC15C25B06
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 23:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbiHKX5R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 19:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbiHKX5P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 19:57:15 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F869E2DB
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 16:57:14 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id p10so22955217wru.8
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 16:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=REb1sQqGoWoxkX45enPvevbu0mHf9uPI29cBwtBDEfo=;
        b=HPpkkglrSemf6PqsIBr4GIQcZpT3d3N7Hu7CuqMMfCsyz4mlSrhBPyHx8ii/RwFsMH
         NxbUGlyE+UfZpp2Ta/HmDvJes44T2wfpTAyaLRsZl4UOfBIzU5rZfgXli0C9iogcAffQ
         R+eQIVq758Y/5lvLXLEyjM+/6a6d93JuBJIhipilokZFW7m/0w73b+YlqFXPbAUc1qHS
         OFonvSpf89ZeQcLjo9Fbrmn916f/+yKl40FWutznzl/jnefQ+TR8az1Y22AZ4NQklRQG
         4BFt4SpXVuQoHgWbTrd0IdB9reRQu196/XFhUTZVHuGeGI6oq9xCEQWZsFhw3JjsArUu
         VQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=REb1sQqGoWoxkX45enPvevbu0mHf9uPI29cBwtBDEfo=;
        b=vd9z14UPs7Fxy+xxfvv+kOvjqbRApafAPnjTvcLbZQGwrniBsXPIhzEWKW1DAwzUhn
         slsejawXfAlDMCmGvaaRmfXCF82wfO93aqQ1zzn5tVscwo51LLJobBQKT2dSN9mTLQin
         Jx/JMv5zJqKUKJ5R+8mTBDi/dqHPyXw4/Fj4rrX6iPrBBmFHNnZpk4UdLDFemX0W0LIJ
         rb5e69ZQmtWLkhWKYjn9DAr5s4y9o+r2PYM2dQDKNMXgtIQI7vAC8BX0D6+FWQaTtpiS
         h/AkmfqGb1wsFJoPj/X7gFMJlQVDK9HPbd14R+G6kWFQ8gvLvZJAKvV5Lv+o6Y+iEvQJ
         7jKg==
X-Gm-Message-State: ACgBeo1GcmkTLX4EIzmv4JOJn9d4mHO4gcIjZsoiA4Ipqf+jfrV772x7
        z+AH0yiRTEy17PTpFF01mCj4tqo0x7Y=
X-Google-Smtp-Source: AA6agR4nKhU7bV1Kbv5sURgjXU2Y/daHeBQm5Ww1YcPDaI3yqZhFMBPtAXvwBCPoDd1k1cKKEjkbMw==
X-Received: by 2002:a5d:5986:0:b0:220:73d5:1f01 with SMTP id n6-20020a5d5986000000b0022073d51f01mr590216wri.417.1660262232788;
        Thu, 11 Aug 2022 16:57:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n40-20020a05600c3ba800b003a5ca627333sm292829wms.8.2022.08.11.16.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 16:57:12 -0700 (PDT)
Message-Id: <pull.1317.v4.git.1660262231357.gitgitgadget@gmail.com>
In-Reply-To: <pull.1317.v3.git.1660242752495.gitgitgadget@gmail.com>
References: <pull.1317.v3.git.1660242752495.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 Aug 2022 23:57:11 +0000
Subject: [PATCH v4] fsmonitor: option to allow fsmonitor to run against
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1317%2Fedecosta-mw%2Fmaster-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1317/edecosta-mw/master-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1317

Range-diff vs v3:

 1:  6c5f176cbee ! 1:  058dc400c8a fsmonitor: option to allow fsmonitor to run against network-mounted repos
     @@ compat/fsmonitor/fsm-settings-win32.c: static enum fsmonitor_reason check_vfs4gi
      + * Check if monitoring remote working directories is allowed.
      + *
      + * By default, monitoring remote working directories is
     -+ * disabled unless on a network filesystem that is known to
     -+ * behave well.  Users may override this behavior in enviroments where
     ++ * disabled.  Users may override this behavior in enviroments where
      + * they have proper support.
      + */
      +static int check_config_allowremote(struct repository *r)
     @@ compat/fsmonitor/fsm-settings-win32.c: static enum fsmonitor_reason check_vfs4gi
      + *
      + * Error if client machine cannot get remote protocol information.
      + */
     -+static void check_remote_protocol(wchar_t *wpath)
     ++static int check_remote_protocol(wchar_t *wpath)
      +{
      +	HANDLE h;
      +	FILE_REMOTE_PROTOCOL_INFO proto_info;
     @@ compat/fsmonitor/fsm-settings-win32.c: static enum fsmonitor_reason check_vfs4gi
      +	if (h == INVALID_HANDLE_VALUE) {
      +		error(_("[GLE %ld] unable to open for read '%ls'"),
      +		      GetLastError(), wpath);
     -+		return;
     ++		return -1;
      +	}
      +
      +	if (!GetFileInformationByHandleEx(h, FileRemoteProtocolInfo,
     @@ compat/fsmonitor/fsm-settings-win32.c: static enum fsmonitor_reason check_vfs4gi
      +		error(_("[GLE %ld] unable to get protocol information for '%ls'"),
      +		      GetLastError(), wpath);
      +		CloseHandle(h);
     -+		return;
     ++		return -1;
      +	}
      +
      +	CloseHandle(h);
     @@ compat/fsmonitor/fsm-settings-win32.c: static enum fsmonitor_reason check_vfs4gi
      +				"check_remote_protocol('%ls') remote protocol %#8.8lx",
      +				wpath, proto_info.Protocol);
      +
     -+	return;
     ++	return 0;
      +}
      +
       /*
        * Remote working directories are problematic for FSMonitor.
        *
     +@@ compat/fsmonitor/fsm-settings-win32.c: static enum fsmonitor_reason check_vfs4git(struct repository *r)
     +  */
     + static enum fsmonitor_reason check_remote(struct repository *r)
     + {
     ++	int ret;
     + 	wchar_t wpath[MAX_PATH];
     + 	wchar_t wfullpath[MAX_PATH];
     + 	size_t wlen;
      @@ compat/fsmonitor/fsm-settings-win32.c: static enum fsmonitor_reason check_remote(struct repository *r)
       		trace_printf_key(&trace_fsmonitor,
       				 "check_remote('%s') true",
       				 r->worktree);
      +
     -+		check_remote_protocol(wfullpath);
     ++		ret = check_remote_protocol(wfullpath);
     ++		if (ret < 0)
     ++			return FSMONITOR_REASON_ERROR;
      +
      +		switch (check_config_allowremote(r)) {
      +		case 0: /* config overrides and disables */


 compat/fsmonitor/fsm-settings-win32.c | 68 +++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/compat/fsmonitor/fsm-settings-win32.c b/compat/fsmonitor/fsm-settings-win32.c
index 907655720bb..e5ec5b0a9f7 100644
--- a/compat/fsmonitor/fsm-settings-win32.c
+++ b/compat/fsmonitor/fsm-settings-win32.c
@@ -24,6 +24,59 @@ static enum fsmonitor_reason check_vfs4git(struct repository *r)
 	return FSMONITOR_REASON_OK;
 }
 
+/*
+ * Check if monitoring remote working directories is allowed.
+ *
+ * By default, monitoring remote working directories is
+ * disabled.  Users may override this behavior in enviroments where
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
+static int check_remote_protocol(wchar_t *wpath)
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
+		return -1;
+	}
+
+	if (!GetFileInformationByHandleEx(h, FileRemoteProtocolInfo,
+		&proto_info, sizeof(proto_info))) {
+		error(_("[GLE %ld] unable to get protocol information for '%ls'"),
+		      GetLastError(), wpath);
+		CloseHandle(h);
+		return -1;
+	}
+
+	CloseHandle(h);
+
+	trace_printf_key(&trace_fsmonitor,
+				"check_remote_protocol('%ls') remote protocol %#8.8lx",
+				wpath, proto_info.Protocol);
+
+	return 0;
+}
+
 /*
  * Remote working directories are problematic for FSMonitor.
  *
@@ -76,6 +129,7 @@ static enum fsmonitor_reason check_vfs4git(struct repository *r)
  */
 static enum fsmonitor_reason check_remote(struct repository *r)
 {
+	int ret;
 	wchar_t wpath[MAX_PATH];
 	wchar_t wfullpath[MAX_PATH];
 	size_t wlen;
@@ -115,6 +169,20 @@ static enum fsmonitor_reason check_remote(struct repository *r)
 		trace_printf_key(&trace_fsmonitor,
 				 "check_remote('%s') true",
 				 r->worktree);
+
+		ret = check_remote_protocol(wfullpath);
+		if (ret < 0)
+			return FSMONITOR_REASON_ERROR;
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
