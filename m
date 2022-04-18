Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0419CC433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344684AbiDRRQM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243486AbiDRRQK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:16:10 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760302252F
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:13:30 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id p18so18429804wru.5
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=rrvhWjlewgdS14yyEftGPUfXKps6z5d8Yih9sdsPAsY=;
        b=graxgFdpdOg9fFf9GElCDQh0GWlk2SgzTqrwyhjcDvZZi5PfrGSU+6m7c1tZW5Ho3f
         yVqYIonkiPVSP9P4pVEQX4NAgUKBsh8VFaXFqB5j7Rhf9wcaqWsHA7VG7As2fSTvE9wT
         ylQuV2qFQD5CA7U/HFTeVGcHJjYdcas5KpbMTDgnUZITcPtOhKA6Q9QhjIK6OymngLGl
         L4/3LWFCgfqvMqKceTmaZUhJW0m45cs9+l6KoVrMTIHe2AjZkIIwlN6x0kqBo6PzRNGS
         QVGadFAN46BlxUai/iOdnIZao9DeJBUqiRepuXwzmqBPXbRsc0dG4EJYzggq8qsk0/PV
         j/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=rrvhWjlewgdS14yyEftGPUfXKps6z5d8Yih9sdsPAsY=;
        b=g5SA+GqoBOA040f0bwL/JwcdbYgOf7i515I5Z79tjDZJGg0jrRx+b/3J2kSp0wB6FQ
         wlWs3aAr+CL0aulyKAWlm968k/Pw+b6oEa1PKRT1o0GIdwUHd2Wf8fcNmFm3FW8857tJ
         ndQ7EiEhZ6H/FGTJw7lHslkthVt211Sy3r9KgFpt7vtwtAeGvhJQvV/hOmXtiH/kXznh
         cXVsLVCXQXE0MU8xYgT0mCtQBQwBwLsJ/0ij4a9SoRqpNggG1e1IY1UEOFVYiA7GHVQS
         OCoM4g7diNba8tWMlHJflULNcFNkX1izk+nWrASNUBLn1Qtjgy95Sva1heCqcEJHX9fI
         Dw5Q==
X-Gm-Message-State: AOAM533FC11jA/64yMjnABfNVCe03IMKdJQrFANsSbVLHdejU/Vau2w4
        2IrYQrtLUKAfiCXc7HQ93DnvjHYRi1I=
X-Google-Smtp-Source: ABdhPJyEdoaOy662kzgHJtfjD+MUYvNyMBkdclnL+dNUzPi2fln2zrRvgiRoTJ3F0KoJKoR3hiHnLw==
X-Received: by 2002:a05:6000:1c16:b0:207:bc18:d0c2 with SMTP id ba22-20020a0560001c1600b00207bc18d0c2mr8736889wrb.533.1650302008605;
        Mon, 18 Apr 2022 10:13:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i11-20020a5d584b000000b0020a8d859e5fsm4919592wrf.10.2022.04.18.10.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:13:28 -0700 (PDT)
Message-Id: <pull.1213.git.1650302007395.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 18 Apr 2022 17:13:27 +0000
Subject: [PATCH] commit-graph: close file before returning NULL
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?Kleber=20Tarc=C3=ADsio?= <klebertarcisio@yahoo.com.br>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Kleber=20Tarc=C3=ADsio?= <klebertarcisio@yahoo.com.br>

There are two reasons that we could return NULL early within
load_commit_graph_chain():

 1. The file does not exist, so the file pointer is NULL.
 2. The file exists, but is too small to contain a single hash.

These were grouped together when the function was first written in
5c84b3396 (commit-graph: load commit-graph chains, 2019-06-18) in order
to simplify how the 'chain_name' string is freed. However, the current
code leaves a narrow window where the file pointer is not closed when
the file exists, but is rejected for being too small.

Split out these cases separately to ensure we close the file in this
case.

Signed-off-by: Kleber Tarcísio <klebertarcisio@yahoo.com.br>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
    commit-graph: close file before returning NULL
    
    This change was originally submitted to the microsoft/git fork [1].
    Kleber discovered this issue using some automated tool they are working
    on. We recommended that this change be submitted to the core Git group,
    but we have not had any word from the original author in some time.
    Hence, I am submitting it on their behalf.
    
    [1] https://github.com/microsoft/git/pull/259
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1213%2Fderrickstolee%2Fclose-file-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1213/derrickstolee/close-file-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1213

 commit-graph.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 441b36016ba..06107beedcb 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -523,10 +523,13 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r,
 	stat_res = stat(chain_name, &st);
 	free(chain_name);
 
-	if (!fp ||
-	    stat_res ||
-	    st.st_size <= the_hash_algo->hexsz)
+	if (!fp)
 		return NULL;
+	if (stat_res ||
+	    st.st_size <= the_hash_algo->hexsz) {
+		fclose(fp);
+		return NULL;
+	}
 
 	count = st.st_size / (the_hash_algo->hexsz + 1);
 	CALLOC_ARRAY(oids, count);

base-commit: ab1f2765f78e75ee51dface57e1071b3b7f42b09
-- 
gitgitgadget
