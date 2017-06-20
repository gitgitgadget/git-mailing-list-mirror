Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0E7B1FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 02:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751108AbdFTCsf (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 22:48:35 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36650 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbdFTCsd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 22:48:33 -0400
Received: by mail-pg0-f49.google.com with SMTP id u62so37275203pgb.3
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 19:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pnNL7suvMwTKJUpBo2agF3gGGzikyAGCeaKt4FG3bA4=;
        b=VvAskRRenCvyYk9Gf4m4lGDieB8cBVa/h9vKo3T4PxIgiHBKMQRLQr1/18pnn+p+K0
         WPmchVSB4ueDaNo3jnVGqXHSqoINRW1Hf+/NXT2T+uNJhm06TbBVQ9/dX0PhBhmA7QhL
         r1CTjuli3cGULkv1mXYQLkxz3rpv58VaToaGwzaI6M/OtX7JuxgVoeryn3Va53srr7ZB
         /JScgjXEnZ6Y+A4B4cxzpooZkSG61EMUQ0sebdmmiM8TyRwuhOalUDJLeJ/MBJEVtTZF
         YF6+U11Qd64zfuv9FkuACduA5Vr4qGrlL7vcx61j+KvNlk9SgApr2ndldqe60cZn4HAN
         M1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pnNL7suvMwTKJUpBo2agF3gGGzikyAGCeaKt4FG3bA4=;
        b=Frs4NSlXonMVQmBEJ/jqXZbGQaDskQPnFTcFHAVMQL6uqNHTOShKSy39rv7AlkxsxW
         VTZ2fIb9Qec5nqgLPg4Qs7LHPp3DNZj9oo8byWcVV5qiIqRjPKfGMqp4nAaeKLcRkoQJ
         Jod5oxupM7iaDcIF0iwhugYh7hmF5h12G8/HmN0STArlHuquliez7pAXXPqu4hhgUiUz
         XIXTXbDUDKjCGPx0VEsFDAeG253fqs698UdkIkiLxhaYXtz0cCm2UpHNT1AJINMwiaC+
         z5ht4885jDtgLODAH+CWzxGutp4GhAMolOnA9Vq0CFgcfLgki07gJBnj92CARCCdi8SL
         OSJQ==
X-Gm-Message-State: AKS2vOzIJK/R7hx2FeNpS3JlB+XPPPrjf4/vNkzEtoRJSeNDOKrBle0N
        4c+SVHorwLhlk92H
X-Received: by 10.98.55.199 with SMTP id e190mr20490798pfa.15.1497926912327;
        Mon, 19 Jun 2017 19:48:32 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:bc0c:b118:3a9a:5fd4])
        by smtp.gmail.com with ESMTPSA id u74sm25026709pfg.20.2017.06.19.19.48.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 19:48:31 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCH 06/26] diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_FRAGINFO
Date:   Mon, 19 Jun 2017 19:47:56 -0700
Message-Id: <20170620024816.20021-7-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170620024816.20021-1-sbeller@google.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
 <20170620024816.20021-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 3af07fa659..a1804a7785 100644
--- a/diff.c
+++ b/diff.c
@@ -562,6 +562,7 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
 enum diff_symbol {
 	DIFF_SYMBOL_SEPARATOR,
 	DIFF_SYMBOL_CONTEXT_MARKER,
+	DIFF_SYMBOL_CONTEXT_FRAGINFO,
 };
 
 static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
@@ -579,6 +580,9 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 		reset = diff_get_color_opt(o, DIFF_RESET);
 		emit_line(o, context, reset, line, len);
 		break;
+	case DIFF_SYMBOL_CONTEXT_FRAGINFO:
+		emit_line(o, "", "", line, len);
+		break;
 	default:
 		die("BUG: unknown diff symbol");
 	}
@@ -704,8 +708,8 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 
 	strbuf_add(&msgbuf, line + len, org_len - len);
 	strbuf_complete_line(&msgbuf);
-
-	emit_line(ecbdata->opt, "", "", msgbuf.buf, msgbuf.len);
+	emit_diff_symbol(ecbdata->opt,
+			 DIFF_SYMBOL_CONTEXT_FRAGINFO, msgbuf.buf, msgbuf.len);
 	strbuf_release(&msgbuf);
 }
 
-- 
2.12.2.575.gb14f27f917

