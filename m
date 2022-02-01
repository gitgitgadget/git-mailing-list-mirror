Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9498DC433EF
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 15:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240645AbiBAPuB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 10:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240647AbiBAPt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 10:49:59 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB84C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 07:49:59 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id e8so32942270wrc.0
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 07:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dMfGOz6LctA/BC9sgzdXPx+Itxm2O7fq09EiakwmCQo=;
        b=N0RKVOO9E/hgyM+npLsTHscyyLCr1NjJsgu1YCzAXnJez1WyFCAiKMof/DuF6hkimV
         SHq2HM6GpCmWIjBaFIwwdamcyowUDUeRn3O/BeeVZbT+ydCayxZysbiaa+0Va8JXBPx7
         YEAHGoAym2fKowjn6+ea1GXllzbwOl9gSgYoQ2Cg9/5IMWvmH+2G/DAuI5Qfnx4LdWbJ
         haRgP0NFJEEScJ1DvdgIuLW/7LFVMIsMJ/R3ZDmqfciem7o6d+YcNlWPNgBIsk6xDv2u
         FvMQWRBatZbgzLqKEm36B1ktLDVbRj19mccjzmVDl86ZYZ1z2ZjjCsiXJy8MXCuM8ayX
         q3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dMfGOz6LctA/BC9sgzdXPx+Itxm2O7fq09EiakwmCQo=;
        b=N2Q/59EB/KkPCn+94CglMexTIuHiYy15vpnO0YQZ0sAXjO/ht8RSGbXlbnHFuFkk0W
         Yt8WRSl9NozlIgqJ2NM5W5IKVigqpXMlMX8NVWH4Hv2tSjKg30L62XN+8p3zVkI1+23M
         BF5yaEazRf91UuPVZxZ02tauYYBWoSLrNKQVqyuEAdCNfDkmJfVUHEszLal7KzSJF4JG
         j6LIMLtg1SU7PtBwfLqfkOTJ2S0Bx6UOp6ca6rZrPTOAc8r/FNJ5F5LacCsFMWZoyp/6
         d0FA0XoJt14tr88en69FRTDpn2pDblJwmjjq/b/xsuA6bdIhjJ+cJSkpAHCPv3IrV3np
         ioTw==
X-Gm-Message-State: AOAM530LlMPi9nRPzpfDfekLWMvFMxVNRf1CANxWviMimaQuCjnm0NCW
        lbKSpXlZrOkbm1m3DA7x3RQC15N54hk=
X-Google-Smtp-Source: ABdhPJyhq4d4o/mDrrmhahHutR17BvNGIes9zu/9dI/lcS4JlJ5YGsPhS7rFc9C/xjJHuN15bSwv2A==
X-Received: by 2002:adf:fb05:: with SMTP id c5mr22131944wrr.220.1643730597976;
        Tue, 01 Feb 2022 07:49:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o10sm2871812wri.69.2022.02.01.07.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 07:49:57 -0800 (PST)
Message-Id: <d7f4b6c8052ddfebe477228057500e6ec5025b62.1643730593.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
References: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
From:   "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Feb 2022 15:49:50 +0000
Subject: [PATCH 3/6] builtin/fetch-pack: add --refilter option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Robert Coup <robert@coup.net.nz>,
        Robert Coup <robert@coup.net.nz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Coup <robert@coup.net.nz>

Add a --refilter option to fetch-pack to force a full fetch when
applying a new filter.

Signed-off-by: Robert Coup <robert@coup.net.nz>
---
 Documentation/git-fetch-pack.txt | 4 ++++
 builtin/fetch-pack.c             | 4 ++++
 remote-curl.c                    | 6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index c9758847937..ad21c627d75 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -101,6 +101,10 @@ be in a separate packet, and the list must end with a flush packet.
 	current shallow boundary instead of from the tip of each
 	remote branch history.
 
+--refilter::
+	Skips negotiating commits with the server in order to reapply a new
+	partial clone filter and fetch all matching objects.
+
 --no-progress::
 	Do not show the progress.
 
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index c2d96f4c89a..eb478929236 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -153,6 +153,10 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			args.from_promisor = 1;
 			continue;
 		}
+		if (!strcmp("--refilter", arg)) {
+			args.refilter = 1;
+			continue;
+		}
 		if (skip_prefix(arg, ("--" CL_ARG__FILTER "="), &arg)) {
 			parse_list_objects_filter(&args.filter_options, arg);
 			continue;
diff --git a/remote-curl.c b/remote-curl.c
index 0dabef2dd7c..0679f71e935 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -43,6 +43,7 @@ struct options {
 		/* see documentation of corresponding flag in fetch-pack.h */
 		from_promisor : 1,
 
+		refilter : 1,
 		atomic : 1,
 		object_format : 1,
 		force_if_includes : 1;
@@ -198,6 +199,9 @@ static int set_option(const char *name, const char *value)
 	} else if (!strcmp(name, "from-promisor")) {
 		options.from_promisor = 1;
 		return 0;
+	} else if (!strcmp(name, "refilter")) {
+		options.refilter = 1;
+		return 0;
 	} else if (!strcmp(name, "filter")) {
 		options.filter = xstrdup(value);
 		return 0;
@@ -1182,6 +1186,8 @@ static int fetch_git(struct discovery *heads,
 		strvec_push(&args, "--deepen-relative");
 	if (options.from_promisor)
 		strvec_push(&args, "--from-promisor");
+	if (options.refilter)
+		strvec_push(&args, "--refilter");
 	if (options.filter)
 		strvec_pushf(&args, "--filter=%s", options.filter);
 	strvec_push(&args, url.buf);
-- 
gitgitgadget

