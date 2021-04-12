Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44DBC433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 05:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC0C361209
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 05:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhDLF4g (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 01:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhDLF4e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 01:56:34 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A436C061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 22:56:17 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id em21-20020a17090b0155b029014e204a81e6so1404738pjb.1
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 22:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PNfXs6ImOLsF1FiSX/Cgb5kiAw2nV+AoNwvUXBQ/HWo=;
        b=sJT0Ze33yhA8JQDg/ojyqp4jOLCGJzLa4GyI52AdxUwWOyEeQ1tQgZRbEXcbX1Gng8
         0YkXlp+fJvJk0GLSQVDkL+QkT7YONgs7D2LK1IT3S/qw8t3aMmNMMfgc47IL/1BmU/a1
         RKn3Qr0cDxoQoGzo0ZtvxfR3QH1+RNAq6eCBxn3ad2kDRjuyJZmVgBq9vk9LW80jbIe2
         IeqKQHTfOULWFA65ngEiQ9HsRu6s+q9La8y5IAEYvKpgHAznzxP716K+FLqShgnQHveo
         vij/mQsHVE47pNoxScRwJ4QN1WdyekBHzVGCiqXwk8s6KvxCHO/fTTmyKtp6x2Kko9Ih
         Gs4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PNfXs6ImOLsF1FiSX/Cgb5kiAw2nV+AoNwvUXBQ/HWo=;
        b=qqQJep/3T03WeOuCIReNoRL4eSyaqE9x8OcvqBcNwSMF7fF072n4WGxsJDtOe1dCR0
         2bV6yP8S1V5w4bk/DuR5fhCQgqYCtKLceC8pA8CMX3MOR5u0SMXc+2/fUJCxyngOQaul
         YJUQPYsR5AXu0N7x2zj10qru2pRX0gS7+7VLJ92smjg00S8e02xNjB2wiRi2N854EGyF
         2lEdMWs9F1bAD445REKKkgHrTrQwVyU0eZGCmX8HGLOZAnpwn40gg6lmP+ZXmMiDe6zk
         myU8eC2hkYo05v7gc6xdJ90WKZe5WAtrWE/eSRTvnGsYcWLnCle0fOD41MZTf5dsivRZ
         U8oA==
X-Gm-Message-State: AOAM5332XglhXeroA+RyT1U8ARv201wycc/jg62b6cRJTBhL3GadBopk
        HkvK4HU+MtwsrV+FtA3uIbQ=
X-Google-Smtp-Source: ABdhPJwHorocCjIEA0GVF3qinG6L2wW0wu7BqRW5kgWkCDkFWY7xSeXCf/z7lN7FeZ05x7F7WKkFPw==
X-Received: by 2002:a17:902:f291:b029:eb:736:95d8 with SMTP id k17-20020a170902f291b02900eb073695d8mr1457263plc.41.1618206976881;
        Sun, 11 Apr 2021 22:56:16 -0700 (PDT)
Received: from atharva-on-air.dlink ([180.151.104.48])
        by smtp.gmail.com with ESMTPSA id o18sm9570674pji.10.2021.04.11.22.56.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Apr 2021 22:56:16 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [GSoC][Draft Proposal v2] Finish converting git submodule to
 builtin
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <f721d35c-72fe-fe18-edfc-8745966e41af@gmail.com>
Date:   Mon, 12 Apr 2021 11:26:13 +0530
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5E858DC0-E642-4E0D-BDCD-40F62198DE11@gmail.com>
References: <E6E88000-9C18-4035-9A14-8B406617351A@gmail.com>
 <F3446051-620F-4C7B-A306-5C36922A976C@gmail.com>
 <CAP8UFD2hhtpnz+WE2J9iLbzfRJ2k5EOtUMRW=QcH9xe1U6y69g@mail.gmail.com>
 <F6B9AC67-EB44-4FD9-A7A0-A6494BAE3BC7@gmail.com>
 <f721d35c-72fe-fe18-edfc-8745966e41af@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12-Apr-2021, at 01:02, Kaartic Sivaraam <kaartic.sivaraam@gmail.com> =
wrote:
>=20
> Hi Atharva,
>=20
> On 11/04/21 3:10 pm, Atharva Raykar wrote:
>=20
>>> On 10-Apr-2021, at 18:29, Christian Couder =
<christian.couder@gmail.com> wrote:
>>>=20
>>> On Thu, Apr 8, 2021 at 12:19 PM Atharva Raykar =
<raykar.ath@gmail.com> wrote:
>>>>=20
>>>> Here's my updated draft. Changes since v1:
>>>>=20
>>>> - Elaborated more on example porting strategy, stating how the =
patches
>>>>   could be broken up.
>>>> - Made language at the end of section 6 less ambiguous.
>>>> - Updated status of microproject.
>>>> - s/git/Git in several places.
>>>=20
>>> Thanks for this summary of the changes since the previous version!
>>>=20
>=20
> Yeah. Summaries are really helpful :)
>=20
> [ ... ]
>=20
>>>> This
>>>>      would perform the work being done by the shell script past the =
flags
>>>>      being parsed and make the necessary call to `update_clone()', =
which
>>>>      returns information about the cloned modules.
>>>=20
>>> How does it return information?
>>>=20
>>>> For each cloned module,
>>>>      it will find out the update mode through =
`module_update_mode()', and
>>>>      run the appropriate operation according to that mode (like a =
rebase,
>>>>      if that was the update mode).
>>>>=20
>>>>      One possible way this work can be broken up into multiple =
patches, is
>>>>      by moving over the shell code into C in a bottom-up manner.
>>>>      For example: The shell part which retrieves the latest =
revision in the
>>>>      remote (if --remote is specified) can be wrapped into a =
command of
>>>>      `submodule--helper.c'.
>>>=20
>>> Could you give an example of how the command would be named, what
>>> arguments it would take and how it could be used?
>>>=20
>>>> Then we can move the part where we run the
>>>>      update method (ie the `case' on line 611 onwards) into a C =
function.
>>>=20
>>> Do you mean the code that does something like:
>>>=20
>>>                       case "$update_module" in
>>>                       checkout)
>>>                               ...
>>>                       rebase)
>>>                               ...
>>>                       merge)
>>>                               ...
>>>                       !*)
>>>                               ...
>>>                       *)
>>>                               ...
>>>                       esac
>>>=20
>>>                       if (sanitize_submodule_env; cd "$sm_path" &&
>>> $command "$sha1")
>>>                       then
>>>                               say "$say_msg"
>>>                       elif test -n "$must_die_on_failure"
>>>                       then
>>>                               die_with_status 2 "$die_msg"
>>>                       else
>>>                               err=3D"${err};$die_msg"
>>>                               continue
>>>                       fi
>>>=20
>>> ?
>>>=20
>>> Could you also give an example of how the command would be named, =
what
>>> arguments it would take and how it could be used?
>> I could add more detail about the exact arguments each converted part
>> would take, but I feel a little hesitant because I will most likely
>> change my mind on a lot of those kind of lower-level decisions as I
>> understand the codebase better. The point I was trying to convey is
>> that the high-level workflow I would follow while converting would =
look
>> like this:
>> 1. Identify parts in git-submodule.sh that have cohesive =
functionality
>> 2. Rewrite that functionality in C, which can be invoked from
>>     `git submodule--helper <function name> <args>`
>> 3. Remove the shell code and replace it with the above invocation
>> 4. Once the shell code is reduced to only a bunch of calls to
>>     submodule--helper, wrap all of that into one call that looks like
>>     `git submodule--helper update <flags>` that encapsulates all the
>>     functionality done by the other helper function calls.
>> (In other words: I will cluster the functionality in a bottom-up way.
>> Maybe I should mention the above four points in my proposal?)
>=20
> That sounds like a good idea which wouldn't result in one huge patch =
and
> thus avoids reviewer fatigue.
>=20
>> The example I gave for how to handle the presence of the remote flag
>> and the function that performs the module updation method (ie, the =
`case`
>> on line 611) was just to illustrate the above workflow, rather than =
say
>> that this is how I will exactly do it.
>> I also would like to know what level of granularity is ideal for the
>> proposal. For now I have tried to keep it at "whatever I will surely
>> follow through when I work on the project", which at the moment is =
the
>> covered by the four points I mentioned above.
>> If I go too much into detail about the functions and arguments
>> of every helper in my example, I will feel compelled to do the same =
for
>> the `git submodule add` example. I also will have to reason more =
carefully
>> because I do not want to end up in a situation where I do not =
actually
>> stick to my proposal all that much, because I realise in my =
investigation
>> phase that there is a different, much better way.
>> Do let me know what is preferred.
>=20
> It makes sense that you don't want to go into too much detail in your
> proposal. I think Christian wasn't expecting it either. As far as I
> understand, he was just trying to make your proposal clear to the =
person
> who reads it. Just mentioning something like,
>=20
>  This would perform the work being done by the shell script past the
>  flags being parsed and make the necessary call to `update_clone()',
>  which returns information about the cloned modules.
>=20
> is not clear as it doesn't say how you're "thinking" the function =
would
> return information. Mention this would be helpful for the reader to =
know
> what your expectations are and if they need any correction. So, it is
> better to mention such related information to make your proposal
> complete. The high-level flow looks good to me.

Alright, I get what you mean. I hope my v3 communicated my intention
more clearly. Translating my thoughts to text is hard work, and the
good part of revisiting my proposal and fleshing out the details is
it is forcing me to understand the problem better :)

> Also, I believe Christian would correct me in case I got anything
> wrong :)
>=20
> --=20
> Sivaraam

