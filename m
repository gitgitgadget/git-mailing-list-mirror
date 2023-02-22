Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7895DC636D7
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 01:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjBVBiG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 20:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjBVBiF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 20:38:05 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E91D7DB8
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 17:38:04 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id e21so6531938oie.1
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 17:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mC6WVe4S47U2mRzEs6rKF2LyfX+53X6ypUudhizOuUM=;
        b=D/fnuHlVLgAl22GeIuqb3eO+p3j52cUExhhhLsHIUDguyn22FOpUIzTaazQxQ0OLha
         Ji6Rg+N3lSZl4ALkzA7lWx+xkNGXJ2o3JRwiM0qz0I9jzXNvRJSN9DfLGjHHZ3eTxjPx
         7Mr4BXcv7NCQWg/cguRrskZAzau4mp1Q4Yxci+tAGqH9wOKJ2A4/C/1aNVnAfbv5rSib
         I/+kjY5OdKY/kKavBWmQQRoeBHbf1GirKGDA8iKp6Hcl2rTBLQSQfe5ganto25HnGmK3
         89+VnmM0e8Efl/DDdSxw4nA9qZ1JAT0IEbVy5xKi4YdravtKSF+7HUfAkqsJrvL8ww0c
         5SDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mC6WVe4S47U2mRzEs6rKF2LyfX+53X6ypUudhizOuUM=;
        b=EFYQLPT+CQ8HfkkWPQvTqjIGwiNfwAE2wkwDGrVL3DsXxhjvJg9mbSiVDWvqKP5NZS
         E3tB1ULZvhAfWYpv5UUawk8Vc5pipkzsBSW2gXLjv5fHttoqJhQMFny6K0TBV345p63o
         fT8WilcqJ65B+jxhnaahaJ4Jk4c7GtAlZb4+BkPWHM4wQ+K1rsCz67tZBKIIS/FTlEfD
         KEHfxBtSJgTxEciyElCUg4B2RgHBurzrpA2X+BTzo1wm9uKAlTkrSS3iHpwLUr1edssg
         m/QnxbtNQ3vD1EKcf4UDpFUrUBfIgpOIWWSHv8lXZ+qehAK1gg6MG9mv0dCyEZC0+2pe
         u2cg==
X-Gm-Message-State: AO0yUKXMVxNuxBl3WMTRuIgDvw9m2GMeFlWqOVMQJjctX8BHwa0VpgrY
        BBULMNTX9r/7qrfYfeVpbxP2hlGMgbg4o7gYhKQ=
X-Google-Smtp-Source: AK7set8iFmnXACTc6wNK2oTx/vMYD8DnUsjJ3XbtWxD34Im6PE8+wo610fOtUC8+RsIQzhbuo5uLZ3r3cQ3FotnGxQQ=
X-Received: by 2002:a05:6808:1795:b0:37d:8c44:93bf with SMTP id
 bg21-20020a056808179500b0037d8c4493bfmr654986oib.141.1677029883738; Tue, 21
 Feb 2023 17:38:03 -0800 (PST)
MIME-Version: 1.0
References: <20230221055805.210951-1-alexhenrie24@gmail.com>
 <20230221055805.210951-2-alexhenrie24@gmail.com> <24be0c50-9dfa-e9d9-9d78-1b993832884b@dunelm.org.uk>
In-Reply-To: <24be0c50-9dfa-e9d9-9d78-1b993832884b@dunelm.org.uk>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Tue, 21 Feb 2023 18:37:52 -0700
Message-ID: <CAMMLpeSMO38acvnxK2QX18CdoaEiUojwLsV+AQZYOTe5h4Nq=Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] rebase: add tests for --no-rebase-merges
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 21, 2023 at 4:00 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> On 21/02/2023 05:58, Alex Henrie wrote:
> > +test_expect_success 'do not rebase merges unless asked to' '
> > +     git checkout -b rebase-merges-default E &&
> > +     before="$(git rev-parse --verify HEAD)" &&
> > +     test_tick &&
> > +     git rebase --rebase-merges C &&
>
> I don't quite follow what this part of the test is for

The test is modeled after the existing test "do not rebase cousins
unless asked for". First, it verifies that --rebase-merges rebases the
merges, which in this case results in no changes to the branch. Then,
it verifies that `git rebase` without arguments flattens the history.

> > +test_expect_success '--no-rebase-merges countermands --rebase-merges' '
> > +     git checkout -b no-rebase-merges E &&
> > +     git rebase --rebase-merges --no-rebase-merges C &&
> > +     test_cmp_graph C.. <<-\EOF
> > +     * B
> > +     * D
> > +     o C
> > +     EOF
> > +'
>
> This test looks good. I think we could probably have just this second
> test

I like having a test for the default behavior. Nevertheless, I am
happy to remove that test as requested. Does anyone else have an
opinion?

> and squash this into the previous patch - improving the
> documentation and test coverage for --no-rebase-merges would make a nice
> self-contained commit.

Sure, squashing the first two patches is no problem.

Thanks for the feedback,

-Alex
