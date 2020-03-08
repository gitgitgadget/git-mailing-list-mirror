Return-Path: <SRS0=m/qT=4Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77A7C18E5B
	for <git@archiver.kernel.org>; Sun,  8 Mar 2020 08:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1F4206D7
	for <git@archiver.kernel.org>; Sun,  8 Mar 2020 08:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kf5OH8r7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgCHIqi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Mar 2020 04:46:38 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38569 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgCHIqi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Mar 2020 04:46:38 -0400
Received: by mail-lj1-f195.google.com with SMTP id w1so6768104ljh.5
        for <git@vger.kernel.org>; Sun, 08 Mar 2020 00:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JntQEYt2wArX8mX/io1NC8/FQRnEyzwV2iiJanGEwF0=;
        b=Kf5OH8r7sgPHWSKUCRoh+EoHkRWzj/WTZe2mfXtDyv+gYf3lyS6OKHMu+MtRfJPpji
         hlLepWe3U65SiuSr4rOCpbCyZWC0gN8hHm5gYLXpt0T7NjwsEcrW1oiOnyhh5GRPiS4o
         MdlBde7rNptdGHhFmt9L97hVs0gRr/lBuWJBaDlTZZEDJW0QRUUD9DBNiTf79X3kBGw3
         m/kDvD8Po1NEjA9ByVVjNMVNw4ohI40sJmdBtzFPhHZh+A3pRBBej3mE05tr9ZwTS8zF
         yxPctipQ8ZQEzGLSCUx6LBmBnt7WSMw7NwYg/TfU7AqTlR3B6OkVRATqTN6JyVFiwLno
         S4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JntQEYt2wArX8mX/io1NC8/FQRnEyzwV2iiJanGEwF0=;
        b=oIPTFIVEvqetJECqqjFdcCVVDq2uTuiFH3uSuELtHci0/oaNYd6+Aj6IECVaafr0EH
         cMo9COv1POvbDVJz9hqBSD6lPHtNIqdmRhFqNZC/3RPDKfjUMVy2yXwQtN4Pfxxn7Kh+
         UOTiplCY0poM/19QWosXcg9YmhYa1GREBn2v3hW1RSnELq3As4g2nXU6DekHc2v1ITS/
         tMDjdcgTVwBzw6QKTP7WDjRpNVEcBtK2Vmq9YAWKKXRMp4OC7z1Loiecm5tSZ+cI4oUe
         yznGmCuhBV5UmE87gJAL3Q/df4KMqCwMQetW8wyoNH6l23rj0d75yv804iwIgzkHKVi9
         2LlA==
X-Gm-Message-State: ANhLgQ0G8etYVKZNSz1ORN2tYnO1dfDMvYnTEW4xePh58iXsHk3hG82Y
        8bH199It5IbXyJnl6h95veJGsT4K
X-Google-Smtp-Source: ADFU+vu5tOmlS67kO8/hhVaRbMJl2X3+hSbbAE2qqBxijwqFXCtA5p9Cruoz82Rc7U1MiKih2oN2jQ==
X-Received: by 2002:a2e:b166:: with SMTP id a6mr6278555ljm.77.1583657194692;
        Sun, 08 Mar 2020 00:46:34 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id u4sm5817874lfo.79.2020.03.08.00.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 00:46:33 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     "Randall S . Becker" <rsbecker@nexbridge.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Subject: [PATCH] t1091: don't grep for `strerror()` string
Date:   Sun,  8 Mar 2020 09:46:27 +0100
Message-Id: <20200308084627.26677-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <018001d5f305$0c709af0$2551d0d0$@nexbridge.com>
References: <018001d5f305$0c709af0$2551d0d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We grep for "File exists" in stderr of the failing `git sparse-checkout`
to make sure that it failed for the right reason. We expect the string
to show up there since we call `strerror(errno)` in
`unable_to_lock_message()` in lockfile.c.

On the NonStop platform, this fails because the error string is "File
already exists", which doesn't match our grepping.

See 9042140097 ("test-dir-iterator: do not assume errno values",
2019-07-30) for a somewhat similar fix. There, we patched a test helper,
which meant we had access to `errno` and could investigate it better in
the test helper instead of just outputting the numerical value and
evaluating it in the test script. The current situation is different,
since (short of modifying the lockfile machinery, e.g., to be more
verbose) we don't have more than the output from `strerror()` available.

Except we do: We prefix `strerror(errno)` with `_("Unable to create
'%s.lock': ")`. Let's grep for that part instead. It verifies that we
were indeed unable to create the lock file. (If that fails for some
other reason than the file existing, we really really should expect
other tests to fail as well.)

An alternative fix would be to loosen the expression a bit and grep for
"File.* exists" instead. There would be no guarantee that some other
implementation couldn't come up with another error string, That is, that
could be the first move in an endless game of whack-a-mole. Of course,
it could also take us from "99" to "100" percent of the platforms and
we'd never have this problem again. But since we have another way of
addressing this, let's not even try the "loosen it up a bit" strategy.

Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Hi Randall,

 Thanks for the report.

 > test to fail. The error message generated is "File already exists" not "File
 > exists" as is required in the test. We should not be testing for specific
 > text content originating from strerror - I thought we had this decision in a
 > different thread.
 > https://public-inbox.org/git/xmqq36intlpj.fsf@gitster-ct.c.googlers.com/

 > error: 'grep File exists err' didn't find a match in:
 > fatal: Unable to create '/home/ituglib/randall/git/t/trash
 > directory.t1091-sparse-checkout-builtin/repo/.git/info/sparse-checkout.lock'
 > : File already exists.   <----- this is the test issue

 Does this patch solve it?

 t/t1091-sparse-checkout-builtin.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index b4c9c32a03..44a91205d6 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -305,7 +305,7 @@ test_expect_success 'fail when lock is taken' '
 	test_when_finished rm -rf repo/.git/info/sparse-checkout.lock &&
 	touch repo/.git/info/sparse-checkout.lock &&
 	test_must_fail git -C repo sparse-checkout set deep 2>err &&
-	test_i18ngrep "File exists" err
+	test_i18ngrep "Unable to create .*\.lock" err
 '
 
 test_expect_success '.gitignore should not warn about cone mode' '
-- 
2.25.1

