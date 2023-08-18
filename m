Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8C0C7115A
	for <git@archiver.kernel.org>; Fri, 18 Aug 2023 15:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378077AbjHRPR7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Aug 2023 11:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjHRPR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2023 11:17:29 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC0735A1
        for <git@vger.kernel.org>; Fri, 18 Aug 2023 08:17:27 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-58f5f8f998bso9257877b3.0
        for <git@vger.kernel.org>; Fri, 18 Aug 2023 08:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692371847; x=1692976647;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Kqa1pWA/ID28Um+goyBP8gQNMjkY5UsszMjYtb+F834=;
        b=GO9AuhFujOYgogIweZoecMOGEE1t0oAsBWxRSR7qvXtZr4Hjjb/rjcriszrXZ0G6kQ
         6rAqLThsIDAUwyXHWnGjrIoJmB03w1sPdDybPG/0AQGE6gPyTsjy12wZ/PmC8qTwhTE1
         OGQbBwCJRvgUSaegtrrNbq+aEQXqOg9kU45YcpHVRBw5XzRcE9cAbJtsRKwZAloP6lqv
         9IuvQ05bQhXNxl+WsnTbD9TKUuzmIyJXqmwou1C8ul16uVmkMQsiPRhn7arEatzvyOts
         Vg11ZvQB+Pnk9stVRnbUgQT+MWJu2jq5FObXANEvvzD/NNEc9/86rGucAYusNy5qREdn
         i8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692371847; x=1692976647;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kqa1pWA/ID28Um+goyBP8gQNMjkY5UsszMjYtb+F834=;
        b=Z7UH/sNGtuL+v/oRx9e+ykqjOw3LxdUjx+x4bnMef1v478Ti1X1orjhYfuihsm2DRH
         IZOCpQAbvlmbz9X/klTVDklUqXZYFt+qxjsRcqLL3DH97crPrXKTaT7/3pSIgJHmj/Vc
         WUpmOZo4Wc8h6r50/wXsTb/j9OjJrQ+qCme5JPpRzV1RKXRJthd761Inj3MrH8asEPns
         pnTixi2ACke2dgP6WuPrtuWyp0aSWtm4bqLEFoUWIqW84IrBH1oUd4QXwwTrZeiWxxeJ
         x+9oOJsyXlrRG66KiIhtJmbxOi/TIe0wlQJHW7om3gqxg+rYFrpVEv0hb2SKwf/bCZkQ
         cblA==
X-Gm-Message-State: AOJu0YxIZub6/8H7eR827zepcsNkSL9I29cKo1hfzTNibUzBEC80SD8M
        KHFLxdBikdjp6CXT5kg0V9m8lg==
X-Google-Smtp-Source: AGHT+IHFEhSdp21+DFR6MiHMhlk/zMHB61fTR+XZtwq+Yt6hvsQ8twtokNimrHEI4QZ4J1ZOnfAYtw==
X-Received: by 2002:a0d:dd4d:0:b0:58c:8b7e:a1e4 with SMTP id g74-20020a0ddd4d000000b0058c8b7ea1e4mr3026655ywe.23.1692371846962;
        Fri, 18 Aug 2023 08:17:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k189-20020a816fc6000000b00586a9abcbe9sm547456ywc.53.2023.08.18.08.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 08:17:26 -0700 (PDT)
Date:   Fri, 18 Aug 2023 11:17:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: Git in Outreachy? (December, 2023)
Message-ID: <ZN+LhRufurwegMc5@nand.local>
References: <ZNwhVOggObU7aVTr@nand.local>
 <CAP8UFD2Yw1XazomxEj0QB20FoaxkO16t_xgRurtnqCCOuhX-eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD2Yw1XazomxEj0QB20FoaxkO16t_xgRurtnqCCOuhX-eQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 18, 2023 at 05:10:25PM +0200, Christian Couder wrote:
> (Adding a few people who could be interested in helping with this in Cc:)
>
> On Wed, Aug 16, 2023 at 3:07 AM Taylor Blau <me@ttaylorr.com> wrote:
> >
> > Christian and I got an email from the Outreachy organizers asking if
> > the Git project is interested in participating this year. Last year we
> > submitted projects, but ultimately did not select anybody from the
> > program.
>
> Actually we actually selected someone and a backup person in case the
> first person was not eligible to participate, but unfortunately it
> happened that both of them weren't eligible. And we learned that after
> the selection process was closed.
>
> The year before we had no applicants for some reason.

Ah, that's right. Thanks for jogging my memory!

> >   - Updates to our applicant materials on git.github.io (project ideas,
> >     as well as potential microprojects).
>
> Yeah, I can start working on the applicant material after my current vacation.

Enjoy your vacation :-).

Thanks,
Taylor
