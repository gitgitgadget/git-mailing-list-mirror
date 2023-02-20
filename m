Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9395C636D6
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 20:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjBTUxP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 15:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjBTUxO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 15:53:14 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03065869D
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 12:53:12 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id d7so2774620qtr.12
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 12:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1676926391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvKn/TFu28oRzWyr/ykMYNbhUTunv/8qlx68xCkvdiM=;
        b=AblxGzoTWCBDS1ER2SVIEFGUSFUKt6IWf4mox4Ay4FoT2kywNZVshY9tKd77ve+dUk
         UndO1j0O/DGCkGlKLJj6/f2JDsBd5jD1hF3+RF4ER44aYF34LkBqgyBQLBdUdLZfZnF4
         5V7zJB6ADYUBkrsfkJbjdlQ1hAazcjyEsJWm9dZe0f7UiRexypjkz0+abTFP3s05u7OJ
         D/Ww1ONJBDtQbBjq5SX6lxoybW6t/MFxULsfrJz7iQJq5XLr51hGQ1ErFNKsSGoaZN4L
         pTwbM/RCC2mgpvSeaeWKOR9JOEWqWvfJYmrOO7MnoI+IngVP+5gEOnFWJWeVm4C5pnAg
         3UPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676926391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yvKn/TFu28oRzWyr/ykMYNbhUTunv/8qlx68xCkvdiM=;
        b=5jmR8t25GPJujUbXRBYIHmf7I2S+dRXrgiu/sXFjBSC15bJZKuST6lK78chw8EL4gU
         1zmTRePVaGgMu0vl9mOkNBJAjcZwWgXyx3qRNgL+I5V1yhvb5G6b1dEtncf5pQ9i2gcT
         vpyEQE3fFtZ7jUk9znSwcYQ6hur4OmXr+9CVSx/1IxX3jJhf/6utoy0TiePsO31LIXfz
         UHqTuVppzZcaOe6yAXuAjKl14ka9649r6PEh/LypgaxRDvTFcl46VH+e2VvxR/exCzDQ
         PQ8jrmRoSeS69FSPjq+A81rgrm5LeF6A7PV1wdwEE9aYf7JvRCa+VNHveYp6lTqnCgpv
         FhAA==
X-Gm-Message-State: AO0yUKV4384neQkGaUMl9S2sVsmCDfbwIyeHn9gPxemcZ2JvFQF5UNoI
        UxCqWFjDaZXJIg/oX4fkk/U=
X-Google-Smtp-Source: AK7set9FuRCSVV+MVEzdQoENYPodXFSnsGbiNHU9gOqMSdfcNMSYh3LcdhOWQ60weW5niCuxQsNXqg==
X-Received: by 2002:ac8:5995:0:b0:3bd:1c0f:74f3 with SMTP id e21-20020ac85995000000b003bd1c0f74f3mr3964513qte.2.1676926390963;
        Mon, 20 Feb 2023 12:53:10 -0800 (PST)
Received: from [192.168.1.211] ([2600:4041:4542:c100:8905:dad0:53aa:3ab7])
        by smtp.gmail.com with ESMTPSA id z79-20020a376552000000b0073b7568d998sm9616572qkb.2.2023.02.20.12.53.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Feb 2023 12:53:10 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/2] diff: teach diff to read algorithm from diff driver
Date:   Mon, 20 Feb 2023 15:53:09 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <647D3D49-B85B-4B66-A857-695CFF9685EE@gmail.com>
In-Reply-To: <CABPp-BHQn0sjAMwJ+r6uenO=nGLG1HvfnhS6tG8mu1BWt4bdOw@mail.gmail.com>
References: <pull.1452.v2.git.git.1676410819.gitgitgadget@gmail.com>
 <pull.1452.v3.git.git.1676665285.gitgitgadget@gmail.com>
 <b330222ce83bdf03c20085ff10fcff8a090474d5.1676665285.git.gitgitgadget@gmail.com>
 <CABPp-BFCMpA=nHtb5RuQL7ACbkhSEKtvmRxKwMuktcf24uQJtQ@mail.gmail.com>
 <EE7565DF-BE70-4C45-AF0B-95C85050DFA4@gmail.com>
 <CABPp-BGDi1VQXFdGw_Y8i0ZDBOoHJe9039fh4mO44qJ-nJE1ig@mail.gmail.com>
 <47981D9E-9DC7-4C23-911D-13BA52A27040@gmail.com>
 <CABPp-BHQn0sjAMwJ+r6uenO=nGLG1HvfnhS6tG8mu1BWt4bdOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On 20 Feb 2023, at 12:32, Elijah Newren wrote:

