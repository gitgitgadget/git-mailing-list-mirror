Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57E55207BC
	for <e@80x24.org>; Thu, 20 Apr 2017 11:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942441AbdDTL0r (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 07:26:47 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:32859 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031189AbdDTL0n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 07:26:43 -0400
Received: by mail-io0-f193.google.com with SMTP id k87so15222878ioi.0
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 04:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w6p3Cdl97ad9b9d1tgIEx35twqDxZufbgvCuxmFn2HM=;
        b=G698kEoVkBKdUfKajMz29x8jNeYS1QzN8xtgyTJ13mHn0m8544HPnxvM8OO7I+Esof
         tAdK1Ge4ANEUBSvHJusqDrGCkrNkLIOGb4e38sNrM1owW3QB5AGGB+ejSPhuUgRc7rxX
         CRsRIhl5VgvVaXdFJXsM5D3ZQ24X4zqKq+Z3eRlIQdM/jt51BUNeJ89oP6gUN01OIlh4
         lgE9lJUwjtf5KSrkaYRVyJAm+38l2SqEMqyFzs/OEKtZPBOcFLFJRTDlQYDgdfIJFQs5
         XMchteOpW+0XmjQ4dFAhKZiely57KGnfrSpOfjvxeK0G0cIbYm5rx7fkUBl9KlkRMqAg
         Xafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w6p3Cdl97ad9b9d1tgIEx35twqDxZufbgvCuxmFn2HM=;
        b=JKuz+f9xkjTu+LexMBaxTAkB2hTIg1BDguW/FJMVeennPmelQNXvsN5xpCdlMpk+F7
         N3sYDWtBuoJeO3W+hGBM/tdgiIgGv8xdUJfj8VkHz9qTEfyn0Psn27F98OaAXIajhZMl
         qnozE10Ai15IiLU1++wMLGGGnHZ6ViOhClsinRKytmS9pCnP8ZPMAAtXdxCh94rEHE9W
         VshpOM4wLmSjfkBkjNS45n7x9M4fodcXukBbMHCmLJTclAwfM0Ve847+UQfrXPgCwPwp
         HNel8xkACzchiXLx+nYeiePeZVnJCxtstjyVVlVSOF1wEWrfjKMiKKG+dG2UFDheFAab
         JYUQ==
X-Gm-Message-State: AN3rC/7yFTeAFLnL7+3w02qb0TyCu8gItJNsTCxriiTAf+UU3bqEtCjg
        hkqEi0Z4pbMjlg==
X-Received: by 10.99.102.134 with SMTP id a128mr7591381pgc.42.1492687592332;
        Thu, 20 Apr 2017 04:26:32 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id m194sm10039964pga.62.2017.04.20.04.26.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 04:26:31 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 20 Apr 2017 18:26:27 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 02/15] bisect: report on fopen() error
Date:   Thu, 20 Apr 2017 18:25:56 +0700
Message-Id: <20170420112609.26089-3-pclouds@gmail.com>
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

The main thing to catch here is when fopen() is called on a
directory. It's safe even without this change because a few lines
earlier we do check if "filename" is a regular file.

Regardless, let's stay on the safe side in case somebody changes those
lines. Unconditionally printing to stderr by warn_on_inaccessible()
should be fine, because the caller does unconditional fprintf(stderr,
too, no checking for quiet option or anything.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 bisect.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/bisect.c b/bisect.c
index 03af06c66c..6dc4dc9397 100644
--- a/bisect.c
+++ b/bisect.c
@@ -669,8 +669,11 @@ static int is_expected_rev(const struct object_id *oid)
 		return 0;
 
 	fp = fopen(filename, "r");
-	if (!fp)
+	if (!fp) {
+		if (errno != ENOENT)
+			warn_on_inaccessible(filename);
 		return 0;
+	}
 
 	if (strbuf_getline_lf(&str, fp) != EOF)
 		res = !strcmp(str.buf, oid_to_hex(oid));
-- 
2.11.0.157.gd943d85

