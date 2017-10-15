Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCC5F20372
	for <e@80x24.org>; Sun, 15 Oct 2017 17:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751865AbdJORHu (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Oct 2017 13:07:50 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:46043 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751386AbdJORHq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Oct 2017 13:07:46 -0400
Received: by mail-wm0-f68.google.com with SMTP id q124so29573620wmb.0
        for <git@vger.kernel.org>; Sun, 15 Oct 2017 10:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KOok9EBJMwEvNZw53+JqkEQpsUbUXHCCW+25XyFqTNY=;
        b=qEv1Wa6TLzrBoTDLdxcuS587DRwyFAZH/KKwdRB7z6r5VhTzQuof08XNDdWXNooTtE
         WFdWsoFMfZLVMsJti2mUAZnrZzZh9zl6td4Ez1pjKyVDm1z2MYGF5+FyV2wHZKCZ4gRp
         jr/EmS8Su1MeaRZfQIdMVC+s2t6urpW/otHD7eaybaQO9WkciIe2Wgi+lkycRKjpJrxL
         Mf6C4mfG5VdgY2RjxytBvE0aIfkvKoNd6ZeXRwUjn+nO6jvThOdwhiuCfrZshrJKqXxH
         ah7EbI1ob8Fws0yeujy11jPZobPZWZEbV9HDCW5hwI0Y0CT7aFQRxz8W3CNG/NlIo8j+
         5Hbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KOok9EBJMwEvNZw53+JqkEQpsUbUXHCCW+25XyFqTNY=;
        b=Xm7qMVT9VoDQlRaBhp0t8l3JriBRkFn7e28fcInVWa6uWQOJfDMhAq7Ttdr6dnxlUT
         WMatciZKOOKQmewCCGTL5kDU1aMWmLeNgM0DfxDfWWAsDM5vaKuHd/SwwopR8Fiz8mdZ
         K+OMbx+t4NrVUe/RhH6maw+FVCALG8AwSpviyyYJ0xv1JeIUQ+XEQFTfcxLmihCUp+rv
         4JGapodirkFQoBSxMWdqzD37h/IL4CGG2wGikLTe35NorXVwZBn7ZsjlINahQg61mraU
         lFNUg8Q5vvI4Qs5ugrmu5TMwL1qkvKFK/jQT+TpcMNqPB+ohQUrhvT/ttoD9og3AeCYQ
         98YQ==
X-Gm-Message-State: AMCzsaXYYGTrh3gcFZT8jESFNJG2zBOk4+vwvGnE43RymYxXM1+ymEMO
        vMKKtCJpsUT6kxUBeqS25EoLjA==
X-Google-Smtp-Source: AOwi7QD4A0Lo69oH5Oxtxq1sCGvYalfrFbmE9b9Vje6W1ReFPoStwQUeetrZIijIL35UGEUjhcws8A==
X-Received: by 10.80.151.22 with SMTP id c22mr10077075edb.247.1508087265159;
        Sun, 15 Oct 2017 10:07:45 -0700 (PDT)
Received: from localhost (cable-62-117-26-3.cust.telecolumbus.net. [62.117.26.3])
        by smtp.gmail.com with ESMTPSA id e14sm4061871edk.95.2017.10.15.10.07.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Oct 2017 10:07:44 -0700 (PDT)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH v2] sequencer.c: fix and unify error messages in rearrange_squash()
Date:   Sun, 15 Oct 2017 19:07:42 +0200
Message-Id: <20171015170742.8395-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.15.0.rc0.296.g7b26d72
In-Reply-To: <20171013175157.13634-1-ralf.thielow@gmail.com>
References: <20171013175157.13634-1-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the write opertion fails, we write that we could
not read. Change the error message to match the operation
and remove the full stop at the end.

When ftruncate() fails, we write that we couldn't finish
the operation on the todo file. It is more accurate to write
that we couldn't truncate as we do in other calls of ftruncate().

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 sequencer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e258bb646..75f5356f6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2948,9 +2948,9 @@ int rearrange_squash(void)
 		if (fd < 0)
 			res = error_errno(_("could not open '%s'"), todo_file);
 		else if (write(fd, buf.buf, buf.len) < 0)
-			res = error_errno(_("could not read '%s'."), todo_file);
+			res = error_errno(_("could not write '%s'"), todo_file);
 		else if (ftruncate(fd, buf.len) < 0)
-			res = error_errno(_("could not finish '%s'"),
+			res = error_errno(_("could not truncate '%s'"),
 					   todo_file);
 		close(fd);
 		strbuf_release(&buf);
-- 
2.15.0.rc0.296.g7b26d72

