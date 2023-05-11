Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA3CC77B7C
	for <git@archiver.kernel.org>; Thu, 11 May 2023 16:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238697AbjEKQQx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 12:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238664AbjEKQQw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 12:16:52 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96E25255
        for <git@vger.kernel.org>; Thu, 11 May 2023 09:16:44 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-559f1819c5dso133108797b3.0
        for <git@vger.kernel.org>; Thu, 11 May 2023 09:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683821804; x=1686413804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/oBL/9i3+IWsZ9jjBvOfHxikmhC9wpcungLmJuFrJOo=;
        b=cS9JSrW7V3DpK6JbzvJtvupyIEQrjODA574AquiBLXyOEccAy98w//o+/PNxlX3xCx
         kzWb9NDJxtcRO9Gai+B5dNvjzkDha0P55sBQQUGXgD6Proc6uodKGx6CQ8UmcTyOrPYQ
         iteMonEXlr9zlM/mnk2PBGGa2O48PLpa0FpQkH5GH5WxKmukptELqNRa/gofSiiBrR+3
         5hGPy52EUiIbP5g7mBZ5G93/QNCUNeHjqGWRBxOgosNbB2S82EKYJ2WPhUsLs7WmMHrN
         7ABaonetdqhpnw6yKHgy20bY2Pqd4y9/ih3at67V6uRV6owustwuM3KQ+FmPymdduKMg
         9v2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683821804; x=1686413804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oBL/9i3+IWsZ9jjBvOfHxikmhC9wpcungLmJuFrJOo=;
        b=ZBqEyTrRyFQRQ0c0e4nPYIZZzpwprZn/AGWA+PFVW302+ykzC3CWpLLNIbJAi2GkYK
         Uu2atfJEhHX0DN+RANHnPish9bxCX+C3I2JMEaweDy0X/AJ2laFltjeduIYeVavEcb2/
         G3NNnc4EwkjyOrP1ggw0IEYlDc28r5mZXrQ8EZL7z1USl1S+MdhQRxjqaD7ZNek7F1pt
         6ERMhw8Yv2ckD7CEfJePexRFZS9YtefuOx9snzQuoAbzacopLyUBxo+3p9huAfsTDcGI
         3Kv27dJN+0f9kI8kWxt0kkXu0hFFScKM6mfYL7VxgBWGXWy4Q2dJaNSO2HD1BgEZwHqG
         5XaA==
X-Gm-Message-State: AC+VfDwncEHDx8m2gd2ewF2VqHoS5aKwzeWANy1L8BbE1lUiO8+9vSje
        K+K3L2jwf2bwnOe+A4exzqEIQcHLQSJi6gOZNcppRQ==
X-Google-Smtp-Source: ACHHUZ4wIxnbeHYjYLqfr5syBN0sd4imlGIwQeqes7rGYhV24d9z/LbzxV4Bj0FjPATV+WXcLsdXwQ==
X-Received: by 2002:a0d:e696:0:b0:55a:2d2b:cdf0 with SMTP id p144-20020a0de696000000b0055a2d2bcdf0mr22491665ywe.8.1683821803765;
        Thu, 11 May 2023 09:16:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m188-20020a0de3c5000000b00560c648ef1esm2033801ywe.72.2023.05.11.09.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 09:16:43 -0700 (PDT)
Date:   Thu, 11 May 2023 12:16:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Christopher Fretz <cfretz@icloud.com>, git@vger.kernel.org
Subject: Re: git rebase --root bug
Message-ID: <ZF0U6tneDjLfGxf1@nand.local>
References: <5E3AD305-8461-496F-B165-7734D400C4A6@icloud.com>
 <288a9935-264b-4dc5-0d63-200c310f326e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <288a9935-264b-4dc5-0d63-200c310f326e@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2023 at 03:21:11PM +0100, Phillip Wood wrote:
> The cause of the problem is that --root creates an empty commit (known as
> "squash_onto" in the code) which it uses as the "onto" commit. When it picks
> the first commit in the todo list the "onto" commit is amended and so is
> unreachable when the reflog is expired above. I think the best fix would be
> to stop pretending that we have a real "onto" commit when --root is used
> without --onto and either store "new root" .git/rebase-merge/onto or not
> create that file at all.

Wouldn't it suffice to consider the squash_onto commit as reachable the
same way we do for `--indexed-objects`?

Thanks,
Taylor
