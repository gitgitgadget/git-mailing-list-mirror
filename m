Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECF6C433EF
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 17:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242693AbiBSRK1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 12:10:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbiBSRKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 12:10:25 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92673123422
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 09:10:05 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id f3so19562437wrh.7
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 09:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=wXyzuveFVd0hot7Ar7ocYhRbloOdoSeAs6T85yF0d08=;
        b=BYRcs29Zp+XiyxFQ1O7xvovJdK055mlOTybIuBr/Ktbw/dwSNa6qPoUbdVmG7yQQk5
         5sTU4p2GSi2uwjX9m9E2bP5+1Vvzue0xUCuk1srRvh4IENUI7zbf+a1gORmj0MrL1S8U
         87XI5st6KlCnGPISxl4iM7G2zd+DS+nTln88K/itvmGBd2q7viOGNzCtclzHu/eCAV2c
         rQqJI9e7OOtJcu5Nl16eXB4XXgr70Aj5w+rnDh0+sSdg4L7eqjg8twTBqnifBkfRluGD
         qcX1TSXyW8vXvbl60qUozd761Anu902frVa5yyFB9Pg9XY5TTGiuZA6fpLl8i6P7eYeP
         1dbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=wXyzuveFVd0hot7Ar7ocYhRbloOdoSeAs6T85yF0d08=;
        b=GBX0s1Czib8Ml2t5a/IsHoX5BxdgDGwYiF1HdIHu65tdY8s6uJvPT9EtZRhwnpZCrk
         vnRGCOxDnv4yz0tNEImYqoY7aLzRM1FTBqa6hXIuE95be68tT4ORs0zJH5HMabNSYjuX
         mehifpSam040PLIr9k/Q8OuJtwF/lO5bL29ICFDKw7Au0uca2rPeIlKMRGw4bKyE25jX
         Z/GgeTsjeTCt/xkGLht1hxz1j4V6WXvRmG3uInPIhbR2UZ3oo++cAY92NqXvGHJBQQjY
         +aI1bBhyKLYIUfDXEiIzCGbq7b3sy7LGnC/eB6ZlmbsNFO2VkD6kqYR/OtEs6TmIOB2r
         Q5DA==
X-Gm-Message-State: AOAM532CqsmBdxTsyONWqeXB9uUY7eVOBnh+aFvz+isAb3xAwX0naHv3
        6s09DX2skmBqnch3J3uwLTeQVRSrECU=
X-Google-Smtp-Source: ABdhPJyWiB/d4b0pAFQjLqCAdtNzY/XmYU7F+6TwooPK7SAu0izRGfK47i4htbrK7kn915tRkbJJXA==
X-Received: by 2002:adf:fe06:0:b0:1e5:95ad:b6bc with SMTP id n6-20020adffe06000000b001e595adb6bcmr9666359wrr.191.1645290603933;
        Sat, 19 Feb 2022 09:10:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 3sm43453168wrz.86.2022.02.19.09.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 09:10:03 -0800 (PST)
Message-Id: <f0308de28e49fb9bb1239fdcbc839097f5afa62a.1645290601.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.git.1645290601.gitgitgadget@gmail.com>
References: <pull.1152.git.1645290601.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 19 Feb 2022 17:09:59 +0000
Subject: [PATCH 1/2] merge-ort: fix small memory leak in
 detect_and_process_renames()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

detect_and_process_renames() detects renames on both sides of history
and then combines these into a single diff_queue_struct.  The combined
diff_queue_struct needs to be able to hold the renames found on either
side, and since it knows the (maximum) size it needs, it pre-emptively
grows the array to the appropriate size:

	ALLOC_GROW(combined.queue,
		   renames->pairs[1].nr + renames->pairs[2].nr,
		   combined.alloc);

It then collects the items from each side:

	collect_renames(opt, &combined, MERGE_SIDE1, ...)
	collect_renames(opt, &combined, MERGE_SIDE2, ...)

Note, though, that collect_renames() sometimes determines that some
pairs are unnecessary and does not include them in the combined array.
When it is done, detect_and_process_renames() frees this memory:

	if (combined.nr) {
                ...
		free(combined.queue);
        }

The problem is that sometimes even when there are pairs, none of them are
necessary.  Instead of checking combined.nr, we should check
combined.alloc.  Doing so fixes the following memory leak, as reported
by valgrind:

==PID== 192 bytes in 1 blocks are definitely lost in loss record 107 of 134
==PID==    at 0xADDRESS: malloc
==PID==    by 0xADDRESS: realloc
==PID==    by 0xADDRESS: xrealloc (wrapper.c:126)
==PID==    by 0xADDRESS: detect_and_process_renames (merge-ort.c:3134)
==PID==    by 0xADDRESS: merge_ort_nonrecursive_internal (merge-ort.c:4610)
==PID==    by 0xADDRESS: merge_ort_internal (merge-ort.c:4709)
==PID==    by 0xADDRESS: merge_incore_recursive (merge-ort.c:4760)
==PID==    by 0xADDRESS: merge_ort_recursive (merge-ort-wrappers.c:57)
==PID==    by 0xADDRESS: try_merge_strategy (merge.c:753)
==PID==    by 0xADDRESS: cmd_merge (merge.c:1676)
==PID==    by 0xADDRESS: run_builtin (git.c:461)
==PID==    by 0xADDRESS: handle_builtin (git.c:713)
==PID==    by 0xADDRESS: run_argv (git.c:780)
==PID==    by 0xADDRESS: cmd_main (git.c:911)
==PID==    by 0xADDRESS: main (common-main.c:52)

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index d85b1cd99e9..4f5abc558c5 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3175,7 +3175,7 @@ simple_cleanup:
 		free(renames->pairs[s].queue);
 		DIFF_QUEUE_CLEAR(&renames->pairs[s]);
 	}
-	if (combined.nr) {
+	if (combined.alloc) {
 		int i;
 		for (i = 0; i < combined.nr; i++)
 			pool_diff_free_filepair(&opt->priv->pool,
-- 
gitgitgadget

