Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FF5EB64D9
	for <git@archiver.kernel.org>; Tue,  4 Jul 2023 22:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjGDWlz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jul 2023 18:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGDWly (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jul 2023 18:41:54 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE5919B
        for <git@vger.kernel.org>; Tue,  4 Jul 2023 15:41:53 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-565d65adcf2so3557474eaf.3
        for <git@vger.kernel.org>; Tue, 04 Jul 2023 15:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688510512; x=1691102512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDOYp9DrdYoRWDMHjycu/vrGpqQOzEf1f9wWwhn7rPo=;
        b=ilHFNtJu1qgP3zU3nwgRjW88j+cugFCCpwS6r3Cm/Wr8m1RbYjcCyqaal8Lw6JirwO
         0EiY1moQ3ppD6Ygvn0SSyquc3ZejwN2q/JL15Ad6FFkBCzsTtxxpCDBKFLoYda1+3n8a
         jnmUeX6A+axCZLBGdnp7rwPSpIEazbPm8jG2juZ3aoN66SimdGfTw2fFFbuOAxvJFb0L
         nF/qDNQgiKPMfUq9bXw9/ZUjnnKtgiL+nbm3MJ5MWbqZc99wXwWJJsDF7Wzu44rax+fL
         gZINnSDz9tENDEukqzjz5OFPxRgyIzqZeU5U+Pvw7ekIF3RjDg+xurvmvRpfIYMCqqKx
         daRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688510512; x=1691102512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDOYp9DrdYoRWDMHjycu/vrGpqQOzEf1f9wWwhn7rPo=;
        b=BM9UDBSzd9o/YrJ4TD0p79VGZqF5eIYxJmSFhbz46QJJX0QDXXh5XvLApU8nRHfUQw
         Pu1jun8vwWQ28dHCTY62DB9ibmqkc9bbBnoW8K5isqXMx9q/lGsf5xB5SMBPS4FfaSHi
         dhp8iMtqMgH+VIOG8Gknhmti5QdVC+gToDaDAO7AroKzNgImH/nSt4jt/QOZnZ1dm5cj
         LiAfKY4o3bXDw42Ti+1MhHs1peWfTWNcO5P/Se78PY45XH3h/H06j2EeO/gVUD5jOsUN
         qtsx0h7kYTERPWn+VcjVfYQqysn37KM2FPrSFch7vbu0cg9mKq7t9YRoinyBhQIqQ9WW
         BcBw==
X-Gm-Message-State: AC+VfDyeQFUUWSFeTPdUkBzD7iUyB3bNHDwygm7jj1BjInbjlVeWb5ca
        3vPpqiW9nJiHW7LVwoyRORWdPqtujbH2B2LGfIM=
X-Google-Smtp-Source: ACHHUZ5jhsjRrkqSz1H7BMePO+8CEKXTDavO+t/VObM/qMR8m6X+EspqRC3JH/ybY8/rHGZOWaxwF2dvwM2/R9u4kCI=
X-Received: by 2002:a4a:4995:0:b0:563:60b4:db82 with SMTP id
 z143-20020a4a4995000000b0056360b4db82mr10870049ooa.2.1688510512141; Tue, 04
 Jul 2023 15:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230702200818.1038494-1-alexhenrie24@gmail.com>
 <20230704194756.166111-1-alexhenrie24@gmail.com> <20230704194756.166111-2-alexhenrie24@gmail.com>
 <xmqqr0pn4a6c.fsf@gitster.g>
In-Reply-To: <xmqqr0pn4a6c.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Tue, 4 Jul 2023 16:41:16 -0600
Message-ID: <CAMMLpeQQk8ik9rJxNNKo9-3hGUuts5W70V=ABB=k9mNwVp+2KQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] remote: advise about force-pushing as an
 alternative to reconciliation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@matthieu-moy.fr, christiwald@gmail.com,
        john@keeping.me.uk, philipoakley@iee.email,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 4, 2023 at 3:52=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> > Also, don't imply that `git pull` is only for merging.
> >
> > Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> > ---
> >  remote.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/remote.c b/remote.c
> > index a81f2e2f17..009034ecde 100644
> > --- a/remote.c
> > +++ b/remote.c
> > @@ -2323,7 +2323,9 @@ int format_tracking_info(struct branch *branch, s=
truct strbuf *sb,
> >                       base, ours, theirs);
> >               if (advice_enabled(ADVICE_STATUS_HINTS))
> >                       strbuf_addstr(sb,
> > -                             _("  (use \"git pull\" to merge the remot=
e branch into yours)\n"));
> > +                             _("  (use \"git pull\" to reconcile your =
local branch with the remote branch,\n"
> > +                               "  or \"git push --force-with-lease\" t=
o overwrite the remote branch with\n"
> > +                               "  your local branch)\n"));
> >       }
> >       free(base);
> >       return 1;
>
> Use of --force-with-lease without which commit you assume to be at
> the tip of their branch is just as risky as blind use of --force.
>
> As I said in a separate message, I do not think "reconcile" and
> "force" cannot both be sensible choices at the same time.  If the
> user wants not to lose the work by themselves and by others,
> reconciling would be the only sensible choice and forcing cannot be
> a sane substitute for that (if the user knows what is at the tip of
> central repository is wrong and wants to get rid of it, forcing
> would be a very sensible choice, but then reconciling would not be a
> subsitute for that in such a case---"merge --ours" does not count as
> "reconciling").
>
> So, I'd suggest to make it a bit more clear that they are not
> alternatives in the message, and discourage forcing in the first
> place by using not "overwrite" but a bit stronger word, like discard
> or destroy.  e.g.
>
>     To reconcile your local changes with the work at the remote, you
>     can use 'git pull' and then 'git push'.  To discard the work at
>     the remote and replace it with what you did (alone), you can use
>     'git push --force'.
>
> or something, perhaps.

I think we're splitting hairs about what the word "alternative" means.
The user has two ways to get their work onto the remote branch:
Reconcile it with what's already there, or delete what's already
there. I would call those two ways "alternatives" and that does not
imply that either one is always a sensible choice, but if you can
think of a word that's more clear, I'm happy to use it instead in
these commit messages.

At any rate, your proposed wording for the advice message in remote.c
is perfectly fine. Thanks, I'll use it in v3. Would you like the same
text in push.c, or was my proposed text there already OK?

-Alex
