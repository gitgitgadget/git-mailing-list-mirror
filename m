Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D30FC433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 10:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1352661244
	for <git@archiver.kernel.org>; Wed, 19 May 2021 10:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347969AbhESK0y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 06:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345613AbhESK0y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 06:26:54 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D99C06175F
        for <git@vger.kernel.org>; Wed, 19 May 2021 03:25:32 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id t17-20020a4a3e110000b02901fab2f46a48so2890503oot.6
        for <git@vger.kernel.org>; Wed, 19 May 2021 03:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=iVpIxcMx3z9kH7WROMKTn4/DJc/fWp68fvV1FaBasIM=;
        b=OVjBIbtycY07VIxKq9/E4k9s/qe+p3R9KED8g0J4QT9FHzBPr5DBfttbVzd/+FKW/T
         2LKz/8AqqelbpyE4Q5Jbr7N3cbGsWsV6xsXAIDFhi3iw3GTK96n2i3iIRHOM5tqqQ3Sg
         H8IE96oEtum+H3zhYPtN8x1u+oXy0Qk6rcWWL+XjA4gBAOLWt+W3dyU5hNjgO1laBrUj
         zQEhZQ7nOj/27G7AuuoGlAGlEYiXbStfcRox67fIyCvS9r7ETO1b5J2+LyWLpV2cnkES
         zXOwU+Og2pgHGb6t0A3ynI78pcntJ2G3KfmS2KW84ZsT8Q1XERrWYNfbNJ7DyiF1mP/N
         Qx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=iVpIxcMx3z9kH7WROMKTn4/DJc/fWp68fvV1FaBasIM=;
        b=fcs4UZ1IDDIV7dJcFgO4TD/b7murweAnlE54F0+UJmxyPFUOncOGHS62If/w4CIpLq
         XST0r7+aIhWQuBlVNY8nAiQhY9JKm45NPYfZJoPFGQs6wo6Fk8H8MZmoQxnglKGs4hfY
         IbVRrDqpp3NJWxnmJyAd+flBMhYRu/d00t2Ljae8Nnl/ukG+RNOn0xf+u8XgcFYSNCzu
         DrgMe97z27zLC85/4GbfsI143AJqb6JPeiyYO4Kt9Srv8NBrfwltjKGeWxOzFklNN8zk
         hdgpqq/xGdlbkI44aN1eymLmdK64gZOCpz59orNQPbDj2Tt2Oh8fvSBdOzqvBtDZynoQ
         MbBA==
X-Gm-Message-State: AOAM533IVeMY38oLDLEEwYB00qZqBe225iIWXuv1MX8npTFqVHNiN9nN
        iwaJBIrMraTrH3bW0otWpyQ=
X-Google-Smtp-Source: ABdhPJz/tz1ekVilrPcm3aQq2335lZCDFsrGoiodn4ym4f+hC+3JBr0QCEQSE7V542tkBQeA4M/Row==
X-Received: by 2002:a4a:b202:: with SMTP id d2mr8354947ooo.13.1621419931646;
        Wed, 19 May 2021 03:25:31 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id a14sm4338135otl.52.2021.05.19.03.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 03:25:31 -0700 (PDT)
Date:   Wed, 19 May 2021 05:25:29 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Message-ID: <60a4e799ce22e_86a8208b7@natae.notmuch>
In-Reply-To: <YKRSlFcFAcHcR3uY@camp.crustytoothpaste.net>
References: <20210518010121.1350327-1-felipe.contreras@gmail.com>
 <YKMWL0iZLVl1KTrB@camp.crustytoothpaste.net>
 <60a332fd22dad_14c8d4208ed@natae.notmuch>
 <YKRSlFcFAcHcR3uY@camp.crustytoothpaste.net>
Subject: Re: [PATCH] help: colorize man pages
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:
> On 2021-05-18 at 03:22:37, Felipe Contreras wrote:
> > brian m. carlson wrote:
> > > I think we should let the user decide whether they want to set this
> > > feature themselves instead of setting it for them.  For example, I have
> > > specific colors set up with these environment variables, and I'd like
> > > Git to honor them without having to configure Git independently of less.
> > > I expect other users will expect Git's rendering of the manual pages to
> > > work like other instances of man(1) on their system as well.
> > 
> > It does respect them.
> > 
> > This would render the man page with the color specified in the
> > environment, not the default of git.
> > 
> >   LESS_TERMCAP_md=$'\e[1;33m' LESS_TERMCAP_me=$'\e[m' git help git
> 
> It still doesn't work like other instances of man(1) on the system.
> While you claimed that "that's a preference others don't share", I'm
> pretty certain that I'm not the only person who feels this way.

Two people feeling in a certain way is not an argument against a feature
that could potentially benefit millions of people.

> There's a big difference between Git coloring a Git UI, like a diff, and
> Git coloring a separate program that already has sensible, standard
> defaults.

Would you be happier if I implement an entirely new library to render
asciidoc documentation in a pretty way and make `git help` link to that?

That way we wouldn't be using "a separate program".

> A user who has not configured any color settings would
> probably not want Git to render manual pages one way, cargo to render
> manual pages a second way, and still other programs to render manual
> pages in other, incompatible ways.

That is one opinion. Again, not shared by everyone.

> Would you consider various projects coloring their respective manual
> pages differently to be a desirable state of affairs?

That is irrelevant, because we are not talking about `man git`, we are
talking about `git help git`, which can render help in a variety of
ways.

You can do for example `git -c man.viewer=woman help git`, and the
result would be *completely* different from what the user sees in `man
git`.

A different thing is different.

Would you be happier if we enable this with `man.viewer=mancolor`?

> > > Additionally, using colors poses accessibility problems.  I know someone
> > > who, due to his colorblindness, finds terminal colors distracting and
> > > hard to read, and prefers not to use them at all.
> > 
> >   git -c color.ui=never help git
> 
> Yes, but unfortunately, since you've colored the manual pages, they may
> be hard to read for the user who needs to read them to learn about your
> configuration.

man git

> > > Even users who want to use them might find some colors to be too
> > > similar, and this patch doesn't permit them to be configured.
> > 
> > Yes it does:
> > 
> >   LESS_TERMCAP_md=$'\e[01;38;5;33m' git help git
> 
> I should clarify that the patch doesn't permit them to be configured
> using the normal Git mechanisms.  For example, unless the user sets the
> environment variables, which take effect globally, they're stuck with
> the colors that we've chosen here.  Yes, they can specify a single
> environment variable before the command, but practically nobody will do
> that.

If you don't like the colors they can disable them.

They lose absolutely nothing from the state of git 2.31.

> It's my argument that the user doesn't want Git manual pages to be
> colored differently than other manual pages on the system,

/usr/share/man/man1/git.1.gz is not changed.

> > > In my particular case, despite having normal color vision, because I use
> > > a transparent terminal which often results in a grey background, I find
> > > the standard terminal red to be difficult to read, and so this patch
> > > would result in a significant decrease in the readability of the manual
> > > pages for me.
> > 
> > If you have LESS_TERMCAP_md set in your environment, it won't.
> 
> The problem is, I don't always.  I am on call for a set of hundreds of
> servers, only one of which has my shell configuration set up, so
> defaults here matter.

Surely you can live typing `man $x` instead of `git help $x` for a bit.

> Moreover, because there are many novice users of
> Git, we should consider that for a decent number of users, they
> literally won't know where to look in our documentation to make
> changes, and therefore the defaults matter for them, too.

And we are considering them.

But the defaults are for the majority.

-- 
Felipe Contreras