> On Mon, Feb 20, 2023 at 8:49 AM John Cai <johncai86@gmail.com> wrote:
>>
>> Hi Elijah,
>>
>> On 20 Feb 2023, at 11:21, Elijah Newren wrote:
>>
>>> On Mon, Feb 20, 2023 at 7:32 AM John Cai <johncai86@gmail.com> wrote:=

>>> [...]
>>>>> I'm still curious if this should this also include warnings/caveats=
, such as:
>>>>>   * The diff attribute specified in .gitattributes will be ignored =
in
>>>>> a bare clone
>>>>>   * The diff attribute specified in .gitattributes will be ignored =
if
>>>>> it is only specified in another branch (e.g. on a branch "special-f=
ile
>>>>> diff=3Dpatience" recorded in .gitattributes, then checkout master b=
ut
>>>>> run `git log -1 -p $branch`)
>>>>>   * When a file is renamed, the diff attribute for the pre-image na=
me
>>>>> is the only one the system pays attention to (thus adding "-R" can
>>>>> flip which diff algorithm is run for the renamed file).
>>>>
>>>> I would be fine with adding that--though originally I was thinking t=
hat these
>>>> can be inferred from the way that gitattributes are documented in [1=
]. Calling
>>>> these out would make it more clear though, so I could go either way.=

>>>>
>>>>>
>>>>> Also, since I tested the three items above to verify they are valid=

>>>>> warnings, I'm a bit confused.  I thought your intent was to use thi=
s
>>>>> server-side[1], so isn't the bare clone aspect a deal-breaker for y=
our
>>>>> intended usecase?
>>>>>
>>>>> [1] https://lore.kernel.org/git/7852AC7B-7A4E-4DD0-ADEA-CFFD5D16C59=
5@gmail.com/
>>>>
>>>> yes, indeed. I was planning on adding bare repository support in a s=
eparate
>>>> patch series, since the additions in [2] allows .gitattributes to be=
 read from a
>>>> bare repository.
>>>>
>>>> 1. https://git-scm.com/docs/gitattributes
>>>> 2. https://lore.kernel.org/git/0ca8b2458921fc40269b0c43b5ec86eba77d6=
b54.1673684790.git.karthik.188@gmail.com/
>>>>
>>>> thanks!
>>>> John
>>>
>>> Oh, interesting, I didn't know about [2].  So, is the plan to take th=
e
>>> --source option from that series and add it to diff (perhaps with a
>>> different name, since log tends to consume diff options and --source
>>> is already taken)?
>>
>> Yep, that would be the general idea
>>
>>>
>>> And do you expect to get the tree-ish from the two the users are
>>> already specifying to diff?  If so, which one do you use (the two
>>> commits being diffed might have differing .gitattributes files)?  If
>>> not, what does that mean for users of e.g. the GitLab UI who have to
>>> specify a third tree when diffing?
>>
>> Good question! Since it seems that when `git-diff(1)` considers diff.<=
driver>,
>> it goes with the path of the first one. (might need some confirmation =
here)
>>
>> in diff.c:
>>
>>
>> static void run_diff(struct diff_filepair *p, struct diff_options *o)
>> {
>>         const char *pgm =3D external_diff();
>>         struct strbuf msg;
>>         struct diff_filespec *one =3D p->one;
>>         struct diff_filespec *two =3D p->two;
>>         const char *name;
>>         const char *other;
>>         const char *attr_path;
>>
>>         name  =3D one->path;
>>         other =3D (strcmp(name, two->path) ? two->path : NULL);
>>         attr_path =3D name;
>>         if (o->prefix_length)
>>
>> I was thinking we would just use the tree-ish of the first one
>
> That would certainly simplify, but it'd be pretty important to
> document.  (Incidentally, this kind of decision was my reason for
> asking about all those special cases earlier, i.e. how to handle diff
> between different commits, how to handle renames, how to handle bare
> repositories, etc.)

Good point--that would be good to document.

>
> This kind of decision probably also means you'd need a variety of
> testcases where .gitattributes is different in every commit & the
> index & the working tree, and then you start testing several of the
> possible pairings to make sure the right .gitattributes file is used
> (e.g. (commit, commit), (commit, index), (index, commit), (worktree,
> index), etc.)
>
> However, I'm curious again.  You brought this up because you want to
> use it in GitLab, yet configuration of using this option as it appears
> in this series requires changing _both_ .gitattributes and
> .git/config.  How will users of the GitLab UI do the configuration
> necessary for the git-config side to take effect?

Good question--we would likely need to add some pre-baked configuration s=
erver
side with a driver config that users could then tap into with their
gitattributes files.
