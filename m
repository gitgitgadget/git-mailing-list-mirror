Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2D5C43334
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 01:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350523AbiFNB5J (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 21:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236298AbiFNB5G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 21:57:06 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B89733EAF
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 18:57:05 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id p83so3412436vkf.6
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 18:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HyXIEz2iIYELK6MG6YzXY5buKqOYdDPSHWr5LAUoRjo=;
        b=ZNs40l1uRw9259oUebDZeUJfXsnRjkI9i6lczk9w9swzn+um+BM/onkOoL9P/vmhA/
         j7qwUmA5RpEgDYqkpzlks1Y0fHN+uDzsLSuEOMvByH6okpJZG9mH9fC6+WwMacd5f6WX
         W8xDgQSUKcysxAR0vPMIIG9RhFMs1X0bVaD8zycUSUstkOvFl2jOHqFmssPJ/3enAGwe
         J1krPDXwpAg/U54RVLNI1XRJkyY9bAjsepLGlc36w1uY2JMERtZGFWB4ebTUVjux8itp
         z5y9DdFCyeUiB7fwqxX/QPqeDMSv7/gGI41cXAJ0rAhFqVubzH/x5ZmHIskIFz2dgEFm
         i2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HyXIEz2iIYELK6MG6YzXY5buKqOYdDPSHWr5LAUoRjo=;
        b=XpofvdIcR1MPZSQSLA79nhsNWcOt/MN+9rINSAr7W+SeZ8iIOaELZpFGGUBcuHmmQn
         +WvtLTpWvutSek/9WnYTYIkDIYaPcBH/u6hg3uzSLSD+KwWr73uIsWlwlYiGWZLqYgER
         7OlqQaCrzY3s7HmeeSX81h4L4z7AkW3B9Zgnjhs3X5rb+K97EzkmRtSW5GkDSzXsdGjc
         1kpfDYvVyjtL3KtV47aEJ/SDjhG7fMM/IsLLAt3drf5N9fFuMmJzzWXkzX/CNfJmumfU
         3lx+J1/xkU1C5CubSo/jW9Q2cPUFW0p6l9wSy0vAuXTICbDFpv9OQS0SdoaYz/SdoLpC
         uC9Q==
X-Gm-Message-State: AJIora+OVGVJcYTF3q83QM2LoAuYqcuAB+EZ2ggHdewz0oNjGhDNVNy6
        1HBo+J2MS8WmYQUS1/Eo5O/hnDXJ8H3riImNvKVXeSZ7
X-Google-Smtp-Source: AGRyM1srW6A+Fe/0JW5tvkPdJzGVbpGrKS5RxS1lnhJQdsBFxiufPyESN4tOaz0hHQDK4xKeUhCN5GecQW0lAHZyo2s=
X-Received: by 2002:a1f:4d83:0:b0:35d:a9bf:1a30 with SMTP id
 a125-20020a1f4d83000000b0035da9bf1a30mr1042070vkb.20.1655171824674; Mon, 13
 Jun 2022 18:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220614003251.16765-1-jacob.e.keller@intel.com> <Yqfec9yvT3LKomNK@nand.local>
In-Reply-To: <Yqfec9yvT3LKomNK@nand.local>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 13 Jun 2022 18:56:55 -0700
Message-ID: <CA+P7+xrgWVh_GPMiziiMnsrESH_Z+HzB+D2un8FWSs0dpcDFdA@mail.gmail.com>
Subject: Re: [PATCH] remote: handle negative refspecs in git remote show
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Pavel Rappo <pavel.rappo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 13, 2022 at 6:03 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Mon, Jun 13, 2022 at 05:32:51PM -0700, Jacob Keller wrote:
> > Fix this by checking negative refspecs inside of get_ref_states. For
> > each ref which matches a negative refspec, copy it into a "skipped" list
> > and remove it from the fetch map. This allows us to show the following
> > output instead:
>
> Seems sensible.
>
> > +     /* handle negative refspecs first */
> > +     for (tail = &fetch_map; *tail; ) {
> > +             ref = *tail;
> > +
> > +             if (omit_name_by_refspec(ref->name, &states->remote->fetch)) {
> > +                     string_list_append(&states->skipped, abbrev_branch(ref->name));
> > +
> > +                     /* Matched a negative refspec, so remove this ref from
> > +                      * consideration for being a new or tracked ref.
> > +                      */
> > +                     *tail = ref->next;
> > +                     free(ref->peer_ref);
> > +                     free(ref);
> > +             } else {
> > +                     tail = &ref->next;
> > +             }
> > +     }
> > +
>
> Not being overly familiar with the "git remote show" code, this
> implementation looks very reasonable to me. If we see a negative
> refspec, we remove it from the fetch_map list and append it to the
> skipped list. Otherwise, we increment our pointer, and continue along
> until we reach the end of the list.
>
> > diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> > index fff14e13ed43..e19b8d666c73 100755
> > --- a/t/t5505-remote.sh
> > +++ b/t/t5505-remote.sh
> > @@ -302,6 +302,33 @@ test_expect_success 'show' '
> >       )
> >  '
> >
> > +cat >test/expect <<EOF
> > +* remote origin
> > +  Fetch URL: $(pwd)/one
> > +  Push  URL: $(pwd)/one
> > +  HEAD branch: main
> > +  Remote branches:
> > +    main     skipped
> > +    side     tracked
> > +    upstream stale (use 'git remote prune' to remove)
> > +  Local branches configured for 'git pull':
> > +    ahead merges with remote main
> > +    main  merges with remote main
> > +  Local refs configured for 'git push':
> > +    main pushes to main     (local out of date)
> > +    main pushes to upstream (create)
> > +EOF
> > +
> > +test_expect_success 'show with negative refspecs' '
> > +     test_when_finished "git -C test config --fixed-value --unset remote.origin.fetch ^refs/heads/main" &&
> > +     (
> > +             cd test &&
> > +             git config --add remote.origin.fetch ^refs/heads/main &&
>
> Doing "git config --unset" outside of the subshell could be avoided by
> ditching the subshell altogether, perhaps with something like:
>
>     test_config -C test remote.origin.fetch ^refs/heads/main &&

We need "--add" semantics here which test_config doesn't seem to
support at the moment.

>     git -C test remote show origin >actual &&
>     test_cmp test/expect actual
>
> Thanks,
> Taylor
