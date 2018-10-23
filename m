Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B37981F453
	for <e@80x24.org>; Tue, 23 Oct 2018 12:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbeJWU6z (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 16:58:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36959 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeJWU6z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 16:58:55 -0400
Received: by mail-pf1-f194.google.com with SMTP id j23-v6so603975pfi.4
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 05:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wl1rE3iXyknQs1zqov7zfPOXrUlLIyjRQBeDRKhlxx0=;
        b=eYHMzfxjJfWD8tp+EkKQddQ+lnIz57KALsfs3v/gMvBK4xPrUBBCbgfZss+Jm6uFQa
         109vwCeX84OjnX3dX96OUwUU2kWfmbAphFD1Zt9tKxESdN1223ORSgLo8xMfcyAL6IEe
         ZaMthLpAhitdJzhl/4g3brg4Im5rNVkUle4JCwlbshnLTphuZOwT/s0JIB7YEtqLqfj3
         XgEebx0JpG7hlIr0CzIo5O+6/0BL8NyXITSkjE9/UZSC8s9F04eVWrW8ch7Q5IgGq3Gy
         /T1pMxLKjH52Z78yAPUM/k34zh/O+2Nmb/yymZWpRQv0+Q/DtU8ZUBQJbtSjqTy2IK5u
         wRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wl1rE3iXyknQs1zqov7zfPOXrUlLIyjRQBeDRKhlxx0=;
        b=o3NlqsYY78Y+UNOC0fa/7mOpZ6b12r/zLNssr0j0MgkI0I16m1OIy14PCP4DbQrzVq
         KXfli6I+LJJ7jn+5R3ZwA3ZmqCnAVwKo/33X63SO/TXNwALTkxsq5jm7kmX4B7w0ymgp
         0e5gGTjDSzW1zQU0vjThrTyy0nk4OaxIYbGPPkQIjSYh23j7qWugqcf/JLlvLDEZ3nsc
         XdGsyHo/IL5HBTKhkpl/u10F8wglZUoAIfwhq9bDc0SLPsCItEraCh/fpGATaE5PoxrX
         NlpC/fPRhsvLQFtIK5d2SKhYZrBVrQJ1DFZyKiygifvfQZMVjWwZlUj/H8MRzwDu6k0D
         5lgg==
X-Gm-Message-State: ABuFfogllXXIhOwTKHfJnPDCnI7Ay0ju6EWqcWi9aAeW0wKh9GJg0aJ4
        0pQTxONBlAEOV5vMhBuamcY=
X-Google-Smtp-Source: ACcGV61utRgC773eBXc0XOKtaK5qYon3kacwK8I11N8iosfCkwYJtwhPoArKGnoymjku3+RBeoIx3A==
X-Received: by 2002:a62:8dcd:: with SMTP id p74-v6mr50930916pfk.217.1540298136607;
        Tue, 23 Oct 2018 05:35:36 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id u65-v6sm1779058pfb.144.2018.10.23.05.35.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Oct 2018 05:35:35 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2] compat: make sure git_mmap is not expected to write
Date:   Tue, 23 Oct 2018 05:35:19 -0700
Message-Id: <20181023123519.91317-1-carenas@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <nycvar.QRO.7.76.6.1810231212190.4546@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1810231212190.4546@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

in f48000fc ("Yank writing-back support from gitfakemmap.", 2005-10-08)
support for writting back changes was removed but the specific prot
flag that would be used was not checked for

Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
Changes in v2:
    
* reset-author to match signature
* cleanup commit message and add ACK

 compat/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/mmap.c b/compat/mmap.c
index 7f662fef7b..14d31010df 100644
--- a/compat/mmap.c
+++ b/compat/mmap.c
@@ -4,7 +4,7 @@ void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t of
 {
 	size_t n = 0;
 
-	if (start != NULL || !(flags & MAP_PRIVATE))
+	if (start != NULL || flags != MAP_PRIVATE || prot != PROT_READ)
 		die("Invalid usage of mmap when built with NO_MMAP");
 
 	start = xmalloc(length);
-- 
2.19.1

