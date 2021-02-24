Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6ECC433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C16164ECB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbhBXTWU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbhBXTWH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:22:07 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCEBC061574
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:21:27 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id c16so3298563otp.0
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=89on6bZbyeHY+nE1+ttRmareAM8nFtKLPo8EfLqdkn8=;
        b=cbmJ0rou3sQqtpbrQB2avTMz4zRlVTMCxG3FX+dORpH7JR7/FmzuAjPQbK98q6/pbt
         +fTxweLIL/+9PB6xvMC18LT3E7MxllTKhIRK3gAunoQtc8Aob0f7NolElfTeeOmTX4Z0
         +fNwVfLhww7T7BlFdi7hW4WIAWwIBuULK2jE/WhMC+Z7Dn5KQD/K3uLM/6d0v8Ddzff5
         hIWIMmCiBVDypSSWCvzTu2zFiz1guqWgfh7WrsqdU8Ps4aTjNmwxLBKTn/hA1eOoL/MW
         uXgjzx+Forflc7dNoO7gf7fYf4KBg1hP5rG5YGeqjkrJAjbNKIurUQ4MaipDV7Pu5Nnk
         QoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=89on6bZbyeHY+nE1+ttRmareAM8nFtKLPo8EfLqdkn8=;
        b=hNyWhxZWpurviq22CHMpoHg4kOVkpZtSWzJ0NGr4XWwyE1fbjl47KReUyd3aNHI3g5
         QswJ0P7yDOSPq+YWx7jZUOzagqy6IIt8J95Db/4c7KSIHTNgyBMUI1Wehjq0i1CBhvtg
         5nPfqRq2MtDwcHfhmQ0TXbbxaM+x1fg9bSwQeFtZPpd/TZ5wRuE81KTCs9u1QHoF8K+Q
         pC4fOfViUNHonEXC7Kfo+vZ9pCmM4VVJgcbu12GjGCyBnHVYUGpLgacW73TWTVsbzY89
         9b3iTIKnN7pC8rRl5E3lAOmaPB3l0PvJ6lsu1MBfO/5FaM9ZC4JZR25luXDkVVohZeKK
         lLSA==
X-Gm-Message-State: AOAM532RkMGNxCpXkCqwsTgEkITmIKtsznP03GvZ657GGySZ8f7qK1fV
        KitpyOzBBYRriPXKzfV9FIUbr5tNdontm2oKqro=
X-Google-Smtp-Source: ABdhPJwtdVlorbVignc6XSXTArvI88vBqT0PfCooaxJcN6+htnsf/y4fEXT17betZTIaCWEzsiOSWgjCjty2vqs9u2o=
X-Received: by 2002:a9d:7459:: with SMTP id p25mr13812906otk.316.1614194486421;
 Wed, 24 Feb 2021 11:21:26 -0800 (PST)
MIME-Version: 1.0
References: <AM0PR02MB4081D3C17C53DB5CD9021C5E9C9F9@AM0PR02MB4081.eurprd02.prod.outlook.com>
 <YDYteUnxQZuPIAML@camp.crustytoothpaste.net>
In-Reply-To: <YDYteUnxQZuPIAML@camp.crustytoothpaste.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 24 Feb 2021 11:21:15 -0800
Message-ID: <CABPp-BEKJrRkhb2W0SWpjCawG4ZVs8oVuhQ5SJ+7zT331ybhSA@mail.gmail.com>
Subject: Re: Ort-merge: What does "ort" mean?
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 24, 2021 at 5:13 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2021-02-24 at 10:05:12, Kerry, Richard wrote:
> >
> > It's now been quite a few weeks, probably months, since the
> > "ort-merge" work has been going one.  However, I don't think I've ever
> > seen an explanation of what "ort" means.  I know it means "place" in
> > German, but that seems an unlikely usage because git project generally
> > works in English.  I don't know of it as a word in English.  So maybe
> > it's an acronym - ORT.  But what does that mean?
> >
> > So, can someone please say what "ort" means?
>
> I believe it's a joke.  One can use the -s option to control the
> strategy, so you could write "git merge -sort" to use the new
> implementation.

It actually has meaning beyond being a joke, though:

$ head -n 15 merge-ort.c
/*
 * "Ostensibly Recursive's Twin" merge strategy, or "ort" for short.  Meant
 * as a drop-in replacement for the "recursive" merge strategy, allowing one
 * to replace
 *
 *   git merge [-s recursive]
 *
 * with
 *
 *   git merge -s ort
 *
 * Note: git's parser allows the space between '-s' and its argument to be
 * missing.  (Should I have backronymed "ham", "alsa", "kip", "nap, "alvo",
 * "cale", "peedy", or "ins" instead of "ort"?)
 */

However, I learned my lesson -- Eric is way better at coming up with
names than me[1] so if I need more names in the future, I'll ping him.
:-)

[1] https://lore.kernel.org/git/CAPig+cQ2e4NF6GhRvCTgt1KpPG5Lw_ybPM5FeWtmc69rxvXFuQ@mail.gmail.com/
