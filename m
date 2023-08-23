Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F115C7113B
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 22:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238679AbjHWWeY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 18:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238708AbjHWWeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 18:34:09 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF7310D7
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 15:34:07 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-58d41109351so4431817b3.1
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 15:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692830047; x=1693434847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/RFfNlDAM2rcsM4p7HcMs+yAUcx7bP+21eqMxf2gDLU=;
        b=bhGFflwO3xekDT6+xkXv73LPADkxNSvARMcxnW0i1xIFZcyT8GrN3eK+aNzXcNf1NF
         3GSWtlaYmkVmTdCbMJVVofTZjV95bwGNHlYJ8fZrfOBUeahkL6mlUX8fh8v9yzLxdwio
         E/oESEuohuI8L3OkQvwOvRKtLA6p1DuuFiUkx+etC3e+jtPvBLSdb089VZM5j/4pq4yK
         vu+tlHF+KFye/yaO83dLxLjxsqWDG6CP2xVJZR5OhaY59qH0xDxdYac4wUVFuEbxnHHN
         mDjC/eDoaBq/bJ2zKskyZS0rjcn3NArydJaRkgWV/AnktrNiGAdwjDSxx0y9Cx9sQxR0
         SNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692830047; x=1693434847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RFfNlDAM2rcsM4p7HcMs+yAUcx7bP+21eqMxf2gDLU=;
        b=To7XZUOmBxZt0pGhunIivrxacMC+eOe4PWrxBUe0yw8pVRkXOSwxdZL+eWhP/oVAaM
         bPgSlohTvf+ORUVOsLwIf8i+vKlXJoUqdGWoXThMIg4uaZGCpxJihGBuZ1dYwID3O4eX
         cwY2t9XnmV7uP34Sq2/28IXGlzHXSiNZpFZ9UmVvQSyQI6dSteJWDvdyXgPep0jFZzng
         M9rPw6t1Ld+dPSzHEky47T6PJY5NpdJJQtB1NL13uCRveg83b0+ovLvGRZtG/0lLmWqI
         J0EohH6Ojkl1SMw8bP5BDgz0++/3MoPDzZCZ6h0f9O3crTB6CvpIZyBz8BIN01GZ6+6H
         dERw==
X-Gm-Message-State: AOJu0YylkD+y6wC0OhdgRc6gi5ExaGAJXVwyMuABO7rmTEyV2kTbzqfT
        9Tfnf0zgeP3CD56Buwm+DF++yw==
X-Google-Smtp-Source: AGHT+IEZ/ZyyXM7OdfwbplvRW6uYLPoHgVagkvD78VaSGT4JlkR2SnrxJW53uLZTt8/UQVbwogly4A==
X-Received: by 2002:a0d:d644:0:b0:58c:ba72:37c2 with SMTP id y65-20020a0dd644000000b0058cba7237c2mr13496042ywd.12.1692830046873;
        Wed, 23 Aug 2023 15:34:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x185-20020a817cc2000000b00577269ba9e9sm3568979ywc.86.2023.08.23.15.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 15:34:06 -0700 (PDT)
Date:   Wed, 23 Aug 2023 18:34:05 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: 2.43 release date adjustment?
Message-ID: <ZOaJXSZu4Bv6aXEH@nand.local>
References: <ZOYdG8RtPIgymtBV@nand.local>
 <xmqqpm3dg27i.fsf@gitster.g>
 <ZOZR0jesPpCDNbRj@nand.local>
 <xmqqh6ope8v6.fsf@gitster.g>
 <ZOZ+cbkrXsEcQyaW@nand.local>
 <xmqqcyzde7r2.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcyzde7r2.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 23, 2023 at 03:03:45PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > No specific reason to expect bugs. Just trying to line things up so that
> > we have (a) people around when the release is tagged, and (b) don't have
> > a release hanging over our heads either during or immediately after a
> > week when most US developers are offline.
>
> That is exactly what I call "expecting a post-release fixes".
>
> A much more important thing is to make sure we catch them before the
> release and devise ways to help us do so, perhaps opting more userbase
> into testing early.

I agree, but shouldn't we still plan such that we have folks around for
a week after the release in case something was missed?

Thanks,
Taylor
