Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400A2C77B7A
	for <git@archiver.kernel.org>; Wed, 17 May 2023 16:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjEQQCT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 12:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjEQQCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 12:02:09 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B255B94
        for <git@vger.kernel.org>; Wed, 17 May 2023 09:02:06 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5617d793160so10951647b3.2
        for <git@vger.kernel.org>; Wed, 17 May 2023 09:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684339326; x=1686931326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+uR/HeMsUOv0mbK4UkDbUqQhd/TMyACUnf1uziQ1NaU=;
        b=iOPRnckSfbikNkDBX1RUUetCxQLt8UoR3y2p5rY8DUP/ZBwKj4vfkIl0npTlE3J5vd
         5bfvy4tShIeY0ZdQClgwiyIEVeY+RIUXji4PIVa4YInaJTQOWa/JltBcXvsnGZk4Pwp1
         ebHDz5XBxH0F4M9fVNzb9gNgf6DEGgjeK9l9FkjWMl0fPEpx8qN5NRvm7vLFbhoWC5Gp
         e5xg6EFgKMXUpQkOJ/HODPXsXAOMUJEGKj1LS088B//63OBOCjlkSqrVnYvf0OfEq17O
         xAxd9NdeGpM3Awmzhz3oqWJd/60fVsQh4BoypF+68FIK8NXbU99fqv2XgYhnNwHyboVD
         THQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684339326; x=1686931326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+uR/HeMsUOv0mbK4UkDbUqQhd/TMyACUnf1uziQ1NaU=;
        b=KUYz7/Sh7793T3VkwliEr0oMXCy3NwvE4zn6JShug6kWnuoGhTL9m+0q5pRk7hU9Oz
         bRoh6Cc5vGQ2gliVAtKMWXMi0JantYRIVXLFbC7w308fdQ8ZBOQ24FTv1l95wPPnVlVA
         rupPB5hxk6IdizM52Uw66uznQacZBkAXHi6hxJty00+FkP4Ruz0ZF9iqmQ73KhKtz3GZ
         Gh8fexFjLXdx8pRJvahiPUixU80tjXOj6ax0yVy9DoZ7LNBWVMOTM5NFjkC+02wmD03f
         pr6GGsByCZ8OLIWJSI3+hBrMsBvFP90ZtRqAWTfF2I1rrZPVptYtwZXJYtqpkWnHuPYK
         Ux8A==
X-Gm-Message-State: AC+VfDygoL2uLbkjFOFQzBJ91NmpqamrnBVF6Vv859twQJbDPGNiF5H6
        eejhr1bPtF8cOXT6Zdiym7T7pCh2Ee9HsSEOXSs/Vw==
X-Google-Smtp-Source: ACHHUZ713POcy8wu4xDPCL/XcNcE3XnvIjJo3OyfrYTnFSuLwc2diJFWOKoISkeU/h/6XExkjLmEPA==
X-Received: by 2002:a81:4ed6:0:b0:561:b85f:34f9 with SMTP id c205-20020a814ed6000000b00561b85f34f9mr2814751ywb.44.1684339325699;
        Wed, 17 May 2023 09:02:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r64-20020a0de843000000b00559f03541c6sm730096ywe.132.2023.05.17.09.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 09:02:05 -0700 (PDT)
Date:   Wed, 17 May 2023 12:02:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Hesse <list@eworm.de>, git@vger.kernel.org,
        Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] imap-send: include strbuf.h
Message-ID: <ZGT6fEZFumAsZnxu@nand.local>
References: <20230517070632.71884-1-list@eworm.de>
 <xmqqwn17q7ou.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwn17q7ou.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2023 at 08:49:37AM -0700, Junio C Hamano wrote:
> Christian Hesse <list@eworm.de> writes:
>
> > From: Christian Hesse <mail@eworm.de>
> >
> > We use xstrfmt() here, so let's include the header file.
> >
> > Signed-off-by: Christian Hesse <mail@eworm.de>
> > ---
> >  imap-send.c | 1 +
> >  1 file changed, 1 insertion(+)
>
> Puzzled.  For me Git 2.41-rc0 builds as-is without this change just
> fine, it seems.

It will fail to build for ancient versions of curl (pre-7.34.0, which
was released in 2013), or if you build with `NO_CURL=1`.

> I know there are many header file shuffling patches flying around, and
> I have seen some of them, but is this a fix for one of these patches?

Similar to [1], this bisects to ba3d1c73da (treewide: remove unnecessary
cache.h includes, 2023-02-24).

Thanks,
Taylor

[1]: https://lore.kernel.org/git/ZGP2tw0USsj9oecZ@nand.local/
