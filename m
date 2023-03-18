Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AEDC76195
	for <git@archiver.kernel.org>; Sat, 18 Mar 2023 06:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjCRGAZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Mar 2023 02:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjCRGAY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2023 02:00:24 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EB22C65F
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 23:00:19 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id x22-20020a056830409600b0069b30fb38f7so4016349ott.5
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 23:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679119218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Zxk5u1opsJr5ECy3oNS1u6NsdRbICF3Qa/Mj6lm57A=;
        b=KE5hAQILROOSpHQRf8sbEEQ6sP7iCGxZQovykVDpR+1jGfxGDAzDRl4aRk4niXTF9Z
         G7Wo2E09X2+6GnjR24vfbm4N6rfQnmf5k8Da7fsCA9F4zV6X6zE6Rxro49WdntSSUdZb
         r3HG2a7GI2nap+K8845oHoeZVlbvPEw5XqOwTb8dID/G3YUCvmkhwZAuU1XWZLgoqS58
         zdLpyDkrl2u30V0yFfWxDCSOeC4J47YxtKuKJQCtPpDT2tfTtAJqLg3PxShUZSvXy+8U
         /QIxRSuvcBQcMjYhyVMbA2RRN7gjb3bn2tU5TX77vgX4OUqse7wd3xrC2tEdZwFvi3PB
         Hv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679119218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Zxk5u1opsJr5ECy3oNS1u6NsdRbICF3Qa/Mj6lm57A=;
        b=5zljmSuihFxPCJkSuYY4ACiwNzaa3m8PmYGVbnh1Shuy8WOYMgirtXH1Zn1bNhEFzS
         /YP2FzUSN9DORENjAtUIx3S0f9tD5uEc7Y8QSrEuF39ZliubgzQu/qXnEMjVfXEbumC1
         hDSZN88A078pKNCQ/N9fae/G9I/c1gZimdn5CAu1vTNTpuXm5VG1vLfD2Qw7G3/udLa1
         XoKbfrDAbrNRJQ9amDzjdeLLwcd3JQsBKv9pU+PYz9BITAv+07pWTmvGwqsFj6gg5F8i
         UOBJrwtuEo1XvhRfkRkYF/E5QCvyocZKNdNynta9MMrGJuLSORkeId317TKuL0Qf/4ha
         ectg==
X-Gm-Message-State: AO0yUKWzCRtH/BzxAQ9hd+le7wWLL82OaVtMJwTOqwep2b1Zp10nMMgL
        rGgDOlCzCJAdeWE0bOtheI18sa/dBR/EjnWIvkzLy7RY
X-Google-Smtp-Source: AK7set+GhtJmBlj1Fr6OSQo96EAyZ+a8eTEHOTZqrYe5Wx4WZ8ukwIvgHieMb7TCZTuIfdsgzbBwGy3DuWXeY0K3Pe0=
X-Received: by 2002:a9d:4e8d:0:b0:690:eb8c:bae0 with SMTP id
 v13-20020a9d4e8d000000b00690eb8cbae0mr326404otk.6.1679119218449; Fri, 17 Mar
 2023 23:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230225180325.796624-1-alexhenrie24@gmail.com>
 <20230305050709.68736-1-alexhenrie24@gmail.com> <20230305050709.68736-4-alexhenrie24@gmail.com>
 <kl6l7cvsi006.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CAMMLpeRGEETraueJTTV0tJSsycNYF24YX8n6h-pMp87VcCRJtQ@mail.gmail.com>
 <kl6lzg8cvby2.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CAMMLpeR4x0_u=JGnWQ1xvBeVBXBw7VAgLTWgvHdMFDZLrcy1pA@mail.gmail.com> <kl6lwn3guxrv.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6lwn3guxrv.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Fri, 17 Mar 2023 23:59:00 -0600
Message-ID: <CAMMLpeS3+NUQa2oqpHKVo3yWQNVMgkEXrs4U5_ggvk31yQbezQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] rebase: add a config option for --rebase-merges
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, sorganov@gmail.com,
        calvinwan@google.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 16, 2023 at 4:39=E2=80=AFPM Glen Choo <chooglen@google.com> wro=
te:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> >> Your doc patch explains the rules pretty clearly, but perhaps it doesn=
't
> >> explain this mental model clearly enough, hence the confusion. If we
> >> don't find a good way to communicate this (I think it is clear, but
> >> other reviewers seem yet unconvinced), I wouldn't mind taking Phillip'=
s
> >> suggestion to have "--rebase-merges" override
> >> "rebase.rebaseMerges=3D'specific-mode'".
> >
> > I got the impression that everyone, including Phillip,[1] already
> > agrees that the proposed documentation is clear about the interaction
> > between the config option and the command line option. However, it is
> > a little weird when you consider that other flags with optional
> > arguments, like `git branch --track`, unconditionally override their
> > corresponding config options.[2]
>
> Ah, I didn't consider other options like `git branch --track`. I haven't
> looked into what is the norm, but I think we should follow it (whatever
> it is).
>
> If other reviewers have a strong idea of what this norm is, I am happy
> to defer to them. If not, I can look into it given some time.
>
> > Let me ask a different but related question: If we add a
> > rebase-evil-merges mode, do you think that would be orthogonal to the
> > rebase-cousins mode?
>
> I am not an expert on this, so perhaps my opinion isn't that important
> ;)
>
> My understanding is that `[no-]rebase-cousins` affects which commits get
> rebased and onto where, whereas `rebase-evil-merges` would affect how
> the merge commits are generated (by rebasing the evil or by simply
> recreating the merges). From that perspective, it seems like yes, the
> two would be orthogonal.
>
> Hm. Maybe this means that we'd be introducing a new option, and that my
> hunch that we would change the default to `rebase-evil-merges` is more
> wrong than I expected.
>
> Though I guess this doesn't really affects what we do with the CLI
> options _now_, since the discussion is about what we do about defaults,
> and what the default is is quite immaterial.

I looked through the code and documentation and found 12 good examples
of command line flags with an optional argument that always override
their corresponding config options whether or not the optional
argument is given:

git -c branch.autoSetupMerge=3Dinherit branch --track mynewbranch

git -c commit.gpgSign=3Dmykey commit --gpg-sign

git -c core.sharedRepository=3D0666 init --shared .

git -c diff.ignoreSubmodules=3Duntracked diff --ignore-submodules

git -c diff.submodule=3Ddiff diff --submodule

git -c format.attach=3Dmyboundary format-patch --attach HEAD^

git -c format.from=3D'Dang Git <dang@example.org>' format-patch --from HEAD=
^

git -c format.thread=3Ddeep format-patch --thread HEAD~3

git -c gc.pruneExpire=3D1.week.ago gc --prune

git -c log.decorate=3Dfull log --decorate

git -c merge.log=3D1 merge --log mytopicbranch

git -c pull.rebase=3Dinteractive pull --rebase

I found 6 other similar examples where the config option is a
yes/no/auto trilean, but I don't think those are good examples because
it makes total sense for a command line flag without an argument to
override a nonspecific "auto" value in the configuration:

git -c color.diff=3Dauto diff --color | less

git -c color.grep=3Dauto grep --color . | less

git -c color.showbranch=3Dauto show-branch --color master mytopicbranch | l=
ess

git -c color.ui=3Dauto log --color | less

git -c fetch.recurseSubmodules=3Don-demand fetch --recurse-submodules

git -c push.gpgSign=3Dif-asked push --signed

I found 1 good example where the config option does make a difference
if the optional argument is omitted:

git -c diff.colorMoved=3Dplain diff --color-moved

And I found 1 other similar example, but it's not good a example
because the config option doesn't do anything unless the command line
flag is specified:

git -c diff.dirstat=3Dlines diff --dirstat

Given 12 good examples versus 1 good counterexample, I would say that
the established convention is for the command line flag to always
override the config option. Please let me know if there are other
examples that I missed.

It's worth noting that the documentation for `git format-patch
--thread` explicitly says that format.thread takes precedence over
--thread without an argument, but that is not correct: When I tested
it, the command line argument always took precedence.

Another problem is that the documentation for `git pack-objects` does
not even mention that --unpack-unreachable has an optional argument,
and it says that the argument to --cruft-expiration is required when
it is not.

I'm not going to fix all the documentation problems, at least not
right now. However, in order to follow the established convention for
flags with optional arguments, and because we probably aren't going to
use rebase.rebaseMerges to facilitate a future change of defaults, I
will redo the patch so that --rebase-merges without an argument takes
precedence over rebase.rebaseMerges.

Thanks for the feedback. I feel more confident about the way forward now.

-Alex
