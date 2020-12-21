Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D42C433DB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 04:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E20D922CB2
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 04:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgLUEbA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Dec 2020 23:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgLUEa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Dec 2020 23:30:59 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A616C061282
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 20:30:19 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id s75so10126438oih.1
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 20:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=85pGKujTQD53E9jn/X52szRW7cMDXWoS1TT3Xm4mM0Y=;
        b=umRmFSfFyUcSJAcwFw/g8+6R9QpWKEuSaTt48bBgceNvZAvXNHOSgoqwhHRQItV5T3
         VZqkSjE+2hxBMLDC+LMjQyyizRBAoASCqiTERpH73Bv/oL3mvIqoS50B7NCa6QIKcIXL
         cXVMWlOyd4GHc++0axIM81+vaU3x/LgeKSUOQjNDpAZII5h5njJpNeRYPHk4tCfksWit
         C2FEb3F75Xb5YazvMDZRfPNjiYiA8tKesmytzGuMizItIMDMf/4Es/KuhLXPUc/sOhe7
         Jx+qKGljl8pQ9mfq0IQZX5qaNGN+W0AGcISJu45ymmC4ZIY2b60lHixloOvEYqgnuD9t
         Bx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=85pGKujTQD53E9jn/X52szRW7cMDXWoS1TT3Xm4mM0Y=;
        b=UcONsgceJyVDlMG4t3YaMs5Z2HHUoow4VdDDyTnVVZrVU8pSXEWQaXgL+gaOgJqlYF
         SSmgrSYWHayCKqknno6J+NMKzomoApRZDv0v0J2NxeWg7YDr+t/iy9HCoUad8J7N5CnY
         fjlOLoJvCbNaPZ/kxDN51pyGqTKVhUAnIe+fNina2c2GzCMl9uYI7b8XvKiMzKhcr3EQ
         SF5pKenYsd3S/uYUFD63EabDLeYTOuMvufZ6ZEdntm8Coq3dbwlnE98B+j31AkpkQn50
         A1QM/QMZ3RLU1qCAHxh95yJbHHIPKG+fF2FfUPf0ljaLLEk3EVyqhaxhXpCrmODWCsBX
         3U9Q==
X-Gm-Message-State: AOAM533SX5mf7SCihjmE2+81PBJ7/K9VF0cR1Rdc6xrfQqwrBE7PFGaP
        FwrtCi9WP7OEfragn/ID6a/UkZ2OneO2WQ==
X-Google-Smtp-Source: ABdhPJzQoQXxu67RuDPULT0rBNLCjmNRR8VopfwEdgllNe7S6lZ+/7zPWjbU6/NVWHDdoER1pTUKyg==
X-Received: by 2002:aca:b60a:: with SMTP id g10mr9525405oif.26.1608515201237;
        Sun, 20 Dec 2020 17:46:41 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id y35sm3533505otb.5.2020.12.20.17.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 17:46:40 -0800 (PST)
Date:   Sun, 20 Dec 2020 19:46:39 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     David Aguilar <davvid@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Seth House <seth@eseth.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <5fdffe7f7fbd_89f120860@natae.notmuch>
In-Reply-To: <CAJDDKr5EiH3R284XNToTkVQ1a12Mqp7oCA30xpt_cMjatfHQjg@mail.gmail.com>
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
 <5fdc998216c89_104e15208da@natae.notmuch>
 <xmqqlfdtoch2.fsf@gitster.c.googlers.com>
 <5fde69944fe4d_1e50c7208f@natae.notmuch>
 <CAJDDKr6RP+TPFF2mHph7sqa-eG9uoRtqS4d4vUU84V3HJ_CMBA@mail.gmail.com>
 <5fdf030d2bde5_32bc20825@natae.notmuch>
 <CAJDDKr5EiH3R284XNToTkVQ1a12Mqp7oCA30xpt_cMjatfHQjg@mail.gmail.com>
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar wrote:
> On Sat, Dec 19, 2020 at 11:53 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > David Aguilar wrote:
> > > On Sat, Dec 19, 2020 at 12:59 PM Felipe Contreras
> > > <felipe.contreras@gmail.com> wrote:
> > > > They don't have to rely on that failure, they can just turn off
> > > > mergetool.automerge.
> > > >
> > > >
> > > > But fine. Let's the perfect be the enemy of the good. That seems wise.
> > >
> > > FWIW I'm in favor of having per-tool configuration precisely for
> > > custom mergetools that do things with custom file formats and benefit
> > > from having all of LOCAL REMOTE and BASE.
> >
> > That's a preference, not an argument.
> 
> Lol, that's why I said "in favor".  But, since you asked, it turns out
> that my preferences have a stronger weight than yours.
> 
> "git shortlog -n git-difftool* git-mergetool*" shows that my
> preferences and opinions are 44 times more important than yours in
> this area, whether you like it or not.  ;-p

That doesn't mean you are right.

This is an appeal to authority fallacy.

