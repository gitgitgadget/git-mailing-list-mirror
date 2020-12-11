Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F0BC4361B
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 04:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB1A723D3C
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 04:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgLKEih (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 23:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404614AbgLKEiT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 23:38:19 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E40FC0613CF
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 20:37:38 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id x22so6443439wmc.5
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 20:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=HyD++roSimksU0tpMgwHBz2EE5SnFGvjz39Sq+5ftqo=;
        b=pLqHe5br7BIq9zLCXdslDJoGWyB6fcWP6BtMtjNph4u83o8gi8saqpbB4nsSvTIiUg
         P/Y4AXBQGGJq4woUad4MNRvfNoRdy18lv5awx13Z35U10ArBdr69dTW2WuUZjB8Z1Bx+
         EL0YZ8MWqAZYCZbL5xqdfz/EOVbg1c8PdevJ7ZPjEhQUWQ+FsFDCEw+L+08XjtH0kqWT
         KkclFFtYueMCzm67z0a3Qly7n3BEBA4X0+e/OJYnC4HffJAhbN9jQxuYQerZzKXJNfvJ
         /QFoefkAgfJmQNcwum7GAmEV/B58nVYQ2gC/wgN6Rj4qBgMcB6ZAI/n0OB4tnCvRoEy/
         8JQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=HyD++roSimksU0tpMgwHBz2EE5SnFGvjz39Sq+5ftqo=;
        b=G7DZuC1KMjaT1OHpDtPHnByBWbvdgOWOB0+Kb8f3Am8jIpFCxLcJ5nVQwqCEjNytum
         2MhJgR/jGSHbPZJYkmintlK4NMkESMvbx8WWzryKKlnkIN6F8Xxre5N818iZj5x+FJrs
         4by6pyPn7CQyAiUBL1Avx6Kll+FU3lHBklkrC6P+3SXiLh1p9qayLrh1yf9SHrw7e1zz
         PoLjHyerb9yqVTah2wfskvG216rCVrEy/9i/SHoLf6m+W+PaYkY9ooBz0iqqxGM5DVFy
         G7PtZyqAFsijhHSU8GCXy92/+1Q6De5v/Q5uLR3Q8Vqdq+zmwec8yFPDaVfm1PePL4oR
         HO4Q==
X-Gm-Message-State: AOAM530mz9vmZuPx5nni7q3W9BJfyh5SrJYQz1SmcHR4c+VMZmoLo02W
        JdBic0pVDVHaBasfrpWpJSy/cOiB6KlE8WlhI8jrRiijYaAN5jJX
X-Google-Smtp-Source: ABdhPJxtKx9kbn7StxLvMTfjfDT5IBYtDqLgyYKkYqmVdeAd4uSlymOCrGqJ7L8Zg27xuRc8WgmfiOk1Mn+bkkmKg2c=
X-Received: by 2002:a05:600c:210e:: with SMTP id u14mr11623352wml.48.1607661457282;
 Thu, 10 Dec 2020 20:37:37 -0800 (PST)
MIME-Version: 1.0
References: <20201209065537.48802-1-felipe.contreras@gmail.com>
 <20201209065537.48802-2-felipe.contreras@gmail.com> <X9GbIG9vZbK1pEoi@camp.crustytoothpaste.net>
 <CAMP44s33J6F60W=2Yd2WSGE78VT0XBkewi8m3unXvathBH2TOQ@mail.gmail.com> <X9Lf1p++YktzZMWe@camp.crustytoothpaste.net>
In-Reply-To: <X9Lf1p++YktzZMWe@camp.crustytoothpaste.net>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 10 Dec 2020 22:37:26 -0600
Message-ID: <CAMP44s3skSjDM4c=G2izwX7n-9Of_TMsgouozj=O8sD68B18Pw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Add project-wide .vimrc configuration
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Aaron Schrab <aaron@schrab.com>,
        Denton Liu <liu.denton@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 10, 2020 at 8:57 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2020-12-11 at 01:08:00, Felipe Contreras wrote:
> > On Wed, Dec 9, 2020 at 9:51 PM brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
> > > On 2020-12-09 at 06:55:36, Felipe Contreras wrote:
> >
> > > I don't think this should go in this location.  It should go in contrib.
> > > Here's why:
> > >
> > > * We should not ship editor-specific files in the main directory of the
> > >   repository.
> >
> > Why not?
>
> Best practices indicate that we don't check in files which are specific
> to a developer.

But it's not specific to a developer.

> Anything that controls the specific editor people use
> is by definition specific to the developer.

Not really. Everyone that replied to the patch agreed on those settings.

Did anyone say they use tabstop=4?

> Checking in these files
> leads to conflicts over which settings to apply and whose settings are
> better when they could just be avoided.
>
> If we have style policies, those should be expressed in a general,
> universal way so that all users can take advantage of them in the same
> way.

Do you have any specifics? Because nobody complained about the
proposed settings.

> Furthermore, some editors want entire large directories of configuration
> files in order to work correctly, which we don't want to include.

That's a problem for "some editors". Not vim.

> If we treat all editors in the same way, then every developer gets the
> same experience when they work on our code.

But we don't want every developer to get the same experience. We want
developers to get the best experience they can get from their editor
of choice.

We don't want the least common denominator.

> If that experience is
> inadequate, our time would be better spent improving it in a universal
> way so that all developers can benefit.

This is the nirvana fallacy. We don't have to wait for a perfect
solution when we have a perfectly good enough solution. *Right now* we
can help the vast majority of vim users. There's no reason not to do
so.

Feel free to contribute patches to editorconfig until the experience
matches the proposed .vimrc. In the meantime the proposal is still the
best solution.

> > >   Even though Vim is very popular, it is one of many
> > >   editors, and it is not even the most popular editor (which is now VS
> > >   Code).
> >
> > Even if vim is not the most popular, it certainly is among the top 3
> > (and I doubt VS Code is the most popular, I would like to see some
> > numbers on that, but even then; VS Code is not an editor).
> >
> > Nobody is arguing to have editor-specific files for "every editor
> > under the sun", just perhaps 2 (or maybe even 3).
> >
> > No slippery slope fallacy here.
>
> Because we don't need them.

We don't need to need them. All we need is to want them (because it's
better than the current situation).

