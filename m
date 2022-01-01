Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED3CC433F5
	for <git@archiver.kernel.org>; Sat,  1 Jan 2022 20:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiAAUT1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Jan 2022 15:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbiAAUT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jan 2022 15:19:26 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF191C061574
        for <git@vger.kernel.org>; Sat,  1 Jan 2022 12:19:25 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id z29so120422024edl.7
        for <git@vger.kernel.org>; Sat, 01 Jan 2022 12:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QxnnVgD8D1GbFczFv5SPwNRzcGls2U20fEkHyrh7WCs=;
        b=ki2H+lm/SPtDyIcKYeixCdcFCxtzq73xDKEI2PP0DOFVDcdA0ZwPHqxnqTWbMhVBtG
         8F/yyMqnAYgrP8Y5SrpjZDlCSfzMhgk/dPxjQIGd54pwDKxRcA8i6Wq82f9HzWYojw0+
         6kkO6SP/9LiWMT1L/8tahiPzvAhHRRBWIk4w57ERwmEiVtnk8G1YlWglAoXUXHHEjcVb
         297Hh4Hq+jxCKG4zKulz4DLVH0j8TAkLPeMTrgLaQ4+pLxkvCVc60AJiXgTjJseEtrs9
         WNTbapzwIixcGTBIjw+xbBMQtCZZCCWGbkcgxjTdEa5usy02P7G/zExREiWmAH8oMTs6
         xtFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QxnnVgD8D1GbFczFv5SPwNRzcGls2U20fEkHyrh7WCs=;
        b=IjKkDfT5ewF4Av1GGGELjtWxDxQ5oDT2Phg/+EkVd6xwmIdcCXlAJtj4NZ9Ifbq2E2
         0HEpE6rmfALpuXqGwaQt2b8Tk6zdVn8jzKyUZ1D9SSL0+n4lnfvN5pEHhagbEss+8FAf
         NnScAw6S8Ypp42zHQuBFz7BPHAREe5uHCFb8ec55FEK+lcMgZY+ZGZhest2/61d00Jj6
         SDSEqRiAE9uW9a5h7nFp9q1mtOkWAyR0eA6m6Ey8SdPn5QvEwyQnxNRu58SeNeT4p4Xp
         Gyjzc136i/XA/mDgTeT8N0y5d7o4gwm6n54KvheBiC5s8WJoNVi5d3bcJNaDst5m8R+u
         KBqg==
X-Gm-Message-State: AOAM531jH20saW+c6UAdYPm9rvlbaZpq1gK+B26BDJ+v9hDCZwrq6lJK
        KkE/SAkkKxhNo3fX1xQ5lUf48yXZmUaDWTwR7dPLikXXEtQ=
X-Google-Smtp-Source: ABdhPJzIN3T9K0GoWBiNO6EYJLeZzzzOcS/MffWmdNg0XrK7mJqZ4ZcAI4rTWBDEPG7947wbNEfobaCbV6FtnbGH9LE=
X-Received: by 2002:a17:907:160e:: with SMTP id hb14mr31753814ejc.328.1641068364495;
 Sat, 01 Jan 2022 12:19:24 -0800 (PST)
MIME-Version: 1.0
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
 <32ad5b5c10da7204dc4a2d3ca74f8d73745925a7.1640927044.git.gitgitgadget@gmail.com>
 <20220101200836.msaewswefs5uvkyq@gmail.com>
In-Reply-To: <20220101200836.msaewswefs5uvkyq@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 1 Jan 2022 12:19:13 -0800
Message-ID: <CABPp-BE8+kRLtEG2OVULGJ7UWX6FFKdoAU_=sMAbmiXPMuafAA@mail.gmail.com>
Subject: Re: [PATCH 6/8] merge-ort: allow update messages to be written to
 different file stream
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 1, 2022 at 12:08 PM Johannes Altmanninger <aclopte@gmail.com> wrote:
>
> On Fri, Dec 31, 2021 at 05:04:02AM +0000, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > This modifies the new display_update_messages() function to allow
> > printing to somewhere other than stdout.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  merge-ort.c | 7 +++++--
> >  merge-ort.h | 3 ++-
> >  2 files changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/merge-ort.c b/merge-ort.c
> > index 6237e2fb7fe..86eebf39166 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > [...]
> > @@ -4271,6 +4272,8 @@ void merge_switch_to_result(struct merge_options *opt,
> >               trace2_region_leave("merge", "write_auto_merge", opt->repo);
> >       }
> >
> > +     if (display_update_msgs)
> > +             merge_display_update_messages(opt, result, stdout);
>
> is it intentional that the previous patch doesn't have this call?

Ugh, oops.  Yeah, bad split of the patches; this should have been part
of the previous one.
