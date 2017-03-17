Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D44220951
	for <e@80x24.org>; Fri, 17 Mar 2017 23:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751129AbdCQXne (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 19:43:34 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34734 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbdCQXnd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 19:43:33 -0400
Received: by mail-pg0-f68.google.com with SMTP id b5so11846481pgg.1
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 16:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kmyqTB9PLSKrccY5r13HhIxMj2bd59tXzIfOwBHZIlM=;
        b=rRW050T9EdFQon561e/k9GJPjk57mwePi5M18FxFj5yl1oLYrQwW9tKorX11QlIaNG
         Wl+XH9NvUvDP+P+5yMAAKKNts63+5ymDhVvhR/MRC1cUcacs6+q3MfDrptEtY/7Nk2b5
         +DYuj6rm5uZxuWuKJqa54d5AFUpmfCPc0pkrh/zVROCbxccTk0VoHxRlyakD95r8KS0L
         ncLzXnxIOBVOldcRuriUL5iYLc4xQxP0D6u43NKc1OFcHLrt6f8GCu+CcgWe9aISYOYo
         3nJWiwecNa2xEpfwGUcfUh0QBM52Z5itw1K+nT7IQths5gx8srgScZJ9YviMGuKJWCk1
         GWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kmyqTB9PLSKrccY5r13HhIxMj2bd59tXzIfOwBHZIlM=;
        b=RxiyKFOEBZoozdjMStSCXaGMZDbId/9J9T316mGNcQSQmsWe8hzizpridcoojzaAEW
         z78zx/KZSNGy/iDDN/BAHb3GQch0EoFcLbpaqy3bUieUPkmoZG8JK59b+gxYRFO04kWc
         pERsmv5hgdd8vtEYrPO95hFw2LIxYubrayhIJ33l4zuPBS6ZNuFkWFhAXIzonGUBo/6C
         MLkWV6B1cQue+5gH96YEwXAEdyNTk24GCA2IEiQqDTivWsipehGYo0v1U+cIbT88PwdQ
         CBvvSPszwAES18FT/rZbnJxsDBLfx1ZpipiDLgUWAsMdoieWRq3o5ISx43Cx/sKxgB/b
         7xoQ==
X-Gm-Message-State: AFeK/H1sYfOne7ciqtbp5kCGNB314q3/2OkFft6us6o3O6Yc8/8VpnHJ3zQfIPhVV747mA==
X-Received: by 10.98.14.140 with SMTP id 12mr13439813pfo.77.1489794137988;
        Fri, 17 Mar 2017 16:42:17 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:cc9f:ca23:5f26:6394])
        by smtp.gmail.com with ESMTPSA id s13sm18840202pfk.26.2017.03.17.16.42.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 16:42:17 -0700 (PDT)
Date:   Fri, 17 Mar 2017 16:42:15 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] run-command: fix segfault when cleaning forked async
 process
Message-ID: <20170317234215.GT26789@aiede.mtv.corp.google.com>
References: <20170317232004.xqs5f2q2swa3b5bq@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170317232004.xqs5f2q2swa3b5bq@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> Reported-by: Brandon Williams <bmwill@google.com>
> Signed-off-by: Jeff King <peff@peff.net>

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
