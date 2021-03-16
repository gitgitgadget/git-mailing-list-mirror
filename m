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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2062C4321A
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD75D64FB4
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbhCPVSH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 17:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbhCPVR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 17:17:29 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D881C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:29 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id z6-20020a1c4c060000b029010f13694ba2so141846wmf.5
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YaUzrcunWYtZa7lKH40QfQZeg2Uz3GETXegzG5AwNCs=;
        b=mi0iQAqIE7PswHq06LDW6uuLRqlKdWmoDEDtLZNwmOMu1KbldMOhD7mqOqaVTdJgoq
         PtZclNhrfg7Ejm43Z3+qwdGOHfZnTZvSa0HvI703VaNKxaqQpHr/+AxljlYczRenihDn
         2+L6QfLssDHh+VwxlRp0QhLaYZNm1isFO3UXwDNStqh/RT30OQ3QiOoTWGqwlmHOctgx
         0DfOJ04a+5N+tjz8BntwBOWlo4q9xx6rW+KPBohqn5kFNglnzc4jul2QPBgQSTOmHGWz
         k/n+CmfoJk2Qcjt7eOc9gfeB1dmWtIdK3JLKMAuFiBWuT0kK1djP2Yf+NO91r82xqtWn
         HkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YaUzrcunWYtZa7lKH40QfQZeg2Uz3GETXegzG5AwNCs=;
        b=a5F6WUo6m7cX7Wrojy4Rh+2N4edAycyENf6GFPJ7E+hIWM5MDDy8VvSzydK+5vyaLL
         eETax0ljYy0KibHRIJLjFhG/DHMWc1dhszth1gvAdzZ9U2kd3qot46uGjJDaDf/UNCet
         6g22khapi/Ql4SrycIrcAII+9IQoC4Y6+ohKPtpFt5WjU3EVNMxPSzVqJLLFx43iHsEG
         o6HS8YdzZUgXkTyNWoLMaic41OTzm0PP0SEiYNiJ3fKXyRLOzRkrIjnH2NkTJ4UzkiVQ
         Zc49JGpfKv5Oy+zCR+/+CSXyFUX8fkoGnYprtW4y6ssPo3nEFmaSdKlut85psgT3OZqu
         Htdg==
X-Gm-Message-State: AOAM532G/Zd20ibX+HLZXovgY2GoY3DuAevcyu/OVTfBJC7wRVGlaxa4
        WnB9+EY5lWnqJx4SzeWKPQKLqU5eptE=
X-Google-Smtp-Source: ABdhPJznnm3uS8cFWebnj9HUwpVJvvRcpMHjUUHRzUdRIGvAXqDyVGnpM9kg7qmHWqMqcohsbBrDkw==
X-Received: by 2002:a7b:c112:: with SMTP id w18mr681493wmi.28.1615929447951;
        Tue, 16 Mar 2021 14:17:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s20sm484363wmj.36.2021.03.16.14.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 14:17:27 -0700 (PDT)
Message-Id: <796449758a08ad9f2038f16c7d157edf27ca3cc4.1615929436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.git.1615929435.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 21:17:04 +0000
Subject: [PATCH 16/27] update-index: ensure full index
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

Before iterating over all cache entries, ensure that a sparse index is
expanded to a full index to avoid unexpected behavior.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/update-index.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 79087bccea4b..8eb654ddc754 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -745,6 +745,7 @@ static int do_reupdate(int ac, const char **av,
 		 */
 		has_head = 0;
  redo:
+	ensure_full_index(&the_index);
 	for (pos = 0; pos < active_nr; pos++) {
 		const struct cache_entry *ce = active_cache[pos];
 		struct cache_entry *old = NULL;
-- 
gitgitgadget

