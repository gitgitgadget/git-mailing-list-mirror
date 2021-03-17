Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BA2C433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 09:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3E9F64E21
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 09:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhCQJua (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 05:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhCQJuN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 05:50:13 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB8AC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 02:50:13 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso1029122pjb.4
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 02:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9PMxqd8uUHdLoZxRxNF/DrMMeTWYwTJuz7CqDntF0oE=;
        b=sfL/5yIFScc1h3OylLZ4moT5N4xeAAndK5M/z7Xpihbb5L/c3QSPjDv9d3l1kxy95K
         z27HdVQu/Zv/vhB/jofbuANO8r2EmIVtMRsiy2iy5ElAsmGrPOlt0tL/SKt4QPpxmxsw
         bCyhM5oowAO/yc59KAcqcLNVOTz+w5e2dUiZa+oRhUQ484aQ3x/BBEhXoENO0qbeAVuc
         Bu5m/WUbr6dttd9NMXJESxzQYcab94bVaujtqAnhrSrELU7yMh42Qj2alnCQAsQ2wuzR
         PXwU35bohQ+R3D8lkg0m5CQaAQng1cYeDRc55uy6gSQQAY6sJfGF4E0iny6yW4nW0ZGL
         MGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9PMxqd8uUHdLoZxRxNF/DrMMeTWYwTJuz7CqDntF0oE=;
        b=BX9ofh/WHw+RgagiIrtlcw3euQyMtXzMUYH1vf77v22lD5Rzc4EuT63/rN3LK4zE/2
         2byATBIGgM6qKzwDvm0c6lQ0F9yIura3Y/iLBSUi6EXMlUtU7J98oyYfTKm0AgM9fISO
         3g9zyhc11HHouuN3lNpBbCbz8SV+Hi6SPoKuv2XmcHc1xiqZOn3MuGqDZj5sJCFWVhGm
         3dp0NhYtapx1YPwRpGWy1MJHREiBvQRo5zKSPuQ599uVAFka+uU2H2k1Hz712Qz/sQst
         I+gjpudKMOhcEc3+x2Nu/IAwv0wi5kop+IbY0aKirW2AIrmZzvzxqF4Xb9cyppbj4ef0
         7RZQ==
X-Gm-Message-State: AOAM531+r3OmCSrOVAhFUXQ6eUUttiB3OXj3LgEf5une2b5TFmbX2oyt
        LuqdsjuiA3HB53u8AcC9Pf57zfCXslc=
X-Google-Smtp-Source: ABdhPJxIdFnnixi5fIhkluRgqHf6YO1//Rfccku8dRDpOIuK7Orczhd/pgiaUjEdXLUjJ8oaK3YI0A==
X-Received: by 2002:a17:902:e884:b029:e5:fece:3bb0 with SMTP id w4-20020a170902e884b02900e5fece3bb0mr3880285plg.61.1615974612919;
        Wed, 17 Mar 2021 02:50:12 -0700 (PDT)
Received: from generichostname ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id e65sm20101287pfe.9.2021.03.17.02.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:50:12 -0700 (PDT)
Date:   Wed, 17 Mar 2021 02:50:09 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] Makefile: add 'check-sort' target
Message-ID: <YFHQ0X5m58sTQb0g@generichostname>
References: <cover.1615856156.git.liu.denton@gmail.com>
 <5088e93d76e44de9d079b7b2296b8c810828a2f5.1615856156.git.liu.denton@gmail.com>
 <CAPig+cRM2y15cH5gLvmn5dDa=rafBL53GPua8rmjsTsmkQAkPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cRM2y15cH5gLvmn5dDa=rafBL53GPua8rmjsTsmkQAkPA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Tue, Mar 16, 2021 at 02:37:16AM -0400, Eric Sunshine wrote:
> On Mon, Mar 15, 2021 at 8:57 PM Denton Liu <liu.denton@gmail.com> wrote:
> > In the previous few commits, we sorted many lists into ASCII-order. In
> > order to ensure that they remain that way, add the 'check-sort' target.
> > [...]
> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
> > ---
> > +my @regexes = map { qr/^$_/ } @ARGV;
> > +my $last_regex = 0;
> > +my $last_line = '';
> > +while (<STDIN>) {
> > +       my $matched = 0;
> > +       chomp;
> > +       for my $regex (@regexes) {
> > +               next unless $_ =~ $regex;
> > +               if ($last_regex == $regex) {
> > +                       die "duplicate lines: '$_'\n" unless $last_line ne $_;
> > +                       die "unsorted lines: '$last_line' before '$_'\n" unless $last_line lt $_;
> > +               }
> > +               $matched = 1;
> > +               $last_regex = $regex;
> > +               $last_line = $_;
> > +       }
> > +       unless ($matched) {
> > +               $last_regex = 0;
> > +               $last_line = '';
> > +       }
> > +}
> 
> This is, of course, endlessly bikesheddable. Here is a shorter -- and,
> at least for me, easier to understand -- way to do it:
> 
>     my $rc = 0;
>     chomp(my @all = <STDIN>);
>     foreach my $needle (@ARGV) {
>         my @lines = grep(/^$needle/, @all);
>         if (join("\n", @lines) ne join("\n", sort @lines)) {
>             print "'$needle' lines not sorted\n";
>             $rc = 1;
>         }
>     }
>     exit $rc;

That's pretty clever, thanks for showing me how it's done :)

However, the reason I wrote it out the way that I did is because my code
ensures that consecutive lines matching the regex are sorted but if
there are any breaks between matching regex lines, it will consider them
separate blocks. Just taking all the lines fails in the case of
`LIB_OBJS \+=` in Makefile since we have

	LIB_OBJS += zlib.o

	[... many intervening lines ...]

	LIB_OBJS += $(COMPAT_OBJS)

and that is technically unsorted. That being said, I don't really like
my current approach that much.

I think I have two better options:

	1. Tighten up the regexes so that it excludes the
	   $(COMPAT_OBJS). I don't want to be too strict, though,
	   because if we end up not matching a line it might end up
	   unsorted.

	2. Consider blank lines to be block separators and only consider
	   it to be sorted if the text matching regexes within a block
	   are sorted.

Now that I've written that all out, I think I like option 1 more,
although I could definitely be convinced to go either way.

> By the way, it might be a good idea to also print the filename in
> which the problem occurred. Such context can be important for the
> person trying to track down the complaint. To do so, you'd probably
> want to pass the filename as an argument, and open and read the file
> rather than sending it only as standard-input.

Agreed.

Thanks,
Denton
