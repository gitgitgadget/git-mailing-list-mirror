Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF809C433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 16:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243651AbiA0QXN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 11:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243622AbiA0QXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 11:23:09 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E15C06173B
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 08:23:08 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c192so2314786wma.4
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 08:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BAETt61/rXj9abAjf8MzrmJN3IQi5ZHrn+x2pIH9/VI=;
        b=Qem0fB1UjwOTBVQViNi4eY6HgD7ZTqt9DshpupXFmCIYiK3In1ih1fgtIo1M83zb3X
         SOSX2xdTPSeCF8P21VQTT+i/cdVmf6zf+9JU+JgdhgwgmG2tmisgU758j4zfj2xRXxcw
         eOyOKGNZeMpajOqCXqehBJYBrAJ2icxIA5CkqbZs52MoF9tQKWP8PO+ctREkyzgEQYDs
         GHLGgJ2GFjZPLrBnKZgWdypXJ1KnvA2jJ6T7+kMjpDWNW893mm6ecctNUKmd/6RoSZnv
         9hClZoPiYO2NZOVEk3v6yScQ2t7QiAOAUP9jHe0FgT12T+QG9VyOiL+tWWs5VUzGx28G
         GUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BAETt61/rXj9abAjf8MzrmJN3IQi5ZHrn+x2pIH9/VI=;
        b=Sg+JBzHmUW+Xsqk9Hue/6AlvytZzsgGvCyG29EDm51Ov5HMb/Ksscecej5Ci2hfnJ7
         fnRx9BJcqncR6n3AwmZ9S+i1qiwq2xt4495r160+0u+jII65b3tFMcbfE0CJM19QLcov
         lDydVE8NEMemqg1PiNseYLK2HmDa39LELfRsdtOrLAzXDXpB+1DVt5TCvnAN469PLTz1
         f5KmHAuWymDwdUpy0ftGI94LO6SBjJpFfL3FE1g9zSB4iOSe3cc85kbwn8W7iiSoKUsg
         AZdwE51y/2cTH6IeGQgp3hYJ+2ogajs6Dkj3u4Ew6G2+WTHu49NYbO6MeCvNvKUBkZOi
         Ndzw==
X-Gm-Message-State: AOAM531095K0FvV80cj88Bew+yS6gdoWPWjbsJm2e2+INF20EPeVFCOR
        rGH3UZq5MaonUz0kcS3eFZdw4pV05qYFyQ==
X-Google-Smtp-Source: ABdhPJyR5xqXlfm501Bus4Raegc5TbBZ0BTG2VeG4+3NCCdVnhsxlvdSF7Hfx+v/E12OwCM2vYiMGg==
X-Received: by 2002:a7b:c44e:: with SMTP id l14mr3889151wmi.185.1643300587271;
        Thu, 27 Jan 2022 08:23:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f13sm3257186wry.77.2022.01.27.08.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 08:23:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        Glen Choo <chooglen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 5/7] builtin/submodule--helper.c: reformat designated initializers
Date:   Thu, 27 Jan 2022 17:22:54 +0100
Message-Id: <patch-v4-5.7-29aa2fc0851-20220127T143552Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.894.g563b84683b9
In-Reply-To: <cover-v4-0.7-00000000000-20220127T143552Z-avarab@gmail.com>
References: <20211013051805.45662-1-raykar.ath@gmail.com> <cover-v4-0.7-00000000000-20220127T143552Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Atharva Raykar <raykar.ath@gmail.com>

The second hunk here will make a subsequent commit's diff smaller, and
let's do the first and third hunks while we're at it so that we
consistently format all of these.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 328c6cc87cd..1553b318cc7 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1656,7 +1656,10 @@ struct module_clone_data {
 	unsigned int require_init: 1;
 	int single_branch;
 };
-#define MODULE_CLONE_DATA_INIT { .reference = STRING_LIST_INIT_NODUP, .single_branch = -1 }
+#define MODULE_CLONE_DATA_INIT { \
+	.reference = STRING_LIST_INIT_NODUP, \
+	.single_branch = -1, \
+}
 
 struct submodule_alternate_setup {
 	const char *submodule_name;
@@ -2049,7 +2052,9 @@ struct update_data {
 	unsigned int nofetch: 1;
 	unsigned int just_cloned: 1;
 };
-#define UPDATE_DATA_INIT { .update_strategy = SUBMODULE_UPDATE_STRATEGY_INIT }
+#define UPDATE_DATA_INIT { \
+	.update_strategy = SUBMODULE_UPDATE_STRATEGY_INIT, \
+}
 
 static void next_submodule_warn_missing(struct submodule_update_clone *suc,
 		struct strbuf *out, const char *displaypath)
@@ -3015,7 +3020,9 @@ struct add_data {
 	unsigned int progress: 1;
 	unsigned int dissociate: 1;
 };
-#define ADD_DATA_INIT { .depth = -1 }
+#define ADD_DATA_INIT { \
+	.depth = -1, \
+}
 
 static void append_fetch_remotes(struct strbuf *msg, const char *git_dir_path)
 {
-- 
2.35.0.894.g563b84683b9

