Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EACC43603
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 20:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D312464E
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 20:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4d2jbWr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfLFUQE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 15:16:04 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41610 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfLFUQE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 15:16:04 -0500
Received: by mail-pf1-f196.google.com with SMTP id s18so3883335pfd.8
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 12:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aBzk+gwqp9sM8ylnvZ/AWW5w4k5p2wCnR8/8pQ+jqYg=;
        b=q4d2jbWrxOogz16fj110D0pUlRDOzHXINIWsY2fRXUGtDP2DhESJ247VjZjvqEZWAK
         GQCn8dyEO9v4SDBAZ6ZRcq7prMLpklBVD6IU4OUfsh7RcSNGk9zs4vQuyQPenvhGkDx1
         ZZkxxNDO6BpM3hW4/C1574wj2aEc5mVF6VyrRHVmQy7IEItyFT9nzQ+ocNYMcHs6fisK
         +0zgbVpgL2WessXfG744Ye4lUNGzGOiHVvY1aEuixrIMWT4wmL1m9aCqi0dfPZQtXpPB
         25oLh+ANn3Y/yZsNlDW5XpNTwdiB6e05IbV9bjDo4zdZzVjUDIXRKRBn/ThDsqbSMhL0
         Y/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aBzk+gwqp9sM8ylnvZ/AWW5w4k5p2wCnR8/8pQ+jqYg=;
        b=r3oIctHVcXe5BPChsCmGKp5mCU0bPlnU4LV62rZXvBuep6WAZfGC1WRubGKM1AZK+k
         31fGSyPzIT+QbQH7dtIqdN2UVhh1owzqHw67G5ldTU5B+9FErns/CFkKr5mFG3SE+5ff
         XTETM0DXNxjIJuSY6jjQpYbNLk6jg93nNqmIMMxfzNW1o5R4XbbuuxagJ3bP4X5eyLDA
         GLWCS+kROeGN0KQFQztsywhKiGRKIPoW3rca0Lvj4YuyP779rh65u47aE4JqXyBkbehZ
         QJWeTPlPp16Q/u576gfGrD1RczzR9lPCY1LBunwrRrS5MPJQd2jUlgHFQQFoe7ad6ULM
         uDbw==
X-Gm-Message-State: APjAAAUH9g/emgK83cTOru/iJqAaOUi9l83gzw+TwQTenr4QZH7qWSdi
        PD7F0lzUGclXnbtIfJW92E4DCT+B
X-Google-Smtp-Source: APXvYqwAQ1N0RbjkiI5KRIiallWtLjIf+gylSXK/NuiniNa4Pb7Q8NLftZZxPMWtUJLTHCjMFVKBwA==
X-Received: by 2002:aa7:801a:: with SMTP id j26mr14222911pfi.50.1575663363224;
        Fri, 06 Dec 2019 12:16:03 -0800 (PST)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id d85sm17485000pfd.146.2019.12.06.12.16.01
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 12:16:02 -0800 (PST)
Date:   Fri, 6 Dec 2019 12:16:26 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/3] range-diff: mark pointers as const
Message-ID: <159516cf99c445604d82d8760e8d2f7497db05a5.1575663345.git.liu.denton@gmail.com>
References: <cover.1575663345.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1575663345.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The contents pointed to by `diffopt` and `other_arg` should not be
modified. Mark these as `const` to indicate this.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 range-diff.c | 6 +++---
 range-diff.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index f56b4012a2..f745567cf6 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -41,7 +41,7 @@ static size_t find_end_of_line(char *buffer, unsigned long size)
  * as struct object_id (will need to be free()d).
  */
 static int read_patches(const char *range, struct string_list *list,
-			struct argv_array *other_arg)
+			const struct argv_array *other_arg)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT, contents = STRBUF_INIT;
@@ -506,8 +506,8 @@ static struct strbuf *output_prefix_cb(struct diff_options *opt, void *data)
 
 int show_range_diff(const char *range1, const char *range2,
 		    int creation_factor, int dual_color,
-		    struct diff_options *diffopt,
-		    struct argv_array *other_arg)
+		    const struct diff_options *diffopt,
+		    const struct argv_array *other_arg)
 {
 	int res = 0;
 
diff --git a/range-diff.h b/range-diff.h
index 7d918ab9ed..381d52f4d3 100644
--- a/range-diff.h
+++ b/range-diff.h
@@ -13,7 +13,7 @@
  */
 int show_range_diff(const char *range1, const char *range2,
 		    int creation_factor, int dual_color,
-		    struct diff_options *diffopt,
-		    struct argv_array *other_arg);
+		    const struct diff_options *diffopt,
+		    const struct argv_array *other_arg);
 
 #endif
-- 
2.24.0.612.g9b7bad38f5

