Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E6AB207B3
	for <e@80x24.org>; Fri,  5 May 2017 18:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755414AbdEESoN (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 14:44:13 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34606 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755154AbdEESoH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 14:44:07 -0400
Received: by mail-qt0-f194.google.com with SMTP id l39so1943950qtb.1
        for <git@vger.kernel.org>; Fri, 05 May 2017 11:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JHzHj6bEWQYvdKV70oD1kcM/tCp9JCBAywFTJyO1sms=;
        b=m6WazJrdvIHW3lTwH9I4Ffxn1PCG+IokUcXygq7rg8jD+5ghVjpfWW1TJVAtzfbQ+y
         5Vac/qo5xVGKuWmxNU5AhB2gvwxl7msVdskztP1Rlhd6z+cGkn+As3ftEChgXq9Bf10d
         56MG5QI5aQ6j+WoaWQczvqazMvslORlWMRKni5dD1wq+eCIFjQTTm+w1tg3VeEKuNtjq
         invgKPoLc5aB81fG+WLqJzssv7KB6a/4+IDPKeicakMtgCC/SNAcsQPB2RVJgqq0Z8eP
         bzAlsUFPhOdSHJ77PLDYM/aV4eCzVDHDT0s5/JiwfDwchI3nkefXI9xJHaNDGatjdxvs
         N3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JHzHj6bEWQYvdKV70oD1kcM/tCp9JCBAywFTJyO1sms=;
        b=k+2GHAg/I7IF9y62XrnoSHlP+kHExuw0+QJpC1kM/mAAEaNcqF9g9m9SuBKEnADIxn
         r8IEnJ8CjcALkT+Z3QVR2+zM1XvirbbbPMo94vBRhrVxKWpQZPPymDI2tfHDzzeDWye4
         hxTUrdAsnHQ5ns0VTCpJmlMtIG17kUOEEypfYjdG/IbEvElJ+4QM0wALX6wNnEdGTuSw
         8HnnFU8e7Z6gmFWooDJ3n2MEQnt23YtbHaoSyGvUNqAXukYsvyHhovuFy8vQkjbrHYrS
         +gbEU0Q6t47sGmhqydbeRj81qaKkLAZCxAGAbeCO0/7d9fd+q3nS7bxWPqHBV9zAS/Ut
         1ScA==
X-Gm-Message-State: AODbwcC42URku9ccoD7bjrthOodXrvqwFuyN8RZNax+nw5NBqy5RKTPO
        99gX/s6cQrvm2exh
X-Received: by 10.237.42.5 with SMTP id c5mr1719488qtd.284.1494009846836;
        Fri, 05 May 2017 11:44:06 -0700 (PDT)
Received: from localhost.localdomain (gwmind.semfio.usp.br. [143.107.127.12])
        by smtp.gmail.com with ESMTPSA id p184sm3733369qkb.17.2017.05.05.11.44.03
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 05 May 2017 11:44:05 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de,
        Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH 3/3] add--interactive: use add-interactive--helper for status_cmd
Date:   Fri,  5 May 2017 15:43:40 -0300
Message-Id: <1494009820-2090-4-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1494009820-2090-1-git-send-email-bnmvco@gmail.com>
References: <1494009820-2090-1-git-send-email-bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call the newly introduced git-add-interactive--helper builtin on
status_cmd() instead of relying on git-add--interactive's Perl
functions to build print the numstat.

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
---
 git-add--interactive.perl | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 709a5f6..8617462 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -632,9 +632,7 @@ EOF
 }
 
 sub status_cmd {
-	list_and_choose({ LIST_ONLY => 1, HEADER => $status_head },
-			list_modified());
-	print "\n";
+	system(qw(git add-interactive--helper --status));
 }
 
 sub say_n_paths {
-- 
2.7.4 (Apple Git-66)

