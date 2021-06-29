Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007D9C11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 12:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC68061D70
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 12:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbhF2MIV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 08:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbhF2MIU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 08:08:20 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07FFC061760
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 05:05:52 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id v20so17392464eji.10
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 05:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=4Z0USvEE+uqnPr2Zqd8YjwWeB2EMOvv+QrzD+GxB5YQ=;
        b=D6DM0n25hMdj+dz2Yv2Rxb2TZm30s+AFVDoZhDJuift4pdhExKMWFfPYwLtdNLmBcd
         PY1q3cFlL/7z+EKtItUzloNNJWjnImL+72U/4ILWdK8hvymvVRJK5zzHYLiptGXMCZug
         hmnvYU5NJlux7a1zft6uqBGB9f5m4QE7ZdjJ9E3Fb3l7mLgLhkexd7j0fbhpTIJo1t2j
         gL2tXhnEJeEWHCCvGbIHH4EKiyBNru8T1FpNhP+8UXibwU9qN1g1ejN9JAc27g913qz3
         MxWImSibjNsYNENjT6l4d1USNTUZhnl5S3tUU/81XpoeeQ4B9LOxrLkvLc5Yfzj1rWzP
         i6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=4Z0USvEE+uqnPr2Zqd8YjwWeB2EMOvv+QrzD+GxB5YQ=;
        b=WR4Ujg+n7bBxOCqKf9DtZB8sLy7AsIaIR+VKiWGUYrVMD4wTsqQ0N1BL1nmfKA0XzS
         seIx3uFZ710esmsUOhZiXKKetmb3lrSq2ZfrXKftQF8SmbvGRkpRMc9pvIZkhXN6B83j
         WrG033VaM/zch1vhnT5gpc6IunF8YcwBFHSpLiTnCj6C38UokZPVaH2SO0B0OAanrTH9
         5h33Ue5DcZBgvwIAehb4a5IlzszOUt2xf1jWjSfuAOjUJndFEeYuf8b2zcCPPCPKJCMd
         ULnD8gKYt0x9Aa2R3gtYhKycBmoDvrJMx8LZn1+y1483UBcV0xoJVtAralpVYNjebks8
         0/Mg==
X-Gm-Message-State: AOAM532cx36U0wkzqnpofdCxiIFDGcy8TdMvQEjto2+6BfXRx4DjYBww
        NQlH0qap/G5aHMVWtQzr2R8=
X-Google-Smtp-Source: ABdhPJxQndSFykCfhVHGnHgVFXDsUpbl4QpxDnOT8Tem2KYJFb/ZgAT2T8i3IWomHdFzr34IPhbzAw==
X-Received: by 2002:a17:906:6b8a:: with SMTP id l10mr29280686ejr.125.1624968351383;
        Tue, 29 Jun 2021 05:05:51 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id x1sm4447552edd.25.2021.06.29.05.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 05:05:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Martin <git@mfriebe.de>
Cc:     git@vger.kernel.org
Subject: Re: feedback/idea about "switch -C" force create
Date:   Tue, 29 Jun 2021 13:33:12 +0200
References: <20eb626d-89b4-fe2a-7cf4-c596b634f0f8@mfriebe.de>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20eb626d-89b4-fe2a-7cf4-c596b634f0f8@mfriebe.de>
Message-ID: <87wnqcg9k1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 29 2021, Martin wrote:

> First of all, my first post, hope it's the correct place.

Hi Martin. Welcome, and yes you're in the right place.

> I've been using the new git switch for some time, and also I have
> helped people new to git.
> When people are new to git, I try to avoid introducing them to
> commands that can loose them commits (such as git reset).
>
> "git switch" however has to be on the list of commands that new user
> have to learn early, but unfortunately when used with "-C" it may
> cause the loss of commits.
> I am aware, it is a force option. But I still think it may be better
> if it could emit a warning, or even reject the job.
>
> Reasons:
> 1) Newcomers may not be aware of the extend of such a force at
> all. Newcomers may not expect loss of commits, on such an elementary
> command.
>
> 2) People aware that it is a "force" may not be aware of the extend of
> the force, because there are either up to 2 actions forced.
>
> Action 1)
> The move of the branch is forced.
> - That means, the info which commit was on the top of the branch
>   before will be lost.
> - Also the move may affect push-ability without "force"
>
> Action 2)
> The commit may be lost (except for the reflog, but many less
> experienced people do not know that).
> This loss is dependent on other factors. It may or may not happen.
> Because it does not always happen, people may not expect it.
>
> As a result:
> - A user could believe the force is for the effect on the branch, and
>   be unaware of the loss of commit
> - A user (ever experienced) could opt for the force in the good belief
>   that their commits are held by other branches, when maybe they are
>  not.

Makes sense. So basically the users are not using "-C" as some typo for
"-c" (e.g. as a result of using the readline M-u key-combo), but mean
"force", they just don't know what "force" actually does, and lose data.

