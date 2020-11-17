Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29121C64E69
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB2D1221F9
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 21:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaTYlRoc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgKQVgI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 16:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbgKQVgH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 16:36:07 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22876C0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:36:07 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id oq3so31499804ejb.7
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 13:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pxTYoQ+UCwjJ5cJTU5ii7+zH6QrQ0S4pwzOx/HgkXwA=;
        b=OaTYlRoc0TRFjKp4sqlyqFuDfTy6xIKBe5HcSH/qtOFr6yK8kYrygdHiCAF7ud53E8
         aZIDzQwIAJzN9ZQmifXH59hxtaLc5zw27IX/VvZ6uCKuLKk+Slb6ywHH0P0auG02JoLc
         hl1/nhe3QXslYyFaZbX3KyiPxBsY8dsVRij5L47jhvYkjPpu7tgM6oOYmhsIdUbn3wXY
         h6hoBUF5K2oPyOPBZf5C/6IZMriQjidZeQ5DgGN5jBT6Ul3mopYXKTIXD+vycHlwsiAz
         uf5IYmFZPbaFIOdqIQiX1DRfgJ3IEtbWwMKBTsYl93ThmzJ5BYt/6kxHS3DtMKjeR0L1
         1IPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pxTYoQ+UCwjJ5cJTU5ii7+zH6QrQ0S4pwzOx/HgkXwA=;
        b=UpRO/vzAb15cT6Jr+uWDekvmeqmmRK8bDxXOhYLBKOuxY4+kGZ+b98P2ix7EvJztuO
         g08FpSm6EaijEHn8Ktnvodum7KBeSaFkRodOGv2deroWp+Z4ADIPo6qr0dxKFqzVWpL0
         NXF6eJZRn891UACvywt5p1CPH9PpUed0yZNRWE+0I8hFVGJ04EYhIBJ6ZVfjrG5Yos4b
         DHae4W6XYEE2eNAEd+oPSj4ACieowz8aiZdnStKa/hr6R4IULP3hfWTWyBNVO+Wt0c7A
         TmzRyVUjXUK+ELI1uVZqsxaGJTNA9PllWRYB/ixMix5/ujCOUfu3MAT2rU38POa2HCWF
         ebbw==
X-Gm-Message-State: AOAM532T2ZFoH4GXPBWZ2OQQg0fJti40CnIzbIYGSa8Wv/qLq8zIerPj
        ESjBghK62h/fHwqjsA0p+1g=
X-Google-Smtp-Source: ABdhPJxJW9mNxMsokwrnYhiTDOInSkZysGN8reaGyDbm6nCgFxiRgSeEPhS6yJ7iSKcCf7yIOQxuWw==
X-Received: by 2002:a17:906:9445:: with SMTP id z5mr12546059ejx.165.1605648965929;
        Tue, 17 Nov 2020 13:36:05 -0800 (PST)
Received: from localhost.localdomain (178.115.129.143.wireless.dyn.drei.com. [178.115.129.143])
        by smtp.gmail.com with ESMTPSA id by8sm12623417edb.49.2020.11.17.13.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 13:36:05 -0800 (PST)
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, newren@gmail.com, peff@peff.net,
        Johannes Altmanninger <aclopte@gmail.com>
Subject: [PATCH 3/3] range-diff: only compute patch diff when patches are different
Date:   Tue, 17 Nov 2020 22:35:51 +0100
Message-Id: <20201117213551.2539438-4-aclopte@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201117213551.2539438-1-aclopte@gmail.com>
References: <xmqqmtzvikwi.fsf@gitster.c.googlers.com>
 <20201117213551.2539438-1-aclopte@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a pure optimization, probably with negligible impact. I'm not sure
if it is a good idea because it could obscure future bugs.
---
 range-diff.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index df2147ef79..343a71d3eb 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -388,7 +388,7 @@ static int are_diffs_equivalent(const char *a_diff, const char *b_diff) {
 	return 1;
 }
 
-static void output_pair_header(struct diff_options *diffopt,
+static char output_pair_header(struct diff_options *diffopt,
 			       int patch_no_width,
 			       struct strbuf *buf,
 			       struct strbuf *dashes,
@@ -456,6 +456,8 @@ static void output_pair_header(struct diff_options *diffopt,
 	strbuf_addf(buf, "%s\n", color_reset);
 
 	fwrite(buf->buf, buf->len, 1, diffopt->file);
+
+	return status;
 }
 
 static struct userdiff_driver section_headers = {
@@ -537,9 +539,9 @@ static void output(struct string_list *a, struct string_list *b,
 		/* Show matching LHS/RHS pair. */
 		if (j < b->nr) {
 			a_util = a->items[b_util->matching].util;
-			output_pair_header(diffopt, patch_no_width,
+			char status = output_pair_header(diffopt, patch_no_width,
 					   &buf, &dashes, a_util, b_util);
-			if (!(diffopt->output_format & DIFF_FORMAT_NO_OUTPUT)) {
+			if (!(diffopt->output_format & DIFF_FORMAT_NO_OUTPUT) && status != '=') {
 				patch_diff(a_util->patch, a_util->diff_offset, 
 						b_util->patch, b_util->diff_offset, diffopt);
 			        diffopt->ignore_regex_nr = ignoring_context_only_changes;
-- 
2.29.2

