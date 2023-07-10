Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FC3EB64DA
	for <git@archiver.kernel.org>; Mon, 10 Jul 2023 21:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjGJVNK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jul 2023 17:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjGJVMo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2023 17:12:44 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAA7FB
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 14:12:41 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-c4dd86f5d78so7239786276.0
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 14:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689023561; x=1691615561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x4fGxHFlcIAZYT2CBLKurvB6zt4YEHFgrdipdCyPcek=;
        b=rJ6onLwZ/2JUV5gx5iNqNhIOI+rzcu2pAp473mWkQusJ82/w3/TjvhQDowMJeA+Oc9
         4e+WzchDCEUswkTN5aSK3Iwf5ZGMcigB6uRRPOX/n2yzqyPsFwGMfmTnGEqDDa5NuaJh
         Z2B2N+v7DHjOJOfv2EE+vsu8w5DvDWg9ro5Y7Y7QpzfOKtwHNj+VAD5jNxLtuVPevSAk
         BabZphffY4P2qerSZy/xSTW9GosDRuzALZT3dPdMebnMn6B5k7I57mkmX96LbDN+YWxo
         lJKGn4XJopgi+4lGL983sTFtDowfKpoqECs1kQeugN2D+hrRjeqBL4SjarwiGNtWZjE7
         jHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689023561; x=1691615561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4fGxHFlcIAZYT2CBLKurvB6zt4YEHFgrdipdCyPcek=;
        b=j/kbsa6WnfsZr/b1QNbI0suBXl9Uiev/WS4JIfOrClX15epDVx35IJU6GnSYJXt0A5
         57AJBYf/81/8R4vNKsX1xjAFmv+HguRJKTM0HKtMorzecAdQUdb+UetjrkwoqBcL7zhu
         AgVqBQky856Bg0fiBEo6LHeQAKBs0qd71L5CsO2vQWz9a6qkFlmE2c/L+/KlVXgy0LB5
         SfyJcgMufQttYlaFbukFQivjcerojjJ5cyOjZ0LixuQtGwOVBfSAlROamT3WO7hkOJUD
         6ZYmLNHfuKelxKlM4TpL4y7TdjUTG1/DYZj24aABO8UHPDNUk2XoPsrbxE1F2znKOaPh
         znMQ==
X-Gm-Message-State: ABy/qLbeFlmoP2uV1g+bp2wj5QRyihUnZtEiz2zH8rAUR/ZQ6pWFmSsM
        u+uJO7xuFSUlaTgNNitFCyHd47159aacQUv2xWSJYQ==
X-Google-Smtp-Source: APBJJlGrAQeDcwwWTzUmTymCBj9yIyOEiRYugYpP5zlwAQ3qD3EAq1QDjCh5o7Djw2cv0oJn18pkmA==
X-Received: by 2002:a25:b30d:0:b0:c47:3430:bcb0 with SMTP id l13-20020a25b30d000000b00c473430bcb0mr13448058ybj.26.1689023560961;
        Mon, 10 Jul 2023 14:12:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z1-20020a25ad81000000b00c581e8d0ae4sm136541ybi.56.2023.07.10.14.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 14:12:40 -0700 (PDT)
Date:   Mon, 10 Jul 2023 17:12:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 13/16] refs.h: implement `hidden_refs_to_excludes()`
Message-ID: <f99d89d53b9640db656109de06dd5e084754cc0e.1689023520.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1689023520.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689023520.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In subsequent commits, we'll teach `receive-pack` and `upload-pack` to
use the new jump list feature in the packed-refs iterator by ignoring
references which are mentioned via its respective hideRefs lists.

However, the packed-ref jump lists cannot handle un-hiding rules (that
begin with '!'), or namespace comparisons (that begin with '^'). Add a
convenience function to the refs.h API to detect when either of these
conditions are met, and returns an appropriate value to pass as excluded
patterns.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 refs.c | 24 ++++++++++++++++++++++++
 refs.h |  6 ++++++
 2 files changed, 30 insertions(+)

diff --git a/refs.c b/refs.c
index 3065e514fd0..0916a6ba582 100644
--- a/refs.c
+++ b/refs.c
@@ -1482,6 +1482,30 @@ int ref_is_hidden(const char *refname, const char *refname_full,
 	return 0;
 }
 
+const char **hidden_refs_to_excludes(const struct strvec *hide_refs)
+{
+	const char **pattern;
+	for (pattern = hide_refs->v; *pattern; pattern++) {
+		/*
+		 * We can't feed any excludes from hidden refs config
+		 * sections, since later rules may override previous
+		 * ones. For example, with rules "refs/foo" and
+		 * "!refs/foo/bar", we should show "refs/foo/bar" (and
+		 * everything underneath it), but the earlier exclusion
+		 * would cause us to skip all of "refs/foo".  We
+		 * likewise don't implement the namespace stripping
+		 * required for '^' rules.
+		 *
+		 * Both are possible to do, but complicated, so avoid
+		 * populating the jump list at all if we see either of
+		 * these patterns.
+		 */
+		if (**pattern == '!' || **pattern == '^')
+			return NULL;
+	}
+	return hide_refs->v;
+}
+
 const char *find_descendant_ref(const char *dirname,
 				const struct string_list *extras,
 				const struct string_list *skip)
diff --git a/refs.h b/refs.h
index 7871faed632..23211a5ea1c 100644
--- a/refs.h
+++ b/refs.h
@@ -837,6 +837,12 @@ int parse_hide_refs_config(const char *var, const char *value, const char *,
  */
 int ref_is_hidden(const char *, const char *, const struct strvec *);
 
+/*
+ * Returns an array of patterns to use as excluded_patterns, if none of the
+ * hidden references use the token '!' or '^'.
+ */
+const char **hidden_refs_to_excludes(const struct strvec *hide_refs);
+
 /* Is this a per-worktree ref living in the refs/ namespace? */
 int is_per_worktree_ref(const char *refname);
 
-- 
2.41.0.343.gdff068c469f

