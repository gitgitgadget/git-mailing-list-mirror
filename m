Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39A3C433FE
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 11:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241137AbiKRLTE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 06:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241441AbiKRLSo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 06:18:44 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6435C18364
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:18:42 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id f27so12310717eje.1
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/eu7AgKdaxXH3EksEd0F5/hiQARojqiblAAuKhpprQ=;
        b=NjDokXiq2CTW85OsWTXTMpegTg5AnZgXhpEFMZpqtCdcw9Qr/1/xHq/uRD+t7lSLDW
         3TWuncR/2ttcfMEv4tg8hgS6XU+3SW4JsWp/h9dOfiTZqbFRCD9PBI4KoIWAug4/4HM4
         0XtqLjqNKnQMz0A++wUHsyPt8ZvUrSj2cxFPlCnfNyz1CT9y/nIJswxiydIsO0uaovxI
         pmrPUScVqEcCz9VPTMwAe/wx7fxUpY7yOYzBWoq4l5OzrzBfMWjLaqGajOyBlG0wS+tN
         4AgREsTNslGnvVYpjDYc0z8EAFzjgbSp+cPE9Nl0ved6qlmFPn7j3qHuY/NuTWMEP6W2
         Tcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/eu7AgKdaxXH3EksEd0F5/hiQARojqiblAAuKhpprQ=;
        b=W+ACGOoD+Ja/D1jCkeEiaJgECcVY1GWdUP486bJG+nd+VDP/blbq4Xy8gwVAcsoZC8
         SDBYUbO1beLaAQACnXaqhcsjiAe4p80ZnXA0oi/su0TdhrM5iO2M8ontqM/7EorjrL2n
         /v7gKQxZxf0JPuwwFew0o1hsv8oo4fvkXSus7V0BzzdXq+r+Up0NyPAG7AZgxGf6VjUU
         q1jkIY5zQlNeUNlOo8m7rsh52IA0umMRo8R55ZUkGbKS1jzIu/+TEOg7QPqaSiq3+WeI
         wO/LZXsgHzkfm4Q8bWkFV7ELqDthaAv2i9bpuRmWEl0s41xMCgiF8hLjjAnQEfbm7h/F
         8+nQ==
X-Gm-Message-State: ANoB5pll1nzCV9EU6Dt2pM7f9MQVVn1BTHtEA95e7IbZxjR1vemOXbFd
        WgpkfteCwGhkpyh+oisZyCq+rYrXlkSxuw==
X-Google-Smtp-Source: AA0mqf7U/A4697Ad8sxlqBwBiYEwWcqz0qR+8HWdO2/WZX5MJy+dKrWaTnQ+thNrY1Z/v545gTO/Bg==
X-Received: by 2002:a17:906:ca18:b0:781:c97c:84d1 with SMTP id jt24-20020a170906ca1800b00781c97c84d1mr5492067ejb.147.1668770320433;
        Fri, 18 Nov 2022 03:18:40 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id fy20-20020a1709069f1400b00788c622fa2csm1558955ejc.135.2022.11.18.03.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:18:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 08/12] merge-index: stop calling ensure_full_index() twice
Date:   Fri, 18 Nov 2022 12:18:25 +0100
Message-Id: <patch-v9-08.12-badfc60354a-20221118T110058Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1511.gcdcff1f1dc2
In-Reply-To: <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com>
References: <20220809185429.20098-1-alban.gruin@gmail.com> <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When most of the ensure_full_index() calls were added in
8e97852919f (Merge branch 'ds/sparse-index-protections', 2021-04-30)
we could add them at the start of cmd_*() for built-ins, but in some
cases we couldn't do that, as we'd only want to initialize the index
conditionally on some branches in the code.

But this code added in 299e2c4561b (merge-index: ensure full index,
2021-04-01) (part of 8e97852919f) isn't such a case. The merge_all()
function is only called by cmd_merge_index(), which before calling it
will have called ensure_full_index() unconditionally.

We can therefore skip this. While we're at it, and mainly so that
we'll see the relevant code in the context, let's fix a minor
whitespace issue that the addition of the ensure_full_index() call in
299e2c4561b introduced.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge-index.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index ee48587a8fb..9bffcc5b0f1 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -61,8 +61,7 @@ static void merge_one_path(const char *path)
 static void merge_all(void)
 {
 	int i;
-	/* TODO: audit for interaction with sparse-index. */
-	ensure_full_index(&the_index);
+
 	for (i = 0; i < active_nr; i++) {
 		const struct cache_entry *ce = active_cache[i];
 		if (!ce_stage(ce))
@@ -122,7 +121,6 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 	/* TODO: audit for interaction with sparse-index. */
 	ensure_full_index(&the_index);
 
-
 	if (all)
 		merge_all();
 	else
-- 
2.38.0.1511.gcdcff1f1dc2

