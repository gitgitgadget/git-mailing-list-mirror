Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81A8C61DA4
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 20:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjBPUDG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 15:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBPUDE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 15:03:04 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5D7497FF
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 12:03:04 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id h7so753056ila.7
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 12:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=su5t91DTgOxNDiovQ5aWS8rbLviZK+CEn9LZc54oA8s=;
        b=AmAlnGzHUaUEmME0+azwep0VRgAsxRdvVA4fSJR82TK+q+xkO5iQKs9/yv2n1TLLHQ
         7m0fMuxpJsq09vtc8mM0smdFgayMODT1x/xlNDbZ6Iv2HJYzpbY+bAWl+9zZwpkUprND
         w8Hf2UDQo1Sd86T4HVzWd0cfl0CRCNo2wN0AzjvbycAWJ/vuswqp9E627Be4QqDoImcc
         9cWJd6zNZO3mO7o61AujeF528JBjETfjA3ljEMGP6BlufBva313MrIWNwOLUoD5p/6Ih
         vVzW+8er5efiV4DufTKV0YDxTUFjHu/TqAK4vmcKydz4PJegpGX/JURAtj3yWGHaUzuF
         0aKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=su5t91DTgOxNDiovQ5aWS8rbLviZK+CEn9LZc54oA8s=;
        b=ZXtS/HZzk2z4s7dBVFJIVH5BDBl5V6swYHgDgVGlbU9B/eiTt48VHFQbSnNmN4o3BA
         Uy/CkH03CzdCfjTCZk1zf6U07uZi447DIoe5RQJBKqUmLVKU7tRAPp7mvaler+iQ+2SZ
         VG7w4LNKG4eNW0dVz22vRp+JcokGVBDEO9SusVv+GrJm+MOfaclsMx5p0HvP86TZzh7y
         0NNR3ON6r674ZQCYsrotpv2vFKTkfGXArEdoQhmvzo8gSopA1mP+uwe0B2serEV2mTyq
         yWImzbznl6KmpFdkT86ZWAiWRU019TNt8rsUegPXPwb5RX3dqPXEC0Kp5GluNDA2nsnG
         bTnQ==
X-Gm-Message-State: AO0yUKVPUnHUgkzAyLacbqIQYl7c8a7elE5wEi1RGQ2XxcJlYaLSbN8D
        fRC6imI7rNfQpORqIUAZPJQnwaj8ILxblhsPoy0=
X-Google-Smtp-Source: AK7set+WIz5UXwbefeVhgBqW+uy+fSd5S3cgTd2zEbMzpmph8jL0HBe13M/lzKsP5gas1wc87sV1pQ==
X-Received: by 2002:a92:c268:0:b0:313:cd79:adcb with SMTP id h8-20020a92c268000000b00313cd79adcbmr6788360ild.18.1676577783393;
        Thu, 16 Feb 2023 12:03:03 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x19-20020a02ac93000000b003a484df1652sm817201jan.55.2023.02.16.12.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 12:03:02 -0800 (PST)
Date:   Thu, 16 Feb 2023 15:03:01 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org
Subject: Re: [PATCH] dir-iterator: drop unused `DIR_ITERATOR_FOLLOW_SYMLINKS`
Message-ID: <Y+6L9R9HkkUc7PkX@nand.local>
References: <9bb10b607e46f867a3f8f5c71abf13c990d1ecfe.1676572031.git.me@ttaylorr.com>
 <Y+560+/G4pelldXF@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+560+/G4pelldXF@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2023 at 01:49:55PM -0500, Jeff King wrote:
> Thanks for following up on this. I think it's an obviously good
> direction, and the patch looks sensible. It's hard to grep for
> --follow-symlinks or FOLLOW_SYMLINKS to make sure you got everything,
> just because there are other unrelated features that use that name. ;)

No problem.

> But...that is true even before your patch. dir5 is not mentioned in any
> of the expected output, even in fa1da7d2ee (dir-iterator: add flags
> parameter to dir_iterator_begin, 2019-07-10) where it was added. Was it
> just vestigial? Or is it somehow important that it is _not_ in the
> output?
>
> I didn't dig, and even if it can be removed, it would probably make
> sense to do it separately from your patch anyway.

I have no idea either. From a cursory scan, I think I'd err on the side
of it being vestigial. But Matheus (cc'd) should be able to tell us for
sure.

Thanks,
Taylor
