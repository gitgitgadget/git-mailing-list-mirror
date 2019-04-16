Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 188D120248
	for <e@80x24.org>; Tue, 16 Apr 2019 09:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbfDPJey (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 05:34:54 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44405 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfDPJey (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 05:34:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id y13so10097519pfm.11
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 02:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=264gLtMqjr6EVMDrXmftVG+JmMG00L443ygr4yX9u3A=;
        b=JZV/QAPzP6BT0ilzvUawjIFZh9EdKX4MkcTsHegqcTzW2sUDKnRrVQUCuK2hInIMyX
         FD6I1XkgnPdwIine0yI7Rulj7ZnHJDvAAHHa8VGdr1EHdK1DHOA3VbLeAMDUUF8xojHh
         hZKJY2uaSmvsBhC9OG5BtJcPhJg2PGEUEm+3xUGbXfBlajfaBQrw7UHXQRaLSsQKQX/j
         s28ycmcx0E3U6Ub0XZCJ2187lycNanmLsu3omz6cJYd3dVkJdBesmwVCQmwJruaJQyVx
         IW/wfAzZcXnVw2yuNaIwjqazCVp9v1adpQvt6gb4lLmb63h6KclUbQL3e9CLE5FV0SQK
         8M2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=264gLtMqjr6EVMDrXmftVG+JmMG00L443ygr4yX9u3A=;
        b=aD4wGQLupnk9hg4bzCkSWEfEPgO58vzW2d10bnD/GnksMPdImsG303xYsRWaH4CSCw
         j/hQ64h5JdL5sNNMq+Q4U1iAnI76ownFgn4iGjPVio0s63+E1Xpuu2Oht/AxS5lrpKnf
         fbkHc0Rlnqrod8cBGrtx0Rsk39KIXe7A3GpZIaQWleJ4WNte2oyZPvwy9WXrD+HPzo+h
         JDIyxk4K2rtUuZwPafNBR4w9XN4Dsazsbn2g/WOGKY2y2gmx34ydylYEnigWNBkWm7/n
         zL4KB0LQdWya0O6rYyk+t+t+6/LjTAbiCFYPI0nAj/A5R/io2lYcK6BmVaBhU1TFZcWH
         hEmw==
X-Gm-Message-State: APjAAAW//nDvjgWL93d9yLvxg7VQPQaAQM3lWqCTqaJgxC3WTi8iyPdW
        6NU0i91dZGNuBR2yvIPGNWU=
X-Google-Smtp-Source: APXvYqzAMwWWgnwoWCsnMc7zEX/lTD90z9jwUxHYcLbWXrBsaOnx+AyqI8xgiZT05IkXXppxHJxnbw==
X-Received: by 2002:a62:6c6:: with SMTP id 189mr54078089pfg.36.1555407293937;
        Tue, 16 Apr 2019 02:34:53 -0700 (PDT)
Received: from ash ([116.106.33.3])
        by smtp.gmail.com with ESMTPSA id s5sm58433482pgv.8.2019.04.16.02.34.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 02:34:53 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 16 Apr 2019 16:34:49 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        stefanbeller@gmail.com, szeder.dev@gmail.com
Subject: [PATCH v4 04/34] refs.c: add refs_ref_exists()
Date:   Tue, 16 Apr 2019 16:33:11 +0700
Message-Id: <20190416093341.17079-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190416093341.17079-1-pclouds@gmail.com>
References: <20190406113453.5149-1-pclouds@gmail.com>
 <20190416093341.17079-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 142888a40a..b869f32d8b 100644
--- a/refs.c
+++ b/refs.c
@@ -241,9 +241,14 @@ int read_ref(const char *refname, struct object_id *oid)
 	return read_ref_full(refname, RESOLVE_REF_READING, oid, NULL);
 }
 
+static int refs_ref_exists(struct ref_store *refs, const char *refname)
+{
+	return !!refs_resolve_ref_unsafe(refs, refname, RESOLVE_REF_READING, NULL, NULL);
+}
+
 int ref_exists(const char *refname)
 {
-	return !!resolve_ref_unsafe(refname, RESOLVE_REF_READING, NULL, NULL);
+	return refs_ref_exists(get_main_ref_store(the_repository), refname);
 }
 
 static int match_ref_pattern(const char *refname,
-- 
2.21.0.682.g30d2204636

