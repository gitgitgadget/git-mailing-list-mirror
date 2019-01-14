Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 539B1211B4
	for <e@80x24.org>; Mon, 14 Jan 2019 18:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfANSfJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 13:35:09 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39531 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfANSfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 13:35:09 -0500
Received: by mail-lf1-f68.google.com with SMTP id n18so8414lfh.6
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 10:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qS3BNiSUt2fZfz0WCH9bVtrLjGAdEPGYhOcH46aAxdo=;
        b=haqqwqrhsBJzjl2IESdFjqgO7nDnt97WrFbm+gwfiSSypsdLCTQqrrzLJD5RbkY5Cf
         R567qvEwV7KefDnDPEUJnuOx5tahSLp1lOx/bIITs9boMBVh4NiyX6QJDfWbh644+9B5
         PsQ61QnTxDQY++wNrXu5x9QVJwk+ZoGVTeGJpDVIBynTVndrpHTJxq0KYjcYnLg/tFW0
         U5cCIIIh61cX+3ke7FqP+0VTlW+hSNO6+wx4Qd9P/qGvUu5o46xZwKv7AkM+EDhDerfO
         TaT/IQF8GwOk0gMbgOMiWDmAYTESmVPTmkrndcOveaDH9F/iq0f9TBAq+CLozMHrj/no
         fwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qS3BNiSUt2fZfz0WCH9bVtrLjGAdEPGYhOcH46aAxdo=;
        b=olkQR4chUqCsNKleXitcYOblJHB69lKpWq61fLxLzJp/rq+GHgzR1wTa1DdBhWyfRj
         hB1SNtOjdmgdBuhh15U1e9r9mza8e9jBNktizsj1AuVi1FkrwGFt4P7PJopLzGHja35u
         GENHiYW0KbFVcgTOqYjdvQbaqy40kiUE9QQYo80wQ7+ECnQAwPIlzSA6Xv9d0F2XJfz8
         J5Zqzdh4LQ2wj5WXTtzspcorrm+u/UTLTfTDR3OlKr9EbPX5HGnzYh4Xz3TDIhtge6Xe
         nLSRohR4j0ABaA5VaGPozktvr1+Rb4+lqBJ3VSDI2sbCZtul9vGKtYz6MUqQEHjiV0jY
         C5yg==
X-Gm-Message-State: AJcUukfIZ4ujMCXMn8RnRgPiyA2mwX7e/fMOLHNYKjYRctiwXBEgykQA
        5jwM65zXjrJ/9qd8WBaHocsg1b/b
X-Google-Smtp-Source: ALg8bN7LsDYrsRqaTLTK3s2jLK/bB8jHDz8SvvAEorAhrr1kbVuwCb33kOcy8WVQdZ1vLxbi1w3UXw==
X-Received: by 2002:a19:7352:: with SMTP id o79mr15329853lfc.104.1547490906601;
        Mon, 14 Jan 2019 10:35:06 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id x24-v6sm224492ljc.54.2019.01.14.10.35.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 10:35:06 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 1/3] setup: free old value before setting `work_tree`
Date:   Mon, 14 Jan 2019 19:34:55 +0100
Message-Id: <8585c0bfdc071f17e75346b801a16580d360c18a.1547488709.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1547488709.git.martin.agren@gmail.com>
References: <20181218072528.3870492-1-martin.agren@gmail.com> <cover.1547488709.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before assigning to `data->work_tree` in `read_worktree_config()`, free
any value we might already have picked up, so that we do not leak it.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/setup.c b/setup.c
index 1be5037f12..bb633942bb 100644
--- a/setup.c
+++ b/setup.c
@@ -411,6 +411,7 @@ static int read_worktree_config(const char *var, const char *value, void *vdata)
 	} else if (strcmp(var, "core.worktree") == 0) {
 		if (!value)
 			return config_error_nonbool(var);
+		free(data->work_tree);
 		data->work_tree = xstrdup(value);
 	}
 	return 0;
-- 
2.20.1

