Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAD3C433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 12:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2DED61251
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 12:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhJUMQX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 08:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbhJUMQU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 08:16:20 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAC8C06174E
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 05:14:04 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id t16so379947eds.9
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 05:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=QIimucJ4FqV6enk4fZ/pSHezSdmMDdt1OrdAuIgW/Zc=;
        b=gb8DzLyvNtOE03TdcSyrD7cj8BwBN5EtmJ1imZNM+GYPdKDGSwo+P7RM/MrdLfh7Aw
         oPGdJqNrBXVQATZ3ONCkjrChzzJ5InrMSRW/BAJrA2L+aQU917s3Lk0AYsXW4kWrBBx5
         b+LCj8M3S52SrORwmczLX+kJazSFBs979PlTLvKzRWF0Shan5UjrQKf+0Z7J88wGClyM
         4ippkLjxy/LeCdnWHSSr5EefVaawmlHS/M/u78MtEcJ4vYy+kax60xVqgq6WkZF9s1si
         V9AoVgGjTY9RyNE8HBHCUvCWsyynzK92Xhg+iW5MUN7gq8Fbt2X/btL5HJ87weRDdlrl
         oloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=QIimucJ4FqV6enk4fZ/pSHezSdmMDdt1OrdAuIgW/Zc=;
        b=atqAPcGfY7PcScCtLutS89ASDOi2XYRBdZZfZ0HOfuJ/1Lb1v79xX1NQFIxPmSFIAH
         ih+hIQdZcwer9r/EqXHf1akomBORF1bHx6DRE5INiiMUgREWJ7FyWJeZyDtXBSspc/Et
         NURPmtCpSKiXtc7U0HmVubMVig2Fh6nTdiVFBZGDdsC/6ebD5Q+9CIrCJEb20K2u0fC3
         hlPiHdkZVYlKvxzvv8Jxg7G5qKI14uBRP98+ExUJFNgRZbSD7+SMAQnBLv1g+xWdkSjw
         8PNcZaGw5M22+UjvRJONV8Y/dmIHan/6pRT7Pj31Z6GfJaM9ScpHe7TbdxShatmPqKwS
         +nnw==
X-Gm-Message-State: AOAM5330wTOa04LZxyvUDVIT1BlxjBOQD6ybkaPoyxU9Nk845iRsAAs0
        j1khk4c9cV/MCRR17se+LIw=
X-Google-Smtp-Source: ABdhPJxkIb/Py58J0/m997iU78Fpbk5BIwqPliJW9wgFNlFsQw+buJvoAyQjAzinGCN+pn2dwVrJrw==
X-Received: by 2002:a17:906:6a2a:: with SMTP id qw42mr6658274ejc.561.1634818443110;
        Thu, 21 Oct 2021 05:14:03 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z19sm2426836ejw.44.2021.10.21.05.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 05:14:02 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mdWxM-000zkN-Ue;
        Thu, 21 Oct 2021 14:14:00 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, peff@peff.net
Subject: Re: [PATCH 00/11] midx: clean up t5319 under 'SANITIZE=leak'
Date:   Thu, 21 Oct 2021 13:50:55 +0200
References: <cover.1634787555.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <cover.1634787555.git.me@ttaylorr.com>
Message-ID: <211021.861r4emv7b.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 20 2021, Taylor Blau wrote:

> I tried to separate these out based on their respective areas. The last 10% are
> all from leaking memory in the rev_info structure, which I punted on for now by
> just UNLEAK()-ing it. That's all done in the last patch. If we choose to take
> that last patch, then t5319 passes even under SANITIZE=leak builds. But it's a
> little gross, so I'm happy to leave it out if others would prefer.

I'll defer to you, but I've got a mild preference for keeping it out. An
upcoming series of patches I'm submitting (I'm waiting on the current
leak fixes to land) will fix most of those rev_info leaks. So not having
UNLEAK() markings in-flight makes things a bit easier to manage.
