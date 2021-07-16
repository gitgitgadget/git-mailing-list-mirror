Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0217EC12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 20:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D41FB613FD
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 20:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbhGPURG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 16:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhGPURG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 16:17:06 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED72C06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 13:14:09 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id n187-20020a4a40c40000b029025e72bdf5d6so2749398ooa.0
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 13:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Bdi0oAUtSCCRmBVX3SomlRrCw0Ni1bsBz0LGNs/j0Zo=;
        b=AhDnUhHzMLartXHv7DqHhMH9BFZHKYYXwVsKt18WEVGdrmBecH2ai5Djgb2S/flgYj
         hjRzipGnigeKGLmHOeRFRqU93hjlrFirt/TFF7a6Rahvu9EZmVs+hY5t+KqsVxPtwG97
         xTyW/YzkYb+QbJxDSu1sULv0cvnIbcwquj5/mdP6VIU5Ozlr6uFZ1Z/gP54E7+lxtqxX
         bkBvvcIxnC88hpQkm5XE8HRcEEUG03UM+X+/g7/fj/moNfhGZCq2MIvPWPBy8NrUCkJd
         sCwKowYOKkcosQWfu2iTWGvB/eZJhrIIvvxxynaXWsT0zaNleQcDwulSKN366COFlGtG
         4cww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Bdi0oAUtSCCRmBVX3SomlRrCw0Ni1bsBz0LGNs/j0Zo=;
        b=uLFn+ucU7TIKEXuzu2ud1DgVf+2AC4yaJWGdaY58R/NadGy+Q7d2JovUDgo7tJnofw
         n/Xjib/DPi3rwjcnmJGTjBKceyMSBG1do/cgo1AJZy4tnihkItfYYB7p6PIw1axUI/yF
         ZqN1SIHgvxFDq+4gAm3GKO48sMzOR27l32be/GZFIYh84kXUD6UmfQ7ungVbEHzfzMC1
         25WltY2zUQ5n6xLMgqZmH8GKdXyj5fQAKSxz255XkPvZb18D5SVe1ip4MH0h3+IYj4JY
         /i/bppMzJBes+nJPuCsM+TwE+lh6NlpceSf6QothiNui4kFq9aE2HHMh/1sisYXDbq7x
         9cbA==
X-Gm-Message-State: AOAM530JRBNtZU11IRL4ysa+hitFHhM/cpEojFV30hc/wu8hQHVXmBYg
        XWrEexRJlg+9fAIxvIL5YHk=
X-Google-Smtp-Source: ABdhPJy6I3Q4zIjhyx9EUzm4cBs0DIPpSDP71pzt2xlobqtmMoI/M81/1F9BBym5SvlOjYvUaNpp3g==
X-Received: by 2002:a4a:6042:: with SMTP id t2mr572235oof.31.1626466449245;
        Fri, 16 Jul 2021 13:14:09 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id v3sm2113825ood.16.2021.07.16.13.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 13:14:08 -0700 (PDT)
Date:   Fri, 16 Jul 2021 15:14:01 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Luke Shumaker <lukeshu@lukeshu.com>,
        Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <60f1e88949659_3302085e@natae.notmuch>
In-Reply-To: <87zgumyd7w.fsf@evledraar.gmail.com>
References: <20210710234629.17197-1-felipe.contreras@gmail.com>
 <20210714202344.614468-1-felipe.contreras@gmail.com>
 <20210714202344.614468-2-felipe.contreras@gmail.com>
 <87bl74zdtb.fsf@evledraar.gmail.com>
 <878s28zdmz.fsf@evledraar.gmail.com>
 <60f088b054e74_519c2084d@natae.notmuch>
 <87zgumyd7w.fsf@evledraar.gmail.com>
Subject: Re: [PATCH v3 1/1] completion: graduate out of contrib
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Thu, Jul 15 2021, Felipe Contreras wrote:
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >> On Thu, Jul 15 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >> > On Wed, Jul 14 2021, Felipe Contreras wrote:
> >> >> [...]
> >> >> @@ -2399,7 +2399,7 @@ test_expect_success 'sourcing the completio=
n script clears cached --options' '
> >> >>  	verbose test -n "$__gitcomp_builtin_checkout" &&
> >> >>  	__gitcomp_builtin notes_edit &&
> >> >>  	verbose test -n "$__gitcomp_builtin_notes_edit" &&
> >> >> -	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
> >> >> +	. "$GIT_BUILD_DIR/extra/completion/git-completion.bash" &&
> >> >>  	verbose test -z "$__gitcomp_builtin_checkout" &&
> >> >>  	verbose test -z "$__gitcomp_builtin_notes_edit"
> >> >>  '
> >> >>
> >> >> diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
> >> >> index bbd513bab0..784e523fd4 100755
> >> >> --- a/t/t9903-bash-prompt.sh
> >> >> +++ b/t/t9903-bash-prompt.sh
> >> >> @@ -10,7 +10,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> >> >>  =

