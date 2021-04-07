Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081B2C433B4
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 18:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D00D06121E
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 18:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbhDGSlF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 14:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhDGSk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 14:40:58 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC853C06175F
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 11:40:47 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id u10so21923232lju.7
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 11:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YVBZZiJwirgK87iH2xyrrN709tlDj+JdsszbuGh/fKM=;
        b=i2VhZNhLq/h+Q+epD0mqlbFnQuzpVMRPQSfEcEsQKrPyvnWDD+62YY2Vj39UXatjrm
         GH10CmHkFs96bhRsYiH3WX7gznInDSTRRbVooKUY6RHb5AWkMF1lQcTDnBhcOY5RBiXM
         AILotW/mpyOGmNtWT32wGRkLR0OYrQ3QRSlV6aKkehJs3UM+caSfLpVJF/7zKx2ayG//
         VM2fJ6TCBe4SB7xiTYoAhp9RcofkBRCsgDe3lODK+RzBdJFX4IsTU4GTV90X/SPdS92f
         61+zBElILMO2hl6d/Z4HM++Vv2Y8iPd89EfjD4Q+n+/MmpEXMw8+wDn5s3GVF1TaNaed
         KAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YVBZZiJwirgK87iH2xyrrN709tlDj+JdsszbuGh/fKM=;
        b=WruBFfkakzw0n1Qu/TCQdtyMYV6R8fozIHYfKRXlDxRmZi/f+j64pNW+gV0ZUQY5kp
         y/sJ7uDmRSeIl6xdaKCYAkDoQ58YI+aFYzglftsXjoAyPNnCFs1acxgM2crV3Jq/HF3/
         WROopHZaw0qB0XdLkbXJUyMcMKNZWnogjF5uxpWLWTOXqjf71MvkIOYKscSt76MoLp/h
         DJcny2k1NfN0fvCOFdCK7U4Z+ZkUKHUatfXnVUmX3QqYMTnlJ+cGtWS6YOx5wVMmzPoj
         W9PMAwH3x6h01inNe8tPpP+NBj4XgoVqzGzpWgQmHxlpurjgV4X+uf7cdHr+GgikW+bE
         7nwA==
X-Gm-Message-State: AOAM5335cdjqFrLVvNgkrI8h6cMckXCxFPRLaqfDXYCYbFNOiVf/Un8D
        RzOIBgTtZcmfzfTETgKRyoiBza3F1yWITR6bwVmoPdBsKK4wj1Od
X-Google-Smtp-Source: ABdhPJwMQBpgmnFpguG041vZbLUE4n6/U1sQJZoO3SmT07UVraUrN9B4dokyA2H3u8QA3d4ObKy3cty0iksVwB/LBWc=
X-Received: by 2002:a2e:7618:: with SMTP id r24mr2986575ljc.420.1617820846196;
 Wed, 07 Apr 2021 11:40:46 -0700 (PDT)
MIME-Version: 1.0
References: <pull.908.git.1616105016055.gitgitgadget@gmail.com>
 <pull.908.v2.git.1616723016659.gitgitgadget@gmail.com> <ec031dc8-e100-725b-5f27-d3007c55be87@gmail.com>
 <CAMbkP-S-9cccMpU4HG0Wurqap-WkTmD2zk50nKd9kJ_oWO__qw@mail.gmail.com>
 <YGzrfaSC4xd75j2U@camp.crustytoothpaste.net> <87tuoijzsy.fsf@evledraar.gmail.com>
 <9af3770f-204b-253b-d7f2-c9d5e7cf2fdb@gmail.com>
