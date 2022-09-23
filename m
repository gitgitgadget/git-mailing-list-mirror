Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC917C04A95
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 18:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbiIWS2y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 14:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIWS2w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 14:28:52 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6230123845
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 11:28:51 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id p3so568436iof.13
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 11:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=WywelfVhfUnS50iBI3TfDpZ1jeaVoGwz3xL7+OiJLio=;
        b=vGGQ77U+3qwuzZSyjUNAfb4AlF5yu8FoFuF1lJQpGxe5+TJeUsKc6ZgO5HfSobHGSH
         bDTT6a3QnjXzv7SDmU6YJqqvws9Lvxnou71bjIOCENn4ni+3KwmzGdcOjaIlNLaBTgFw
         TQ09+9Su8CvkGx3cPoNOLgbkpnDIzteAEpz4QVKECJaFc5o5cjB0PKCf/SWsIu1bOM8l
         F3CecycXzc9744Hz6yAmiR7VzqHWS95IMVrn9tQ/eancpoJBIRNxZlUKnOSljlgkBnI+
         zvG97D48UnyKbE53LZ7cO6zHQBA//RuegYz4UvLjH/2UOYfS8gB4khXemT/Oymi8aE64
         aaOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=WywelfVhfUnS50iBI3TfDpZ1jeaVoGwz3xL7+OiJLio=;
        b=DP6j2GPIxwi7QVMHjrsKrLNtNbe5w96fvP0ruABDjU2z0LLDuoPj4f5rzJzCeBvdIi
         MgZBbAtS2oeOrdHYBwZSZ7EjAuI9wCQlgCLU4fk9e4hvBRxwQmHbapp1bKhPm7vA/FBG
         2yv8Kuy7WK6FkfQW6FacqctAV+8wT1phTQcmMZu1e/P4N4WYIh+oADja72aRhRcx01oL
         bimFbYDog/XHXvL8yF6g6+ymZXakdFL1JbBDX9VmFwOKkaEQql9oJgMqtdO/b4Nyo5c0
         ihRKu0P101v+7WeC5X2QwhmUNBpSf1T7O+GUBNK4zSm1gAXhT3MyQMTois7TrHTG9qdx
         hH+A==
X-Gm-Message-State: ACrzQf12clMo2hLQvC0NWko2hA5LMaVgz82j2b07tRZv/f/SsF436XCT
        a1X+IShPKUw9YxgZZpjV8eqv2A==
X-Google-Smtp-Source: AMsMyM7cFVf/kBXVtpH6SEWqzSnW9rSrxFJYMTa+ysxHYSzIopg0Qu80G2HYbTfVF12kW+Z0u5HGJA==
X-Received: by 2002:a02:93c7:0:b0:35a:3271:1c83 with SMTP id z65-20020a0293c7000000b0035a32711c83mr5536153jah.105.1663957731230;
        Fri, 23 Sep 2022 11:28:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 125-20020a020a83000000b0035a216fc475sm3670848jaw.163.2022.09.23.11.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 11:28:50 -0700 (PDT)
Date:   Fri, 23 Sep 2022 14:28:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v2 2/3] midx.c: use `pack-objects --stdin-packs` when
 repacking
Message-ID: <Yy364WAutGIdXCub@nand.local>
References: <YyokIf%2FSd7SYztKQ@nand.local>
 <cover.1663706401.git.me@ttaylorr.com>
 <4218d9e08aba629d8f64b5a999f60d12e5d8785b.1663706401.git.me@ttaylorr.com>
 <5172dbb7-61d1-7249-f9bb-d760e6f4450a@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5172dbb7-61d1-7249-f9bb-d760e6f4450a@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 23, 2022 at 02:23:30PM -0400, Derrick Stolee wrote:
> Do you know if there is any reason to do this explicitly? Does this
> change the set of objects in any way (perhaps by not including
> duplicates that are tracked in those other packs)?

Yes. The "^" lines become excluded packs from the perspective of the
follow-on reachability traversal to discover the namehashes. So as soon
as we hit an object contained in one of the packs marked as excluded,
we'll halt the traversal along that direction, since we know that we're
not going to pick up any objects in those packs.

So you could omit them, and you'd get the same resulting pack, but it
would take longer to generate since we wouldn't be stopping the
follow-on traversal as early as possible.

Thanks,
Taylor
