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
	by dcvr.yhbt.net (Postfix) with ESMTP id C401B1F404
	for <e@80x24.org>; Wed, 21 Mar 2018 18:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752674AbeCUS2v (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 14:28:51 -0400
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:48784
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751891AbeCUS2u (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 21 Mar 2018 14:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1521656929;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=6K5qKFWr9vtqM8Z9pZ1vkpj7LXaAHjICYxxP/s527Fs=;
        b=fwkWfaFjthkENtGO4YFWW4FJfCb+aGJc95v81tBLAwiEdU0x4F/A+TJHd9pexilF
        bhc9/Fr88KVxX7xZgEavKkQTDSivXWb861S2zVN7hwN3kU9P9xmBSpaldG5e3YI4bMi
        UjwPLIFPAcr6hbhNAlOGGdjZ5Jbqrp4Ukg5PytFU=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016249d21c40-0edf6647-4d26-46fc-8cfd-5a446b93a5e2-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020162442818b4-c153f9ce-3813-41a6-aebd-f5cb2b98b1fa-000000@eu-west-1.amazonses.com>
References: <01020162442818b4-c153f9ce-3813-41a6-aebd-f5cb2b98b1fa-000000@eu-west-1.amazonses.com>
Subject: [PATCH v5 1/6] strbuf: add shortcut to work with error messages
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Wed, 21 Mar 2018 18:28:49 +0000
X-SES-Outgoing: 2018.03.21-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add function strbuf_error() that helps to save few lines of code.
Function expands fmt with placeholders, append resulting error message
to strbuf *err, and return error code ret.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 strbuf.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/strbuf.h b/strbuf.h
index e6cae5f4398c8..fa66d4835f1a7 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -620,4 +620,17 @@ char *xstrvfmt(const char *fmt, va_list ap);
 __attribute__((format (printf, 1, 2)))
 char *xstrfmt(const char *fmt, ...);
 
+/*
+ * Expand error message, append it to strbuf *err, then return error code ret.
+ * Allow to save few lines of code.
+ */
+static inline int strbuf_error(struct strbuf *err, int ret, const char *fmt, ...)
+{
+	va_list ap;
+	va_start(ap, fmt);
+	strbuf_vaddf(err, fmt, ap);
+	va_end(ap);
+	return ret;
+}
+
 #endif /* STRBUF_H */

--
https://github.com/git/git/pull/466
