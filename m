Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9904C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 11:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91A3723A82
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 11:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgLRL7l (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 06:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgLRL7l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 06:59:41 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2868C0617A7
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 03:59:00 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id l207so2541912oib.4
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 03:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=PYFaP87/a/WP/n6GWV1P/IQc412n/ymqWMQ5d89tPq8=;
        b=Bx4KJH4RMudQ4aj0D8O6mviFNaVrsPnVwHRWoRUTCm4030By9TdD5NM2ii2Tetx2Gr
         F1s0qSl7oD4l/JyNkr/stQ9HNOtEPKZkdzyrcmDolwsaa4M5ri+dw+0PSYZOs5wp9chO
         gI3oaUzqKC9xy6Z6YDYS410ijZI4GI/AgVqwAyPxmD4Gygg2Iq2VxcwaZhM1XCh1ZX8F
         XycZVyGpff3EMpJiKDpgarOkpDuDPuJmU2NyWpjRHTPO0VIgNNY6gMeh0e5rm8hTK2gr
         Nuxnl4qulwsdTwHi2lL3GWYlBXa2D1Txh9JosypgIJ6WvHE8jrwPiP6QEi6ZFR458y2X
         K94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=PYFaP87/a/WP/n6GWV1P/IQc412n/ymqWMQ5d89tPq8=;
        b=R1Sz7DzD0uIddBKxR2ITPkTZDXjyLVvRY0GXdlb+GjMMfRdSBypbWsoUpZtEN0fpKY
         +25uKgtHnPFp2NkM7d2OcMGAVcsQjsZ5Z3Czw+aFeSfZdiL0g9553MAp1m2hfCJophZE
         nuJoS+mSJsaz/Yg7SG7Wc7objc+hO/3fG72JVmNtLLJR6KNgy3XpwO43lupdpYA7hes7
         herI6+PGdeNljDrdBg8IHqLmD1bO7od8UcilW8v8O30PkP5JT2qAD+7LEZTrPyGFQdu9
         McTLfLqHHAyANR/XqXTFwGOXSVMBHWSQfWu4Jg6FF4qXEtOjJSzLa/OOmA3a1+u3n92T
         D/oQ==
X-Gm-Message-State: AOAM533SYEJCxoO3GRC9LyqTX+4+F3zyjqb0Yr+oImDYHEVQtJDaB9nv
        /hTHb4m8M+Qos4HgUrY54vE=
X-Google-Smtp-Source: ABdhPJxBIOCZm9NzQUzScehs+U2BrDtd2PulmQrmEaHdVfv3rRggc4lfIyQzuZA8xW6zKru4kCV9ag==
X-Received: by 2002:aca:aa83:: with SMTP id t125mr2347009oie.103.1608292740330;
        Fri, 18 Dec 2020 03:59:00 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id l73sm107246ooc.43.2020.12.18.03.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 03:58:59 -0800 (PST)
Date:   Fri, 18 Dec 2020 05:58:58 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Seth House <seth@eseth.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>
Message-ID: <5fdc998216c89_104e15208da@natae.notmuch>
In-Reply-To: <xmqq3603v3a0.fsf@gitster.c.googlers.com>
References: <xmqqa6ud2xuw.fsf@gitster.c.googlers.com>
 <105041520.23756286.1608159189934.JavaMail.zimbra@eseth.com>
 <5fdaef83a40ba_d0e26208f6@natae.notmuch>
 <e5c73fed-b87e-2091-794e-19aced4dd25b@kdbg.org>
 <20201217094424.GA75257@ellen>
 <5fdb3471c6bb7_d6d032087@natae.notmuch>
 <20201217175037.GA80608@ellen>
 <5fdc0e6dd79a7_f2faf208a1@natae.notmuch>
 <20201218023534.GA117762@ellen>
 <5fdc18a91c402_f2faf20837@natae.notmuch>
 <20201218054947.GA123376@ellen>
 <xmqq3603v3a0.fsf@gitster.c.googlers.com>
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Seth House <seth@eseth.com> writes:
> 
> > On Thu, Dec 17, 2020 at 08:49:13PM -0600, Felipe Contreras wrote:
> >> And no person is the sole arbiter of truth, in this list, or anywhere.
> >> People have managed to change Junio's mind.
> >
> > I'm not worried about Junio but I am wondering if anyone has managed to
> > change your mind. You and I have been going back and forth on this list
> > and on Reddit for two solid days and, to be frank, I'm running out of
> > steam.
> > ...
> > I, as a user of diffconflicts, may want to both disable this flag for
> > diffconflicts but enable this flag for VS Code and kdiff3. It is not
> > unusual for people to use more than one mergetool. Some of them are
> > better or worse at visualizing different kinds of conflicts. Sometimes
> > a conflict is small and straightforward; othertimes a conflict is
> > complicated and requires deep knowledge of the history of both branches.
> > If we force this to be a global flag only then users will not be able to
> > make different choices for different tools.
> >
> > Someone who does use multiple mergetools but only uses tools from group
> > one may appreciate a single global flag so s/he doesn't need to set it
> > for each tool.
> > ... there's every possibility that a user will prefer it a different
> > way or that a mergetool author will. And there's every possibility that
> > there will be differing opinions between users and authors like there is
> > between you and me. But that's ok! Because it's just a configuration
> > option.
> 
> Well explained.  I do not think I need to add much.
> 
> It makes sense to at least allow people to enable/disable the
> behaviour independently for different tools.  When unconfigured, I
> would say we should enable the feature by default to give it wider
> exposure.
> 
> Because what I care is not about the set of tools we happen to have
> right now, but is about leaving users access to an escape hatch in
> case things go wrong.

They do have an escape hatch.

> If it turns out that all the tools we happen to have do not seem to
> break with this new option with just a few days' survey,

Seth's blog post was ten days ago, and I presume it took him more than
one day to write, so I'm not sure it's a "few days' survey".

> it does not mean we do not need a per-tool escape
> hatch they can use until the next release either fixes the feature
> or makes it disabled by default, when there is unexpected breakages
> discovered later.

They don't need to wait for the next release, they can just disable the
flag.

These hypothetical users of multiple mergetools that are using a
hypothetical mergetool that doesn't seem to exist yet can just disable
the flag globally.

These users have managed to survive many years without this feature
enabled in all the usual mergetools, I think they would survive until
the next release.

> The time between a release and the next is a long
> time that the users cannot keep the tool they have learned to rely
> on broken.  And that's a conservative maintainer's view.

They don't have to; they can just disable the flag.

> When a tool that never wants its input munged appears, we might
> further want to have the mechanism to give different default per
> each tool for users who have no configuration, so that such a tool
> can be disabled while other tools are enabled by default while
> allowing users to choose.  But such a code to set different
> enabled/disabled default per tool (the one I outlined in the
> footnote of the other message) won't be exercised in practice with
> the set of tools we have (hence a bug in such a code would go
> unnoticed for a long time), so I tend to think we might be better
> off to wait until the need arises before implementing per-tool
> fallback default for users who do not configure at all.

Agreed.

> Another reason why allowing users to disable the feature per tool is
> important is because as far as I know we have kept the mergetool
> framework to allow adding a tool that can merge binary data, and
> leaving these three files pristine was one ingredient for that.
> With only a single knob, we would be making a decision to declare
> that such a tool is unwelcome, which is not quite acceptable.  I
> expect that users would want the new feature most of the time
> because they would be managing text files more of the time, and
> having only a single knob would force an unnecessary choice on those
> who want to use such a binary-capable tool as well.

I can't imagine what that binary data could look like, and how any tool
could represent that to the user.

But either way "git merge-file" fails on those cases, so we can just
check if the file is empty, and bail out.

I've implemented that in the next version.

Cheers.

-- 
Felipe Contreras
