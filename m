Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBD5C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237564AbiHBPze (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237503AbiHBPzM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:55:12 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDA432449
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:55:00 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id b6so7416185wmq.5
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=1DS8P67aDbPXoMR3pxsEeQvKpzY8UkK/mp7zqV0VurQ=;
        b=lRqhKaFyauJJldLMfJhcQ4b3J3sdrXAoDOr9BJ0z0sIztInHFDFf5zgeTPUMrXGV7m
         hNq3KKABGtR1ppf6cOeC0svzsqz+PaWhwEFYweOTEj0UMcmZrQLfpuzyik6vnJyx3zug
         m70QxgZn29TxQeh6vsC7rKzmXKImXulX57afalcF0MkWPPVTpP3z6uJHSD+dVxCVn2Dh
         B01ztf4VCBpP/Ko8tXZIzQeOci6vrKPbJ1EUhCtSMy8tsEBO6tc5m78uBUL4FMgSetV4
         rLgFYaq9zIZXeY34Ozr1rmz8fQKWqd3GabzLNWRx9vP83+nGr3wXwaMqRyvT37cQLICV
         NeTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=1DS8P67aDbPXoMR3pxsEeQvKpzY8UkK/mp7zqV0VurQ=;
        b=b7oYPEq9OSgVPA53aXtxa9OPMeH+doQ8ueQXEJeJ9tyvOykcvpJ6VpyFjt+RUgMgOx
         ZiRvuR9nz1kv46JKSGYpkp1SguiZBxdjXdLAHmv/j8HtsCVv90gpA+d3JkQT8X8evFRX
         Hzxt/qrS9laRGqYGgZDxLsIg9OuPgGSKTBJp9RhLmjJcNq1M6ed4GWseTah/YInxbzTW
         si4/x/U96u7wyb54QqVhNwzZRKzRsfGSojSi5W9VHRF6+MJETpeNsWMC+FeLSGt+M9PG
         vKd2dnN4NWavvHlk25idmUHG+T5q4O5ydfbP6s6TjfBnSo/LI3dF1KV3yn6YxBxeqK2G
         eEtw==
X-Gm-Message-State: ACgBeo1WH0YvMqOHix6tkjALZJtB8sxAjzwrpZ6JEp9IGC5n29BsB2CX
        9Z4f46C4S2F1RbxE8og/CRbeBZhy6XWi/Q==
X-Google-Smtp-Source: AA6agR6+c8ZBev5A8SoROn6ePCik2qCCgyC443bFRSIkso72bU+TnDfMWkp6uPXHQfHK2xOv+MCAHw==
X-Received: by 2002:a05:600c:1c19:b0:3a3:181e:89e with SMTP id j25-20020a05600c1c1900b003a3181e089emr59298wms.203.1659455699024;
        Tue, 02 Aug 2022 08:54:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bg3-20020a05600c3c8300b003a327b98c0asm23562286wmb.22.2022.08.02.08.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:54:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 14/17] submodule--helper: fix a memory leak in print_status()
Date:   Tue,  2 Aug 2022 17:54:38 +0200
Message-Id: <patch-v5-14.17-2429db2f1c7-20220802T155002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
References: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com> <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a leak in print_status(), the compute_rev_name() function
implemented in this file will return a strbuf_detach()'d value, or
NULL.

This leak has existed since this code was added in
a9f8a37584a (submodule: port submodule subcommand 'status' from shell
to C, 2017-10-06), but in 0b5e2ea7cf3 (submodule--helper: don't print
null in 'submodule status', 2018-04-18) we added a "const"
intermediate variable for the return value, that "const" should be
removed.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 2fca6d66bb5..0f1846021e6 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -590,10 +590,11 @@ static void print_status(unsigned int flags, char state, const char *path,
 	printf("%c%s %s", state, oid_to_hex(oid), displaypath);
 
 	if (state == ' ' || state == '+') {
-		const char *name = compute_rev_name(path, oid_to_hex(oid));
+		char *name = compute_rev_name(path, oid_to_hex(oid));
 
 		if (name)
 			printf(" (%s)", name);
+		free(name);
 	}
 
 	printf("\n");
-- 
2.37.1.1233.ge8b09efaedc

