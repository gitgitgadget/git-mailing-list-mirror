Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FF1ECAAD2
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 07:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245168AbiHZHJY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 03:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244943AbiHZHJX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 03:09:23 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33469D2B02
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 00:09:21 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id f12so691588plb.11
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 00:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=4zSnk0KsVijcG2U1nlcVmLdVYdKl5uJu+1cxq5RUs8Y=;
        b=INUvQubWyTzI/G+eGwgA6Ws35NGQtF0GAOvh91lRz3uTBlvbuYAofr6Ay5r8JbjqJS
         xPrhGfOU49tDeTAM+QLmKP29y88LhGIcdgZOGRWxZ5E/9Z2HDJGgs8ETFW7JIUc1Jh5V
         er6ZOKwqI4e8PWUoC3OJCD3Wbgx0UsNhDkJ0FiHY5RVX7/uvaoJ3dWoGAdXba4hKjNds
         egzRh3+uKIlgjWlGC9Metm8Zi5YbjSvrrwcSHnOj40QMZ4gySHuwaFPtY87Fh4jUhofu
         rMl8v/HksFOlHeyQr3L96ykXPEcYw9LOHOfbpPHmwghPWTnlAWnpGK9O0sJ5yzUu1t6g
         FnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=4zSnk0KsVijcG2U1nlcVmLdVYdKl5uJu+1cxq5RUs8Y=;
        b=pb43MyyY6ORt180Dv3MHlzQPJ6BHQzXKB2gCoHMz0PHu1Mcd6sfbNSZ0lOk2xiHvo7
         c0kckxoSy4hbsywAbRZhmsvSDlNfBnTqlUCSNsLBtCbGZmb7CpOND+TK5mpouAIQD3Ib
         dSlKTM3066PFr3YDdHgBVSVWA4d/RKTVoi4J0DLW0qsJDksmylJGkPTrT7Ev85ie28Qs
         xIo47l4167LaaujFDpw7h+8Hue4ye0A2+SXbgMO4nLKw+MYs2zPFOB5FKhI4jI7hrSsz
         RkpDiQYXxV7CcQZRZPe14HP920W3hgYKLI1kjeJMpBTs7HJ1m0IzrCtYxEChvvQEtApY
         +5Qw==
X-Gm-Message-State: ACgBeo1+guv2V5BZYzemLerBHKVp6Nl+fGQspjCeR1O8dbsQW/B7J30r
        tNJjb2mBgdKkszJrkht/mtEyy22HHzqrJWa3
X-Google-Smtp-Source: AA6agR5aokUE2cR1ow3BHIkJQODkRjlp3JX34cMl/g5d4xugJoXO4UGmaoCvqal9zavJ5M7WkW/czg==
X-Received: by 2002:a17:902:e849:b0:16e:81c6:2cb7 with SMTP id t9-20020a170902e84900b0016e81c62cb7mr2558382plg.110.1661497760563;
        Fri, 26 Aug 2022 00:09:20 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.43])
        by smtp.gmail.com with ESMTPSA id t12-20020a62d14c000000b0052f3a7bc29fsm866930pfl.202.2022.08.26.00.09.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Aug 2022 00:09:20 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, derrickstolee@github.com,
        me@ttaylorr.com, tenglong.tl@alibaba-inc.com,
        Teng Long <dyroneteng@gmail.com>
Subject: [PATCH 0/1] pack-bitmap.c: avoid exposing absolute paths
Date:   Fri, 26 Aug 2022 15:09:11 +0800
Message-Id: <20220826070912.70274-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.581.g7a5d018042
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch tries to avoid the problem of leaking sensitive information that
could output the absolute path of the repository when try to open multiple
bitmaps. For example, in "alternates" scenario, where the repository
"alternate_repo" serves as alternate object stores for repository
"want_to_borrow" , and each of both has it's own bitmap file, then we run
`git rev-list --use-bitmap-index HEAD`, the output might be:

  $ cd want_to_borrow.git
  $ git rev-list --test-bitmap HEAD
  warning: ignoring extra bitmap file: /Users/tenglong.tl/Downloads/alternate_repo.git/.git/objects/pack/pack-bff67e2a7a154e6933afe61b3681726cf9bd8e8b.pack
  Bitmap v1 test (1 entries loaded)
  Found bitmap for 30f146d41a7a86930fae3f4a5e1f1c1f2bfacbba. 64 bits / 11030517 checksum
  Verifying bitmap entries: 100% (3/3), done.
  OK!

After apply this patch:

  $ git rev-list --test-bitmap HEAD
  warning: ignoring extra bitmap files
  Bitmap v1 test (1 entries loaded)
  Found bitmap for 30f146d41a7a86930fae3f4a5e1f1c1f2bfacbba. 64 bits / 11030517 checksum
  Verifying bitmap entries: 100% (3/3), done.
  OK!

Thanks.

Teng Long (1):
  pack-bitmap.c: avoid exposing absolute paths

 pack-bitmap.c                 | 8 ++++----
 t/t5310-pack-bitmaps.sh       | 2 +-
 t/t5326-multi-pack-bitmaps.sh | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.37.2.1.g1591e7ee52e

