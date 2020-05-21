Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE6EC433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 11:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB66A2072C
	for <git@archiver.kernel.org>; Thu, 21 May 2020 11:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwqv2Ugr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgEULVb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 07:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728887AbgEULVa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 07:21:30 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EC8C061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 04:21:29 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b6so6744402qkh.11
        for <git@vger.kernel.org>; Thu, 21 May 2020 04:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6IZdhoAnRCmj2zk7tLJX1BCQkilUXmijcNA79xfUwV8=;
        b=cwqv2UgrF0zGu64Ly/fNKZe0KjEmMT93NhEeVfDNfRkGn3N3o5O6gCGxV5SwSZEZXz
         xrqNzi+fxNZuRfPYkMVMuJzB0KPyjvm1IXoAvnYJvsq8KGq9dUwzXaIwl2+TQ1wxMaXg
         quZZFaltPR8zzGbn/QrRIrVrCHjQLplgbVA5eDnicXqN46urhelDwaNXQFT8rxdJDaij
         Mbh3O7nrmxdKVXylAoFZxyEqXVrqUu3e/yQgvYsDEFA+q0eO6GzGqe08tXkTGr0oMlSU
         wy+fNOs4F2+5jnqYHSuuzN2KhLOtbFsdT4K+BaGnaXaZHAcd1DfGHI3MUKoSz4P0ZNiR
         JYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6IZdhoAnRCmj2zk7tLJX1BCQkilUXmijcNA79xfUwV8=;
        b=J0h7a/rZ+08f/nNy4zfqu6dwiUrQ6PCkkOGwmhjWl1/8jvUc8LDqZY1zCU3WhzEWiR
         +qnxMw9kuZaHoQWs2nzO9HgWX1renas3p8h7gTqqHCiQHW1ddUhYptSkYrKDfwe5qx3c
         tnhDw4Arxigya7umhsH2O+v2c2xHATrCoBEixDbbg38YXoO+FL5K8Pzg6aJHaa57MqCm
         pS5xTfLHJNoq35OBAl24KBtqj5IxAlHbAzOl3PXSuMInMPtIl/2wdwYMx0EBk/iAmUwx
         EDN/R06rg0o61hdizIbXNLJ8oGldrmbW3z75sA/5MkNpE7T1zYmIFJ5cEnQPusN/S+OJ
         Fgww==
X-Gm-Message-State: AOAM532GbYEmFOwgN4/NVmn8N1XdUal49M0FtRpieYKHpzHWZTgIVOu+
        Ho0tb7utmOAs+gq7SnQnc933xxQZ
X-Google-Smtp-Source: ABdhPJw9lyXmBmwSDk9XGb2BBtNGO+fJ9Mz6oqESgVVcRb/ek6NmMZu5bz6UWJH/diZ19oaMGncmjw==
X-Received: by 2002:a37:27d6:: with SMTP id n205mr9509565qkn.149.1590060088514;
        Thu, 21 May 2020 04:21:28 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id v4sm4244127qkv.43.2020.05.21.04.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 04:21:27 -0700 (PDT)
Date:   Thu, 21 May 2020 07:21:25 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Jiuyang Xie <jiuyangxie@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jiuyang Xie <jiuyang.xjy@alibaba-inc.com>
Subject: Re: [PATCH v2] doc: fix wrong 4-byte length of pkt-line message
Message-ID: <20200521112125.GA581643@generichostname>
References: <20200521094454.GA577071@generichostname>
 <20200521104146.36729-1-jiuyang.xjy@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521104146.36729-1-jiuyang.xjy@alibaba-inc.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jiuyang,

Sorry, one more small typo.

On Thu, May 21, 2020 at 06:41:46PM +0800, Jiuyang Xie wrote:
> The first four bytes of the line, the pkt-len, indicates the total
> length of the pkt-line in hexadecimal. Fix wrong pkt-len headers of
> some pkt-line messages in `http-protocol.txt` and `pack-protocol.txt`.
> 
> Reviewd-by: Denton Liu <liu.denton@gmail.com>

s/Reviewd/Reviewed/

Thanks,

Denton

> Signed-off-by: Jiuyang Xie <jiuyang.xjy@alibaba-inc.com>
