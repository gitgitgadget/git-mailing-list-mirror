Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C600C433E1
	for <git@archiver.kernel.org>; Tue, 19 May 2020 10:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9C1D20758
	for <git@archiver.kernel.org>; Tue, 19 May 2020 10:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUHpyyUO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbgESKyS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 06:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbgESKyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 06:54:16 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554EAC061A0C
        for <git@vger.kernel.org>; Tue, 19 May 2020 03:54:16 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id d7so10659369qtn.11
        for <git@vger.kernel.org>; Tue, 19 May 2020 03:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kf97xiEpEC7PleCi4uJLbelhql6zZMVB0zEdFr9uAHA=;
        b=cUHpyyUOAY0/I25g530+eRw8q0T9GZeTOXhXLsRMjveNVbU1rFscQWjVcZOetE7qX5
         ONrbFX77CPSnDGgdWFzHZ3TxaWeFkK2PgO2OXFupGP8HrPt8624bnlSYo8G00T5UoVDZ
         jK+/yP10m4I1hXV1a6uesQ24CTfn6tV1pROuPtVIqqOgqvlTC/1FRrnz9y8rdER+oHQo
         NsV7lNh52/nrx12FdBI6qQAivrLEPwHucAlLtI3Vs8euBotW/JHuYagtTtBBdYoYv3OZ
         gHd9AQQuUH57Rb6LfoshqQkXCmxJX29yNhV3qadu5ebuVDQb7XTrIvz6tJZULkkJXk2X
         YtDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kf97xiEpEC7PleCi4uJLbelhql6zZMVB0zEdFr9uAHA=;
        b=OFNphywV7CnaLLkpLKI4b2RyiW0waO8kKnqjY1cKQEJrF435vLFNHNCZ6+mLpAqQtJ
         Z7myHcUvEiphuFOOHodkdV1aBwsQF3Gw6UyY/1mMkk15sx9v3aYTAguuhOpbQiknW2Oa
         kU8b30Pvthn2nBJUM1IhLif9Z9viAtqlOorVRCuOfD2MWtiEdQ2tIJRaR+n7/cpb57JW
         j0o3e9sHEvHvPiMKPoGykGC5MhgTcc8H8EEY9oD3JmwjD2MldxJScvpL1CzXhsBRnqRc
         HbRwZH2NKMOClBYtk5H+cXtlGnQ8b+PfeBCya63HHEkku4BBUdvwAhFdK+Z67luI7N7y
         8UNQ==
X-Gm-Message-State: AOAM530gsIMoodp4uZaKOIKHAaO3wlqHXMCaxMnpjhg4F3aVwE2v0fU5
        ZVUa6sEIO7zsTS5Q/y1+Ql+M1oQw
X-Google-Smtp-Source: ABdhPJxyt4ATIOzvt2H6R1J9+p/OFki/kFYyqmSf1F2oV3CneMLTGHtuvyUD6A8Z0YFC7jVg8Izgog==
X-Received: by 2002:aed:3f8f:: with SMTP id s15mr5942059qth.82.1589885655405;
        Tue, 19 May 2020 03:54:15 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id c63sm10177775qkf.131.2020.05.19.03.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 03:54:14 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/7] pkt-line: extern packet_length()
Date:   Tue, 19 May 2020 06:53:57 -0400
Message-Id: <36885943b239807eda49e231d8a45e1991f7288e.1589885479.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.2.706.g87896c9627
In-Reply-To: <cover.1589885479.git.liu.denton@gmail.com>
References: <cover.1589816718.git.liu.denton@gmail.com> <cover.1589885479.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future commit, we will be manually processing packets and we will
need to access the length header. In order to simplify this, extern
packet_length() so that the logic can be reused.

Change the function parameter from `const char *linelen` to
`const char lenbuf_hex[4]`. Even though these two types behave
identically as function parameters, use the array notation to
semantically indicate exactly what this function is expecting as an
argument. Also, rename it from linelen to lenbuf_hex as the former
sounds like it should be an integral type which is misleading.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 pkt-line.c | 6 +++---
 pkt-line.h | 9 +++++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index a0e87b1e81..3beab1dc6b 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -306,10 +306,10 @@ static int get_packet_data(int fd, char **src_buf, size_t *src_size,
 	return ret;
 }
 
-static int packet_length(const char *linelen)
+int packet_length(const char lenbuf_hex[4])
 {
-	int val = hex2chr(linelen);
-	return (val < 0) ? val : (val << 8) | hex2chr(linelen + 2);
+	int val = hex2chr(lenbuf_hex);
+	return (val < 0) ? val : (val << 8) | hex2chr(lenbuf_hex + 2);
 }
 
 enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
diff --git a/pkt-line.h b/pkt-line.h
index fef3a0d792..0d92c5e17f 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -74,6 +74,15 @@ int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
 int packet_read(int fd, char **src_buffer, size_t *src_len, char
 		*buffer, unsigned size, int options);
 
+/*
+ * Convert a four hex digit packet line length header into its numeric
+ * representation.
+ *
+ * If linelen contains non-hex characters, return -1. Otherwise, return the
+ * numeric value of the length header.
+ */
+int packet_length(const char lenbuf_hex[4]);
+
 /*
  * Read a packetized line into a buffer like the 'packet_read()' function but
  * returns an 'enum packet_read_status' which indicates the status of the read.
-- 
2.26.2.706.g87896c9627

