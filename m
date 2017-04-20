Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52D6C207BC
	for <e@80x24.org>; Thu, 20 Apr 2017 11:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S944873AbdDTL1U (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 07:27:20 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34099 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S944521AbdDTL1P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 07:27:15 -0400
Received: by mail-io0-f195.google.com with SMTP id h41so15344459ioi.1
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 04:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NVO8YxpyRVEFxo6XMO5ECf1pS8CFy9ApzuYaRcSk4y4=;
        b=PrgIvVzdH+uCmVyYVodQBpuJ5MoFKSjfvObo/iMhBLLLCk3x5791TGm+OY9hoLDbBv
         uAncfiaYEyw+38GLnSTmPA5RdVAHUCYz9/dXHj2QIiZzIkHwajdvSoVMVewow4SkXydX
         h2vbarcEqWzCCzZc9VQWF1Jd2oU9IJF0croCrNalr/49/KC4ONtQZfcgPKxmHFeZAFey
         rIRziZL9S9S8lUPfIeBHV5Uxk/KLRqzv7vCu49g2G0ZvCp/Mbcj7lfQn8CgS/koHRlmm
         0PZW9FqQS4gBCeTfhtHeEPjIZX7YO/krdNdoGhSAEDkCw6BXX8zS5gcZMOijqceFdsFZ
         CnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NVO8YxpyRVEFxo6XMO5ECf1pS8CFy9ApzuYaRcSk4y4=;
        b=Y/Vj4MSMX0njc6EIsPpMnGbBJFeskgbmb1B6yj/XYCHYI0b/8YlOgKRnkONslNWY/X
         QOgdPWOKOGQvOzXb8UtYSV9v7K16NfQtY4MzH+lmBKGPpOvJpBnbpQPVmpH5NONV9ieS
         k5BBai6gx8lnLwJgDrm7frbu9KsVpoXS8GlMrZ2lRhgotZCzZwZp6JGFhSx79sOAQNpB
         pVO1Yd/wfSOjhv4CLwE3rE6WpQ1Qah3A+faCLH3u9G67kQksOFR4M6kO6LJIZP64BG+o
         jlMoeGIeuULz/1+na1VHDP9WsNO2tDpx9GWSAdGmKOmQll6eF/btJvxUZFGpnlHkmqse
         Joqg==
X-Gm-Message-State: AN3rC/7HLLDZeE5KnJf44czuMrYakjc22ieWDtE0orxhM9doMc1PbqTT
        a+yuCcxayqfXSw==
X-Received: by 10.98.18.137 with SMTP id 9mr7730671pfs.75.1492687634694;
        Thu, 20 Apr 2017 04:27:14 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id 3sm10030239pge.12.2017.04.20.04.27.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 04:27:14 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 20 Apr 2017 18:27:09 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 10/15] sequencer.c: report error on failure to fopen()
Date:   Thu, 20 Apr 2017 18:26:04 +0700
Message-Id: <20170420112609.26089-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170420112609.26089-1-pclouds@gmail.com>
References: <20170420112609.26089-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sequencer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 77afecaebf..8d5ebfc14f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -919,8 +919,11 @@ static void record_in_rewritten(struct object_id *oid,
 		enum todo_command next_command) {
 	FILE *out = fopen(rebase_path_rewritten_pending(), "a");
 
-	if (!out)
+	if (!out) {
+		if (errno != ENOENT)
+			warn_on_inaccessible(rebase_path_rewritten_pending());
 		return;
+	}
 
 	fprintf(out, "%s\n", oid_to_hex(oid));
 	fclose(out);
-- 
2.11.0.157.gd943d85

