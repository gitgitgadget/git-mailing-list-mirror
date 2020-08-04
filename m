Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C96C433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 05:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 320EC206F6
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 05:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZtDS+ad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgHDFXP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 01:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbgHDFXO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 01:23:14 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90753C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 22:23:14 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id p25so20452091vsg.4
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 22:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Glvre7hafbBALgfjkB+egclwS1F3ahI13o7pqMUcS1A=;
        b=NZtDS+adBY1jnIQuhAAvR6pxYp9OBIQ2N+TPbqdB5sYfnfaWcTMaa3FeSD35Ev46PQ
         dYKuIZRqpmWQsCnTWeeyj48sB8q3RQoAzpVFY/fgTb9qMVBNjYFGQx3KYALU78xA4YDT
         1GQfvlhLi7lBFjZ5/BDKu2OrMynnEQpzLcieDCeqPjyzJIT9PcYTwYuFHQLj5B0Dr838
         SHBo95jO26Lp1RmzvYrxmxVnUsrhw5DSo/auG8Ri8kK1capS7cftLWDDxcBX6Uwbbs1W
         4Ws+upfSbjbG6vuo/FVpz1B741jaEqFxMkJI78iPAnYkXwuDrEghh5txz2Dkch8OojFl
         IKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Glvre7hafbBALgfjkB+egclwS1F3ahI13o7pqMUcS1A=;
        b=sUcYee4dxwmjE8A5frja3BDjXH/qIM0X12fdnOUIJDlTXIU4j+SSrSUjBqybCmaLcI
         oU1dfWJQMpc6P/gw0eFYrRhTK+wn1tEp8fUyJ0ujNEIUm8gDc0l381ZdMGt3EzoNnO1x
         oKgbA5887BdOA8Y1mW11ksZUiCpUl9vneM46lGZXKkwldeMdVcpOpCvQESvz3AaD1E05
         iPsNOa2eeYNoHJov6g9FCw7qp2jO2pprnSd7jw265puYFolX5FOpWAIdEhdhTzxYkHCU
         ZyuBVV8a6YZrZcM/70PIkxEIqXUbhekVQKul0l1ab0gnz5cU7TA83+sP0Y13Ajm/o5dQ
         3T4A==
X-Gm-Message-State: AOAM533RwiJsE11diPhh0SwQbOCKuswZkPmvma0DCO0EBxMyWZKhQqb8
        fDI0Oy3YXSja6YpfSZDV8u6Q9sr9UMbWeA6qcp4=
X-Google-Smtp-Source: ABdhPJxevYvp6UOldREU/4dB3OSpC5H13d3OmMXO2Tw2Np7rniHAHJWbXjfEcRdAotXq7xcfkFjRlOvPjnUW8MQMRzU=
X-Received: by 2002:a67:7fc8:: with SMTP id a191mr13691781vsd.85.1596518593763;
 Mon, 03 Aug 2020 22:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200803053612.50095-1-sunshine@sunshineco.com>
 <20200804005535.5126-1-sunshine@sunshineco.com> <CAN0heSpO4ocUTv2BSAOkRsuEX59V7phKn1=Y-PU2qq0POhp1Rg@mail.gmail.com>
 <CAPig+cS2jsmYkpf5+Kob2w09UKQgBvM5wjOV-bS-fVOK5KGhyA@mail.gmail.com>
In-Reply-To: <CAPig+cS2jsmYkpf5+Kob2w09UKQgBvM5wjOV-bS-fVOK5KGhyA@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 4 Aug 2020 07:23:01 +0200
Message-ID: <CAN0heSpMFULN2O7-Z1=eDJaw5mZqAnR8rVg1V8JT5N0ER5MCxw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] git-worktree documentation cleanups
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 4 Aug 2020 at 06:44, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Tue, Aug 4, 2020 at 12:29 AM Martin =C3=85gren <martin.agren@gmail.com=
> wrote:
> > On Tue, 4 Aug 2020 at 02:56, Eric Sunshine <sunshine@sunshineco.com> wr=
ote:
> >
> > > -By default, the repository "config" file is shared across all workin=
g
> > > +By default, the repository `config` file is shared across all workin=
g
> >
> > I don't think this is a filename (in which case it would have been
> > `.gitconfig?) but rather some sort of colloquial short form for
> > 'configuration file', thus '"config" file'. So I could see the double
> > quotes remain or being dropped, but I was surprised to see them
> > converted like this.
>
> I also thought at first that it was just shorthand for "configuration
> file", but then I realized that it's talking about the `.git/config`
> file, in which case it is an actual filename. So, I believe that
> quoting it with backticks is correct here.

Yes, you're perfectly right, of course.

Thanks
Martin
