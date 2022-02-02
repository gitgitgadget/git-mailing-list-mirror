Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F9CC433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 11:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240863AbiBBLS2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 06:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbiBBLS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 06:18:27 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70308C061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 03:18:27 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id w25so40346918edt.7
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 03:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=pHD33WVmsNFbTlr/9QZ3sNBaOH/p+E6WNh/N9vMCPOA=;
        b=dU22v9nW4lglrLHYH0fcHs14FHgxlkU02m576+/r2hvGAC/h2b8dXAHQfJgPiiB0y+
         fzLgkjT4HumpHSBKW7bjNa1/zdX9NkRSu4ATWavk2Fkz4Z3bFLVzCTyCF+oZ84W4Etw8
         WUwR6UQ/+RsoweCNZtanm9rrNqFxutCV/eYEQT3FXNPXaTTsf+tdpmc7AwFggzuzrPvm
         WlVLVDg2HyBg85LFax7AOeczAgMuUhmgJ6BHhfqzwgGdm05TV7V1KWjt5fQH0lyVKtsL
         9OCPCBCyXptPMTZ/NmqLxUcuDo5KTy3R4ZtgISNUGr09bVnmQsOJQs/A1E+/IuDre71A
         +Y0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=pHD33WVmsNFbTlr/9QZ3sNBaOH/p+E6WNh/N9vMCPOA=;
        b=12Rz65CG9TeiML9BdbcTDOx1e0tGYsQQXzjIBz+LXb7GITk6r8raiNT/9qDHMb+Rdc
         A/+3DVmEZg0/yMvc9Av8UadFNl4xgES5TA0AfbJlILUZIt/l9zYL5pvEBv1mvGP/7w94
         MRRKIwHxM9YBvziKBQWw1MVtLzxv1pGKrAbL6kHtQvV4FnFkx8kTTI8FxU+H5Vy8LICB
         LItN7lCfw3eVU/TNsFmcPyabH0DYxJT/pu61V7NKp88++pCMQv5QAGf6Ob9qAKuh2hmL
         TUtF+2ub9+HdQLGDJnUEyXekDu3p8PtJIfFp+MGZaYTetzG+U4SwnLrhqZUNOGKIETJR
         M74g==
X-Gm-Message-State: AOAM531jXobcUm7/Mz1Lf6pCSFDDztl1hmKcGYrbQ0oqonSh3y5LsU3Y
        yWPzpNjAyvjbsHi7jcQTyGERi6Df7wc/cA==
X-Google-Smtp-Source: ABdhPJzHPMWR8A2E43ppHRFAjqmHC5Fm5oF2nb/9spUt3JnX/Y8bfZIpdEnK4jY6B8fR0+rYKIlpEg==
X-Received: by 2002:a50:d907:: with SMTP id t7mr30176646edj.59.1643800705612;
        Wed, 02 Feb 2022 03:18:25 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id lm6sm15489035ejb.46.2022.02.02.03.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 03:18:25 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFDea-004WR4-Ks;
        Wed, 02 Feb 2022 12:18:24 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>,
        Johannes Altmanninger <aclopte@gmail.com>
Subject: Re: [PATCH v4 02/10] log: clean unneeded objects during `log
 --remerge-diff`
Date:   Wed, 02 Feb 2022 12:17:30 +0100
References: <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com>
 <pull.1103.v4.git.1642792341.gitgitgadget@gmail.com>
 <f06de6c1b2fbd5c5a23b6755197a3683c7d18d2f.1642792341.git.gitgitgadget@gmail.com>
 <220201.86v8xyapj9.gmgdl@evledraar.gmail.com>
 <CABPp-BHPZZuGoJO8PXCngBhStBJmDhbyCYOmR+CVZX5wv3O+4w@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CABPp-BHPZZuGoJO8PXCngBhStBJmDhbyCYOmR+CVZX5wv3O+4w@mail.gmail.com>
Message-ID: <220202.868rut8qkf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 01 2022, Elijah Newren wrote:

> On Tue, Feb 1, 2022 at 1:45 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>>
>> On Fri, Jan 21 2022, Elijah Newren via GitGitGadget wrote:
>>
>> > From: Elijah Newren <newren@gmail.com>
>> > [...]
>> > @@ -944,7 +945,12 @@ static int do_remerge_diff(struct rev_info *opt,
>> >       strbuf_release(&parent1_desc);
>> >       strbuf_release(&parent2_desc);
>> >       merge_finalize(&o, &res);
>> > -     /* TODO: clean up the temporary object directory */
>> > +
>> > +     /* Clean up the contents of the temporary object directory */
>> > +     if (opt->remerge_objdir)
>> > +             tmp_objdir_discard_objects(opt->remerge_objdir);
>> > +     else
>> > +             BUG("unable to remove temporary object directory");
>>
>> Re the die in 1/10 I don't think this will ever trigger the way this bug
>> suggests.
>>
>> If we didn't manage to remove the directory that'll be signalled with
>> the return code of tmp_objdir_discard_objects() which you're adding
>> here, but which doesn't have a meaningful return value.
>>
>> So shouldn't it first of all be returning the "int" like the
>> remove_dir_recursively() user in tmp_objdir_destroy_1() makes use of?
>>
>> What this bug is really about is:
>>
>>     BUG("our juggling of opt->remerge_objdir between here and builtin/lo=
g.c is screwy")
>>
>> Or something, because if we failed to remove the director(ies) we'll
>> just ignore that here.
>
> Yeah, I think I'm suffering from leftover bits from earlier versions
> since this patch series has been waiting for 17 months now.  I
> switched it to
>
>     BUG("did a remerge diff without remerge_objdir?!?");

Thanks :)

>>
>> > +void tmp_objdir_discard_objects(struct tmp_objdir *t)
>> > +{
>> > +     remove_dir_recursively(&t->path, REMOVE_DIR_KEEP_TOPLEVEL);
>> > +}
>>
>> I skimmed remove_dir_recurse() a bit, but didn't test this, does this
>> remove just the "de/eadbeef..." in "de/eadbeef..." or also "de/",
>> i.e. do we (and do we want) to keep the fanned-out 256 loose top-level
>> directories throughout the operation?
>
> It will remove everything below t->path, but leave t->path.  As such,
> it'll nuke any of the 256 loose top-level directories that exist.
>
> If someone wants to come along later and measure performance and
> determine if leaving those 256 loose top-level directories around
> improves things, I think that's fine, but I'm not going to look at it
> as part of this series.  I'm more curious about where tmp_objdir
> creates the temporary directory; when the intent is to migrate the
> objects into the main directory, it should probably be created on the
> same filesystem.  When the intent is scratch space, like it is for
> --remerge-diff, the tmp_objdir should probably be shoved in /dev/shm
> or something like that.  But again, that's outside of this series.
> This series already has had a long list of things keeping it from the
> light of day; there's no need to add frills to it as part of the
> initial submission.

Sorry to add to the frustration. I really didn't mean that as a
suggestion for a thing to be addressed, I think this is way past good
enough. It was just something I found curious, didn't quite know how it
worked, and thought I'd ask if you knew offhand. Thanks!
