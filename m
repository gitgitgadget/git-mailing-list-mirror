Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E3361F97E
	for <e@80x24.org>; Sat, 13 Oct 2018 00:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbeJMHzu (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 03:55:50 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36509 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbeJMHzt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Oct 2018 03:55:49 -0400
Received: by mail-ed1-f67.google.com with SMTP id c26-v6so12947345edt.3
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 17:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BQ6WxvX45XIaL8HbFG/iaO/VKoC54BJxBmqgvu9rc0U=;
        b=ecHUQ9vFkVVMIaWCalyEZHSWic1wxejWyZHXgYGSaqLXZp9STCDJqUKgJAlT98gcvN
         AUlJt9cHelzLuVWf+4KyYoLZmo++veGDjlcnm4Nh9irXC8dzSHlYKvgyZTL0nuUAkphB
         wOSTjqO03cA0YtliNXxjQ3f3E1pn6ng2RhHhRoRJeebav/3bSR1Ix9mc1qefht38FBRK
         HOh0f+qYcctVT8K38MkpAsVbqLSQv+1VhjK0bUNd2Oi3zhKkrzDtEBCZE7RvAGaYtD5j
         g4QLxffOQZT4r/ESlT8FQFSVuFAaNkX8ljYcvHeO8miHzUflFDGJYjv9cxeg+cKoTXPW
         JbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BQ6WxvX45XIaL8HbFG/iaO/VKoC54BJxBmqgvu9rc0U=;
        b=FEcZDss6HdI+AawGtqqcRtNVn7TJXYAqSwLxG6pCtxIjt7Ul8O21hSHn7+6ZNP5Wom
         W1HyJ5enzN89TgLfElThcxkv6tL/yvlNQ6rnYn4CCtYQH+8HtgzSXz95PUWzQOnn51gB
         gMuQNvoJqhnGpP1vPK+m5wzAUhAuI84qPeXDJJsukxjoeKjkPUoHX/zv/EU1c4Ijpizb
         NufY/CaVfeXacbUmP9beKf5S9AXbIJzytlW8eYC32rcZg1dQtA8JJMkgFDLBr1uc8OL7
         FNSYxpv95ZG+eNeg8GtDFR/a5juxXOrBp5ksNFjuG+CJJh9OHON9ard/8b7Vdo3lXM+7
         Yb5g==
X-Gm-Message-State: ABuFfoiwpCBNjd9lo9+CxK5E0699du+uJwkRhHPPJLv2GwNaL2Igzuxe
        8GMMYoB0ubCIysmhM5KLf+8sx/KDP7uPE2A/8MU4OlwMhrM=
X-Google-Smtp-Source: ACcGV62dhiRq9/KxK4ihaSpovDQopP2zYamLoDpjoXpvdybXBHgYuN83hfKYL8SHVO0IPppfWXWegnhoDpEIqI9oWAk=
X-Received: by 2002:aa7:d9cf:: with SMTP id v15-v6mr11642421eds.25.1539390055489;
 Fri, 12 Oct 2018 17:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181011211754.31369-18-sbeller@google.com> <20181011224052.191281-1-jonathantanmy@google.com>
In-Reply-To: <20181011224052.191281-1-jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 12 Oct 2018 17:20:44 -0700
Message-ID: <CAGZ79kZTxoNMUyX+EHg0q3Ss2M-Etkf0yiw3E40U3VCt4QMwrQ@mail.gmail.com>
Subject: Re: [PATCH 17/19] submodule: use submodule repos for object lookup
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 11, 2018 at 3:41 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > +/*
> > + * Initialize 'out' based on the provided submodule path.
> > + *
> > + * Unlike repo_submodule_init, this tolerates submodules not present
> > + * in .gitmodules. NEEDSWORK: The repo_submodule_init behavior is
> > + * preferrable. This function exists only to preserve historical behavior.
>
> What do you mean by "The repo_submodule_init behavior is preferable"?

Preferable in the sense that it follows the definition of a submodule, but this
here works for "any repo" that happens to be at the gitlink.

>  If
> we need to preserve historical behavior, then it seems that the most
> preferable one is something that meets our needs (like open_submodule()
> in this patch).

Yes, I'll reword to drop the preferrable, but still state the difference.

I wonder if instead we'd want to introduce a

    repo_submodule_init(struct repository *submodule \
        struct repository *superproject \
        const char *path, \
        int tolerate_lookalikes)

Another patch proposes to replace the path
by a struct submodule, but for lookalikes, we do not have
a struct submodule to begin with (though in the other
patches we cook up a fake entry in the submodule config)

> > +static int open_submodule(struct repository *out, const char *path)
> > +{
> > +     struct strbuf sb = STRBUF_INIT;
> > +
> > +     if (submodule_to_gitdir(&sb, path) || repo_init(out, sb.buf, NULL)) {
> > +             strbuf_release(&sb);
> > +             return -1;
> > +     }
> > +
> > +     out->submodule_prefix = xstrdup(path);
>
> Do we need to set submodule_prefix?

Good point! Thanks for catching this.

>
> > @@ -507,7 +533,7 @@ static void show_submodule_header(struct diff_options *o, const char *path,
> >       else if (is_null_oid(two))
> >               message = "(submodule deleted)";
> >
> > -     if (add_submodule_odb(path)) {
> > +     if (open_submodule(sub, path) < 0) {
>
> This function, as a side effect, writes the open repository to "sub" for
> its caller to use. I think it's better if its callers open "sub" and
> then pass it to show_submodule_header() if successful. If opening the
> submodule is expected to fail sometimes (like it seems here), then we
> can allow callers to also pass NULL, and document what happens when NULL
> is passed.

That looks intriguing, I'll take a look. Note that we also pass
in **left and **right to have it assigned in there.

>
> Also, repositories open in this way should also be freed.

Yes, thanks!
