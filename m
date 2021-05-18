Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE9FC433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 05:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09CC8611BF
	for <git@archiver.kernel.org>; Tue, 18 May 2021 05:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346442AbhERFEG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 01:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbhERFEF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 01:04:05 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEC7C061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 22:02:48 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso7634351ote.1
        for <git@vger.kernel.org>; Mon, 17 May 2021 22:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=SlE4E0KQ3foZ/cWCh6U5A1UY45EhUwVOvHv4KXUCv4k=;
        b=BnpQ0htVq3kxRYC4jePDCoSagWW4d1d4J5DCGpK2NovS6uB8ascEBkuOxBfbfSkkn5
         mna6bvdoizqUcIM9dBh5F1U+k0LO7s2lxaaFyaMzgiynKN4QffabNDuLBQJ3bCeK9jVw
         N5u1NyZu/5s+dh4n0Sg7gnFXOVH/EE5+gm68dVFNNns2kicB0JOVf8u3GrYgL6rj8HSK
         SEJzclK9H3WPmQ+yPzGT/P2Y1wzCTVf2MSCN+lMmJtK3t443pKpcAfKK2Ht2n4zYVg0h
         x0RlC++/prRimJNmR8NKX+ssDs4SRoNR95Gg26pwKb5IpS6ojAo7BEMOmbEo7dIwtOb8
         mflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=SlE4E0KQ3foZ/cWCh6U5A1UY45EhUwVOvHv4KXUCv4k=;
        b=ukvAjE1C6xm+erApuDT7+9nKMyyup+DUgxOYCPTwUzp4JG3OOr0R1RiCk8qbU6+UWD
         BNsxaqX6MAjAQMahEqiLTDfXP4xOgsK/pDqTwTBxtNwdqvTyp+Qzix1lV+8Jq22TSDct
         jws0MeYckjxYs74ep2alyZcCIrxHX9cwVG07iXYbcMLl9so4IqSMLyky4KIZEgi4/CY8
         1eVuNtcSoiJ+Gmnqve5nZ++RksmhQt/mxOlsvxeCy5YpKSSBtmibZA6sgh8Ls1AawpfB
         +raGRlGPz5GjUuIkSR0HcTOQ5OUBwjL/WtHD2HX6IdC880BPe/1MtuUrEs0zN6d0vTtY
         501Q==
X-Gm-Message-State: AOAM531HBftjlIl54Hpm44AKcIvnqmHiAb1eqcivkJpJplcCJaPHUBDU
        wDeOW5obRw320saxPt/rrIQ=
X-Google-Smtp-Source: ABdhPJzp8TLRbbDszBDPhCcradf/meN4XMPVWlw9qplZawfyDnr3lkTfma3hiwQQZODIUebedu98CQ==
X-Received: by 2002:a05:6830:1d5c:: with SMTP id p28mr2781170oth.280.1621314168001;
        Mon, 17 May 2021 22:02:48 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id l8sm1862866ooo.13.2021.05.17.22.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 22:02:47 -0700 (PDT)
Date:   Tue, 18 May 2021 00:02:46 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Richard Hansen <rhansen@rhansen.org>
Message-ID: <60a34a7616cda_14d1bc20818@natae.notmuch>
In-Reply-To: <YKMhqZNhamnKqWfi@coredump.intra.peff.net>
References: <20210516203736.1098072-1-felipe.contreras@gmail.com>
 <xmqqbl993irp.fsf@gitster.g>
 <60a245a927c62_126333208ea@natae.notmuch>
 <YKJZt4vFECoLZhc2@coredump.intra.peff.net>
 <xmqqpmxp6u13.fsf@gitster.g>
 <60a2daa57d8a6_13c370208f3@natae.notmuch>
 <YKMhqZNhamnKqWfi@coredump.intra.peff.net>
Subject: Re: Re* [PATCH] doc: glossary: add entry for revision range
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Mon, May 17, 2021 at 04:05:41PM -0500, Felipe Contreras wrote:
> 
> > > >> Nobody uses "origin" (what does that even mean?), [...]
> > > >
> > > > I guess I'm "nobody" then, because I use it all the time.
> > > 
> > > Oh, I'm nobody, too, and so are many others ;-)
> > 
> > That depends on the definition of "many". My guess is that it's less
> > than 1% of users (probably 0.01%), and for me that's not many.
> > 
> > If you google for `git remote "set-head"` there's barely any
> > information. It's basically all online man pages.
> 
> Why would people need to use "git remote set-head" most of the time? The
> symlink is set up properly by git-clone, and has been for many years.

First instructions from GitHub:

  echo "# test" >> README.md
  git init
  git add README.md
  git commit -m "first commit"
  git branch -M main
  git remote add origin git@github.com:felipec/test.git
  git push -u origin main

Second instructions from GitHub:

  git remote add origin git@github.com:felipec/test.git
  git branch -M main
  git push -u origin main

None of these use `git clone`.

Of 31 repositories I work on and have quickly at hand only 8 have
origin/HEAD.

> For most people, using "origin" just works (the exception is people who
> "git init" and then "git remote add origin" themselves; since we're
> guessing at numbers, I would guess that _that_ population is less than
> 1% of users).

On what do you base that guess?

The GitHub instructions don't use `git clone`. I can gather similar
instructions from other places if you are unconvinced.

I don't think most people set up their repositories as you think they
do.


And even *if* origin/HEAD did work on most repositories (hardly the
case), most people are not going to train their fingers to type `git cmd
$x` when the only $x where the command works is "origin"; they would
rather train their fingers to do $x/master which works on many more
repositories.

Cheers.

-- 
Felipe Contreras
