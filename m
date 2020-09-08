Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F00BC43461
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 07:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EED721D1A
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 07:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oby7PFfq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgIHHRX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 03:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbgIHHRU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 03:17:20 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B827C061755
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 00:17:20 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t16so14379990ilf.13
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 00:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1H+cV+eVhyQQ1oem3DSYqbGoPyiWZiLyN2+tTh/nxdA=;
        b=Oby7PFfqSQB7NAac5ZI4Ne+kNMVTv+DwTpRsoZZgn2dXOy16A4AvpoVjczyNx9ZsQY
         fwxW366VaKwpi+v4I97cWNbp2uYdtBd0BLKY93dhpiSrsL0DaBnoISFRjQaQrIsVaqV9
         5/Jyme/Tq/J2WuMXn+jUWhv9axXDAuhhP3JHJ3jZIH9Fzeejd4sb0wKD4Ztjb+RQB7Ns
         KSqiujrOiQRDwzywaLOa7ZCcKMT69xh5XkC+T+f6pIuN9IEQi5IDyAu05HQ4SWcqqZV/
         7kBpalkVY0pLzUuu0ihy9v2Xs3XnW1HJlZoem/K0mQM9Tdlj0GoHdf3fh8THIo2IJDEN
         fMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=1H+cV+eVhyQQ1oem3DSYqbGoPyiWZiLyN2+tTh/nxdA=;
        b=mGuvxnqEhAA7lw5IfDu5uV+Q9rAK9KeSDczlGixNazEKpX0T1mPBNSqUG4W0J/Mfhf
         4/NP+BS3qRj0Rxk2QU4CMRZWZ0svEE9BqhHtpuINwKSTqkyYbWyaHI+jr7FdSjKcflEO
         xkP/fUh41tIYm2KZKbr6SK/o66G5VsOR1EeoL9iw+4gFnrlQoe1y/qIbpbGZSGTVwk58
         dVaKu06oowvWoa2zjCyAwHRce3qfy3sDjAhunnnRNjGN409A9OPcLrPxHnJ2S3iGnUOh
         v7SAbXxLAoHphwE9h0ei35H58ndD8tDAzOK+XAPJbgYUqrqvzKvNqVfq+3jmJ4fJ+ksG
         lUmw==
X-Gm-Message-State: AOAM530S42WRm0ZHmbjMIdRlNA3sXbsCLRozPuDAs3RfSTtZU0a9jiRX
        5Cau0gWj941/V89bpHKxv/0qyPLTyfU=
X-Google-Smtp-Source: ABdhPJxFJeE/qJukIVvPXtPf3z2GHgJuoRqyidnXLwwb7FGwPNnB/XiJ2dMD7ltY9ANdlsFHAEHzpw==
X-Received: by 2002:a92:9ec3:: with SMTP id s64mr22151427ilk.294.1599549439255;
        Tue, 08 Sep 2020 00:17:19 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id m18sm9587778iln.80.2020.09.08.00.17.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2020 00:17:18 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/3] diff: move show_interdiff() from its own file to diff-lib
Date:   Tue,  8 Sep 2020 03:16:08 -0400
Message-Id: <20200908071610.16714-2-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
In-Reply-To: <20200908071610.16714-1-sunshine@sunshineco.com>
References: <20200908071610.16714-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

show_interdiff() is a relatively small function and not likely to grow
larger or more complicated. Rather than dedicating an entire source file
to it, relocate it to diff-lib.c which houses other "take two things and
compare them" functions meant to be re-used but not so low-level as to
reside in the core diff implementation.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Notes:
    Suggested by Duy[1] and seconded by Junio[2] during review.
    
    [1]: https://lore.kernel.org/git/CACsJy8C8RK6HkfoEYJGZg=sgtJS0WksHD3=7Souw3jYebRo=Sg@mail.gmail.com/
    [2]: https://lore.kernel.org/git/xmqqh8kp4otz.fsf@gitster-ct.c.googlers.com/

 Makefile      |  1 -
 builtin/log.c |  1 -
 diff-lib.c    | 24 ++++++++++++++++++++++++
 diff.h        |  2 ++
 interdiff.c   | 28 ----------------------------
 interdiff.h   |  8 --------
 log-tree.c    |  1 -
 7 files changed, 26 insertions(+), 39 deletions(-)
 delete mode 100644 interdiff.c
 delete mode 100644 interdiff.h

