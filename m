Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6126DC433F5
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 20:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380165AbiD2UJK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 16:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239462AbiD2UJG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 16:09:06 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF7473079
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 13:05:46 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id l9-20020a056830268900b006054381dd35so5835838otu.4
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 13:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dt7YqY0E/q1fcWy5UoQP2oZlueZyTy8QTZ7MPNCHh0Y=;
        b=gDMlZJKuqOgs6HtPNvpyrXo5rz6j9Moh7docg6zGfcJgXu8dAEMO2kZhrUmsG6JWSo
         OLEgGed8OLNRo9HWbl8ZO8HzpHdmq3l/nI1hpYuVN6cACONC39zpPObt2QV3hbhyms/c
         Cuu9TZUnjo2SZL9nMxl4Vz1Wc1F0LKdNA7owq+NSJaWVlJovLVh6haiLWZCf6ViNZj9W
         ukIT70+PU4NIL7eTutZ3a/9mvhzeGXuOJKdyiMrZVreHjldqdZlyxhxn9iNsXrywRqH7
         q1oXB6DzAspvQVeZogQWBNqdCtpk1RuAgacBj6byEURjCuZ/P9ALFe8ZqpVr5LwlTEZA
         mREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dt7YqY0E/q1fcWy5UoQP2oZlueZyTy8QTZ7MPNCHh0Y=;
        b=PnDaf7tfqGltp4K0H/guLKK5IuG7SXPR0V8k3g948LJOm83/3hsrX92in+Bpb7fv6R
         oprTF2YkOiIAhC0G9c2meWIaSX5IZi2QJPle+HDZHI9932dneBoFRbNZMiBWHiULD4O/
         sqdbFDs1OXcnvqIdjCDYOlJKGNErwAs3Gu+SOiWJkDqH95aG+TFS5ulFPQ6XGNnPSF1D
         3do8Jtid5qVQhKwDWtw5n5fvZfXHA3nMQjZInht4ZV279eloZFQmg3WaFCT3n9zozpXt
         rPRNV/xqqy+JDnMojWJg0HfTmYhHoWvnTkpLt1c+eslN49J9exdwBsGR/2oBZczBzsOP
         90bA==
X-Gm-Message-State: AOAM530n3hNmZtoun7kt3DT6jqKQXXCQqK0zDK1df/5XrhkVyi2SFl1K
        BSfqcENj99yasaWJlNQuEnTCR8Q0594=
X-Google-Smtp-Source: ABdhPJy0WYFN62PJopv32btuZVBVQehkl/9hKXFsC2axEXOw6IjClgqxTNo8U7yJpdWS7fEeB3bkog==
X-Received: by 2002:a9d:6b0e:0:b0:605:deb7:682b with SMTP id g14-20020a9d6b0e000000b00605deb7682bmr371301otp.285.1651262746010;
        Fri, 29 Apr 2022 13:05:46 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id z10-20020a4ad58a000000b0035eb4e5a6c9sm1131453oos.31.2022.04.29.13.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 13:05:45 -0700 (PDT)
Date:   Fri, 29 Apr 2022 13:05:44 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] t: add tests for safe.directory when running with
 sudo
Message-ID: <20220429200544.p7ggvccdnksmhvxt@carlos-mbp.lan>
References: <20220428033544.68188-1-carenas@gmail.com>
 <20220428105852.94449-1-carenas@gmail.com>
 <20220428105852.94449-4-carenas@gmail.com>
 <xmqq7d79du6c.fsf@gitster.g>
 <CAPUEspiCjQRiaOcvSVgS5cZ9q=o6YeZgjp5s3BRZEByD=9Un2Q@mail.gmail.com>
 <xmqqv8usex1v.fsf@gitster.g>
 <20220429012438.37o4uaxsrfdu2b6x@carlos-mbp.lan>
 <xmqqee1fbu67.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqee1fbu67.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 29, 2022 at 11:50:40AM -0700, Junio C Hamano wrote:
> Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:
> 
> > If we do :
> >
> >   [0] login as regular user || sudo to root || login as root
> 
> Among these three, the last one is equivalent to "sudo and then
> unset the environment", right?

Correct, the differences from the most likely sequence of commands
of a potential tester on their workstation (which as you point,
most of the time doesn't allow login in as root) is :

  $ sudo -s -H
  # unset SUDO_UID
  # IKNOWWHATIAMDOING=yes ./t0034-root-safe-directory.sh

the unset only relevant for the third option, of course.

> As many installations no longer allow direct "login" as "root",
> clarifying how users can get the behaviour for the third column
> would help our documentation, and that is the reason behind the
> question.  IOW, this is merely a simple yes-or-no question to
> sanity-check our mutual understanding, and no need to get overly
> defensive about being asked.

Apologies if sounding otherwise, but I can assure I am not offended
by any of this questions, and looking forward to improve in the
documentation with the help you had provided on reviewing it.

I would also like to thank you personally, since I am well aware
that as a not native English speaker, and because Spanish is my
mother's tongue I usually write things in a way that is not natural
or expected and also overly verbose and without expected pauses.  So
having a second set of eyes on it is specially appreciated.

> >   [1] % mkdir -p root/r
> >   [2] % git init root/r
> >   [3] % cd root/r && git status
> >
> >   step \ type | regular user | sudo to root | root
> > --------------------------------------------------
> >             1 |    work      |     work     | work
> >   before    2 |    work      |     work     | work
> >             3 |    work      |     work     | work
> > ---------------------------------------------------
> >             1 |    work      |     work     | work
> >    after    2 |    work      |     work     | work
> >             3 |    work      |     fail     | work
> 
> So the only difference is that in a repository created by a user who
> did "sudo mkdir; sudo git init".  It used to be that the same user
> can read the repository with "sudo git status" (because we did not
> care about how we become 'root', we only saw the owner of the repo
> and the current euid).  Now, such an access is no longer allowed.

Correct, but more importantly we now allow the sequence documented
in the test case which is also IMHO more comnon and useful, where the
last step might need to run through sudo (unlike the previous ones)

> But I do not see what relevance the above has to the argument you
> were making, against "if you start these tests as 'root' (instead of
> starting as an ordinary user), some tests may succeed but for a
> wrong reason, and some tests may fail because they are not prepared
> for it; it is wrong to mark only the latter with prerequisite and
> not the former".  The change in the behaviour we see above is for
> those who start as an ordinary user and uses "sudo" without dropping
> SUDO_UID.  How is it relevant to allow those who start the test as
> 'root' (not an ordinary user) to try that?  Tests done under such
> condition will see 'root' in euid, SUDO_UID, and st.st_uid, so there
> is no way for them to detect any mismatch and behave differently,
> so the transition from "it used to work" to "now it is forbidden"
> is not even tested.