> Your solution requires the user to
> configure Vim with a plugin _and then_ allow the specific directory in
> order to be secure, which means it doesn't work with worktrees.

The editorconfig solution also requires a plugin.

And the .vimrc solution does work with worktrees. All the user has to
do is specify them.

Or just:

  let g:gitvimrc_whitelist = [ '.*' ]

Plus, even if it didn't work with worktrees, it's still better than
the current situation, where it works nowhere.

> It also
> requires that the user never pull an untrusted branch into their
> repository.

This is always the case. An untrusted branch can modify the git binary
to do whatever it wants.

> The .editorconfig file also requires a user to configure a plugin, once,
> and then things automatically work in a secure way across projects.

And have a *much poorer* configuration as a result.

It's not even close.

> So the .vimrc solution requires more effort, has more potential security
> problems, is less flexible, is less like how other projects solve this
> problem, and is less general.

All that is hypothetical.

What is *factually* the case is that the resulting configuration is
much superior.

> > >   We have editor-independent files, and users can copy this into
> > >   the root of the repository and ignore it if they want it there.
> >
> > Which are insufficient. They are certainly better than nothing. Plus,
> > it's unclear how many people are actually using those.
>
> Why are they insufficient?  Multiple developers are using them on Git
> already.  They're used on projects from Microsoft[0], W3C[1], and folks
> working on JSONPath[2].  They are the de facto standard for this
> purpose.

I already explained:

1. The sharness syntax is not set for tests
2. The asciidoc syntax is not set for the documentation
3. The specific cinoptios for C code are not set: "(s,:0,l1"

All of these are improvements the people that replied to the proposal
seem to want.

> In contrast, searching GitHub commits for ".vimrc" shows overwhelmingly
> that the repositories in which these commits are named are called
> "dotfiles".  I was unable to find any projects from major organizations
> using this configuration style.

