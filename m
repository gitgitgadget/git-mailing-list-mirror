Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_PDS_SHORTFWD_URISHRT_QP,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B0CC433ED
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 09:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9417611F2
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 09:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbhDKJkf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 05:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhDKJkc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 05:40:32 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3356C061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 02:40:14 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id l123so7198454pfl.8
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 02:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=E6sx1WJdBk2a7G3dorPJ2CmHjvewuP1hAm3CRay7bUw=;
        b=erruTslwTCitstHmRWojrSKaVx4fOlkShH76rKLNL7J7/AFbfceHQzuf9p6RCVMPyS
         0OVLyQPANAzDFAVTb6W/JFAkgErPHJpYNivxxgp0K7JDL64PzHSnoS2OkL3K2RMgOmFG
         H+GLCM/CVBN8eJa30d9GirZGRl5esaersULKeAbpAlPjRuYzGDuSIRNDWtCgfeqD/lfH
         en3K2lZqlxNNHd4X04Mt7TGMN3NhByWLhUHmk0v+Uwv5t/8/CgQ5HfJXY9gMyJS/MaUV
         6X5qYVWB/12B1R5VByVnKkbqh0ZHcUzYZ2gEaAVRxAzYtE5M2riuHzwOqF4Kct20eLpY
         sZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=E6sx1WJdBk2a7G3dorPJ2CmHjvewuP1hAm3CRay7bUw=;
        b=pSqAY4VOq2hF+kHe0go27Tuep8BuHw9BbN5isa5OTf2vwT1l0idagj/pAvhvZ2krSI
         CiPrd7V/9VjSNgJJLDaqscJlvJXS6M9PBAdBkohiQ93IjBTG6O0bci42zjq+hAXTJm1B
         87CdCDUR7ONRS79AFMMx3edb3BkI4lVBDjaf5kuh8K4BY4L+SF3Ol1JUdYX/aq+Q4kuG
         tuFCFx74GVDQnWtUZJ12+Xoz5UxSD8P0MCYwbkxzR6fxaJAYwP5FGRBL7qvGXaTWJHPk
         0K60D20CFuHUQKojeSP7btJa+wbDwq5UHfCzh1wEhLeXfOJehKyD4nUmd6w9u8w6oL2u
         1Usg==
X-Gm-Message-State: AOAM5329x/zG55bClr5jB2jlwwPCuJ3AsVjcwyB1GsCU5CbP5zMQpfBN
        62d7AbVUfX5cjVzPC5eD/iNt/MkAvjgDqQ==
X-Google-Smtp-Source: ABdhPJxVLQlnSpfaXNiuYKiMeBW53NTabOudnf4B0X1S2onFq9G18fkw25diYz5ag5rRTZTfrfyVTg==
X-Received: by 2002:a62:b403:0:b029:20c:cbd5:5be1 with SMTP id h3-20020a62b4030000b029020ccbd55be1mr20360665pfn.53.1618134014181;
        Sun, 11 Apr 2021 02:40:14 -0700 (PDT)
Received: from atharva-on-air.dlink ([180.151.104.48])
        by smtp.gmail.com with ESMTPSA id a30sm6896770pfr.66.2021.04.11.02.40.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Apr 2021 02:40:13 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [GSoC][Draft Proposal v2] Finish converting git submodule to
 builtin
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <CAP8UFD2hhtpnz+WE2J9iLbzfRJ2k5EOtUMRW=QcH9xe1U6y69g@mail.gmail.com>
Date:   Sun, 11 Apr 2021 15:10:10 +0530
Cc:     git <git@vger.kernel.org>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F6B9AC67-EB44-4FD9-A7A0-A6494BAE3BC7@gmail.com>
References: <E6E88000-9C18-4035-9A14-8B406617351A@gmail.com>
 <F3446051-620F-4C7B-A306-5C36922A976C@gmail.com>
 <CAP8UFD2hhtpnz+WE2J9iLbzfRJ2k5EOtUMRW=QcH9xe1U6y69g@mail.gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On 10-Apr-2021, at 18:29, Christian Couder =
<christian.couder@gmail.com> wrote:
>=20
> On Thu, Apr 8, 2021 at 12:19 PM Atharva Raykar <raykar.ath@gmail.com> =
wrote:
>>=20
>> Here's my updated draft. Changes since v1:
>>=20
>> - Elaborated more on example porting strategy, stating how the =
patches
>>   could be broken up.
>> - Made language at the end of section 6 less ambiguous.
>> - Updated status of microproject.
>> - s/git/Git in several places.
>=20
> Thanks for this summary of the changes since the previous version!
>=20
>> 3 Me and Git
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>>  Here are the various forms of contributions that I have made to Git:
>>=20
>>  - [Microproject] userdiff: userdiff: add support for Scheme Status: =
In
>=20
> s/userdiff: userdiff/userdiff/
>=20
>>    progress, patch v3 requiring a review List:
>>    =
<https://lore.kernel.org/git/20210408091442.22740-1-raykar.ath@gmail.com/>=

>>=20
>>  - [Git Education] Conducted a workshop with attendance of hundreds =
of
>>    students new to git, and increased the prevalence of of git's =
usage
>=20
> s/git/Git/
> s/of of git/of Git/
>=20

Thanks, will fix these.

