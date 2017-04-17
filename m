Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFCE6209FC
	for <e@80x24.org>; Mon, 17 Apr 2017 22:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756782AbdDQWIi (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 18:08:38 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33183 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754060AbdDQWIc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 18:08:32 -0400
Received: by mail-pf0-f175.google.com with SMTP id s16so71341486pfs.0
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 15:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GByRXP7CBhvXT9I59jWtqNNr04lfykAx+Us0S0Xtm3U=;
        b=RDvMsF/3MfuQDF3C0tj/YtKQS0NbwMd+H13WZ0hlcdxgJ4hIzuaFPYR7v6QmJlZCb/
         TWk6iMp6rHjeI2qz2hXmWo39HI7cLRto69bEg0KFT0eIxeXFaDmnl8S5griKjzVITqi9
         5aCU+PlH19VUnykfonzSdua4pPUzP9cPEEqbrHhJUy3ZQ9AotjGxhtFFlSbJuMlcrJVB
         DFMY76zpfYtzaN8NWdcvp96lWvSwivMzL0kRf4NHytr5N1d6858aHhFJhwbZGXHJm7Ak
         jsL9EohE2jZRYmunvFAWdIqq8RhMHld+tm/sryL5UZA9+jyIz2VhYdBvH8y6Opg7vChj
         5cfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GByRXP7CBhvXT9I59jWtqNNr04lfykAx+Us0S0Xtm3U=;
        b=PSAvKZKtM3H/WKD2i7P9/RD7QnwOctNncM+xnz/o1aD7TDcA/D7JWHihZuEo/KjPuE
         qO+VD32zvtFCnllVEWf+kUnkngct/+zF1wV+pwPuvmxm2EqeR+aVTw23Y1oEwpDCxXRs
         RI66xjp0/70KlF/gbSuFeVLrEe9gsljFLnHc3sZKKrl29NKCcPHd6fazDPXclIflQxZK
         dh19+poX/OPS2/yPuxXkR/1ntGfVLVlCyg+eguPbWaDKtejtj8OBpSOA2As/1Dp4ahMJ
         3fLrpHcV1Kdlzg3PdH2ypyyQnd5W/PLo9aC+IDnji2Cc38crMiGQxeGVOAHXrjZRL1J2
         d9PQ==
X-Gm-Message-State: AN3rC/74YJ1XejCKW6UIGOZp/XdtllEOxABi4wvPLXAaEAMmaqIhzX7c
        +QeDB74CYqdImHJj
X-Received: by 10.84.195.129 with SMTP id j1mr18972858pld.88.1492466911469;
        Mon, 17 Apr 2017 15:08:31 -0700 (PDT)
Received: from nalthis.roam.corp.google.com.com ([172.19.163.186])
        by smtp.gmail.com with ESMTPSA id v12sm12644915pgn.5.2017.04.17.15.08.30
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 17 Apr 2017 15:08:30 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, jrnieder@gmail.com,
        e@80x24.org
Subject: [PATCH v4 02/10] t0061: run_command executes scripts without a #! line
Date:   Mon, 17 Apr 2017 15:08:10 -0700
Message-Id: <20170417220818.44917-3-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226-goog
In-Reply-To: <20170417220818.44917-1-bmwill@google.com>
References: <20170414165902.174167-1-bmwill@google.com>
 <20170417220818.44917-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test to 't0061-run-command.sh' to ensure that run_command can
continue to execute scripts which don't include a '#!' line.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 t/t0061-run-command.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 12228b4aa..1a7490e29 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -26,6 +26,17 @@ test_expect_success 'run_command can run a command' '
 	test_cmp empty err
 '
 
+test_expect_success 'run_command can run a script without a #! line' '
+	cat >hello <<-\EOF &&
+	cat hello-script
+	EOF
+	chmod +x hello &&
+	test-run-command run-command ./hello >actual 2>err &&
+
+	test_cmp hello-script actual &&
+	test_cmp empty err
+'
+
 test_expect_success POSIXPERM 'run_command reports EACCES' '
 	cat hello-script >hello.sh &&
 	chmod -x hello.sh &&
-- 
2.12.2.762.g0e3151a226-goog

