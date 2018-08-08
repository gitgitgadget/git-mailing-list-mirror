Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A08C8208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 13:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeHHQLE (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 12:11:04 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44316 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbeHHQLD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 12:11:03 -0400
Received: by mail-ed1-f65.google.com with SMTP id f23-v6so1278051edr.11
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 06:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sdGIkFhKgQ7CW3+0cianDC0ePmyMRxEpcRzI+AnUidQ=;
        b=Kwmxv/YxsQJxBS/5Os6XjOiNx7TDTwXDQMM8ue8g7Z4Wj1vZdSlOcaJMgzqu/8me7i
         wCN6nTeDmTDTETZk1IAOXd1k5qegg7kYwXdZAeHR/h3C8cVYukrqUE2VbuSeYvBQGKbm
         bBjlYHJiw4b9gsGHozBzybGFP08qRN6mi7jDW3F/wArGt74lyOgwBz9CEnkg4Tokcvmm
         Oja5oBrDDVQ1Xjl07/XnoBRiHnXVA4mSdr0bj43Vy7smXbhmJM2dWnqmzBDdYRawUPe7
         BtMK76gqrjvnCIqzxa0mhHeN6fBc72LCRhYfBlIC5xmJS88bXH3K2rUj/XVZo7HUvM6o
         VmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sdGIkFhKgQ7CW3+0cianDC0ePmyMRxEpcRzI+AnUidQ=;
        b=VpTbhmeg3r6mZd6wm6I62pb/7GCPovuNaQKiJmAl86k+Kjx5iqmPaD7UPEt5E6uo0l
         a0mSH2tXZvF4TPx3cdqbIgOpLRFngmPShoLivP2krT4F1F+aDyp4/T2t556SvKR0rkz+
         uaXroVdQrXIHEjg13QXkJWEwA2cL/LEtDxPJg5AIyXOMpcVSi9JHyiF3K7ErIYslIpSL
         3YZgduS7R81OXPrdqjNMfvlZ0PGXIfRjQuf0fzgnQIWY3Gh3Kv1Lc/Xwf6SwsO1EmOup
         XxnTuSm6MuDbuSeNMqocVvxQXLnn2qYkM7SjhtZgtvx+RL4PYNemrl7jCGkOw/KFznt1
         WHuQ==
X-Gm-Message-State: AOUpUlHuCjZwpK0BpGf7FCKrZahCHJuEh4Zzv4ZIEb7BfAx8JVlzfgWh
        JPa46U1D14FF+DdaMUrLFM8QPI6g
X-Google-Smtp-Source: AA+uWPyisLB8FGm5xSL+ZFwVsr6AuRqE40pdBkEqiDV7mZ35wz4qQjXk6o2ZPKeOXMr3eL8O/RxaLQ==
X-Received: by 2002:a50:b822:: with SMTP id j31-v6mr3319146ede.76.1533736276648;
        Wed, 08 Aug 2018 06:51:16 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.181])
        by smtp.gmail.com with ESMTPSA id u3-v6sm1619420edo.44.2018.08.08.06.51.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 06:51:15 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, Johannes.Schindelin@gmx.de,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com,
        Pratik Karki <predatoramigo@gmail.com>
Subject: [PATCH 02/11] builtin rebase: support `git rebase --onto A...B`
Date:   Wed,  8 Aug 2018 19:33:21 +0545
Message-Id: <20180808134830.19949-3-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808134830.19949-1-predatoramigo@gmail.com>
References: <20180808134830.19949-1-predatoramigo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit implements support for an --onto argument that is actually a
"symmetric range" i.e. `<rev1>...<rev2>`.

The equivalent shell script version of the code offers two different
error messages for the cases where there is no merge base vs more than
one merge base. Though following the similar approach would be nice,
this would create more complexity than it is of current. Currently, for
simple convenience, the `get_oid_mb()` function is used whose return
value does not discern between those two error conditions.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 builtin/rebase.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 742ed31498..38c496dd10 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -17,6 +17,7 @@
 #include "unpack-trees.h"
 #include "lockfile.h"
 #include "parse-options.h"
+#include "commit.h"
 
 static char const * const builtin_rebase_usage[] = {
 	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
@@ -311,6 +312,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	int ret, flags;
 	struct strbuf msg = STRBUF_INIT;
 	struct strbuf revisions = STRBUF_INIT;
+	struct object_id merge_base;
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -387,7 +389,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (!options.onto_name)
 		options.onto_name = options.upstream_name;
 	if (strstr(options.onto_name, "...")) {
-		die("TODO");
+		if (get_oid_mb(options.onto_name, &merge_base) < 0)
+			die(_("'%s': need exactly one merge base"),
+			    options.onto_name);
+		options.onto = lookup_commit_or_die(&merge_base,
+						    options.onto_name);
 	} else {
 		options.onto = peel_committish(options.onto_name);
 		if (!options.onto)
-- 
2.18.0

