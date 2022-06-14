Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89DBC43334
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 06:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245730AbiFNGJP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 02:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiFNGJO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 02:09:14 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931BF11158
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 23:09:13 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id n203so3580410vke.7
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 23:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uuxi1JHGqAFvbmp+tPsxz1IDWB5ifMT99rajL0xdXMo=;
        b=HPAAasC3Vfpta4vWIc4Ng3m2mDJSIkU6dBI6m1lZnzpnDCQYNC8meHer58F4dQt/fz
         c2+q3Fu5ZlWmdRc2t9qjQCrbOXoV4IGIngIaNTrY7Lu+qAk2gs9XXOkQDfJSyCJR8X9b
         7gTF2yo1LVmI33WaZsqXKf6tfFwtcOMY8Bh8bKCkVzItGBcOFvwE+yqi1jRzR11s0Rhe
         +cCnPEQ2ubKRe2KQQWIQupRw306WJm2kPWJTBQLFffHdHKPBktUlfDo1LHmzV799LzfJ
         4/6E8d5Rtjbbt348HTJNNhWY8o7VIWlqLBMD/dO/IbL5Q26XbamIUYS0/wqPNvkxqT7R
         teLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uuxi1JHGqAFvbmp+tPsxz1IDWB5ifMT99rajL0xdXMo=;
        b=LzujLFj0RdMrkIsSu+Z/WsgaKVnWUCRCr0el8oqyAcdy6MNA3O7FHipvuGODV/1t/N
         HecM9aoNB+76QwioynyCNnV9V1yNgewWph7lOD34zT+dN7XfkOHkkoy5VUYriuOu/qtN
         0s/6POzQrEsGPG26sLymeGHBsaj8WUCFgjF6tdz2QBCVGIi0aFb2yHv3g2fzV//IWorx
         sRB52t2fvXk/Dx05a3ITlqyrg+mGTSqCApWCIwy96mycQkf7i0yQShVrrx85bljVqnt6
         OjcHfV8X3h5LjqeO/4amrZiyOZHKYmsFmnsEs6+w9jsOC4Ff9sM4su4xZJEBEULrVHII
         gCfg==
X-Gm-Message-State: AJIora9OveRFMqapuwmWWbwOu0MQ7V0wq9w4MbgxwpIsszheM/Mxn777
        BV2YYkjf5u1IwJD0GHpB6Ep7BTNpK8ZmGoS3XdIDw+t9
X-Google-Smtp-Source: AGRyM1sOhqdOzu5Dl0/FJIuGCVN3+J7uE+CNt1/RtLXVxKY+J4Tlq1YeX3VtH9VXUHs2N2jkeHukp54ZtP6FT4nOQFY=
X-Received: by 2002:a1f:ae8b:0:b0:35e:12bf:1ae with SMTP id
 x133-20020a1fae8b000000b0035e12bf01aemr1241154vke.18.1655186952622; Mon, 13
 Jun 2022 23:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220614003251.16765-1-jacob.e.keller@intel.com> <Yqfec9yvT3LKomNK@nand.local>
In-Reply-To: <Yqfec9yvT3LKomNK@nand.local>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 13 Jun 2022 23:09:02 -0700
Message-ID: <CA+P7+xos3vpPjb3m_BkR4Qp3OPf+R+-A1B=jTD3-Q6FeO4RpMg@mail.gmail.com>
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

The specific way the loop works is similar to other ref looping code
but it feels a little odd to me. Still, it seems to be the right
approach overall.

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
>     git -C test remote show origin >actual &&
>     test_cmp test/expect actual
>

I still think that removing the subshell is a good idea here. I'll
investigate this.

I also wonder if it would be difficult to enable "--add" semantics for
test_config.

> Thanks,
> Taylor
