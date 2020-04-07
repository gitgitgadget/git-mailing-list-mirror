Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C934CC2BB86
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A033F2078C
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTLwaDfx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgDGO20 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:28:26 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42451 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729040AbgDGO2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 10:28:24 -0400
Received: by mail-qt1-f196.google.com with SMTP id b10so2759971qtt.9
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 07:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b/2hoE+6wPB6yrTn/Ub3LVA7378nqWm6uLTwohQhczY=;
        b=iTLwaDfx4WG7H/dWmEHzH+yEbjtcy+bo90vKhoo9ClsN+3b+BoEOE+5wc0z6d04cc/
         Q1STb/TofwmT1NOvaq1T0bROuUXOg64i+YPk5aB7/1F4lRBvka87OXTxITkdBM6aRher
         dcI9kY0TOqXoJjKFiuX/bODSBSEiIAz927yz4Bv/vEHHWacJ2g5WfYEYFBg/eafmw66f
         WHGqWrXTSRiPYKchTgga+7PfzeicTbaGZYDQt5wVpHgWzTT3GZ4yXQu/2WB6YlgZgGpP
         gucZu01Ne8hwF7PPtiIYnUk/ZbdyB8Q8+/VdIluXuzn4sdgTYc9juKQ95ASHJ0Hgnumi
         q16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b/2hoE+6wPB6yrTn/Ub3LVA7378nqWm6uLTwohQhczY=;
        b=kBFUwMLpyzsU5xibEA77EXRqfD2zzeVc8LJaz72HvpLatRRlrUUZdf3yvXIKTJN34F
         +TvJEo1oqVl4flvrKPKJraw3XvgmpH1pKZ26+swlm1M0QNWI5TJL4HY/ybvbKupvOKWu
         UDJJ2V28+vBsYGDAMZuhnDFc1nKRLZ8IFvoY3KL2sJu4JI1lVZYkErJpp9W+tmGDkO6d
         6eu+9n4sqXE5T1e0lgL4hMOWt0VhYGAqStiBDDWybEKT0QJCBbuEXTqJimbUjrW+lb6Q
         ySaHfyxTAC8G2+mGtk3rOlJ5nJKZYPRkh6DF/RsbbIWdFtqTJkhziNFk3k3FZD4t7RAI
         Q0rQ==
X-Gm-Message-State: AGi0PuY4ht9ay1eJ6SMryDhRAljosu27pDmSDJGrsffrM9LLUwhaf+gZ
        E2HJ089KvZxQq3m580yS74xwcsTW
X-Google-Smtp-Source: APiQypKfFsREyAotkEnKmGnS6qxWKZlhf5TRdf8HyiPGDPUZgPNeeeo6y5YAojYYaP4VX91s3bt/IQ==
X-Received: by 2002:ac8:3466:: with SMTP id v35mr2544377qtb.308.1586269702991;
        Tue, 07 Apr 2020 07:28:22 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id j6sm17051736qti.25.2020.04.07.07.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:28:22 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v5 04/22] sequencer: make file exists check more efficient
Date:   Tue,  7 Apr 2020 10:27:51 -0400
Message-Id: <dc4674d222317fa2f503e6e1b3cad6a78dd70676.1586269543.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1586269542.git.liu.denton@gmail.com>
References: <cover.1585962672.git.liu.denton@gmail.com> <cover.1586269542.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We currently check whether a file exists and return early before reading
the file. Instead of accessing the file twice, always read the file and
check `errno` to see if the file doesn't exist.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 sequencer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index faab0b13e8..a961cf5a9b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -433,11 +433,9 @@ static int read_oneliner(struct strbuf *buf,
 {
 	int orig_len = buf->len;
 
-	if (!file_exists(path))
-		return 0;
-
 	if (strbuf_read_file(buf, path, 0) < 0) {
-		warning_errno(_("could not read '%s'"), path);
+		if (errno != ENOENT && errno != ENOTDIR)
+			warning_errno(_("could not read '%s'"), path);
 		return 0;
 	}
 
-- 
2.26.0.159.g23e2136ad0

