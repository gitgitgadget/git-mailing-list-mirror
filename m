Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5758E20958
	for <e@80x24.org>; Thu, 30 Mar 2017 01:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933348AbdC3Bmr (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 21:42:47 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35012 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933103AbdC3Bmq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 21:42:46 -0400
Received: by mail-pg0-f44.google.com with SMTP id 81so23607308pgh.2
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 18:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rQyszbwW3KHs/5LQj1BcDu4AcxM6DNc8mUSI/Md0vZs=;
        b=sinerESl4ah/q7eeotKHTwCMADS9puVGmajHjWPAseCZPhg2aOfUu6zUrvgGs/AzLL
         9UW7Htf1faz2XQSg6FLDxm4poZqymRbcIvl2PYdS0TnUvdLj3zD9UqN6I4raHRsltKbA
         ZgRMtJyJqRW4+zjTfMwJ5RexMwUejaBdkl/uPyn54dLccyvgLl65RApCqTIPfmMSOqQZ
         UKWyOUDFMpyjrFuONRRlm3mElmOFSaqDc5Qo7SW3COwoyDvdThAJPLuVoqrDKY6f/O2l
         5+Q2/3yphL0ZI/cEtohhAsMGTexNBahKyxbqhR6ld8oDZ1pZZ8pzSgRQCjkIUoz70u7h
         Iaig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rQyszbwW3KHs/5LQj1BcDu4AcxM6DNc8mUSI/Md0vZs=;
        b=pFYSql2uWUG+GApgMAA7LJkW+d+vQKzHQaPp30B8fAGUCDdoOOoKa1RUWZ9e4AEpDe
         G9UUTvPVWPpl8K+0HGf4jkX+lA+6MZiC0tjF8yRuuvaZDLzFK/u4JHzy5E1Xay5A58zu
         E1PjXQuXMHzTegpmlYmJbG3PSEjzeWetp4p0mdwfDxXqkM6IpHHmCTZd4gDKgqucbh8a
         kaq0/XxIjybP3j/+tvu2H1qz5IdNSEwuq/3dbE5TPZiRUII2zZq88RYWRaGCDP8r0OjC
         xGO4aeWY0OIhXXiIFHCyMiDgwM4UTdNRg7Vy+NdCF4wTmo/kR2xy2mLoQ+A0nCLFcGN/
         BJJQ==
X-Gm-Message-State: AFeK/H1AYO4n4URCj1N4kgfMWONojjVmIhSHBjwyDabgoS0KHlsQZnIMzUHRlMyyoYlWOC4G
X-Received: by 10.98.34.73 with SMTP id i70mr3467803pfi.248.1490838164622;
        Wed, 29 Mar 2017 18:42:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:cc96:1eab:fd67:9864])
        by smtp.gmail.com with ESMTPSA id i3sm577240pfk.47.2017.03.29.18.42.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 29 Mar 2017 18:42:43 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, peff@peff.net
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/3] column: allow for custom printf
Date:   Wed, 29 Mar 2017 18:42:37 -0700
Message-Id: <20170330014238.30032-3-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.511.g2abb8caf66
In-Reply-To: <20170330014238.30032-1-sbeller@google.com>
References: <20170330014238.30032-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 column.c | 13 ++++++++-----
 column.h |  3 +++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/column.c b/column.c
index 4851b9aa04..522e554f29 100644
--- a/column.c
+++ b/column.c
@@ -114,7 +114,9 @@ static void display_plain(const struct string_list *list,
 	int i;
 
 	for (i = 0; i < list->nr; i++)
-		printf("%s%s%s", opts->indent, list->items[i].string, opts->nl);
+		opts->_printf("%s%s%s", opts->indent,
+					list->items[i].string,
+					opts->nl);
 }
 
 /* Print a cell to stdout with all necessary leading/traling space */
@@ -143,10 +145,10 @@ static int display_cell(struct column_data *data, int initial_width,
 	else
 		newline = x == data->cols - 1 || i == data->list->nr - 1;
 
-	printf("%s%s%s",
-	       x == 0 ? data->opts.indent : "",
-	       data->list->items[i].string,
-	       newline ? data->opts.nl : empty_cell + len);
+	data->opts._printf("%s%s%s",
+			   x == 0 ? data->opts.indent : "",
+			   data->list->items[i].string,
+			   newline ? data->opts.nl : empty_cell + len);
 	return 0;
 }
 
@@ -200,6 +202,7 @@ void print_columns(const struct string_list *list, unsigned int colopts,
 	nopts.nl = opts && opts->nl ? opts->nl : "\n";
 	nopts.padding = opts ? opts->padding : 1;
 	nopts.width = opts && opts->width ? opts->width : term_columns() - 1;
+	nopts._printf = opts && opts->_printf ? opts->_printf : printf;
 	if (!column_active(colopts)) {
 		nopts.indent = "";
 		nopts.nl = "\n";
diff --git a/column.h b/column.h
index 0a61917fa7..c44a1525a9 100644
--- a/column.h
+++ b/column.h
@@ -24,6 +24,9 @@ struct column_options {
 	int padding;
 	const char *indent;
 	const char *nl;
+
+	/* when non-NULL, use this printing function, fallback to printf */
+	int (*_printf)(const char *__format, ...);
 };
 
 struct option;
-- 
2.12.2.511.g2abb8caf66

