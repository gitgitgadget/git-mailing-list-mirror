Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE9EC433FE
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 10:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 781F66113E
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 10:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238020AbhJFKEe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 06:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238047AbhJFKE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 06:04:29 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04050C061766
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 03:02:33 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r18so7115244wrg.6
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 03:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HqBxnBdJDc811wYka34z0oCiqNFjsR27o10Wypv7ACE=;
        b=aB5TKXac35fRqgoRg9YjWRZxnbxjY6ocCHxO3pwpYJ1mnvIb1qQu2a2A7M2qNh1Eys
         s+Eay1HVxb5MUpq6BRKEPo+3WA7oSq1P8JtQGjb3chDiKfcz2Qr6to/g9ErpXkEvXQbx
         t+soqHXkrgcCM+ur8xJrOB+5ubcR0mYvOnquLkNWcuz/jbtFYrqb3hHa495lLG8GAiqG
         npic4bB3EdmoGJUxXOf4lL3Vq02IapZaeoTU5tD6e4FzdVIQNLJZxkL0U2p2Fa+Ei56i
         822vkn4tZm6YZZPLvUWAr0wAsAc1qERlYOK7riBvsS/ex7F0NyltzPFnQl/l+2/OO8Jl
         rzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HqBxnBdJDc811wYka34z0oCiqNFjsR27o10Wypv7ACE=;
        b=fz/WwJsJ3x3hjYWFJ1k4apqOcfGknXj723Q/0hS/JpjrDC0T285YJqn1nuEYvYvj3R
         1jWNp+zxLmdZth6La+TehfSjsQJ8Vu7ZDRoITFM6QzEPPB0pEHxOazfcyZNX7UwgEeab
         qxKkrfvxsl1t8Nt8SJd22Cy9qM6DGnNZm37Jzg9hqTftWdJtVjO32xy4Z+iMJvkLR+Nv
         PPQVfJV93X7Fhqd0Y44MMhNA18KQJUfmRABYp3c7KkOhb1QZNGK4AEOnKPSUtOQ+W6Yr
         7Wx3tKbWmGrMCkFgwxY+jSWrSWyigbQrqBDTDVtN/ofgwoSN3p7s1wx7q/rKmAvb5EFh
         4VVg==
X-Gm-Message-State: AOAM530tybMTcXRY8nsz9WVicGm+js2NBE3yhq9rpc3vkw6bgxhpmHwf
        xni4vmk3xao0MUcG9S8sW62zxPOtPJAtjQ==
X-Google-Smtp-Source: ABdhPJwiEcBpS2PSdUL9y1jOUYmF3gDbAUr4Do8B84DBGqxTjmpL+3n/vJnHLhCXOBAmDVUTl/Zf9Q==
X-Received: by 2002:a1c:791a:: with SMTP id l26mr8840496wme.22.1633514551367;
        Wed, 06 Oct 2021 03:02:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h18sm5515279wmq.23.2021.10.06.03.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 03:02:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/7] tests: fix a memory leak in test-oidtree.c
Date:   Wed,  6 Oct 2021 12:02:21 +0200
Message-Id: <patch-3.7-a216297aba1-20211006T095426Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1441.gbbcdb4c3c66
In-Reply-To: <cover-0.7-00000000000-20211006T095426Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20211006T095426Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in t/helper/test-oidtree.c, we were not freeing the
"struct strbuf" we used for the stdin input we parsed. This leak has
been here ever since 92d8ed8ac10 (oidtree: a crit-bit tree for
odb_loose_cache, 2021-07-07).

Now that it's fixed we can declare that t0069-oidtree.sh will pass
under GIT_TEST_PASSING_SANITIZE_LEAK=true.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-oidtree.c | 3 +++
 t/t0069-oidtree.sh      | 1 +
 2 files changed, 4 insertions(+)

diff --git a/t/helper/test-oidtree.c b/t/helper/test-oidtree.c
index 180ee28dd93..d48a409f4e4 100644
--- a/t/helper/test-oidtree.c
+++ b/t/helper/test-oidtree.c
@@ -45,5 +45,8 @@ int cmd__oidtree(int argc, const char **argv)
 			die("unknown command: %s", line.buf);
 		}
 	}
+
+	strbuf_release(&line);
+
 	return 0;
 }
diff --git a/t/t0069-oidtree.sh b/t/t0069-oidtree.sh
index bfb1397d7b2..74cc59bf8a7 100755
--- a/t/t0069-oidtree.sh
+++ b/t/t0069-oidtree.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 
 test_description='basic tests for the oidtree implementation'
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 maxhexsz=$(test_oid hexsz)
-- 
2.33.0.1441.gbbcdb4c3c66

