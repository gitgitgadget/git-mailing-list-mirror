Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BB9C2BD09
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 11:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7C2207FF
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 11:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0fjLYgn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfLILxL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:53:11 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52845 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbfLILxJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 06:53:09 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so15138464wmc.2
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 03:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WRCuS8uoGdooWawEks4A6ADDNXlbiIEL6gyZ7gENGQQ=;
        b=N0fjLYgniiHtCz+NxfGQmOP+VkBI/Zh4GZupKh61vBxIsV+MBGBcMbmAEOSmMHkE8I
         XjX+7Wp0iSUwemDbBC6/slfEGJPqQWWAvb+ZEmVTmolcHPQA4E8XHNfrtQJCJyC9seA5
         HGeyaCslHk6Z9GZFOnp/LvpOidiuf5BP3RZmsepC7agvjjg4lfFBJZDOLyddeDcW3zXN
         QY6rOGFtH0ivCmlgTn38l3iFA9LCFoKfZEyKmQyY5M5GHYzsvUmMKZZQf3k4HYtu311k
         mF6nDPeC4fOcZqvK6KZBkUwDl3gSu8j0Rn8jHNiO3auXa+KuBqeioltQ+du52pkysRPG
         5ItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WRCuS8uoGdooWawEks4A6ADDNXlbiIEL6gyZ7gENGQQ=;
        b=G71RvFqWMnnOIdepO9HGJZuW8OfjhflvzUF6cqII8d1VqQdQ0mo+2yOJRNziRJ/elx
         YZBsiW51MKdW70TNGBZtSpsKN1CX9wFxLg4zzGDJ8pm/Y7YR8L760yogT4BGvs62rp8Q
         sHfFvfuNZqvGYa29lxNM3EIPk127H1pfNsCEC509eRVW7VZV9SUP6QcPGGYs+IghMdnN
         ITYofjPd3sFrzMvbSEDgm5fybL30H8n4o4WFUvsbXEc7lgouWpNhUbHQWc2KU4Mkbzja
         Zqi36sKWfCK9KaEBBDO3WZI/pNq5+FFqefSK/y/vCmxbf3k1W18DNGBMkgjRcvztKLP/
         GHdQ==
X-Gm-Message-State: APjAAAUXzE7xGoH8UpnExNYdS04DqF5s+f41NKsdwluUJsBJz/XoN7Hv
        43KFK/NL4zpO0AQQdcVl2FI=
X-Google-Smtp-Source: APXvYqzrQuvjUCcl5+esy4ROfHXXsvNwBGn7R0R2ihrCTiyQL/OX2HeQUmXm2a7Unr1JyRAYTd3qNg==
X-Received: by 2002:a1c:a70e:: with SMTP id q14mr24217037wme.142.1575892387640;
        Mon, 09 Dec 2019 03:53:07 -0800 (PST)
Received: from localhost.localdomain (x4db55b9c.dyn.telefonica.de. [77.181.91.156])
        by smtp.gmail.com with ESMTPSA id k8sm27239621wrl.3.2019.12.09.03.53.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Dec 2019 03:53:07 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 04/14] name-rev: avoid unnecessary cast in name_ref()
Date:   Mon,  9 Dec 2019 12:52:48 +0100
Message-Id: <20191209115258.9281-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.801.g241c134b8d
In-Reply-To: <20191209115258.9281-1-szeder.dev@gmail.com>
References: <20191112103821.30265-1-szeder.dev@gmail.com>
 <20191209115258.9281-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Casting a 'struct object' to 'struct commit' is unnecessary there,
because it's already available in the local 'commit' variable.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/name-rev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 15919adbdb..e40f51c2b4 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -272,7 +272,7 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
 		int from_tag = starts_with(path, "refs/tags/");
 
 		if (taggerdate == TIME_MAX)
-			taggerdate = ((struct commit *)o)->date;
+			taggerdate = commit->date;
 		path = name_ref_abbrev(path, can_abbreviate_output);
 		name_rev(commit, xstrdup(path), taggerdate, 0, 0,
 			 from_tag, deref);
-- 
2.24.0.801.g241c134b8d

