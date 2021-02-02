Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F62C433E6
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 15:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FC8F64E92
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 15:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbhBBPcA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 10:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbhBBPaF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 10:30:05 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3332C06174A
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 07:29:24 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id e70so20135253ote.11
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 07:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xniQtn/xM6O9+VhyEu8dwHK9VivLOBWBkvNew4iCxEo=;
        b=O/bdZ3jLE861rDpjvVeyRTAbA2XXoNhe+5B+uS4psiuUsZswBRyxhABxTRhm7PdSnL
         GOzFpfapDHRXqK8MmMelbvSjWbucPNbUyGdIjAgmy/Kd8ruAOVYqvLwtQVL2TUh7hVdD
         jjCwVKx+bZks3UJq63DppCtXWOPekgSnucpQAap4ia1iVa85yOkoGm7Bda7lUxdOze1m
         EdxGcETekbGe/PGc9FIZ/ilLfe9p0H+D/6nbA9fFyLy8vEKRyjdqSiZ3iONumzkwz9/w
         59tiSY+It81YWCEc/oQWlWNNMg2lLKyAfa3qKj8Xc3kqcZjgRSK1kaNaw0A4iVHTvLtA
         cyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xniQtn/xM6O9+VhyEu8dwHK9VivLOBWBkvNew4iCxEo=;
        b=pQTvqJURF1gYEK3OThVsWt1PI1bAyYsVOk42AUe9q4Du/m0JBfzqj7FZ9hoRQ+FcHk
         KaMcHYMN0lKEqxUl4tyqV2sAN4KZuMJP9BeIqpX20JiHLWwQlo9fxwXLVXiDcOHXD1gu
         M5GSU0i7aelfgWzGOkc/l7kO4vbxhaBJ8zkprCPQE2PfTbCPXF6tlcXQIA2NDiWZl11L
         vtTyb6nxB93NuXwAIwY1Y9bxWx5DohYk5MjZ8iOllLsTCG9AVhIzL/7TaddpnpDkj+Z/
         11jcdzfrOfiv/OOhCajjI2Mxgw3LLbw5ak7JjcgOAhrJpLCq5YAhI6fNlpM+ZrC5A7pu
         /iOg==
X-Gm-Message-State: AOAM5321wOBdqpfgH2jqkYxcoDjtGCvn0FILV+1I3QY4LWN5H+1tFfPD
        ZPyhR2CzgUrlWG34zzmaLxdkaIUbSerBjWETHHCYR562U3I=
X-Google-Smtp-Source: ABdhPJxRaGQPxW5DMkO/vvSu/N2pu54m7IcFoC6nfn1on5RdJSF2q9ZOUa4qjdGHFwYc95t+RKJ/ukpxK7XgBE6Xqqs=
X-Received: by 2002:a9d:313:: with SMTP id 19mr15384578otv.147.1612279764274;
 Tue, 02 Feb 2021 07:29:24 -0800 (PST)
MIME-Version: 1.0
References: <20210124170405.30583-1-charvi077@gmail.com> <20210129182050.26143-1-charvi077@gmail.com>
 <20210129182050.26143-7-charvi077@gmail.com> <CAPig+cQeBE7m8wf1e_soVrpvL3==u50MPyb90NwWLnFiUz1Byw@mail.gmail.com>
In-Reply-To: <CAPig+cQeBE7m8wf1e_soVrpvL3==u50MPyb90NwWLnFiUz1Byw@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Tue, 2 Feb 2021 20:59:12 +0530
Message-ID: <CAPSFM5fZHZDnmRD2GzwPVKwBjogKD=GJbC7e=6aQSbu_iXBdNw@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] rebase -i: add fixup [-C | -c] command
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Tue, 2 Feb 2021 at 06:17, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Fri, Jan 29, 2021 at 1:24 PM Charvi Mendiratta <charvi077@gmail.com> wrote:
> > Add options to `fixup` command to fixup both the commit contents and
> > message. `fixup -C` command is used to replace the original commit
> > message and `fixup -c`, additionally allows to edit the commit message.
>
> In the cover letter for this series, you had this additional information:
>
>     This convention is similar to the existing `merge` command in the
>     interactive rebase, that also supports `-c` and `-C` options with
>     similar meanings.
>
> which helps to explain the choice of -c and -C. It might be nice to
> include that explanation in this commit message, as well (but not
> itself worth a re-roll).
>

