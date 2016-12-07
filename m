Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A292820259
	for <e@80x24.org>; Wed,  7 Dec 2016 15:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932360AbcLGPhp (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 10:37:45 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35691 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752840AbcLGPgv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 10:36:51 -0500
Received: by mail-pf0-f193.google.com with SMTP id i88so11380373pfk.2
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 07:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ngt1KtHZthbZdexGKUOJ3zZK8Df+FvvydUgrdLXdM1c=;
        b=meBgaCj/WcEyw5Ml0U6E/BePCpVOijiW8CpnPuxAgEs/npLQW9whFWMhmXGNwjEhW/
         7KBQjl9iDhUevO2QJ1gAJtqkif45Oot2t7PYpguDYris1LebZh8Rc2LQxlI/0STxOb9M
         rP5xY1r6+mks4PgtN33IUDhhRmugOXfUbDQ9DyXwcxaPCOm8sMa9/wUVJSk20bO8OnSO
         U5IuBQT8S5QH8u65U8l/nbKz/yD24nIrl1CyZf4EtwRU9y5dKlAgYOWTUdmKXsR/1P6s
         L8FJCOCeYH4MEBZywCrx36nsxC/tBloVXv8BgVjQphXNTGs9saFnRctQUb5WYpe13GAh
         jf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ngt1KtHZthbZdexGKUOJ3zZK8Df+FvvydUgrdLXdM1c=;
        b=Simgojz6qMwY9RlscWcvb2+l376iab7/EoIjE4KuAe7WsMnZI7M2jXwWO3CQLWHF9u
         6DFo50f/SIoOkVKY/10wvkstrcf7RSYQONdtWMBx0fWJmaAgrgdsunfqhr1o48XCBDkA
         efvAyZvZx5T24anUOK2wLYL8N/FlZbgowlod50JNxTozOQKOvts/E1WN4rALnS5oV+Pb
         6q/x5UamsiyLDIzx/sTebMPCTbSx1ltediBP4e5HXIFaA4SSXzeQ71rralQni3lngG8j
         d6xWN7Vlw/z7tgZ6nrlg7ei7IAqcBfUxVbM98s9fRSGadteu32nILsA4N+iBco9dGrlb
         kl1g==
X-Gm-Message-State: AKaTC01I4vz2wlCZ8RKIEUhMAyZ+7O6wMKFfcVY2bPt44qAVwouIQlK0ZArqYSVIUGScJA==
X-Received: by 10.98.149.81 with SMTP id p78mr69201922pfd.95.1481124979046;
        Wed, 07 Dec 2016 07:36:19 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([122.15.255.69])
        by smtp.gmail.com with ESMTPSA id l7sm43584459pfg.35.2016.12.07.07.36.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Dec 2016 07:36:18 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com, jnareb@gmail.com,
        Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 06/19] ref-filter: introduce format_ref_array_item()
Date:   Wed,  7 Dec 2016 21:06:14 +0530
Message-Id: <20161207153627.1468-7-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161207153627.1468-1-Karthik.188@gmail.com>
References: <20161207153627.1468-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karthik Nayak <karthik.188@gmail.com>

To allow column display, we will need to first render the output in a
string list to allow print_columns() to compute the proper size of
each column before starting the actual output. Introduce the function
format_ref_array_item() that does the formatting of a ref_array_item
to an strbuf.

show_ref_array_item() is kept as a convenience wrapper around it which
obtains the strbuf and prints it the standard output.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 16 ++++++++++++----
 ref-filter.h |  3 +++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index bb69573..0f81f9f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1799,10 +1799,10 @@ static void append_literal(const char *cp, const char *ep, struct ref_formatting
 	}
 }
 
-void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
+void format_ref_array_item(struct ref_array_item *info, const char *format,
+			   int quote_style, struct strbuf *final_buf)
 {
 	const char *cp, *sp, *ep;
-	struct strbuf *final_buf;
 	struct ref_formatting_state state = REF_FORMATTING_STATE_INIT;
 
 	state.quote_style = quote_style;
@@ -1832,9 +1832,17 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 	}
 	if (state.stack->prev)
 		die(_("format: %%(end) atom missing"));
-	final_buf = &state.stack->output;
-	fwrite(final_buf->buf, 1, final_buf->len, stdout);
+	strbuf_addbuf(final_buf, &state.stack->output);
 	pop_stack_element(&state.stack);
+}
+
+void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style)
+{
+	struct strbuf final_buf = STRBUF_INIT;
+
+	format_ref_array_item(info, format, quote_style, &final_buf);
+	fwrite(final_buf.buf, 1, final_buf.len, stdout);
+	strbuf_release(&final_buf);
 	putchar('\n');
 }
 
diff --git a/ref-filter.h b/ref-filter.h
index 4aea594..0014b92 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -98,6 +98,9 @@ int parse_ref_filter_atom(const char *atom, const char *ep);
 int verify_ref_format(const char *format);
 /*  Sort the given ref_array as per the ref_sorting provided */
 void ref_array_sort(struct ref_sorting *sort, struct ref_array *array);
+/*  Based on the given format and quote_style, fill the strbuf */
+void format_ref_array_item(struct ref_array_item *info, const char *format,
+			   int quote_style, struct strbuf *final_buf);
 /*  Print the ref using the given format and quote_style */
 void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style);
 /*  Callback function for parsing the sort option */
-- 
2.10.2

