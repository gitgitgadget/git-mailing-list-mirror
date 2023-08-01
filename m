Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83C6C04A94
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 20:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjHAUul (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 16:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjHAUuj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 16:50:39 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4F31BF6
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 13:50:34 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-583b3939521so68312767b3.0
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 13:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1690923033; x=1691527833;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o/FGhQanbQuQhfNXx9PcohewDX2A6vCJ5G/vCiRjePU=;
        b=XGukfPnAdK/uJETRNeNEPA7gWBUDJTrR0+n6U9Cwr9c3ZtNxpr83L/UKpcfkEr0he6
         SZmHJm/pQ9p4oYsy5cOWmh/l1744toSEROuMzgjcJEBaJ1WS8iVk8X0bFRI6YA0JYCM3
         hbaL8g+WUyU70J5NerKdqUQoYxos3jRV2AjziWP8EfRYj5uS6PZLPHiclSGw/CUOaydO
         4tCFV0B98uvkjBt2qsqiwZcGdcPxAMQDtjF3gCTpId+HYr2rB79lPCO6Gy1zBhf3lBer
         rMneFrV/WaSIE9stOFZcaUEoxWfulK3OqQfOWBRaga5gmD4XlqIhKq6g3gCosyCdGq5A
         QETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690923033; x=1691527833;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o/FGhQanbQuQhfNXx9PcohewDX2A6vCJ5G/vCiRjePU=;
        b=dMg8IIOacH3oxCVszPtm2G5jVMUm4MumF5WxS9DGDT8bPC0TcFOV4gwCVjmcNwCpDd
         7vH4lgRnhJY/W+2NKKOc4eizAsq4N0kMuh7Bi09P0d/Ec0R1hFa930lt1pmWACAf+JJM
         wGGVfrzgIJjoYweR/zlehWUblpgyjwXbA9bh9GfM2Bis14QZETsgj8DRlZCyRV4djyio
         iHq7IC1To4ORrlj5hgUTUkM6YXJlb982jHfzlsat/lZBSJ+EVqw+tjDjW3kEznIM6SaM
         +vPq0AN3T7exqpcZpJm+ACX7c13yxstaOGmFbby5M0oV3BwHJDKDPaQfXzoWkD1Nzbzg
         Af9A==
X-Gm-Message-State: ABy/qLYScwiUYqynez8pwisqvNQy5P0tTWflCa/6cEjyMw0EDX3uiHGX
        sby4RGzqIeq0WeCMAtZ1KMk/1BHSXL4NNCLjdahksg==
X-Google-Smtp-Source: APBJJlFJtooVqwKH6G1z6ZDIGiI4dH+iRZlpkYXBE/Ew6hb+GjwdkJVGeAG/aVZ+1Iz3N3oAmjRKzQ==
X-Received: by 2002:a0d:e642:0:b0:56c:e70b:b752 with SMTP id p63-20020a0de642000000b0056ce70bb752mr13605822ywe.13.1690923033391;
        Tue, 01 Aug 2023 13:50:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b186-20020a8167c3000000b00578942e2a86sm3988905ywc.60.2023.08.01.13.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 13:50:33 -0700 (PDT)
Date:   Tue, 1 Aug 2023 16:50:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: tb/commit-graph-tests (was: Re: What's cooking in git.git (Jul
 2023, #06; Thu, 27))
Message-ID: <ZMlwGJv8GgIPBgQG@nand.local>
References: <xmqqh6po95a5.fsf@gitster.g>
 <ZMfhWkd24y7XjEIw@nand.local>
 <CAPig+cTRUac+FRg6V1H+3_rusT17imQGZOy8Fd-MWriEv_epRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cTRUac+FRg6V1H+3_rusT17imQGZOy8Fd-MWriEv_epRQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 01, 2023 at 02:33:23PM -0400, Eric Sunshine wrote:
> On Mon, Jul 31, 2023 at 12:55 PM Taylor Blau <me@ttaylorr.com> wrote:
> > On Thu, Jul 27, 2023 at 06:46:42PM -0700, Junio C Hamano wrote:
> > > * tb/commit-graph-tests (2023-07-24) 5 commits
> > >  Test updates.
> > >
> > >  Will merge to 'next'?
> > >  source: <cover.1690216758.git.me@ttaylorr.com>
> >
> > I think this one is ready to go. Eric Sunshine gave the earlier round a
> > review, and I made sure to address his feedback in the subsequent
> > version.
> >
> > I'm happy to wait for an ACK from him, but I think this is low-risk
> > enough that you could merge it as-is. Either way :-).
>
> Yup, as I recall, I gave v1 a reasonably thorough read. When the
> reroll arrived, I scanned the range-diff and saw that the few minor
> review comments had been addressed, thus I had nothing more to add.

Thanks for giving it another look. In the latest WC, this is marked as
"will merge to 'master'", so I think that we are good here.

Thanks,
Taylor
