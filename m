Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AE4C64EC4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 18:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjCIS0T (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 13:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjCIS0R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 13:26:17 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A4EF6384
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 10:26:16 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id b5so1080772iow.0
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 10:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1678386376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dSdn6GgJsnNe0jmkd/4h+f7aOnqMYaPIKLuDYxdk9KA=;
        b=n3Ijlrp4QEk/ZnZcD4n2ZCW6YxKdCcJW/ys/fSxZlqJmuaa0BLfqrqvoiXh98EOSmh
         5/xSh9CQ4I2r1Zv5RuHjVoNny/5VE+HonEGlCRCiU3v8e/HoGudmuqgf7G7z1oZ05x6t
         CfoYFF/MiZNKQ+izN68AkxReHyuEocN7rIX6tv5jUjyuJMozVAcvus9NRSvjptJqLZ3T
         S8AMjGeivTiJEzUL4WovQbBt3qtVgL/aZYijqpTvTKTCSPWAbjzOO5m/nzpUMLguclA6
         ObNPIaEdmRuPLvycbyggEw6jTdzjeRtu/+bKD9U8DB+Hx3FQNWxuoD/C6rYbwoEkgkSy
         dZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678386376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSdn6GgJsnNe0jmkd/4h+f7aOnqMYaPIKLuDYxdk9KA=;
        b=vnGcYppMjfKHInZb5RAFGTymIqCYiswvObdYiODKNXQyGuZWxyt+KvyA4QK6cvAJdI
         WvMsdN7yUNBKm8AvSh4PQSMHV58CnBATkoh45uR3a1BE5TewBJ86nkBL2s5Lecg21kpH
         z6/AhCNe/dW4aNO7E+hadnowlrTuCU/aQgsY+qNVeWjK1QYYqrBRxKiPYW2iFtl1Eo1Z
         L6Rqe3iRkmvUZLOfoNF5V/ZTlamIJF+xuG+ekzYnYhgS1aziHko4YwLC8pWzv0QeL9+/
         rWDBwbIFuoAxVQIkzStytWfloCfB7NQFKQ2CzIcfkkAs0G7PyrxGQY48JKspmBkxBkZM
         3Czg==
X-Gm-Message-State: AO0yUKU6bORwIk5ZLDHy1Qf89U5hzk58A77mFdYJO6Wf6/1Iiz51tgYF
        QK+1YqGNbaFTUx23Zmkq+RyOzbH7bOXen+pD0VErbQ==
X-Google-Smtp-Source: AK7set+mD1KrRBjoA8avyUghXdgqT/fc9RGqTc9Ul1eIApcvtpOBd8KiAsaN8hKenTmuX8heM+dThw==
X-Received: by 2002:a6b:c993:0:b0:74c:8f72:291c with SMTP id z141-20020a6bc993000000b0074c8f72291cmr19836615iof.2.1678386376148;
        Thu, 09 Mar 2023 10:26:16 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v12-20020a6b5b0c000000b00746cb6d90c0sm5979062ioh.14.2023.03.09.10.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 10:26:15 -0800 (PST)
Date:   Thu, 9 Mar 2023 13:26:14 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] receive-pack: fix stale packfile locks when dying
Message-ID: <ZAokxsXGwgdNEmDc@nand.local>
References: <e16bd81bf9e251aa6959fbe10a3fbc215a4a1c12.1678367338.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e16bd81bf9e251aa6959fbe10a3fbc215a4a1c12.1678367338.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 09, 2023 at 02:09:23PM +0100, Patrick Steinhardt wrote:
> Fix this race by installing an atexit(3P) handler that unlinks the keep
> file.

This reminded me of a discussion that I thought you and I had a few
months ago on the list about whether or not it was safe to call unlink()
in an async signal handler.

TL;DR, it is, and the link back to that discussion is here:

  https://lore.kernel.org/git/YdjBkZsnYd+zYne1@nand.local/

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/receive-pack.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index cd5c7a28ef..0a6030d775 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -2186,6 +2186,12 @@ static const char *parse_pack_header(struct pack_header *hdr)
>
>  static const char *pack_lockfile;
>
> +static void unlink_pack_lockfile(void)
> +{
> +	if (pack_lockfile)
> +		unlink(pack_lockfile);
> +}
> +

...and I think that this would all work, but I agree that using the
tempfile API here (as Peff suggests below) would probably be more
ergonomic.

Thanks,
Taylor
