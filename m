Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-10.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,UNWANTED_LANGUAGE_BODY,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E86B1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 19:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbeGRU2h (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 16:28:37 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:51608 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbeGRU2h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 16:28:37 -0400
Received: by mail-ua0-f202.google.com with SMTP id m26-v6so1937861uaq.18
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 12:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Y1X4WjuumEShCamFXuuVDePcAAwPIvTeturUQ95JZZk=;
        b=isuD/LmfnaWYC2XToZhyLP6XJu0rdfzkujWd5f0n1E/CXzik1uwy9jFDtBCtTiJeRZ
         qcDBgCLnzWfNkC9mdhx8OyWyyjyYB7VQ31bQIF8wivIXrD3eSO765NUaLu+xsCWgAcIf
         If3FPKEAvhgS2kDSXJnZ1JQZd6WHlSzEcrQdKzfO9OvKDajs+KSBl6NEBtp/7yAvyD+9
         XcHKz99Q2NDPp3wdUWuxNVb3qSjhEawLOloqFv+23p5ee04fysxFJtimfubg2BDThMkj
         OOT/4OR2H3t/dIFE3lmhO4hX7VQHC4tk9L/xaem4wO5bsz5MZPRQSJrGpPsyTsJESiNL
         iDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Y1X4WjuumEShCamFXuuVDePcAAwPIvTeturUQ95JZZk=;
        b=fpJq3EnDyaAspIFu1mfC3dxHk/JZXT4HnjvB9D87UOvmcna2F3X+70ZWSouwQ7IIqp
         YENbvAmgtBpDKGty4YfV1WSYTxZnbb69BMEiWGvRJp/sOaC1zt4DiT+4yLa2QQhrT447
         QWbszyNpdfDCj8ggOIqAE1LncVdrasCDzsbeYn9l9NALXznzYA/bhWWEICHwym+QcdFS
         tffB8CDhmizP3tNr5NiLI5LvBPZPCoN1HaonMOGCDJks8Z8wHfCJIYtk/dATM6XCYCUY
         jossiR1PU0dMhEsO4nThXgLSStbqkIVIKqOxvwQgdjPlDvmLVwSseyLziKjhTA14Wxer
         8zNg==
X-Gm-Message-State: AOUpUlGxei9n2gM/t5zAIez62jbig4LIrr5Nv+oFVYVcDyq2yRnWWtqo
        aHQ7RCIf5zCHuYEA5b85kj0Zb7wrxHBI0pam4YOf54LaUYYKh/iLIQbshkO54OEGf5tTXWUOhnW
        rnHvuLO3l+EARmLN4x/Wrumwkj1DHooxfG36Mzt1FOjnsLz9yzZH7GNqrmyP5
X-Google-Smtp-Source: AAOMgpfK+HfVlez7v+2UvQNye9f2dvWAAnGETYqKWzZTf3Gd9EuNqABpLxk9nyNs0K1QddXP+uy/4rpZUUzo
MIME-Version: 1.0
X-Received: by 2002:a1f:308c:: with SMTP id w134-v6mr3285288vkw.94.1531943353263;
 Wed, 18 Jul 2018 12:49:13 -0700 (PDT)
Date:   Wed, 18 Jul 2018 12:48:52 -0700
In-Reply-To: <20180718194853.57994-1-sbeller@google.com>
Message-Id: <20180718194853.57994-6-sbeller@google.com>
References: <20180718194853.57994-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH 5/6] builtin/submodule--helper: factor out method to update a
 single submodule
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, szeder.dev@gmail.com, stolee@gmail.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch we'll find this method handy.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index fb54936efc7..034ba1bb2e0 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1725,10 +1725,17 @@ static int gitmodules_update_clone_config(const char *var, const char *value,
 	return 0;
 }
 
+static void update_submodule(struct update_clone_data *ucd)
+{
+	fprintf(stdout, "dummy %s %d\t%s\n",
+		oid_to_hex(&ucd->oid),
+		ucd->just_cloned,
+		ucd->sub->path);
+}
+
 static int update_submodules(struct submodule_update_clone *suc)
 {
 	int i;
-	struct strbuf sb = STRBUF_INIT;
 
 	run_processes_parallel(suc->max_jobs,
 			       update_clone_get_next_task,
@@ -1747,16 +1754,9 @@ static int update_submodules(struct submodule_update_clone *suc)
 	if (suc->quickstop)
 		return 1;
 
-	for (i = 0; i < suc->update_clone_nr; i++) {
-		strbuf_addf(&sb, "dummy %s %d\t%s\n",
-			oid_to_hex(&suc->update_clone[i].oid),
-			suc->update_clone[i].just_cloned,
-			suc->update_clone[i].sub->path);
-		fprintf(stdout, "%s", sb.buf);
-		strbuf_reset(&sb);
-	}
+	for (i = 0; i < suc->update_clone_nr; i++)
+		update_submodule(&suc->update_clone[i]);
 
-	strbuf_release(&sb);
 	return 0;
 }
 
-- 
2.18.0.233.g985f88cf7e-goog

