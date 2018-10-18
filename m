Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 969AA1F453
	for <e@80x24.org>; Thu, 18 Oct 2018 18:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeJSCsv (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 22:48:51 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:36977 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbeJSCsv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 22:48:51 -0400
Received: by mail-it1-f196.google.com with SMTP id e74-v6so1629721ita.2
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 11:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/1eserc5Sx6OiCpfITyAAXM+Ez4Ut3Ws/R7kEIw1WTs=;
        b=rGDcuBDUzvznACWZScF32wYwe997APo167aPJrU65KDHTzJchUQkHfvIRVFg4bCmxR
         ToYIs9YggXsAS3VeWpS2o49NNAODVUsqJuSngoVQr7EWa6Ujv3+I8ZH2WmE5GxagmOSm
         WT3EBgt+1E4kLhBsh9EnBMINv5kn12wPdwNEeIpKeFEh3W1T86YDZxn7k+H4205AAKVc
         IkX9SHOR3c7+rCjQ4Ai1FCNsz6Yfh+Fy4e+zNnAbd9j6oo7tpXKtwG+3uA5suGTJcwrM
         WGyE0fvrKOkcTHYadx2Fbxr8xe3biIfIGKtfiCRwilskb2CGyuLOvtod/vK2IGt17yhD
         WTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/1eserc5Sx6OiCpfITyAAXM+Ez4Ut3Ws/R7kEIw1WTs=;
        b=T+5/QEGZ9vBJL3dvBpEzWX5eYyLv9OSOsUzCu2FnSDLBpGdx3T7XHV3P9eTSW6zJzf
         7SfYxNp9vOrP08ZceOOftagsWviXlJArkXiaOXl8cJ6UFbzdB2gpBEe0waVFKvL3BNYY
         qXtxspp3gE1doxBtoDuhMSpbZto5LSNPLLzH7Wru+ryDM+2gWMsmpv9Wumlvq4fSEoVx
         4ASIb450hk1GzIbMACY8ZRchVXrNu6Zln/1BT9SAilMdG3MZgAXG8ODqbdpE4QKa7T/h
         8KT6UIDpvd5KnU0p/+36wBq1N18qXGHawEnlpqvoDuutB0o9rnNuPunMfaa3guI+6HTV
         Kp1Q==
X-Gm-Message-State: ABuFfoiOQKK2eMDLuVKM/ZT6wAcUsw7BPIAAEwiDxQVPlQLzew/tsduX
        dAo0y3KiDjD5vMCXcFCf2zD4nbm9
X-Google-Smtp-Source: ACcGV63ChoaO6rq+2sXvMKp7ZFKibU4WQBk38qMHKqs+a4QRmxJH9pyXToJvjoBZ3xz/aaWKUEtzog==
X-Received: by 2002:a24:89d6:: with SMTP id s205-v6mr1090912itd.51.1539888391661;
        Thu, 18 Oct 2018 11:46:31 -0700 (PDT)
Received: from Carlos-MBP-2.sf.stch.co (50-207-95-178-static.hfc.comcastbusiness.net. [50.207.95.178])
        by smtp.gmail.com with ESMTPSA id e76-v6sm6903271iof.31.2018.10.18.11.46.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 11:46:31 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] unpack-trees: avoid dead store for struct progress
Date:   Thu, 18 Oct 2018 11:46:04 -0700
Message-Id: <20181018184604.22840-1-carenas@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

it is unconditionally initialized a few lines below

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 unpack-trees.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index f25089b878..88dc9a615e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -340,7 +340,7 @@ static int check_updates(struct unpack_trees_options *o)
 {
 	unsigned cnt = 0;
 	int errs = 0;
-	struct progress *progress = NULL;
+	struct progress *progress;
 	struct index_state *index = &o->result;
 	struct checkout state = CHECKOUT_INIT;
 	int i;
-- 
2.19.1

