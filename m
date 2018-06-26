Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25DD91F516
	for <e@80x24.org>; Tue, 26 Jun 2018 07:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932089AbeFZHdT (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 03:33:19 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:45767 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752680AbeFZHa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 03:30:56 -0400
Received: by mail-io0-f193.google.com with SMTP id l25-v6so14978449ioh.12
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 00:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=usdiu4ro08bKh7zfILzn2NKyNq0IsmXFKpxc6VoJg+8=;
        b=K5uIyw5Y+/cglWeS76a0mLcigpiNuVvfMoVOHcwmKi9ChdIytWRDVIH5DIPLgHELG5
         f80LHmUBuf8SmXK5+z/TQwzq5gu+oTux3AmRWwfWYegirNNBpJ6eHuZNVWLdUjn7eC+/
         vN5zY1+KIssolTAgfKL4MygtjUSFaWgzTc1goCSJM8d8vgrlrmXgi6vM4tyGh5JXUWso
         6MlMhdvL0DOt6LmR1c96JiZPe9sSPUKWrH8oSHWjXScbT+aN0EH8tdZHN8mKzcff/nKQ
         ffTf1ZBqqfGK8Zp4NogcYKZXQkoJF6aI9t2z2VVtWS4bMuJnpWfLxi4FgGPvzypeN/Mu
         FAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=usdiu4ro08bKh7zfILzn2NKyNq0IsmXFKpxc6VoJg+8=;
        b=WfsebfP7z7b4GXKsFvEzcOxmNGO89XEFwRHhSktpgt8Kon8riRBqFqA/e8tk2AIMZz
         YAzgqZg9ILAKU8eOXVMuiPHGP6DnvsN888oPXgWgHVhMqwFoVKltO9mE83Xbl2/doK0v
         w30x6ztuSLu1tpZ608R9DDZEDvCSE3Z1XxPMU/J+ARwV6zdA3Cfw8bynfHWzwG86ESUr
         qUiEgL6BPWIwrJSOUh1FN7aLHidc/BLiybeltDnHyMe4lTcxK/FNzNXzpW03mpau+E5f
         a7Dh6L2l9i8yIvx/lyNetxe2+Ai794DXDR/RzTKVuF9NHz7ulMGqKxqpAdjMsZfR+hry
         OeMQ==
X-Gm-Message-State: APt69E3HmKu9mNxkg+6s+b3iyPCrtWfPWcx2c4w4DzE+CyS1B/mScf9d
        JD4P3e4y+nmLwWN0XZFe8MpxNA==
X-Google-Smtp-Source: AAOMgpcBb+jJgeJar05EBbRysYfuuHs7kWhoYvlgLHMGO6YabtFN6ME2/1uREBfYy21GyLxGa1woFQ==
X-Received: by 2002:a6b:cf05:: with SMTP id o5-v6mr283882ioa.230.1529998255204;
        Tue, 26 Jun 2018 00:30:55 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id k20-v6sm471361iok.9.2018.06.26.00.30.54
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 00:30:54 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 06/29] t6036: fix broken "merge fails but has appropriate contents" tests
Date:   Tue, 26 Jun 2018 03:29:38 -0400
Message-Id: <20180626073001.6555-7-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.419.gfe4b301394
In-Reply-To: <20180626073001.6555-1-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These tests reference non-existent object "c" when they really mean to
be referencing "C", however, this error went unnoticed due to a broken
&&-chain later in the test. Fix these errors, as well as the broken
&&-chains behind which they hid.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t6036-recursive-corner-cases.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index b5621303d6..b32ff8e1db 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -506,10 +506,10 @@ test_expect_success 'merge of D & E2 fails but has appropriate contents' '
 		test_line_count = 2 out &&
 
 		git rev-parse >expect    \
-			B:a   E2:a/file  c:a/file   A:ignore-me &&
+			B:a   E2:a/file  C:a/file   A:ignore-me &&
 		git rev-parse   >actual   \
 			:2:a  :3:a/file  :1:a/file  :0:ignore-me &&
-		test_cmp expect actual
+		test_cmp expect actual &&
 
 		test_path_is_file a~HEAD
 	)
@@ -533,10 +533,10 @@ test_expect_success 'merge of E2 & D fails but has appropriate contents' '
 		test_line_count = 2 out &&
 
 		git rev-parse >expect    \
-			B:a   E2:a/file  c:a/file   A:ignore-me &&
+			B:a   E2:a/file  C:a/file   A:ignore-me &&
 		git rev-parse   >actual   \
 			:3:a  :2:a/file  :1:a/file  :0:ignore-me &&
-		test_cmp expect actual
+		test_cmp expect actual &&
 
 		test_path_is_file a~D^0
 	)
-- 
2.18.0.419.gfe4b301394