diff --git a/Makefile b/Makefile
index 86e5411f39..cf47141939 100644
--- a/Makefile
+++ b/Makefile
@@ -883,7 +883,6 @@ LIB_OBJS += hashmap.o
 LIB_OBJS += help.o
 LIB_OBJS += hex.o
 LIB_OBJS += ident.o
-LIB_OBJS += interdiff.o
 LIB_OBJS += json-writer.o
 LIB_OBJS += kwset.o
 LIB_OBJS += levenshtein.o
diff --git a/builtin/log.c b/builtin/log.c
index b58f8da09e..ae9380da1b 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -33,7 +33,6 @@
 #include "commit-slab.h"
 #include "repository.h"
 #include "commit-reach.h"
-#include "interdiff.h"
 #include "range-diff.h"
 
 #define MAIL_DEFAULT_WRAP 72
diff --git a/diff-lib.c b/diff-lib.c
index 50521e2093..9bab907412 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -571,3 +571,27 @@ int index_differs_from(struct repository *r,
 	object_array_clear(&rev.pending);
 	return (rev.diffopt.flags.has_changes != 0);
 }
+
+static struct strbuf *idiff_prefix_cb(struct diff_options *opt, void *data)
+{
+	return data;
+}
+
+void show_interdiff(struct rev_info *rev, int indent)
+{
+	struct diff_options opts;
+	struct strbuf prefix = STRBUF_INIT;
+
+	memcpy(&opts, &rev->diffopt, sizeof(opts));
+	opts.output_format = DIFF_FORMAT_PATCH;
+	opts.output_prefix = idiff_prefix_cb;
+	strbuf_addchars(&prefix, ' ', indent);
+	opts.output_prefix_data = &prefix;
+	diff_setup_done(&opts);
+
+	diff_tree_oid(rev->idiff_oid1, rev->idiff_oid2, "", &opts);
+	diffcore_std(&opts);
+	diff_flush(&opts);
+
+	strbuf_release(&prefix);
+}
diff --git a/diff.h b/diff.h
index e0c0af6286..308937c94b 100644
--- a/diff.h
+++ b/diff.h
@@ -600,6 +600,8 @@ int index_differs_from(struct repository *r, const char *def,
 		       const struct diff_flags *flags,
 		       int ita_invisible_in_index);
 
+void show_interdiff(struct rev_info *, int indent);
+
 /*
  * Fill the contents of the filespec "df", respecting any textconv defined by
  * its userdiff driver.  The "driver" parameter must come from a
diff --git a/interdiff.c b/interdiff.c
deleted file mode 100644
index c81d680a6c..0000000000
--- a/interdiff.c
+++ /dev/null
@@ -1,28 +0,0 @@
-#include "cache.h"
-#include "commit.h"
-#include "revision.h"
-#include "interdiff.h"
-
-static struct strbuf *idiff_prefix_cb(struct diff_options *opt, void *data)
-{
-	return data;
-}
-
-void show_interdiff(struct rev_info *rev, int indent)
-{
-	struct diff_options opts;
-	struct strbuf prefix = STRBUF_INIT;
-
-	memcpy(&opts, &rev->diffopt, sizeof(opts));
-	opts.output_format = DIFF_FORMAT_PATCH;
-	opts.output_prefix = idiff_prefix_cb;
-	strbuf_addchars(&prefix, ' ', indent);
-	opts.output_prefix_data = &prefix;
-	diff_setup_done(&opts);
-
-	diff_tree_oid(rev->idiff_oid1, rev->idiff_oid2, "", &opts);
-	diffcore_std(&opts);
-	diff_flush(&opts);
-
-	strbuf_release(&prefix);
-}
diff --git a/interdiff.h b/interdiff.h
deleted file mode 100644
index 01c730a5c9..0000000000
--- a/interdiff.h
+++ /dev/null
@@ -1,8 +0,0 @@
-#ifndef INTERDIFF_H
-#define INTERDIFF_H
-
-struct rev_info;
-
-void show_interdiff(struct rev_info *, int indent);
-
-#endif
diff --git a/log-tree.c b/log-tree.c
index 55a68d0c61..39bb362d5e 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -15,7 +15,6 @@
 #include "sequencer.h"
 #include "line-log.h"
 #include "help.h"
-#include "interdiff.h"
 #include "range-diff.h"
 
 static struct decoration name_decoration = { "object names" };
-- 
2.28.0.618.gf4bc123cb7

