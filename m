Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E82BC4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 10:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21AC560F00
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 10:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbhG1Kz6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 06:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbhG1Kzb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 06:55:31 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E31DC061765
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 03:55:29 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id j21so2462345ioo.6
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 03:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eFJLjr+HfsZHIT7b0otf94BuOtOym29fuwTtgGh4q7Y=;
        b=g6cxn6w02Eu1ylqw4fOkTZpINzrV9wu3+m31NRQQZ1b/zgsxy+Qt4hkBePWnFMwp8Q
         Lqn0tlc3y/3GPY3pMkvkfzxQLT/H5yuqm8BiwTJI+NfhJXnNoZVFLjKrEG1dL+G3vopB
         o88dyqaWj6tzqg91y/cIZh3V0z6AsRZJgz5LhNw2eD8l2RZhI2IFrGewAuUB5piIr9ec
         vr4mBKdpOSfqXUj6e1Pyso8cvgmu20guaTySYRE2GovOAFIHqqUGXT5CUOe8QAVJqI2d
         LUTbTKvcE9nyUZWncyEoj29CKu90w86XrpvvV8o1UK4eAOX+/rozdukp9WXMHeVoJlR1
         lMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eFJLjr+HfsZHIT7b0otf94BuOtOym29fuwTtgGh4q7Y=;
        b=i+bYSEUQ8nUpM2nlQ1AwzH1SOY0+93QhgLADOxMV4kcu+5a5JmUX4QQJ8ROrePfa6B
         9X+bDaHZgWK3IPeFYSfIpA0615kP7tfl3AQ3zQOjqRjvKXv5nC1d+orgmjjOz0Fiu/Wr
         y4+dhq/uij6LggkyVfF8cvyYjQL738lZPI+e8xJQK3SXUJOMyhtX+cmNuVGI9Nz0jnJ9
         pZBaA277eYy9jRf7GFe6RC6yVxtNDTWm/ADv4RYN+o7TihpRXbZb4wVrbkwHxA9kquU8
         AFaJzlaeCliQ0ty68Qb/33LU4l+iUOQ/3a+1pwegPITLBe5NYtAbKyYU3vXseBeKn+Yv
         tGKA==
X-Gm-Message-State: AOAM530L0QJjPjFjzOIPAxxfLtyWEzRsZuhxSTs4FmsFaUOYFvs/WAKG
        fzxamGxVOckqW2dInlxyc5OJtgDgli6Le5minD/YL/JnRx8pVJZr
X-Google-Smtp-Source: ABdhPJzBS0PvAe1n4WA/QrE6YwufPXGHbY2W0tFrZaUOD73qfdpCNPK7pBEF1BcLvt9O5UHi/L5gCj+b2m019U9ITRE=
X-Received: by 2002:a02:a1c8:: with SMTP id o8mr25465235jah.50.1627469728857;
 Wed, 28 Jul 2021 03:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1001.git.1626962763373.gitgitgadget@gmail.com>
 <pull.1001.v2.git.1627135281887.gitgitgadget@gmail.com> <a8b260be-dae5-e717-d4cb-3ee123f93620@gmail.com>
 <xmqq1r7jebbf.fsf@gitster.g> <xmqqtukfcvzv.fsf@gitster.g>
In-Reply-To: <xmqqtukfcvzv.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 28 Jul 2021 18:56:02 +0800
Message-ID: <CAOLTT8RRbwss5sJAM-a=LQrZjr0fyOP4C_x8oRGdLFFnpc+M3g@mail.gmail.com>
Subject: Re: [PATCH v2] [GSOC] cherry-pick: fix bug when used with GIT_CHERRY_PICK_HELP
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8828=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=885:00=E5=86=99=E9=81=93=EF=BC=9A
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Phillip Wood <phillip.wood123@gmail.com> writes:
> >
> >> This will break git-rebase--preserve-merges.sh which uses
> >> GIT_CHERRY_PICK_HELP to set the help and ensure CHERRY_PICK_HEAD is
> >> removed when picking commits.
> >
> > Ahh, I didn't realize we still had scripted rebase backends that
> > called cherry-pick as an executable.  I was hoping that all rebase
> > backends by now would be calling into the cherry-pick machinery
> > directly, bypassing cmd_cherry_pick(), and that was why I suggested
> > to catch stray one the end-users set manually in the environment
> > and clear it there.
> >
> >> I'm a bit confused as to what the
> >> problem is - how is 'git cherry-pick' being run with
> >> GIT_CHERRY_PICK_HELP set in the environment outside of a rebase (your
> >> explanation in [1] does not mention how GIT_CHERRY_PICK_HELP is set)?
> >
> > I didn't press for the information too hard, but I guessed that it
> > was perhaps because somebody like stackoverflow suggested to set a
> > message in their environment to get a "better message."
>
> A good way forward may be to relieve sequencer.c::print_advice() of
> the responsibility of optinally removing CHERRY_PICK_HEAD; make it a
> separate function that bases its decision on a more direct cue, not
> on the presense of a custom message in GIT_CHERRY_PICK_HELP, make
> do_pick_commit(), which is the sole caller of print_advice(), call
> it after calling print_advice().
>

I think this function "check_need_delete_cherry_pick_head()" should be befo=
re
print_advice(), like this:

+               const char *help_msgs =3D NULL;
+
                error(command =3D=3D TODO_REVERT
                      ? _("could not revert %s... %s")
                      : _("could not apply %s... %s"),
                      short_commit_name(commit), msg.subject);
-               print_advice(r, res =3D=3D 1, opts);
+               if (((opts->action =3D=3D REPLAY_PICK &&
+                     !opts->rebase_preserve_merges_mode) ||
+                     (help_msgs =3D check_need_delete_cherry_pick_head(r))=
) &&
+                     res =3D=3D 1)
+                       print_advice(opts, help_msgs);

> I do not offhand know what that "direct cue" should be, but we may
> already have an appropriate field in the replay_opts structure;
> "replay.action is neither REVERT nor PICK" could be a good enough
> approximation, I dunno.
>
> Otherwise we can allocate a new bit in the structure, have relevant
> callers set it, and teach cherry-pick an unadvertised command line
> option that sets the bit, and use that option only from
> git-rebase--preserve-merges when it makes a call to cherry-pick.
> When "rebase -p" is either retired or rewritten in C, we can retire
> the option from cherry-pick.
>

I think this one can be easily achieved.

> Workable?

Thanks.
--
ZheNing Hu
