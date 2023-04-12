Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11B3C7619A
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 22:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjDLWUc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 18:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjDLWU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 18:20:26 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F0E658E
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 15:20:23 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-54c12009c30so354177847b3.9
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 15:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681338022; x=1683930022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Op2dNgfz2LJJmlQ7oVycm1fitJJMjgLuH55iEowcxig=;
        b=q0NAle4Q5XTmU+VOLFf/Ml7NH/+y+MUu+ZU/ACjyeJ+TDZxcAZ7HPWrsImiugqriRJ
         VV2lfyNmMbkLwhMO4viHhSRIxyyoc2cy14SvLNpx/q9MRMOcZHV10t5MNU19LDwTKiD4
         IkZxPUeDg36Y4dgIOey6uIFrcWW5+VMdpjnvvbqqI9ZiUgUOW4I6jgamzCb7j/qT1b9D
         5jfAzA7hgfItmxHa1UoypKBMFyKTTVUgdegZRXmqbN2ZcuSaAFNp7sIO/QBSNzRb84hE
         UDXNLZ1adOQU/aRqq1lFB2qNILiWFhWVvC1z2n4/8PMLxx6udr1+Q+a+/XgBqMfTyWo3
         lwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681338022; x=1683930022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Op2dNgfz2LJJmlQ7oVycm1fitJJMjgLuH55iEowcxig=;
        b=IGUk5YpTXtf/Ut8D11wGmukdkZFFzu5u+U1yx9g1AFRzRm55rI1m147ciMQj21ss2m
         CLI/k0l7hKYt5wI5/v/FFRLRaTZN/HuryEBe7CmHV4ZH+SDJihOvwYp2Yvv9TuH0476E
         3kXrpxXoJ5R6Z+kyluVFrRp7dBvcABvrNgu03JIINR6rTvVxEzQOB+fvCWYWuQ5AFr3b
         jVX3GpywU7CMduF+nApt/UtGDjygjzzBq6R17szodd5XQZcU/2CLdyG5gX31dbniFso3
         zmiJzLZYeZRRC5iz29ciG7uOLW6lOI7BLvyaSB8A2LckBZgIh7a+Ot991aKhhAeFSYDg
         aOHA==
X-Gm-Message-State: AAQBX9f5dmaMj1vLno8wIAV//E6YvL8hzwKtruxTzkWSq71CiL8laOpU
        kdd+KjYBEenWKN5pO4Dycj4vlivQf92PQ0CTiiKTMA==
X-Google-Smtp-Source: AKy350aFRipSLOHlfJiHKVJlY4mmHXI587INuYu1dCdN1Z0Zb+igpcKk2TRkRZIfL0LFDtYypf8Now==
X-Received: by 2002:a0d:d607:0:b0:54e:d7f3:2be0 with SMTP id y7-20020a0dd607000000b0054ed7f32be0mr147112ywd.12.1681338022461;
        Wed, 12 Apr 2023 15:20:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f69-20020a81a848000000b00545a08184c9sm13879ywh.89.2023.04.12.15.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 15:20:22 -0700 (PDT)
Date:   Wed, 12 Apr 2023 18:20:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/7] t5325: mark as leak-free
Message-ID: <affb5e2574bc1072d8f4ab8e3dccde7a5a39e725.1681338013.git.me@ttaylorr.com>
References: <cover.1681166596.git.me@ttaylorr.com>
 <cover.1681338013.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681338013.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test is leak-free as of the previous commit, so let's mark it as
such to ensure we don't regress and introduce a leak in the future.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5325-reverse-index.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t5325-reverse-index.sh b/t/t5325-reverse-index.sh
index d042d26f2b3..48c14d85764 100755
--- a/t/t5325-reverse-index.sh
+++ b/t/t5325-reverse-index.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='on-disk reverse index'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # The below tests want control over the 'pack.writeReverseIndex' setting
-- 
2.40.0.323.gedff6a80c63

