Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DC2D20958
	for <e@80x24.org>; Thu, 30 Mar 2017 01:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933345AbdC3Bmq (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 21:42:46 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35003 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933281AbdC3Bmo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 21:42:44 -0400
Received: by mail-pg0-f50.google.com with SMTP id 81so23606925pgh.2
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 18:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TmuAJCi+k8XJKosO3PWx8OCuSJ25ltQEYpxgb70MO5Y=;
        b=ej6+Ul7rw/Al9Ewc1k8R9NpCeXwD3KMKavuiMZX6tzAfsiOwaJcOXKGDdmKLYpK3OG
         wrxWnEg6iuB4YXte+gfrHwuNc5QN/0ydTS8F1EIqJ+n472dosChtf31Ff98D7LLtygE0
         l4w3jgu/K6sMHF/Nu683YBjS4Bq+jyvh0C9ycbjVCQBzUX4JcfjD7hPr6wpPRm6LJwe0
         k9gMa/Ipd4xVCGM5lPczATQP9lsLhqXZij13OsTCoVKpteRFqxGRHuS7um3YBfeZdSN9
         t/fpB49oEQu5Ov8nilttgaJ1ziRQnI2VS85Pe22+4oPKqM2QcKwQIEu2nD+uHvQuypp8
         p/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TmuAJCi+k8XJKosO3PWx8OCuSJ25ltQEYpxgb70MO5Y=;
        b=QLmcdPgJ+eSxKH4DFrh3L+cnIRNwe63pUiYgaK1lYJ0hD0IS3A4tmnmCy7AS6PKfPN
         JrJlYwhQ16cvMq7cOlgN91W0K6gqBYmS/4gncjzHBjXLTikHnMBY5/Ai13pfhe83E81I
         q/h7Jks3qKBRztGu3jnnJsmJ9p0V90JnIpuRst2y+507z8SOrnTBi+hJXNzxu2lJomj6
         xYjq3pNXD1WUmWeHLMoACC6yHrFl2dEnbpnuD0knH1h4A1GPthlSOaXCmVa4/Ffs2lu4
         izKU+TefAUkElg9g3QjYloX6acDpD2OtPKZOW5jt0pLY8fWrOAS82z16zzkcw56anD+s
         HdlQ==
X-Gm-Message-State: AFeK/H2VMSRGe80dHoIo6GrFjSmZCbKUmdzr6eyA36wIzelfT2clPsqJ4hJkL8zl/KfkDypt
X-Received: by 10.99.47.199 with SMTP id v190mr3408055pgv.26.1490838163445;
        Wed, 29 Mar 2017 18:42:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:cc96:1eab:fd67:9864])
        by smtp.gmail.com with ESMTPSA id u69sm558573pfg.121.2017.03.29.18.42.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 29 Mar 2017 18:42:42 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, peff@peff.net
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/3] column.c: pass column_options to down to display_plain
Date:   Wed, 29 Mar 2017 18:42:36 -0700
Message-Id: <20170330014238.30032-2-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.511.g2abb8caf66
In-Reply-To: <20170330014238.30032-1-sbeller@google.com>
References: <20170330014238.30032-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch we want to use more of the column_options members at
places, where we do actual output, so it will be handy to have the whole
struct around in `display_plain`.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 column.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/column.c b/column.c
index d55ead18ef..4851b9aa04 100644
--- a/column.c
+++ b/column.c
@@ -109,12 +109,12 @@ static void shrink_columns(struct column_data *data)
 
 /* Display without layout when not enabled */
 static void display_plain(const struct string_list *list,
-			  const char *indent, const char *nl)
+			  const struct column_options *opts)
 {
 	int i;
 
 	for (i = 0; i < list->nr; i++)
-		printf("%s%s%s", indent, list->items[i].string, nl);
+		printf("%s%s%s", opts->indent, list->items[i].string, opts->nl);
 }
 
 /* Print a cell to stdout with all necessary leading/traling space */
@@ -201,12 +201,14 @@ void print_columns(const struct string_list *list, unsigned int colopts,
 	nopts.padding = opts ? opts->padding : 1;
 	nopts.width = opts && opts->width ? opts->width : term_columns() - 1;
 	if (!column_active(colopts)) {
-		display_plain(list, "", "\n");
+		nopts.indent = "";
+		nopts.nl = "\n";
+		display_plain(list, &nopts);
 		return;
 	}
 	switch (COL_LAYOUT(colopts)) {
 	case COL_PLAIN:
-		display_plain(list, nopts.indent, nopts.nl);
+		display_plain(list, &nopts);
 		break;
 	case COL_ROW:
 	case COL_COLUMN:
-- 
2.12.2.511.g2abb8caf66

