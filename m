Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB038C433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 08:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FE2F2311C
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 08:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbhASIWm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 03:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730838AbhASIVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 03:21:16 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39DEC061573
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 00:20:35 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id gx5so8006911ejb.7
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 00:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:message-id:in-reply-to
         :date:mime-version;
        bh=2J2SGtW93K9t/h+IQaHFddqokX3fvc793T/z3/qp/LU=;
        b=jg4OKo/JMbtM3PUpjFe/jekdiPoWb1u3z16EKQtjTjnqFihcUQTBHSB6tsI3zyKwXJ
         wtNQpd88FU4SWrvkhnbrrBT3WYwKwK2enOfpFukMS8wTiIJknWvAt+sEojAz7X3hBqbL
         0oxNS5oLYtULP0QtUlDbtMZ51FbCNXEgzWeyWMJU6mLMXq39YRouQem01Yx52GgQFAdQ
         8flgRO+yZEy56GSHbewZ6x7G3MZ0UGOXZcIRbp0xbhaI19yYI0HDwXDXrarWgn0S3V1b
         kY9NQ6drQXSv0YhQbHcbMzdSR/pbvJOtlylN1d63yBn+8qjcQqjskAa90kBUpXPGkErv
         I53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :message-id:in-reply-to:date:mime-version;
        bh=2J2SGtW93K9t/h+IQaHFddqokX3fvc793T/z3/qp/LU=;
        b=RuZIl3fPm092vbOGTurhEK3skA34foplrBtS+d/V0u+yRMUuFO4LyAYrxgIHU/BR6s
         EnJkYI19cPu7yngIJjihC0r1VKkQdIiZTAkSQUstF4j8SB2I9K0qdp9keZIjt/3Uo38z
         fa9iKgClzu6aO5aarjy0gO+BwAsOXKnaqw35bVjS8Ns4TtAtQmLLt0N+9LofGT9Op9EV
         FSk18HTBBXVkajClEx6Z1aYgiG2CfhY8jF0UWGMN3ZmAaFCiqYdgTgaC+2mdiVqltqdP
         THk0dj15oUubFiQFJDfPn6lZdkHlJv8JNhNVT0XzgUEPPzdNNl7W9L9eaz7L3BaIg2Qi
         rZiA==
X-Gm-Message-State: AOAM530wWZnCdV9Lx8OxTgWkOt3r1+GP2UzEPNhY93kKeWm40kgasvnL
        uDZF0L7SIoAptYE+Efke7lxF0/MH03g=
X-Google-Smtp-Source: ABdhPJwIVR61dMj/Weaxzx+cvLxMjC1rFZSEof1xb3C4NMgnguAs+Siy5jtlOmDPQvVgu/gFVNU02A==
X-Received: by 2002:a17:906:653:: with SMTP id t19mr2267455ejb.44.1611044434629;
        Tue, 19 Jan 2021 00:20:34 -0800 (PST)
Received: from cpm12071.local ([212.86.35.161])
        by smtp.gmail.com with ESMTPSA id a22sm8835788edv.67.2021.01.19.00.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 00:20:34 -0800 (PST)
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
 <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
 <20210117234244.95106-5-rafaeloliveira.cs@gmail.com>
 <CAPig+cSHpP8-QxmQhNuBd3sgn7D6ZfBnK7+1Yw50aakD2UqGFg@mail.gmail.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 4/6] worktree: teach `list --porcelain` to annotate
 locked worktree
Message-ID: <gohp6kbldlfkig.fsf@gmail.com>
In-reply-to: <CAPig+cSHpP8-QxmQhNuBd3sgn7D6ZfBnK7+1Yw50aakD2UqGFg@mail.gmail.com>
Date:   Tue, 19 Jan 2021 09:20:33 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Thanks for the review.

Eric Sunshine writes:

> On Sun, Jan 17, 2021 at 6:43 PM Rafael Silva
> <rafaeloliveira.cs@gmail.com> wrote:

