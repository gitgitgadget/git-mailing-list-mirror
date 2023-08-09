Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0444DC001E0
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 20:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbjHIUck (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 16:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjHIUcj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 16:32:39 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86772108
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 13:32:38 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-583b0637c04so3051707b3.1
        for <git@vger.kernel.org>; Wed, 09 Aug 2023 13:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691613158; x=1692217958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fjAuA6He4govPEOzCLTdZnB7V/vPPVoXAhnFGIohwuY=;
        b=iKVfzYGa6LopJJTp/TOt4tBVzT/jMS/TZB0sfEOmOM3qGl1RqrQI8zvZcwjYj9o/0R
         z+SeVxtERaVwhU273nDFtSZeQagDdSyPk9BAT8tt7j5UiTQHn72kDcesmq2avZrMKoNe
         +rTu1vSdRJ2l9Tpf3odL+OdwvTpi66c/UxKFALvhVr61gbrzk+VNWgiPBBYbHAZMTpYL
         hIjvCJOwWYNYWu7k8wR2K0DTJ2Zr6K7L/Mj/8KKD93FinsZgr5ijVmzCWdBILir6o1pH
         sO0+YZ4M2TS73y9oG49IWx0R68AA3drbbrqjfB+n7A4meQIt8zc7K6wh7pGy3S8EvfEX
         D9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691613158; x=1692217958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjAuA6He4govPEOzCLTdZnB7V/vPPVoXAhnFGIohwuY=;
        b=cmsFSElDZplD+yI/nfVzHkZm13Kg24Hy2VH+15mNVIBPHc4sJwlivnFd1H4DYO1AuI
         WXo1AHfb2/dL5fU6PwK+9cpi/4pYlbDrP0WaPjruaarZPICUCw5t5BTpcAhPEeiC+vyY
         ePe4UThT7UtYTxnPjmCtrlxYUDbB5BbboPt2XKXazKp4QMRuwIJYEapXc9AvReNpjZOQ
         D93A+Z5XlueQX4EaolwhWVeHNAHirlIPkcX+pf+5+ntBubDyNalBwbi+TNTU57P1bg2w
         bLsMOnoldXdlwNqPnQc1TAfPxoaWb4OH7UYHa4xWgqsZkzxV0hyr7Xja3uroWbYqxwW/
         YmEQ==
X-Gm-Message-State: AOJu0Yzt5diPf1SdsHOGBEDtDOoYxgo5caZCaD9nkQoi/dRAujlVcbZ5
        XPx3J+LnkeyTQ41ecII8/EHiVbxWSi1UrNEEWCFmUA==
X-Google-Smtp-Source: AGHT+IH5S7HbYFY/hooKDEl8X/8AXRxVESwaL8LKGV0dlyUKK7//SDE0KTTfEL+tMs53dS8isXUEcQ==
X-Received: by 2002:a0d:df8a:0:b0:583:821b:603a with SMTP id i132-20020a0ddf8a000000b00583821b603amr614058ywe.20.1691613158024;
        Wed, 09 Aug 2023 13:32:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k188-20020a816fc5000000b0058461c9524fsm4213523ywc.12.2023.08.09.13.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 13:32:37 -0700 (PDT)
Date:   Wed, 9 Aug 2023 16:32:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 0/2] repack: prevent geometry struct leak
Message-ID: <cover.1691613149.git.me@ttaylorr.com>
References: <20230808211759.GA322409@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230808211759.GA322409@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This short series combines a patch from Peff and a patch from me to
prevent leaking the 'struct pack_geometry *' pointer from the repack
code.

The first patch free()s the heap-allocated struct, and the second
patch moves the variable to be allocated on the stack.

Jeff King (1):
  repack: free geometry struct

Taylor Blau (1):
  repack: move `pack_geometry` struct to the stack

 builtin/repack.c | 66 +++++++++++++++++++++++-------------------------
 1 file changed, 32 insertions(+), 34 deletions(-)

-- 
2.42.0.rc0.27.g2e2a760381
