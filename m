Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4E6C433E2
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 12:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E7AF20771
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 12:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5VFNz/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732694AbgFWMsM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 08:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732681AbgFWMsK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 08:48:10 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CDBC061795
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 05:48:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r12so3069211wrj.13
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 05:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cb0PLLSdpbYlVTVIBARrXXA64sdU5+pjSUpxpo19Mf0=;
        b=T5VFNz/iBTuS8YSQXIk3RzcpUOne+3vdH4w1rhsm8g5LZnemcdFyqcm4lKjz0aoCNq
         eG3wlAdsN+V2MUjAwhQjG5aC4tv8SQMFTGEHfL6W3RpkDg7HgfWvvZTjx1xLHsHLyQAi
         PZ9OhkhOQe9+5AlZOuAwIF93rLTgYZa83kweTRZUvDLZL64sFoQp3O6qyjz8OITtJXDS
         xoS512VWa+OUiaWxZDVkfilDakdDJb6Uy9/vW0mFLakceDWsXS2la024qxMAqPdiNkQx
         UaEO4W0Lso4Z+pBdR2nZep38LWsBvQFNqKFRIrTo+J2HfDkw0JLPa5OydhVgoJuAmU0r
         ye2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cb0PLLSdpbYlVTVIBARrXXA64sdU5+pjSUpxpo19Mf0=;
        b=iLG71iQrZ87GcSSJpSOmRV9aKrppMHGjsApdY5x2+l+83UG98DApcEyc9VehbgwKRC
         8MryLvoXF24lnxjnuYkVhuDwpRi4dSGY56XsSpgblcuQsaXx36s6BlxdLmP51ttDK8QS
         Gm+bwPUj8X7KWozgZdJsedzQNiy8w+QcWIzuJtkvj/kv7aOizHFuRMfQ/2AaUebMD3XK
         L0aQ2MF4nA0/GL1g021UWykSL3saxSmIfezhRqP0UR0ZhcbWi2l+2ZmaffVhtmwWoUez
         jsW7QHDa5giJCHa1XRh5t4SIWhmO/77K5s57CE5b2m8nBVR25F45fSRplU5qi657R78V
         oFtA==
X-Gm-Message-State: AOAM531Zs3Oc17kpUbyDD+BtH3pPbvtD+j2a5xJIxG5ZgeHEImoQXepC
        vUET/uO1U+5+7BiIVtl2pgCUanaf
X-Google-Smtp-Source: ABdhPJx9oQXB8pWCJv4/TUu67nWOpZSQ8AEvIlImsGurwUWMSn01ceAgzHslcWlI/HZ+NTbDZJpOZQ==
X-Received: by 2002:a5d:67c8:: with SMTP id n8mr12363920wrw.211.1592916488955;
        Tue, 23 Jun 2020 05:48:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k185sm381429wmk.47.2020.06.23.05.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 05:48:08 -0700 (PDT)
Message-Id: <b9633315a2f09a56a46259a8540f458747250d6f.1592916485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.654.v2.git.1592916485.gitgitgadget@gmail.com>
References: <pull.654.git.1591879139.gitgitgadget@gmail.com>
        <pull.654.v2.git.1592916485.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Jun 2020 12:48:04 +0000
Subject: [PATCH v2 2/3] diff-files: fix incorrect usage of an empty tree
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In c26022ea8f5 (diff: convert diff_addremove to struct object_id,
2017-05-30), the OID to use for intent-to-add files was inadvertently
changed from the empty blob to the empty tree.

Let's revert that.

To be able to do that, we just taught the regression test introduced in
feea6946a5b (diff-files: treat "i-t-a" files as "not-in-index",
2020-06-20) to _not_ expect the raw diff to contain the hash of the
empty tree (we also had to fix the code to actually produce the expected
output, but for the sake of this here patch, that's beside the point).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff-lib.c b/diff-lib.c
index ea23169afa2..7aafd7cc376 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -234,7 +234,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			} else if (revs->diffopt.ita_invisible_in_index &&
 				   ce_intent_to_add(ce)) {
 				diff_addremove(&revs->diffopt, '+', ce->ce_mode,
-					       the_hash_algo->empty_tree, 0,
+					       the_hash_algo->empty_blob, 0,
 					       ce->name, 0);
 				continue;
 			}
-- 
gitgitgadget