>> Additionally, c57b3367be (worktree: teach `list` to annotate locked
>> worktree, 2020-10-11) introduced a new test to ensure locked worktrees
>> are listed with "locked" annotation. However, the test does not clean up
>> after itself as "git worktree prune" is not going to remove the locked
>> worktree in the first place. This not only leaves the test in an unclean
>> state it also potentially breaks following tests that relies on the
>> "git worktree list" output. Let's fix that by unlocking the worktree
>> before the "prune" command.
>
> The actual code change to fix this bug is about as minimal as it gets,
> but the explanation you've written here is lengthy enough and nicely
> self-contained that it suggests splitting it off to its own patch. And
> since you can re-use this paragraph almost verbatim as the commit
> message, it shouldn't require much work to do so. On the other hand,
> it is itself not necessarily worth a re-roll, but if you do re-roll,
> perhaps it's worth considering.
>

make sense, I'll re-roll with this change on its own patch. I actually
thought about splitting it off during as well, but I wasn't sure whether
this was a good idea. Now that you mentioned here I guess it sounds a
like reasonable change for the next version.


>> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
>> @@ -377,8 +377,10 @@ Porcelain Format
>>  The porcelain format has a line per attribute.  Attributes are listed with a
>>  label and value separated by a single space.  Boolean attributes (like `bare`
>>  and `detached`) are listed as a label only, and are present only
>> -if the value is true.  The first attribute of a working tree is always
>> -`worktree`, an empty line indicates the end of the record.  For example:
>> +if the value is true.  Some attributes (like `locked`) can be listed as a label
>> +only or with a value depending whether a reason is available.  The first
>
> Perhaps:
> s/depending whether/depending upon whether/
>

Yeah, I think that's sounds bit better.

>> +attribute of a working tree is always `worktree`, an empty line indicates the
>> +end of the record.  For example:
>> @@ -393,6 +395,16 @@ worktree /path/to/other-linked-worktree
>> +worktree /path/to/linked-worktree-locked
>> +HEAD 5678abc5678abc5678abc5678abc5678abc5678c
>> +branch refs/heads/locked
>> +locked
>> +
>> +worktree /path/to/linked-worktree-locked-with-reason
>> +HEAD 3456def3456def3456def3456def3456def3456b
>> +branch refs/heads/locked-with-reason
>> +locked reason why is locked
>
> I was momentarily confused by the branch named `locked` with the
> `locked` attribute in the first new stanza. Perhaps take a hint from
> the second new stanza and call the first one `locked-no-reason`:
>
>     worktree /path/to/linked-worktree-locked-no-reason
>     HEAD 5678abc5678abc5678abc5678abc5678abc5678c
>     branch refs/heads/locked-no-reason
>     locked
>
> Again, though, not worth a re-roll.
>

This seems like a nice touch. will include this in the next revision.

>> diff --git a/builtin/worktree.c b/builtin/worktree.c
>> @@ -579,6 +582,16 @@ static void show_worktree_porcelain(struct worktree *wt)
>> +       reason = worktree_lock_reason(wt);
>> +       if (reason && *reason) {
>> +               struct strbuf sb = STRBUF_INIT;
>> +               quote_c_style(reason, &sb, NULL, CQUOTE_NODQ);
>> +               printf("locked %s\n", sb.buf);
>> +               strbuf_release(&sb);
>> +       } else if (reason)
>> +               printf("locked\n");
>
> This needs a change, and it's totally my fault that it does. In my
> previous review, I mentioned that if the lock reason contains special
> characters, we want those special characters escaped and the reason
> quoted, but _only_ if it contains special characters. However, I then
> incorrectly said to call quote_c_style() with CQUOTE_NODQ to achieve
> that behavior. In fact, CQUOTE_NODQ gives us the wrong behavior since
> it avoids quoting the string which, as Phillip pointed out, makes it
> impossible to distinguish between a string which just happens to
> contain the two-character sequence '\' and 'n', and an escaped newline
> "\n". So, the above should really be:
>
>     quote_c_style(reason, &sb, NULL, 0);
>
> The example in the commit message should be adjusted to account for
> this change, as well:
>
>     In porcelain mode, if the lock reason contains special characters
>     such as newlines, they are escaped with backslashes and the entire
>     reason is enclosed in double quotes. For example:
>
>     $ git worktree list --porcelain
>     ...
>     locked "worktree's path mounted in\nremovable device"
>     ...
>
> And, of course, the new test will need a slight adjustment.
>

