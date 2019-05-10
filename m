Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 111091F45F
	for <e@80x24.org>; Fri, 10 May 2019 13:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfEJNiI (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 09:38:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35094 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfEJNiH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 09:38:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id q15so3578310wmj.0
        for <git@vger.kernel.org>; Fri, 10 May 2019 06:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h6ta50T5M0eaQw5z152cH/XrezyiQUl32x/nwv8nkXM=;
        b=uuibwIp5wUj164MRXbDBII0+DEbb04UXtHQ4dY2MGY7Im3pK3MkeTsewtwI33b2E7n
         1VwRM9DcE/1Us4B39Oj6r4UJyQWZ9hYSfs34ABFnO+tfwYc9rk2IsS+cBdqflCZtvqZ+
         JULKQOjvl1jP5lPMUbYYaZ/lAYXMBKdCB2UZywZytEW2Gu48udfHTO5LuPEzLEnFiJLM
         UBZ1TAgKT2tc/Y2ZVWuCWDaIwZTixVPrds1E12p+SkR6+vtIErU5iiqnRS8X+XicB0Cz
         qn8+y7KOuGHePTNcS5xW2mce/j2f5FS9FGTjjFGss416C64dYszqO+PC6++MokxOgd+Y
         72uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h6ta50T5M0eaQw5z152cH/XrezyiQUl32x/nwv8nkXM=;
        b=KtfXbWELEekta+4oGlOwdxOS1NFNAhALG8BdMBPCTBKsSxkoNd1Gib7cfyew4zUc4J
         t4RAtQ9YfuTgRkPtZDb9qN2E9YGIezj2RyagIexc2uQPmP+ZVaZ87qo+9fQj997WNmZX
         I0ZBOSSmVKt3kUTnki6wifT/0IVTnu+JA2eYhw1NfXUkojSzE9vxgKwFnh0spUgOrkF1
         IbXPNeFNGy562bffRg8G5oEhTbboKJrnX0yYNhan02dsATN+FvQCYZgp+Cg7PLYIJ7Bf
         +WZ+D7V+rrDRJZ9+o9Ld6cBsBm46T5pYc6Xnq2YtTTOeeil6pkUk2080SHol8MDvqVxT
         6nuA==
X-Gm-Message-State: APjAAAU4cAVwvcGHiS7vygZB5cIKuQUnuAZjl21QA4TUpZMF1QLwfSlz
        VIckey0K/LXEKqSOJb3jGAeKqkNU
X-Google-Smtp-Source: APXvYqxV96867KSych+BM4XSRSoV+FTtSKvLtx4P42BG1BwEljAR3PKQa2cL0/TcVUrTdPoOUNbEag==
X-Received: by 2002:a1c:f111:: with SMTP id p17mr6465080wmh.62.1557495485551;
        Fri, 10 May 2019 06:38:05 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j131sm11310673wmb.9.2019.05.10.06.38.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 10 May 2019 06:38:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] trace2: fix up a missing "leave" entry point
Date:   Fri, 10 May 2019 15:37:38 +0200
Message-Id: <20190510133738.4511-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
In-Reply-To: <08be5aadbef7f6b404d2e1c47cf3657ced585ba1.1550874298.git.gitgitgadget@gmail.com>
References: <08be5aadbef7f6b404d2e1c47cf3657ced585ba1.1550874298.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a trivial bug that's been here since the shared/do_write_index
tracing was added in 42fee7a388 ("trace2:data: add trace2
instrumentation to index read/write", 2019-02-22). We should have
enter/leave points, not two enter/enter points. This resulted in an
"enter" event without a corresponding "leave" event.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 read-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 61b043bac3..4fad4e3f9a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3131,7 +3131,7 @@ static int write_shared_index(struct index_state *istate,
 	trace2_region_enter_printf("index", "shared/do_write_index",
 				   the_repository, "%s", (*temp)->filename.buf);
 	ret = do_write_index(si->base, *temp, 1);
-	trace2_region_enter_printf("index", "shared/do_write_index",
+	trace2_region_leave_printf("index", "shared/do_write_index",
 				   the_repository, "%s", (*temp)->filename.buf);
 
 	if (ret)
-- 
2.21.0.1020.gf2820cf01a

