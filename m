Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D514C433FE
	for <git@archiver.kernel.org>; Fri,  6 May 2022 21:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358686AbiEFVy0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 17:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355406AbiEFVyV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 17:54:21 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29B71FA61
        for <git@vger.kernel.org>; Fri,  6 May 2022 14:50:32 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id j187-20020a638bc4000000b003c1922b0f1bso4189228pge.3
        for <git@vger.kernel.org>; Fri, 06 May 2022 14:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :content-transfer-encoding;
        bh=ThfGv2vp7dCS52z0CDNTrsZeJaVoVBCvSE+rrTxMltI=;
        b=Qwxwh70pJ2PKi5Vqm7PK8TOivSyxhIkAClYbxoBKTq6CdJHuNQ/mZXy+FbqPWeqQRQ
         ZENaOUX5/WclZYPNo3gX1FmYQhe5ypxOBzMhC4SkdfFlGuazDWYrtTxB+he+8w7cJwUV
         PVF8yOg/G0diUz1d9MryNUl5v1eG457k3yE7zsbaePXKZNw2EhHCuk1NjXW1X8rTEPVr
         3J/7lDjXBsyD/H8JVX/GF+cykJlBQ8pttwGjbFeuV456fFoexgzJsi2IgKLp3DqZYWHG
         QKKyMVmiw9OeDYCQBA0Zft/+Mh3ErnfTisslA63/q9fEvfBqyw5xbLAg8gTgVwvCm0Z/
         U4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:content-transfer-encoding;
        bh=ThfGv2vp7dCS52z0CDNTrsZeJaVoVBCvSE+rrTxMltI=;
        b=BM1Os3FTvTtNWnAzU8J1XDLkpOv1utf8233HJ2X4Hve3fpizKwB58GSKZz8jHHbaxV
         VKddkztYkySrU4ByuHdijeu4dHKy+nEyRJsQPPJ1T69M8TzwqDfLsfjUJv1lmQFtH4ql
         5YuvpsAj0wOtvA4oHTxhu28RTt5NDhnI92gYNw+l66psVh/ixVSCvnFjuI7Yu5y3OTnK
         CJW1DAOc/USlsGg6DNq9HWzRyQbA2kgw8J4kZ6b24lgT2Q1Een9MaqhK7b0A8y3WJswO
         2nM1Y434DfrAlt06gyXKD/VrRfnHs5njUFHfBOmzTynXgvo3q0eSDI68P2GfMCqk0kkO
         P95Q==
X-Gm-Message-State: AOAM532sMn4nqqnzdQRuTq7t4cjT3SaK/IPov48njAs89I+sdBX9QKsJ
        0innaLU4Txdz2I592Cky/qOjWo5ivG4Xyw==
X-Google-Smtp-Source: ABdhPJxyoODXpcGNUJzlhQd3/31yWfE7cyEVvxS4qiImlUILD7gXt/y2tK9sNTq6eYLUlKgc2CsAndzgEVyc9A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:9802:0:b0:50d:4f5d:fef6 with SMTP id
 e2-20020aa79802000000b0050d4f5dfef6mr5613486pfl.9.1651873832061; Fri, 06 May
 2022 14:50:32 -0700 (PDT)
Date:   Fri, 06 May 2022 14:50:28 -0700
In-Reply-To: <fc492627-c552-10ec-b30c-820299241278@gmail.com>
Message-Id: <kl6lbkwa8h5n.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <CAFnZ=JNE_Sa3TsKghBPj1d0cz3kc6o91Ogj-op8o6qK8t9hPgg@mail.gmail.com>
 <fc492627-c552-10ec-b30c-820299241278@gmail.com>
Subject: Re: Bug Report: fetch.recurseSubmodules doesn't affect git pull as
 otherwise stated in the git config docs
From:   Glen Choo <chooglen@google.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Huang Zou <huang.zou@schrodinger.com>, git@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Hi Huang,
>
> Le 2022-05-02 =C3=A0 10:42, Huang Zou a =C3=A9crit=C2=A0:
>> Thank you for filling out a Git bug report!
>> Please answer the following questions to help us understand your issue.
>>=20
>> What did you do before the bug happened? (Steps to reproduce your issue)
>> 1) Set the following configs:
>>  git config submodule.recurse true
>>  git config fetch.recurseSubmodules false
>> 2) On a repo with submodules, run:
>> git pull
>>=20
>> What did you expect to happen? (Expected behavior)
>> git pull doesn't recursively fetch submodules
>>=20
>> What happened instead? (Actual behavior)
>> Submodules are fetched recursively
>>=20
>> What's different between what you expected and what actually happened?
>> Submodules are fetched recursively
>>=20
>> Anything else you want to add:
>> git fetch works as intended. The documentation for fetch.recurseSubmodul=
es
>> states that "This option controls whether git fetch (and the underlying
>> fetch in git pull)" so I would naturally expect git pull to behave the s=
ame
>> as git fetch
>
> I did not try to reproduce, but I took a look at the code and I think I u=
nderstand
> what happens.=20
>
> When 'git pull' invokes 'git fetch', it does so by specifically using the=
 '--recurse-submodules'
