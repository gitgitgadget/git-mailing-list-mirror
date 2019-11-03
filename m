Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6471D1F454
	for <e@80x24.org>; Sun,  3 Nov 2019 00:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfKCAWD (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 20:22:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35444 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbfKCAWC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 20:22:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id 8so5474696wmo.0
        for <git@vger.kernel.org>; Sat, 02 Nov 2019 17:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NWQAdTEZfVEv6wikEkYvSfIeiiOqACmOr8cCLPySyC4=;
        b=GVv5duUlw7tmDJ9uW5eVCUPsftZ8sLIZyqSkOQmzgOffSmnDTQ4PCdPpoieyd8NoZw
         cDTADy59bi9HY6POrg5gAoox3zDzSi42MZAc77qVMMT3jEGzH6L/fL4vMo2kgVC0vjY9
         P8c+P4wwRdbu3vRPUO5yY5axOc22ekMqaC+vAaCBzBEAdC9Tr+BJzFzLjHN0Gi+6GDS5
         zV/Z5EdXEV0sX+lNJJvurWoPXMOq5sd1QB+VS8UrXqXBgRH3ZeHL0RJxPRpjP1TTPSps
         ZAgSzIJNh9RJEXqd63U13xuhuKhUGNUR0H2m7MRinsUoER3/5P5BE/52H0fsemTdBfUT
         pp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NWQAdTEZfVEv6wikEkYvSfIeiiOqACmOr8cCLPySyC4=;
        b=EysMXn9dT03CFpc77pKgHUS3rb5o7/pO8pwlBlxa36/74Aq2zzrsYjqNTT2no1Bt8r
         F8H/T0AmP7ns85ICAaoLtg1ftfLcUEC1D3bYw9Z5ALCMrlZz0yvkPsKLjrLgyjVrUqLk
         VYf+4gLvykCdVf9i0fS4YeFGuAcUfQsLNk1fc7fMjIJJYunPEigJiYbSMUidQqSjHl+4
         M2gF8weDDEanu18zeYJdr2dK9XOSmw0LB5KCXFS9hJsr5s3GoDycv1vfCiWLcIF1Ahpa
         66212xbuux/gsla0BA9MIF1K3NbqTAg7/ss8HVCiNEH6bdUz4saB2semFlKxfVY7yeXi
         jHdw==
X-Gm-Message-State: APjAAAVe4yfV6nPjTZ3zazs+/k3o6IHuE11/my27fiQFJtJ4QHZBOQ3W
        SgxzkXsR6B9AY9Twq0Myqg9VFa0X
X-Google-Smtp-Source: APXvYqxc0b0OY6j/fBFUB8v/BjMaV0I4tF0xWD0z4+UaUEMgpZBAEIFQSFUVsF2nwJOP2QWB/TpAdg==
X-Received: by 2002:a7b:cd83:: with SMTP id y3mr18297668wmj.150.1572740520547;
        Sat, 02 Nov 2019 17:22:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n17sm2262048wrp.40.2019.11.02.17.22.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Nov 2019 17:22:00 -0700 (PDT)
Message-Id: <f8157985dc5d59331a80d3c6034644bc3f6d8881.1572740518.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.443.git.1572740518.gitgitgadget@gmail.com>
References: <pull.443.git.1572740518.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 03 Nov 2019 00:21:57 +0000
Subject: [PATCH 2/2] fetch: avoid locking issues between
 fetch.jobs/fetch.writeCommitGraph
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When both `fetch.jobs` and `fetch.writeCommitGraph` is set, we currently
try to write the commit graph in each of the concurrent fetch jobs,
which frequently leads to error messages like this one:

fatal: Unable to create '.../.git/objects/info/commit-graphs/commit-graph-chain.lock': File exists.

Let's avoid this by holding off from writing the commit graph until all
fetch jobs are done.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/fetch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index ba2a81c392..dc7dc303b1 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1602,7 +1602,8 @@ static int fetch_multiple(struct string_list *list, int max_children)
 			return errcode;
 	}
 
-	argv_array_pushl(&argv, "fetch", "--append", "--no-auto-gc", NULL);
+	argv_array_pushl(&argv, "fetch", "--append", "--no-auto-gc",
+			"--no-write-commit-graph", NULL);
 	add_options_to_argv(&argv);
 
 	if (max_children != 1 && list->nr != 1) {
-- 
gitgitgadget
