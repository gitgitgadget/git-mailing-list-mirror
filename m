Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDF5F2082E
	for <e@80x24.org>; Fri, 23 Jun 2017 01:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754090AbdFWB3q (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 21:29:46 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:36465 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753833AbdFWB3m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 21:29:42 -0400
Received: by mail-pg0-f52.google.com with SMTP id u62so14977305pgb.3
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 18:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+c4c6q5PWouEJXwxFZuLdWH8Uw67BBfgtGy1NBogn+k=;
        b=FDMtqL/WZr0vL/7/DK3IXNstS9QwxNpDWkipbGJHu9in847pt9Tv19mhRqVK6ra+ul
         nRiMPkPVqBrMpiFhFNMqbqkfao5aDtfZqMk9Wa06dJeN8BPGSuIvN4zNXU6N424kGmTO
         pw8LkfAQjEPda4iEFOirM4wVkFjEble8i73sYZ8GQsISjXsRhIE4nKOL2vAIOHhXGIOb
         0B2SdTuEDV10tgVf1bAt45Dt0e/4Ql2YEJsnSfFr2MmaWejA7emoI1S+woM32ATIAX5z
         AVjLGj/JemkMLBdbc/2rRJqf0NVymrPQPk5IXr3hobdXJ/hjXUIdlNCmYL58qRm0yfNT
         enfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+c4c6q5PWouEJXwxFZuLdWH8Uw67BBfgtGy1NBogn+k=;
        b=uHlQYS0LTu1beKi+nXplAAFHyvYaOtoyK99FTjsjgq6IKw3PTe6CE1jSDeVuI/Rs10
         1PmUpJTwGMJfnjoXMdKugzlwuFv5SODC699b/YPH+CadSFknz20BY2i15xubYoFp4toZ
         a96DlWIlMChyRiUWo+3CAb2ezdxm8xMa1ntWxoOAn4Aqm5hkpONO2uTm3KPtBPP/QQEN
         no0B0bMsc3lu+LklEY4RUXeKiikMK0TzOlcHkBN0H9sAzb/r82NGxur5pkxsbTEZCwnZ
         KsgR3G593noDSrZsmeV3wG2DGkbV+8Muzh0zTMJ51A2Nqx9s6HZ59p/YgR/gVXzwqdos
         Dg+w==
X-Gm-Message-State: AKS2vOztDuYyt97GOd84BxO6yM/T/Q9xC2eloES8PXY7UxFpyrnhZZlF
        1DnEAP50Fm+Wsgi5
X-Received: by 10.99.119.12 with SMTP id s12mr5551096pgc.143.1498181377102;
        Thu, 22 Jun 2017 18:29:37 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:54b:7db6:84cb:995a])
        by smtp.gmail.com with ESMTPSA id n123sm6048811pga.35.2017.06.22.18.29.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 18:29:36 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCHv2 07/25] diff.c: emit_diff_symbol learns DIFF_SYMBOL_NO_LF_EOF
Date:   Thu, 22 Jun 2017 18:29:01 -0700
Message-Id: <20170623012919.28693-8-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170623012919.28693-1-sbeller@google.com>
References: <20170620024816.20021-1-sbeller@google.com>
 <20170623012919.28693-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 16818fa571..b78f698cad 100644
--- a/diff.c
+++ b/diff.c
@@ -560,6 +560,7 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
 }
 
 enum diff_symbol {
+	DIFF_SYMBOL_NO_LF_EOF,
 	DIFF_SYMBOL_CONTEXT_FRAGINFO,
 	DIFF_SYMBOL_CONTEXT_MARKER,
 	DIFF_SYMBOL_SEPARATOR
@@ -568,8 +569,16 @@ enum diff_symbol {
 static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 			     const char *line, int len)
 {
+	static const char *nneof = " No newline at end of file\n";
 	const char *context, *reset;
 	switch (s) {
+	case DIFF_SYMBOL_NO_LF_EOF:
+		context = diff_get_color_opt(o, DIFF_CONTEXT);
+		reset = diff_get_color_opt(o, DIFF_RESET);
+		putc('\n', o->file);
+		emit_line_0(o, context, reset, '\\',
+			    nneof, strlen(nneof));
+		break;
 	case DIFF_SYMBOL_CONTEXT_FRAGINFO:
 		emit_line(o, "", "", line, len);
 		break;
@@ -750,7 +759,6 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 			       int prefix, const char *data, int size)
 {
 	const char *endp = NULL;
-	static const char *nneof = " No newline at end of file\n";
 	const char *reset = diff_get_color(ecb->color_diff, DIFF_RESET);
 
 	while (0 < size) {
@@ -768,13 +776,8 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 		size -= len;
 		data += len;
 	}
-	if (!endp) {
-		const char *context = diff_get_color(ecb->color_diff,
-						     DIFF_CONTEXT);
-		putc('\n', ecb->opt->file);
-		emit_line_0(ecb->opt, context, reset, '\\',
-			    nneof, strlen(nneof));
-	}
+	if (!endp)
+		emit_diff_symbol(ecb->opt, DIFF_SYMBOL_NO_LF_EOF, NULL, 0);
 }
 
 static void emit_rewrite_diff(const char *name_a,
-- 
2.12.2.575.gb14f27f917

