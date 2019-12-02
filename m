Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F076C43141
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 08:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049B62231B
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 08:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzHgFeJC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfLBInQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 03:43:16 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35225 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfLBInP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 03:43:15 -0500
Received: by mail-wr1-f65.google.com with SMTP id g17so11027316wro.2
        for <git@vger.kernel.org>; Mon, 02 Dec 2019 00:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=L9XVR8VOsB3bYrZtKENmQ4sNcY2R7OGHnnkJvc2N+cM=;
        b=gzHgFeJCYsueQ5KZxS/dbIdKL+tmvom614LeEEyZn+7RxO13OBpetGu6Qh2ovq6QX4
         9fiT5bBH7zbFfTvjvBFvdGYY9T6B19CA9UnvRf3G8FWCFWfDfcj1HKBOOEhKsHBqC+Ig
         gebG4hqJhbvmcEsqKZjXybvw7hHHxxUqnZglPLlDXqlKkoodF1JsUY9MJsW70qgyEAZ8
         8OORG0srHe6paXm/pHXQk8YBICXLJf2Rg2Kj6tKDHr6UKX1uLDn/3mtwMWOjhvZ15kpz
         1qMc+A8VHfCsmp4+f8OfTDIDxAmjZzVAV6hrmPlPGuUyPDrY4K6+poWyZKvUGhsSLTcN
         UBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=L9XVR8VOsB3bYrZtKENmQ4sNcY2R7OGHnnkJvc2N+cM=;
        b=JANr8OQG3a+bKRrO4/04cXw2oioVgU/ZC+mv6OXXP6QZ465vn7ztOGctb+uuYr2I2y
         yAos8EyEGharaRTTnxTYXM487UeUMHtjVXybX36+aIxQdIGiVJCKmPLFlo5YTOoKOU74
         iKF4/5ggO4CjW+r1gKDNiZrAw/ojhh3dQRhGn7ovxbUJb+8iKzIn9CxVloJYPSf2VSxN
         VpLsryaou6Br+dhyuHIsKaXO8sd2EteDkSJGD7sCdp5YvIWN+G4BmXov0B1SIAug+e/q
         w3X9Na5N++A+yUzxeGPu6el7GFOPL/IwM7/GsYJjHL0qKPfU/Wphzzoa6WeVrIiG2Ygx
         e9WA==
X-Gm-Message-State: APjAAAVGjfzUEeqFc/U7MX7Jxmmudw4mROgQlR3HU1nGSYQdm5rA6vhZ
        RmcIEofYMvE1dukYtwLmmvqf12vP
X-Google-Smtp-Source: APXvYqw9ByMUdXa2Tri08ynjj+kpN5cprM1M82DifEibWgttQUWbzZCMPbGXx2onP14dj+V1b9vq/Q==
X-Received: by 2002:adf:fc0c:: with SMTP id i12mr7902664wrr.74.1575276193632;
        Mon, 02 Dec 2019 00:43:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a186sm11886677wmd.41.2019.12.02.00.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2019 00:43:13 -0800 (PST)
Message-Id: <df82efe896aea1fd5ff597b3fad772aef0957d2e.1575276191.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.481.git.1575276191.gitgitgadget@gmail.com>
References: <pull.481.git.1575276191.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Dec 2019 08:43:11 +0000
Subject: [PATCH 1/1] pkt-line: fix a typo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This typo was introduced in 2153d478b74 (pkt-line: introduce
packet_read_with_status, 2018-03-14).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 pkt-line.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pkt-line.h b/pkt-line.h
index 5c62015db4..fef3a0d792 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -77,7 +77,7 @@ int packet_read(int fd, char **src_buffer, size_t *src_len, char
 /*
  * Read a packetized line into a buffer like the 'packet_read()' function but
  * returns an 'enum packet_read_status' which indicates the status of the read.
- * The number of bytes read will be assigined to *pktlen if the status of the
+ * The number of bytes read will be assigned to *pktlen if the status of the
  * read was 'PACKET_READ_NORMAL'.
  */
 enum packet_read_status {
-- 
gitgitgadget