In-Reply-To: <9af3770f-204b-253b-d7f2-c9d5e7cf2fdb@gmail.com>
From:   Albert Cui <albertqcui@gmail.com>
Date:   Wed, 7 Apr 2021 11:40:34 -0700
Message-ID: <CAMbkP-QDzCQbekBf7tdN6zccDU8xnXdYFAuSZSbsdS6hSumghA@mail.gmail.com>
Subject: Re: [PATCH v2] hooks: propose project configured hooks
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Albert Cui via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 7, 2021 at 6:09 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 4/7/2021 3:53 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >
> > On Wed, Apr 07 2021, brian m. carlson wrote:
> >>
> >> I continue to have serious reservations about this series and approach=
,
> >> and I'm not sure that any proposal we can adopt here will address the
> >> security concerns.  To be frank, I don't think this proposal should mo=
ve
> >> forward in its current state or otherwise, since I think the security
> >> problems are inherent in this approach and fundamentally can't be fixe=
d.
> >>
> >> This is, as should be obvious from my email address, my personal
> >> opinion, despite my reference to my employer above.  Unless otherwise
> >> stated, I don't speak for my employer and they don't speak for me.
> >
> > I agree with pretty much every word you said, in particular the social
> > engineering aspect of this. In past mails I've referred to elsewhere
> > I've proposed some Emacs-like "ask" facility for git, but you've
> > convinced me that that default would be a bad idea for the "user just
> > clicks yes no matter what" reasons you noted.
>
> These replies definitely speak from a perspective common to mine.
> This is very dangerous territory and should be handled carefully.
>
> There is also a legitimate user need to use hooks _to contribute_
> to some repositories. Hooks are not needed to read the repositories
> or interact with them as a document.
>
> The current mechanisms require ad-hoc approaches that are custom to
> each project, so there would be value in creating a standard inside
> the Git client itself. I think the proposal goes too far in making
> this an automatic configuration, either because it assumes trust or
> assumes sufficient skepticism on behalf of the users. Either is not
> acceptable for the Git project.
>
> Here are the hard lines I draw:
>
> 1. This should not happen in "git clone" (other than maybe a message
>    over stderr that hooks are available to be configured through a
>    different command).
>
> 2. Hooks should not update in "git checkout" (other than a message
>    that hooks have updated).
>

To =C3=86var's point, maybe it would help to separate the two user bases of
project configured hooks.
(1) Employee working at BigCorp. They are cloning from a trusted
remote on company machines where the company controls what gets
installed and how Git is configured. Their motivation is to make
changes to their local clone and submit changes to a central
repository.
(2) Git user cloning from any remote e.g. GitHub. They could have many
motivations: to make changes, to inspect the code, to simply just
build.

I agree that this feature should not get in the way of users (2), or
expose them to new attack surfaces, users who may have no desire to
have project configured hooks. That said, I think we can still get
into a world that better serves users (1). I proposed this upthread
and would like feedback on it (I realize these examples still assume
one config for every branch, but you get the gist):

Case 1. Opt-into clone setup via config
```
#~/.gitconfig
[hook]
   allowCloneInstallFromRemote =3D $REMOTE
```

IFF $REMOTE matches the config, then `git clone $REMOTE --setup-hooks` work=
s:

```
$ git clone $remote --setup-hooks
The following hooks were installed from `origin` ($ORIGIN_URL):
pre-push: $GIT_ROOT/pre_push.sh
```

Case 2. Without the config opt-in for clone setup
```
$ git clone $remote # using --setup-hooks here wouldn't change
behavior since there's no config opt-in
Remote `origin` ($ORIGIN_URL) suggests the following hooks:
pre-push: $GIT_ROOT/pre_push.sh

If you wish to install them, run `git hook setup origin`.
To always ignore hooks from `origin`, run `git hook ignore origin`.
```

Case 3. Opting into updates
You could imagine a similar config, e.g. allowAutoUpdateFromRemote
that allows Git to prompt users to consent to auto-updating hooks on
"git checkout" with this type of behavior:

....
$ git checkout

The following hooks were updated from remote `origin` ($ORIGIN_URL):

pre-push: $GIT_ROOT/pre_push.sh

If you wish to install them, run `git hook setup origin`.

# The below only appears if allowAutoUpdateFromRemote is set for $ORIGIN_UR=
L
If you wish to always accept hooks from `origin`, run `git hook setup --alw=
ays
origin`. You should only do this if you trust code changes from origin.

To always ignore hooks from `origin`, run `git hook ignore origin`.
....

> 3. Whatever document triggers a hook configuration should live at
>    HEAD and should not be configured or updated until HEAD has been
>    updated by one Git command (git clone, git checkout), time
>    passes for the user to inspect the worktree, then _another_
>    command (git hooks?) is run manually to reconfigure the hooks.
>

I want to separate the requirement from the implementation. What I'm
hearing is that "users should have a chance to inspect the suggested
hook before consenting to installing it." That doesn't necessarily
require the configuration to be in HEAD.

Again, that's reasonable for users (2) but doesn't seem necessary for
users (1) if we have the correct opt-ins.

> I think there is a potential way forward if these items are followed.
>
> But I'd like to ask a different question: What problems are these
> custom hooks solving, and can Git solve those problems in-core?
>
> If we care about checking commits for format or something, is that
> a common enough problem that we could implement it in Git itself and
> enable it through a Git config option? It might be interesting to
> pursue this direction and maybe we'll solve 80% of the need with
> extensions like that.
>
> I'm aware of some hooks that insert things like a Gerrit change-id
> that would probably not be appropriate for such an in-core change.
>

A `git lint` command would cover a lot of the use cases, but to your
point, there are others.

Thanks,
Albert
