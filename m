Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C8F4207D6
	for <e@80x24.org>; Thu,  4 May 2017 13:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755343AbdEDN4Y (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 09:56:24 -0400
Received: from mout.gmx.net ([212.227.15.15]:64005 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755186AbdEDN4X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 09:56:23 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lu874-1e6b1N2FmQ-011TKs; Thu, 04
 May 2017 15:56:15 +0200
Date:   Thu, 4 May 2017 15:56:14 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v4 09/25] mailinfo & mailsplit: check for EOF while parsing
In-Reply-To: <cover.1493906084.git.johannes.schindelin@gmx.de>
Message-ID: <2f54cb32079186abea8ca12c3e81f3d993500673.1493906085.git.johannes.schindelin@gmx.de>
References: <cover.1493740497.git.johannes.schindelin@gmx.de> <cover.1493906084.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:yNjwt6ebGlGPX9LAt/FiY7bCpvKNNdgX5BvMq0FN8A4zXPKVJaR
 WXpcfUzeIPFLJkesaI6NrPeYy6mohhJmu4sqH02o9FTb3okjDDCDrFJrUZDOZggZLHjVvsN
 ca6GqukJVB19rv6EgGVUBlC65r6GhxOeohQlKUUT6RnwNvWSnyD1+vL1YdeaFmwCtIg+snF
 nYr9bGjFRsvMAt09rTWVQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ldy2ksw1AGI=:SWW/B9wSIluuu8GpkWlun3
 4ZGXoi4T4yPf2MLS1PLW6Acmw4LLtMYySWhGj6V4v2fyaj5jIETaMCMGhu1TD7Fh1G4X+Spyb
 O73DyFDKFsG/vHOSZDEBD8LlumZ8+xrJVWRBjHst7qd7CUMrnqOAQRJ53krqHzNP4YSgJto49
 UxQTaEEpLn3cBogu0gT2mYdyki3272g/hdfEABZjmGGCJPzpQ8sZW8mImj+vCSQVcGwWlfYgz
 bxF1STLJ17JQZ/DZB495gPcaXVF2BjiDLsGEDFQKNZiKzsKFofA9VCG5Zcga+HwJXNFkimmGh
 VdZ4qJbVn6ZlF5X6PTYB9a3k5AGSu4DpUdA7PPE2KHcJwrnZ9ZNYhdg824L4DIm3ZnjJIgyay
 pjvwJi3zBzbSDQ8TR+LjzkCwgLbzdvP8Wgejc+qkgpL6LOcgSAcpJFyepy1PdBkDW3sT4vxkN
 gs4NPeMyFOq14NVyfuyXVVYFnRaYVKd0MGw93g7wl7/IlS9kA/e7F/zizeNkIhcrYV/QBHWaa
 +pewTla5jnQ+sVVcT/gVTk5Cha4mAU5ntjUe3geN3HRdiAkVSwbbP8CuwxlUuI4EY+Ugzv2yb
 Gny1sGLTk+21TFMZH4504Hh6opIeVmyOVQQwEovyARE7THtHgSXJyTaDMHYCSK+9SeQhaLPDL
 F0+o9QaviY39fbgEKUdk24ZLbxRTckPRKF8fwT8qanBtBQNEv2kCuXZG4Br45+qD+TXJgTS7G
 CUQrbutP7t8wAxwEHNwj1JVKBVqk/8leKBMKMxnlnB592SpVXm2ZcY0SPVaS3x1Ian2p15Xua
 Bgsj3Um
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While POSIX states that it is okay to pass EOF to isspace() (and it seems
to be implied that EOF should *not* be treated as whitespace), and also to
pass EOF to ungetc() (which seems to be intended to fail without buffering
the character), it is much better to handle these cases explicitly. Not
only does it reduce head-scratching (and helps static analysis avoid
reporting false positives), it also lets us handle files containing
nothing but whitespace by erroring out.

Reported via Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/mailsplit.c | 10 ++++++++++
 mailinfo.c          |  9 ++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 30681681c13..664400b8169 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -232,6 +232,16 @@ static int split_mbox(const char *file, const char *dir, int allow_bare,
 
 	do {
 		peek = fgetc(f);
+		if (peek == EOF) {
+			if (f == stdin)
+				/* empty stdin is OK */
+				ret = skip;
+			else {
+				fclose(f);
+				error(_("empty mbox: '%s'"), file);
+			}
+			goto out;
+		}
 	} while (isspace(peek));
 	ungetc(peek, f);
 
diff --git a/mailinfo.c b/mailinfo.c
index 68037758f2f..f92cb9f729c 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -882,7 +882,10 @@ static int read_one_header_line(struct strbuf *line, FILE *in)
 	for (;;) {
 		int peek;
 
-		peek = fgetc(in); ungetc(peek, in);
+		peek = fgetc(in);
+		if (peek == EOF)
+			break;
+		ungetc(peek, in);
 		if (peek != ' ' && peek != '\t')
 			break;
 		if (strbuf_getline_lf(&continuation, in))
@@ -1099,6 +1102,10 @@ int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
 
 	do {
 		peek = fgetc(mi->input);
+		if (peek == EOF) {
+			fclose(cmitmsg);
+			return error("empty patch: '%s'", patch);
+		}
 	} while (isspace(peek));
 	ungetc(peek, mi->input);
 
-- 
2.12.2.windows.2.800.gede8f145e06


