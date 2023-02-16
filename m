Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C45C636CC
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 20:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjBPUez (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 15:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjBPUex (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 15:34:53 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2223D7288
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 12:34:53 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id h24so3590593qtr.0
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 12:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676579692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pPIS3KHPwmqtwBJI+4MPKN38B7zCpr8GcKJ5Bv2LKzY=;
        b=cE/5DbW3/F89Ic8c3d0hxCtTJWGG5PHSENF3dlc+SqoNBOYZV0QdVZ30u2so2ySeS8
         CLCBlTK5bsmnE1qKMnL58jJFz6n40qQeGtSWyhYi1DBxpzX/5qyxf/L/n8ArFE4nsA7X
         KwXaFP/nptBQulzdNe65YxjtLKtSFGLX9eZcsIO5tLFFIhFX2x5Qq0SLCrpMCTBbSHbe
         BCe/G50MEYqs6VSerDp2FQqr+mLO4+bW+bhouR6A/YTBryiaL701GS9Xcj7rTj+gkxph
         i0PSkLKxzPB7Z2VZrmLWqUYhiOcDuVzbkN48ZdhG9IKP8hPRBb9BGikFHJG70IXDKMaD
         Sfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676579692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPIS3KHPwmqtwBJI+4MPKN38B7zCpr8GcKJ5Bv2LKzY=;
        b=rMjcEmAuxgwsMIj1wI3ujl6kLmaaM6wHRj9QvlG547YEwuJECNXyuaLXROVkZ1sskD
         QiFSBI6HXfQ34ShEx3vNxRB2yH/J1EO8PQl8DrfjKCe/BlPAumbd4duoV/ifrcHMj9Y4
         kfbRwaoPa2OB3OPZ72y648o8oM/2VLz6ViYrOOYbjQDt2f/NJjNTFp6phJtLFlaI0rK4
         qAJl/ImiggJnTWLYF+lAbm25lEIOrvsryDGW0J+4MmaxwQIfuKkhowYYa2wo+tDJcLyQ
         xLlooY9lR1aUssLU7Xo3JgYdmbSjDtX5FuwmvL7KBTr2NXad2GrNHTMiFMokU4wbyYwq
         YlKw==
X-Gm-Message-State: AO0yUKVYBpbHLMVPN1po+GHQffR3aCld+Cb8VzWHkgeCuzOcRdNTGyCs
        +BogfKSbhKXj8m0BZlGD7XA=
X-Google-Smtp-Source: AK7set8rRiPpjXdZxrJ7cbnzMCh0Bw6ihZ2bK00E9jd9wte3B00XWv1OO1ON49lTzcEu3aHkUB6Ijg==
X-Received: by 2002:a05:622a:1a13:b0:3a5:f916:1d2c with SMTP id f19-20020a05622a1a1300b003a5f9161d2cmr13730023qtb.5.1676579692169;
        Thu, 16 Feb 2023 12:34:52 -0800 (PST)
Received: from localhost (pool-74-105-67-34.nwrknj.fios.verizon.net. [74.105.67.34])
        by smtp.gmail.com with ESMTPSA id q13-20020ac8734d000000b003b62e9c82ebsm938168qtp.48.2023.02.16.12.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 12:34:51 -0800 (PST)
Date:   Thu, 16 Feb 2023 15:34:50 -0500
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/2] diff: consolidate diff algorithm option parsing
Message-ID: <20230216203450.yej5c5dejjz6e4r7@pop-os>
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
 <pull.1452.v2.git.git.1676410819.gitgitgadget@gmail.com>
 <0c5e1fc6c2651e39bcefa27ee0976c9519671969.1676410819.git.gitgitgadget@gmail.com>
 <xmqqk00j3b6r.fsf@gitster.g>
 <AAC53EE0-91F5-4A74-AB26-5F3F8B680CDE@gmail.com>
 <xmqqmt5ev6ln.fsf@gitster.g>
 <Y+2RgdCDrDC1N9Y1@coredump.intra.peff.net>
 <xmqqk00itj0c.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk00itj0c.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/02/15 06:57PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > I'd have expected it with individual callbacks like:
> >
> >   int handle_patience(...)
> >   {
> > 	do_patience_specific_stuff();
> > 	do_shared_stuff(PATIENCE_DIFF);
> >   }
> >
> >   int handle_histogram(...)
> >   {
> > 	do_shared_stuff(HISTOGRAM_DIFF);
> >   }
> >
> > and so on. That's a bit more verbose, but the call stack reflects the
> > flow we expect.
> 
> Exactly.
> 
> Thanks for spelling it out.

Thanks for this suggestion--makes sense to me. Will incorporate in the next
version.