Agree, I will include this in the commit message.

> > Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> > ---
> > diff --git a/rebase-interactive.c b/rebase-interactive.c
> > @@ -44,7 +44,9 @@ void append_todo_help(int command_count,
> >  "s, squash <commit> = use commit, but meld into previous commit\n"
> > -"f, fixup <commit> = like \"squash\", but discard this commit's log message\n"
> > +"f, fixup [-C | -c] <commit> = like \"squash\", but discard this\n"
> > +"                   commit's log message. Use -C to replace with this\n"
> > +"                   commit message or -c to edit the commit message\n"
>
> This change jarringly introduces the first and only use of a period
> and capitalized word in the to-do help text. Perhaps instead say:
>
>     ... like \"squash\", but discard this
>     commit's log message; use -C to replace with this
>     commit message or -c to edit the commit message
>

Okay, I will change it.

> When `-c` says "edit the commit message" it's not clear what will be
> edited. The original's commit message? The replacement's message? A
> combination of the two? If you can come up with a succinct way to word
> it such that it states more precisely what exactly will be edited, it
> would be nice, but not necessarily worth a re-roll.
>

Here the editor shows the commented out commit message of original commit and
the replacement commit message (of fixup -c commit) is not commented out.

So maybe s/edit the commit message/edit this commit message  is better.

> > diff --git a/sequencer.c b/sequencer.c
> > @@ -1718,6 +1718,12 @@ static int is_pick_or_similar(enum todo_command command)
> > +enum todo_item_flags {
> > +       TODO_EDIT_MERGE_MSG    = (1 << 0),
> > +       TODO_REPLACE_FIXUP_MSG = (1 << 1),
> > +       TODO_EDIT_FIXUP_MSG    = (1 << 2),
> > +};
>
> I'm confused. These enumeration items are defined as bit flags,
> implying that they may be combined, however...
>
> > @@ -1734,32 +1740,176 @@ static size_t subject_length(const char *body)
> > +static int check_fixup_flag(enum todo_command command,
> > +                           enum todo_item_flags flag)
>
> ...here and elsewhere, you declare the argument as a strict
> `todo_item_flags` enum item rather than `unsigned` which is the
> typical declaration when combining bit flag values. So, the picture
> thus far is confusing. Are the `todo_item_flags` values distinct
> unique values which will never be combined, or are they meant to be
> combined?
>
> > +{
> > +       return command == TODO_FIXUP && ((flag & TODO_REPLACE_FIXUP_MSG) ||
> > +                                        (flag & TODO_EDIT_FIXUP_MSG));
> > +}
>
> This code adds to the confusion. In the function argument list, `flag`
> has been declared as a single enum item, yet this code is treating
> `flag` as if it is a combination of bits. So, it's not clear what the
> intention is here. Is `flag` always going to be a specific enum item
> in this context or is it going to be a combination of bits? If it is
> only ever going to be a distinct enum item, then one would expect this
> code to be written like this:
>
>     return command == TODO_FIXUP &&
>         (flag == TODO_REPLACE_FIXUP_MSG ||
>         flag == TODO_EDIT_FIXUP_MSG);
>
> Otherwise, if `flag` will actually be a bag of bits, then the argument
> should be declared as such:
>
>     static int check_fixup_flag(enum todo_command command,
>         unsigned flag)
>

I admit it resulted in a bit of confusion. Here, its true that flag is always
going to be specific enum item( as command can be merge -c, fixup -c, or
fixup -C ) and I combined the bag of bits to denote
the specific enum item. So, maybe we can go with the first method?

> By the way, the function name check_fixup_flag() doesn't necessarily
> do a good job conveying the purpose of this function. Based upon the
> implementation, I gather that it is checking whether the command is a
> "fixup" command, so perhaps the name could reflect that. Perhaps
> is_fixup() or something?
>

Agree, here it's checking if the command is fixup and the flag value (
which implies either user has given command fixup -c or fixup -C )
So, I wonder if we can write is_fixup_flag() ?