While I suspect the answer is something like "they had no idea, git
errored, and they tried another option" I'd be interested if you know
what these users were expecting the "force version of -c" to do in this
case & what the use-case is.

E.g. are they using this to (re-)create a local topic branch for an
upstream PR that may or may not have advanced, and they may or may not
have local work they forgot about, so they get in the habit of using it
& sometimes it destroys their data. More below...

> Therefore I believe, it would be best, if=C2=A0=C2=A0 git -C=C2=A0 branch=
 new-location
> would give an error, if this will lose commits.

...so just to clarify, do you mean that forcing it would be OK if you
advance the branch, so in git.git terms you could do:

    git switch -c mynewbranch master # creates new branch
    git switch -C mynewbranch next

Which would be OK since what's in "next" is in "master", But doing the
reverse would error:

    git switch -c mynewbranch next # creates new branch
    git switch -C mynewbranch master

Do you think just a plain "-c" should also error if you "lose" a commit
by committing on a detached head, or that should be treated differently
(and if so, why?). I.e.:

    git checkout master^0
    touch foo && git add foo && git commit -m"foo"
    git switch -c a-branch master

Which gives you something like:
=20=20=20=20
    $ git switch -c a-branch master
    Warning: you are leaving 1 commit behind, not connected to
    any of your branches:
=20=20=20=20
      ceccd14206 foo
=20=20=20=20
    If you want to keep it by creating a new branch, this may be a good time
    to do so with:
=20=20=20=20
     git branch <new-branch-name> ceccd14206

I mean, you could pun on that warning for what you're suggesting, but it
seems to me that it would be sensible that they're consistent, no?

I.e. either we don't error on -C and give a similar useful warning (now
we don't say anything), or error on both.

Don't read any of the above as disagreement with your proposal, just
spitballing ideas & edge cases.

> There could be
> - a git config to=C2=A0 toggle this
> - an additional command line option to extend the force to drop commits
>
>
> I would like to know if that idea might in general be acceptable at all.
> If so, where it could or should be made as a feature request
> (unfortunately I wont be able to provide a patch myself)

Ideas are most welcome, unfortunately the git project is almost entirely
limited by who can come up with patches.

I had some more general proposals for the UI of "git switch" recently at
https://lore.kernel.org/git/877dkdwgfe.fsf@evledraar.gmail.com/

None of that steps on the toes of the idea you have explicitly, but it's
a very adjacent area, so I'd be interested to know what you think.

I haven't had the time or desire to write up complete patches for that
idea of mine, so it's gone nowhere thus far. I'm afraid yours will
probably similarly languish unless you or someone else is willing to
pick it up...

> On top, I would propose that the documentation of the current
> behaviour should be made more clear.
>
> https://git-scm.com/docs/git-switch about -C / --force-create
>> =C2=A0 Similar to --create except that if <new-branch> already exists, it
>> will be reset to <start-point>. This is a convenient shortcut for:
>>
>> =C2=A0 $ git branch -f <new-branch>
>> =C2=A0 $ git switch <new-branch>
> While the word "force" is in the option itself, the description does
> not explain what is forced, or what effects this may have.
> Instead it only refers the user to study another option.
> I believe the documentation should state directly
> - commits currently in part of that branch may be lost [under certain
>   circumstances]
>
> and maybe, but less important
> - the old location of the branch will be lost

...realistically unless you provide a patch or someone interested
happens to pick this up (which I'd deem to be not likely) this
observation is likely to just languish in our ML archive.

If the "I won't be able to provide a patch" has to do with not thinking
you have the know-how to do so I and others would be happy to
help.

E.g. in the case of the documentation change you can even do the change
entirely on the github.com/git/git web UI, no C compilation
etc. needed. Our Documentation/SubmittingPatches has more info on the
general process.

Most of the actual work in doing the sort of change you're suggesting is
the leg-work of figuring out the relevant UI edge cases. E.g. I could
write (and could provide you, if you want to run with it) a patch for
"git switch" that dies on "-C" unless "--force-i-really-mean-it" or
whatever is provided. The real work is then going through the test
failures, checking/explaining that each thing you need to change as a
result makes sense etc.

I think your idea of a config option for this sort of thing might make
sense, but really only if it's done in a more holistic way. That's
basically saying "I wouldn't like the small change you want unless it's
a more general feature", but I think for users having just *one* of our
many --force options behave this way would just be more confusing than
not.

E.g. Emacs has a general facility for disabling the training wheels it
comes with by default, certain commands are considered dangerous or
confusing to newbies and disabled by default.

I'd think such a mode would be useful e.g. for this, replacing "git push
--force" with the "--force-with-lease" option etc., but starting on an
end-state where a user who means "--force" eventually needs to tweak a
"yes I mean force" for all the commands they regularly use would be
worse for everyone.
