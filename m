Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE13C1F424
	for <e@80x24.org>; Mon, 22 Jan 2018 11:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751110AbeAVLEw (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 06:04:52 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40261 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751137AbeAVLEt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 06:04:49 -0500
Received: by mail-wm0-f68.google.com with SMTP id v123so15954602wmd.5
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 03:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=tpJwMZYL+oxH8z9scd8jSR0RztMPKX+ty7luNp1tKbg=;
        b=e90GsIJhOtOK4gbNrwVwxLeqQ0GnW9Hks1omIYuFTs/9Cdi+clYFUM2soC5FpmdYqU
         QsHZLRtg8pu1ldG7i503jLPd+4SAhHa5bSTPkPqAu1GCfJYqZK11tlUFNSECx/Fx0sdV
         Bh64+5/g0R69XbBn06qpl6An8vea0p+exrbe++wGD71zRZXZZ9ekc/zCiZk5P4Y8LKJb
         EuEw+H5TXAUwjVMGbY0zi5Tc01BQKPpdnNpyLDUmjCs5+CNN6fIJvIHwoZLo6KFuXtPg
         fJHdB5qx0PTbhyxuaQYKy8+ezKsQdnsWTk4z4WE4yRqB0T56Vez1wrSJt0BoIjbxNiE+
         fgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=tpJwMZYL+oxH8z9scd8jSR0RztMPKX+ty7luNp1tKbg=;
        b=DUfpKX6vfeolAtvPqKWQCbNYZn9Y4qviOh/1cIIlEQnHSMPXh5onj1f9s85fSAtNNk
         AGIfcTna9EETA337IgTEeHV+bMCa/DCLoxgkSen6PLomv3uA97YACTfBjeWLCBGxIin5
         hiTf8i+ZJlGgC+2qbUoRZp00/sTPgATvCBzc4kwn/HnfivXLHb8vSkMCZ2RygQF6iOZs
         lB0j7GBl3G02Zo05A0/Xo/wHHHs19qu9DtzpH+25qbazcrS/PVqdHYuvOds8eXHYQgJd
         nSeEe+dGnyfUhRoUEt8z9DbwJaA9Iqy9V6fE5pPnYKHypyhh86SeBUuezP6dylzVx1B9
         J3pA==
X-Gm-Message-State: AKwxytcJaeo4NdZZ4OLT9PS+dM2xo0Ojnv1OCKbyM5BLoVV7HX8hYy3F
        JMAkf7qHK8aLP7tgigp9oLLPLIxD
X-Google-Smtp-Source: AH8x2273f2NkGcT4m5JAim8FCBVA6E845IsCUvvyIGNGiaR7eZzsoIcowuW+Gz5llRFaAhVowghvvQ==
X-Received: by 10.80.244.23 with SMTP id r23mr12484367edm.2.1516619088090;
        Mon, 22 Jan 2018 03:04:48 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id e12sm10833591edm.42.2018.01.22.03.04.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jan 2018 03:04:47 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        sandals@crustytoothpaste.ath.cx,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2 06/14] cache: clear whole hash buffer with oidclr
Date:   Mon, 22 Jan 2018 12:04:29 +0100
Message-Id: <a1c53b148ccf8587ca61dda5be88fc54838a89b3.1516617960.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1516617960.git.patryk.obara@gmail.com>
References: <cover.1516282880.git.patryk.obara@gmail.com>
 <cover.1516617960.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1516617960.git.patryk.obara@gmail.com>
References: <cover.1516617960.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As long as GIT_SHA1_RAWSZ is equal to GIT_MAX_RAWSZ there's no problem,
but when new hashing algorithm will be in place this memset will clear
only 20-byte prefix of hash buffer.

Alternatively, hashclr implementation could be adjusted, but this
function is almost removed from codebase already.  Separate
implementation of oidclr prevents potential buffer overrun in case
someone incorrectly used hashclr on object_id in future.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 cache.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index 08f2b81e1b..d5d78d6a51 100644
--- a/cache.h
+++ b/cache.h
@@ -1029,7 +1029,7 @@ static inline void hashclr(unsigned char *hash)
 
 static inline void oidclr(struct object_id *oid)
 {
-	hashclr(oid->hash);
+	memset(oid->hash, 0, GIT_MAX_RAWSZ);
 }
 
 
-- 
2.14.3

