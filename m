Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09D511F461
	for <e@80x24.org>; Tue, 14 May 2019 18:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfENSEE (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 14:04:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55065 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfENSEE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 14:04:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id i3so29407wml.4
        for <git@vger.kernel.org>; Tue, 14 May 2019 11:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=gnBAG4q5GIs5YWzbla5uHaaJfSjhi0fheUTMEMyPzt4=;
        b=kop9yz4K92ifiFiEqlarS1lnYvrUS5/4mey6UIEE+7IILKPM5p76Xx2WhgZ5EFs5Q+
         yXUOYnKvJCyCmf6Uve10pguYUFSUdFrzbdCmamLdnlkEScj/7e9V8mOoqPdY1QHa4ch9
         Sr/FXSbORKOmOv0canGFlP75XZ4GKbdNW4rpDGRg+MxeMwKVYiKOyhcfZJh52IgCmg6c
         eJnNT4DyPcq08ANAc3ULj6Ga6bFstwwh+XxZqd6/bj5U4qVzx24JcuxOJ3MPmm9jM0yq
         +xkwY+MD7mAQSUGPI1lGwSd6+rGbHvOsbOs58kWmthUZYCS9JvrZv9H5PD8IBIqKKxA/
         c8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=gnBAG4q5GIs5YWzbla5uHaaJfSjhi0fheUTMEMyPzt4=;
        b=j8BKLubv2p3lkrAoqnO0Q69xpyQV9IRU5GDy/HQM/R4pTgdCkZ9IQoLAfZ8jcLbeXY
         sVi/u91KJV2lPEYeKJt2nrUnrTwpKycuz8XOE36qbPa4SVWERHlAtRfRNXLkng3u8K5q
         CKx6EC4uaeMKCE+yF+4QIwTME0GORCRCKQvJ7OiDofLm/3W7JymRV8Z/AdFDInIf9qnE
         O34wrbLnfPPEawXEfIROVFP43vgeR80yB9tozQ0cUaSWjnNzB78zLui0SAlRGFZyweO0
         uoQgN1H0yaEkc4YHtu8Mkzd8OZ/g9xgJA69dm40ZSzFOkcAc2m83A88+rmErFhfyhK0V
         GDUw==
X-Gm-Message-State: APjAAAWIgfbCShWODdS9OonXhjDWZxlubLtgoqHdIW768fRDog+ApFKm
        rbv9kkHON5qAVj5unQnkVRqA+Rk9
X-Google-Smtp-Source: APXvYqxgLr6kXWn4dBXZuOKwrB8Ad9B62JMJPoqdlohPbQ9A+ynHpECpA5Lh005lIjL3RwpWGeS0DQ==
X-Received: by 2002:a7b:c304:: with SMTP id k4mr21170906wmj.22.1557857041678;
        Tue, 14 May 2019 11:04:01 -0700 (PDT)
Received: from lindisfarne.localdomain (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id a4sm4528230wmf.45.2019.05.14.11.04.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 11:04:01 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 1/4] rebase: fix a memory leak
Date:   Tue, 14 May 2019 19:03:46 +0100
Message-Id: <20190514180349.17245-2-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514180349.17245-1-phillip.wood123@gmail.com>
References: <20190426103212.8097-1-phillip.wood123@gmail.com>
 <20190514180349.17245-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

buf was never freed.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 82bd50a1b4..90037c9c45 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -2168,6 +2168,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	ret = !!run_specific_rebase(&options, action);
 
 cleanup:
+	strbuf_release(&buf);
 	strbuf_release(&revisions);
 	free(options.head_name);
 	free(options.gpg_sign_opt);
-- 
2.21.0

