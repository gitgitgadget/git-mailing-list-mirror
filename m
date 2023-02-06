Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174BCC05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 19:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjBFTIv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 14:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjBFTIs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 14:08:48 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B002B091
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 11:08:47 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so11498691wmb.4
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 11:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9ff3x2NgXbDUwLQwuAkvnY4NbIsuw7HvaFDlZV/vVs=;
        b=MhCNP2gZPIVC7nyMHjFABxtGpre3hk9EG+CBbna0MBmCHRDGCbZoIqodVgocG0OzoO
         Wj2WLMS7vb8UbLrVNykiUL7p5n0oRvIDA3ykcACIxow9TK6N2G5tEG1i3Cqr/Gwcol6H
         2IVFaPVVF1wh6nrZ9VqDOW4x4bNlnr4Cijn+ZtbL2unzkIUyhGHwDQOuHWdnIm7NOsRZ
         43hiJ9TS7pb3GyeZj+dzwwcG0Ce4x6s+NmsibNIekq7Hbmb2AwE8lLR4fofwlLUZTdri
         1CLXw13w1YFu9yDnUlQ3asKWLeyu55ApNsCHTJrkvmYnxQXqPqr/OIQ3RWMXGriNlrN+
         8lYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9ff3x2NgXbDUwLQwuAkvnY4NbIsuw7HvaFDlZV/vVs=;
        b=xQpFtfnAaiTYjDgou6HiP8E8IPgHnjpwjx9fpM5tgKQQtaodp+jNovIm4351mkN3ms
         P7ikuyzVfsJuESi9mI/NgYmSVPO3JbKtW3jkzz/R5pQhbvCPC1eW1+3b/zwAcWvSeqZ8
         xFNgl7QSOqs31tGheFmSlL8DPEN9aA5Dg2eaqTZBX9qzgQreYSTsAJSD0+BfhSCmyHqj
         08fAMbmYM0gpnxNYcXgMfqUprxoGs5cnLZmtdRvrWTpSOc7GdfAlokz1BXCuI4z3RK2o
         Ayas0jLJi7v9ltolzDZL8K8iN1sA+rXytd0b3wlS2IvaZXdZTBWVULedx0Q0cCLZ/t4R
         Oq8g==
X-Gm-Message-State: AO0yUKU6J10YoKpKEK9K8aCt3pOisEEmWEkVa9lG/U8QSeskazIl96Vh
        tGI8Snzn/6ItXwnzz729ncAcAaVSa+jgzyEk
X-Google-Smtp-Source: AK7set8JAOmwE1dwtq8uqWnumpz7ty2GufI30v3cuRRQfAK6tM/5Q+9gmB6B2B2I1NyBWNo4qD7gmA==
X-Received: by 2002:a05:600c:4918:b0:3dc:d5c:76d9 with SMTP id f24-20020a05600c491800b003dc0d5c76d9mr820292wmp.0.1675710525795;
        Mon, 06 Feb 2023 11:08:45 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p2-20020a05600c358200b003dc4ecfc4d7sm12538595wmq.29.2023.02.06.11.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 11:08:45 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/8] sequencer.c: split up sequencer_remove_state()
Date:   Mon,  6 Feb 2023 20:08:07 +0100
Message-Id: <patch-v4-2.8-b0c9da95ca1-20230206T190346Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1425.ge02fe682bd8
In-Reply-To: <cover-v4-0.8-00000000000-20230206T190346Z-avarab@gmail.com>
References: <patch-v3-7.8-ee8262ab22a-20230118T160600Z-avarab@gmail.com> <cover-v4-0.8-00000000000-20230206T190346Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split off the free()-ing in sequencer_remove_state() into a utility
function, which will be adjusted and called independent of the other
code in sequencer_remove_state() in a subsequent commit.

The only functional change here is changing the "int" to a "size_t",
which is the correct type, as "xopts_nr" is a "size_t".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sequencer.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 3e4a1972897..b6392b43204 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -351,10 +351,22 @@ static const char *gpg_sign_opt_quoted(struct replay_opts *opts)
 	return buf.buf;
 }
 
+static void replay_opts_release(struct replay_opts *opts)
+{
+	free(opts->gpg_sign);
+	free(opts->reflog_action);
+	free(opts->default_strategy);
+	free(opts->strategy);
+	for (size_t i = 0; i < opts->xopts_nr; i++)
+		free(opts->xopts[i]);
+	free(opts->xopts);
+	strbuf_release(&opts->current_fixups);
+}
+
 int sequencer_remove_state(struct replay_opts *opts)
 {
 	struct strbuf buf = STRBUF_INIT;
-	int i, ret = 0;
+	int ret = 0;
 
 	if (is_rebase_i(opts) &&
 	    strbuf_read_file(&buf, rebase_path_refs_to_delete(), 0) > 0) {
@@ -373,14 +385,7 @@ int sequencer_remove_state(struct replay_opts *opts)
 		}
 	}
 
-	free(opts->gpg_sign);
-	free(opts->reflog_action);
-	free(opts->default_strategy);
-	free(opts->strategy);
-	for (i = 0; i < opts->xopts_nr; i++)
-		free(opts->xopts[i]);
-	free(opts->xopts);
-	strbuf_release(&opts->current_fixups);
+	replay_opts_release(opts);
 
 	strbuf_reset(&buf);
 	strbuf_addstr(&buf, get_dir(opts));
-- 
2.39.1.1425.ge02fe682bd8

