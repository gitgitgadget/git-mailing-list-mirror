Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 921D31F461
	for <e@80x24.org>; Sat,  7 Sep 2019 11:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387993AbfIGLvE (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 07:51:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38707 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbfIGLvE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 07:51:04 -0400
Received: by mail-pf1-f195.google.com with SMTP id h195so6301662pfe.5
        for <git@vger.kernel.org>; Sat, 07 Sep 2019 04:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0OORSVW77GzviJH0HVbbzrmwnCbEJbSImYP5c3j/8lQ=;
        b=HpTPXhkLTeOn3fmh0NGJtoPegU/7TeFRVzrcdHJE3yeREN3QtAtx9qIHqn1oKiTdQy
         G3A4hJV4OrQycy6FYijdon9h0cqAPzCzoo5d6cnfbeehi5l2HIzjNkKdjrGn5sDxoKtI
         kTLDUKDaksGx6HIqWY/ZwNUFMbA1AKjUQEVrkpKG++meuJ62m4cUOpDzzzMoPW1I//2y
         EIN6wQUgEa3RkvkTfBDuz8i27mTB5wUAsqW7Scw7ykYNSwALI1cDVApQipTVjL2WZ5FY
         qfcACzjy0iebIzN5ZDWYVnIZNAADpj83G1nKbeiWRgxO7b/f8hR8V1fHUrqiCjlej/zK
         89Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0OORSVW77GzviJH0HVbbzrmwnCbEJbSImYP5c3j/8lQ=;
        b=egE5Mz2F+GaTU+mKeA/PsWZNXw7/F/FCCSQZpCO+UaY8cI+LudRwCvGOItdH8dITQE
         aUoJgFqXWcGD/bfwNKBWYRt72P1NaV5syieS0M6xlY4ArzbDoE87upww7xKhbYaPvdPO
         /cBZH78bDK3t3vNDHqV8mgq97Q1mXtekhCiT9HLKtnqy5Bzr75aJRVk2J1W5SGxpPt7+
         q9zheRe7iMOFG/jlWuR8xVPZOdE5BbZFZevCjys4LR7BM6jZ5sMfYUP1L5YVorvCQS8Q
         TwsnAk3CGuu4KBZmNcuH6Jj8ajdfvC1refaHuVW36AuMuARBrEsmuJEHI7vdLm4ogHBi
         fMjg==
X-Gm-Message-State: APjAAAWrsYLBXVICppkbTFmI/P2Aq3tPr85LKxRS8rgvg9clsCz4abwG
        R8icfLNM7eGnti4I3+ntK2I=
X-Google-Smtp-Source: APXvYqxjMwjp5QtkTxNXP7IbCSUlsmtgpWruKngVHAsMIyIzH3KpRVq0fEyHUiKoBztCaziC/V9xlQ==
X-Received: by 2002:a63:40a:: with SMTP id 10mr12477952pge.317.1567857063388;
        Sat, 07 Sep 2019 04:51:03 -0700 (PDT)
Received: from ar135.mshome.net ([103.37.200.225])
        by smtp.gmail.com with ESMTPSA id a11sm18134792pfg.94.2019.09.07.04.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 04:51:02 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
Subject: [PATCH v4 2/6] sequencer: allow callers of read_author_script() to ignore fields
Date:   Sat,  7 Sep 2019 17:20:30 +0530
Message-Id: <20190907115034.14933-3-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190907115034.14933-1-rohit.ashiwal265@gmail.com>
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20190907115034.14933-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current callers of the read_author_script() function read name,
email and date from the author script.  Allow callers to signal that
they are not interested in some among these three fields by passing
NULL.

Note that fields that are ignored still must exist and be formatted
correctly in the author script.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 sequencer.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e55550510a..adeff2561e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -824,9 +824,19 @@ int read_author_script(const char *path, char **name, char **email, char **date,
 		error(_("missing 'GIT_AUTHOR_DATE'"));
 	if (date_i < 0 || email_i < 0 || date_i < 0 || err)
 		goto finish;
-	*name = kv.items[name_i].util;
-	*email = kv.items[email_i].util;
-	*date = kv.items[date_i].util;
+
+	if (name)
+		*name = kv.items[name_i].util;
+	else
+		free(kv.items[name_i].util);
+	if (email)
+		*email = kv.items[email_i].util;
+	else
+		free(kv.items[email_i].util);
+	if (date)
+		*date = kv.items[date_i].util;
+	else
+		free(kv.items[date_i].util);
 	retval = 0;
 finish:
 	string_list_clear(&kv, !!retval);
-- 
2.21.0

