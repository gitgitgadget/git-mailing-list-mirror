Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DDDC4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 16:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E1CF60E52
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 16:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbhHMQsE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 12:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhHMQsD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 12:48:03 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACE2C061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 09:47:36 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id y3-20020a17090a8b03b02901787416b139so8115950pjn.4
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 09:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AAuLhpYMlbbaFawlM7vVTAlbRZQo+M6yRfEsvti/zOI=;
        b=SUvVGPzc+wjKdwLgOKZr6zzetM9JKqiAaR3L3bZ/GInu05Vr7ep0LhnpXJuC45Wmky
         XMYpggG0uPXK00sHLiEZRMvxRc+NvWYv/bvo9Bz1839Qfy1xeMA7eaP9PrRJvKX5BaKj
         CR6pA2H4qWDqjVPMpyWJm1hdBbyRZS4Rw/i74WeVIXBPH9JdSdcbrinKAoxLqHX8jlB1
         nNzDj47ef+D3Rf/Ui+GhU7ish1w+qCnBj+WGK4qU+4D39F8Lfh2i4Of+5iYreJzaRuC7
         5u7b739FhdRrk8M3VxAHAjxZXu6720+MsN26reMRX3oC+E8VKDGBohmqXNKWMFQgPnNt
         5lwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AAuLhpYMlbbaFawlM7vVTAlbRZQo+M6yRfEsvti/zOI=;
        b=eLfx7ba5HaQllLivPsdRxPtcToCQsjLCMtk7cIPvReykXm4bR3NwBGb6x6PwlbPh5i
         mZZgqybZzPMs6pneUP052Fc+mWAykhruumonaWG/bK+cwQgUWkML3X9PmVaESAO9XGqZ
         Jh5ko5/POqk6jV0izI+eIJD/t0PZgakKJK220L641B5ki9rwXbimyZPLf5VMTg/f9jdN
         ryITCDzHJDHa8tFSRpnd0TXWt17D8s+eIr+GfphyUjnjLshtPBeL/196bVkw7IqCNj79
         mHKXMLs1YJiGxGqyLYw9otvqEgCleRQfJ9PO30szmpUG+boULR7VCXg5I8v8kugaMDGE
         Ss8w==
X-Gm-Message-State: AOAM533mPXTTPEr1LoHtjEkHTT1iDHicl8wCgbJuiTXRawU9KFCrkdFs
        c7euoN+qrEAFjUiWMxMn3Ndy4gS+Gx6/a9xwP+nR
X-Google-Smtp-Source: ABdhPJx6Naf1S5CwryIuuH2A4ZrwErdKYd6ymD5oLaf8ciDU6wON82zW0RJXq+O8+fnM40DcmvtH54wUQLQPgI7HsGw+
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:ff13:: with SMTP id
 ce19mr3354565pjb.114.1628873256250; Fri, 13 Aug 2021 09:47:36 -0700 (PDT)
Date:   Fri, 13 Aug 2021 09:47:34 -0700
In-Reply-To: <CAHd-oW4ntWB7KOKxhZU4wM-Xg9MARVN2EmpxEg-rEfc4i_SUnw@mail.gmail.com>
Message-Id: <20210813164734.3219965-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CAHd-oW4ntWB7KOKxhZU4wM-Xg9MARVN2EmpxEg-rEfc4i_SUnw@mail.gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: Re: [PATCH 6/7] grep: add repository to OID grep sources
From:   Jonathan Tan <jonathantanmy@google.com>
To:     matheus.bernardino@usp.br
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Tue, Aug 10, 2021 at 3:29 PM Jonathan Tan <jonathantanmy@google.com> wrote:
> >
> > Record the repository whenever an OID grep source is created, and teach
> > the worker threads to explicitly provide the repository when accessing
> > objects.
> 
> This patch fixes the second NEEDSWORK comment at grep_submodule(),
> right? Maybe this comment could be replaced with a mention that
> add_submodule_odb_by_path() is called for testing purposes, and it
> should no longer produce a real addition to the alternates list?

Good catch. I'll update the comment.

> > diff --git a/grep.h b/grep.h
> > index f4a3090f1c..c5234f9b38 100644
> > --- a/grep.h
> > +++ b/grep.h
> > @@ -187,6 +187,7 @@ struct grep_source {
> >                 GREP_SOURCE_BUF,
> >         } type;
> >         void *identifier;
> > +       struct repository *repo; /* if GREP_SOURCE_OID */
> 
> Hmm, the grep threads now have two `struct repository` references, one
> in `struct grep_source` and one in `struct grep_opt` (see
> builtin/grep.c:run()). The one from `struct grep_opt` will always be
> `the_repository` (in the worker threads). I wonder if, in the long
> run, we could instruct the worker threads to use the new reference
> from `struct grep_source` throughout grep.c, and perhaps even remove
> the one from `struct grep_opt`.
> 
> This would solve the issue I mentioned in [1], about git grep
> currently ignoring the textconv attributes from submodules, and
> instead applying the ones from the superproject in the submodules'
> files. (Here there is an example of this bug: [2] .)
> 
> It would also allow grep to use the textconv cache from each
> submodule, instead of saving/reading everything from the
> superproject's textconv cache.
> 
> While this doesn't happen, though, could we perhaps add a comment
> somewhere to avoid any confusion regarding the two different
> repository pointers that the worker threads hold?
> 
> [1]: https://lore.kernel.org/git/CAHd-oW5iEQarYVxEXoTG-ua2zdoybTrSjCBKtO0YT292fm0NQQ@mail.gmail.com/
> [2]: https://gitlab.com/-/snippets/1896951

Ah...another good catch. Thanks also for a link to your email - I'll
mention it when I add the comment you suggested.