This is the naturalistic fallacy. Just because in the current state
most projects do not have a .vimrc does not mean we should follow the
steps of most projects.

Most projects have vim modelines at the end of each file. Shall we
follow what most projects do?

In addition it's the bandwagon fallacy: if all your friends jumped off
a cliff, would you?

The reason why most projects don't have a .vimrc file is that nobody
has taken the time out of their normal tasks to improve the current
situation.

But I just did.

> > And I'm still waiting for the argument against adding such a top-level file.
> >
> > What is the harm?
>
> As mentioned, enabling the use of this file is still risky from a
> security perspective because it precludes even pulling in an untrusted
> branch and then spawning an editor.

That is always a risk.

Have you ever pulled a branch from an untrusted source and not looked
at the commits?

> We already have a more general
> solution that is more widely adopted and has fewer downsides, so there's
> no point in adding files which really provide little benefit over what
> we already have.

Is it widely adopted? I've never heard of editorconfig.

> If there's little benefit, we shouldn't carry files which are going to
> be subject mostly to pointless arguments over personal preference.

Who says there's little benefit? Nobody that replied objects to this
change (except you).

If you see little benefit, then you don't use this .vimrc solution.

Why are you against the rest of us making our own decision out of our
own volition?

> The
> fact that two heavy Vim users disagree so strongly over relatively
> simple settings is an argument for not adopting this approach as a set
> of project settings.

Who are these two heavy vim users that disagree so strongly?

> > > * Whether a user wants to use automatic indentation is a personal
> > >   preference.  I do happen to like it, but there are others who don't
> > >   and prefer to leave it off.  Similarly, whether to use cindent,
> > >   smartindent, or autoindent is a preference, as is which cindent
> > >   options to use (I use different ones).
> >
> > So?
> >
> > These options will not be forced on users, they have to specifically
> > enable them by doing at least two steps, *and* they can still
> > selectively override them in their ~/.vim files.
>
> Right, but why are your preferred settings checked into Git as a project
> setting?

They are not my preferred settings. Everyone (so far) has agreed these
are good project-wide settings.

> They are objectively no better than my settings, which differ.

How do they differ? What are your settings?

> Absent a compelling reason that these settings are objectively better,
> we should not endorse them as preferred project settings.

They don't have to be better than *your* settings. They have to be
better than vim's default settings, which they are.

*Your* settings will not be overridden.

> > > * These settings affect every file that's loaded in the same editor
> > >   process.
> >
> > That is not true.
> >
> > :setlocal [1] applies the setting to the current buffer only, not
> > globally, and *only* when the buffer is of the filetype specified in
> > the autocommand.
>
> So if I spawn an editor process using this .vimrc in my Git directory
> and then I load an AsciiDoc file from a different repository into that
> same Vim process, are you arguing that the Git settings will not be
> applied to the AsciiDoc file from other directory?  I'm pretty sure that
> Vim will in fact use the Git settings.  It's possible, however, that
> I've misunderstood how Vim works.

In that particular case; yes, those settings would be applied.

Configurations are never perfect. If this particular configuration
bothers you, and I fix that. Would you then approve of this change?

> > > So while I agree that these are common settings, they are not
> > > universally applicable, even for Vim and Neovim users, and we shouldn't
> > > try to claim that all or even most Vim and Neovim users should use them.
> >
> > We don't. These are defaults, which a) the user must consciously
> > choose to apply them, and b) can be easily overridden (as is explained
> > in the commit message).
>
> I'm arguing that they are not universal enough to be defaults.

And yet everyone else that replied is fine with them.

> We already have files for Emacs and VS Code, and those live properly in
> contrib, along with code for Thunderbird and alternative build systems.
> If we're treating this proposal like existing code, it belongs in
> contrib.

And yet we have .editorconfig, .clang-format, and .tsan-suppressions,
which don't seem to be hurting anybody.

> The .editorconfig file, on the other hand, doesn't express defaults.  It
> expresses only project standards and doesn't specify any other settings.

Fine.

The .vimrc file doesn't express defaults. It expresses project standards.

There. Now conceptually they are the same.

Cheers.

-- 
Felipe Contreras
