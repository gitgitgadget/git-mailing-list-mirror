Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2133C433EF
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 14:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354634AbhKYOEC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 09:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355551AbhKYOCB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 09:02:01 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A000C0613DD
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 05:56:04 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id y13so25898910edd.13
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 05:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=/rtrt/akRBIlpO1C3iIJAjo/ftO6RsBUkxFOTeG53GM=;
        b=hPPPZOlPhFYoHgLTnxjbv+wqgLm0AbpXW35qXlyoCv1WdvKMqoBheX0OmP9b/PjaDo
         GJguE9fOmZ6pcgvB0WQiqGm/skAwci5fUJh9DVHfFa9Lf59EPVLaTxkrZiZCSycRQu6F
         xI8YGx0Dp5OGOMPdNbSepyzeE5bB5TeIzUsWoXutAeeD6056WraY5ATfZfqzHRMq3IVa
         iS5Qj8AU08AhWOlWn+FiOIgRnR91wFRg01RXyMJtqUO7pEDkVCQlsfFrQLarCzetf9Jf
         6K2Zh2XlDSAdJrPTk6bB1v6Xonj0Xb91Xj0glR4GRi5IZjI/Cvzd2WZSXSSAD4Nxze/k
         wt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=/rtrt/akRBIlpO1C3iIJAjo/ftO6RsBUkxFOTeG53GM=;
        b=DYPwkiOfpZtRro7dGen8IMDelMSmqtO8dvchyezkUWK+izTYzZMk2lQ7+Q/VXo2qOb
         z+sGw+MwtIdh2r/EILhHDBqP+YQozXJTentJkDRfTNZuHWR8ZC1cI6unCurGswL7DNi8
         ihaXV4qGLW3MErrIs1URLo1zf4qqi392XOLjz3nkTIUJZ5vqANselwYoYkvmhBYpz22b
         W3PdSSDa+5LBHYZUc5aTDgbkmTN3N+Fhui3s6w1LKCf8MvTmt7ubEKjTX1v0puhocRUt
         5dtcrDL824/Wmzh62ZLzTNvvq8NpgZI4YUG9AEKhCiWn27BKx4gdppbw6NGKDEhy+a0F
         0IuA==
X-Gm-Message-State: AOAM5300vJVVGHUYCoJPWKKSl3naiqCM48cOqpAVdCugPlan7Sy+w3Dp
        D70NhZUKJ/cCn4QgA6b7IzI=
X-Google-Smtp-Source: ABdhPJxkGOc2K2qZGMLQ4IaRh1jXzZlWQkvLmT2TQl34/W33GqHZ4nipy5f9Mx3aPI5yt/3RO0ce6A==
X-Received: by 2002:a17:907:869e:: with SMTP id qa30mr30100286ejc.356.1637848562405;
        Thu, 25 Nov 2021 05:56:02 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id qa7sm1644625ejc.64.2021.11.25.05.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 05:56:01 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mqFEG-0008ue-Pw;
        Thu, 25 Nov 2021 14:56:00 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 8/8] dir: avoid removing the current working directory
Date:   Thu, 25 Nov 2021 14:51:55 +0100
References: <a5528cbb14ddbbf26cde873e3f3e95744d59b950.1637455620.git.gitgitgadget@gmail.com>
 <20211123003958.3978-1-chooglen@google.com>
 <CABPp-BE0Bcimwr1wwcnnh+6apx7r114Oqnu=QDgKEn6VAHAtFg@mail.gmail.com>
 <kl6lmtluka55.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CABPp-BGr9PDTE0q5zev4Ffx19g+hG083zdNShoSdH47VqzT8mw@mail.gmail.com>
 <211124.86ee76e4fl.gmgdl@evledraar.gmail.com>
 <CABPp-BGZPheDqWD1pXbePOYe2BcT1-TqX-zGVqnNLGtFuXab1g@mail.gmail.com>
 <211124.86wnkxdbza.gmgdl@evledraar.gmail.com>
 <bf9b547d-f421-49f7-9dc5-cc1f81187127@iee.email>
 <xmqqk0gx1gmz.fsf@gitster.g>
 <f63ed861-1109-d892-597e-25949b08b8cf@iee.email>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <f63ed861-1109-d892-597e-25949b08b8cf@iee.email>
Message-ID: <211125.86lf1cibkf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 25 2021, Philip Oakley wrote:

> On 24/11/2021 19:46, Junio C Hamano wrote:
>> Philip Oakley <philipoakley@iee.email> writes:
>>
>>> On 24/11/2021 11:14, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>> I'm not concerned that you didn't research this change well enough, I
>>>> just find it a bit iffy to introduce semantics in git around FS
>>>> operations that don't conform with that of POSIX & the underlying OS. =
My
>>>> *nix system happily accepts an "rm -rf" or an "rmdir" of the directory
>>>> I'm in, I'd expect git to do the same.
>>> Isn't this the same, conceptually, as trying to remove the root
>>> directory, but from a Git perspective?
>>>
>>> i.e. Something along the lines of
>>> https://superuser.com/questions/542978/is-it-possible-to-remove-the-roo=
t-directory
>>> (their answer is 'no' without a special option, default since 2006)
>>>
>>> If I read the arguments correctly, Elijah is saying that Git shouldn't
>>> delete it's own root (cwd) directory, and that it is already implicit
>>> within the current Git code.
>> I do not think it is about protecting "root"; the series wants
>>
>>     cd t/ && git rm -r ../t
>>
>> to leave an empty directory at 't/', because "git rm" was started in
>> that directory.
> My point was about where the conceptual 'root' (for Git and it's rm
> command) was deemed to be.

Makes sense, but nothing being discussed here has to do with crossing
repository boundaries so far.

> For instance, can/should we be able to elevate ourselves into a super
> project for the deletion? I did notice that a regular `cd / && cd
> ../../` will happily recycle itself at `/`, rather than bugging out.

This behavior explicitly standardized in POSIX:
https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap04.html:

    The special filename dot shall refer to the directory
    specified byits predecessor. The special filename dot-dot
    shall refer to the parent directory of its predecessor
    directory. As a special case, in the root directory, dot-dot
    may refer to the root directory itself.c

The same goes for "foo", "./foo", "./././././foo" etc.

> Whichever way is decided (cwd, GIT_WORK_TREE, or higher), ensuring that
> the documentation is plain and clear , and not just the code, is
> important for future readers, to help avoid future confusions.

Yes, offhand I don't know where we canonically document our behavior of
not crossing repo boundaries, or rather not going "up".
