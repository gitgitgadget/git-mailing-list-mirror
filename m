Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9F5C433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 08:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A14A206B5
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 08:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3obGcJS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgHGIpo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 04:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgHGIpn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 04:45:43 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E52C061574
        for <git@vger.kernel.org>; Fri,  7 Aug 2020 01:45:43 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id j23so521881vsq.7
        for <git@vger.kernel.org>; Fri, 07 Aug 2020 01:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YfgqUuLuz34d1eQbkoft30kyJ0jPQh5flE3r+9px9XU=;
        b=T3obGcJS2ZY1LlxRhnzpF25PZwzvoIabX04WSQSm5y6jG8/sxaPO7WcNhC6bREi/r4
         zRfEEnSlqV6xczjUhEnwlg9XdMTt4VPf9f9lZbeWtgSyA7jT/1wxWXqBYXaWe+JmlBdk
         +4iDz3+FhM+V3HUZjbJqcBc7rowmg5ORoirDTB03kg8P4f8yuhypzpptuQKBPRCBIX8J
         p7bL/GkL/arAmiVIb9VHWnUbVUyK2k+iqWyMcUb/zT6HdJzfOQdVXFwZIha19UF6ESfC
         CGI+e4DWMnCDbQZoooAofpOlpglvnkf4n+5DJp5NdcCWmMhG4+yIPaw+UDQQNQotyRBt
         BpNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YfgqUuLuz34d1eQbkoft30kyJ0jPQh5flE3r+9px9XU=;
        b=WBFhPyRl9C0CoflN1dbk640v6KzzQ35noxNHy4t5GIshCiPKLsXKqnGLq26C1yJ1Lt
         WQezCsDANpIb7NL0I9s8xqvWPz1WD+NGsTC1tj3rrSfPOmFR9qKRR6V1bmF8okJAVeOL
         ZHMUm/z/jfYOs1t1zolkvBhGT181Rc8kk5KjNV1RoPQZ4AnQ+NOruAYP8NY7lFhoqxtm
         qaamULHeq/gUoysqst7VIevMLPL3O5IcveLPGrwFkGuFb70DPVBgZIMKPDCoo08i4em1
         +voC6FRI/dLcGg7i/XynG5SnQprQ5JPeHSYDSqvXfrI+27yEzKlej0O49ZhaoK1Azj/y
         SYtA==
X-Gm-Message-State: AOAM531yol3QmAWjo3uh5ZkP0SF104mt7+Ngo9FzAw7fF+0+XJEwfLdJ
        TBoRWl9ymZF2RsaDaX6RXYF6Npk+TkXC6gPT7XgDbnWr
X-Google-Smtp-Source: ABdhPJxyRGsd7t+/ByXDOjABc7X3OWJ5HdZM336bdXhwVcH06gDhcJFVtNzoLX1BCyu1Yr7qlYowb0QuUbixXECPvxU=
X-Received: by 2002:a67:f787:: with SMTP id j7mr9036215vso.79.1596789942786;
 Fri, 07 Aug 2020 01:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200802143018.5501-1-martin.agren@gmail.com> <cover.1596742823.git.martin.agren@gmail.com>
 <c60416a111bada9624b8b64235ac5c4dd3dedac4.1596742823.git.martin.agren@gmail.com>
 <CAPig+cSjHg2-WYqdkZAS0ye1goj_=5RN3mdjt0-4kSBqNm6WLg@mail.gmail.com>
In-Reply-To: <CAPig+cSjHg2-WYqdkZAS0ye1goj_=5RN3mdjt0-4kSBqNm6WLg@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 7 Aug 2020 10:45:29 +0200
Message-ID: <CAN0heSpjgc0GUHnebeBdtr6Yny3Y_jsjz5hTfJqw15bZiPc8HQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] t: don't spuriously close and reopen quotes
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

Thanks for having a look.

On Thu, 6 Aug 2020 at 22:26, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Thu, Aug 6, 2020 at 4:09 PM Martin =C3=85gren <martin.agren@gmail.com>=
 wrote:
> > diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
> > @@ -364,7 +364,7 @@ test_expect_success 'set up an unresolved merge' '
> >         fifth=3D$(git rev-parse fifth) &&
> > -       echo "$fifth            branch 'fifth' of ." |
> > +       echo "$fifth            branch fifth of ." |
> >         git fmt-merge-msg >msg &&
>
> This one is a bit weird. It really seems as if the intent was to quote
> the word "fifth" in the merge message, so dropping the quotes
> altogether seems wrong. However, the file 'msg' is never even
> consulted in this test (or any other test), so is this just "dead
> code" (including the leading 'fifth=3D' assignment which also is
> otherwise unused outside the 'echo')?

Huh, good catch. The tests showed up in v2 of the patch [1] and there's
not enough context in the archives to tell whether something was partly
removed from an earlier "v1.5" or partly added but not all the way.

We expect to fail the merge -- and we do, and not because of this msg
thing -- and then we look around a little, but we don't resolve the
merge and make a commit. And from what I can tell, there wouldn't be
much point in making a commit. So I should be able to safely drop this
"dead code" entirely.

[1] https://lore.kernel.org/git/20100805112837.GL13779@burratino/>

> > diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> > @@ -213,7 +213,7 @@ test_expect_success 'fetch tags when there is no ta=
gs' '
> >  test_expect_success 'fetch following tags' '
> >         cd "$D" &&
> > -       git tag -a -m 'annotated' anno HEAD &&
> > +       git tag -a -m "annotated" anno HEAD &&
>
> There are a fair number of these quoted single-token arguments
> containing no special characters which don't actually need to be
> quoted at all, so an alternative would be simply to drop the quotes
> altogether, making the commands less syntactically noisy. However,
> that might be outside the intended scope of this change.

FWIW, I find something like `git foo -m "message"` a lot more
intuitive/reasonable than, e.g., `git foo "HEAD"` to signal that here's
a message that could in principle have whitespace, even if this one
doesn't. For all of these, I tried to follow the surrounding style. For
example in t9401, where we do `echo "hi"`. We certainly don't need the
quotes there, but t9401 is very consistent on this and I didn't want to
muddy that unnecessarily.

If we say that "don't use quotes if you don't need to" is a reasonable
thing to strive for, I can drop these in a reroll. I think I'll be
injecting a patch anyway for the "msg" you pointed out in t4200, so I
can certainly tweak this patch to be a bit more aggressive in dropping
unnecessary quotes.

Thanks
Martin
