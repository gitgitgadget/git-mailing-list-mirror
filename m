Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF88DC4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 09:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE0256024A
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 09:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239291AbhHMJPr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 05:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhHMJPn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 05:15:43 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07264C061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 02:15:17 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id om1-20020a17090b3a8100b0017941c44ce4so1439552pjb.3
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 02:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e7zw7nNM5IRHgIdOMC/vOQu7sPAzLKedqwrdkrfxiG8=;
        b=o5ZvMH7n0R2EiuoC5FJkXed9OJUmlzcYO0vR3uOZTLv4PaUJ4THdv9JXI7QPiOSRzV
         daJp/jiVPbpM7XFKAJizMm2aVS3g7Bz6BMR9QZqlIB0fa6mR8En4/WtGrgm01NW1XmbB
         Wfme6eKuRq9kfdTO75N7sc3Yk6mavJJqqbhT9IHdKTSpnQY8eZ5i/D31jtslfgP/g1Uo
         qzNCImCblLcMrjkEPAvOFBQtEZnwmd4ldM1y1pfEgy8HqawNXSEnTc6k3gWTheEU9lxL
         NDT9Jq/8tLxhXyXXliDJZDYp5fAYZF5JkLs/fGFi3+l/6Q0176E9NzhUi/co17aRmd66
         ohFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e7zw7nNM5IRHgIdOMC/vOQu7sPAzLKedqwrdkrfxiG8=;
        b=ObtaqGjR9aBFMEsO1TBPCcNZPbc3VpN4MKKijo/+WNc/f6tsMW5J2tB7+46aNix+sX
         sPXobws7uDevV7ynmvC6FBJqKRKofgVX8euVM+Dnk7MR+RAYnu97XRJkGi0BotcpFJ5q
         hKtiqPf4T7rVJHvfcPTQvWtv8b5vTmzNcHvLoYeo1WAa0wZIYW4IavXc9e4Sisr4c1xc
         /sQp5cKRvRvi8Dwv53nN4VbZbDhqp8hYgbNZPHcstjqDr+3+/znOrX63g18LWseRDWkc
         JbbBvbBFTaTdR9INP0zGaSSAYm0Nn84S09TIxrArsKNKDnen2reBKOCldO37d7cIg2dd
         2aYg==
X-Gm-Message-State: AOAM532uhYPhX7gwfzWBo2OzWilF0wI02D08IUwOiMeOL9smeAENpFJM
        oKEV9Zv4JplFgoaXP43qO58=
X-Google-Smtp-Source: ABdhPJzdH1MBwJzpttQVBMb4esZr/4Vhf4S4Pd/z9vVV3kNPxCEiwrddhCkSjQksSRAWs7rpJosxvw==
X-Received: by 2002:a63:a4d:: with SMTP id z13mr1460508pgk.445.1628846116574;
        Fri, 13 Aug 2021 02:15:16 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.158])
        by smtp.gmail.com with ESMTPSA id p17sm1286968pjg.54.2021.08.13.02.15.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Aug 2021 02:15:16 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     git@vger.kernel.org, avarab@gmail.com, jonathantanmy@google.com
Subject: [PATCH v1 1/3] packfile-uri: http and https as default value of `--uri-protocol`
Date:   Fri, 13 Aug 2021 17:14:54 +0800
Message-Id: <0754ea6472f2665a5fe77de080434d3734c67259.1628845748.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.32.0.1.g0de8fe24d1.dirty
In-Reply-To: <cover.1628845748.git.dyroneteng@gmail.com>
References: <cover.1628845748.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

HTTP(S) is usually one of the most common protocols, using "http" and
"https" as the default parameter values of `--uri-protocol`, which can
simplify the use of packfile-uri feature on client side when run a
git-clone or git-fetch.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/pack-objects.c | 18 +++++++++++++++---
 fetch-pack.c           | 13 ++++++++-----
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index de00adbb9e..5f6db92a4c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3892,6 +3892,18 @@ static int option_parse_unpack_unreachable(const struct option *opt,
 	return 0;
 }
 
+static int option_parse_uri_protocol(const struct option *opt,
+				      const char *arg, int unset)
+{
+	if (!arg) {
+		string_list_append(&uri_protocols, "http");
+		string_list_append(&uri_protocols, "https");
+	} else {
+		string_list_append(&uri_protocols, arg);
+	}
+	return 0;
+}
+
 int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 {
 	int use_internal_rev_list = 0;
@@ -3995,9 +4007,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			 N_("do not pack objects in promisor packfiles")),
 		OPT_BOOL(0, "delta-islands", &use_delta_islands,
 			 N_("respect islands during delta compression")),
-		OPT_STRING_LIST(0, "uri-protocol", &uri_protocols,
-				N_("protocol"),
-				N_("exclude any configured uploadpack.blobpackfileuri with this protocol")),
+		OPT_CALLBACK_F(0, "uri-protocol", NULL, N_("protocol"),
+			       N_("exclude any configured uploadpack.blobpackfileuri with this protocol"),
+			       PARSE_OPT_OPTARG, option_parse_uri_protocol),
 		OPT_END(),
 	};
 
diff --git a/fetch-pack.c b/fetch-pack.c
index c135635e34..511a892d4c 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1755,11 +1755,14 @@ static void fetch_pack_config(void)
 	git_config_get_bool("transfer.fsckobjects", &transfer_fsck_objects);
 	git_config_get_bool("transfer.advertisesid", &advertise_sid);
 	if (!uri_protocols.nr) {
-		char *str;
-
-		if (!git_config_get_string("fetch.uriprotocols", &str) && str) {
-			string_list_split(&uri_protocols, str, ',', -1);
-			free(str);
+		const char *value;
+
+		if (!git_config_get_value("fetch.uriprotocols", &value)) {
+			if (!value || !strcmp(value, "")) {
+				string_list_append(&uri_protocols, "http");
+				string_list_append(&uri_protocols, "https");
+			} else
+				string_list_split(&uri_protocols, value, ',', -1);
 		}
 	}
 
-- 
2.32.0.1.g0de8fe24d1.dirty

