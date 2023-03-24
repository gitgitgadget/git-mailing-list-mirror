Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928D2C6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 03:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjCXDuK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 23:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjCXDuI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 23:50:08 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A2724CAD
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 20:50:07 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id ix20so742860plb.3
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 20:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679629806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awMSq4YKCKEruP2LdON6tm1RraWK3uw2i686TyGgBQk=;
        b=MGxDqMVMN+N8uqMtVW3YnAF7vRkd7igS6dytIi8Pv744Sz8b73dxVL3Y+HCLlJulcx
         8dmQZ9NpMaVXjf8VQYY2ADJP9FVIVkRTEGe17IBs2Rre/h1drritMh8uwqkfSGrrHDXJ
         4M16oluw+YzHXf5zCDy9JHzr5rhiktUruNeZjZTUsfYh+Azk1Pml9/XIKC/txrL+E4Yi
         9jVfNL39l6CRuO1xsGkKXI5nvVzkrqZKi8uZp8NMU2zebYPY0WOb2px34Mr9uPv5QHDp
         KVuVVthWszfmAI3YSSq7gMG4zukobRNdUUn2rYHoaqHKg8qoauJKHCBJrhOBgOwm0EiB
         B7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679629806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awMSq4YKCKEruP2LdON6tm1RraWK3uw2i686TyGgBQk=;
        b=HVpLwo+Vl4ZoGqhcYzB5PR4mFZyv5AQ+avv+tNDRJoi+7V3GBSZKMuQx/S80jOTQ8T
         5n2FGg9mGfQG7uqpnXpHuNFPFxmoj5uvwC7gXun00tNjYri65p13IR0mUtELtMvLLyX1
         WWdZgEMEFLKHuMCc4fXCwRUBcNwledraUqrGmK9Qs2H8peiTZvh42biyvCyfy2J1pofg
         ViN4iJSVrc8d3rs91Yav5srGAhb30eTupHh88H4PbgrNsv0L65HggWujXJs2EeufNSAE
         awSUDA4WbKP7dh8g2NZ4mhEFbxSn8FDgm3Op0x0McEusKHMMGwJEt6kX8qFx8qHcn5xB
         USUg==
X-Gm-Message-State: AAQBX9fqgvdLb/3iBlRnqwYtEPR05cT8Ry61yEWHkLDDzv3D36MCl76o
        aTN6IP+03b6N9jQyqMo706ZCQ48w6bg678KBO+I=
X-Google-Smtp-Source: AKy350ana2MrdkgRu1SjneMDjJ0Moj2yQraDLH4hi4689ryJKYPpaXKE+moHH6twpTkBduVemofMVtFleUDR6EoT53Y=
X-Received: by 2002:a17:902:7088:b0:19a:5953:e85c with SMTP id
 z8-20020a170902708800b0019a5953e85cmr506617plk.1.1679629806439; Thu, 23 Mar
 2023 20:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230119055325.1013-1-carenas@gmail.com> <20230120113553.24655-1-carenas@gmail.com>
 <8f24fc3c-c30f-dc70-5a94-5ee4ed3de102@dunelm.org.uk> <xmqq355wbaar.fsf@gitster.g>
In-Reply-To: <xmqq355wbaar.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 23 Mar 2023 20:49:55 -0700
Message-ID: <CAPUEspj_Bh+LgYLnWfeBdcq_uV5Cbou-7H51GLFjzSa5Qzby9w@mail.gmail.com>
Subject: Re: [PATCH v4] checkout/switch: disallow checking out same branch in
 multiple worktrees
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        pclouds@gmail.com, Jinwook Jeong <vustthat@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2023 at 5:06=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > Hi Carlo
> > ...
> > As I said before, it would be much easier for everyone else to
> > understand the changes if you wrote out what they were rather than
> > saying "look at the tests"....
> > ...
> >> +    if (!opts->ignore_other_worktrees && !opts->force_detach &&
> >> +        check_branch_path && ref_exists(check_branch_path)) {
> >
> > I think check_branch_path is NULL if opts->ignore_other_worktrees is
> > set so we could maybe lose "!opts->ignore_other_worktrees" here (or
> > possibly below where you set check_branch_path).
> > ...
> >> ...
> >> +            if (!opts->ignore_other_worktrees && !check_branch_path &=
& new_branch_info->path)
> >> +                    check_branch_path =3D xstrdup(new_branch_info->pa=
th);
> >
> > I'm a bit confused what this is doing.
> > ...
> >> +test_expect_success 'allow checkout/reset from the conflicted branch'=
 '
> >
> > I'm not sure what "the conflicted branch" means (it reminds we of
> > merge conflicts). Is this just testing that "checkout -b/B <branch>
> > <start-point>" works?
> > ...
> >> +test_expect_success 'and not die on re-checking out current branch ev=
en if conflicted' '
> >
> > I think 'allow re-checking out ...' would be clearer, again I'm not
> > sure what's conflicted here.
> > ...
> >>   -test_expect_success 'not die on re-checking out current branch' '
> >> +test_expect_failure 'unless using force without --ignore-other-worktr=
ees' '
> >
> > This test passes for me - what's the reason for changing from
> > test_expect_success to test_expect_failure?
> >
> > Thanks for working on this
>
> are there remaining things
> to be done and issues to be resolved before we can see v5?

it interacted with another branch
(rj/avoid-switching-to-already-used-branch) that was just recently
merged to master.

it also was probably too aggressive as pointed[1] by Phillip after my
explanation of the change of behaviour as quoted:

>> Using`checkout` for simplicity, but also applies to `switch`,
>>
>>    % git worktree list
>>    .../base  6a45aba [main]
>>    % git worktree add -f ../other main
>>    Preparing worktree (checking out 'main')
>>    HEAD is now at 6a45aba init
>>    % cd ../other
>>    % git checkout main
>>    Already on 'main'
>>    % git checkout -B main
>>    fatal: 'main' is already checked out at '.../base'
>
> Thanks for explaining that. If there is no <start-point> given we don't
> reset the branch so it seems a bit harsh to error out here. For "git
> checkout -B <branch> <start-point>" when <branch> is checked out in
> another worktree requiring --ignore-other-worktrees makes sense.

I wasn't sure on how to proceed from there, but will come with a v5 to
discuss further.

Carlo

[1] https://lore.kernel.org/git/a848b7d5-fd40-b043-7ed9-1672f65312e6@dunelm=
.org.uk/
