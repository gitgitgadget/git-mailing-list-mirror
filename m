Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B15C433F5
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 19:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8996E60F02
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 19:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhKBTYu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 15:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbhKBTYu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 15:24:50 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09567C061714
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 12:22:15 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r4so1209874edi.5
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 12:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=BnbO/CiOyfnYcS14o2ALqXOZCPYsOkzZJW9TZO9qIL4=;
        b=pXo/tNJ50ahqsPhOIcgqrOAxo1KXP7YqI6EyYJbv2eN9pcqWUs4I3JsqDMET6Y0XoM
         LL5zEk9nTAFOTFUZvM5xAxYDstUpGnUaOLlywhhfEDu1vE5lcJOg+fxOIyAtANSE++aX
         Fy3sLULp8uu4njqXQHfZJsoiZq7wcw2J5HF1B5LlXSHnFvNSyicGAMUeJQG7bBRuei/U
         UpgYoXNMq/HVjKabPspBZYhoRyqPnG1DVJS9sH6dJdd43rB+iydS3w1YCeoln/IfG1jO
         uas2wBqOpLj2vO9mDfM762/F/6z8PdRcuk7BWCPx9MdZQyTbLGn5+FaSeftPv6rKOwHa
         u5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=BnbO/CiOyfnYcS14o2ALqXOZCPYsOkzZJW9TZO9qIL4=;
        b=U/sTq5xEHngutpdWOTRYnsCClK8/OaE9veqgvHNlbvzoBa17hNCdUc/+54AqoPzLv6
         pQmHZrySbAJad0N2sIdNXOMXHFitU7D9kOZlp+MtHh79ez643VD+ZPXX9vYOoyaePkf7
         LCkcGtl1uax6wD4vDuNT2+ti2CLXgmmmOPMQXq/kHAjzAen2x8usqrV2Byueabe14aRJ
         E4trbWbbtVFtWUIZ4Uu+nnA2RgeM8S7tgTBv8AXKan3wCM9Pxe2H8lIzYZ2JFEMtd+uk
         Lgxbk4lxxs6/48vplQsUh1idzhsGi+XalF537DjJmSWFf9fhZwrUxXP9ejjYcbV/Ip+x
         aBWw==
X-Gm-Message-State: AOAM5312Oivjf2frwsb3zC5EF0RdJgVA/Y2Ol2or9nq8oQwGPyle6fP6
        H5ty6gbetK878fDc8YiLb/0=
X-Google-Smtp-Source: ABdhPJzC0GMsZhOIzFWcMs/CIMMO/BFn1gqExkM+0uI7F4FapYwLVR2dBsTZWzEV/dZ+6gAlRcPTgA==
X-Received: by 2002:a50:da0a:: with SMTP id z10mr53324196edj.95.1635880933512;
        Tue, 02 Nov 2021 12:22:13 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h20sm6635859eds.88.2021.11.02.12.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 12:22:13 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mhzMK-002F9J-KD;
        Tue, 02 Nov 2021 20:22:12 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] var: add GIT_DEFAULT_BRANCH variable
Date:   Tue, 02 Nov 2021 20:14:12 +0100
References: <nycvar.QRO.7.76.6.2111021433010.56@tvgsbejvaqbjf.bet>
 <20211102164434.1005707-1-thomas@t-8ch.de>
 <211102.86czni1o72.gmgdl@evledraar.gmail.com>
 <06095eb4-df18-4f23-8e72-26882c49f25c@t-8ch.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <06095eb4-df18-4f23-8e72-26882c49f25c@t-8ch.de>
Message-ID: <211102.868ry61hy3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 02 2021, Thomas Wei=C3=9Fschuh wrote:

> On 2021-11-02 17:53+0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Tue, Nov 02 2021, Thomas Wei=C3=9Fschuh wrote:
>>=20
>> > Introduce the builtin variable GIT_DEFAULT_BRANCH which represents the
>> > the default branch name that will be used by git-init.
>> >
>> > Currently this variable is equivalent to
>> >     git config init.defaultbranch || 'master'
>> >
>> > This however will break if at one point the default branch is changed =
as
>> > indicated by `default_branch_name_advice` in `refs.c`.
>> >
>> > By providing this command ahead of time users of git can make their
>> > code forward-compatible.
>> >
>> > Co-developed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>> > Signed-off-by: Thomas Wei=C3=9Fschuh <thomas@t-8ch.de>
>> > ---
>> >
>> > Changes from v1 ( https://lore.kernel.org/git/20211030140112.834650-1-=
thomas@t-8ch.de/ ):
>> > * Replaced the custom subcommand with an internal variable
>> > * Cleaned up the tests
>> >
>> > @Johannes: I replaced BUG() with die() from your example because that =
seems to be
>> > nicer for user facing messages.
>> >
>> >  Documentation/git-var.txt |  3 +++
>> >  builtin/var.c             | 13 +++++++++++++
>> >  t/t0007-git-var.sh        | 19 +++++++++++++++++++
>> >  3 files changed, 35 insertions(+)
>> >
>> >=20=20
>> > +static const char *default_branch(int flag)
>> > +{
>> > +	const char *name =3D repo_default_branch_name(the_repository, 1);
>> > +
>> > +	if (!name)
>> > +		die("could not determine the default branch name");
>>=20
>> Isn't this die() unrechable given the similar logic in
>> repo_default_branch_name()? Hence the previous BUG(...)?
>
> Ok. Good point.
>
>> I really don't see how it makes sense to add this to "git var", we have
>> that to correspond to environment variables we use.
>>=20
>> *Maybe* if we renamed GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME to
>> GIT_INITIAL_BRANCH_NAME and made it a non-test thing like
>> GIT_TEMPLATE_DIR, but even then shouldn't we be adding
>> "GIT_TEMPLATE_DIR" and any number of other things to this as well?
>>=20
>> I'm not saying that your patch needs to do that, but we really should
>> think about the interface & future implications if we're going in this
>> direction.
>>=20
>> The reason I suggested extending "git config" in [1] is because it seems
>> like a natural thing for "git config" to learn to spew out our idea of
>> default hardcoded config values to the user.
>>=20
>> But creating a variable form of that existing config just so we can have
>> "git var" spew it out just seems weird.
>>=20
>> We don't have or need such a variable now for anything else, so why go
>> through that indirection, instead of something that closes the feature
>> gap of asking what a config variable default is?
>>=20
>> In any case whatever we do here this really should be updating the
>> documentation of init.defaultbranch & the relevant bits in the "git
>> init" manpage to add cross-references, similar to how we discuss
>> GIT_TEMPLATE_DIR now.
>>
>> 1. https://lore.kernel.org/git/211030.86ilxe4edm.gmgdl@evledraar.gmail.c=
om/
>
> I'll then wait for a consensus of the git devs. The actual implementation
> shouldn't be the issue afterwards.
>
> Thanks for looking into this!

Please don't take that message as me or anyone else "pulling rank" just
because we've got some previous commits in git.git. That applies to both
me and Johannes, and clearly we disagree on this minor bit of UX
direction.

I'd think if anything the opinion of someone who's not overly familiar
with the system would be more valuable, i.e. yours, especially since you
tried & failed to find a way to do this recently. Would you find it more
intuitive to look in say "git var" over "git config" for this sort of
information?

A further weirdness is that another effective source of config for this
is the "unborn" ls-refs feature[1]. I'm not sure what that means for any
query interface, i.e. would a user want to know what branch a freshly
cloned repo would end up with in advance, taking into account all of the
local config, remote "unborn" etc?

1. https://lore.kernel.org/git/878s8apthr.fsf@evledraar.gmail.com/