> Poking fun is my answer to such misguided seriousness.

I did not poke fun. I was just pointing out the fact that it wasn't an
argument.

> > > I don't have to imagine these use cases, they are very real.
> >
> > Show one.
> 
> Heh, I don't have to show you anything.

No you don't, but in a discussion with other people if you don't
substantiate your claims, then others have no rational reason to
consider them.

> Barring that, please use your imagination.  Imagine a custom file
> format for a graph-like data structure (both binary and text-like)
> that is able to use the full set of information for the purposes of
> resolving conflicts.  Private tools exist.  It's impossible to prove
> that they don't so I won't ask you or anyone else to do so.

So it's not a real use-case, it's an imaginary one.

Even if we do consider this imaginary use-case, you just swept the
problem under the carpet by saying "is able to use the full set of
information".

How?

Explain how this tool would use this information.

> > > This design choice is also in alignment with the general
> > > mergetool/difftool per-tool configuration paradigm.  If we didn't
> > > support per-tool, then it would be inconsistent.
> >
> > Can you do
> >
> >  1. mergetool.vimdiff3.keepBackup
> >  2. mergetool.vimdiff3.keepTemporaries
> >  3. mergetool.vimdiff3.writeToTemp
> >  4. mergetool.vimdiff3.prompt
> 
> can_merge()
> diff_cmd()
> merge_cmd()
> translate_merge_tool_path()
> list_tool_variants()
> exit_code_trustable()
> 
> mergetool.<tool>.cmd
> mergetool.<tool>.path
> mergetool.<tool>.trustExitCode

None of those are user preferences.

> We even have mergetool.meld.hasOutput which is completely tool-specific.

We don't have a user preference `mergetool.hasOutput`, or
`mergetool.vimdiff3.hasOutput` for that matter.
 
> I'm not asking, I'm telling you: the tool was designed around per-tool
> hooks.  This is per-tool behavior.  End of story.

And yet a tool cannot override `mergetool.keepBackup`.

Correct?

> > ?
> >
> > In fact the opposite is the case; not a *single* `mergetool.foo`
> > configuration can be done with `mergetool.<tool>.foo`.
> 
> That's not the right question.  This a behavior that can differ
> per-tool and thus this feature must reflect that.

Can it?

I am waiting for somebody to show *how*.

> There is a difference between top-level and per-tool behavior.

> This is a per-tool feature

No, that's your opinion. You haven't explained why.

> The way to think about it is that it's a per-tool feature

Ditto.

> We are not designing just for today; we must keep our eye on
> longer-term goals where the community tools can be improved.

Yes, but an actual future that might actually happen.

> Here is the "right" question to ask: Why shouldn't we have this
> flexibility?

Why shouldn't we have `mergetool.vimdiff3.keepBackup`?

> The heavy hammer of completely disabling the feature means that they
> will have crippled all of the other mergetools just because one of
> them couldn't cope,

Precisely *how* a tool couldn't cope?

> Are you willing to compromise on the small concession that we should
> allow per-tool overrides so that we can move forward and get this
> integrated?

We can move forward right now.

But no, I am 99.99% certain *nobody* will ever implement
should_automerge (), so I won't waste my time with it.

If you think otherwise, you spend your time implementing this on top of
my patch. That way it's clear who made the mistake.

> To be extremely clear -- is this discussion arguing between the
> following two strategies?
> 
> # Per-tool override + Global default
> 
> should_automerge () {
>     git config mergetool.$tool.automerge || git config
> mergetool.automerge || echo true
> }
> 
> # vs. Global default only
> 
> should_automerge () {
>     git config mergetool.automerge || echo true
> }
> 
> , or are we discussing a different aspect?  When spelled out in code,
> we're discussing whether or not we should have
> "mergetool.$tool.automerge ||" in there, and the argument for why not
> is pretty thin considering that use cases that would be harmed by not
> doing so exist.

I don't think mergetool.autoMerge should be any different from
mergetool.keepBackup; a single global user configuration suffices.

You say the argument against such per-tool configuration is thin, I say
the argument in favor is non-existent.

> Such a trivial difference is not a hill worth dying on so please route
> this energy into a patch so that we can get this integrated.

Nobody can tell me how I chose to spend my free time that I'm choosing to
contribute to this project altruistically.

> I suggest this compromise -- if adding "mergetool.$tool.automerge ||"
> to the logic is something you don't want to do then submit the patch
> without it and I'll submit a follow-up patch that adds the per-tool
> override.

That's not a compromise. That's a difference of opinion stated in the
code.

I don't have to convince you. And you don't have to convince me.

> I'd personally prefer to just have the patch include this from the
> get-go, though, so if we've managed to convince you then please take
> the shorter path to success.

And I would prefer that we don't waste time with hypothetical use-cases
that will never materialize.

We can add such configuration when the need actually arises.

But we can't always have what we prefer.

Cheers.

[1] https://en.wikipedia.org/wiki/Argument_from_authority

-- 
Felipe Contreras