> flag, see [1]. It sends either 'yes', 'no' or 'on-demand' as value, depen=
ding on the value
> of the local variable 'recurse_submodules'. This variable is initialized =
to the config value
> of 'submodule.recurse' in 'git_pull_config' [2], called at [3], and then =
overwritten by the value given
> explicitely on the command line [4], parsed at [5].
>
> So when 'git fetch' runs when called by 'git pull', it always receive the=
=20
> '--recurse-submodules' flag, and thus any config for fetch.recurseSubmodu=
les is ignored
> (since explicit command line flags always have precedence over config val=
ues).

Thanks for looking into this! This seems to agree with my reading of the
code. I haven't tried to reproduce it either, but the code looks
obviously incorrect.

> So one way to fix this would be to also parse 'fetch.recurseSubmodules' i=
n 'git_pull_config',
> and send the correct value to the 'git fetch' invocation... Or simpler, c=
all 'git fetch' with
> '--recurse-submodules-default' [9] instead...

Despite having touched this code fairly recently, I had to do quite a
rereading to refresh myself on how this works. If I _am_ reading this
correctly, then I think we actually want to set `--recurse-submodules`
and not `--recurse-submodules-default`.

The short story is that the two are not equivalent - when figuring out
_which_ submodules to fetch (we determine on a submodule-by-submodule
basis; we don't just say "should we fetch all submodules?"),
`--recurse-submodules-default` gets overrided by config values, but
`--recurse-submodules` does not.

The longer story (which I think is quite difficult to explain, I am also
a little confused) is that in a recursive fetch,
`--recurse-submodules-default` is the value of the parent's (we'll call
it P) `--recurse-submodules`. This only matters when a process, C1, has
to pass a value for `--recurse-submodules` to its child, C2. The
precedence order is:

- C1's --recurse-submodules | fetch.recurseSubmodules |
  submodule.recurse
- C2's submodule entry in C1's .git/config
- C2's entry in C1's .gitmodules
- C1's --recurse-submodules-default (aka P's --recurse-submodules)

Specifically, in code:

  static int get_fetch_recurse_config(const struct submodule *submodule,
              struct submodule_parallel_fetch *spf)
  {
    // Glen: passed in from builtin/fetch, which parses
    //  --recurse-submodules, fetch.recurseSubmodules, submodule.recurse
    if (spf->command_line_option !=3D RECURSE_SUBMODULES_DEFAULT)
      return spf->command_line_option;

    if (submodule) {
      // ...
      // Glen: fetch configuration from .gitmodules
      int fetch_recurse =3D submodule->fetch_recurse;

      key =3D xstrfmt("submodule.%s.fetchRecurseSubmodules", submodule->nam=
e);
      if (!repo_config_get_string_tmp(spf->r, key, &value)) {
        // Glen: fetch configuration from .git/config
        fetch_recurse =3D parse_fetch_recurse_submodules_arg(key, value);
      }
      // ...
    }

    // Glen: --recurse-submodules-default
    return spf->default_option;
  }

So `--recurse-submodules-default` really wasn't meant for anything other
than "fetch" invoking itself in a superproject-submodule setting.

Of course, I could be entirely wrong and I should just write up a test
case :). I hope to send one soon.

> [sidenote]
> I'm thought for a while that it was maybe not a good idea to change the b=
ehaviour
> in your specific situation. If you have 'submodule.recurse'
> set to true and 'fetch.recurseSubmodules' set to false, and if the code i=
s changed so that indeed
> 'git pull' does not fetch recursively, then the code will still try to up=
date the submodule working
> trees after the end of the operation (merge or rebase), see the end of 'c=
md_pull' [6], [7]. This  is
> OK, because if there are new submodule commits referenced by the superpro=
ject and they were not fetched because the=20
> fetch was not recursive, then the call to 'git submodule update' in updat=
e_submodules/rebase_submodule
> should fetch them, so no problem there.
> [/sidenote]

I think the bigger question to ask is "what is the intended effect of
'submodule.recurse =3D true' and 'fetch.recurseSubmodules =3D false'?". I
think it is not surprising to think that recursive worktree operations
might fail if the submodule commits weren't fetched.

Perhaps this is just a performance optimization? i.e. after fetching in
the superproject, the user wants to skip the rev walk that discovers new
submodule commits.
