Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 350601F859
	for <e@80x24.org>; Wed,  7 Sep 2016 23:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752019AbcIGXg7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 19:36:59 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36682 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751644AbcIGXg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 19:36:57 -0400
Received: by mail-pf0-f169.google.com with SMTP id 128so11271604pfb.3
        for <git@vger.kernel.org>; Wed, 07 Sep 2016 16:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jK+WxyybCzUdqxsnnuAnCkr/Uvol1z6w+noetw00eiM=;
        b=K+S2UZx3WovYCRitwDGOgWF3e6Bg8BVaL7CkVffQ1Lt9MfWwrzq+sZ2/f4nM84ppam
         rqLizTy3YSVf13nSweJPrIlTctQTZaHLSYCB7quUPQ3EeYcGxXJFEfCDKp76Hbano5J7
         Pctyb9SxyJQNFXFOKA9mh9YWPavF0k4QNcnTOQiC8GOJ44hF1VQuSereKBQv92DDpFmG
         riwgBc8GcOx9GArm4dULUNZo/DfoCYFQ+prhkaCA303r6MPURFHmMSdhF/9nKmJHPVeF
         /Jd3sPfw06pB0h13RBZZEm+Vny4VZMZoJQ1+Orv/e6OHYV4iM7YOS10Mt87GK9DgH8IR
         dZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jK+WxyybCzUdqxsnnuAnCkr/Uvol1z6w+noetw00eiM=;
        b=CM3TkVX20lB5vILDBhRCILIQoRO665ifk/Ed92B27buzQ5VwDYrkb/17DoeQkrsJDT
         NWlsqhFkK5k73Fbh/apX/yM7QOYEZ58pT2TllVBBwpyy7JjOxpPyIkhrznGlidocufrc
         j6jcJr/v1SyKUXTkeKptQ//4DlpA/kYroeRU2SsqMWT2N2vbEXreHo2Xf2YpUVU3s9Kl
         5n0z5n7AUY1B3/ROfA9SazZ2VV3r2ZKbGlzW33QM/xYB5R6VUZzGcIhsOtLbMHt5OPPH
         wu5tFsvyfIbdPBDxZBnNO4OB9bgd2ck3BdA9hDugjBW4dAcWbJvT+L3dRaGePpKaIUbr
         pilA==
X-Gm-Message-State: AE9vXwPkwG0rE18Dz/JFhESR2+HlPOFDpD6LmX9paEPQYtvvbqJ2aa9ne8dC8mWKM5ZcFkBC
X-Received: by 10.98.17.83 with SMTP id z80mr87575553pfi.38.1473291416347;
        Wed, 07 Sep 2016 16:36:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:f111:face:c1e2:bcdc])
        by smtp.gmail.com with ESMTPSA id y2sm51463194pan.31.2016.09.07.16.36.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Sep 2016 16:36:55 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] diff: omit found pointer from emit_callback
Date:   Wed,  7 Sep 2016 16:36:45 -0700
Message-Id: <20160907233648.5162-3-sbeller@google.com>
X-Mailer: git-send-email 2.10.0.2.g0676c79.dirty
In-Reply-To: <20160907233648.5162-1-sbeller@google.com>
References: <20160907233648.5162-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We keep the actual data in the diff options, which are just as accessible.
Remove the pointer stored in struct emit_callback for readability.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 4a6501c..79ad91d 100644
--- a/diff.c
+++ b/diff.c
@@ -354,7 +354,6 @@ struct emit_callback {
 	const char **label_path;
 	struct diff_words_data *diff_words;
 	struct diff_options *opt;
-	int *found_changesp;
 	struct strbuf *header;
 };
 
@@ -722,7 +721,6 @@ static void emit_rewrite_diff(const char *name_a,
 
 	memset(&ecbdata, 0, sizeof(ecbdata));
 	ecbdata.color_diff = want_color(o->use_color);
-	ecbdata.found_changesp = &o->found_changes;
 	ecbdata.ws_rule = whitespace_rule(name_b);
 	ecbdata.opt = o;
 	if (ecbdata.ws_rule & WS_BLANK_AT_EOF) {
@@ -1215,13 +1213,13 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
 	struct diff_options *o = ecbdata->opt;
 	const char *line_prefix = diff_line_prefix(o);
+	o->found_changes = 1;
 
 	if (ecbdata->header) {
 		fprintf(o->file, "%s", ecbdata->header->buf);
 		strbuf_reset(ecbdata->header);
 		ecbdata->header = NULL;
 	}
-	*(ecbdata->found_changesp) = 1;
 
 	if (ecbdata->label_path[0]) {
 		const char *name_a_tab, *name_b_tab;
@@ -2437,7 +2435,6 @@ static void builtin_diff(const char *name_a,
 		memset(&ecbdata, 0, sizeof(ecbdata));
 		ecbdata.label_path = lbl;
 		ecbdata.color_diff = want_color(o->use_color);
-		ecbdata.found_changesp = &o->found_changes;
 		ecbdata.ws_rule = whitespace_rule(name_b);
 		if (ecbdata.ws_rule & WS_BLANK_AT_EOF)
 			check_blank_at_eof(&mf1, &mf2, &ecbdata);
-- 
2.10.0.2.g0676c79.dirty

