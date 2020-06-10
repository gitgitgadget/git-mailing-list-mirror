Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A835C433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 21:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 051E82072E
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 21:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0Rwx1bg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgFJVTk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgFJVTh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 17:19:37 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01612C03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 14:19:37 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j10so3926833wrw.8
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 14:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7Nd4/W6P67eOLim7Hwc4v1JpBcEtKZpep65gLVkktDk=;
        b=B0Rwx1bg90KCQ+n0mqPUTVDMNwtPN0S6z6B3rCSQiHXXvMmUimHsfUEqmmMnjmC5Gj
         Ie2STyzl+OYG1AiDGpH+BDXl9T10RZFBKNRpuslhzkN7f0v6xNXERxO9iTpaRukpoBbF
         EOsKhjOZz6DoSIGRi6iWeRl+YpWDtlrTur/4rO1a7lNd6E5VnYhNtJUk1YJE3u/VxM8D
         xUvONcN0WwKKDGgimqZsXuIxLRZ1BA9PcBm8alNw7CFIGD6GGrnnVwLyBEbrpbL71SkF
         YxgdZkdlj5YYAVdXw8437ed8HNvqpYzmtLQ0GsxkdfyK6l/k8a1Kp2kOYUiyQ2Hb7kmF
         D6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7Nd4/W6P67eOLim7Hwc4v1JpBcEtKZpep65gLVkktDk=;
        b=W+j/Z2F8Jfwg7cSUTeWZpjDBr6aGNy+TqgNlS7YaEfiinl//IgooEBL65A/nK8d1CK
         3vV8RBrsdJ79c2XljYzmt8lXv5mSDSGNvTqVnW7YFshAOIaW1oPDorArF+brG/IAlA16
         8laof8SzDD1wmDuHm+R1ASA0hUZhw2X2F7olatsK3A5CjtiFDDytcqENOF24zNtSoK6s
         P1+qZs9jFhDAg6JglKgihvngW5Q9sBMwanP8eqlujlqhaeCjEqOOt6n0MynPRgK537a4
         KOK989YbdGitm/SwhgdxHWULxbUCow+13NKmqB4MFbZ2FL0ZEU2StH4vePVwgeZVzjE2
         1N2w==
X-Gm-Message-State: AOAM5310f8xu1ImhT98QMqKY8eVbik3oOZwciG5ZviN30NO/PpaTscFE
        7tiBmblgONI2q0M8JFTOgNdiHd/S
X-Google-Smtp-Source: ABdhPJwxK8/SF4ci5Khw+95hE48v2ACr3qxJAi9IAT++S5s6Y1DBkB/0/DobJ7+Hd1B3M5uutMjP2Q==
X-Received: by 2002:adf:a1d3:: with SMTP id v19mr5693687wrv.245.1591823975576;
        Wed, 10 Jun 2020 14:19:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q11sm1482219wrv.67.2020.06.10.14.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 14:19:35 -0700 (PDT)
Message-Id: <c9c9c81068e24972e084956aa3b09a3ec0eb98c1.1591823971.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.git.1591823971.gitgitgadget@gmail.com>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Jun 2020 21:19:24 +0000
Subject: [PATCH 3/9] send-pack/transport-helper: respect
 `core.defaultBranchName`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     don@goodman-wilson.com, stolee@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When mentioning the default branch name in an error message, we want to
go with the preference specified by the user.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 send-pack.c        | 6 +++++-
 transport-helper.c | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 0abee22283d..f7747bed1c9 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -405,8 +405,12 @@ int send_pack(struct send_pack_args *args,
 	}
 
 	if (!remote_refs) {
+		char *branch_name = git_default_branch_name(1);
+
 		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
-			"Perhaps you should specify a branch such as 'master'.\n");
+			"Perhaps you should specify a branch such as '%s'.\n",
+			branch_name);
+		free(branch_name);
 		return 0;
 	}
 	if (args->atomic && !atomic_supported)
diff --git a/transport-helper.c b/transport-helper.c
index a46afcb69db..cc8ae5c67ca 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1044,9 +1044,13 @@ static int push_refs(struct transport *transport,
 	}
 
 	if (!remote_refs) {
+		char *branch_name = git_default_branch_name(1);
+
 		fprintf(stderr,
 			_("No refs in common and none specified; doing nothing.\n"
-			  "Perhaps you should specify a branch such as 'master'.\n"));
+			  "Perhaps you should specify a branch such as '%s'.\n"),
+			branch_name);
+		free(branch_name);
 		return 0;
 	}
 
-- 
gitgitgadget

