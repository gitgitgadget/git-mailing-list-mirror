Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68584C56201
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DAED22268
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ts8scDof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgKBSzf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 13:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgKBSzX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 13:55:23 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E57FC0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 10:55:23 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c18so10441558wme.2
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 10:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HHeM+c7NkTWs7nebSEJ3cvO5n6VeizXf/xOxj+EbJxc=;
        b=ts8scDofaqQ+2sNfBR7EznkK8RKDGWdUPg0wuojl964DQRI4yDerD3xnR7WZFn04XO
         HPkwkRZTEhRTFoaRji5F3sdrwx0cCV/DzlzEW59Z441IOFfC3EWmqhazMsTE7pj9evyZ
         AcLK/0dr7ccmrKag8n9YpBcfiA54DNRCF+3j5fEg/zIJdoWEHP1OFkIW4C0ZLCsu8+d/
         y93eJEf3tRsqDy2qkZYG0e5YMYMKb7dRmiI5aiLldFPCO2WnJG16ot4nlkz4bj5pqmxl
         uIKBpVU8xXv+9oAR3LFi5hqsvCC0tIW+AYBcDcekcP5nHB0YKPyw5H2jSuZa3LobWB9B
         vpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HHeM+c7NkTWs7nebSEJ3cvO5n6VeizXf/xOxj+EbJxc=;
        b=ammSsvm4yqsuxXxNbQMQok/n6ZmK3WYOxMqG/ui8z2rpCHKhxW4qIcwLC+bIdC6vto
         nepFz4X0rdYJP72Sa0evmi7cqYaLUKTGYn+AfeAUCICIeEv9XuVe1VB0CxxkOR+SDVbc
         LwzMfmNZ6G4LuLza1PxqjTzEE2koH53mgCrJiWUmTvX9HQY2MPEOf7opVH29O698PisK
         4JFQ2gWkwrz9gG27EEzUtGzGHG7IEUMGT3He1UK9aWMRJIyKUIkxcFI3wn0ipCtqRID2
         T7m7/Eebf04WYS0TrqcZ18Cox7EKJs4KNfeHNN2lbK/tTdo/9c0DAjtxbFzDasQEVj6k
         OisA==
X-Gm-Message-State: AOAM5303IaEzR1I4EASXN2RtUmKfBajO1Ru9L455mt7Tg8t2v3S+BoMw
        /rGhUOD65JOGS0BW9NjnVkoFfkP3M9U=
X-Google-Smtp-Source: ABdhPJw1rvXCWdveqNEpL56n/CLTJ8Orq9KqCwdZJnIH7hjc+pn+N0kS0gfGWW8+paF41hrPUquk7w==
X-Received: by 2002:a1c:e482:: with SMTP id b124mr15764632wmh.25.1604343322283;
        Mon, 02 Nov 2020 10:55:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u10sm23084120wrw.36.2020.11.02.10.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 10:55:21 -0800 (PST)
Message-Id: <ea942eb8035686af4b284e66affa3a0a1d2a5b0c.1604343314.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
References: <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
        <pull.835.v3.git.git.1604343313.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Nov 2020 18:55:08 +0000
Subject: [PATCH v3 08/13] strmap: enable faster clearing and reusing of
 strmaps
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When strmaps are used heavily, such as is done by my new merge-ort
algorithm, and strmaps need to be cleared but then re-used (because of
e.g. picking multiple commits to cherry-pick, or due to a recursive
merge having several different merges while recursing), free-ing and
reallocating map->table repeatedly can add up in time, especially since
it will likely be reallocated to a much smaller size but the previous
merge provides a good guide to the right size to use for the next merge.

Introduce strmap_partial_clear() to take advantage of this type of
situation; it will act similar to strmap_clear() except that
map->table's entries are zeroed instead of map->table being free'd.
Making use of this function reduced the cost of
clear_or_reinit_internal_opts() by about 20% in mert-ort, and dropped
the overall runtime of my rebase testcase by just under 2%.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 strmap.c | 6 ++++++
 strmap.h | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/strmap.c b/strmap.c
index 829f1bc095..c410c5241a 100644
--- a/strmap.c
+++ b/strmap.c
@@ -64,6 +64,12 @@ void strmap_clear(struct strmap *map, int free_values)
 	hashmap_clear(&map->map);
 }
 
+void strmap_partial_clear(struct strmap *map, int free_values)
+{
+	strmap_free_entries_(map, free_values);
+	hashmap_partial_clear(&map->map);
+}
+
 void *strmap_put(struct strmap *map, const char *str, void *data)
 {
 	struct strmap_entry *entry = find_strmap_entry(map, str);
diff --git a/strmap.h b/strmap.h
index ee4307cca5..10b4642860 100644
--- a/strmap.h
+++ b/strmap.h
@@ -42,6 +42,12 @@ void strmap_init_with_options(struct strmap *map,
  */
 void strmap_clear(struct strmap *map, int free_values);
 
+/*
+ * Similar to strmap_clear() but leaves map->map->table allocated and
+ * pre-sized so that subsequent uses won't need as many rehashings.
+ */
+void strmap_partial_clear(struct strmap *map, int free_values);
+
 /*
  * Insert "str" into the map, pointing to "data".
  *
-- 
gitgitgadget

