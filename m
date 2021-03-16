Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D47C43381
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8577964FA8
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbhCPVR2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 17:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbhCPVRU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 17:17:20 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C15CC061756
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:20 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k8so8163295wrc.3
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0iz5/2sHB8WhhqvdKiv+NkDMDD7WdLz77MP6lFCbRfo=;
        b=n/uOsSXSMvkAXxqOXfCF8mvkMxfY33HjP/yJ1LxnP6EiNIZ0Ahuj6E2cY+xiqQmu3k
         aO0ITzEi/inHkcmOf4FBQEy1lEC9UWdgbMT+7Uvxu+yYzreMWCl9Hd6Wdu757kU1srhR
         Hcd9U4+kvNX6iE9oX018AiDMpv9cPyF8OF0l2h/H+36TxAGg6VS914sIuwYWyDrkLbTK
         N4DdE4H7WYjPB/NcoMpQV3T493SgxWtQNIWbbBoyrv3qdBzaysZyNGdAGtPoGzvWzZUg
         1ssX1c9V5LAA8j9ADcNA5+UmAyRI1kjWGE2xJxuks4XkkRPMXk0Xpxk0ar0ypO/Esyh4
         utSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0iz5/2sHB8WhhqvdKiv+NkDMDD7WdLz77MP6lFCbRfo=;
        b=cQ+eLuNcsAI3U2wgAdkD/unrk2hj8cIIbFKu6Dvs4/8k8SODspqWSaVYq8oHSu4QSS
         JFZ7Iq2cC5RQlzn8wI2B6iCYk50FoGeHbDz2mUJFnciVK43j9kWFP8KGPi67IBabJ4zn
         9cjl1vMh+p1Zr8xGRffSxVrdZpjaJq8VklIvZyj6lOQeWRRUsN/F1FQz3dWyBXSAj+HP
         ERGpgDF2ywR3VJmQEIcv2oYbS8APe6t4dntVNePZBHlonINJwbVJzQkddj9cVwAsOj2I
         JGEtlq7AUBH3RIYMgrg9jI2/G/JQNFd1U8cmiLzvT0m6KpHbosOFi1eZwSVdV+EAdahd
         MJqg==
X-Gm-Message-State: AOAM531ZEtDmzYPfDIHBs+lOMhHjn6jflDF3I1vOhMs9h4VfisvkP9yA
        2tvf4jRX8m/VF/Kt4aNPuzKH2Pur5HY=
X-Google-Smtp-Source: ABdhPJx2TKzgfl4Slu7gGZzQJRzaIvoau82Yi/OrVlxuahTweMYmY7u+LvFJk7lj+LBhMpaAWWJA8Q==
X-Received: by 2002:a5d:6c69:: with SMTP id r9mr927857wrz.11.1615929438958;
        Tue, 16 Mar 2021 14:17:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s84sm520141wme.11.2021.03.16.14.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 14:17:18 -0700 (PDT)
Message-Id: <8e11e891701985729cd5ecd7737e59d5a18284ce.1615929436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.git.1615929435.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 21:16:50 +0000
Subject: [PATCH 02/27] read-cache: expand on query into sparse-directory entry
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Callers to index_name_pos() or index_name_stage_pos() have a specific
path in mind. If that happens to be a path with an ancestor being a
sparse-directory entry, it can lead to unexpected results.

In the case that we did not find the requested path, check to see if the
position _before_ the inserted position is a sparse directory entry that
matches the initial segment of the input path (including the directory
separator at the end of the directory name). If so, then expand the
index to be a full index and search again. This expansion will only
happen once per index read.

Future enhancements could be more careful to expand only the necessary
sparse directory entry, but then we would have a special "not fully
sparse, but also not fully expanded" mode that could affect writing the
index to file. Since this only occurs if a specific file is requested
outside of the sparse checkout definition, this is unlikely to be a
common situation.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 read-cache.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index dfec221d9128..b143277ed106 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -566,6 +566,27 @@ static int index_name_stage_pos(struct index_state *istate, const char *name, in
 		}
 		first = next+1;
 	}
+
+	if (istate->sparse_index &&
+	    first > 0) {
+		/* Note: first <= istate->cache_nr */
+		struct cache_entry *ce = istate->cache[first - 1];
+
+		/*
+		 * If we are in a sparse-index _and_ the entry before the
+		 * insertion position is a sparse-directory entry that is
+		 * an ancestor of 'name', then we need to expand the index
+		 * and search again. This will only trigger once, because
+		 * thereafter the index is fully expanded.
+		 */
+		if (S_ISSPARSEDIR(ce->ce_mode) &&
+		    ce_namelen(ce) < namelen &&
+		    !strncmp(name, ce->name, ce_namelen(ce))) {
+			ensure_full_index(istate);
+			return index_name_stage_pos(istate, name, namelen, stage);
+		}
+	}
+
 	return -first-1;
 }
 
-- 
gitgitgadget

