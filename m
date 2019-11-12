Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF3C11F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 10:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfKLKig (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 05:38:36 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41584 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfKLKif (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 05:38:35 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so17909367wrm.8
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 02:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O+uwDpL5C8Es92Es/gA1mmITlPbqqGIFZ6Uf0BqL2es=;
        b=WFnGGcIy21BBJxSjisKFF1b676Q1PS62/eT9lS612GCyl+Cx5NDB4aIwYh/SlHpMQd
         +IGhsKZa8udxrUm4IrBndSGSqpYgKeYWxixoIEBUsao8ziATzLf7WaNyTf2W3WNuCkV+
         okZ/fXZMJEnZkVismLAXO008MR+R963zF0phmAESugEM0eUfx0GkpMWYfagIYQi+p05T
         N+zoUv8zTCbttfIXXMJcv80+DBm10pDwKdT/c8kxVx3f0mTZQdaaPt6FNQHD6q08BU0o
         s4O3VSoyCNW5kOrnqex5XT5/kzb4ZwD9FJVfY86O7pNOi+PNasyOFQLXWAsqiCDsWI0t
         yfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O+uwDpL5C8Es92Es/gA1mmITlPbqqGIFZ6Uf0BqL2es=;
        b=OwiGD7q19IMYcec8MvOAWbxGDunguGCuYhC/yuA+gvkdetw7xKk5w9c5wEdhJ9qEOj
         BEMN+g1ifRHgTE2vCMgezyqXozvjQWgiInfQ1zDtyWYdbj567kiBKlA2Jwh8IUtuNoAO
         OnQr92rcAWg95Dqq6TRGzcvllqEMbbfj8UNPgPfcBYL0yYuujypka+nwldf1SE/jzKYf
         pjFjWB69LYi6gRCzdRBGnRMO/ucD5J+HMTJjRI+HjGszsOhhCjcT6vNq8aEDfNPMFhMK
         F2IVsqikneEp7IKrDcwLJaw61F0/p63xh4FcdmgSgn7CHVQhUm0unad8rpF93og2p+m2
         PV/A==
X-Gm-Message-State: APjAAAV9rgUuRr9FMVTybfBILmLjw+cK+ZfOby950vSESBWwFNyqW/C2
        nW7GDdIldxElQXXDvY/A1bM=
X-Google-Smtp-Source: APXvYqzTGRUHJCWdLX6Wnq39DuW7SowYtUFyZ5AmMdqGvrYsTeur9MQh5wytqNY+rPKetdfXDCP9Xw==
X-Received: by 2002:a05:6000:343:: with SMTP id e3mr26332671wre.20.1573555113337;
        Tue, 12 Nov 2019 02:38:33 -0800 (PST)
Received: from localhost.localdomain (x4d0c65ae.dyn.telefonica.de. [77.12.101.174])
        by smtp.gmail.com with ESMTPSA id f24sm2313759wmb.37.2019.11.12.02.38.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Nov 2019 02:38:32 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 03/13] name-rev: use strbuf_strip_suffix() in get_rev_name()
Date:   Tue, 12 Nov 2019 11:38:11 +0100
Message-Id: <20191112103821.30265-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.388.gde53c094ea
In-Reply-To: <20191112103821.30265-1-szeder.dev@gmail.com>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20191112103821.30265-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: René Scharfe <l.s.r@web.de>

get_name_rev() basically open-codes strip_suffix() before adding a
string to a strbuf.

Let's use the strbuf right from the beginning, i.e. add the whole
string to the strbuf and then use strbuf_strip_suffix(), making the
code more idiomatic.

[TODO: René's signoff!]
Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/name-rev.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index b0f0776947..15919adbdb 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -321,11 +321,10 @@ static const char *get_rev_name(const struct object *o, struct strbuf *buf)
 	if (!n->generation)
 		return n->tip_name;
 	else {
-		int len = strlen(n->tip_name);
-		if (len > 2 && !strcmp(n->tip_name + len - 2, "^0"))
-			len -= 2;
 		strbuf_reset(buf);
-		strbuf_addf(buf, "%.*s~%d", len, n->tip_name, n->generation);
+		strbuf_addstr(buf, n->tip_name);
+		strbuf_strip_suffix(buf, "^0");
+		strbuf_addf(buf, "~%d", n->generation);
 		return buf->buf;
 	}
 }
-- 
2.24.0.388.gde53c094ea

