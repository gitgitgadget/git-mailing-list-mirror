Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00ED6C433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 22:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C692A60F94
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 22:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243444AbhIWWd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 18:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243431AbhIWWd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 18:33:56 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86818C061574
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 15:32:23 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t10so32244465lfd.8
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 15:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qZBxgW14eyp2QnfA2zaarFlkp4AxAx2V3Jk4Sii4Q/A=;
        b=Lrjcv2JM50MAXwk2C0iDFZo6n8g/ok/R9q3BXzFAYO57062jjaeR8J1XK2kbfng2uM
         UnbrDFkxFpNLp9WPvNQFLvEf6nFjH48oA82DuheaBPoQMwDIxQ4hTonVv+i1ofovunPQ
         SjIO1b4Y7V/4MkmlWBNkLP70zcR20sOGSTbdFKzJn3K8FvNBVoYMTFri71AGGOzILJMQ
         7/fE6+Ip0nwIFiRyVbKWFqjTWgES8LdR6JT8a8sqx7mwqw4QqlNtVEVOaC4qktrEQqMZ
         gRseTd4Le10f4AB+4c4P0WmHL58BLK15uBbh7TyNmRLGiUd9CiIkKYQfKhokgQIP4INl
         z3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qZBxgW14eyp2QnfA2zaarFlkp4AxAx2V3Jk4Sii4Q/A=;
        b=07O4d73yzAJ+p8v7ODYnBXcrLHAZ9c4dZYJ0bMwbmNcfCzSd4HBmP0pi6I0eYS6Yd7
         hwc9672bVEFhpO8FeSkmbOer8zWXlNCuKRPrVm9CVknzr3g5fejPzKpFNx5o6ZRuTYWq
         9eqeBvAuA33i83RtN0lLx66AkbhDKW+OGO2DRNIpnf+V+M5ZWKWz3MvlCoqR4is/KHko
         x8hKW1hsNQeoYX6Rw/ZU40OKk/kB17ssDQSovQ4gtQs2eNg+0+pn361QyXAYqyhqc142
         D1Kgggzn4IG8wNrOoo7iSi5Zi+Ulbu5jK7WGQSTN8MzoaeohdJG14jKypG2o3R4716o6
         R3iQ==
X-Gm-Message-State: AOAM533g6AIwqIwmZO6a+aLYoeGTFuLkoQeb/WSNcSuZfxnuNSHVJfOW
        yXYUlzesrFX8iuAs0v4hfk4FWS5e5C5l7Y0yOCM=
X-Google-Smtp-Source: ABdhPJy7FU3otHN5aWlDa1JHdYiVpBr7EHUiSPJaCG8fJE6m/Kcbjb00Szy9Gm5mQsCYUEd+gunOAc3KIW9FteFC300=
X-Received: by 2002:a05:6512:31c1:: with SMTP id j1mr6799177lfe.442.1632436341844;
 Thu, 23 Sep 2021 15:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com>
 <pull.1076.v4.git.git.1632176111.gitgitgadget@gmail.com> <f7f756f3932cdbca587de397598758c685bac29a.1632176111.git.gitgitgadget@gmail.com>
 <87ee9h8p0a.fsf@evledraar.gmail.com> <CANQDOdeV4JuE8jnkzLmK6VfFj1t-+EOzvn=GD-ejPdS6unc66w@mail.gmail.com>
In-Reply-To: <CANQDOdeV4JuE8jnkzLmK6VfFj1t-+EOzvn=GD-ejPdS6unc66w@mail.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Thu, 23 Sep 2021 15:32:11 -0700
Message-ID: <CANQDOdckziehbqqvAPhy9aJ79TKLaSifgT7ZB553FxzABn_jfA@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] update-index: use the bulk-checkin infrastructure
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 6:27 PM Neeraj Singh <nksingh85@gmail.com> wrote:
>
> On Tue, Sep 21, 2021 at 4:53 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
> >
> > All of this makes me wonder why this isn't using tmp-objdir.c, i.e. we
> > could have our cake and eat it too by writing the "real" objects, and
> > then just renaming them between directories instead. But perhaps the
> > answer has something to do with the metadata issues I raised.
> >
> > And well, tmp-objdir.c isn't going to help someone in practice that's
> > relying on this "update-index --stdin" behavior, as they won't know
> > where we staged the temporary files...
> >
>
> One motivation of the current design behind renaming the files is that
> some networked filesystems don't seem to like cross-directory renames
> much.  It also so happens that ReFS on Windows also prefers renames to
> stay within the directory. Actually any filesystem would likely be
> slightly faster,
> since fewer objects are being modified (one dir versus two).

Whelp, as part of v5 I tried to make unpack-objects.c use the batch fsync
mode and now I see a strong reason to take your tmp-objdir suggestion. As
part of OBJ_REF_DELTA unpacking, we need access to the object while
we're in the plugged state. I didn't notice this at first, but got
lucky that I tested
that case first and hit an error.

V5 will create a tmp-objdir and add a new interface to install it as the pr=
imary
objdir.
