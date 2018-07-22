Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2DE61F597
	for <e@80x24.org>; Sun, 22 Jul 2018 09:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbeGVKyJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 06:54:09 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36472 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728342AbeGVKyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 06:54:09 -0400
Received: by mail-io0-f193.google.com with SMTP id r15-v6so7034853ioa.3
        for <git@vger.kernel.org>; Sun, 22 Jul 2018 02:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CYQZ73MY67faggMP2u1nDTZEYAO461FBJJdHNJqAsU0=;
        b=HtvDVJ9SK6X98F4k273FOJrKAb8Ee2I1hn1baJkqesBgE7FqEHsKfiZ4v4Uyanc2HZ
         j05/XdyqGw81xygYJjcKhudAgeBo6150JkhitoUUE85qL8XZN3vPYxzEdZSwJizGYFIL
         qg0UXa6fwEeqaXXDaEk3bQxcXjvAu2dD+PzgdXIIyqHbM8c/5PT0qtIt3t/Wn0KN09f2
         Muk1h9f6Tchf1xTxcn7K3pvbzR+ldwu0IumZwUnap4sIcNI2czj84W+7LGF7DnfgFcR2
         yGd0sQOuWS65mMcjG1ifPYahmK0C42mBVSBMtPN1zRZsQNlAU0RX6S1L4f7st3HkiRR2
         oMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=CYQZ73MY67faggMP2u1nDTZEYAO461FBJJdHNJqAsU0=;
        b=PQDcHzEpiYAcu7YlWZ/zeiu57Xd9/Br94IfDqnX4zIJQxW3xNxgHwseIl4i/kcuat+
         joZHthzYWsIwgJi72i98t3JWSEm646aXD1CT5wKf+zvU/9xH0PMtk89A7yL3LYp7bOIa
         2O5gq8VoKdw2KuNFDS04KfGla9JyxsiAgrzk3hlf5gC457Qrw4GiYEaIpdxORu6xU+RN
         GFC80DUMia6zvaJfJDolRpiQnU2fsXBsdo1vg+4MGgdzT0LlUYUkD8dAE0vd88vV3gNN
         QDa3t6vz0P/uF6emixOf8KztGpqhANQAmE+eKOr4OTs231yehSC0oLHZ6PftSGTmH1Qk
         KtSQ==
X-Gm-Message-State: AOUpUlGFD22dsX3BBRuxgHUlUAoLzDheksixBsItGWycBQJwgRgh5pEZ
        tOXOg96Sv7N/oL2HNi1b5rMiuw5a
X-Google-Smtp-Source: AAOMgpeSxmXmAu6ZIHt4tKttv/fV/xK16oQPsFp9r7ZWBYooLc+RKwNaSJpBxN5rmkmPiiojKiNguA==
X-Received: by 2002:a6b:4a15:: with SMTP id w21-v6mr6253216iob.277.1532253479948;
        Sun, 22 Jul 2018 02:57:59 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id w13-v6sm3681298itb.29.2018.07.22.02.57.59
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 02:57:59 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 04/14] interdiff: teach show_interdiff() to indent interdiff
Date:   Sun, 22 Jul 2018 05:57:07 -0400
Message-Id: <20180722095717.17912-5-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180722095717.17912-1-sunshine@sunshineco.com>
References: <20180722095717.17912-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A future change will allow "git format-patch --interdiff=<prev> -1" to
insert an interdiff into the commentary section of the lone patch of a
1-patch series. However, to prevent the inserted interdiff from
confusing git-am, as well as human readers, it needs to be indented.
Therefore, teach show_interdiff() how to indent.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/log.c |  2 +-
 interdiff.c   | 13 ++++++++++++-
 interdiff.h   |  2 +-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 99ddfe8bb0..8078a43d14 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1086,7 +1086,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 
 	if (rev->idiff_oid1) {
 		fprintf_ln(rev->diffopt.file, "%s", rev->idiff_title);
-		show_interdiff(rev);
+		show_interdiff(rev, 0);
 	}
 }
 
diff --git a/interdiff.c b/interdiff.c
index d0fac10c7c..c81d680a6c 100644
--- a/interdiff.c
+++ b/interdiff.c
@@ -3,15 +3,26 @@
 #include "revision.h"
 #include "interdiff.h"
 
-void show_interdiff(struct rev_info *rev)
+static struct strbuf *idiff_prefix_cb(struct diff_options *opt, void *data)
+{
+	return data;
+}
+
+void show_interdiff(struct rev_info *rev, int indent)
 {
 	struct diff_options opts;
+	struct strbuf prefix = STRBUF_INIT;
 
 	memcpy(&opts, &rev->diffopt, sizeof(opts));
 	opts.output_format = DIFF_FORMAT_PATCH;
+	opts.output_prefix = idiff_prefix_cb;
+	strbuf_addchars(&prefix, ' ', indent);
+	opts.output_prefix_data = &prefix;
 	diff_setup_done(&opts);
 
 	diff_tree_oid(rev->idiff_oid1, rev->idiff_oid2, "", &opts);
 	diffcore_std(&opts);
 	diff_flush(&opts);
+
+	strbuf_release(&prefix);
 }
diff --git a/interdiff.h b/interdiff.h
index 793c0144fe..01c730a5c9 100644
--- a/interdiff.h
+++ b/interdiff.h
@@ -3,6 +3,6 @@
 
 struct rev_info;
 
-void show_interdiff(struct rev_info *);
+void show_interdiff(struct rev_info *, int indent);
 
 #endif
-- 
2.18.0.345.g5c9ce644c3