Alright, I believe I've got the whole picture now and sorry for the
confusion. You and Phillip clearly stated in the review cycle that the
reason should be quoted because of the aforementioned reasons and I 
dropped when I was working on this version.

I will re-roll and change this in the next revision.

>> diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
>> @@ -66,11 +66,43 @@ test_expect_success '"list" all worktrees with locked annotation' '
>> +test_expect_success '"list" all worktrees --porcelain with locked' '
>> +       test_when_finished "rm -rf locked1 locked2 unlocked out actual expect && git worktree prune" &&
>> +       echo "locked" >expect &&
>> +       echo "locked with reason" >>expect &&
>> +       git worktree add --detach locked1 &&
>> +       git worktree add --detach locked2 &&
>> +       git worktree add --detach unlocked &&
>> +       git worktree lock locked1 &&
>> +       git worktree lock locked2 --reason "with reason" &&
>> +       test_when_finished "git worktree unlock locked1 && git worktree unlock locked2" &&
>> +       git worktree list --porcelain >out &&
>> +       grep "^locked" out >actual &&
>> +       test_cmp expect actual
>> +'
>
> So, the purpose of the `unlocked` worktree in this test is to prove
> that it didn't accidentally get annotated with `locked`? (Since, if it
> did get annotated, then `actual` would contain too many lines and not
> match `expect`.) Is that correct?
>

Yes, this is what I intended to check when adding the `unlocked`
worktree. I'm considering how to make this more explicit so it's clear
for readers why the `unlocked` worktree exists in this test.


>> +test_expect_success '"list" all worktrees --porcelain with locked reason newline escaped' '
>> +       test_when_finished "rm -rf locked_lf locked_crlf out actual expect && git worktree prune" &&
>> +       printf "locked locked\\\\r\\\\nreason\n" >expect &&
>> +       printf "locked locked\\\\nreason\n" >>expect &&
>> +       git worktree add --detach locked_lf &&
>> +       git worktree add --detach locked_crlf &&
>> +       printf "locked\nreason\n\n" >reason_lf &&
>> +       printf "locked\r\nreason\n\n" >reason_crlf &&
>
> The trailing "\n\n" is unneeded. Due to the way `$(...)` expansion
> works (dropping trailing whitespace), you'll get the same successful
> test result with:
>
>     printf "locked\nreason\n" >reason_lf &&
>     printf "locked\r\nreason\n" >reason_crlf &&
>
> and even with:
>
>     printf "locked\nreason" >reason_lf &&
>     printf "locked\r\nreason" >reason_crlf &&
>
>> +       git worktree lock locked_lf --reason "$(cat reason_lf)" &&
>> +       git worktree lock locked_crlf --reason "$(cat reason_crlf)" &&
>
> You could also just embed the `printf`'s here rather than using these
> temporary files.
>
>     git worktree lock --reason $(printf "...") <path> &&
>

Having the `printf` together with the $(...) expansion seems like the
good simplification for this test. will include in the next revision.

> Or, if we care only about testing LF, and not about CRLF, even this would work:
>
>     git worktree lock --reason "reason with
>     newline" <path> &&
>
> but that gets a bit ugly.
>
> Anyhow, all the line terminator commentary about this test is a matter
> of personal taste, probably not worth a re-roll or even changing.


-- 
Thanks
Rafael
