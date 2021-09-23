Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60C1C433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 20:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE9296124E
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 20:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243100AbhIWUec (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 16:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242950AbhIWUec (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 16:34:32 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746E4C061756
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 13:33:00 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id q14so8003702ils.5
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 13:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QYGYwjBaxSCA1C1e08HegmNUjSO9ejenhLI64ldmBmA=;
        b=StoEgs6JTIEMDYTfXoBOzr4daqBE6rTxacpbXIj07DzMBwxZCPyEbtWNX7Vh+4xJaw
         7dUKnFHGngGNejfxKekD5P4F20FSb4ZG6D8JgEMJcl7oNnP0qBJw2NRIy5y+obXJfOim
         fMrBslyeYHg9ySftWBEs+J+pYClEZlIXhtg6RyGBM8QpKjSVnDyNnW9COdgkEtEdhbDO
         ke/gW46eF5FWAQqt43A43hdnvKTM11vshZ4/QMw7ZVM9FjEKtECPfq/2bMobWxpuOiR/
         z5p49bZ/gp/RB5MmByxrQJ1Y8f7Scz8B9TaIVDfsx3pOBukBVhqkJplhLpo/mE0Kwgh5
         lJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QYGYwjBaxSCA1C1e08HegmNUjSO9ejenhLI64ldmBmA=;
        b=y44s3Rp6M2X3299TKaGEqxhiq4K4NdBDWSbcrxFUmIEENh9aJa8A1sWsfJ7hx+G1G6
         hdVK4bEnyVZ436gSc5jgTMMwWo4iYthssdXxb4G9euqwJZvgUWcnDwpYXBkFhq6lYBpO
         VtutT5/7Y0lMLdg/pnU22bRlOqOTmfFYv3QlPtinhDmEfJ0dVJSymMoOXaXcNYK5MxzL
         zr4zeW9q6ZSNglHvcpWzF4NErkRjqoHsPTiqjKdcsnK3zIJjWg630ZIPc8ZNVv64Gqm9
         HNa/FcGT9WUXBf/D9TjkL/g/z1Buiy0+o/+0MbYv7MK7GkdBfvMY9zy/evSDck5SmYtU
         us+Q==
X-Gm-Message-State: AOAM530hpe3PZs+SYpmhKO07nhFbdXbB+jnst/lRSR3U8VZ4RSIhDRed
        LxJ/lxwz0KdZXiVfjWhfXbjw/S/Z2cbWAA==
X-Google-Smtp-Source: ABdhPJxPVhcUFg2rT56m7MWSM6sOIWPkMbcS60j5FPY9K6/l5d1f60LLakZHBIYNDk5XYbTp4Sbg8A==
X-Received: by 2002:a92:c98b:: with SMTP id y11mr5100410iln.205.1632429179833;
        Thu, 23 Sep 2021 13:32:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t10sm2864442iol.34.2021.09.23.13.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 13:32:59 -0700 (PDT)
Date:   Thu, 23 Sep 2021 16:32:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
        Eric Wong <e@80x24.org>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] doc/technical: remove outdated MIDX default note
Message-ID: <YUzketzIpMqI8wbE@nand.local>
References: <20210922221342.6867-1-e@80x24.org>
 <9ebb4c34-8cdd-3120-ff9a-0e47099c3cf6@gmail.com>
 <YUy9HzRgHU2zvI4P@nand.local>
 <xmqq8rznyr4c.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8rznyr4c.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 23, 2021 at 01:27:31PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Thu, Sep 23, 2021 at 09:47:03AM -0400, Derrick Stolee wrote:
> >> On 9/22/2021 6:13 PM, Eric Wong wrote:
> >> > Multi-pack-index files are used by default since
> >> > commit 18e449f86b74bab35b150549c8342d252fe7ae00, so the
> >> > outdated note was misleading.
> >>
> >> You are correct that the note is misleading, but it is still correct.
> >>
> >> A user can _disable_ reading MIDX files by setting core.multiPackIndex
> >> to false. If this was in the user-facing docs, not the technical docs,
> >> then I might push back on trying to make that distinction.
> >
> > It may present a fuller picture to instead say:
> >
> >   The core.multiPackIndex config setting must be on (which is the default)
> >   to consume MIDX files. Setting it to `false` prevents Git from reading a
> >   MIDX file, even if one exists.
>
> Do you want to replace the one-line sentence with that paragraph,
> instead of removing it, in a replacement patch?

That's what I was hoping for, and Eric did that here:

    https://lore.kernel.org/git/20210923201252.GA25980@dcvr/

Thanks,
Taylor
