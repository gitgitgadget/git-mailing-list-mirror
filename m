Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E9DC433EF
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 06:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240228AbiA2GWF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 01:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbiA2GWE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 01:22:04 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DFFC061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 22:22:04 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id j2so14407137edj.8
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 22:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zQdc0Q4u8jNaJTGIzN1suD+LfCRzp1m68o6Q3+EfcgM=;
        b=Jc5Dha3XWdMeYFQoyklcpgAL781rYQFLqIEJSSTtForlLcZD67sOFfly3HHr9oTy79
         hreA8B2zjL2TbvT6qdpcHoO/us7Z6PXOJGL5ssF5y6y1LGkIdv5jHyoNCq3uc4L4DqUK
         4sOepg9LA37cUvVCy2CwOHDuIRDuq5b24GZ5Rs5dbxNFYZtZJ2HUVXoZEOjga4kMA5Dl
         S2Oo6z68OCuTUr42ZMJSIZI67WvVB6XMgFPvth755+Cy9zdyYgAl7eDD20+3VfAPzPht
         eDAVa8Y+MsmBkyVIlmDheTnP5jHepGiM9/iAAPrEHyNkaJNf5m8pBKS5PztpfnO9pL/a
         yAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zQdc0Q4u8jNaJTGIzN1suD+LfCRzp1m68o6Q3+EfcgM=;
        b=TZ7+89ZA92gGjoeqLKvI0hWVPSp8j6mpEwBkUnVsJha2d7WaOOuzWzEyneHSOGh3SY
         EgzrehNT7IIfQ2btyFlDckZwHd/uqaihS0Q+bGk3UaJHtp1pQXJJ3oltLEM7P7ZLcO/y
         7YRf95D31Z9GvEogZNWZtI9WlSBIBP72Zr2sgBfS5At3j1NaPHHX/+mTTDZ7y173Qo1+
         GtndpHzH1taRd8bgnE1gL9vbnDPt/I2Y2lcnzhvlASYxq/BtP16yWa2wulPcJYPb9ZZe
         zdMuTeBcIlsMuZxHfSeJs35YTiSjH6x5hjyqArls4/85ewRgXEpwoz5lskSTNO0O8fsO
         7SqQ==
X-Gm-Message-State: AOAM530+IalgDMtYv8CR/5rEOukvcJRvQzBv9RLXqIiman/6EsNbrUUq
        kMOJiMYqWlECvvmuiSt+yy5JmkwKQ77qoqJ/cla4oNk3
X-Google-Smtp-Source: ABdhPJw7TqepM5Uz6th91gWQKHUy9cYK2eNgq9/ox+tUBYjl6cJ6+IKasZ7VjL99L61H1EemuoWGbr0hmkLCxjQRdCI=
X-Received: by 2002:a05:6402:84f:: with SMTP id b15mr5001113edz.206.1643437322804;
 Fri, 28 Jan 2022 22:22:02 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <fcbb087fa8865ac05e20473d822cd9795590ee38.1642888562.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2201281755200.347@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2201281755200.347@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 28 Jan 2022 22:21:51 -0800
Message-ID: <CABPp-BEn=fvmTyYEzjSfvKkYyHj0te=6ck6WF+Jor+L1jKrVkg@mail.gmail.com>
Subject: Re: [PATCH 09/12] merge-tree: provide a list of which files have conflicts
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 28, 2022 at 8:57 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Sat, 22 Jan 2022, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
[...]
> > diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
> > index fd7a867de60..041a4ac2785 100644
> > --- a/Documentation/git-merge-tree.txt
> > +++ b/Documentation/git-merge-tree.txt
> > @@ -58,6 +58,7 @@ simply one line:
> >  Whereas for a conflicted merge, the output is by default of the form:
> >
> >       <OID of toplevel tree>
> > +     <Conflicted file list>
> >       <Informational messages>
>
> To distinguish between the list of conflicted files and the informational
> messages, I think it would be good to insert an empty line, as a
> separator, like.

Yes, I agree; that's why I did so.  :-)

[...]
> >       if (o->show_messages) {
> >               printf("\n");
>
> ... it seems that we do this already...

Yep.

[...]
> > diff --git a/t/t4301-merge-tree-real.sh b/t/t4301-merge-tree-real.sh
> > index c34f8e6c1ed..43c9950dedb 100755
> > --- a/t/t4301-merge-tree-real.sh
> > +++ b/t/t4301-merge-tree-real.sh
> > @@ -94,6 +94,8 @@ test_expect_success 'test conflict notices and such' '
> >       #   "whatever" has *both* a modify/delete and a file/directory conflict
> >       cat <<-EOF >expect &&
> >       HASH
> > +     greeting
> > +     whatever~side1
> >
> >       Auto-merging greeting
> >       CONFLICT (content): Merge conflict in greeting
>
> ... as illustrated by the test, too. I guess the documentation should show
> the empty line, too?

It does:

    Informational messages
    ~~~~~~~~~~~~~~~~~~~~~~

    This always starts with a blank line to separate it from the previous
    sections, and then has free-form messages about the merge, such as:

The newline should not be split out separately, because --no-messages
suppresses the newline.  (Without the messages section, the newline
isn't needed.)
