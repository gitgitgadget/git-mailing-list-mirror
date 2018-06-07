Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09F831F403
	for <e@80x24.org>; Thu,  7 Jun 2018 14:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932885AbeFGOEO (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 10:04:14 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45679 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932862AbeFGOEL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 10:04:11 -0400
Received: by mail-qt0-f193.google.com with SMTP id i18-v6so9913603qtp.12
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 07:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OaWmlz491gnrw4jbGr2enw7HRZYNn8em5YaniKTglVQ=;
        b=aDJnkZ6yH4MbPANjiiARDzlgCJh+ojmcyORQ5ohUZadDquEum/zKmbHdHI4ooDvvhE
         nvTIF8Bw5ccgOHcWqpWXQeth2D1VAe0T9o8YUnco9hcdpvmiEDYXxdvoHKou7FWBazDU
         T6SU9vnQ+2A40IgHUTyNd6DXDMncCnsz7YHKM48nnWzPRxdYZ8eSXFjYEVYHZaawo3rR
         5SCstR9VXuP7K0J9ELjQBWi7NhfIf/QAjJCEERKui6z++7Vq3vi4ZOvdPneB8XdKjpGx
         4dukR1i9cMXQ0ebfeZRoLTO8M+lXxKBjyx2V8m9Rmqs0HCDU/6dUhGZDjHj2VSkl5AzZ
         vujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OaWmlz491gnrw4jbGr2enw7HRZYNn8em5YaniKTglVQ=;
        b=b7Ncqh9gEl+Vw10UGPiDndRvo/1Li4jhWTeM3pIP0HaFyfO6T0f+qm8oTUxjZlBIWN
         inOAf9HctU0+vmYSlrLN1t1u6i1N7MZJ70Ct2hKqZq2vshATnFBO6+ANzUDzl0Wvrcmb
         vfBOA6bms0Ie+WpoMLhJi0SBc97/syN+hdREHH13ktJScs7ieTdJy29aEf75HSlY+Fq0
         R3snM5rLDgfKzkjW/4z8OzJn7aVfsRZQanJRlvnF5P6uqzaVlb1WnWzTJ/88IRTL/4X6
         TLdAIckp9ra4G4bxvDOLYkR4fBtGO8HorrbxCP4QDz1VQ0U25dkW/n/6bozY+QQRo6hq
         EsMA==
X-Gm-Message-State: APt69E33VHCMoALzEQir6/Cj1Rl8IOp8UH/vpqaos0AL4Mc9PJ6Goy8Z
        QtQsKGpvCyIR++5zvRjy0LlL9qwc
X-Google-Smtp-Source: ADUXVKL9DbJ98muWuZszCIUCpxujMlXwAbNTZ/cDZjLD7BQ/GkHaiAHY5tQrXfQZynMMcKmFHnNdHQ==
X-Received: by 2002:a0c:f905:: with SMTP id v5-v6mr1717196qvn.207.1528380250357;
        Thu, 07 Jun 2018 07:04:10 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u74-v6sm12532763qku.55.2018.06.07.07.04.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 07:04:09 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, dstolee@microsoft.com, avarab@gmail.com,
        jrnieder@gmail.com, jonathantanmy@google.com, mfick@codeaurora.org
Subject: [PATCH 23/23] midx: clear midx on repack
Date:   Thu,  7 Jun 2018 10:03:38 -0400
Message-Id: <20180607140338.32440-24-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180607140338.32440-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a 'git repack' command replaces existing packfiles, then we must
clear the existing multi-pack-index before moving the packfiles it
references.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/repack.c | 8 ++++++++
 midx.c           | 8 ++++++++
 midx.h           | 1 +
 3 files changed, 17 insertions(+)

diff --git a/builtin/repack.c b/builtin/repack.c
index 6c636e159e..66a7d8e8ea 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -8,6 +8,7 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "argv-array.h"
+#include "midx.h"
 
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
@@ -174,6 +175,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	int no_update_server_info = 0;
 	int quiet = 0;
 	int local = 0;
+	int midx_cleared = 0;
 
 	struct option builtin_repack_options[] = {
 		OPT_BIT('a', NULL, &pack_everything,
@@ -340,6 +342,12 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 
+			if (!midx_cleared) {
+				/* if we move a packfile, it will invalidated the midx */
+				clear_midx_file(get_object_directory());
+				midx_cleared = 1;
+			}
+
 			fname_old = mkpathdup("%s/old-%s%s", packdir,
 						item->string, exts[ext].name);
 			if (file_exists(fname_old))
diff --git a/midx.c b/midx.c
index e46f392fa4..1043c01fa7 100644
--- a/midx.c
+++ b/midx.c
@@ -913,3 +913,11 @@ int write_midx_file(const char *object_dir)
 	FREE_AND_NULL(pack_names);
 	return 0;
 }
+
+void clear_midx_file(const char *object_dir)
+{
+	char *midx = get_midx_filename(object_dir);
+
+	if (remove_path(midx))
+		die(_("failed to clear multi-pack-index at %s"), midx);
+}
diff --git a/midx.h b/midx.h
index 6996b5ff6b..46f9f44c94 100644
--- a/midx.h
+++ b/midx.h
@@ -18,5 +18,6 @@ int midx_contains_pack(struct midxed_git *m, const char *idx_name);
 int prepare_midxed_git_one(struct repository *r, const char *object_dir);
 
 int write_midx_file(const char *object_dir);
+void clear_midx_file(const char *object_dir);
 
 #endif
-- 
2.18.0.rc1