> > +static int append_squash_message(struct strbuf *buf, const char *body,
> > +                        enum todo_command command, struct replay_opts *opts,
> > +                        enum todo_item_flags flag)
> > +{
> > +       /*
> > +        * amend is non-interactive and not normally used with fixup!
> > +        * or squash! commits, so only comment out those subjects when
> > +        * squashing commit messages.
> > +        */
> > +       if (starts_with(body, "amend!") ||
> > +           ((command == TODO_SQUASH || seen_squash(opts)) &&
> > +            (starts_with(body, "squash!") || starts_with(body, "fixup!"))))
> >                 commented_len = subject_length(body);
>
> I understand from the cover letter that "amend!" is being added by
> this series, however, no patch up to this point, nor this patch
> itself, adds "amend!" functionality, so it's surprising to see it
> being tested here. As a reader, I would expect code/comments related
> to "amend!" to be added in the patch which actually introduces
> "amend!" rather than doing it here.
>

This patch series does not include the implementation of amend! commit.
I think to avoid the confusion I will remove this part from this patch series
and add it in the next patch series for amend! commit.

> > +       /* fixup -C after squash behaves like squash */
> > +       if (check_fixup_flag(command, flag) && !seen_squash(opts)) {
> > +               if (opts->signoff)
> > +                       append_signoff(buf, 0, 0);
> > +
> > +               if ((command == TODO_FIXUP) &&
> > +                   (flag & TODO_REPLACE_FIXUP_MSG) &&
> > +                   (file_exists(rebase_path_fixup_msg()) ||
> > +                    !file_exists(rebase_path_squash_msg()))) {
>
> Is the expression `command == TODO_FIXUP` redundant here considering
> that the only way we got this far is if check_fixup_flag() returned
> true, in which case we know that command is TODO_FIXUP? Or am I
> missing something?

Yes, it implies the same.

>
> > @@ -2281,6 +2436,18 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
> > +       if (item->command == TODO_FIXUP) {
> > +               if (skip_prefix(bol, "-C", &bol) &&
> > +                  (*bol == ' ' || *bol == '\t')) {
> > +                       bol += strspn(bol, " \t");
> > +                       item->flags |= TODO_REPLACE_FIXUP_MSG;
> > +               } else if (skip_prefix(bol, "-c", &bol) &&
> > +                                 (*bol == ' ' || *bol == '\t')) {
> > +                       bol += strspn(bol, " \t");
> > +                       item->flags |= TODO_EDIT_FIXUP_MSG;
> > +               }
> > +       }
>
> I was wondering if the above could be rephrased like this to avoid the
> repetition:
>
>     if (bol[0] == '-' && tolower(bol[1]) == 'c' &&
>         (bol[2] == ' ' || bol[2] == '\t') {
>         item->flags |= bol[1] == 'C' ?
>             TODO_REPLACE_FIXUP_MSG :
>             TODO_EDIT_FIXUP_MSG;
>         bol += 2 + strspn(bol + 2, " \t");
>     }
>
> but perhaps it's too magical and ugly.

I agree, this [tolower(bol[1]) == 'c'] is actually doing all the
magic, but I am not
sure if we should change it or not ? As in the source code just after
this code we
are checking in a similar way for the 'merge' command. So, maybe implementing
in a similar way is easier to read ?

Thanks and Regards,
Charvi
