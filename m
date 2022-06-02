Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A8AC43334
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 06:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiFBGdB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 02:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiFBGc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 02:32:59 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FB31203E3
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 23:32:57 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z7so4945857edm.13
        for <git@vger.kernel.org>; Wed, 01 Jun 2022 23:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tkePSHpkrh7PQXG31Qtq0DfMARI+3i1pC93HIiLxpnI=;
        b=BnSDwwBbUmtkceKGim+ByuJKvyNWIk9hOcVrsku8dZn3jaLBwQYMLiwzimeEU7EATn
         gPeCmEmo6ErOBOuaKep1Rl+rq6P12s+hS02Mk2cfokTYoNQme/SYVAfhG6UYty5DnMNG
         Dsd967QGrGZkK0sggbjZBbfn0iaPicdAWf4X4YRgwa+BdLHwGCxMTViNwP3aaIMMIuOs
         wMBh2WLfeGP+4DM2FQnR+82R7KdSjpql74mVeQM7B1SZrZkULKGe2qsW5dt9cUnD7lnb
         XEdreSERHPx34HWhtOcd2OuH/APEYcYknRdwazTLrFm1r68Q7YDi4HzfX7hnq13cWTRT
         ZyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tkePSHpkrh7PQXG31Qtq0DfMARI+3i1pC93HIiLxpnI=;
        b=HwWjgyvVmiBxd6wL8KsqeRUhOhuwR518Xyzg/L8YP2rZPNOMdRzFjnLR927XVFDgnX
         UKcfzSxIkTEUc6/jmvOqRblOYCGvYDQ1b4eNPFC9d5vkCOXqT6IopSJ+w1PNIKbiEzFC
         adFAty+kxHSdYuBQi3LvzYAXmFf8Gk766bH5DvUByjHOVPusn5RoxolEuKZwlc3DAnOf
         2XHSru2pTUIo4dnd6xSaVJMv4Gl7TsvPKXL0hpMfjizupd9XTY4WDLueXAdq2fl98TLt
         XEioK/hUjpzEhKpqcT9JSlZ5kItLDHAkEkup9ISodvS2NaWHBbiNPhMJ80H8k8EiWdj3
         aSXA==
X-Gm-Message-State: AOAM531fVq/m7lXAWo/ECkwZkP//J4kRUmT8ULdtiD8khW/SXNg0hyrD
        YDsM8w7tvcg+TdPGMnvWCk87X5kuECUUc3NeY90=
X-Google-Smtp-Source: ABdhPJwGxTrCJ09iFqIevFN5znHhxXFzJG4tBGCbw8ZBNaoPHGpP0PhBDlHBoAqEbxs9+QfJKSlW8p85KB+/gnOxWCg=
X-Received: by 2002:aa7:cac7:0:b0:42a:b00a:eeb2 with SMTP id
 l7-20020aa7cac7000000b0042ab00aeeb2mr3653266edt.60.1654151576368; Wed, 01 Jun
 2022 23:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAHHcNoe12h5E9OmkZy03-i7miFg2hLiT04BF3_t9C2bcmduR5Q@mail.gmail.com>
In-Reply-To: <CAHHcNoe12h5E9OmkZy03-i7miFg2hLiT04BF3_t9C2bcmduR5Q@mail.gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Wed, 1 Jun 2022 23:32:45 -0700
Message-ID: <CAPx1GvfQLP3q-SvW38=VOxoAmQpMMau_UfXXXQiZSV3NOJCs0w@mail.gmail.com>
Subject: Re: BUG? git stash and immediate git apply results in conflict
To:     Akos Vandra-Meyer <axos88@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 1, 2022 at 2:11 PM Akos Vandra-Meyer <axos88@gmail.com> wrote:
>  git stash -ku
>  git stash pop

This is not a bug in `git stash` itself, but rather in the way you're using it.

There are two mistakes on your part here:

1: You are using `-k`, aka `--keep-index`. This flag is intended for usages
that are not yours here.

2. You are *not* using `--index` in your `git pop`.  The `--index` flag is
intended for the kind of thing you are doing here.

It's a bit unfortunate (and perhaps worth some work in the documentation)
that the `--keep-index` and `--index` flags sound so similar, and yet are so
different.  The documentation could use some examples here, I think.

Note that if you *do* want to use `--keep-index` during the `git stash` step,
you will need a `git reset --hard` before your `git stash apply --index &&
git stash drop` step (aka `git stash pop --index`).

Chris
