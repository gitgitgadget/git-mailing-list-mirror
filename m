Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1011AC433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 17:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D931A604DC
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 17:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbhIKRsj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 13:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhIKRsi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 13:48:38 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCEEC061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 10:47:25 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g21so7442891edw.4
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 10:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=kiL2rEXz+y13zXC/iHvJOlW3QKE4wOmLNpfhbFvQ0GA=;
        b=S+5RnzXyeYZHc1tCIQcnr3rMT6lEq6KlncoD21JMcht3yrjis8ZG4jlqzYtIseQZAS
         OXFkb6e6PSXyrxa/s1eKkpescOxjR7k0H4MCZUSimPtm8p7IN3UAmTP9AZ4IljzqmA3F
         Q9E5CcAduIpFp0dcxWiHr3KWwoEo3xlz2lKlyudxoGAiX8mYMduHyAnj9GnxkBRDx4Sk
         m5FlepnbGLt7wboHNBxQYEVy3WBqjICkF/MWHtfGiR38CQRbMOk8kurYzkTAA5knYDUE
         B26MqC1dbsauTxbGsJVrhG7Le5Ji1oMKw4omc5HjRi5tCdxvHSh0WEYVgw1cmyTOQIXs
         paOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=kiL2rEXz+y13zXC/iHvJOlW3QKE4wOmLNpfhbFvQ0GA=;
        b=zIXXH8nK7NtEPwlww6dL9/vrVjT6UOBy3RcI084jap/y6fzYeCv2l2EVx8/3pXmOuT
         FTfGVSBRu4g73BZ4E8iUAuCdOO87Wh+XYQB0t4IBKBGskL052VHuEFZkww4yRTNWoCHo
         S+dH4CVwnvTMElc+df6P55ZUCXcf7BIxPUYJZcZMwLaz62L4OZFP2/jdpEluCaeH6sbb
         4FZp4XhBDONIVjsNIgWQER3+4fwKPZgqZuCYdWuGTIAYIhe8tUSHEjstWow9Oo5lUhVc
         3VBJlXz0IrA4sKPRgoRagz26iqio7jjlseB54hTTBHtvNXrMeflFAV0JDMyCHNOkZcHo
         aY4A==
X-Gm-Message-State: AOAM530VA7BvLB0IavfyaC3/0Ts4PchImsekblfnUusvnZ1TGlboOtd9
        sykrT84YOLokKa2M8Fc9vt83rkU8NtYXMg==
X-Google-Smtp-Source: ABdhPJwmL+BsA4lp++8unLjjEPtJ5DWLfOSx8Pc0p5Ya0gtb11iQNkOu9FfCPN61st/4lnudi1Ohqg==
X-Received: by 2002:a05:6402:27d4:: with SMTP id c20mr4209169ede.332.1631382443721;
        Sat, 11 Sep 2021 10:47:23 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q11sm1224078edv.73.2021.09.11.10.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 10:47:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Sep 2021, #03; Fri, 10)
Date:   Sat, 11 Sep 2021 19:42:59 +0200
References: <xmqqsfycqdxi.fsf@gitster.g>
 <CABPp-BGR3dfJE7TZ+jkjDdWyeXYowmJhtoFaQ8_Abn=ZROhB5Q@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CABPp-BGR3dfJE7TZ+jkjDdWyeXYowmJhtoFaQ8_Abn=ZROhB5Q@mail.gmail.com>
Message-ID: <87k0jn80np.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Sep 11 2021, Elijah Newren wrote:

> On Fri, Sep 10, 2021 at 3:12 PM Junio C Hamano <gitster@pobox.com> wrote:
> [...]
> I just sent a reroll, since I did have some fixes from Phillip and
> some new testcases, but it fails one of the testcases I made and I saw
> another suboptimal case that I lost but would like to include.  I
> still have this labelled RFC and it's definitely not ready.
>
> I do plan to get back to it eventually, but am focusing more on other
> topics, so you may want to eject this from seen for now.
>
>> * ms/customizable-ident-expansion (2021-09-01) 1 commit
>>  - keyword expansion: make "$Id$" string configurable
>>
>>  Instead of "$Id$", user-specified string (like $FreeBSD$) can be
>>  used as an in-blob placeholder for keyword expansion.
>
> Kinda disappointing to see mis-designs from CVS not only persist but
> get extended.  Perhaps I'm just biased...

Yeah, if we were doing this today we'd say no, just use a smudge/clean
filter.

Which is effectively what this feature in git is, i.e. before we had
that we had this built in smudge/clean filter, but this pre-dates that
facility.

And yeah, the relevant projects should probably fix their build systems
to not rely on this CVS-era concept.

But since we're probably not actually talking about ripping the "$Id$"
feature out of git & telling users to use their own clean/smudge filter
or whatever for it, I don't see much harm in that existing facility
becoming configurable.

>> * js/retire-preserve-merges (2021-09-07) 11 commits
>>   (merged to 'next' on 2021-09-10 at f645ffd7a3)
>>  + sequencer: restrict scope of a formerly public function
>>  + rebase: remove a no-longer-used function
>>  + rebase: stop mentioning the -p option in comments
>>  + rebase: remove obsolete code comment
>>  + rebase: drop the internal `rebase--interactive` command
>>  + git-svn: drop support for `--preserve-merges`
>>  + rebase: drop support for `--preserve-merges`
>>  + pull: remove support for `--rebase=preserve`
>>  + tests: stop testing `git rebase --preserve-merges`
>>  + remote: warn about unhandled branch.<name>.rebase values
>>  + t5520: do not use `pull.rebase=preserve`
>>
>>  The "--preserve-merges" option of "git rebase" has been removed.
>>
>>  Will merge to 'master'.
>
> I'm not objecting, but I'm kind of surprised to see this after your
> and Dscho's previous discussion at
> https://lore.kernel.org/git/xmqqv939uis8.fsf@gitster.g/; I thought
> it'd stay in next for a while.  Was this a mistake?

Perhaps I was just really convincing in
https://lore.kernel.org/git/87fsuedl5x.fsf@evledraar.gmail.com/ ? :)
