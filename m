Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F2BE1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 18:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751366AbeCNSmx (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 14:42:53 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41400 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbeCNSmw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 14:42:52 -0400
Received: by mail-pf0-f195.google.com with SMTP id f80so1785324pfa.8
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 11:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=o1j26z+UGBS4snHdZ+Gke25WquXDMjR1NYShpTODmDc=;
        b=deBKNxQSD18F/3vNDbIbiNX6cwHCdsmQ3s5zx5ts5wzCILtO5PtV3qe9m/8jau1VRQ
         iz+Ffy/MUsxkhkpo1NwluTqjCN6ADv/D0hnNY8J7jX3O6VZJpW0egwUNSug1FDf7UPeA
         AHg+YC9o5tB41+2ywcb05wkUOISpZYBytiu8en6Lq0DAy+3qMM4Aa9YseFiTzfDjfS8b
         DsVKEK/JB6KVtFc97gypaDj0eqfjcD2bpheFn2SNfjxFGVuINxe2jnvfENDKfmjzGd8W
         Ik8kY1bW5MAFxMZXthAJlsOZhc1204P9rEkxpkuvdEAK2cezTxldzHu0KRISZzUVnQQg
         BpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o1j26z+UGBS4snHdZ+Gke25WquXDMjR1NYShpTODmDc=;
        b=V2woBlDnvG4STDZIz6SRbKV3qfvkMlaQ+zcyBGirsaDP2FndbuLxt3LSsehaFSXBNu
         NWjxsaPfSH6h195jXnE8mCkt8eHsiWCbgzxRkuBoEl2/PiAhnABnAurhwaOx+YMrtpNF
         rRSJ5AdIK0nLPAr5tdoxn9iFl4xINUj3HZNxDmH1Zm6GKcoqa7vkHI+6MYDIfmjKEtEU
         PhYyQsAz0rGGk3THICi7vik5xUpzvYSWz5jLFGVEI1jdXcCHU+XHpj1Wu2tWiABEsq7v
         vqoU6WcpzX0Hj76nl8z872nvz8Av44JJWTryL/Z1UWu+UIsioFQDM3PZK4NakaCiQKmK
         8Img==
X-Gm-Message-State: AElRT7E2OZFdTXeqVkrF07ehiFYRAuE8AtTBvCBBOxQ3Dn7I8H6TyLA3
        eE2ByJDUOS5NV+Ns4xZZPVt1VSZs1cc=
X-Google-Smtp-Source: AG47ELtUpQ7GP1VJJQetjI1woWyXSZWKzipEEimMDZLSdCKeiC13Y1rKsGIX8mTNxZbPEMPBgaDbBA==
X-Received: by 10.101.74.77 with SMTP id a13mr1522148pgu.32.1521052971557;
        Wed, 14 Mar 2018 11:42:51 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id l22sm6255351pfj.98.2018.03.14.11.42.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Mar 2018 11:42:50 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 0/2] Make partial clone/fetch work when transfer.fsckobjects=1
Date:   Wed, 14 Mar 2018 11:42:39 -0700
Message-Id: <cover.1521052825.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.16.2.520.gd0db9edba.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of my colleagues noticed that we obtain a "fatal: did not receive
expected object" error when partial-cloning (that is, with --filter set)
if transfer.fsckobjects is true. Here's a fix for that.

Jonathan Tan (2):
  index-pack: support checking objects but not links
  fetch-pack: do not check links for partial fetch

 Documentation/git-index-pack.txt |  3 +++
 builtin/index-pack.c             |  6 ++++--
 fetch-pack.c                     | 13 +++++++++++--
 t/t5302-pack-index.sh            |  5 +++++
 t/t5616-partial-clone.sh         | 11 +++++++++++
 5 files changed, 34 insertions(+), 4 deletions(-)

-- 
2.16.2.520.gd0db9edba.dirty

