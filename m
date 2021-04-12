Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E75C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1D8D60238
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242476AbhDLVIr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238778AbhDLVIl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 17:08:41 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984EEC061756
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:22 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id a4so14339415wrr.2
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gJLBcZut5BdoZ62MD0BUa+X2VnGfeSA3JBLk1DbzHGQ=;
        b=EegA4+XDZS3rRX+DsUqkOPoNiJFnX8CrhKbSu5C8jblUDZf3q2OSItLR8fMUdt3a3E
         ClUd9IPMNAQMjfnRu1em12EZ+3dItYXW0YJ6o/mfXHyOR6OjIE6NU6A48vLTtkiAuYNZ
         sxi6BeZA2i8atAQ8r7n0Ef6U2lxsdE+sNCtYBJ1v3OAVKdvs6xRemEZ27Av7NqveTUWo
         kvPeVPYGB8RhqxqNFuzYJOvrMLPp86+s/V+LGQemH27Y7xf/ru9E/v7qUI7wb6MsyQ9D
         z2n+nIaxEU6ayn6SzVALqcLX52+VJ7XDlYNWkc/JSITJwv776Kl6+U+Z6r8ZCH3moIxG
         AutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gJLBcZut5BdoZ62MD0BUa+X2VnGfeSA3JBLk1DbzHGQ=;
        b=HkpQpgR+ZBHy3U4cnimPvKgMNJrl0H9Fi05xQO8t3wei4HUDjTA8IN6urVQaZoiGhP
         GUcpf4+xW/rxUPH7ftYjSh+mp0nPzJfgDdEJBbAVTJAxeU3dqCIIyLsmp8gDOLN7QsSf
         I8TvmnXujqGrTT5XuV54Kd5Liatsg2OHdkh+l52J6k97E9s7OwWezeeWUjXUTBb2s2ya
         Zeb+mmjHSEhaD5FogWq8ZbTFouIRyhWHHPj4iExj8Iw+0HaDgtwAam7XZ8pB17f5PYjN
         6Fqc5E616JnU2+ZgARY1NKG9nS33dekSyy3cfMYvl039mTlz0ck30dABqJ+tL6IrArAQ
         WOMw==
X-Gm-Message-State: AOAM531Ih/2evoDmESCJC/YxAiZp30Fntb4Mn5ziO3sNSL80QMsD/p2s
        fHLb+hD+dqUSXSUwHA4DGLSaZY/q1TM=
X-Google-Smtp-Source: ABdhPJy2AxgY7U4L9Zkqg8ziUZeyA3FVSEuaF/H8eGSmged0oZzxAdRMuBpCfWeQjT0VgI66XvvWsg==
X-Received: by 2002:adf:e50d:: with SMTP id j13mr6346222wrm.80.1618261701361;
        Mon, 12 Apr 2021 14:08:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q19sm453125wmc.44.2021.04.12.14.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:08:21 -0700 (PDT)
Message-Id: <f4b77aa18b93f4b3355cbb947fe7145a52d29e5c.1618261697.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
References: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
        <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 21:07:54 +0000
Subject: [PATCH v3 03/26] read-cache: expand on query into sparse-directory
 entry
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
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
index 3ad94578095e..3698bc7bf77d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -567,6 +567,27 @@ static int index_name_stage_pos(struct index_state *istate, const char *name, in
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

