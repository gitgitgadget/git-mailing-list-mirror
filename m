Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 455DC1F404
	for <e@80x24.org>; Thu, 29 Mar 2018 12:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752676AbeC2Mts (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 08:49:48 -0400
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:41226
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751227AbeC2Mtr (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 29 Mar 2018 08:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1522327785;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=x9Kq/no7dyIAplWQiXlcF5mh5238/Wi1+ryDH0dKrkU=;
        b=XejoFKJdEqwxw6XTWV4p0OL3mZnzAXNoRXy2JdCeFS1SkuWySqcBFtk9rinbhRMh
        l4HFIK2Ca8CXPinlYwsi7kQaUlZzOTPGm2cF6ofSYgp9eUM8184L/N7uHXm/jB2Bj6C
        GoXvqNk/w9d+mS4R5BG66GALUMtwwTseq1IxGdzw=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016271ce90fc-1bd75012-add6-49ee-bb32-66eeeb1cc3df-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016249d21c40-0edf6647-4d26-46fc-8cfd-5a446b93a5e2-000000@eu-west-1.amazonses.com>
References: <0102016249d21c40-0edf6647-4d26-46fc-8cfd-5a446b93a5e2-000000@eu-west-1.amazonses.com>
Subject: [PATCH v6 1/6] ref-filter: add shortcut to work with strbufs
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Thu, 29 Mar 2018 12:49:45 +0000
X-SES-Outgoing: 2018.03.29-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add function strbuf_addf_ret() that helps to save a few lines of code.
Function expands fmt with placeholders, append resulting message
to strbuf *sb, and return error code ret.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 ref-filter.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/ref-filter.c b/ref-filter.c
index 45fc56216aaa8..0c8d1589cf316 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -101,6 +101,19 @@ static struct used_atom {
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
 
+/*
+ * Expand string, append it to strbuf *sb, then return error code ret.
+ * Allow to save few lines of code.
+ */
+static int strbuf_addf_ret(struct strbuf *sb, int ret, const char *fmt, ...)
+{
+	va_list ap;
+	va_start(ap, fmt);
+	strbuf_vaddf(sb, fmt, ap);
+	va_end(ap);
+	return ret;
+}
+
 static void color_atom_parser(const struct ref_format *format, struct used_atom *atom, const char *color_value)
 {
 	if (!color_value)

--
https://github.com/git/git/pull/466
