Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670F7C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 21:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C57560EBA
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 21:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243694AbhHZV0V (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 17:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbhHZV0U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 17:26:20 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D97AC061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 14:25:32 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id j13so1379970edv.13
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 14:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4mWOg6jwdDYXzc1NAB9X/PkeXDFG6rMJ3lw/25ji5OE=;
        b=vTNDI2XT/cxesowyHjQpncFK14NnHhnyjr4xt+1DxFchvG0x2kMt0lhFODZGYmfCie
         MpveZvsycxqgtKWDObN0wY2hlh3/GXjpZerU6Ubd7oLBboZpa2QhmtU9rieTskE6JBjo
         teSKljbQE+96cl+jmib1Oxi5frsu9/pjOBRrujtMSUkBGbDv4ee1SFKIklqIksRKNSJJ
         jYBowoPLMuFs8M5QH+ovU5dXlXG4SLs9G/twlOwbPU9v5pt0R7anYaK7m6bRX6xp59jj
         DLHm6fynZFFhGv62Ef2lGlayVlVVcr3F2NcU0LXnPBH8CR35zPbFMOkvSEzcl2HhZFnx
         NXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4mWOg6jwdDYXzc1NAB9X/PkeXDFG6rMJ3lw/25ji5OE=;
        b=JkxbBhF4g4+F6vTRITdILFl38d+lcQyPD5a2ScZu4AI8GIaGlcWaQ+sfY1qGJGBA+W
         kGmosdHt4VEjHp4ZwLjyJhK2Ig+2Ib1qDWRYdNAo+evFFsFEy29Ip+Hli6ZJy2OqsQwN
         VOEgxIGuZOC3E4zSSVklKFBcBIT9nL0Xopw/uVzyVAFWt4eRsGdrR5SnhPDLBUh/Vws3
         GEGOVE7UPG9xe9y5hDSbcJ/UvrdN9Iz/iqHu14zwPBZg/IehokCfwaHtheE6KfkPhIn0
         +jXaYn708u3i5Hln4hZwbNmSFkaK/2FTdDcOPQjieoyaElyoDYO8d3Wgr6BOsVjjVvCc
         CS3w==
X-Gm-Message-State: AOAM531UpjSpL3kehXUhohnd+2HNoJcpnz+nOUtfwj6b/kWN7bKzZiFc
        WG+OX0xh+dmnO8q73UJAj0boPc6yk/Y=
X-Google-Smtp-Source: ABdhPJxoc0xUOzUrzK18Yi65poZOd1lapHjeTFAXa69kkGMfIvM5IlJQAbxsl+017qmqDai9UnKwFw==
X-Received: by 2002:a05:6402:366:: with SMTP id s6mr6186535edw.329.1630013130976;
        Thu, 26 Aug 2021 14:25:30 -0700 (PDT)
Received: from szeder.dev (84-236-78-211.pool.digikabel.hu. [84.236.78.211])
        by smtp.gmail.com with ESMTPSA id s20sm1821795ejx.82.2021.08.26.14.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 14:25:30 -0700 (PDT)
Date:   Thu, 26 Aug 2021 23:25:29 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] column: fix parsing of the '--nl' option
Message-ID: <20210826212529.GF2257957@szeder.dev>
References: <20210818092456.3045808-1-szeder.dev@gmail.com>
 <xmqqy28y4gqt.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqy28y4gqt.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 18, 2021 at 01:53:14PM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > 'git column's '--nl' option can be used to specify a "string to be
> > printed at the end of each line" (quoting the man page), but this
> > option and its mandatory argument has been parsed as OPT_INTEGER since
> > the introduction of the command in 7e29b8254f (Add column layout
> > skeleton and git-column, 2012-04-21).  Consequently, any non-number
> > argument is rejected by parse-options, and any number other than 0
> > leads to segfault:
> >
> >   $ printf "%s\n" one two |git column --mode=plain --nl=foo
> >   error: option `nl' expects a numerical value
> >   $ printf "%s\n" one two |git column --mode=plain --nl=42
> >   Segmentation fault (core dumped)
> >   $ printf "%s\n" one two |git column --mode=plain --nl=0
> >   one
> >   two
> 
> ... and another thing to notice is that number 0 would have meant
> "use LF" due to columns.c::print_columns()
> 
> 	nopts.nl = opts && opts->nl ? opts->nl : "\n";
> 
> which is the same as the default, so it is not likely that people
> have (mistakenly) used to trigger NUL terminated records, or
> anything fancy like that.
> 
> > Parse this option as OPT_STRING.
> 
> So a possible "regression" by this fix could be that those who took
> advantage of the fact that --nl=0 is an absolute no-op would
> suddenly start seeing their output terminated with a digit "0".  I
> would have to say that it is not all that likely ;-)

Yeah, I doubt that it's worth worrying about.

> I agree with Dscho's comment on the test script addition, but other
> than that this looks good to me.

Eleven other tests look just like the one I added.  I really don't
think that doing it in some other way would gain us anything, but it
would be inconsistent with the rest.

> > Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> > ---
> >  Documentation/git-column.txt |  2 +-
> >  builtin/column.c             |  2 +-
> >  t/t9002-column.sh            | 18 ++++++++++++++++++
> >  3 files changed, 20 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/git-column.txt b/Documentation/git-column.txt
> > index f58e9c43e6..6cea9ab463 100644
> > --- a/Documentation/git-column.txt
> > +++ b/Documentation/git-column.txt
> > @@ -39,7 +39,7 @@ OPTIONS
> >  --indent=<string>::
> >  	String to be printed at the beginning of each line.
> >  
> > ---nl=<N>::
> > +--nl=<string>::
> >  	String to be printed at the end of each line,
> >  	including newline character.
> >  
> > diff --git a/builtin/column.c b/builtin/column.c
> > index 40d4b3bee2..158fdf53d9 100644
> > --- a/builtin/column.c
> > +++ b/builtin/column.c
> > @@ -29,7 +29,7 @@ int cmd_column(int argc, const char **argv, const char *prefix)
> >  		OPT_INTEGER(0, "raw-mode", &colopts, N_("layout to use")),
> >  		OPT_INTEGER(0, "width", &copts.width, N_("maximum width")),
> >  		OPT_STRING(0, "indent", &copts.indent, N_("string"), N_("padding space on left border")),
> > -		OPT_INTEGER(0, "nl", &copts.nl, N_("padding space on right border")),
> > +		OPT_STRING(0, "nl", &copts.nl, N_("string"), N_("padding space on right border")),
> >  		OPT_INTEGER(0, "padding", &copts.padding, N_("padding space between columns")),
> >  		OPT_END()
> >  	};
> > diff --git a/t/t9002-column.sh b/t/t9002-column.sh
> > index 89983527b6..6d3dbde3fe 100755
> > --- a/t/t9002-column.sh
> > +++ b/t/t9002-column.sh
> > @@ -42,6 +42,24 @@ EOF
> >  	test_cmp expected actual
> >  '
> >  
> > +test_expect_success '--nl' '
> > +	cat >expected <<\EOF &&
> > +oneZ
> > +twoZ
> > +threeZ
> > +fourZ
> > +fiveZ
> > +sixZ
> > +sevenZ
> > +eightZ
> > +nineZ
> > +tenZ
> > +elevenZ
> > +EOF
> > +	git column --nl="Z$LF" --mode=plain <lista >actual &&
> > +	test_cmp expected actual
> > +'
> > +
> >  test_expect_success '80 columns' '
> >  	cat >expected <<\EOF &&
> >  one    two    three  four   five   six    seven  eight  nine   ten    eleven
