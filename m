Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD400C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 16:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiBXQ1l (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 11:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiBXQ1j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 11:27:39 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716573EBAC
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:27:02 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id v28so3636723ljv.9
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=m7TY9TvyScXovboi5x1I/5tO806auDQUjVIPwgdI+I8=;
        b=gVzs7xfJkN1CzGYXsp/gcVox5eaIYPC8OpwDu9MOiQEm21PEEKSyXPa/CTSpwUiSuw
         WHd9iWrq87vUhEyIKCLV6mv+Y66ttDlIDbHPlexfnobsw1aM7091nvRj9kW+KZzR90au
         u5HvjeqcPf6cC6lXANtQRXQhI8gUO2ESMSbadgRIED/DL5FD1huIf+xzXT8DGycOlSa/
         5codaAQXPlJKNetBUQE4NaKfDWXiXV9YIsZ+CiLXlhTbezP0sFNO1ugyrerNItTdWLzL
         pyPYVmwt4t53mhnY1xfWJfGXmixnZygf4wSTWgY9bBM3t0bg1+8qEbQMuby+0Pl90JWL
         iQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=m7TY9TvyScXovboi5x1I/5tO806auDQUjVIPwgdI+I8=;
        b=CLTD58koV6XTSLJNBmx07bNIC8ZkkJ2baEr2IrCr0ahrwXD8KxbXAxlqy42vCry0Rr
         IbCIZtOTPcpAuHQW9K8UTqqsggKPFIfU5Rce8zBDoo9fNNfmClXjn9wAHqYbALTCbWqP
         S0pccCRxm5B2N5OmA+zvAT8pyRYFG8HygOT2/hIFKoYltpt6ywabCUUxgKeHTkhrParF
         95E/LP4MgEhZd7eSZCwMSOylc86C+DZg1s+e0OoBLUaAjJBGhTNlsIkcfo2nxmlfibH4
         tnuPO11/RHm0YeT1xQAp6hvIfBv52qtx6uloNfLaCDMJ/qsg88k8mlZv++z/emyPAH9S
         HA6g==
X-Gm-Message-State: AOAM533lpgIVrPx1SY2y+F0G0VWuCWyHv42DoI9tljKCH0W7dVPtwQIk
        7zbxxcejRM0rAsPcgT6KORs19a5Rsvw=
X-Google-Smtp-Source: ABdhPJzyn7A3aDwq8fxcwX1KwN35+QMRsIgo8nl7z+KqapPvsc31ZKb7FQlQgdDQs96TwwDOwLK7RA==
X-Received: by 2002:adf:de0b:0:b0:1ed:c0ae:cf76 with SMTP id b11-20020adfde0b000000b001edc0aecf76mr2801923wrm.501.1645719222820;
        Thu, 24 Feb 2022 08:13:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z2sm3329404wrn.60.2022.02.24.08.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:13:42 -0800 (PST)
Message-Id: <a42d40ac2949f6393e0f5985f8ecfcaa6503486e.1645719218.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
References: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
        <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
From:   "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 16:13:33 +0000
Subject: [PATCH v2 3/8] builtin/fetch-pack: add --repair option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Robert Coup <robert@coup.net.nz>,
        Robert Coup <robert@coup.net.nz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Coup <robert@coup.net.nz>

Add a --repair option to fetch-pack to force a full fetch. Use when
applying a new partial clone filter to refetch all matching objects.

Signed-off-by: Robert Coup <robert@coup.net.nz>
---
 Documentation/git-fetch-pack.txt | 4 ++++
 builtin/fetch-pack.c             | 4 ++++
 remote-curl.c                    | 6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index c9758847937..b9276813fa1 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -101,6 +101,10 @@ be in a separate packet, and the list must end with a flush packet.
 	current shallow boundary instead of from the tip of each
 	remote branch history.
 
+--repair::
+	Skips negotiating commits with the server in order to fetch all matching
+	objects. Use to reapply a new partial clone blob/tree filter.
+
 --no-progress::
 	Do not show the progress.
 
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index c2d96f4c89a..60c0082d52b 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -153,6 +153,10 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			args.from_promisor = 1;
 			continue;
 		}
+		if (!strcmp("--repair", arg)) {
+			args.repair = 1;
+			continue;
+		}
 		if (skip_prefix(arg, ("--" CL_ARG__FILTER "="), &arg)) {
 			parse_list_objects_filter(&args.filter_options, arg);
 			continue;
diff --git a/remote-curl.c b/remote-curl.c
index 0dabef2dd7c..941ed627db5 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -43,6 +43,7 @@ struct options {
 		/* see documentation of corresponding flag in fetch-pack.h */
 		from_promisor : 1,
 
+		repair : 1,
 		atomic : 1,
 		object_format : 1,
 		force_if_includes : 1;
@@ -198,6 +199,9 @@ static int set_option(const char *name, const char *value)
 	} else if (!strcmp(name, "from-promisor")) {
 		options.from_promisor = 1;
 		return 0;
+	} else if (!strcmp(name, "repair")) {
+		options.repair = 1;
+		return 0;
 	} else if (!strcmp(name, "filter")) {
 		options.filter = xstrdup(value);
 		return 0;
@@ -1182,6 +1186,8 @@ static int fetch_git(struct discovery *heads,
 		strvec_push(&args, "--deepen-relative");
 	if (options.from_promisor)
 		strvec_push(&args, "--from-promisor");
+	if (options.repair)
+		strvec_push(&args, "--repair");
 	if (options.filter)
 		strvec_pushf(&args, "--filter=%s", options.filter);
 	strvec_push(&args, url.buf);
-- 
gitgitgadget

