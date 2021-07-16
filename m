Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0875BC07E95
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5D59613FA
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240415AbhGPOQQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 10:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240309AbhGPOQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 10:16:16 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7ABC061762
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:13:19 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l17-20020a05600c1d11b029021f84fcaf75so8302998wms.1
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5OKJ5/z6mzkpyFLr8dQSMW7FZKBlkXYkL9ZO9LFWfbs=;
        b=squ92wztvLUuvu2EQLG3As6VayTLCXis2+co7KGwjBYWBdBgqAgh5edEYN5eEg/t3m
         TDsZzcj0TympbGkRRZS6CVzpJevGexKDTUQAiZGg+/xA6CWF1OL9qQIBHEPTZRssdab5
         5L/VKz+nhpu+rtR0adIYIbxgBfCrrVPGqV+g7+Z3bb2hK+4v8NHh7bPgNhoALtYNxpeJ
         IXlMC31yEBBM4EHD8B059J7iRUiyEWMHGjtZeKQxfjtxCb6NO0DjbN2MiHmRsqmKF3mL
         13uSo/CHlBbduVn4PivYXF9J93LlUiAGzu2SW+4jtFoqxG/vBpXKESlH1HF9j+WGJgVD
         RA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5OKJ5/z6mzkpyFLr8dQSMW7FZKBlkXYkL9ZO9LFWfbs=;
        b=PAnp1dT+gcx0ipyauF1fkwhg9qNvzDCRhHrn4GdMzNAhRc2rjbddfkjZ8RKt32HypS
         vkYHKTURAuqbRuYkVF0wKU3ZTlD321GFM31d6at3O2fIo6E91YT3tHErfB8GByTiOILQ
         8lq0+FqQSB5tSM4XBfw5TS1hPpzZZETnDZ+2sSQe/9bjjwVx4Qjpr5O1EPdrbu5xCcjv
         R1uSNA5hgGbD3IdOzKSCXKwOgUtvxtoJ0ufpdYN6ugjD3omBFuY8VyJvaMwbvrP9GyVT
         wXWhWXqZGiSm+wfCm1zxjuWoVD10Uv42F80LE50h3p0po1ii+0GS+du3OvlacjWYPR3e
         wf6Q==
X-Gm-Message-State: AOAM533PF+uHdBdwKCAITo7O4cW52nmd5bOmqRbv1dWbiruUZydVzAvY
        7OKcGqoSQYJ7/YdSK+f9CaMblfhfOQ5ejQ==
X-Google-Smtp-Source: ABdhPJyWS57DupglUZm5gY4PRnReePlfyZ/EEzTkkQJ543AuuMG0sGUE4/CXEoq5xNea4ZBKRv1zcA==
X-Received: by 2002:a1c:f016:: with SMTP id a22mr11070892wmb.65.1626444798073;
        Fri, 16 Jul 2021 07:13:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a9sm10101363wrv.37.2021.07.16.07.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 07:13:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/11] refs/files: remove unused REF_DELETING in lock_ref_oid_basic()
Date:   Fri, 16 Jul 2021 16:12:58 +0200
Message-Id: <patch-02.11-033c0cec33d-20210716T140631Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.gfa1990a4f10
In-Reply-To: <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com> <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The lock_ref_oid_basic() function has gradually been replaced by use
of the file transaction API, there are only 4 remaining callers of
it.

None of those callers pass REF_DELETING, the last such caller went
away in 8df4e511387 (struct ref_update: move "have_old" into "flags",
2015-02-17). This is the start of even more removal of unused code in
and around this function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 677b7e4cdd2..326f0224218 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -934,8 +934,6 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 
 	if (mustexist)
 		resolve_flags |= RESOLVE_REF_READING;
-	if (flags & REF_DELETING)
-		resolve_flags |= RESOLVE_REF_ALLOW_BAD_NAME;
 
 	files_ref_path(refs, &ref_file, refname);
 	resolved = !!refs_resolve_ref_unsafe(&refs->base,
-- 
2.32.0.873.gb6f2f696497

