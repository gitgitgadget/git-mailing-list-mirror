Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 043E820248
	for <e@80x24.org>; Mon, 25 Mar 2019 10:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbfCYKjH (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 06:39:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40065 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730535AbfCYKjF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 06:39:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id t5so9442813wri.7
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 03:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lvazhkb4auI/+oB3ds0HHB9B20eMegcqFylcWLtuZNs=;
        b=kHTnOO1Wk4JCHsAWFToCl5K3VFZIdUNpy/YHLJu37fMJk9jVaRZKcLN0oH3Bn05zGA
         wiOghe/kBitlF3fD1neWTnsG3UXA3AQ8d+5WjY8sC+V9BVfA882qZ7TPB0od5ueC/mu4
         5yKxGOyVGPJ07SOtRNk+ErtnF6Y743a+dLOjBos7Fi14xgQcwOjppomBibtWTWicLUIz
         uUuXJFrJ8FH/wfau3D6UPnb0FCWDEgpvcDOBes4iSaDb22sb7jV5UDg9noCe8djMDSAr
         HoB9d+L5tb62S4xgM9Q25X7k2//7F0sIJRYuM7OaV7E+Zi9wHx494q3uanYHcHxVDMfx
         Glmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lvazhkb4auI/+oB3ds0HHB9B20eMegcqFylcWLtuZNs=;
        b=gWj4p6PopE8q2DHCcZC2GTrhkicSoHPmTNq3tqmRW6bjBrqgcpfsNIxO6EVM7d0gRd
         L8Xq87sRE8LeVSvWbRUo1xwVoXIgXfnseSKD8CgwZpRvy/cHtNrLC46v2LfEtIHHskhp
         vn1cM3AEjGnfIGQfhjHWfpkxlTf6biq5Ta+aPwaVYzZiqQTQYsPmfrKZr5P2Fsj/vihd
         osL7AkMXBd6Ri95FlncJJBKfQ3nAZCMtmP1y4E8DUpnjWJWFkanrq/fV+6mTgsQ+mUfF
         FxDW54qPbI2DjbK1j3boV7ouuEPqm3yqJPunz19jd/k9VPrn6P/zjJOYrCk87aBjHIqB
         epoQ==
X-Gm-Message-State: APjAAAVY+20cFtz/aJYZLASVhqq41BjDbmo2JIGazegAew8tu0O8WAuu
        VwzTP4mpGduGilfYkW0QViCij/eJ0As=
X-Google-Smtp-Source: APXvYqyLe9Py4IqhLAh+f15J45NeICeMvozZ9qpeCDg425myiCJsaNKF54eJ+CJcrVxWEdR0R5a2lQ==
X-Received: by 2002:adf:ff91:: with SMTP id j17mr12370473wrr.114.1553510343389;
        Mon, 25 Mar 2019 03:39:03 -0700 (PDT)
Received: from localhost.localdomain (x4d0c296b.dyn.telefonica.de. [77.12.41.107])
        by smtp.gmail.com with ESMTPSA id q2sm23247292wrd.46.2019.03.25.03.39.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 03:39:02 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 5/5] progress: break too long progress bar lines
Date:   Mon, 25 Mar 2019 11:38:44 +0100
Message-Id: <20190325103844.26749-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.539.g07239c3a71.dirty
In-Reply-To: <20190325103844.26749-1-szeder.dev@gmail.com>
References: <20190325103844.26749-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some of the recently added progress indicators have quite long titles,
which might be even longer when translated to some languages, and when
they are shown while operating on bigger repositories, then the
progress bar grows longer than the default 80 column terminal width.

When the progress bar exceeds the width of the terminal it gets
line-wrapped, and after that the CR at the end doesn't return to the
beginning of the progress bar, but to the first column of its last
line.  Consequently, the first line of the previously shown progress
bar is not overwritten by the next, and we end up with a bunch of
truncated progress bar lines scrolling past:

  $ LANG=es_ES.UTF-8 git commit-graph write
  Encontrando commits para commit graph entre los objetos empaquetados:   2% (1599
  Encontrando commits para commit graph entre los objetos empaquetados:   3% (1975
  Encontrando commits para commit graph entre los objetos empaquetados:   4% (2633
  Encontrando commits para commit graph entre los objetos empaquetados:   5% (3292
  [...]

Prevent this by breaking progress bars after the title once they
exceed the width of the terminal, so the counter and optional
percentage and throughput, i.e. all changing parts, are on the last
line.  Subsequent updates will from then on only refresh the changing
parts, but not the title, and it will look like this:

  $ LANG=es_ES.UTF-8 ~/src/git/git commit-graph write
  Encontrando commits para commit graph entre los objetos empaquetados:
    100% (6584502/6584502), listo.
  Calculando números de generación de commit graph: 100% (824705/824705), listo.
  Escribiendo commit graph en 4 pasos: 100% (3298820/3298820), listo.

Note that the number of columns in the terminal is cached by
term_columns(), so this might not kick in when it should when a
terminal window is resized while the operation is running.
Furthermore, this change won't help if the terminal is so narrow that
the counters don't fit on one line, but I would put this in the "If it
hurts, don't do it" box.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 progress.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/progress.c b/progress.c
index b37a5398c5..36aaeea340 100644
--- a/progress.c
+++ b/progress.c
@@ -8,7 +8,7 @@
  * published by the Free Software Foundation.
  */
 
-#include "git-compat-util.h"
+#include "cache.h"
 #include "gettext.h"
 #include "progress.h"
 #include "strbuf.h"
@@ -37,6 +37,8 @@ struct progress {
 	struct throughput *throughput;
 	uint64_t start_ns;
 	struct strbuf counters_sb;
+	int title_len;
+	int split;
 };
 
 static volatile sig_atomic_t progress_update;
@@ -119,8 +121,22 @@ static void display(struct progress *progress, uint64_t n, const char *done)
 		const char *eol = done ? done : "\r";
 		int clear_len = counters_sb->len < last_count_len ?
 				last_count_len - counters_sb->len : 0;
-		fprintf(stderr, "%s: %s%-*s", progress->title,
-			counters_sb->buf, clear_len, eol);
+		int cols = term_columns();
+
+		if (progress->split) {
+			fprintf(stderr, "  %s%-*s", counters_sb->buf, clear_len,
+				eol);
+		} else if (!done &&
+			   cols < progress->title_len + counters_sb->len + 2) {
+			clear_len = progress->title_len + 1 < cols ?
+				    cols - progress->title_len - 1 : 0;
+			fprintf(stderr, "%s:%*s\n  %s%s", progress->title,
+					clear_len, "", counters_sb->buf, eol);
+			progress->split = 1;
+		} else {
+			fprintf(stderr, "%s: %s%-*s", progress->title,
+				counters_sb->buf, clear_len, eol);
+		}
 		fflush(stderr);
 		progress_update = 0;
 	}
@@ -225,6 +241,8 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
 	progress->throughput = NULL;
 	progress->start_ns = getnanotime();
 	strbuf_init(&progress->counters_sb, 0);
+	progress->title_len = strlen(title);
+	progress->split = 0;
 	set_progress_signal();
 	return progress;
 }
-- 
2.21.0.539.g07239c3a71.dirty

