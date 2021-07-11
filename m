Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EB2C07E96
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 12:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D753C61130
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 12:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbhGKM0I (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 08:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhGKM0I (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 08:26:08 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CE9C0613DD
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 05:23:20 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id r20so17942560ljd.10
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 05:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xV8jlOcLGon+P3I5JEXK0ALh9bJsMdOeEQqzahlg2JY=;
        b=nce+68/zThouQqoITfOP/5W5INK7IlwL/pKmqpcG040/0ZZ2m0We8GNVH/KNQiSQFX
         /zDm94pDMKptyOkWWVYB4owE+sDuxJ9ROJTIGAS2YLVTewb3vXC4DPh8pd5kVshx+F+h
         jYK4W1VjANWuNjZJGK1h5c5+HXdou11QSHQiejQRyMDjLfmEjxt19OsKcn5Pc1WUKzqx
         bbcVEKqaYp6+BD6UezhhFLEwG4Vduds9YrvhX3utIBOFTC8W0Z3a3Ares5QllV7bhr53
         R1IGKauKfnnmyBEGxA3Fjg+0XBV73QjDvNXacV5tn5SwL88MAeNxxYyUiQzkobHheFmP
         4QoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=xV8jlOcLGon+P3I5JEXK0ALh9bJsMdOeEQqzahlg2JY=;
        b=DMMG3nJkIA83h//fQzcdrZBaDGHyJM8uKcOAfntIkNN62tclSsTlT3/uhYMgjvyRHA
         iFioncxHTIjWyCdXR8NdrxKUKeoL+BmId0DoCuv6qGKsabuRoeYJLCSnmNorW+iC1Esy
         Rg0SqlW0sy1/3vxfvAz9eLkNmiLUkwNFkl3q2wuG06rbh4otH775flLPEHlZSXTLXK2a
         YjJyTGFNzsHC5J8MaQvgaxDEl0+vSPVt9GEOScjwWXF/p+x9wXR7LmK2xgxglVMPMyaj
         tBYQ7wowF8QlPGItHMmxvPzRcfo8OD7SfOz6MUHG84ADSNfZHpb0gQHzv5SrYeC3qcrz
         3Sag==
X-Gm-Message-State: AOAM530LFZRUMrVkOKSvdaVd6slTr6tqtP0AvgxQXK/FhnkCLOGKJQms
        NDDeKyvAEXePWRMwrwxLduThFduFGhs=
X-Google-Smtp-Source: ABdhPJzxg6ZyVZ75nWZ3u2ZBnbL8vw+4+e3NxpoWs4y4OEf/O2h77enbdfWPSsjMChrjSZWNr7U5bw==
X-Received: by 2002:a2e:924b:: with SMTP id v11mr6822117ljg.214.1626006198473;
        Sun, 11 Jul 2021 05:23:18 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c5sm1222755ljj.17.2021.07.11.05.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 05:23:17 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Martin <git@mfriebe.de>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: PATCH: improve git switch documentation
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
        <87bl7d3l8r.fsf@osv.gnss.ru> <60e61bbd7a37d_3030aa2081a@natae.notmuch>
        <877di13hhe.fsf@osv.gnss.ru>
        <c740a4f0-011f-762e-4f49-f85d1b3abc99@mfriebe.de>
        <60e67389a4adc_306ac1208fd@natae.notmuch>
        <4057b3ac-a77c-0d5f-d3f4-ad781754aae4@mfriebe.de>
        <60e736e72da68_30939020850@natae.notmuch>
        <155308af-42ad-b044-fb37-676251a9b7e1@mfriebe.de>
        <60e762243aab1_30a7b02089@natae.notmuch>
        <2b85a7eb-d0be-65e7-ecbb-1750abf53e53@mfriebe.de>
        <60e79c31aaa72_30b8a4208c1@natae.notmuch>
        <65362688-b65b-661c-20c1-94d7dc2118c7@mfriebe.de>
        <60e874e1c6845_215320861@natae.notmuch>
        <dbfa96f0-558e-ccaf-6e34-6d95c43848b5@mfriebe.de>
        <87im1ieaba.fsf@osv.gnss.ru>
        <1bd36aa2-ac90-f7d4-9d48-1aa39159b263@mfriebe.de>
        <87a6mudt9b.fsf@osv.gnss.ru> <60e9ff4430c57_7ef20815@natae.notmuch>
        <874kd1gr0q.fsf@osv.gnss.ru>
        <6ffd7f1c-97be-a57c-b738-31deae26e8fc@mfriebe.de>
Date:   Sun, 11 Jul 2021 15:23:16 +0300
In-Reply-To: <6ffd7f1c-97be-a57c-b738-31deae26e8fc@mfriebe.de> (Martin's
        message of "Sun, 11 Jul 2021 12:05:02 +0200")
Message-ID: <871r85f39n.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin <git@mfriebe.de> writes:

> On 11/07/2021 11:04, Sergey Organov wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> 
>>>
>>> I don't see the logic in here.
>>>
>>>    git branch topic # here 'branch' is the verb
>> Not to me. I assumed the "branch" is always a noun in "git branch", and
>> the actual meaning of this command is:
>
> Well, it is easy to see it as a noun. But for "branching" creation of
> a branch, it can be seen as verb. 
>
> Yet in
>    git branch --list
> it definitely is a noun.

It's definitely a noun if only consider its description, as output by
"git help":

  "branch            List, create, or delete branches"

So "git branch" is "whatever about branches", not "perform the branch
operation", whatever the latter might be.

>
> But then how would/should those work?
> The action/verb is "list" or "show"
>
>    git show branches
>    git show tags
>    git show ...
>
> That completely tears apart related topics.

Yep, that's it. However, there is no need to immediately do something
about it except considering this as a sound design to be targeted at.

>
> Or is it enough if the subcommand is a verb?
>     git branch create
>     git branch list
> That be ok for me.

This we can't do sanely in a backward-compatible manner, I'm afraid, so
it's likely not an option.

OTOH, adding, say:

      git rm <branch-name>

or, say, adding a whole new "git new" (pun intended) could be considered
to be steps in the right direction if we choose "git <action> ..."
model.

>
>
>>>> is "branch" a noun or a verb?
>>>
>>> Both.
>> No, it's rather noun plus lacking subcommand, sometimes making it look
>> like verb :)
>
> As is
>     git stash
> for
>     git stash push
>
> And I should guess lots of people like the short form....

Maybe. My primary point is inconsistency, not my personal preference for
one way or another. I'm afraid one could find suitable example to
support any model.

>
>> I.e., I'm in favor of universal:
>>     git <command> ...
>> syntax to Git commands where <command> specifies an action. [Why things
>> tend to drift to Lisp all the time, I wonder?]
>> 
>
> Because humans are more about the "things".
> The way we interact is more ofter derived from the object, than the
> object being purposefully made for an interaction?

I don't see it, at least not in the usual human conversations. When one
means an action to be performed, they name the action and then the object:

  "Play football", "Go home", "Set your thoughts straight", "Wash your hands"

No?

Anyway, it's more the consistency that matters, not particular
convention. Git problem is that is has no convention at all. "Just do
what feels right today" seems to be the motto.

Finally, the problem for this particular discussion is that if we decide
that it's rather:

  git <object> <command>

that is the way to go, that I'm pretty fine with as well, we should
simply *obsolete "git switch" right away*, rather than spending time
improving its now almost useless documentation.

>>  From that POV, for the commands you mentioned, "git bisect" is probably
>> fine, whereas "git worktree", and "git remote" should better be split to
>> operations on them, e.g.:
>>     git new remote
>>     git new worktree
>> 
>
> That also makes documentation harder. People who want a worktree, want
> the documentation for it in one place.

  git help worktree

should be able to provide a short manual on worktrees. Please notice
it's again not

  git worktree help


>
> So a manpage for "git new" is not desirable.

Sure it is desirable. That's the primary purpose of manual pages -- to
describe actual commands.

> It would have to be split into the manpages for the objects. But that
> is not good either, or is it?

No-no! Manual pages for describing actual commands are to be there.

It's user/programmer manuals and tutorials that should rather be built
around concepts. It's fine with me if they are available in the format
of manual pages, even though it's not very suitable for that.

>
>> Once that is regularized, we may as well consider allowing for inverse
>> order of the first 2 arguments, by making
>>    git new remote
>>    git remote new
>> the synonyms.
>
> Having even more ways to do one and the same thing....

Python was aiming to have one obvious way of doing every single thing...
Did it succeed in that, I wonder? Maybe this aim is only good in theory?

>
>
> Btw, missing from the discussion:
>
>    git log
>
> "log" can be a verb, but not in the above.

Yep, and "git log" is yet another can of worms I'm not willing to open.

Thanks,
-- 
Sergey Organov
