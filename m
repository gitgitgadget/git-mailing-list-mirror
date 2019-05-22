Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F12A1F462
	for <e@80x24.org>; Wed, 22 May 2019 00:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfEVAfA (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 20:35:00 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:40706 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfEVAe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 20:34:59 -0400
Received: by mail-ot1-f74.google.com with SMTP id h4so379499otl.7
        for <git@vger.kernel.org>; Tue, 21 May 2019 17:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cufynq4DmDL2OWqhILwbYiGRXD9W0qefnOoC3fN7w2g=;
        b=gV1IoiwAqiwDJxMmEcCZbxgWxuh7zcUAHQ4IwuLZxwvb8BxlUE8gAKXYKGwGjPB6xq
         U+NVZirHLUpRGgimVgBjGCrh+hCWzoBlWDr47S7k3Rq2djO/pdoFAH0DRziYTg7oHnf8
         IDBwZm4pnFLErOgS3z8VSsxgbLoZZ4RAZ/C40R4xRQIHztVd51qGo1Q2WXO36IZv54BT
         b/c2dOWZZ21VIG350wO8cQ1PlDeaVrVdCIcf9AhWPmzQuKxOZybGfS9KxmgHXJ3519n0
         tIf3CNJ4HJMwHHAAL6blPdBX1njXAywfcxhw1GMZDDO6tRphcJJxF16Dr9hWbp+5JJk6
         b+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cufynq4DmDL2OWqhILwbYiGRXD9W0qefnOoC3fN7w2g=;
        b=CY431RgM+E4AjSrO5GB9MG2/vmuP4cdVFdeXDzUqnswchUHTYzYQqDp/FsJb5bihvm
         +TLNl7UrjPkOFTDp+LbKg7k5BTMEcHIiOiyftn5GT63eDpToUjNZrAUXoJH2GPdDf1r1
         /SxXIULUbuTWm4rUC3/zGJMoPgTx4BhIZzG64IrCG4oRDTPLKqhet16yuCD8LUvEi1Zh
         Y6NERb8s8TW6bY3i9j6LOVzDtXbR9nXyA72h0w3BfL5v3UCIzU1m754hzPnmwRhMrivZ
         8U5hc7YB76DP2lRjpjGon7sKeDZE3QOc7mbn6pBpVuoS4wNmv4VQ1a2y/BqO95YteMTA
         o+TQ==
X-Gm-Message-State: APjAAAX6Hie8N9cmredvC5THwZesIwKoJH2cl9p6QijVhV2/yZqfHWTN
        dT50t+8ZaKEfP1BE9yQid22tr7t14FEls7Ekvi0=
X-Google-Smtp-Source: APXvYqx16YE/CnHZ80KqyDpe74/rNgQFCpmabc0YMMAX/gTFYxU31+PSG0xdS2XHAM8cyY2zPA/K6FHyqwwTj8MTUNc=
X-Received: by 2002:aca:558c:: with SMTP id j134mr5226938oib.3.1558485298997;
 Tue, 21 May 2019 17:34:58 -0700 (PDT)
Date:   Tue, 21 May 2019 17:34:02 -0700
In-Reply-To: <20190516214444.191743-1-emilyshaffer@google.com>
Message-Id: <20190522003402.77767-1-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190516214444.191743-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v3] grep: provide sane default to grep_source struct
From:   Emily Shaffer <emilyshaffer@google.com>
To:     emilyshaffer@google.com
Cc:     git@vger.kernel.org, jrn@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

grep_buffer creates a struct grep_source gs and calls grep_source()
with it. However, gs.name is null, which eventually produces a
segmentation fault in grep_source()->grep_source_1()->show_line()
when grep_opt.status_only is not set.

This seems to be unreachable from existing commands but is reachable in
the event that someone rolls their own revision walk and neglects to set
rev_info->grep_filter->status_only. Conceivably, someone might want to
print all changed lines of all commits which match some regex.

To futureproof, give developers a heads-up if grep_source() is called
and a valid name field is expected but not given. This path should be
unreachable now, but in the future may become reachable if developers
want to add the ability to use grep_buffer() in prepared in-core data
and provide hints to the user about where the data came from.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

I think Peff and Jonathan are right. If someone does want to hack away
on something in the very early stages, the BUG() line gives a pretty
clear indicator of what to modify to make it work.

I also moved the BUG() to grep_source_1() to keep it close to the error
itself and reflowed the commit message.

 - Emily

 grep.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/grep.c b/grep.c
index 0d50598acd..f7c3a5803e 100644
--- a/grep.c
+++ b/grep.c
@@ -1780,6 +1780,10 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 	enum grep_context ctx = GREP_CONTEXT_HEAD;
 	xdemitconf_t xecfg;
 
+	if (!opt->status_only && gs->name == NULL)
+		BUG("grep call which could print a name requires "
+		    "grep_source.name be non-NULL");
+
 	if (!opt->output)
 		opt->output = std_output;
 
-- 
2.21.0.1020.gf2820cf01a-goog

