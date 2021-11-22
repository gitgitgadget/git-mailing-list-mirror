Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715D7C433FE
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 08:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238879AbhKVIMA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 03:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238875AbhKVIL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 03:11:58 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9038C061714
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 00:08:52 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id u80so3739937pfc.9
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 00:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kh0ZllFgVuM6KKMaGmIcI7LcGYxE2gtH9yMYyL+YVdw=;
        b=l1iWr4VRTl/z+PSGUZpVurUynVdpI/W76efyYjL29oSWu8vi5d+RXczzI2H9O0EU6L
         R0lx0mUyNia5zBK27dG1GWp9/rnfBvwEYeXRt/RChw9QDbQWYHIyAbRAtGbS24jfEoBH
         V0fPkebU7jR+b4OM2Z2wLD7ILMxgtp5ZOphTfCHfn6juz1HayamvikJADg3RY+SoeVbp
         EaXB3Z5RkfiqM+7bffcVV/e2YtoQWQIMGzJumwtmkMTsV/4SZlfHhZOtmQ5DYzmE6aCR
         3/GG7hGBF3A3sLTdHHvCf2m1B28kOGwZ6vx6Yi5bKtZ6UdgujvfVnNGjYbppKCj/O0WC
         0N4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kh0ZllFgVuM6KKMaGmIcI7LcGYxE2gtH9yMYyL+YVdw=;
        b=wl5WxHRfKVj75jAaIQ9nKUpLVo9rd4+Wmo9I7AE6xlTxPipa525JmqYpILRuMCfXDg
         xb46V1Oj5c/jILpqWlyEcJIxhu4ZYv5wy7I2oDy1/cEO3mfSTybGqZnxu0tMnxUCV+Q0
         3XZDXyVppI1HIo0ody3Tl3XW1gTGv/7A53KnpfbKW38NWqrHLRlvuv0PfjJZMfYcHRTV
         y68fTazD6X1hPDBsyiVfsJ0Ua6UgdMaB3ECokvJKAK8VGtg1TdEC89FpAjFV3Kw2R0/r
         wdrI/RW2ElcngO58GNjd/W1dWXhXiku2s0AIfr7RI1zg47/asuFPe8iYLMUi5iMQF2zM
         SVpw==
X-Gm-Message-State: AOAM531LdSAZEmBPUmIh/3KdOcclHzvmK0rgxfJ2u5CkWCNB3FeRb8/F
        FMCZFkAI+I7vddTu5iCJOKTTDmvhPQRvzUn8
X-Google-Smtp-Source: ABdhPJxMrkN31bYOFPEuXW/tbsEz7grO3AdD/4DGcrWS9NdbRHuBFmdJf+xvZJ+svw2AookKo/QTRg==
X-Received: by 2002:a05:6a00:24cd:b0:49f:bf3f:c42c with SMTP id d13-20020a056a0024cd00b0049fbf3fc42cmr42245005pfv.54.1637568531825;
        Mon, 22 Nov 2021 00:08:51 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.102])
        by smtp.gmail.com with ESMTPSA id f185sm7512990pfg.39.2021.11.22.00.08.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Nov 2021 00:08:51 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, congdanhqx@gmail.com, gitster@pobox.com,
        peff@peff.net, Teng Long <dyroneteng@gmail.com>
Subject: [PATCH v3 0/1] ls-tree.c: support `--oid-only` option
Date:   Mon, 22 Nov 2021 16:07:27 +0800
Message-Id: <cover.1637567328.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.1.10.g438dd9044d.dirty
In-Reply-To: <cover.1637321601.git.dyroneteng@gmail.com> 
References: <cover.1637321601.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Diffs from previous patch:

      1. Remove "Reviewed-by" headers in commit message.
      2. Optimize option descriptions in Doc.
         (Ævar Arnfjörð Bjarmason' advice)
      3. Optimize and bugfix in "t3104".
      	 (Ævar Arnfjörð Bjarmason' advice)
      4. The formatting problems of line wrappers (over 79 col)

All the advices are from Ævar Arnfjörð Bjarmason and Junio C Hamano,
thank you very much.

Althought some advices are apply in this path, but some questions
remains, they are in link [1].

[1] https://public-inbox.org/git/20211122074538.87255-1-dyroneteng@gmail.com/

Teng Long (1):
  ls-tree.c: support `--oid-only` option for "git-ls-tree"

 Documentation/git-ls-tree.txt |  8 +++++--
 builtin/ls-tree.c             | 27 ++++++++++++++++-------
 t/t3104-ls-tree-oid.sh        | 40 +++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 10 deletions(-)
 create mode 100755 t/t3104-ls-tree-oid.sh

Range-diff against v2:
1:  8b68568d6c ! 1:  6c15b4c176 ls-tree.c: support `--oid-only` option for "git-ls-tree"
    @@ Commit message
         only print out the OID of the object. `--oid-only` and `--name-only`
         are mutually exclusive in use.
     
    -    Reviewed-by: Jeff King <peff@peff.net>
    -    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    -    Reviewed-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
     
      ## Documentation/git-ls-tree.txt ##
-- 
2.33.1.10.g438dd9044d.dirty

