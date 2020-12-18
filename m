Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F48C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 22:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20A1123B98
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 22:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgLRWMN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 17:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgLRWMM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 17:12:12 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314EFC0617A7
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 14:11:32 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id s26so9183315lfc.8
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 14:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Jh6+04cc+g5Ig3AkVKmTkP4zB7dmU7vEZCOvwqx0cSo=;
        b=JOnO7MfY2eKDXOelOXajbBTqnvqBax7cCa65eYbdG1XxyMgZA0Ec3binbgP6fco3et
         A4es0smI6oKYk0I05YW8LkMyLyYa/dyiDhCttT5du4o71pJCIChaDhjrZ0+0odNAXFH9
         Gl7vlrmzrgQRVSa+iRb4rnp5cEacQUzAVW7v38JXx6m3XMrcSNCZ9I4wmtccj9ffoyEi
         +mU8pad5o8NigILaE5dmsXUqM7AXIIiNtkBlbwRcfxqW07SKOtNXVAxH33LXkTVx0Z20
         MNvFhwfEsxGrsyi125FYhS1LSqIaptSUw9BaRb/fgP4R29dL64KLWw5edzEMjk1ILGCM
         5hMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=Jh6+04cc+g5Ig3AkVKmTkP4zB7dmU7vEZCOvwqx0cSo=;
        b=LEW22O1yKcSMb77eEeY5MSuajv3o/0pQG8aFZgiVBOmOxc43t8WCVT6qXksW8FgLpk
         iwYbSYuizQ3Nby8rBeZ2r8LaaPkNgN1zunz5RMo/J0j2zuNWKwu9UQJBaDP0uQ4VtTva
         ZfiiSYwOTD8AdWz4IUpZhQF2vEqCrbxQspKYkRYbSVLM7kWI/RSpIFsWoRWPSoMiYRDB
         S//bhFyfI27jjpeslqBfHOpCnXvedGT/dzHT6XoFKtcqppGy8T+c2D5+SW+uYG+iHUu2
         USMkLrJ9PVsnUvx0Fo0zMDAFfUUyd5+nc1kPvJ1Kocg+jfQvx5OIR+TJ/81UgPOd11Rc
         NccQ==
X-Gm-Message-State: AOAM533KnniuRlioXG8M9/eqKMrmK2bKTvi5ruIuUHFdC4hNnM9GDYVz
        tLkEX8XK3sqjeU97NguNG+8q1A3mHCE=
X-Google-Smtp-Source: ABdhPJxl9N1YoOPglai7DGgci9rP9K1knpJDqvLCIKnoRIWOv6I+amMNJYGO6AsDcac/JOyy5RdnTg==
X-Received: by 2002:a2e:b70f:: with SMTP id j15mr2763982ljo.60.1608329490173;
        Fri, 18 Dec 2020 14:11:30 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 195sm987560lfk.109.2020.12.18.14.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 14:11:29 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 29/33] doc/git-log: describe new --diff-merges options
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201216184929.3924-1-sorganov@gmail.com>
        <20201216184929.3924-30-sorganov@gmail.com>
        <CABPp-BFRPFxm=SuJFwfG+QYCivMKp2VRpnHGwxNL+extK7UdtA@mail.gmail.com>
        <87lfdvaymn.fsf@osv.gnss.ru>
        <CABPp-BGAHFLZDWaK5q+ZHOShUOZnRqUQd+T-X6mXxkg5cp7QpQ@mail.gmail.com>
Date:   Sat, 19 Dec 2020 01:11:28 +0300
In-Reply-To: <CABPp-BGAHFLZDWaK5q+ZHOShUOZnRqUQd+T-X6mXxkg5cp7QpQ@mail.gmail.com>
        (Elijah Newren's message of "Fri, 18 Dec 2020 09:25:30 -0800")
Message-ID: <87o8iq7oj3.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Fri, Dec 18, 2020 at 8:05 AM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
>> > On Wed, Dec 16, 2020 at 10:50 AM Sergey Organov <sorganov@gmail.com> wrote:
>> >>
>> >> Describe all the new --diff-merges options in the git-log.txt and
>> >> adopt description of originals accordingly.
>> >
>> > You also took care to explain interactions of options with -p that
>> > were previously undocumented, which is a nice bonus.  That wording
>> > could still be improved a bit, though, as noted below.
>> >
>> >> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> >> ---
>> >>  Documentation/git-log.txt | 85 ++++++++++++++++++++++++---------------
>> >>  1 file changed, 52 insertions(+), 33 deletions(-)
>> >>
>> >> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
>> >> index 2b8ac5ff882a..27bc619490c6 100644
>> >> --- a/Documentation/git-log.txt
>> >> +++ b/Documentation/git-log.txt
>> >> @@ -120,45 +120,64 @@ DIFF FORMATTING
>> >>  By default, `git log` does not generate any diff output. The options
>> >>  below can be used to show the changes made by each commit.
>> >>
>> >> -Note that unless one of `-c`, `--cc`, or `-m` is given, merge commits
>> >> -will never show a diff, even if a diff format like `--patch` is
>> >> -selected, nor will they match search options like `-S`. The exception is
>> >> -when `--first-parent` is in use, in which merges are treated like normal
>> >> -single-parent commits (this can be overridden by providing a
>> >> -combined-diff option or with `--no-diff-merges`).
>> >> +Note that unless one of `--diff-merges` variants (including short
>> >> +`-m`, `-c`, and `--cc` options) is explicitly given, merge commits
>> >> +will not show a diff, even if a diff format like `--patch` is
>> >> +selected, nor will they match search options like `-S`. The exception
>> >> +is when `--first-parent` is in use, in which case `first-parent` is
>> >> +the default format.
>> >
>> > Thanks for fixing this up.  :-)
>>
>> Don't mention it :-)
>>
>> >
>> >>
>> >> --c::
>> >> -       With this option, diff output for a merge commit
>> >> -       shows the differences from each of the parents to the merge result
>> >> -       simultaneously instead of showing pairwise diff between a parent
>> >> -       and the result one at a time. Furthermore, it lists only files
>> >> -       which were modified from all parents.
>> >> -
>> >> ---cc::
>> >> -       This flag implies the `-c` option and further compresses the
>> >> -       patch output by omitting uninteresting hunks whose contents in
>> >> -       the parents have only two variants and the merge result picks
>> >> -       one of them without modification.
>> >> +--diff-merges=(off|none|first-parent|1|separate|m|combined|c|dense-combined|cc)::
>> >> +--no-diff-merges::
>> >> +       Specify diff format to be used for merge commits. Default is
>> >> +       `off` unless `--first-parent` is in use, in which case
>> >> +       `first-parent` is the default.
>> >> ++
>> >> +--diff-merges=(off|none):::
>> >> +--no-diff-merges:::
>> >> +       Disable output of diffs for merge commits. Useful to override
>> >> +       implied value.
>> >> ++
>> >> +--diff-merges=first-parent:::
>> >> +--diff-merges=1:::
>> >> +       This option makes merge commits show the full diff with
>> >> +       respect to the first parent only.
>> >
>> > Does it imply -p?
>>
>> No, none of --diff-merges options do. This one is not any special. Why
>> the question?
>
> The documentation on -m was vague enough that it made me wonder.
> Fixing it would probably prevent me from having asked this question.

