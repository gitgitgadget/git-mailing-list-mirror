Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C54EB64DD
	for <git@archiver.kernel.org>; Thu, 29 Jun 2023 13:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjF2NlC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 09:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjF2Nkr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 09:40:47 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC909358D
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 06:40:36 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-262e66481c4so366822a91.1
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 06:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688046036; x=1690638036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMtRpMBAGwmgjCTbeUtyFTe9qu0TFNB85skrpg1A+p4=;
        b=HV59SYpgrjIfbI0um+UUnTnnH15SwVnEw/2OLtIFIoM0dk4HDYZpeJIsVM/Df6c4T1
         55VTIh1aU6K1e5OcCwQH31U6Ps+WwSxyvpFcHbxsenr7kBwzyZUaZat2rDMv737po+9v
         nCED9xtL9g2duI8rhUtocfIBKWZTC+JYGWnUz9OPJYmFfEM5T7lzG9Qv5kYAUJzByBh2
         FsckC5UrhuvJy1m02yLrizEvNdi5nz0Pzmv3WihjeKGMJi/kRPPqySAAMkB9vdhDc1Xl
         Mx1CmzyXtnZrN6zztV3UWlX7+dY5uZ7q39UNUMTqc76thYeq1vYfRrl49AsA3CkkcSOR
         p6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688046036; x=1690638036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMtRpMBAGwmgjCTbeUtyFTe9qu0TFNB85skrpg1A+p4=;
        b=IyB2cp8T1KN8lmQ4S3jq+MtpgPB9MqvP4C9b+ZyRaifuAk5gDFAwn2D+n95g6HbSdg
         VTQx0rM4n5BnC41hLoo2ucbvSiGPp57oUcDYBhi1jTl5WADGDe6NoLeMn0xcEzvEgy49
         ubyixMxMaTi7OT/smOYbWBAXbujXq/RsG0DLhLC4qJU4IUk+AjQ1Ie3D16FyAsbUOLAZ
         hXhCDgbIjHD1OCLTjsJKieYGw1TOlrnPNEk1GL5MeNYVIRfwwMaSna+L+gu3tEYf4sME
         BMs0yFEILpMTNIXPKjzAh1uYvWOnVjGDXKlMOuJDa7SMURNPW79JcPNvFUZU+kVTftGl
         4BNg==
X-Gm-Message-State: ABy/qLa4jM0ZWERniuxxsJLg9AiVSioo1Qm7B4ESJQdEPQHAd0D0QxEv
        rDfxLcSCUGoS9v41UdK5k7XwcMMV43nDvw==
X-Google-Smtp-Source: APBJJlHQ/tyYehRkb+b/WLZWNEK+RLH1jBtxI1VXIrqn0F+yx6KcAgnI0XcHMpbzanh1JFBPqo9rkw==
X-Received: by 2002:a17:90a:5a04:b0:263:5377:5842 with SMTP id b4-20020a17090a5a0400b0026353775842mr2023975pjd.26.1688046035934;
        Thu, 29 Jun 2023 06:40:35 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.158.45])
        by smtp.gmail.com with ESMTPSA id jd1-20020a170903260100b001b7fad412f9sm7426305plb.226.2023.06.29.06.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 06:40:35 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Kousik Sanagavarapu <five231003@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: [PATCH v2] t4205: correctly test %(describe:abbrev=...)
Date:   Thu, 29 Jun 2023 18:48:08 +0530
Message-ID: <20230629133841.18784-2-five231003@gmail.com>
X-Mailer: git-send-email 2.41.0.29.g8148156d44.dirty
In-Reply-To: <20230628181753.10384-1-five231003@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The pretty format %(describe:abbrev=<number>) tells describe to use
at least <number> digits of the oid to generate the human-readable
format of the commit-ish.

