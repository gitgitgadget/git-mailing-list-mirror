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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8086EC4743E
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 12:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D0046124C
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 12:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbhFHMTc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 08:19:32 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:54918 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbhFHMTc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 08:19:32 -0400
Received: by mail-wm1-f54.google.com with SMTP id o127so1683783wmo.4
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 05:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UxECZp7JY34KeX2gncBgWpBtcjabFvELktQrnq8fNPc=;
        b=C82B64JKGYC0NVWGxOJ8ZC5f6/RCpRMnZOc0x6eqmjJDNqS6NE6bbg+bgMq7Hm2Sol
         b4p3lcizkhagUfObMOCDspJWcsqtCWoNchpvQQ2On7eKLn6WpyKoWiWg8SA11dNw9EQP
         YCYRg0BYp5jElG3HzMzFcCW5aEwIV5FLcwFx3gpDTTONaMqjuaobaW3ZZvf5lv8GIfHq
         K7W6sXSM+/womcSZBenZWtR/CyoHUMqU+2aMMpobGFJa8OFIlqUUyyzUEBgRlrpmbb0G
         DmNhIkpI8et0Buw43HvxzT0XhwIB8YzQ0tIxPmzcHnCRQ+VFsi9A6jdYDVBE9w/+oOhR
         M/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UxECZp7JY34KeX2gncBgWpBtcjabFvELktQrnq8fNPc=;
        b=qtY6Nv31dPQTMDOtu8ECJoXGTdpqTaIEguSNv1YViM0dynFMCqFaM34c2Ox3wZwlDW
         YytK4sN97wGCkMbFig8g13ot/yBVKaLuQQZx0mrzLVjmvHMvOp+aKAHtrDagC/n3VCee
         KRHIl6hVuCuLpCVvVr6CY+wAa6xlqXE07dH6GQeoItxMGHA7FpLeHn/S/Sk0ialvaDOi
         UnG+5eUFUP/G7d6AVXmJTP3+5tE9+mNDE0EEt+kYfMNRe+gXBKAwx8tpPgfSgZHzAp4t
         +BbVyKiYZHnaCdJyuCCvDKZsOaozfmtU8nuUU1XUhzy8/rNbsfzcaRCMYcQ51Siq8wpl
         lwGw==
X-Gm-Message-State: AOAM533CgYR284EeetqcB5hwjONdioVP4jo5FOtJVqOIldklcrBp9iu1
        X/FKPb7wus21eLw8JiKL6Gk2orJsq8D0eQ==
X-Google-Smtp-Source: ABdhPJxF/Jj5gpBrofV36UAzKIjc1nF3PcGRIPGkRCn+aMQ3NzI013XglNW+F/p32dRfbqxPfqpCoA==
X-Received: by 2002:a05:600c:154f:: with SMTP id f15mr21618531wmg.22.1623154598350;
        Tue, 08 Jun 2021 05:16:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x20sm12976378wmc.39.2021.06.08.05.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 05:16:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/4] upload-pack: run is_repository_shallow() before setup_revisions()
Date:   Tue,  8 Jun 2021 14:16:27 +0200
Message-Id: <patch-1.4-c56a302e09-20210608T121008Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-0.4-0000000000-20210608T121008Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210608T121008Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the is_repository_shallow() added in b790e0f67cd (upload-pack:
send shallow info over stdin to pack-objects, 2014-03-11) to above
setup_revisions().

Running is_repository_shallow() before setup_revisions() doesn't
matter now, but in subsequent commits we'll make the code that
followed setup_revisions() happen inside a callback in that
function. This isolated change documents that re-arranging this part
of the code is OK in isolation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/pack-objects.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index de00adbb9e..1fbaa34f91 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3757,11 +3757,12 @@ static void get_object_list(int ac, const char **av)
 
 	repo_init_revisions(the_repository, &revs, NULL);
 	save_commit_buffer = 0;
-	setup_revisions(ac, av, &revs, &s_r_opt);
 
 	/* make sure shallows are read */
 	is_repository_shallow(the_repository);
 
+	setup_revisions(ac, av, &revs, &s_r_opt);
+
 	save_warning = warn_on_object_refname_ambiguity;
 	warn_on_object_refname_ambiguity = 0;
 
-- 
2.32.0.rc3.434.gd8aed1f08a7

