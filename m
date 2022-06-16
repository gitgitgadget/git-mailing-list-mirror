Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD16C433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 21:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379110AbiFPVK5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 17:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379098AbiFPVK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 17:10:56 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C5560B8E
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 14:10:55 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id m10so882994uao.11
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 14:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pOUFghobiLUT+TJrNNp/UiWrVPBJeTvRtUxIRiPWUBI=;
        b=Pj/tK+dtQECrVY+alDRpD1w+fqClMguYppM4aWuqoHQgYAvPXhOoi+VZMZvIjDBwu/
         RcmO4yrsu1lcMHDAxHYj2T44T5NQjZ890soTbU34MHJlf+2FguqdoKudBK1OCxvF7LSf
         5Akz6ghp8LClTHlCXsBgv5cUw16WIurrnIuLrfbtR9dkIi5fWPi9PGpdG8FJjCz71KVK
         gxQXD9iZp5hAbPc/ZDQFcM3ShbpiTxStZUCcsekdGwFSg6zQsVQCUv72a865X/ywKRpu
         rWChAOKxjWhGEhh62vw5+qK0Qq/n/5EUmUGG7qY++/B1FFgTcy9tlqgLuane2VRCg06p
         reFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pOUFghobiLUT+TJrNNp/UiWrVPBJeTvRtUxIRiPWUBI=;
        b=VAY1FJ3k++czBbCnoPmnbWZWj32pU8A8Yk3kfH9opg0COafd1X0nGefWZPLuSZ++Lt
         LbJLP/Y70Gru5g87pG8kRZlkfEVp+k7Ox1g33RMd6+TJ2uZlAVanbMnqtFF3QbTZfP26
         vuYrjE+Tq2FqyOGVxzmNiKX3n1Cy6BEmgoBaD87Dmq4nFIOrnOCKtDvxYm+o6NLamahJ
         D0dlrFVbdcBIDP6q/8aRJyvNgCGRRWlprnss2YGII0yzwtAry4sZr2/ty4yvPM0zu6yb
         bmf1GsE2qT7VLDeqNA4RrpqfSOkATbNoynC9ZJXKEXKLOaqZzW1OtZyo3vDVHtCu3qZM
         tv7A==
X-Gm-Message-State: AJIora9aYoLJBAob3/9N1dVMkxq7D6riPMs0G+30ZnsWn9sq6hbTjvla
        MoOJZu5nhDeVu0AmMUljON7yOpEz5Nj0UVA9dYE=
X-Google-Smtp-Source: AGRyM1tNKLrKhmTmx5gLJIdJNpNd3/sUxSAKXt/qT3909mfbbT1TLT27e1HYuHYRayC9ect51hcEupwDfDWEoCfSRPw=
X-Received: by 2002:ab0:7557:0:b0:378:d2f9:d939 with SMTP id
 k23-20020ab07557000000b00378d2f9d939mr3114384uaq.49.1655413855024; Thu, 16
 Jun 2022 14:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220616205456.19081-1-jacob.e.keller@intel.com>
 <20220616205456.19081-2-jacob.e.keller@intel.com> <xmqq8rpws4ck.fsf@gitster.g>
In-Reply-To: <xmqq8rpws4ck.fsf@gitster.g>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 16 Jun 2022 14:10:45 -0700
Message-ID: <CA+P7+xp95ndNeFY_5icL1=xaBy+ikkT8UhgAXQhoPNfZqo0cWQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] t5505: remove sub shell use in favor of git -C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 16, 2022 at 2:09 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jacob Keller <jacob.keller@gmail.com> writes:
>
> >  check_remote_track () {
> > -     actual=$(git remote show "$1" | sed -ne 's|^    \(.*\) tracked$|\1|p')
> > +     actual=$(git -C test remote show "$1" | sed -ne 's|^    \(.*\) tracked$|\1|p')
>
> This has become less generic.
>
> >       shift &&
> >       tokens_match "$*" "$actual"
> >  }
> >
> >  check_tracking_branch () {
> >       f="" &&
> > -     r=$(git for-each-ref "--format=%(refname)" |
> > +     r=$(git -C test for-each-ref "--format=%(refname)" |
> >               sed -ne "s|^refs/remotes/$1/||p") &&
>
> Likewise.
>
> They used to be usable in any test repository, but now they have to
> be used in a repository whose name is "test".
>
> I wonder if something like
>
>         check_foo () {
>                 if test "$1" = -C
>                 then
>                         in_repo=$2
>                         shift 2
>                 else
>                         in_repo=
>                 fi &&
>                 actual=$(git ${in_repo:+-C "$in_repo"} subcmd ...) &&
>                 do things ... &&
>                 do more things
>         }
>
> would work better?
>

Yea that might be an improvement. They were previously only used in
"test" but I like the idea to clean that up.

> > @@ -44,10 +44,7 @@ check_tracking_branch () {
> >  test_expect_success setup '
> >       setup_repository one &&
> >       setup_repository two &&
> > -     (
> > -             cd two &&
> > -             git branch another
> > -     ) &&
> > +     git -C two branch another &&
> >       git clone one test
> >  '
>
> Clear improvement.
>
> > @@ -57,25 +54,19 @@ test_expect_success 'add remote whose URL agrees with url.<...>.insteadOf' '
> >  '
> >
> >  test_expect_success 'remote information for the origin' '
> > -     (
> > -             cd test &&
> > -             tokens_match origin "$(git remote)" &&
> > -             check_remote_track origin main side &&
> > -             check_tracking_branch origin HEAD main side
> > -     )
> > +     tokens_match origin "$(git -C test remote)" &&
>
> This is a clear improvement.
>
> > +     check_remote_track origin main side &&
> > +     check_tracking_branch origin HEAD main side
>
> These two are a bit questionable (it hides the fact that all these
> names refer to stuff in "test" subdirectory).
>

I think these ones can be fixed up by supporting -C in the function
instead so that it will be clear.
