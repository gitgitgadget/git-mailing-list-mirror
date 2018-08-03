Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-10.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,UNWANTED_LANGUAGE_BODY,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C6581F597
	for <e@80x24.org>; Fri,  3 Aug 2018 22:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732120AbeHDAW1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 20:22:27 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:35545 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731816AbeHDAW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 20:22:27 -0400
Received: by mail-qk0-f201.google.com with SMTP id w14-v6so6708406qkw.2
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 15:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=zGjogUTePHoadC9aPjI+MtDF4INiP6pbtwG4dKMvh90=;
        b=a4BFT7Whj1oNmEr825IE4d48XGI0SSk5P86CXv8dZiATYeHO2pmXpiZhnS9S0zyduQ
         F4Pn60urrQ/IhoYWaW/faRYCSj4kJpJI9RanYHHf/qaO6wM5vKAuwyxViHPZlcE7n14q
         v5QgHjF0cKGMU8erEETi2jL1QnBHkOVSfJVnsxSlrLFDvy0H+RLNeM/zcFufFRWlcsaT
         3xFnUxN6HhHdaL/WGyCG1KhaPfowOBHdmRBd4MiP8iqT2azb/oNNvJAtQHnwmsBRK5eM
         dE+H1vsitRrg4v1iTW908gpqbsFfUj120ga7bBsyYCWUxA6qFeiGRrR4q2ViWZLZcqgp
         d/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=zGjogUTePHoadC9aPjI+MtDF4INiP6pbtwG4dKMvh90=;
        b=OEDs9ZTJn12M3nWQKvUKNO27N9qvw47oNrLxmPfN0n1IbNnKFL0XGzLPPC3sA1a3iH
         wK36yQMyjfW9rUtw/Cq0L9f/HjljHuhcI+4VpAGNDbkIUT6o1aaEi+8apwfCjPeVmXGV
         dBtnoCOKmELeNBdmLSanFcRuxwxQ/2gDQgmI1RhI7YrI/A4hwZvn2UMm2oARVCB5AWkF
         TVDuRjwVGLr2WC/Y7qjnJ3nkqEiIpf4D5kN7W3ARcqmnSdJGPdxumQlCZiDq3uv6vBMm
         6jZDdyYAnKveNrtx4h3K4R0fQQbV1YptQZlOOCKTx4GGwlThIYAIQX0o7FD8Osxh5xHQ
         VZzQ==
X-Gm-Message-State: AOUpUlHo7JveyhLwDqSHU4me/ZhIFq8UTBROLAYKhCxZD0qaSIHd1Qbr
        8nmhMLVnpTpgJC2BrwCkBUiNAmAkDs2iAZ6AOCX6z6wXVRPV11gqW7xgg/2javh23EwjcN2C3ZF
        JIwnDeCaznt7nmCWwj0SudVYQzBuNPMKxxQpZgh1H43tLVXkLvWzw9+0lIkTe
X-Google-Smtp-Source: AAOMgpfMjUmnKFofAbFrQ7CwbVLK4x3HekrILxxaxoh2Axasi09Bfsp2DmN6YWFPZcBjKaE9xI3611WgPrv1
MIME-Version: 1.0
X-Received: by 2002:a0c:f848:: with SMTP id g8-v6mr4842615qvo.11.1533335053911;
 Fri, 03 Aug 2018 15:24:13 -0700 (PDT)
Date:   Fri,  3 Aug 2018 15:23:20 -0700
In-Reply-To: <20180803222322.261813-1-sbeller@google.com>
Message-Id: <20180803222322.261813-6-sbeller@google.com>
References: <20180803222322.261813-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.132.g195c49a2227
Subject: [PATCH 5/7] builtin/submodule--helper: factor out method to update a
 single submodule
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch we'll find this method handy.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 40b94dd622e..8b1088ab58a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1727,10 +1727,17 @@ static int git_update_clone_config(const char *var, const char *value,
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
@@ -1749,16 +1756,9 @@ static int update_submodules(struct submodule_update_clone *suc)
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
2.18.0.132.g195c49a2227

