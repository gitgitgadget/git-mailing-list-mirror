Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14957C76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjDAIqf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDAIqd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:46:33 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3751BEB75
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:46:32 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id b19so18412724oib.7
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+Ik/mgc5Vo++KuKdyyS+fCJV9CAMDLDsNWzL8FJmPQ=;
        b=XNOlyu93QxwD/etPkqOWa49wjz0EY5vPN1PhQsRbZKZ8Sp6xSga3Ko39RP9p4Mn4Gz
         /TZjEcTBvEr/lOoesT4IHRWH2FH3zw4Q7z917+FUL4t2nB7Jkkwfjm4cCiPh/33SzEUr
         HVIleQv0eUPXa6g+YJQ5cP0js7pQRImVqR8thukUPIoHiBnlxbbOTZURKdUPRipT4OIr
         XD3RALFkaMnbTAGEUVZIZuHFdiyRKkNXlx3ym5r1uIoPYgAdRGx0yos0KhMa9zwWdhy8
         X9haTeyfJDyCredvxCCbRuC4gTLJqHuWLc/FcU/6JF2aciGL2barbVAcKAMBg8gLT+wA
         v9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+Ik/mgc5Vo++KuKdyyS+fCJV9CAMDLDsNWzL8FJmPQ=;
        b=n7XHuJd3bObD2jypRGEzVKaU/dThyfUJYaqUtFHhJK81W99qekIjK8xNpj0u6/FAt4
         7AFI6m31MTV26/a3CuW2WMWxh1JAxxlv+ULK0L7w3O8BZL9veSf9GpsckGZwm29BhPhZ
         jkl1Bp0Ul3ou5j/zPYKcmjDSAkf2SGvdB/97TgGFdW5V3uID1VFVQW4BJyxvvhNV0R24
         CSUK6PZNORjd1/BL8R/Q3p3ZT1bC7z0E24KEksrL4ekNdx39jTYOmyCt0lLN+o0L2ZId
         cNOhlfjxvtqlKScW7ujjHA9KhiWV3BsRroJ1yqZKTOJE5CwF2frqYhbmpXOVvvkYBeCX
         D6GA==
X-Gm-Message-State: AO0yUKUefrK4fuW9DHuG9YthRz4iZxlc6FdHYGEnG+4iHmvEyOrMrzGp
        +UiyHsKQtD4mRyLzA3i0z+w4fr5ecAk=
X-Google-Smtp-Source: AK7set8TLsND47mJVFBBccjbi1rPa667jzmeMONq3Pn4ucBFjrlPRP2v1RTsuxn5aXeBSgjfa1l0xQ==
X-Received: by 2002:a05:6808:2d3:b0:37f:a6cb:7a86 with SMTP id a19-20020a05680802d300b0037fa6cb7a86mr9682875oid.10.1680338789652;
        Sat, 01 Apr 2023 01:46:29 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id et18-20020a056808281200b003872148d322sm1847155oib.22.2023.04.01.01.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:46:29 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 01/49] test: completion add test for __git_cmd_idx
Date:   Sat,  1 Apr 2023 02:45:38 -0600
Message-Id: <20230401084626.304356-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When __git_func_wrap was fixed to set correctly __git_cmd_idx in
cea232194d (completion: bash: fix late declaration of __git_cmd_idx,
2021-06-18) no test was added, therefore we could hit the same bug in
the future.

To ensure that doesn't happen add a test which adds an alias for 'git
add' with __git_complete, and then pretend the user typed this alias.

To make sure __git_cmd_idx is correct we add the --update option to
ensure the result of __git_find_on_cmdline (which uses __git_cmd_idx) is
correct. When __git_cmd_idx isn't correct __git_find_on_cmdline fails,
and therefore the --update option isn't interpreted correctly.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index d6c0478d98..561f06b46a 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2689,4 +2689,13 @@ test_expect_success '__git_complete' '
 	test_must_fail __git_complete ga missing
 '
 
+test_expect_success '__git_complete has correct __git_cmd_idx' '
+	__git_complete ga _git_add &&
+	echo modified > file1 &&
+	touch file3 &&
+	_words=(ga --update f) _cword=2 &&
+	__git_wrap_git_add &&
+	test "${COMPREPLY[*]}" = "file1"
+'
+
 test_done
-- 
2.33.0

