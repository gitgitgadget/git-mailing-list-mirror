Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B783C433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 14:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B3D564DEC
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 14:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhBPOHr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 09:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhBPOHq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 09:07:46 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC47C06174A
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 06:07:05 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id x3so1351315qti.5
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 06:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JVV7qM3fU1nF9mfuasDDO2vc9sskcC4PjPUd+EVxGjg=;
        b=iz1+4pAm2D8xpIkIDd2AUxW3mMhj1QxLSdemyzVgyLboBB9PUBFvbVoXWP4zvspK/l
         NmidV7GS2gO04pMHg3EqcEeUVPkD7f1rWJGCavSEyHz7QWNClQ3hAb+6PJRe22PUjQWO
         1r/uQQ6bFSxyicjity6X44wxdIR3bK89byZlkL2vyMipq3mM6Z4PfBsMRKSUigv1LZry
         T1J+T+4fZROOqc4cPcKELTDTugM2Bim7C6SvbtMwRSEac50jnNFFVI+xQnSRKLcZMqtg
         zMrtWkrSqYV0ckBAem/WhMK4AG5vEsJcLcfhfc9lxU67r6Fs/U5pt7ISPiP5XKG1at1d
         /A/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JVV7qM3fU1nF9mfuasDDO2vc9sskcC4PjPUd+EVxGjg=;
        b=tYwYzlHVx7CmQGulJAaYrLps6PcBwPkPIQZA4F6Da3nxU9ezXMxIa1NiOMZkM8XN0A
         HFkMX4hHl5f94hLlJxFf2Y5KQ/3F03yb393QEyYv1ufzkUP7SOsJO32ihUaF2drVFCFw
         9MsS3bhcJ4Sjz7kp/PJUlWl8I8htMWwLeTMgw8dktTuH/iGNR4Q98A7Ka51D2z0jpdD+
         vH+yiBZ8FB4WigU7Sb/fSRTci2ql35Nck0Q/6LcvbT5kJAsy4GDo8w/Xons6DwDSST2G
         x1TtWlrYiP4A1k/BH4ErRpi3TSlQUNsJWRXTAhP1Xy/9id1i6VuOlsAIjkO//sJLmrrW
         XpKg==
X-Gm-Message-State: AOAM532lWgt/4Gg/JWZMYOPBoaRwidF6G55cDmtzA+t4BfICAWvdZst5
        tFwk8oS7XFQnPeXgVYDX1lx/Qmbs6Qh2UQ==
X-Google-Smtp-Source: ABdhPJzxo6TJgQUN4qEpgvFUw5G/5De7F4/TjZkl/o5Z7h+6bE37HoJqITszBcbaqYKPtCdfNKXMdQ==
X-Received: by 2002:aed:2941:: with SMTP id s59mr18866313qtd.323.1613484424577;
        Tue, 16 Feb 2021 06:07:04 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id x62sm14303049qkd.1.2021.02.16.06.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 06:07:03 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v3 2/2] checkout-index: omit entries with no tempname from --temp output
Date:   Tue, 16 Feb 2021 11:06:52 -0300
Message-Id: <8dec184326d1bb4e18975d96f93f536cfd1543fd.1613483833.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1613483833.git.matheus.bernardino@usp.br>
References: <cover.1613483833.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With --temp (or --stage=all, which implies --temp), checkout-index
writes a list to stdout associating temporary file names to the entries'
names. But if it fails to write an entry, and the failure happens before
even assigning a temporary filename to that entry, we get an odd output
line. This can be seen when trying to check out a symlink whose blob is
missing:

$ missing_blob=$(git hash-object --stdin </dev/null)
$ git update-index --add --cacheinfo 120000,$missing_blob,foo
$ git checkout-index --temp foo
error: unable to read sha1 file of foo (e69de29bb2d1d6434b8b29ae775ad8c2e48c5391)
        foo

The 'TAB foo' line is not much useful and it might break scripts that
expect the 'tempname TAB foo' output. So let's omit such entries from
the stdout list (but leaving the error message on stderr).

We could also consider omitting _all_ failed entries from the output
list, but that's probably not a good idea as the associated tempfiles
may have been created even when checkout failed, so scripts may want to
use the output list for cleanup.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/checkout-index.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 4bbfc92dce..023e49e271 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -23,22 +23,35 @@ static struct checkout state = CHECKOUT_INIT;
 static void write_tempfile_record(const char *name, const char *prefix)
 {
 	int i;
+	int have_tempname = 0;
 
 	if (CHECKOUT_ALL == checkout_stage) {
-		for (i = 1; i < 4; i++) {
-			if (i > 1)
-				putchar(' ');
-			if (topath[i][0])
-				fputs(topath[i], stdout);
-			else
-				putchar('.');
+		for (i = 1; i < 4; i++)
+			if (topath[i][0]) {
+				have_tempname = 1;
+				break;
+			}
+
+		if (have_tempname) {
+			for (i = 1; i < 4; i++) {
+				if (i > 1)
+					putchar(' ');
+				if (topath[i][0])
+					fputs(topath[i], stdout);
+				else
+					putchar('.');
+			}
 		}
-	} else
+	} else if (topath[checkout_stage][0]) {
+		have_tempname = 1;
 		fputs(topath[checkout_stage], stdout);
+	}
 
-	putchar('\t');
-	write_name_quoted_relative(name, prefix, stdout,
-				   nul_term_line ? '\0' : '\n');
+	if (have_tempname) {
+		putchar('\t');
+		write_name_quoted_relative(name, prefix, stdout,
+					   nul_term_line ? '\0' : '\n');
+	}
 
 	for (i = 0; i < 4; i++) {
 		topath[i][0] = 0;
-- 
2.29.2

