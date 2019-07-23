Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06B801F461
	for <e@80x24.org>; Tue, 23 Jul 2019 02:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbfGWC6F (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jul 2019 22:58:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40828 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfGWC6E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jul 2019 22:58:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so18625268pgj.7
        for <git@vger.kernel.org>; Mon, 22 Jul 2019 19:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sKo28ii45pjPa1HHPW6fyW1x+fUwBNG3ZsFpqbeDjeo=;
        b=mOU8Igi03y1FH7srwOs6bFcCCGaUVDPrJy7NVKNOSAm3YdLWdmWC3qhFP9IzfJCNbF
         G9J3zRuFspKOWaG+oIjAvMPIwbwTAz9dM/TOgCCmRlNV2aMQYV4525/kRhSDHKFsBCfZ
         07jLcCNYpQuzwjE3h6UNn59o7Rf2ETwdzTsJC+mU5hc/tMLN9zQK9GP8bSjbhm4xYwxw
         KR5twgXKVkWkp79XERVbkiAouMd7DWQ8ax4aNey1skTxsQPl5k9iCY5xA98p+kmD7Jpf
         DkblGGzY3eI4jNMX8ehmWCG7+8EPzpbv9FGEd1Gu/8zq2tWt4pBxrGlrLY0thU0xKWqH
         JNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sKo28ii45pjPa1HHPW6fyW1x+fUwBNG3ZsFpqbeDjeo=;
        b=dXZFVYEyHzEEGIGnm6yzO1M8OTGyJuq51Tr2PnVe9uDD6UtWVRSuewGFrV7wiqK831
         7QbgHlQBK86efsWM62IKttT31OW8zPweVLdzFeh6QUmRlO6Ng2iYi26R9yAgSXv+3CUl
         uU3IGOJ5dS9M0r6xw2bfdGKlHBiMkBvCjCdiPCw0b/dxiQJ1iNSpRdE1uHCppX9G26LS
         d4nzljiy3BEySXXfRgbk+AN8yBvsuZ+U8ogQ6VOV8GPdi8q6YT04SCaeBU78B4XexHSX
         2LmtFT9NCTsjRSljo4uxVWRoIXUdYX8wIqB1fAAzudnfP1msltNX4uzqBgxMnke4k4uQ
         71YQ==
X-Gm-Message-State: APjAAAV8Lr6VMFiW+ut/r2lEDS4ZKtCAYQdUyCjAxgjYe4Q5MXPoIkdr
        XOeNYhCmw73z3NEBmsx5hEUR8YjB
X-Google-Smtp-Source: APXvYqy6esIWLqd6YGrcUqwUEdhN3tgkpcBxyHpfNCl0YSfjHN9sLi+f/mVsCIsFfgJXf9hpyqJdpg==
X-Received: by 2002:a63:5550:: with SMTP id f16mr57051763pgm.426.1563850683615;
        Mon, 22 Jul 2019 19:58:03 -0700 (PDT)
Received: from localhost ([108.161.26.224])
        by smtp.gmail.com with ESMTPSA id i9sm40096233pgo.46.2019.07.22.19.58.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 19:58:03 -0700 (PDT)
From:   Matt Turner <mattst88@gmail.com>
To:     git@vger.kernel.org
Cc:     David Oberhollenzer <david.oberhollenzer@sigma-star.at>,
        Matt Turner <mattst88@gmail.com>
Subject: [PATCH] archive: Store checksum correctly
Date:   Mon, 22 Jul 2019 19:57:36 -0700
Message-Id: <20190723025736.23036-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.22.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tar2sqfs (part of https://github.com/topics/tar2sqfs) rejects tarballs
made with git archive with the message

    invalid tar header checksum!

tar2sqfs recomputes the tarball's checksum to verify it. Its checksum
implementation agrees with GNU tar, which contains a comment that states

    Fill in the checksum field.  It's formatted differently from the
    other fields: it has [6] digits, a null, then a space ...

Correcting this allows tar2sqfs to correctly process the tarballs made
by git archive.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 archive-tar.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/archive-tar.c b/archive-tar.c
index 3e53aac1e6..f9a157bfd1 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -215,7 +215,9 @@ static void prepare_header(struct archiver_args *args,
 	memcpy(header->magic, "ustar", 6);
 	memcpy(header->version, "00", 2);
 
-	xsnprintf(header->chksum, sizeof(header->chksum), "%07o", ustar_header_chksum(header));
+	xsnprintf(header->chksum, sizeof(header->chksum), "%06o", ustar_header_chksum(header));
+	header->chksum[6] = '\0';
+	header->chksum[7] = ' ';
 }
 
 static void write_extended_header(struct archiver_args *args,
-- 
2.22.0.dirty

