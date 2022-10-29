Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2B5C433FE
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 17:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiJ2RZD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Oct 2022 13:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiJ2RYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2022 13:24:25 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AE943E45
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 10:24:15 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id n191so6915294iod.13
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 10:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jpeOLnARdbPSNUg4biyu/YUyQ4/dWmpnd3O4GXU1nRg=;
        b=da8QCIGY7q7uuVPk0a4pbsHpkkdZr5fH5XC9DkNPOk1E1SVY58c0qRNU4+/5Awwqgw
         1gUxv6OAf87uSFb4XgeoaTE+JjyzCZy2qtog8zB6HtpeIBu/JxlJrF3PBtgEG8UVIUM+
         0FCtq0wAHcVWoEMvasNquePngrFzkeS/MgNMA01Y2ryoy28fEcB9JEJvhAtX8O1FHeEE
         fE3rwFDWuKrDZlPs4pCNkWvRXPGnBq6weQHHwkjvJyJprOj8/JBocCnEZd32Vza5Wc8D
         4SSPM+UivVMnASlkYh0a8/yHD6nvtSO5bDTsAKuKPNKBqEfZtveHOfKPbI6nSEJPBvm5
         TwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpeOLnARdbPSNUg4biyu/YUyQ4/dWmpnd3O4GXU1nRg=;
        b=tFa07bsFyC5GesgIfNEM3339SIODMt4VHVultW7jyio4g//XhMf3OrGMKpUxLmcNYI
         R+/z8xZ/uBYx4dp/MEquq0pmeRYGt4+HLJy6dGyj6KZTkffQ6bnoRmKlP/lbd5w16jjC
         6ZsiswixCoqe7LaUzD4sK4pjxHn2FcEE8V011Uc1lbE5G1w/9yEtz50ElxZLoCM3cxlk
         r6pP5j5heaoGf7/7TJDZ2XvAKx5Ddals7cCsFeU2TUGp8JHzdJhzFjBhF0qlNpFTqOUm
         3eDjlNRsxMy/twDPQhbGh0AC5PRJIqJr/hnUFOSPOv4lf6Y6zgMp0F18hlLBjYQGfTU5
         FMig==
X-Gm-Message-State: ACrzQf3gTsQSyFatpO1FKEzDLcG3fnclulyyamt9BjI9Si6xWEiW87zN
        HPyMIi61GZZlGbhLS0hP/A5ykg==
X-Google-Smtp-Source: AMsMyM4Vf/h5S7WmD7BhTrLzx8OYs517GdC8QkIJBOHRhmNtT+w5nkdsXR7Ywr15umKGbBmpYqyXfw==
X-Received: by 2002:a05:6638:1305:b0:374:69ce:ba1a with SMTP id r5-20020a056638130500b0037469ceba1amr2706267jad.189.1667064254810;
        Sat, 29 Oct 2022 10:24:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m17-20020a6bf311000000b006bbf0466587sm818438ioh.49.2022.10.29.10.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 10:24:14 -0700 (PDT)
Date:   Sat, 29 Oct 2022 13:24:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v3 0/4] Add some Glossary of terms information
Message-ID: <Y11hvL8Pubscz3Be@nand.local>
References: <20221022222539.2333-1-philipoakley@iee.email>
 <20221029164112.2097-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221029164112.2097-1-philipoakley@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 29, 2022 at 05:41:08PM +0100, Philip Oakley wrote:
> (in reply to <20221022222539.2333-1-philipoakley@iee.email>
>
> This short series looks to add the basics of the reachability bitmap
> and commit graph phrases to the glossary of terms. While these
> techniques are well known to their developers, for some, they are
> just magic phrases.

Thanks, the updated round looks good to me. I applied these on top of
the tip of master instead of the existing merge base (which was
dc8c8deaa6b (Prepare for 2.36.2, 2022-06-07)).

Will queue.

Thanks,
Taylor
