Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46AD51F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752141AbeBFAKq (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:10:46 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34382 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751914AbeBFAKo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:10:44 -0500
Received: by mail-pl0-f68.google.com with SMTP id q17so118547pll.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EWEudN6FthrOrq/TxP26a+RfIddU7wKMw5G7aGRqQ5U=;
        b=V/S0OlI5C1m7jfmHP0britqsVQdhzBrHCDHx20xjszEdiRGfacuZkU3xPMVfn8YplY
         s5wafAJV/enjiGpFTvrhgOO0JveycdDcvrgaKvJrqdKRHimnUr59Hf1OPfQdae61KfC0
         1ohVmJON5ax7OUMuz79KJDz4NbDV29MwzhfLHEyBfst+lGcYSX8XrWDQdoXjTziuhFcg
         O48WPwSsZzr4O3Ayp0v6lfZR1kY1DO0MPAUmEkWgthK3wmpqPJICyKkDoJu0z7QMqh6+
         koztsfa30SegEDzOw2r+264j1R6cVFt4GVqWPbbv0kkgeT/ZA4YnDjQaEDHtpf/HXffD
         PvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EWEudN6FthrOrq/TxP26a+RfIddU7wKMw5G7aGRqQ5U=;
        b=OEtQQh7GTjAkhwXyS7MsnnJYizy4Vf30+DIwpUl/y6xmuyr6fbPFWJUo/eCbliQXbW
         3crOMLmbEcSQTEZvw2D6oB6VPl9kPvd6PTbNjgh67ihhPC9KRcgu1JG6XiHlP7Sn41/W
         hi4wmRTnO+j1nxsUe3oOZAvsvZti51KlktPt0QGmfpenkUUIqoxHzvZtDdL7vB7f/p5o
         zIW/7z8NeUoDFP/hQ1wPZ8ju3rIec9tFBkn1SwWRBfxonNJJHOlLxUqaT3/VsMYXE+H0
         lhmF1Gwyx8TPi//dbHq0x4OjrBnLA3LElvlbKJ5DBawCIKIE9OwMi01xad6nC5WtV4x5
         Cb2Q==
X-Gm-Message-State: APf1xPCMfdiztx1f1RAMOJqcSddHxkWIPmZkf9WgnWogutB72EklXy3F
        kDuNaot9SSQSRnjx5cbMvQ40eB1aWZU=
X-Google-Smtp-Source: AH8x227eNzfqCADYIRfjMB7P5laUgdCyFpTPSzBaifHcjIVWALkF4nHw2hqaEMCidq/fut1wJtl5OA==
X-Received: by 2002:a17:902:9897:: with SMTP id s23-v6mr524655plp.238.1517875843592;
        Mon, 05 Feb 2018 16:10:43 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id w10sm13630835pgc.69.2018.02.05.16.10.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:10:42 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 077/194] replace_object: allow register_replace_ref to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 15:55:38 -0800
Message-Id: <20180205235735.216710-57-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 replace-object.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/replace-object.c b/replace-object.c
index a6a34217d8..96d339729a 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -68,8 +68,7 @@ static int register_replace_ref(const char *refname,
 	hashcpy(repl_obj->replacement, oid->hash);
 
 	/* Register new object */
-	(void)r;
-	if (register_replace_object(the_repository, repl_obj, 1))
+	if (register_replace_object(r, repl_obj, 1))
 		die("duplicate replace ref: %s", refname);
 
 	return 0;
-- 
2.15.1.433.g936d1b9894.dirty

