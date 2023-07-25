Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C8FEB64DD
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 21:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjGYVAZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 17:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjGYVAW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 17:00:22 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E002173B
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 14:00:19 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-55b22f82ac8so184727a12.1
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 14:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690318819; x=1690923619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8eIgoDnXOksHlX9kAv9ADbyFlegaU569fb0KWPiLe+M=;
        b=ML9ZdFRIlxVCOx8KglGVnG/50xHG5ZFqblDQeuopCUa/7qF0MuSANvGpaEK+wQ7uqm
         dpIka9pWYTQ5KVmSl+D9hIqg8R7Bs4j3wUfgrc0VmnRiR5/W5nN3KAsN/yEqFtpnZHHE
         cn8khCxJr3BjSNPjgdzcwTRTd3BxXqkaqqr9EkGhWMxBlktL7QLrwkfrSu0tE6cFfECc
         CpNPeNnQpzBpwG+a9jZz9KcFilO061vCGORURcHEjaQv/nLaHL+JRUSTth7sgB2N3qh3
         xeQzF7kp94tT70/mo4urCYRxv9OhEApcsMugsEZk8eg2BJKBHKg4zDLQva3gMyDrv53T
         hZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690318819; x=1690923619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8eIgoDnXOksHlX9kAv9ADbyFlegaU569fb0KWPiLe+M=;
        b=N+uXjO0JAMkl8/Y9n/4Y9llWb1mQ427FyeS+Kb4UYKmRHvPBPMYNHIwG04UVaYIJi0
         MPpjIn4jP2N6fxFdQk0+sgtFFfn6p6//15kSvhH04s8ZLTtCBK6Ngn/HixI3yiUHb6oU
         c0nPoVlqE+soAaWH1cmxsZLfNjmRH9Zre7K0lsCPLFDN8E44EsjwFE8c/alJ/2HL8o/U
         /O47OLw6T33Y2VVXnGdIZAfkGihmZJ5kyaokSPkb7IXZSQRly9sMJ5oTJUDLd+S1Wb32
         bDVhNlCkMleukZsjirrsVArwwjo3PJ1MoxFzZ+s7lo60+1eTR5ZXO8VdyCg5QPlw720V
         ISRQ==
X-Gm-Message-State: ABy/qLamuMexRBZw2I3bBYEUgtJiF8OsObDaCX+YqXMuIRnKydwXZAeq
        urclguk4+W0ul2cF1Qt8Nw5MU1ljVvyD3cRc
X-Google-Smtp-Source: APBJJlEMSFfoF7cPCNmDrtWhC7KawGYWDfIyqGHuZYvKNxlsuodPSNS1AmuocKQONq4IfB/k+9LOCw==
X-Received: by 2002:a17:90a:9316:b0:263:161c:9e9c with SMTP id p22-20020a17090a931600b00263161c9e9cmr374799pjo.12.1690318819048;
        Tue, 25 Jul 2023 14:00:19 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.158.194])
        by smtp.gmail.com with ESMTPSA id e6-20020a17090a818600b00262e485156esm10003071pjn.57.2023.07.25.14.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 14:00:18 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Glen Choo <chooglen@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Siddharth Singh <siddhartth@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH v5 0/2] Add new "describe" atom
Date:   Wed, 26 Jul 2023 02:21:20 +0530
Message-ID: <20230725205924.40585-1-five231003@gmail.com>
X-Mailer: git-send-email 2.41.0.396.g77a2a56520
In-Reply-To: <20230723162717.68123-1-five231003@gmail.com>
References: <20230723162717.68123-1-five231003@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
Thanks for the review on the previous version of this series. Here is a
quick re-roll to address the minor changes that you left on the previous
version (apart from the suggestions to PATCH 1/2).

Please queue this instead.

PATCH 1/2 - Left unchanged

PATCH 2/2 - Used the test helper function `test_must_fail` instead of
	    something like "! git foo" for making a command fail.

Kousik Sanagavarapu (2):
  ref-filter: add multiple-option parsing functions
  ref-filter: add new "describe" atom

 Documentation/git-for-each-ref.txt |  23 +++
 ref-filter.c                       | 230 +++++++++++++++++++++++++++++
 t/t6300-for-each-ref.sh            | 139 +++++++++++++++++
 3 files changed, 392 insertions(+)

Range-diff against v4:
1:  2914bd58ec = 1:  2914bd58ec ref-filter: add multiple-option parsing functions
2:  77a2a56520 ! 2:  8127f4399c ref-filter: add new "describe" atom
    @@ t/t6300-for-each-ref.sh: test_expect_success 'color.ui=always does not override
     +          cat >expect <<-\EOF &&
     +          fatal: unrecognized %(describe) argument: baz
     +          EOF
    -+          ! git for-each-ref --format="%(describe:baz)" \
    ++          test_must_fail git for-each-ref \
    ++                  --format="%(describe:baz)" \
     +                  refs/heads/master 2>actual &&
     +          test_cmp expect actual &&
     +
    @@ t/t6300-for-each-ref.sh: test_expect_success 'color.ui=always does not override
     +          cat >expect <<-\EOF &&
     +          fatal: unrecognized %(describe) argument: qux=1,abbrev=14
     +          EOF
    -+          ! git for-each-ref \
    ++          test_must_fail git for-each-ref \
     +                  --format="%(describe:tags,qux=1,abbrev=14)" \
     +                  ref/heads/master 2>actual &&
     +          test_cmp expect actual

-- 
2.41.0.396.g77a2a56520

