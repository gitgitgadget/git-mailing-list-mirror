Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33A00211B4
	for <e@80x24.org>; Sun, 13 Jan 2019 08:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfAMIwl (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Jan 2019 03:52:41 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46033 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfAMIwl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jan 2019 03:52:41 -0500
Received: by mail-wr1-f68.google.com with SMTP id t6so19444377wrr.12
        for <git@vger.kernel.org>; Sun, 13 Jan 2019 00:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JzSKzp0KvtltG1JRJTxXJ88+ajXaKQHFM63a1EMKuls=;
        b=Kum+9v5moNAah3DCWRDrvbQEPqqKKa7EgPwKCLi2DbgaxE6Ak3QZPLXCPHyxmOFkDg
         FBXmUsjM8aYfdDFoKSMs/0UIfQTJ6BRfdjErTKucIAnc8zXfTun1o9vsDwLloyoG/QLz
         GwM+uCVyI8+OncDpPKyXqYBbY4cGSk4eFhsyeKtSvs+gVgwwqbVZ8116ozZfaSrfEi4I
         LG4OnkKd69LOH+Zr4VNzfld9aiThVmfNDbZ8RtOOmPdtNtLvIpG1EkLsf7G+viNsIFkV
         jMy9aecj3i8w2AOz6yZzryqlNBg8lTrd4kOleZiZivKtZ0764gCNUkWs+yxlurYNBs5q
         m9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JzSKzp0KvtltG1JRJTxXJ88+ajXaKQHFM63a1EMKuls=;
        b=SbLdLIz3iYjuWIqDyIMs1zdVAcCrbiZ+x6DpVQXV0TOdAiSuqdIcGWNRZu/fwO5nsN
         WJLJA85k8t7q78SNBztOxO+fQ5IRbxU7b0j+1WOY3VXhRIdx+g4wsiyRwJu5zVT4SEyi
         E8OD9Qh0u7LMrze82FE54FIHf+VA6IJurZGSFW1+MriLgLW+e74yJuzabLjdVRvtNGW8
         KtF0fVH25+ew53Yxmz21SUTCWrw4Q1bIyBLtQShvzrzCJQsAMOhuUpZAyODd6WwqhSo6
         PAL6GjzoU6aS+DAoX9jh6oBIBYbGwOHuhjdakcbs/nV7anAYrMiQXQrWmU2JyyBGCkGX
         gwNQ==
X-Gm-Message-State: AJcUukdNtSvSV1e2r9aWWXNL/7DFncU+9l8m7qjKrPLf3rWXTHMK610i
        haHXBJykHXOsx0n4bDUgjo74aTsN
X-Google-Smtp-Source: ALg8bN6TvR98/6mlHWPSHOEAXTUhyRLJ/FiKypvuJ4gZEN87S0CjUZH4SQYbRhaWJVkpjy4+ziWqCA==
X-Received: by 2002:adf:efd1:: with SMTP id i17mr19412557wrp.200.1547369559081;
        Sun, 13 Jan 2019 00:52:39 -0800 (PST)
Received: from localhost.localdomain ([2a04:cec0:1044:2fea:35f7:f053:bef4:8540])
        by smtp.gmail.com with ESMTPSA id t4sm73035045wrm.6.2019.01.13.00.52.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jan 2019 00:52:38 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] fetch: fix extensions.partialclone name in error message
Date:   Sun, 13 Jan 2019 09:52:19 +0100
Message-Id: <20190113085219.22993-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.20.1.122.g9a13c7f8ea.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is "extensions.partialclone" and "core.partialCloneFilter", but
not "core.partialclone". Only "extensions.partialclone" is meant to
contain a remote name.

While at it, let's wrap the relevant code lines to keep them at a
reasonable lenght.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/fetch.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e0140327aa..c0ade48f5d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1478,7 +1478,8 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 	 */
 	if (strcmp(remote->name, repository_format_partial_clone)) {
 		if (filter_options.choice)
-			die(_("--filter can only be used with the remote configured in core.partialClone"));
+			die(_("--filter can only be used with the remote "
+			      "configured in extensions.partialclone"));
 		return;
 	}
 
@@ -1646,7 +1647,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		result = fetch_one(remote, argc, argv, prune_tags_ok);
 	} else {
 		if (filter_options.choice)
-			die(_("--filter can only be used with the remote configured in core.partialClone"));
+			die(_("--filter can only be used with the remote "
+			      "configured in extensions.partialclone"));
 		/* TODO should this also die if we have a previous partial-clone? */
 		result = fetch_multiple(&list);
 	}
-- 
2.20.1.122.g9a13c7f8ea.dirty

