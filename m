Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A667EC433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 18:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F18860ED4
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 18:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbhJLS17 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 14:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbhJLS16 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 14:27:58 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBBBC06174E
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 11:25:55 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id j21so1021664lfe.0
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 11:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9emnoYP5twu8nypl4yaxH5wYlfbw350yzbe84IGRBzU=;
        b=hhTY31zkbvdpwWyDfsJb0k0s/Wgkbihf4ngvBumiADIjwc+LZBufuMZBYgvrrCRmGo
         LmQQb1RFCRpYaLyUb1sVDIn7Dx08t1Ekf4dx5n8kB4xjKaar1th+X25NpusrJ4QbvQKb
         SO8KNbyFetOoi9BPGYnVY/XUaaQ3pp/R6UWQldqz6BWBPLY/xKrFffYHV4x3dqfKiVsY
         dp+vEp+pySH5onIibRFbiXHk8evWvD5jKndpoZPF1PdLGQBg2JMTqz/ZnvzfK+khCnid
         ehSFYGQyZLZ8YVPV6BKljtZcZBpTI0XL51kZr+fcyqxA35QvRNCWHU4uTGiWAXDn89vn
         Tqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=9emnoYP5twu8nypl4yaxH5wYlfbw350yzbe84IGRBzU=;
        b=TDSZHsrzmsrWzMgbwUmI8Wp9FUZuGZKoqAcbYNWj96ZWdMR2mrcL8iVGG4gG5e+R+q
         FNk8XYUfyxzYLrr0VaZ8Oaa5LG6Tq6yRjxZ5HwdKRihuhLnMVESNkStFSsmL+3EDaLWZ
         ufr0QS9xYdP9Byhs1ixQvLmh/g9+b4dUefJWsvzhFQyWiqjb1VBI+K7tak0AB0dMzHHI
         IJRGKA8EJ3twvI8/nVWVDdnoG/encDMIQJV8Pklt1Vu9ONtpXztFmR/Ty41sJrjqrg/u
         26nMpowVNFilEb+4mPI9fXhgMPVr5AEkVN3NuDbz2nh6PU56pYz1nQuUQwkKxsHx0JAJ
         5A/w==
X-Gm-Message-State: AOAM533a45GKeP9XM3ZcCYZ8C8ptw6lJZtXapKGzc2ICPOtfNK+ts3+x
        VVZDRPfjp5o5wsF3ADT7OPk=
X-Google-Smtp-Source: ABdhPJwrYcAtV3vdQvU5Rq5EfPCY3WMVsOaHl+izyJMROcfke4c7TGrV0wbtjCAw2fV44HnugEd5LQ==
X-Received: by 2002:ac2:4c56:: with SMTP id o22mr4923168lfk.196.1634063153760;
        Tue, 12 Oct 2021 11:25:53 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 9sm1223868ljo.78.2021.10.12.11.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 11:25:52 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH RFC v1] stash: implement '--staged' option for 'push'
 and 'save'
References: <875yugcs3l.fsf@osv.gnss.ru> <87lf2zz59w.fsf@osv.gnss.ru>
        <CAPig+cQgZX5U0KThgSKjmgvOvEZWxPF_BovYYe=VfjDvUE5c9Q@mail.gmail.com>
        <87fst7z0oa.fsf@osv.gnss.ru> <87y26yk35r.fsf@evledraar.gmail.com>
        <xmqqa6je8n5c.fsf@gitster.g> <xmqqo87u777d.fsf@gitster.g>
        <87k0ii446g.fsf@osv.gnss.ru> <xmqqzgre40ff.fsf@gitster.g>
Date:   Tue, 12 Oct 2021 21:25:52 +0300
In-Reply-To: <xmqqzgre40ff.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        12 Oct 2021 10:28:52 -0700")
Message-ID: <87lf2yqevj.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> More importantly...
>>>>
>>>> Whenever I think about a new "feature", I try to come up with a
>>>> story in which the feature effectively improves the end-user's life,
>>>> how it fits in the larger picture, and enables something that is
>>>> hard to do by combining other tools.
>>>>
>>>> The kind of "story" I would aim for is like this.  Suppose we were
>>>> selling not "git stash -S" but "git stash -k". ...
>>>
>>
>> [...]
>>
>>> So in short, I do not think I am strongly opposed to "git stash -S"
>>> existing, since I did find one use case story that it could be used,
>>> but I do think it is redundant and unnecessary.
>>
>> Redundant? Yes. Unnecessary? Yes. Useful? Yes. ;-)
>>
>> I took the steps to propose the new feature after yet another round of
>> "how do I quickly store this tiny bit of changes I just figured I need
>> for later, out of bunch of VIWIP changes?"
>>
>>   git stash --staged
>>
>> is exactly the (currently missing) answer for me, as I have pretty
>> interactive tool to stage diff chunks always handy.
>>
>> What's your answer, I wonder?
>
> I am the one who questions the usefulness of "stash --staged" and
> thinks "add -p", "stash -k", test, "commit" is a much better way to
> solve the "we have a messy working tree and we want to create a
> clean multi-step end result out of it" problem

I don't want to create a multi-step result out of it, if it means a
series of commits. The question is about a change that is *unrelated* to
the series I'm supposedly doing.

>
> I consider "stash --staged" as a solution in search of a problem, so
> you'd need to ask somebody else for a problem that "stash --staged"
> is suitable for.

I didn't ask you what --staged is suitable for, sorry. I asked how do
you solve the problem of saving an *entirely unrelated* subset of
changes for future use?

If the answer is "I don't have such problem", it's OK with me, but my
point is that I, and at least a few others, seem to have such a problem
frequently enough to justify introduction of the --staged option.

>
> And "I want to stash away this tiny bit" is better solved by *not*
> doing "git add" it to the index and then stashing.  Rather, I'd just
> do "commit" so that I can "rebase -i" to reorganize these bits
> later.  Of course, to test the "tiny bit" standalone, I may use
> "stash -k" first, but do not see such a senario shows the merit of
> using "stash --staged" over other tools.

That is a good solution for *different* problem. The changes I want to
stash-out supposedly don't belong to the series of changes currently
being worked on *at all*, and I don't want to test them right now as I'm
working on entirely unrelated set of problems and don't want to get
side-tracked.

So, the analog here is not using "stage -k"->test->commit cycle, it's
rather temporary switching to another branch and committing there, like
this:

 <hack, hack, hack...>
 <notice unrelated problem, give it a quick fix and stage it>
 $ git checkout -b tmp-fix-bla-bla
 $ git commit -m "Will have to look at bla-bla later"
 $ git checkout -
 <hack continues, probably using stash -k and rebasing as needed>
 <... time passes... >
 $ git switch some-branch
 $ git cherry-pick -n tmp-fix-bla-bla
 <... continue to work on the bla-bla fix ...>

See? But now, we already have such a wonderful place for temporary
states called "stash". Why should it be so hard to "commit" right to the
stash instead of stomping around and then house-keeping of these
temporary non-branches? That's what "stash --staged" is suitable for,
not for creating clean sequence of commits out of a mess, where "stash
-k" indeed shines.

>
>> That said, I'm also curious what story, if any, do you have for 'git
>> stash --patch', as exactly the same story should be applicable to
>> proposed 'git stash --staged', as far as I can see.
>
> "stash --patch" is also "Meh" from my point of view.  I do not
> strongly object to its existence, it may be a OK tool for a small
> scale use, but I suspect it would be more frustrating than helpful
> to users when applied in a larger workflow story, just like I view
> "git stash --staged".

I see, thank you for clarification.

Thanks,
-- Sergey Organov