>>    in my campus.
>>    Photos: <https://photos.app.goo.gl/T7CPk1zkHdK7mx6v7> and
>>    <https://photos.app.goo.gl/bzTgdHMttxDen6z9A>
>=20
> [...]
>=20
>> 6 General implementation strategy
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>>  The way to port the shell to C code for `submodule' will largely
>>  remain the same. There already exists the builtin
>>  `submodule--helper.c' which contains most of the previous commands'
>>  ports. All that the shell script for `git-submodule.sh' is doing for
>>  the previously completed ports is parsing the flags and then calling
>>  the helper, which does all the business logic.
>>=20
>>  So I will be moving out all the business logic that the shell script
>>  is performing to `submodule--helper.c'. Any reusable functionality
>>  that is introduced during the port will be added to `submodule.c' in
>>  the top level.
>>=20
>>      For example: The general strategy for converting `cmd_update()' =
would
>>      be to have a call to `submodule--helper' in the shell script to =
a
>>      function which would resemble something like `module_update()'.
>=20
> Does module_update() already exists? It's hard to understand if you
> are referring to something that already exists (where?) or that you
> would create (how?) here. More details about this would be nice.

It is a function that I intend to write, will make that more clear.

>> This
>>      would perform the work being done by the shell script past the =
flags
>>      being parsed and make the necessary call to `update_clone()', =
which
>>      returns information about the cloned modules.
>=20
> How does it return information?
>=20
>> For each cloned module,
>>      it will find out the update mode through `module_update_mode()', =
and
>>      run the appropriate operation according to that mode (like a =
rebase,
>>      if that was the update mode).
>>=20
>>      One possible way this work can be broken up into multiple =
patches, is
>>      by moving over the shell code into C in a bottom-up manner.
>>      For example: The shell part which retrieves the latest revision =
in the
>>      remote (if --remote is specified) can be wrapped into a command =
of
>>      `submodule--helper.c'.
>=20
> Could you give an example of how the command would be named, what
> arguments it would take and how it could be used?
>=20
>> Then we can move the part where we run the
>>      update method (ie the `case' on line 611 onwards) into a C =
function.
>=20
> Do you mean the code that does something like:
>=20
>                       case "$update_module" in
>                       checkout)
>                               ...
>                       rebase)
>                               ...
>                       merge)
>                               ...
>                       !*)
>                               ...
>                       *)
>                               ...
>                       esac
>=20
>                       if (sanitize_submodule_env; cd "$sm_path" &&
> $command "$sha1")
>                       then
>                               say "$say_msg"
>                       elif test -n "$must_die_on_failure"
>                       then
>                               die_with_status 2 "$die_msg"
>                       else
>                               err=3D"${err};$die_msg"
>                               continue
>                       fi
>=20
> ?
>=20
> Could you also give an example of how the command would be named, what
> arguments it would take and how it could be used?

I could add more detail about the exact arguments each converted part
would take, but I feel a little hesitant because I will most likely
change my mind on a lot of those kind of lower-level decisions as I
understand the codebase better. The point I was trying to convey is
that the high-level workflow I would follow while converting would look
like this:

1. Identify parts in git-submodule.sh that have cohesive functionality
2. Rewrite that functionality in C, which can be invoked from
    `git submodule--helper <function name> <args>`
3. Remove the shell code and replace it with the above invocation
4. Once the shell code is reduced to only a bunch of calls to
    submodule--helper, wrap all of that into one call that looks like
    `git submodule--helper update <flags>` that encapsulates all the
    functionality done by the other helper function calls.

(In other words: I will cluster the functionality in a bottom-up way.
Maybe I should mention the above four points in my proposal?)

The example I gave for how to handle the presence of the remote flag
and the function that performs the module updation method (ie, the =
`case`
on line 611) was just to illustrate the above workflow, rather than say
that this is how I will exactly do it.

I also would like to know what level of granularity is ideal for the
proposal. For now I have tried to keep it at "whatever I will surely
follow through when I work on the project", which at the moment is the
covered by the four points I mentioned above.

If I go too much into detail about the functions and arguments
of every helper in my example, I will feel compelled to do the same for
the `git submodule add` example. I also will have to reason more =
carefully
because I do not want to end up in a situation where I do not actually
stick to my proposal all that much, because I realise in my =
investigation
phase that there is a different, much better way.

Do let me know what is preferred.

>>      Eventually, the shell part will just look like a bunch of =
invocations
>>      to `submodule--helper', at which point, the whole thing can be
>>      encapsulated in a single command called `git submodule--helper =
update'
>>      (Bonus: Move the whole functionality to C, including the parsing =
of
>>      flags, to work towards getting rid of `git-submodule.sh'). I =
believe
>>      this is a fairly non-destructive and incremental way to work, =
and the
>>      porting efforts by Stefan seem to follow this same kind of =
philosophy.
>>      I will most likely end up tuning the size of these increments =
when I
>>      get around to planning in my first phase of the project.
>>=20
>>  After this process, I will be adding the `add' and `update' command =
to
>>  the commands array in `submodule--helper.c'. And since these two
>>  functions are the last bit of functionality left to convert in
>>  submodules, an extended goal can be to get rid of the shell script
>>  altogether, and make the helper into the actual builtin [1].
>>=20
>>  [1]
>>  =
<https://lore.kernel.org/git/nycvar.QRO.7.76.6.2011191327320.56@tvgsbejvaq=
bjf.bet/>