OK, I see, so let's try to fix the cause, please see below.

>
>> >> ++
>> >> +--diff-merges=separate:::
>> >> +--diff-merges=m:::
>> >> +-m:::
>> >> +       This makes merge commits show the full diff with respect to
>> >> +       each of the parents. Separate log entry and diff is generated
>> >> +       for each parent. `-m` is different in that it doesn't produce
>> >> +       any output without `-p`.
>> >
>> > Different from what?  From --first-parent?  From flags that haven't
>> > been covered yet?  (-c and --cc show up below)
>>
>> Well, from --diff-merges=m and --diff-merges=separate, that, as any
>> other --diff-merge option, do produce output (for merge commits) even
>> without -p.
>
> That wasn't at all clear to me as the intent of the last sentence.

Well, actually, the right answer to your question is: -m is different
from *everything* ;-)

Maybe the confusion you got is not caused by the documentation, but
rather by some of your expectations? In particular, I wonder, how comes
--first-parent appeared in your question, that is entirely unrelated?

I mean I'm still unsure how to make this description more clear, maybe
this will do:

--diff-merges=separate:::
--diff-merges=m:::
-m:::
       This makes merge commits show the full diff with respect to
       each of the parents. Separate log entry and diff is generated
       for each parent. `-m` doesn't produce any output without `-p`.

>
>> >> ++
>> >> +--diff-merges=combined:::
>> >> +--diff-merges=c:::
>> >> +-c:::
>> >> +       With this option, diff output for a merge commit shows the
>> >> +       differences from each of the parents to the merge result
>> >> +       simultaneously instead of showing pairwise diff between a
>> >> +       parent and the result one at a time. Furthermore, it lists
>> >> +       only files which were modified from all parents. Historically,
>> >> +       `-c` enables diff output for non-merge commits as well.
>> >
>> > "Historically"?  Does that mean it doesn't anymore?
>>
>> Eh, I don't think "historically" means that, but I'm not sure, being
>> non-native English speaker.
>
> Sometimes non-native speakers use the language more accurately.  This
> might be such a case, but that sentence did make me think you might be
> attempting to document past behavior as a way of helping people adjust
> to current/new behavior.
>
>> > (Maybe, "The short form, `-c`, also enables diff output for non-merge
>> > commits as well." or something like that?)
>>
>> ... and then try to explain why this otherwise illogical behavior is
>> there? I thought "historically" would cover that.
>
> It doesn't seem like illogical behavior to me.   Perhaps the view of
> -c as a diff-merges option, reinforced by placing -c right next to
> --diff-merges in the documentation, is what causes you to think so?

-c, described as selecting specific format of representation of merge
commits, suddenly enabling diff output of non-merge commits, is logical?
No. Useful? Maybe. Logical? Not to me. Just saying, see below.

> If so, maybe we should document -c (and --cc) separately after all the
> --diff-merges options, using something like the following:
>
> -c:::
>     Implies both --patch and --diff-merges=combined, i.e. turn on
> patches for normal commits and show a combined diff format for merges.

The problem with this is that it'd then be preferable to describe -m
separately as well, and that's not that simple.

Overall, I'd rather change that in place, like this:

--diff-merges=combined:::
--diff-merges=c:::
-c:::
       With this option, diff output for a merge commit shows the
       differences from each of the parents to the merge result
       simultaneously instead of showing pairwise diff between a
       parent and the result one at a time. Furthermore, it lists
       only files which were modified from all parents. `-c` implies
       `--patch`.


Thanks,
-- Sergey
