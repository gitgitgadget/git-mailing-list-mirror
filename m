Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C6A520A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 10:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbeLIKp2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 05:45:28 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34030 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbeLIKp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 05:45:27 -0500
Received: by mail-lj1-f195.google.com with SMTP id u6-v6so7105611ljd.1
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 02:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4b5AMO2ZrSmSOnyTsE91EaZ32QWfDehmIaDTEG9UpeI=;
        b=TYd9VPiGyN0Nknt7E+oweMhP2ES8r1PO+NC2oitznmTqIM6PBqXh5WRjV6P2M2pX34
         1UFJ1jKOchiXYi+Sm6QzVNt4Vp6hNqwvnRWo6D62vKzmQ7H9mlUbBtuXmC/Dy6N/LGV0
         cNFAAgRXAzc65jBBe8yu05IMyllKwJ5Y+EAuzaQzQ06rF7nIDk7kXYr5NQod0AWnv6VS
         gEKvUQV09eny9aEM3kXIXb3CkefenX2sCpqtDYIX1fwhsmW2V8vE/u9xE0feQepGMnXv
         ldd62L9VVJOyozSQGQWVK8MlwgAEr0lWtTYvq0OGWLpiRjLVqf7cTs6DB3jx/hLRU37s
         fbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4b5AMO2ZrSmSOnyTsE91EaZ32QWfDehmIaDTEG9UpeI=;
        b=Pb87PBxI73sPK8CLLCm0cxtBmwYyFHyGwgyVHwAPvrkziYBvr6xGDfKvBadGaSa1xv
         wbMtoqogaFlFXPYtYHImyN2SQ+WiWZZom5cX4UNmQJlSVn+IWQ1h3FazPFx3caRJ38ck
         s1JmwlTyDFdUiU+/GqVtyHK4goFtv7AVioz+5B0IDX1tGB7y130dnW9VQ/Kbs6tBdAWf
         4Q26GbXiGXJz4mR9VuMSnFyGptyH/oOUN9Do474pvmvrLglKhf6E4OrW0bSyuKnnnlZW
         ZRk3+PiF+XRyxRWkZRYjo+6V2/ED5Fpf8YppeM3qU+g2aiAKx5y0f069QY6xC+wZhor0
         9Rbg==
X-Gm-Message-State: AA+aEWZ9HRh8VdETjKZRNLY/SgCh5ErNu4ynXfBgp/5yzx5Afv9q0/lL
        K13YMZfZ5GSwrHn+56pHP4Dj2MYh
X-Google-Smtp-Source: AFSGD/VvFmlRJ+UdjN4n8Htkvwq/6/Na3gXLzFFrKsoCXnPu6D5f3W34FDa2Nwt4qul9Wxl8UUp/xw==
X-Received: by 2002:a2e:5854:: with SMTP id x20-v6mr4748094ljd.31.1544352323906;
        Sun, 09 Dec 2018 02:45:23 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id s3-v6sm1564938lje.73.2018.12.09.02.45.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 02:45:23 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 21/24] checkout -f: keep backup of overwritten files
Date:   Sun,  9 Dec 2018 11:44:16 +0100
Message-Id: <20181209104419.12639-22-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.486.g9832c05c3d
In-Reply-To: <20181209104419.12639-1-pclouds@gmail.com>
References: <20181209104419.12639-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index b5e27a5f6d..3ae001ae35 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -438,6 +438,8 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
 	opts.verbose_update = o->show_progress;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
+	repo_config_get_bool(the_repository, "core.backupLog",
+			     &opts.keep_backup);
 	parse_tree(tree);
 	init_tree_desc(&tree_desc, tree->buffer, tree->size);
 	switch (unpack_trees(1, &tree_desc, &opts)) {
-- 
2.20.0.rc2.486.g9832c05c3d