There are three things to test here:
  - Check that we can describe a commit that is not tagged (that is,
    for example our HEAD is at least one commit ahead of some reachable
    commit which is tagged) with at least <number> digits of the oid
    being used for describing it.

  - Check that when using such a commit-ish, we always use at least
    <number> digits of the oid to describe it.

  - Check that we can describe a tag. This just gives the name of the
    tag irrespective of abbrev (abbrev doesn't make sense here).

Do this, instead of the current test which only tests the last case.

Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---

Changes since v1:
- Changed the log message
- Added things to be tested as commented by Junio

Range-diff vs v1:
1:  2c10de6c11 ! 1:  76c3e38033 t4205: correctly test
%(describe:abbrev=...)
    @@ Metadata
      ## Commit message ##
         t4205: correctly test %(describe:abbrev=...)
     
    -    The pretty format %(describe:abbrev=<number>) tells describe to
         use only
    -    <number> characters of the oid to generate the human-readable
         format of
    -    the commit-ish.
    +    The pretty format %(describe:abbrev=<number>) tells describe to
use
    +    at least <number> digits of the oid to generate the
human-readable
    +    format of the commit-ish.
     
    -    This is not apparent in the test for %(describe:abbrev=...)
         because we
    -    directly tag HEAD and use that, in which case the
         human-readable format
    -    is just the tag name. So, create a new commit and use that
         instead.
    +    There are three things to test here:
    +      - Check that we can describe a commit that is not tagged
(that is,
    +        for example our HEAD is at least one commit ahead of some
reachable
    +        commit which is tagged) with at least <number> digits of
the oid
    +        being used for describing it.
     
    +      - Check that when using such a commit-ish, we always use at
least
    +        <number> digits of the oid to describe it.
    +
    +      - Check that we can describe a tag. This just gives the name
of the
    +        tag irrespective of abbrev (abbrev doesn't make sense
here).
    +
    +    Do this, instead of the current test which only tests the last
case.
    +
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Mentored-by: Christian Couder <christian.couder@gmail.com>
         Mentored-by: Hariom Verma <hariom18599@gmail.com>
         Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
     
      ## t/t4205-log-pretty-formats.sh ##
     @@ t/t4205-log-pretty-formats.sh: test_expect_success
'%(describe:tags) vs git describe --tags' '
    - '
      
      test_expect_success '%(describe:abbrev=...) vs git describe
--abbrev=...' '
    --  test_when_finished "git tag -d tagname" &&
    --  git tag -a -m tagged tagname &&
    +   test_when_finished "git tag -d tagname" &&
    ++
    ++  # Case 1: We have commits between HEAD and the most recent tag
    ++  #         reachable from it
     +  test_commit --no-tag file &&
    ++  git describe --abbrev=15 >expect &&
    ++  git log -1 --format="%(describe:abbrev=15)" >actual &&
    ++  test_cmp expect actual &&
    ++
    ++  # Make sure the hash used is at least 15 digits long
    ++  sed -e "s/^.*-g\([0-9a-f]*\)$/\1/" <actual >hexpart &&
    ++  test 16 -le $(wc -c <hexpart) &&
    ++
    ++  # Case 2: We have a tag at HEAD, describe directly gives the
    ++  #         name of the tag
    +   git tag -a -m tagged tagname &&
        git describe --abbrev=15 >expect &&
        git log -1 --format="%(describe:abbrev=15)" >actual &&
    -   test_cmp expect actual
    +-  test_cmp expect actual
    ++  test_cmp expect actual &&
    ++  test tagname = $(cat actual)
    + '
    + 
    + test_expect_success 'log --pretty with space stealing' '

 t/t4205-log-pretty-formats.sh | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 4cf8a77667..dd9035aa38 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -1012,10 +1012,25 @@ test_expect_success '%(describe:tags) vs git describe --tags' '
 
 test_expect_success '%(describe:abbrev=...) vs git describe --abbrev=...' '
 	test_when_finished "git tag -d tagname" &&
+
+	# Case 1: We have commits between HEAD and the most recent tag
+	#	  reachable from it
+	test_commit --no-tag file &&
+	git describe --abbrev=15 >expect &&
+	git log -1 --format="%(describe:abbrev=15)" >actual &&
+	test_cmp expect actual &&
+
+	# Make sure the hash used is at least 15 digits long
+	sed -e "s/^.*-g\([0-9a-f]*\)$/\1/" <actual >hexpart &&
+	test 16 -le $(wc -c <hexpart) &&
+
+	# Case 2: We have a tag at HEAD, describe directly gives the
+	#	  name of the tag
 	git tag -a -m tagged tagname &&
 	git describe --abbrev=15 >expect &&
 	git log -1 --format="%(describe:abbrev=15)" >actual &&
-	test_cmp expect actual
+	test_cmp expect actual &&
+	test tagname = $(cat actual)
 '
 
 test_expect_success 'log --pretty with space stealing' '
-- 
2.41.0.29.g8148156d44.dirty

