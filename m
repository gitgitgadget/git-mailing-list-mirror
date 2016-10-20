Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D1851F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 21:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932211AbcJTVkJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 17:40:09 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36819 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753926AbcJTVkG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 17:40:06 -0400
Received: by mail-pf0-f171.google.com with SMTP id e6so43673821pfk.3
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 14:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uivnAb8p+jvjNFoa98LKOGyKFe3F/86nXmmQ8grhfKc=;
        b=OvCbaZb5LPNTBIjJpaupZ1Ey5dURmevZWVrNQno2f0rVPqarNCkmekDQ17EKGWAKB5
         BYmzejA2hnLzQm6LbJy9nGfeU30gQTVUD/E4Mwi7F86K25/dRn9qBZ/IRbnHbKicPs98
         6nlzdnZqJQGRkmGr9w+T6Ea1KeZbujCSDmPTBFd05CCRoZfd/MI40YEsHYnxOaAE3NEs
         WSUTO3ndEwmtfPV1b3YVjHEfcr3VhQE5Caqh8aSEgyVbWdY+yfplkcG60Z8n7U6jyVUh
         PPrIMOTwkhtYj+ohhAi2q6zPAD2wYfxqIIb6WkH96HF5EF/GrUEQ2vE8UuP9kerMTKXk
         dc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uivnAb8p+jvjNFoa98LKOGyKFe3F/86nXmmQ8grhfKc=;
        b=DmEhB1VOTd77pPJ4tY4qsclkVQyLNL5ahVAvIDaWWfEQe5ek/xlB5kPJDfOf0osvd4
         mSCt/O4h0xck6LsvGrxD4dJ2QnRSjOzxmx9IcEw9gMreRvFvG8NLAFaUiYnHCbcaxC2O
         j82kkuB3JlqJriQUVjVb9kgslzGmCqlK7O0+j57n7p6kEFJS/iIinZhnfc3a7Y3sCrEb
         +YgLVBhUNYf5UukEzlc4fIYsqdDO85hK0h0ZDvd+vvnNCHGDgzVP8wkHHV5zKFZdQyPU
         UbuqDbUmJ75NMdGHgU2f/Ig9bzoFeJNhT2jQjOj/xWXt7raCtI04m5GoGAImpNjiBHMY
         tHfQ==
X-Gm-Message-State: AA6/9RngYPeKCfJgray/DKV2T/keSnRvtES5QlrpApuidI2DmUDZQ91Lwm5Se4nRruIyL8Rr
X-Received: by 10.98.138.79 with SMTP id y76mr5109922pfd.158.1476999605012;
        Thu, 20 Oct 2016 14:40:05 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id e6sm73883890pfb.57.2016.10.20.14.39.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Oct 2016 14:40:04 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        sbeller@google.com, ramsay@ramsayjones.plus.com
Subject: [PATCH v4 0/8] allow non-trailers and multiple-line trailers
Date:   Thu, 20 Oct 2016 14:39:45 -0700
Message-Id: <cover.1476998988.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1476232683.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Main changes are:
 - implemented the previously discussed trailer block recognizing rule
   (recognized trailer + 25% trailers or 100% trailers)
 - forbidding leading whitespace in trailers to avoid false positives

Once the recognized trailer + 25% trailers rule is implemented,
implementing the 100% trailer rule gives us backwards compatibility and
is only a few lines of code, so I included it.

Summary of changes from v3:
 2/6->2/8:
   - squashed Ramsay Jones's "static" patch
 new->5/8:
   - new patch
 5/6->6/8:
   - new trailer block recognizing rule
   - reverted to the existing behavior of ignoring comments, since the
     number of trailers and non-trailers in the trailer block now
     matters more
 new->7/8:
   - new patch
 6/6->8/8:
   - updated trailer block recognizing code, since the continuation
     lines must not be counted if they follow a trailer line

Jonathan Tan (8):
  trailer: improve const correctness
  trailer: use list.h for doubly-linked list
  trailer: streamline trailer item create and add
  trailer: make args have their own struct
  trailer: clarify failure modes in parse_trailer
  trailer: allow non-trailers in trailer block
  trailer: forbid leading whitespace in trailers
  trailer: support values folded to multiple lines

 Documentation/git-interpret-trailers.txt |  14 +-
 t/t7513-interpret-trailers.sh            | 299 +++++++++++++++
 trailer.c                                | 619 +++++++++++++++++--------------
 3 files changed, 651 insertions(+), 281 deletions(-)

-- 
2.8.0.rc3.226.g39d4020

