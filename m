Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993A4C71153
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 22:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbjH1WxT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 18:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234335AbjH1WxE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 18:53:04 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3665799
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 15:53:01 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5922b96c5fcso44460047b3.0
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 15:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1693263180; x=1693867980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nF6suqJ6Q8WuyTlKIQHkPYlFwZJHpu9xa7j+9QflZDU=;
        b=L9yodV2QBfjoa2wzgbaGe7jKSe+ssCjgVBx84Wq8fZAj9QvFMus3zsPAjxjk0TRh1+
         u/qGrmkrKRI6CoRkKlKSMeqNU4rP8njKM6QImtkF1MqAuIAjp3jRyBwAAN93tiDPBfcI
         1jACLSecfR5okJktQwJVwqKXZ/VQol/EApambIz3Z55EmrVia8Le6f8rOCx1dmoUmfoR
         XEcPY3/tmmHN54W/Ug5wHXY7P4Vqw2CmLZgdusB3N58Aqi9KTgQqIbCz4zONvJeGlhAJ
         aaRN1YuHj9gEVAvx1dd+7z2Jf43bd56WELqJuBbWCVxgGOibpTZN406YI6u9OdjUsNqf
         lz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693263180; x=1693867980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nF6suqJ6Q8WuyTlKIQHkPYlFwZJHpu9xa7j+9QflZDU=;
        b=HcAuA2M1TVizjOnlNsLi1LkiSyS3cIk3zcd5c6p0NnnpM1bvv3NqopVCdOLHYJcAUo
         O8k1HyqP6a1QguojiUcY7t7YeCIRaCER2P/pPl5s/8IhgFcC62AP982Px1tOPUDUuoe2
         MULtp50rJnmVPsPWXzcfiKsd2O+n1JMgGpcEjY3XSmdDg4U+M8zaIcgNSaZpvqaUKMRB
         TppkUJK9+oUc2OnNTp/0goMF5kZeYT+vKCnFDPlHuVMrT2finl9SW5XvDg5bi1oLIcxw
         RR5BwkveYHVl9rEL8wQmVr0SnDsfddUy0zYeB5MRxz0TYkhrt/IGdPcJGeyNZYlWXvKs
         ztWA==
X-Gm-Message-State: AOJu0YwCoXqjJtFiO3Hwmao0OiUMwtfxLzmXzSccqYoAVXCoL/59pmk6
        nTCdHPKa2gFpszGHKJgIPSdaWPW45Zpz/gIYto5ITA==
X-Google-Smtp-Source: AGHT+IHvn7cxVMn4spno3ndqATPQqZWTTp+083fAQ9p6IxT6CYEhdO3VhGhIz5UdpBAW7rpjGQEhyQ==
X-Received: by 2002:a81:60c2:0:b0:591:4f2b:7eea with SMTP id u185-20020a8160c2000000b005914f2b7eeamr26561743ywb.18.1693263180312;
        Mon, 28 Aug 2023 15:53:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d15-20020a81ab4f000000b005925765aa30sm2418074ywk.135.2023.08.28.15.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 15:53:00 -0700 (PDT)
Date:   Mon, 28 Aug 2023 18:52:59 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v2 2/4] leak tests: mark a handful of tests as leak-free
Message-ID: <164f37cade68104e7cae7613cad833eeeb87b4f1.1693263171.git.me@ttaylorr.com>
References: <cover.1692902414.git.me@ttaylorr.com>
 <cover.1693263171.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1693263171.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the topic merged via 5a4f8381b6 (Merge branch
'ab/mark-leak-free-tests', 2021-10-25), a handful of tests in the suite
were marked as leak-free.

Since then, a handful of tests have become leak-free due to changes like

  - 861c56f6f9 (branch: fix a leak in setup_tracking, 2023-06-11), and
  - 866b43e644 (do_read_index(): always mark index as initialized unless
    erroring out, 2023-06-29)

, but weren't updated at the time to mark themselves as such. This leads
to test "failures" when running:

    $ make SANITIZE=leak
    $ make -C t \
        GIT_TEST_PASSING_SANITIZE_LEAK=check \
        GIT_TEST_SANITIZE_LEAK_LOG=true \
        GIT_TEST_OPTS=-vi test

This patch closes those gaps by exporting TEST_PASSES_SANITIZE_LEAK=true
before sourcing t/test-lib.sh on most remaining leak-free tests.

There are a couple of other tests which are similarly leak-free, but not
included in the list of tests touched by this patch. The remaining tests
will be addressed in the subsequent two patches.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5571-pre-push-hook.sh | 1 +
 t/t7516-commit-races.sh  | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/t/t5571-pre-push-hook.sh b/t/t5571-pre-push-hook.sh
index a11b20e378..448134c4bf 100755
--- a/t/t5571-pre-push-hook.sh
+++ b/t/t5571-pre-push-hook.sh
@@ -4,6 +4,7 @@ test_description='check pre-push hooks'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7516-commit-races.sh b/t/t7516-commit-races.sh
index 2d38a16480..bb95f09810 100755
--- a/t/t7516-commit-races.sh
+++ b/t/t7516-commit-races.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='git commit races'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'race to create orphan commit' '
-- 
2.42.0.49.g03c54e21ee

