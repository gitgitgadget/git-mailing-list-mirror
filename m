Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85D6C433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 12:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90D5520734
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 12:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=goodman-wilson.com header.i=@goodman-wilson.com header.b="GOcrMwf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgFJMSO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 08:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728544AbgFJMSN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 08:18:13 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDF0C03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 05:18:13 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l27so2350235ejc.1
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 05:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=goodman-wilson.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eW/j6x8jdGePSLwMvKU60E41caaZuQuHidtBXqYH1mk=;
        b=GOcrMwf26ZuISUHCBAct2w+/g/GqSkfCalamRaETBHDRBlUh6W3Ty6j4tQeSrm78y2
         PJB4CfZdo3Hoe9dFz1h0+BrpSVJCo5gnOOCZI+UVXaverzBirK4xHenNZ+bIIw2IlYY4
         /NOARg9H18UeT4SDMod+QTN2sCa3JfEoo0s+jDFJT0rVU2wbio2OU5FshwP24b5HDBM5
         CXEfyh87gV3G/tuVmkA6p4K3sOY1HRN1UHaSGm8GqLMns2umP6wmPn8acXJyGOYgLJIA
         UGRO6xTbsaaeQp8lcQGjGkqusDMrzsVxySe+CygaXlDAuPC5/DkFOvVeVLnz2bkzrS23
         aF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eW/j6x8jdGePSLwMvKU60E41caaZuQuHidtBXqYH1mk=;
        b=KZkCzKUfqkNt0SG78Ml+SmjqW/OJqHjk8f3txsU1YvAyAfF53Z2O3qscxhf4iqN1u+
         dlAZCZbt0HjnFJcLP1o9/pLDjo4As+M/0JkCEGjHpzXu2q0BorvjYDCHpVfoJjOTIwuC
         P/URCKV78+iJo6eX1nf+J1Gf2SNbswwoC6SzZkiPRTQAZi7zGhqfXBoe6F8EZmGBS02o
         OUTrfQu2+3hbEzy+z5omPm1sH1BZuQ/76laHMGxF2XAnJEbbXe7nTjMwcfli8t4h9GiO
         pE1FWS6quTw2wM0W8vi33S8PVH7msx6NsowJkIJWWVHYtmTn/CzrVQuYuEhtPbcJvmJG
         +njQ==
X-Gm-Message-State: AOAM532M100PP1YNcP6uh5EId4rJIBE8v9v/AEGWL3sxEzK2Z7j7dTCG
        MNjwSRx+22IfQUZDfaPgoe3K+QICM47Ir0fC9LUxvg==
X-Google-Smtp-Source: ABdhPJybbndT1DwBPvhrKTM3gRohrILmJbL/fTwi4hGcKvxd53jzYoYAKYxx3lD3TFsav779aqGT4EVfnZCQsKG/tZ8=
X-Received: by 2002:a17:906:fc06:: with SMTP id ov6mr3282325ejb.184.1591791491974;
 Wed, 10 Jun 2020 05:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
 <20200505231641.GH6530@camp.crustytoothpaste.net> <CAOAHyQx=+fM1FpAv+g3M+j7j4MgLJA03=MGFmXLvZcfJKAEpGg@mail.gmail.com>
 <xmqqeeqoi5wc.fsf@gitster.c.googlers.com> <CAOAHyQzxG7Lc6+PLBtM6oe9vSoEEAmuXAaKF2VzO_phtkfGRVA@mail.gmail.com>
 <alpine.LFD.2.21.2006100549070.3771@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.21.2006100549070.3771@localhost.localdomain>
From:   Don Goodman-Wilson <don@goodman-wilson.com>
Date:   Wed, 10 Jun 2020 14:18:00 +0200
Message-ID: <CAGA3LAed-QZNiMhEPBmjV2noVgLON4ciJZNsmZ5ZhTFSC2WeKg@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Simon Pieters <simon@bocoup.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert,

If this were the _only_ effort being made, I would agree. It's a small
thing. But lots of small things add up, and they make the big things
worse. So, because it is small doesn't mean it's not important, or
that it can be ignored. Indeed, that is a sign of privilege, to be
able ignore the small things that seem unimportant in isolation. Thus,
of course this is not the only action I am taking at present, I take a
multi-faceted approach to my activism, and I encourage you to do the
same.

I think my friend Mislav has a much more eloquent response that is
worth reading: https://twitter.com/mislav/status/1270388510684598272

Don Goodman-Wilson

On Wed, Jun 10, 2020 at 11:51 AM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
> On Tue, 9 Jun 2020, Simon Pieters wrote:
>
> > Hi Junio,
> >
> > On Tue, Jun 9, 2020 at 6:02 PM Junio C Hamano <gitster@pobox.com> wrote:
> > >
> > > Simon Pieters <simon@bocoup.com> writes:
> > >
> > > > If someone is interested in helping with this, please follow up with
> > > > Don. But I would like to ask again for git mainline to seriously
> > > > consider adopting this change, given the information presented above
> > > > and the ongoing movement against systemic racism.
> > >
> > > I am OK in principle if a future version of Git, when used by a new
> > > user of Git who does not have any custom configuration, wrote a
> > > string other than 'master' in .git/HEAD when "git init" is run.
> > >
> > > Picking a good replacement word to mean the primary branch is
> > > tricky, though.  Just having a notion that one is special among
> > > many (i.e. the primary-ness of the thing being named with a word
> > > that will replace 'master') may already be offending to some folks.
> >
> > I find this response not satisfactory:
>
>   ... snip ...
>
> "I can't breathe ... I can't breathe ..."
>
> "Well, tell you what, what if we rename the initial default branch in
> a distributed version control system for you?"
>
>   *Now* do you understand how asinine all this sounds?
>
> rday
