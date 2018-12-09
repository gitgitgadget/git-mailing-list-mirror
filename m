Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91F2120A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 20:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbeLIUFD (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 15:05:03 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41288 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbeLIUFD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 15:05:03 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so8431186wrs.8
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 12:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nJGaB58FVsS5jxtSvE0P91JPilGw8ccwEcTgQkXH45k=;
        b=r1xH9jvhvqs8z8NLSFB8qMYV8MHxTEVlutfN737CRePdDBu3AdZIxJnioT5iCgXXa+
         bxt+d6wjOFe2hTFv9uRuKFGOcrFQLOEVWigKu17Q8SZaGUXfSCriShCvQ6ozJVwmQdK9
         uvOc2nWSv4rc1a6b2mzFHgIr6CPaTEguje0u7CSR+b8GxcpFHyTYVEnF1cyQ6F3Fb4OL
         ZkJCE90QzzCSQMeYvMVKPnzFJGPujSmIRG3Ik5+G/4oiy1t0Q46A7MbM1GbgJmk0nlkq
         df/8T7nwWJKGVr4kcC6KJZjToy+iKqAY6jWtZ/0bLPlZ4C2WHJBAJpXNcOGhl3vAJZGX
         iqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nJGaB58FVsS5jxtSvE0P91JPilGw8ccwEcTgQkXH45k=;
        b=M24HcWLqizQwIh1BjxCRy5yfWsnnOmJ5hPthFCh4dIYcbCiqIeP7qd6UO4OeQBpAiF
         EeaslILuGkPb9qN5Y8iz3/G72ZVRsyrTq8Yct5H2JeGcmzhs9NrGRcCAh7h8eT7Dqprq
         PkcXSeGKt7WwS9dVhxTsTziESb1Eby0cCq+y2lfW71nVIqAv8OCKjz91U2AVnQeey64X
         O6UHU5NbIaX2q6JQzwoGpoDW79ttYsxLdKWRt52Hf2inm8XuuE+aWkswHsPJdM+Lw8V8
         KzqBGloLN2yLAhet9ZHU89IIkRaW8OWLthfilTHG0GHZwTERSqrDvR/vc//0a2TUFcIt
         jGuQ==
X-Gm-Message-State: AA+aEWaXv2LUtFv7p8fyezVNTGG4wDwf6OA62J3yGgFZuO8ATeWyQx/H
        v1+dvuFYc+kvTLjs2k+c7WMhgJap
X-Google-Smtp-Source: AFSGD/U2yaDUyL8EgWNvtCSRoQpNpRCbhqg+Zko84xFQb66xek+EGLHvpuvyMvTgwl9m4OY+PCS8iA==
X-Received: by 2002:a5d:524b:: with SMTP id p11mr7382287wrv.147.1544385901404;
        Sun, 09 Dec 2018 12:05:01 -0800 (PST)
Received: from localhost ([2.24.105.121])
        by smtp.gmail.com with ESMTPSA id m6sm9196770wrv.24.2018.12.09.12.05.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 12:05:00 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 3/8] entry: support CE_WT_REMOVE flag in checkout_entry
Date:   Sun,  9 Dec 2018 20:04:44 +0000
Message-Id: <20181209200449.16342-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85
In-Reply-To: <20181209200449.16342-1-t.gummerer@gmail.com>
References: <20181209200449.16342-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'checkout_entry()' currently only supports creating new entries in the
working tree, but not deleting them.  Add the ability to remove
entries at the same time if the entry is marked with the CE_WT_REMOVE
flag.

Currently this doesn't have any effect, as the CE_WT_REMOVE flag is
only used in unpack-tree, however we will make use of this in a
subsequent step in the series.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 entry.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/entry.c b/entry.c
index 3ec148ceee..cd1c6601b6 100644
--- a/entry.c
+++ b/entry.c
@@ -441,6 +441,13 @@ int checkout_entry(struct cache_entry *ce,
 	static struct strbuf path = STRBUF_INIT;
 	struct stat st;
 
+	if (ce->ce_flags & CE_WT_REMOVE) {
+		if (topath)
+			BUG("Can't remove entry to a path");
+		unlink_entry(ce);
+		return 0;
+	}
+
 	if (topath)
 		return write_entry(ce, topath, state, 1);
 
-- 
2.20.0.405.gbc1bbc6f85

