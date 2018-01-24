Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 667E81F404
	for <e@80x24.org>; Wed, 24 Jan 2018 16:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934319AbeAXQ47 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 11:56:59 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:32789 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933988AbeAXQ46 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 11:56:58 -0500
Received: by mail-qt0-f194.google.com with SMTP id d8so12061906qtm.0
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 08:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=my8kPfTgaMg/N25E61F137JbG3AvnJUDw6hylD9ej4g=;
        b=lwvpcQqwczTiwYsYJvATnI2WfiwMQE6w+3/INS6p/f1OdBo6v6vsGOPA8vMW4Gj7YT
         3kpDoRNjqKwoQKJdoK1g2ugZ5XvvhhdaxX+RD1CA0xrfobHdRDYTvT79ILG3s6162/od
         hbjdiukSH0IBJBqfmJAZ+x7DDyw5DsHofLUXaKJc9k+3yXYq8gZSyya2nPfGWIW/UIYW
         Bdqmt1D81PW+04/OaLWm/7MwFCUUGn8gKpCeZ4zSg90O5Cp4Oxyww0W8cEtENvg7g4QJ
         0EVCPeoFNnA+0hN55v24B7zT11rj6h9vocEZkjAtvrPhKAL0yk5AB+biErW2qoh/lf6M
         ejLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=my8kPfTgaMg/N25E61F137JbG3AvnJUDw6hylD9ej4g=;
        b=P+MYv3lxgcBndx4aswQ6UIJMipXMobkX4NumWGLA4UHkNmOtZl7hwPyXbcvmCcLZAG
         tt2e65giyTEC1QSu6cxwbW8C+ZPiQWIjCHyjcC4blC7ZzLDGo34aqR7VS63T/bPhvtM+
         +r6gerD5F+4j6ZgmZogwwsMmW4Vs8c04oRTDXEn7+b16T3q7OmyzAImXGnGDeblRG4F9
         FB1eVx4tTEdStrQuYOlW65eVcSvRGygR+uy4bXepSVF37A7FF1L8kaxSLHpELUTNW+Iz
         f+o5MuCoXjO1sW0t/Kzp8gkw/8TZHD8+7SNDIAYL1+MHy4ETX6Ar+fizuV6JxfcaTNv9
         A5Kw==
X-Gm-Message-State: AKwxytcrJoIJHOTbVxWzq5CuOq8SD4VvobmIGRvevgOGUNB20JR0fMb5
        784qXCX1Iba7ThZyFs+RYYYZRm34
X-Google-Smtp-Source: AH8x227r/J0Nbo3QUXHJ6RFl40lyIKMo64+zmzg99c1zaX295dU8uUqsUnn68PhKGEVTVjVxCT98kQ==
X-Received: by 10.237.57.165 with SMTP id m34mr10010680qte.258.1516813017312;
        Wed, 24 Jan 2018 08:56:57 -0800 (PST)
Received: from dinah.internal.zauberlabs.com ([190.210.239.57])
        by smtp.gmail.com with ESMTPSA id m1sm514724qkf.8.2018.01.24.08.56.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jan 2018 08:56:56 -0800 (PST)
From:   "Juan F. Codagnone" <jcodagnone@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "Juan F. Codagnone" <jcodagnone@gmail.com>
Subject: [PATCH v1] mailinfo: avoid segfault when can't open files
Date:   Wed, 24 Jan 2018 13:56:47 -0300
Message-Id: <20180124165647.7386-1-jcodagnone@gmail.com>
X-Mailer: git-send-email 2.16.1.dirty
In-Reply-To: <20180124040232.GB1330@sigill.intra.peff.net>
References: <20180124040232.GB1330@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If <msg> or <patch> files can't be opened, then mailinfo() returns an
error before it even initializes mi->p_hdr_data or mi->s_hdr_data.
When cmd_mailinfo() then calls clear_mailinfo(), we dereference the
NULL pointers trying to free their contents.

Signed-off-by: Juan F. Codagnone <jcodagnone@gmail.com>
Reviewed-by: Jeff King <peff@peff.net>
---
 mailinfo.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index a89db22ab..d04142ccc 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -1167,11 +1167,13 @@ void clear_mailinfo(struct mailinfo *mi)
 	strbuf_release(&mi->inbody_header_accum);
 	free(mi->message_id);
 
-	for (i = 0; mi->p_hdr_data[i]; i++)
-		strbuf_release(mi->p_hdr_data[i]);
+	if (mi->p_hdr_data)
+		for (i = 0; mi->p_hdr_data[i]; i++)
+			strbuf_release(mi->p_hdr_data[i]);
 	free(mi->p_hdr_data);
-	for (i = 0; mi->s_hdr_data[i]; i++)
-		strbuf_release(mi->s_hdr_data[i]);
+	if (mi->s_hdr_data)
+		for (i = 0; mi->s_hdr_data[i]; i++)
+			strbuf_release(mi->s_hdr_data[i]);
 	free(mi->s_hdr_data);
 
 	while (mi->content < mi->content_top) {
-- 
2.14.3

