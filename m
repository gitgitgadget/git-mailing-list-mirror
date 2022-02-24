Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E805DC433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 22:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbiBXWv2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 17:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiBXWv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 17:51:27 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1435A125CA2
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 14:50:57 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id c14so4527149ioa.12
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 14:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z22cDnKsxGRmoKInHqTUcOlxPUVq+Bf8raZKdWgtdlY=;
        b=uNeSfAZ1P2awpUzppJq/AhmhCKis2epTUU2SokKnpOnmDY/bPONYjY36/lkQYOsYk1
         dnFD6DnurzLHc6rvpcB9XKH5VRpp/53l0trw7afqPOoTSFf8ORiP4uh1lbTnHE8GGyBw
         Id59m3WSxziHVVWR2Z4Y6K0DmemPSh10Tetc4wRj5c7PLqytyPI9ksJ5P/HTcXLDq9YQ
         EtBNtbDokO1L9CoRImU2aNqld37XoRpVJ4hcEy5Xl440Zl7K+vqS/tJ/VScjge/hOQaj
         Ah8MnS7z4rk6X6uD3stXMjuxUGR3equo2BWjaHsGkX84jWw8AN6cUAyULSwGOg/w23MF
         KALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z22cDnKsxGRmoKInHqTUcOlxPUVq+Bf8raZKdWgtdlY=;
        b=aby/0/CGgBwIgr59g8tLazkGpY/a9i7ulcMPuC3JpufRZrDwLmu8waTz4Hyvn+bdRt
         qFHVDd/2lUrQ8K6bYr5wvLp3bsCKfz0T0LmkSUnvHsMQEshuCQ8MFl1E2nJmav9TdN0M
         Dwz+PkYHigO46tZsPlb1TRsrKYZo23qIXCCBC3wv6HuNSwrTpC4o4EJtn1YIYUcdMdCq
         QFRJTiUsT+cJRQsh4Ege556NqG2Ii3LE2BzW36rjcXYXR2sTMYDq2MSxuYZPK+lswQoG
         o6D/z9uIQamYLsMQfQ20qnlfHh3hGNaT9h4QRPkQtkUzA3zXV3EzEXZuJq2jLAyddeNZ
         WL4w==
X-Gm-Message-State: AOAM530GFGgU+oiX2smtvCJRklkuA+6pJQOMpZzb2rd/1ScR5HgGcJ/s
        8EsOxohpFWUeZv/1BPDV+enGBQ==
X-Google-Smtp-Source: ABdhPJy/VYdTyVuIwhB/vBeX7Kg/x3k0cqF598a/UfRFaWmQgF3E9ALQKlOQz3P7kGjMJxQsY1OWoQ==
X-Received: by 2002:a05:6638:2388:b0:311:d1bb:ed46 with SMTP id q8-20020a056638238800b00311d1bbed46mr3741624jat.212.1645743056448;
        Thu, 24 Feb 2022 14:50:56 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g5-20020a92c7c5000000b002b864923195sm527765ilk.62.2022.02.24.14.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 14:50:56 -0800 (PST)
Date:   Thu, 24 Feb 2022 17:50:55 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     me@ttaylorr.com, avarab@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, stolee@gmail.com
Subject: Re: [PATCH v4 0/9] midx: prevent bitmap corruption when permuting
 pack order
Message-ID: <YhgLz5tAgLYLMPks@nand.local>
References: <YfGuC0wowQnYi/Eq@nand.local>
 <20220127171509.3073226-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220127171509.3073226-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 27, 2022 at 09:15:09AM -0800, Jonathan Tan wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> > Could I get an ACK from either Stolee or Jonathan Tan that this version
> > looks OK?
>
> I think Stolee has already given his ACK [1]. Here's my ACK:
>
> Reviewed-by: Jonathan Tan <jonathantanmy@google.com>

Thanks, both. Junio picked this up via f2cb46a6b3 (Merge branch
'tb/midx-bitmap-corruption-fix', 2022-02-16), which is on master.

Hopefully this is the last that any of us will have to think about this
bug ;-).

> [1] https://lore.kernel.org/git/8842fdd9-438d-43dc-b7b5-0d6bb456e313@gmail.com/

Thanks,
Taylor