Correct again; guess my intention wasn't clear.  My concern was that by
blocking root, we don't allow for such a test (if it can be written,
since as you pointed out is challenging) to be added and we also lose
the currently failing run which can be used as an "explanation" of sorts
to the question of "is this supported and expected to work?" which I
think the tests help answer and regardless of what is in the documentation.

> > and rejects the repository because it is NOT owned by that id (it was created
> > by root anyway, even if there is no way for git to know that it was done
> > at a different time and with a different session, and therefore the SUDO_UID
> > variable it is honoring could be considered irrelevant in the current context.
> >
> > in the documentation patch (which I think would be better to squash with the
> > fix) I explain what to do as a workaround, and I expect this use case to be
> > less common than the currently broken one (so a net positive)
> 
> Both of these two paragraphs speak truth, but there is no relevance
> to, and it does not justify, your "I disagree, and think that the
> fact ... proves my point".

I ended up doing a bigger refactoring with v3 that split the tests in two and
which I think will help also in the long run, but kept the Documentation patch
independent since it already has your SO and don't want to waste your time
further by having to re-review it.

Assuming that there are no more improvements (or even if they are) to be made
to the documentation would be OK if I follow my own advice and squash it
together with the code change that introduces the change?

Apologies for not doing it earlier, but in my defense I would say that I sent
the currently applied version originally as an RFC ;)

> For example, this is the 'setup' step.
> 
> > +test_expect_success SUDO 'setup' '
> > +	sudo rm -rf root &&
> > +	mkdir -p root/r &&
> > +	sudo chown root root &&
> > +	(
> > +		cd root/r &&
> > +		git init
> > +	)
> > +'
> 
> If the test was started by an ordinary user, root/r is owned by the
> user who is not 'root'.  If the test was started by 'root',
> everything is owned by 'root'.  Either way, 'root' is owned by
> 'root'.  In such a repository, we see this test:
> 
> +test_expect_success SUDO 'sudo git status as original owner' '
> +	(
> +		cd root/r &&
> +		git status &&
> +		sudo git status
> +	)
> +'
> 
> The behaviour we are trying to ensure is that, even though root/r is
> owned by non-root, accessing it with "git status" as the original
> user and "git status" as root work, as long as if you used "sudo" in
> the second "git status", so that "git status" can take SUDO_UID into
> account.  The test is making sure that our "pay attention to
> SUDO_UID" mechanism has not been broken by future changes.
> 
> If we start this test as 'root', we cannot test for that.  The setup
> step made everything owned by 'root', and we go there as 'root' and
> run "git status", which should succceed, but with "sudo git status",
> even we broke SUDO_UID mechanism and compared euid with st.st_uid,
> we'll allow an access.

Depending of the way you become 'root' the test could fail as well,
but IMHO the failing should be expected (and as shown in the table
above) was introduced with this change.

The gist is that if we started the whole test with sudo, there is
no way for git (with the current implementation) to differenciate if that
SUDO_UID is relevant only to its current run or to the environment and
more importantly what the intentions are from the user that is running
on that environment.

Alternatively we could ammend the code to allow for such logic but I
don't think that would be easier to implement and I don't see much of
a benefit.

My thinking is that if we are going to let sudo tells us who the user is
then we must trust that SUDO_UID indicates also the intention of the user
behind that environment and therefore it is correct in this case to fail.

If the user really meant to not trust its SUDO_UID and instead use the
id we are running as, then he should have removed it from the environment
before invoking git as documented.

Long term, as you proposed, if we are running as root we might ALSO
consider that any root owned repositories should be fine to trust but
that change is orthogonal to fixing the 'sudo git <command> in my own
repository doesn't work after the last maint release'

It should also be important to note that starting the whole test with
sudo is not trivial, neither expected, and will also block because of
sudo most likely removing the IKNOWWHATIAMDOING environment variable,
so whichever way we decide we shouldn't expect someone accidentally
failing this test.

> So the test may succeed but it succeeds for a wrong reason even
> after we break the mechanism added by this series.

the test as root without a SUDO_UID would succeed for the wrong reasons
so I agree (and again apologize for suggesting it) that using a
prerequisite to squash that run (as done in the other tests) was wrong.

what I am still not sure about is if it is worth complicating the test
by adding logic that differenciate a root user with and without SUDO_UID
that might run it, and I have to admit that the current draft I have of
v3 does follow your advice of blocking root from even being able to run
it as suggested (and which is also what I am leaning for).

Carlo

PS. I apologize for not trimming on your responses more aggresively to
save some bytes as I would normally do, but wanted to make sure you
understand that by trimming those parts I wasn't implying they weren't
read or relevant, but just not strictly neccesary and implictly agreed
upon for further discussion
