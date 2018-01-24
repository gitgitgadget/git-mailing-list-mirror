Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F24531F404
	for <e@80x24.org>; Wed, 24 Jan 2018 02:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752289AbeAXCye (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 21:54:34 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43819 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752096AbeAXCyd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 21:54:33 -0500
Received: by mail-qt0-f193.google.com with SMTP id s3so6859177qtb.10
        for <git@vger.kernel.org>; Tue, 23 Jan 2018 18:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=J1UiI32iBz6OA2KBPOYJJjigOJPw01XiD52SEVG4xcw=;
        b=coFA6MGOQCTmva55mV7YepDgQPS86tsq03ESucpVDmJQIG7uPAmdUDNKf2aRiJrCxJ
         fMTPsNUsvsMYo5fnOylA0EThzCg3MrsBosFH6xy7eopVPTPMygohMVs4D5Jlr89VdZF/
         TG2dD0lpbsccpDOLxWHErFBoBh5NUJg1zsCpb6DhGYOrcSnKTSfvwMUskXpyAHTzlgN9
         +aU8HCS1eATG3nCRlcx49wY+sn7ou06aKe9LAFPL6cUql4WuKN7/H6XKa5YN78xavUxp
         AakS/NBpWRTWzer1/yQJKbIKzMXP+m1Z/jcQYi80tDpYXbYyUGF1hXMab/2/O4mUuRdg
         wmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J1UiI32iBz6OA2KBPOYJJjigOJPw01XiD52SEVG4xcw=;
        b=Hi8tqL+LG9ToVfEPx/JFr2OWj1RSQZpvVVy2/VJudBHydweinOgiCLjIw+K/mV7IBt
         q/F29Iz5dmI2ApGuoEitiN0X2Smg38QMr+jJIuOMLLLGZpvC9ZPfYufl5ueF2Nig3mCh
         bKQDfltb51c8fuPe8VlB9m2UddO5sPYLx6twtiu+oFtTlWPQgWvp19tbB9GzfR6sb2dM
         J3KTEn3PqIYwBdMaCgfIv9bX4h6TZDXGDUipyf3/PlTUZa00elTfcFF3iJXuY+lF+Wu+
         IgxC4PITOelGqfJN7x5fPDmobe/g7Lf9BDftg6xZ9faaiAN4u+u6KUfXthdWok4kTUZs
         7rxg==
X-Gm-Message-State: AKwxytf/1RlwnxVwMFKysX649uBjwLE1+/hK8z/jzqaikvbQY7nU/OW4
        Nt8tvNFf+ahq9qQ6uhbvoz95rA==
X-Google-Smtp-Source: AH8x22461hFdARr48HPMi1L3p0TcqLzSOEE/L3+v4D+D0Cwl3oc+Vhb0hK9Bw2Kw8ou6euZd50eIJg==
X-Received: by 10.55.204.81 with SMTP id r78mr6937644qki.356.1516762472962;
        Tue, 23 Jan 2018 18:54:32 -0800 (PST)
Received: from dinah.fibertel.com.ar ([2800:21a0:4000:1382::2])
        by smtp.gmail.com with ESMTPSA id m69sm14207859qkm.56.2018.01.23.18.54.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jan 2018 18:54:32 -0800 (PST)
From:   "Juan F. Codagnone" <jcodagnone@gmail.com>
To:     git@vger.kernel.org
Cc:     "Juan F. Codagnone" <jcodagnone@gmail.com>
Subject: [PATCH] mailinfo: avoid segfault when can't open files
Date:   Tue, 23 Jan 2018 23:54:17 -0300
Message-Id: <20180124025417.32497-1-jcodagnone@gmail.com>
X-Mailer: git-send-email 2.16.1.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If <msg> or <patch> files can't be opened, clear_mailinfo crash as
it follows NULL pointers.

Can be reproduced using `git mailinfo . .`

Signed-off-by: Juan F. Codagnone <jcodagnone@gmail.com>
---
 mailinfo.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index a89db22ab..035abbbf5 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -1167,11 +1167,13 @@ void clear_mailinfo(struct mailinfo *mi)
 	strbuf_release(&mi->inbody_header_accum);
 	free(mi->message_id);
 
-	for (i = 0; mi->p_hdr_data[i]; i++)
-		strbuf_release(mi->p_hdr_data[i]);
+	if(mi->p_hdr_data != NULL)
+		for (i = 0; mi->p_hdr_data[i]; i++)
+			strbuf_release(mi->p_hdr_data[i]);
 	free(mi->p_hdr_data);
-	for (i = 0; mi->s_hdr_data[i]; i++)
-		strbuf_release(mi->s_hdr_data[i]);
+	if(mi->s_hdr_data != NULL)
+		for (i = 0; mi->s_hdr_data[i]; i++)
+			strbuf_release(mi->s_hdr_data[i]);
 	free(mi->s_hdr_data);
 
 	while (mi->content < mi->content_top) {
-- 
2.14.3

