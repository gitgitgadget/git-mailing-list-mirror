Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DC8E20281
	for <e@80x24.org>; Tue, 26 Sep 2017 18:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965830AbdIZSyS (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 14:54:18 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:53176 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965309AbdIZSyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 14:54:16 -0400
Received: by mail-pg0-f43.google.com with SMTP id i195so6405201pgd.9
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 11:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mZ2FMo6R2+zwxddGqrVvfOMVOcp/nV0R1QWPM6dVmC8=;
        b=K7yngeJ1hsJPInBMKi/jdHE/Fm/e5dyBw9rlB4NE/xxfRUirdvmO4mEt12SN9PjqPw
         3r0g8lEF5Y3ZjqXK9oJGiOF67/Zg7m2RyluNeBNgUdo2gghALUp2Sq9rd4HMDhPyt1jo
         HgAPk+ourRX1gQAMjAaX2IXG6XuuR3fk0OXtdqwF7Szdo4WQaSE+BdcGxSWE6Ua1ulsc
         tjUhwZiL9RRLA7ZVz2VDG3RNibzYOSdDNTk+sewOkDUIHL/NqTM1AbCIhmys01rS3vB/
         MPG8dAyfryHXg7k3WNtdG2Htnl80h1dTbswvMq45keeCrxP2fCcalS5XzCekNdb1lSJY
         Krbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mZ2FMo6R2+zwxddGqrVvfOMVOcp/nV0R1QWPM6dVmC8=;
        b=tpl8GhntOfRyiUeRJ4vCJhftAxRGbrYtBpC0WO+U+imwIKzWMD8wvRangZd9J7BPgp
         N+6OEQ+AuiT1cYCz5yhdijwwrOQ8pF5bn2ynbB5BRpn0rq711aLRqJg2S2pGZrUhA+ho
         DmkQ2mro2+dlpawDLHGyc2fgKKPTRxeilpdh4Wwa3K61ZJjwJaQclWdfvzXyVcVvsRmT
         x9I+6FpoZonbaJV/xJ2iEydTn0ERDwWwKVQpTTp3+Xa6WL4tNeAPFocPpakLEjeZ9zYp
         sOMttmZFQAIVeoQjYgKqL8hJDk0Pz4kXmWQTU+rL4AhqDOnz5PMlqSs6eAL0rBPPHzt/
         qemw==
X-Gm-Message-State: AHPjjUhEk4C3AN3HcktiJkA8O0KH8FIDf7MncrY44Y4UwfB4OlvOk1ky
        ySh6SgowFejPg4wcLEUclXORHQ==
X-Google-Smtp-Source: AOwi7QDEW9BLp3xy7wdIQ+nWln7H19SUeDsj7yu38wV8gbYGuEbLauqVGZqKo/xyl8oFLK4RSDnyhw==
X-Received: by 10.84.178.164 with SMTP id z33mr11528979plb.53.1506452055661;
        Tue, 26 Sep 2017 11:54:15 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:7981:413b:8357:cbf7])
        by smtp.gmail.com with ESMTPSA id y63sm16792178pgd.20.2017.09.26.11.54.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 11:54:15 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, j6t@kdbg.org, jrnieder@gmail.com,
        sbeller@google.com
Subject: [PATCH] t7406: submodule.<name>.update command must not be run from .gitmodules
Date:   Tue, 26 Sep 2017 11:54:13 -0700
Message-Id: <20170926185413.21209-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
In-Reply-To: <xmqqshfa9doa.fsf@gitster.mtv.corp.google.com>
References: <xmqqshfa9doa.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

submodule.<name>.update can be assigned an arbitrary command via setting
it to "!command". When this command is found in the regular config, Git
ought to just run that command instead of other update mechanisms.

However if that command is just found in the .gitmodules file, it is
potentially untrusted, which is why we do not run it.  Add a test
confirming the behavior.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

Johannes wrote:
> I am pretty confident that this does not test what you intend to
> test. Notice that $TEST_DIRECTORY is expanded when the script is
> written. But that path contains a blank, and we have something like
> this in the test script:
>
>       #!/bin/sh
>       >/the/build/directory/t/trash directory.t7406/bad

I can confirm that.

Instead of mucking around with writing a script, "to make it robust",
I decided to got the simplest route and just have the command "!false",
which would make "git submodule update submodule" return an error.

Thanks,
Stefan


 t/t7406-submodule-update.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 034914a14f..a9ea098e55 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -406,6 +406,16 @@ test_expect_success 'submodule update - command in .git/config' '
 	)
 '
 
+test_expect_success 'submodule update - command in .gitmodules is ignored' '
+	test_when_finished "git -C super reset --hard HEAD^" &&
+
+	git -C super config -f .gitmodules submodule.submodule.update "!false" &&
+	git -C super commit -a -m "add command to .gitmodules file" &&
+	git -C super/submodule reset --hard $submodulesha1^ &&
+	git -C super submodule update submodule &&
+	test_path_is_missing bad
+'
+
 cat << EOF >expect
 Execution of 'false $submodulesha1' failed in submodule path 'submodule'
 EOF
-- 
2.14.0.rc0.3.g6c2e499285

