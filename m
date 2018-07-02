Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFA571F516
	for <e@80x24.org>; Mon,  2 Jul 2018 00:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752898AbeGBAZ4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 20:25:56 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:34006 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752862AbeGBAZC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 20:25:02 -0400
Received: by mail-it0-f65.google.com with SMTP id d191-v6so597672ite.1
        for <git@vger.kernel.org>; Sun, 01 Jul 2018 17:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o/lwkXPcCadfSAGj2S9H3FPd5a6TPoADWOBjyzrCvwA=;
        b=AdQncqmAGJZSm6AAJm311lJP8IudVJfoMIyj2YZVlJ1iYyyBMM1gtn6HCPdeBcqSCj
         vLGnWW/iTsrBMTLM3KsgsK5GSG+BpRhi6WPsbb8JjDbpG4OoEbwKdf2gUbqOf+l6jBdE
         KxrwqtCZ+/HpixwqIDj8Z/M58YnSofMKlE+oVwNjf5K0ICvAxzzlDt4QPwc37EpCFvxR
         Qv3C6lEhbxAMilrIPB7DzqzOLt95EtSd5Aas72VOzxVB+FIaXCJDS1k753xGQs4/YzSJ
         9z1WRbUrqTbrQndq9m76q+NIggzA24m39gl2QeZW2s4Qbmcp0WuQCvHqF6bpQwTbHwAU
         fXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=o/lwkXPcCadfSAGj2S9H3FPd5a6TPoADWOBjyzrCvwA=;
        b=WEmw25zGaebsdMAkaKA/dcrkrnI4Yhe/zdG4Jm0kRcDhGfG52uqUeHPMslmjrJpYJ3
         XzMr6JxTC1Uy14Vyi5juZwhyQKJqrw7vLWfazDtOQuRhUpT9Qls/puPfSUq5ql73aUmv
         au/yJawt3cDU5gFKiOTZZmWToops5xeaxsdO9oqymecRfFZ4/R2No+9e2VaRM4zzBrvm
         mlGcI7FFb3L7YNVhwmworU2alP+No9hfuOdKk9KkljHBczcYgS4lhmeol1ozYVygi9rP
         pG5es0YG4Us6ZbYzGqq76GO+TJHq1asB35zPv+3kmpoO0vyfRfRUPp0G79FSaWOy1H4n
         bh8A==
X-Gm-Message-State: APt69E34S5FtJgw+jznKkXo2f0diDbIs3UezzmY7rMcclrrDfWSjKMFZ
        Sq2tWHe6bW0JZ6leQDwmbEAgGg==
X-Google-Smtp-Source: AAOMgpcWcGhLL0tRiQKnD7fvKldXGniQYkC20DoP/3ti61TKZ1c8PlUE90KkfN07PN5cE55yG0Uh1Q==
X-Received: by 2002:a24:308b:: with SMTP id q133-v6mr4607670itq.55.1530491101888;
        Sun, 01 Jul 2018 17:25:01 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id o143-v6sm3302562itb.42.2018.07.01.17.25.00
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 01 Jul 2018 17:25:01 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 13/25] t9001: fix broken "invoke hook" test
Date:   Sun,  1 Jul 2018 20:23:53 -0400
Message-Id: <20180702002405.3042-14-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180702002405.3042-1-sunshine@sunshineco.com>
References: <20180702002405.3042-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test has been dysfunctional since it was added by 6489660b4b
(send-email: support validate hook, 2017-05-12), however, the problem
went unnoticed due to a broken &&-chain late in the test.

The test wants to verify that a non-zero exit code from the
'sendemail-validate' hook causes git-send-email to abort with a
particular error message. A command which is expected to fail should be
run with 'test_must_fail', however, the test neglects to do so.

Fix this problem, as well as the broken &&-chain behind which the
problem hid.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t9001-send-email.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index e80eacbb1b..776769fe0d 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1966,11 +1966,11 @@ test_expect_success $PREREQ 'invoke hook' '
 
 		# Verify error message when a patch is rejected by the hook
 		sed -e "s/add master/x/" ../0001-add-master.patch >../another.patch &&
-		git send-email \
+		test_must_fail git send-email \
 			--from="Example <nobody@example.com>" \
 			--to=nobody@example.com \
 			--smtp-server="$(pwd)/../fake.sendmail" \
-			../another.patch 2>err
+			../another.patch 2>err &&
 		test_i18ngrep "rejected by sendemail-validate hook" err
 	)
 '
-- 
2.18.0.203.gfac676dfb9