> >> >>  . ./lib-bash.sh
> >> >>  =

> >> >> -. "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"
> >> >> +. "$GIT_BUILD_DIR/extra/completion/git-prompt.sh"
> >> >>  =

> >> >>  actual=3D"$TRASH_DIRECTORY/actual"
> >> >>  c_red=3D'\\[\\e[31m\\]'
> >> >
> >> > It's more of a "for bonus points", but a nic way to round-trip thi=
s
> >> > would be to make this work with GIT_TEST_INSTALLED.
> >> >
> >> > I.e. source these relative to GIT_EXEC_PATH, not $GIT_BUILD_DIR, I=
 think
> >> > that just sourcing them as e.g.:
> >> >
> >> >     . git-completion.bash
> >> >
> >> > But the GIT_TEST_INSTALLED case is tricker, maybe we'd need to add=
 a
> >> > "git --share-path" :(
> >> =

> >> I forgot to include this not-working patch, i.e. I've got no idea wh=
at
> >> the "something" should be other than the harder thing of compiling
> >> "sharedir" into git and making "git --share-path" work.
> >
> > I don't think there's a "something" that would make sense.
> >
> > It would be something like '/opt/git/bin/completion'?
> =

> I think more importantly if they're going to be "first-class" component=
s
> that we have some native way of getting them to the user.

Yes, I already said --share-path would make sense [1] in your other
reply.

> I.e. once you install git being able to load them in your shell as:
> =

>     . git-path
>     . git-completion
> =

> Or whatever, which means either putting them in $PATH (i.e. we'd drop
> them in bin/ along with the non-dashed-built-ins like git-upload-pack
> etc.), or something like:
> =

>     . "$(git --completion-path)"/bash
>     . "$(git --completion-path)"/zsh
> =

> Or maybe:
> =

>     . "$(git --extras-path)"/completion/bash.sh
>     . "$(git --extras-path)"/prompt.sh
> =

> ?

But that's not how completions should work.

There's a standard location for bash completions in order to be picked
by bash-completion:

  /usr/share/bash-completion/completions

This will be the case regardless of what --extras-path is.

The user *should not* be sourcing anything from there directly,
bash-completion does that automatically.

This location depends by distribution, and the standard way to figure it
out is:

  pkg-config --variable=3Dcompletionsdir bash-completion

If you don't have bash-completion insalled, *then* you would need to
source the completion file directly, but you cannot use pkg-config to
figure out that location, so you would need to use the default
(/usr/share/bash-completion/completions).

We could install the completion twice (or provide a symlink):

  /usr/share/bash-completion/completions/git
  /usr/share/git-core/completion/bash.sh

So if the user doesn't have bash-completion installed, can do:

  source "$(git --extras-path)"/completion/bash.sh

Instead of the standard:

  source /usr/share/bash-completion/completions/git

But *right now* the standard location is standard, distributions are
using it, and users are using it.

Moreover, it seems a bit wasteful to have --exec-path, --html-path,
--man-path, --info-path, --extra-path. Why not have --path=3Dextra
instead?

Once again, I think this is a good idea, but it should be done
separately, and you yourself said "for bonus points".


Not to mention my strong feeling that *even* if I implement this nice
feature, Junio will still ignore this series (as he ignores everything I
send), so I will be simply wasting my time implementing something that
will never be merged (just like he stood on the sidelines watching us
implement 6 versions of the man pager colorize patch just to say "no
thanks" [2]).

I'd be more than happy to add any other suggestions you might have, but
let's be honest: this is a patch we all will have be carrying ourselves
(I have dozens of those), so I'd rather not add more complexity for a
perfect solution that won't be applied.

I'd rather aim for something that is good enough.

Cheers.

[1] https://lore.kernel.org/git/60f0859399369_519c2083c@natae.notmuch/
[2] https://lore.kernel.org/git/xmqq4ke8pig9.fsf@gitster.g/

-- =

Felipe Contreras=
