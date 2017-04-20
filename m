Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4AC51FA26
	for <e@80x24.org>; Thu, 20 Apr 2017 16:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971325AbdDTQw7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 12:52:59 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36037 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968663AbdDTQw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 12:52:57 -0400
Received: by mail-wm0-f47.google.com with SMTP id o81so108540579wmb.1
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 09:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BYeN1x0pm0ZNU44DLr7vnY7iWzX+XHdzxAyPJZnPkc4=;
        b=USXqfXMXOJ7PtfuNXNuPWSJnbbYT30FTR0OHgBUvnP2ZGsD9Yk4/6+6V+5ysBkye6a
         oOl8bwjjLgwRW7iDtF5z2TkEPNg9HUwOI4ztyrk1RWPJ8VHm7JWvSRpx/87e29SYd0Lx
         dZv8yqvaHt3z2aUrNNX1HhO84d/P49mehfRdpC25MMbTRCFLNiC7/VKhp6WFPaQlciLX
         jPguWXKJwhrLxyux4ZjPPFL61OL7Za7wO9Q69+6YjEaZaTcHfByND+1B6Qgaue6zxiO6
         9ryF4mg1vASyMf2DcDFxCLyuXTqUJ/6VYOjVBkviVm0KJkfWXkjm7u6/aFJqKvGHip59
         U/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BYeN1x0pm0ZNU44DLr7vnY7iWzX+XHdzxAyPJZnPkc4=;
        b=Z4SOom7ISnPrgysL9MhnoDeYkFrwmLwbcaDbbAGbjHMMHGc5Cjq4IP0vShEiN4PI8H
         wW4YXTothM1xyjk/5TAJQdJQSLJBLMAglNS6CmgIrM9tB2iTZ+b73FobSnqwqilALA3T
         JEa7PcEmBuBzfQGyjryy1009fYHNtPhPbMnNJ0OKVd/oGG5A0Y0MhbsJFpTi9FR7ZFT5
         /ffwy8n+XzzjvKQktyRuTuG6c3/kquYJDA0jwefPG9ko5S/epcJkwOkZHTbC/6JnxgDa
         Z3xz/QrEFEGDEnNJ/O5DOlVbTHmjEjwByTvTCR2lshENcT48TwPjdge/pZYPvX4eR9ub
         prtQ==
X-Gm-Message-State: AN3rC/5Kh7z0Ml5E1O1TUigmT5ZhfXSxqZueVJGY5Ftj9MQmlceuqEXv
        bwwk5d/p1HEdCA==
X-Received: by 10.28.17.147 with SMTP id 141mr4197647wmr.4.1492707176073;
        Thu, 20 Apr 2017 09:52:56 -0700 (PDT)
Received: from localhost.localdomain (x590e4775.dyn.telefonica.de. [89.14.71.117])
        by smtp.gmail.com with ESMTPSA id 134sm24177280wmj.6.2017.04.20.09.52.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Apr 2017 09:52:55 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, Johannes Sixt <j6t@kdbg.org>,
        David Turner <dturner@twosigma.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] test-lib: abort when can't remove trash directory
Date:   Thu, 20 Apr 2017 18:52:30 +0200
Message-Id: <20170420165230.5951-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.12.2.613.g9c5b79913
In-Reply-To: <CAM0VKjm1m4v9vTpwFEejBuD3NuGm+kAdEV-_rzCXCz2G4m5NGw@mail.gmail.com>
References: <CAM0VKjm1m4v9vTpwFEejBuD3NuGm+kAdEV-_rzCXCz2G4m5NGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We had two similar bugs in the tests sporadically triggering error
messages during the removal of the trash directory, see commits
bb05510e5 (t5510: run auto-gc in the foreground, 2016-05-01) and
ef09036cf (t6500: wait for detached auto gc at the end of the test
script, 2017-04-13).  The test script succeeded nonetheless, because
these errors are ignored during housekeeping in 'test_done'.

However, such an error is a sign that something is fishy in the test
script.  Print an error message and abort the test script when the
trash directory can't be removed successfully or is already removed,
because that's unexpected and we woud prefer somebody notice and
figure out why.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

Note, that the commit message references ef09036cf (t6500: wait for
detached auto gc at the end of the test script, 2017-04-13), which
is still only in 'pu'.

 t/test-lib.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 13b569682..e9e6f677d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -761,9 +761,12 @@ test_done () {
 			say "1..$test_count$skip_all"
 		fi
 
-		test -d "$remove_trash" &&
+		test -d "$remove_trash" ||
+		error "Tests passed but trash directory already removed before test cleanup; aborting"
+
 		cd "$(dirname "$remove_trash")" &&
-		rm -rf "$(basename "$remove_trash")"
+		rm -rf "$(basename "$remove_trash")" ||
+		error "Tests passed but test cleanup failed; aborting"
 
 		test_at_end_hook_
 
-- 
2.12.2.613.g9c5b79913

