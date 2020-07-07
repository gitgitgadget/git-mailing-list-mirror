Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C491C433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 17:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0491420675
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 17:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WakhLfgU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgGGRlG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgGGRlF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 13:41:05 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8002FC061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 10:41:05 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g75so44215945wme.5
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 10:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0hO9zfCdI1hsNV4eqvn1MnkFBOWjyFvDyE4eC+lXQkk=;
        b=WakhLfgU4KigHUqXArC95NQRDm5DD81sDXC8QpD0c8YFwwnLZRVswaLfjB2UITGJ0X
         EN6k+HUFVPcSntoA+0ZHWRZrVajm/XVgaDzWbU61WxjQ5unk3dzvAZkyi4c7vvYu/C36
         af5WGJCLg5Qbv8i3NpKgTzTjvi+cbY4BfefDkae0BjfyJiRzT5yrRGNuUqDjv3/dhxCr
         NrJaLktiNbe5QXzklUekH+u8zC/ZxoqPWwUtyCkEXvylnMPbyIySH/Ok3jWOkXNmO6gQ
         8BJITTTbTF8mw/G83eCCt1wwUOE8GcDlOolj600Npnw8K6slYpa56kmCjb/nYuDMBVqt
         FutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0hO9zfCdI1hsNV4eqvn1MnkFBOWjyFvDyE4eC+lXQkk=;
        b=IfM5nZQ6MoI2jr4YsHNAp1o3N1xW1Y/U70+nUAFzj5+iQ8yQk1Wb6QKiSpdlNsZ07h
         ySD7BUlk/JYiax5RN6wCoEuqJg0DjVTqy07kZBwALQecjRckHEUIdgjSBqCTL22LbsZd
         UTGKGnuOWvQ/KhDdphQy83CmEHTXz4m5Gs0BB+4BV+jRK5NRx1S/CgPO3knR72ZY8hc1
         egHSCE7cjZSOFH2f7ismgJRrvhIH+YiaAgRdcUNJnze9KDcdT0VyATnUVm7ubWsiOI6v
         AWZRYGW/UzJLcgfYvgJfq31DJvp8k84t55epxPnKI1M11OBLes/NQhy76YVhVGHSIp4+
         ztfw==
X-Gm-Message-State: AOAM532bXDVf2Yi6LqRJaDKsnRvlvfycUhuVf61vi6kOmX7wESbP6o2V
        NnResh+VlST/lisiRbH0liWeJSsQ4NE=
X-Google-Smtp-Source: ABdhPJxCZJLxgu8/3o2raUzQkPG1UqK6ba4MLy6rD7SzKNGib3G3ECt75EMbHKGwfv+8ScdrWpMaUA==
X-Received: by 2002:a1c:b103:: with SMTP id a3mr5288760wmf.186.1594143663853;
        Tue, 07 Jul 2020 10:41:03 -0700 (PDT)
Received: from localhost.localdomain ([185.228.230.97])
        by smtp.gmail.com with ESMTPSA id c194sm1977405wme.8.2020.07.07.10.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 10:41:03 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 0/4] Add support for %(contents:size) in ref-filter
Date:   Tue,  7 Jul 2020 19:40:45 +0200
Message-Id: <20200707174049.21714-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.460.g66f3a24dd5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is version 3 of a small patch series to teach ref-filter about
%(contents:size).

This patch series is based on current master.

Previous versions and related discussions are here:

V1: https://lore.kernel.org/git/20200701132308.16691-1-chriscool@tuxfamily.org/
V2: https://lore.kernel.org/git/20200702140845.24945-1-chriscool@tuxfamily.org/

Thanks to Junio and Peff for their reviews of this series!

The changes compared to V2 are the following:

  - Added patch 2/4 that clarifies the meaning of "complete message"
    in the doc.

  - Added patch 3/4 that adds tests for refs pointing to a tree or a
    blob.

  - Improved commit message in patch 4/4 as suggested by Junio.

  - Added %(contents:size) tests in patch 4/4 for refs pointing to a
    tree or a blob.

The range diff is:

1:  c6e80b8bc1 = 1:  b04b390f32 Documentation: clarify %(contents:XXXX) doc
-:  ---------- > 2:  b62cab2630 Documentation: clarify 'complete message'
-:  ---------- > 3:  b9584472a1 t6300: test refs pointing to tree and blob
2:  9853b37091 ! 4:  23f941132e ref-filter: add support for %(contents:size)
    @@ Commit message
     
         Also the result of the following:
     
    -    `git for-each-ref --format='%(contents)' | wc -c`
    +    `git for-each-ref --format='%(contents)' refs/heads/my-branch | wc -c`
     
         is off by one as `git for-each-ref` appends a newline character
    -    after the contents, which can be seen by comparing its ouput
    +    after the contents, which can be seen by comparing its output
         with the output from `git cat-file`.
     
    +    As with %(contents), %(contents:size) is silently ignored, if a
    +    ref points to something other than a commit or a tag:
    +
    +    ```
    +    $ git update-ref refs/mytrees/first HEAD^{tree}
    +    $ git for-each-ref --format='%(contents)' refs/mytrees/first
    +
    +    $ git for-each-ref --format='%(contents:size)' refs/mytrees/first
    +
    +    ```
    +
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
      ## Documentation/git-for-each-ref.txt ##
    -@@ Documentation/git-for-each-ref.txt: and `date` to extract the named component.
    - The complete message of a commit or tag object is `contents`. This
    - field can also be used in the following ways:
    +@@ Documentation/git-for-each-ref.txt: The complete message (subject, body, trailers and signature) of a
    + commit or tag object is `contents`. This field can also be used in the
    + following ways:
      
     +contents:size::
     +  The size in bytes of the complete message.
    @@ t/t6300-for-each-ref.sh: test_atom refs/tags/signed-long contents "subject line
      $sig"
     +test_tag_contents_size_pgp refs/tags/signed-long
      
    + test_expect_success 'set up refs pointing to tree and blob' '
    +   git update-ref refs/mytrees/first refs/heads/master^{tree} &&
    +@@ t/t6300-for-each-ref.sh: test_atom refs/mytrees/first body ""
    + test_atom refs/mytrees/first contents:body ""
    + test_atom refs/mytrees/first contents:signature ""
    + test_atom refs/mytrees/first contents ""
    ++test_atom refs/mytrees/first contents:size ""
    + 
    + test_atom refs/myblobs/first subject ""
    + test_atom refs/myblobs/first contents:subject ""
    +@@ t/t6300-for-each-ref.sh: test_atom refs/myblobs/first body ""
    + test_atom refs/myblobs/first contents:body ""
    + test_atom refs/myblobs/first contents:signature ""
    + test_atom refs/myblobs/first contents ""
    ++test_atom refs/myblobs/first contents:size ""
    + 
      test_expect_success 'set up multiple-sort tags' '
        for when in 100000 200000

Christian Couder (4):
  Documentation: clarify %(contents:XXXX) doc
  Documentation: clarify 'complete message'
  t6300: test refs pointing to tree and blob
  ref-filter: add support for %(contents:size)

 Documentation/git-for-each-ref.txt | 28 +++++++++++++++-----
 ref-filter.c                       |  7 ++++-
 t/t6300-for-each-ref.sh            | 41 ++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 7 deletions(-)

-- 
2.27.0.460.g66f3a24dd5

