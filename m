Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8D3C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86EB1610A5
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236496AbhHWLhF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 07:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236431AbhHWLhC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 07:37:02 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57374C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:36:20 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id f10so10323838wml.2
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EdLhCfkTp/+ES1NxZP/qC5aV2h/1GTWwLkGCzaWJOtk=;
        b=K+y6hRLcpJBZ1/Vquay92jHc5/vx1N0DicNkrEtVKrKvEebaEo1u5eN1ckcam4Pekq
         6aoyLyaz6CtOPuY9ckwEeQOAT/tGBzeyJqAh1f0RwaJ6eBj+S6fWOxzGrLo8/iC6huD+
         tMeDBVo/BORzpdRb2+fh0Rk/L/p1+AsGo1qHOREwCxZW+YWCIJptc5IFUoVeplhMqZzr
         Ko34bdi/fcT9zK8hQhtosw4j+ABBaa7fJvhrQqhlVwpI2dg4OQiBdMiWSltSQsi2W9u7
         ++FWvJqX3PMpt/pafdVhd+OXdCzlI+amQO50g91WaVc6HrqMlN00DZOZlDd+WpwO4ZNB
         vc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EdLhCfkTp/+ES1NxZP/qC5aV2h/1GTWwLkGCzaWJOtk=;
        b=Gw8qUUspTt7gaLlRVRABAX2+93pC8v3nC//Eu6zFHhGexH6AIdIGap+niXt9OnoJoU
         F6+pV6UIj8r4CSr4cpsJESAQJ0lbXUO/9g+on6B92qSTDqx6jYgAm8+pnY/kZ/D3u0ix
         lcikaKiur97yEuXfu6Dtkr5CXQpJZC4JgszAuXDFBuhDQ0HoD9/10lWMg5wMgHYiVXVs
         ezOB1TT57CchxNtExnDsqEXjFq+KW5DVthBu5ePMZQlwSVw9vQwlBxwpEHInesMJahC+
         JBKVacv6FKe+TKFyP1Tmr/iMIaSKv0AAUD5IBSCEMt7MN4mHpToy4FeO2KyCsCgO8XAz
         qPkA==
X-Gm-Message-State: AOAM532Jv2AgShPzVhytlEZ0UNWA2I163GPfSrDpU8kM69iJgj0K++6e
        fVHckkbM4tG6nYpOeWdbUDVhZb3ckTBU66p/
X-Google-Smtp-Source: ABdhPJxFb0CsCJRCY2Ga0ew8OCSuNe0VnLPaAZrADwUSBIOqFdav2lsb58Jilp2hNoxmbBX4KBAqUQ==
X-Received: by 2002:a1c:2b04:: with SMTP id r4mr16020464wmr.168.1629718578755;
        Mon, 23 Aug 2021 04:36:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g35sm20555313wmp.9.2021.08.23.04.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 04:36:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 02/13] refs/files: remove unused REF_DELETING in lock_ref_oid_basic()
Date:   Mon, 23 Aug 2021 13:36:03 +0200
Message-Id: <patch-v5-02.13-a20548c1a4d-20210823T113115Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.g438caf9576d
In-Reply-To: <cover-v5-00.13-00000000000-20210823T113115Z-avarab@gmail.com>
References: <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com> <cover-v5-00.13-00000000000-20210823T113115Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The lock_ref_oid_basic() function has gradually been replaced by
most callers no longer performing a low-level "acquire lock,
update and release", and instead using the ref transaction API.
So there are only 4 remaining callers of lock_ref_oid_basic().

None of those callers pass REF_DELETING anymore, the last caller went
away in 92b1551b1d (refs: resolve symbolic refs first,
2016-04-25).

Before that we'd refactored and moved this code in:

 - 8df4e511387 (struct ref_update: move "have_old" into "flags",
   2015-02-17)

 - 7bd9bcf372d (refs: split filesystem-based refs code into a new
   file, 2015-11-09)

 - 165056b2fc (lock_ref_for_update(): new function, 2016-04-24)

We then finally stopped using it in 92b1551b1d (noted above). So let's
remove the handling of this parameter.

By itself this change doesn't benefit us much, but it's the start of
even more removal of unused code in and around this function in
subsequent commits.

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
2.33.0.662.g438caf9576d

