Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D610C5ACD6
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 14:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0419F20774
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 14:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJNs2UOO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgCROWD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 10:22:03 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42789 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgCROWC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 10:22:02 -0400
Received: by mail-pl1-f196.google.com with SMTP id t3so11244675plz.9
        for <git@vger.kernel.org>; Wed, 18 Mar 2020 07:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cnd6Z7i0upgzHfOo7Qn+M47oUSHtXohKw20e6+5TQUs=;
        b=BJNs2UOOt/qLn2UW0h+IqaCn2B1yn83HOgTAroQTlaM8/5kmUSoen+ybUPRDdZ39C7
         HuNLDr6EEK16/D0UXKZVD5GGLCczw/jSq09y/IhHGDCBFCPaF3VeLhvBPL25CsFOyqOM
         MTaXlI3vh1l+3E3cPI8LwH3eaIH6QKqGR7NJXtw7IRQsTa9jP2OdQQTI3yRpwWhAsYIW
         4Q3RPX3rPJKTCxM4ge5rznzl4ns9sBFaxWgVVgMGXkvpzQwdz6yOXQIb60UXTX3+zzrq
         g30M3DUnyGtPic+YgxhgyCL3WesNAWp1x9SgOoRlhvLdbnXrel5pkWBTJi2a6O24/tL6
         WoRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cnd6Z7i0upgzHfOo7Qn+M47oUSHtXohKw20e6+5TQUs=;
        b=X3jUm6kll/REj7zx74NqDhvWnkyxMDN0rIVWKr+A2vFCcaI/9egDbpQjLJpLL/W/LD
         Kndw8SV9iTBUeY/YT+C6vsbX+WOw6qtZeLK4h0TaJu12gPI0p4CDXGJqfKpy1/31y8Y5
         1krPr1eeyZitbHHHTKcwIujbSIsAJF+eyklBkQCauxF2JPQzpKfUI4xDWVHdhCp9SuRV
         4ZKNEgRcuKL+8k4zIe5pz3p0K+8ac+vCTSygJnre58EFApgvnPKQ25r874x9efdbp8I1
         IxCzyT6M8buePz+zmQBZgCZiH/x+g4F53BJbBbvDXfF+HpMObqhUF8flEpHi3oM4xRg8
         dg3A==
X-Gm-Message-State: ANhLgQ2CfOxwml5ZMRNB/Ogr0YtQ/Mer8qgkxhWRc6PL0A4kulE/s3bb
        mzhw6BO0N09PBW8/njpV0tZE6RVjuy7VTg==
X-Google-Smtp-Source: ADFU+vtckw0kVo3x/Z2gxU/4BkPo3F1Z++bqqXrGkTDfgqFqnyZMoML/H3DkTScZcxxPv/gwd28Liw==
X-Received: by 2002:a17:902:8492:: with SMTP id c18mr4254403plo.147.1584541321028;
        Wed, 18 Mar 2020 07:22:01 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.173])
        by smtp.gmail.com with ESMTPSA id q123sm4004948pfb.54.2020.03.18.07.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 07:22:00 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v2 1/1] submodule--helper.c: Rename 'cb_foreach' to 'foreach_cb'
Date:   Wed, 18 Mar 2020 19:50:24 +0530
Message-Id: <20200318142024.16681-2-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318142024.16681-1-shouryashukla.oo@gmail.com>
References: <20200318095842.27679-1-shouryashukla.oo@gmail.com>
 <20200318142024.16681-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 'submodule--helper.c', the structures and macros for callbacks belonging
to any subcommand are named in the format: 'subcommand_cb' and 'SUBCOMMAND_CB_INIT'
respectively.

This was an exception for the subcommand 'foreach' of the command
'submodule'. Rename the aforementioned structures and macros:
'struct cb_foreach' to 'struct foreach_cb' and 'CB_FOREACH_INIT'
to 'FOREACH_CB_INIT'.

Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 builtin/submodule--helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 86a608eec1..1a4b391c88 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -444,19 +444,19 @@ static void for_each_listed_submodule(const struct module_list *list,
 		fn(list->entries[i], cb_data);
 }
 
-struct cb_foreach {
+struct foreach_cb {
 	int argc;
 	const char **argv;
 	const char *prefix;
 	int quiet;
 	int recursive;
 };
-#define CB_FOREACH_INIT { 0 }
+#define FOREACH_CB_INIT { 0 }
 
 static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 				       void *cb_data)
 {
-	struct cb_foreach *info = cb_data;
+	struct foreach_cb *info = cb_data;
 	const char *path = list_item->name;
 	const struct object_id *ce_oid = &list_item->oid;
 
@@ -557,7 +557,7 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 
 static int module_foreach(int argc, const char **argv, const char *prefix)
 {
-	struct cb_foreach info = CB_FOREACH_INIT;
+	struct foreach_cb info = FOREACH_CB_INIT;
 	struct pathspec pathspec;
 	struct module_list list = MODULE_LIST_INIT;
 
-- 
2.20.1

