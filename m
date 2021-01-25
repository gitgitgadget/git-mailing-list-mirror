Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE6DC433DB
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 17:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D84E422C9E
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 17:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731027AbhAYRcF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 12:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730852AbhAYRPU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 12:15:20 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5453C061786
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:14:39 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id z6so10235019qtn.0
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 09:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QealmR7nv/ITx2XA1nnyYeWMgv3TLr5WfnKto9u40Cc=;
        b=B2Qq7KVVF+YQ2M5mP0dVJih0fqh1dE3iLIdrCaPMEz6GN6O8Em7iEiofg5P/Jxoehs
         fynMs2MlvkmpKD9MZrO2qdNl0ALT/LM3bxW8Ymy0G0PeOxZuhHh2opPoAc5KYCvHERef
         H+tMTkfKcsNCK1oTtxiEBpfZSI0WbTc9WAwCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QealmR7nv/ITx2XA1nnyYeWMgv3TLr5WfnKto9u40Cc=;
        b=nouVLeP/iLfjJKOymR6ekACLYsCMvBsLM1UkraEZud+3qkjkXAecpmawl8uiYCPE9i
         Rdf1sdbzgDW3ahu/sUrfnLYrMtkgNwt1JIq0v2lV9rtwrhcX6+CcIFyEqTHbVpLUOycT
         CGkPM2z6/JYFdVFnhDdzM+gwwlLomqz/ZLMoX/aWtxM+sLBVQ/ehdvZ2hx2kNDS72Yu1
         CsrDX8NZvRbdY/vyNgAYcj09CwPG/IqHVGi5BOQZd8zUbh3GvSBbDTumsFn89axgunnD
         z6laCPGxjlVG5CAPBxB+occREn/qjUvJCNw/4OBh8IdsGYeFAk4ETCqIUeMUegQJJP+V
         h8YA==
X-Gm-Message-State: AOAM530LF5TrVN++6xQztch7T5nFKbzWCfH+MWXatpZ1uG5wpm2cEgSJ
        270PXF4xZfqo67yutIxf+brCap3bjomzmw3BkHKtBg==
X-Google-Smtp-Source: ABdhPJx/1xyNqrGZJGoS4DJWsPDPMJKv6/kBmfNK16h2Dl/QXbKlLi4ogyK/Byk9eZxKQX9dEU8hqtNqoElAN2ocV7s=
X-Received: by 2002:ac8:782:: with SMTP id l2mr1386106qth.271.1611594878949;
 Mon, 25 Jan 2021 09:14:38 -0800 (PST)
MIME-Version: 1.0
References: <20210122142137.21161-1-jacob@gitlab.com> <20210122142137.21161-2-jacob@gitlab.com>
 <YAs2RMT1rEH/2LSp@coredump.intra.peff.net>
In-Reply-To: <YAs2RMT1rEH/2LSp@coredump.intra.peff.net>
From:   Jacob Vosmaer <jacob@gitlab.com>
Date:   Mon, 25 Jan 2021 18:14:28 +0100
Message-ID: <CADMWQoMjsa3hpzQCk-4tzSxvGx4z1sMB5DuC+0a7NMq-rjfdEQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] upload-pack.c: fix filter spec quoting bug
To:     Jeff King <peff@peff.net>
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, I changed the reproducing command to use 'env' and I added a
test case in t5544.


Best regards,

Jacob Vosmaer
GitLab, Inc.

On Fri, Jan 22, 2021 at 9:32 PM Jeff King <peff@peff.net> wrote:
>
> On Fri, Jan 22, 2021 at 03:21:37PM +0100, Jacob Vosmaer wrote:
>
> > This fixes a bug that occurs when you combine partial clone and
> > uploadpack.packobjectshook. You can reproduce it as follows:
> >
> > git clone -u 'git -c uploadpack.allowfilter '\
> > '-c uploadpack.packobjectshook=" exec" '\
> > 'upload-pack' --filter=blob:none --no-local \
> > src.git dst.git
> >
> > Be careful with the line endings because this has a long quoted string
> > as the -u argument. Note that there is an intentional space before
> > 'exec'. Without that space, run-command.c tries to be smart and the
> > command fails for the wrong reason.
>
> The "-u" command is run with a shell, so:
>
>   git clone \
>     -u 'git -c uploadpack.allowfilter \
>             -c uploadpack.packobjectshook=env \
>             upload-pack' \
>   --filter=blob:none --no-local src.git dst.git
>
> may be a more readable version. I also found the use of " exec" clever,
> but rather subtle; you need the extra space so that our "don't bother
> using a shell" run-command optimization does not kick in. I replaced it
> with "env" here, which is a slightly more canonical way of running a
> sub-program that does not rely on shell builtins.
>
> But all of this should be added as a new test, probably in t5544 with
> the other pack-objects hook tests.
>
> > The problem is an unnecessary and harmful layer of quoting. I tried
> > digging through the history of this function and I think this quoting
> > was there from the start. My best guess is that it stems from a
> > misunderstanding of what use_shell=1 means. The code seems to assume
> > it means "arguments get joined into one big string, then fed to
> > /bin/sh". But that is not what it means: use_shell=1 means that the
> > first argument in the arguments array may be a shell script and if so
> > should be passed to /bin/sh. All other arguments are passed as normal
> > arguments.
>
> Yeah, that is exactly right. "use_shell" just means that the command is
> (possibly) run with a shell. Quoting for any extra arguments is handled
> automatically.
>
> I think you're correct that this was broken from the start in 10ac85c785
> (upload-pack: add object filtering for partial clone, 2017-12-08).
> That's even before the use_shell was added, and then later it was pushed
> into that conditional by 0b6069fe0a (fetch-pack: test support excluding
> large blobs, 2017-12-08). Presumably because the non-hook path would not
> have worked at all, and that was the first time any of it was actually
> tested. ;)
>
> (I've cc'd authors of those commits as an FYI; I think both were
> relatively new to the project at the time so misunderstanding this
> subtlety of run-command is not too surprising).
>
> I'm somewhat embarrassed to say that despite being the one who added the
> pack-objects hook 4 years ago, we still have not switched over to it at
> GitHub from our custom patch (the reason is just mundane; there's some
> other adjustments that would have to happen and nobody has ever quite
> gotten around to it). Presumably you are looking to use it at GitLab.
> Just beware that you are probably treading new-ish ground, so there may
> be other bugs like this lurking.
>
> > diff --git a/upload-pack.c b/upload-pack.c
> > index 3b66bf92ba..eae1fdbc55 100644
> > --- a/upload-pack.c
> > +++ b/upload-pack.c
> > @@ -305,14 +305,7 @@ static void create_pack_file(struct upload_pack_data *pack_data,
> >       if (pack_data->filter_options.choice) {
> >               const char *spec =
> >                       expand_list_objects_filter_spec(&pack_data->filter_options);
> > -             if (pack_objects.use_shell) {
> > -                     struct strbuf buf = STRBUF_INIT;
> > -                     sq_quote_buf(&buf, spec);
> > -                     strvec_pushf(&pack_objects.args, "--filter=%s", buf.buf);
> > -                     strbuf_release(&buf);
> > -             } else {
> > -                     strvec_pushf(&pack_objects.args, "--filter=%s", spec);
> > -             }
> > +             strvec_pushf(&pack_objects.args, "--filter=%s", spec);
>
> Yep, this looks like the right fix. I think with an addition to the test
> suite, this will be good to go.
>
> -Peff
