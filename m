Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3DCC56201
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 22:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB8852083E
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 22:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSqN0bX+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388803AbgKXWCT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 17:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388264AbgKXWCT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 17:02:19 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11054C0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 14:02:19 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id i17so126478ljd.3
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 14:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QX7QJQKnlU+7FHvtqJoyER1OGnJVQZbSStLLWR7qB5g=;
        b=OSqN0bX+zFco0bAV6QlrDFfwk4YmBQWtjk0GQa0MHNLXW0nPPgpkPmwfSK39ljilkJ
         tPWi6BCc4yQRmj43Dy4Hf/3l93TSaLNsybRduzr2OBnyN8MhTAsP7dvsweV8J26pdPI0
         j4hmTwsNLzTchNmVSC2tVS6oNP28OF3K6+G7M7CdbNFUAqq3PxEXMZeg/ylPUx5siRwV
         KvVuOvMMd32oq0Nowz43WUz3RnTtwbuU0+pLNzRXOMEi8PSXaURPVCmwGm4SpC/cQYrC
         lvfjtYv5UYBE14ZgQ7aXOq4o0CBZ1tyNG2MNSoHUzdKG0a8ZV1v3cDLqQlvStH3Nzr/7
         LCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=QX7QJQKnlU+7FHvtqJoyER1OGnJVQZbSStLLWR7qB5g=;
        b=EvxXYpLsTqOsH1Jju7w5Av79fvHL+0YjCCVT2PfTTD/HJUIV6XdOejiUFd1lufdLK1
         wGTFS/AW742mfAzbAXwe+G3qC+eBjFmvXZyxROXys6upqgs+5/fGnqeRPu9o8OrcuvmU
         jJIbTp2djRfamGVSt1nmiMGAEeYb/tQEKLp1YMjdMAwoRqvW+celtFIRxoavJIb0jdp8
         CY5mgKxDa6ayomk+ZUulJi3fO0z4GXnxr57F646NmXldRUheg5BD+aQaIU8WuqLXEgem
         QeSayk9DdncyBwUn8hApBc1ht2WGybNWbTPjHIGgafWDnm0lHQZ89qGZo7gf9IQMbhA9
         ChDA==
X-Gm-Message-State: AOAM531/Z6wPqDGd1FwWZsiOini+7Mqg/RGq+2m1Idyhx3BgomsvK6Qf
        RHtbOAhF4Yot5Jgoy19r7Pl7zZJeJkg=
X-Google-Smtp-Source: ABdhPJyANr28gpfdK7d3Au2ZaYpBFfT36wyoy2Wob5KTn2CEBWoKQTodEqk9nrQiuyVnxrduk9cWiw==
X-Received: by 2002:a05:651c:30d:: with SMTP id a13mr152280ljp.386.1606255336916;
        Tue, 24 Nov 2020 14:02:16 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id o19sm25514lfd.250.2020.11.24.14.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 14:02:15 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] glossary: improve "branch" definition
References: <87blfnhm8w.fsf@osv.gnss.ru>
        <xmqq7dqbn1nl.fsf@gitster.c.googlers.com> <87im9vekzf.fsf@osv.gnss.ru>
        <xmqqr1ojlkng.fsf@gitster.c.googlers.com>
Date:   Wed, 25 Nov 2020 01:02:15 +0300
In-Reply-To: <xmqqr1ojlkng.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 23 Nov 2020 15:26:43 -0800")
Message-ID: <87r1oi1kig.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>>> But do we need to say "a separate line of development", instead of
>>> just "a line of development"?  What is "a line of development" that
>>> is not separate?  What extra pieces of information are we trying to
>>> convey by having the word "separate" there?
>>
>> I think it tries to convey a notion that 2 branches represent separate
>> lines of development. I.e., that the whole purpose of branching is to
>> provide support for independent, or parallel, or /separate/ lines of
>> development.
>
> So in the context of talking about a branch, there is no need to say
> "a separate line".  It only starts making sense to use the word
> "separate" whey you say "this is a line of development.  By the way,
> there is another line of development that is separate from the first
> one".
>
>> I'm not going to insist on the exact wording though, -- just wanted to
>> bring attention to the issue, and "separate" was somehow the first word
>> that came to mind when I edited the text.
>>
>> As an after-thought, I'd probably add that branch in Git is represented
>> by a chain of commits, and then I'd refer to most recent commit of the
>> chain, instead of most recent commit on the branch. That'd make
>> definition more formal and precise. Makes sense?
>
> It brings up a more serious issue, though.  
>
>          o---o---o---o---x A
>         /             \
>     ---o---o---o---o---o---o---y B
>
> The only thing everybody can agree on in the above history is that
> commit 'x' is at the tip of the branch A, and commit 'y' is at the
> tip of the branch B,

Yeah, sure.

> and 'y^' is on the branch B.

I'm not that sure about 'y^', sorry, even if it now has no other
references.

I'm only sure that commits not reachable as first parents from B are not
on the branch B, and that there is a chain, even if empty, from "Git
branch B" (through first parent) that constitutes particular branch in
the user domain.

> There is no good answer to questions like
>
>   where does branch 'A' begin?
>   where does branch 'B' begin?

There is: "it's undefined".

Why does it matter for definition of the term "branch"? I think it
doesn't. Glossary didn't define where branches begin, and it'd still
refuse to define it. What's the issue with that?

Where exactly given branch starts lies entirely in the user domain, not
in Git domain, so we don't need to define this in the Git glossary, I
think. We can mention why we left it undefined though, if it makes
sense.

>
> Perhaps the merge to 'B' was from another branch that no longer
> exists (because the whole 4-commit chain was merged at that point to
> the integration branch 'B'), and 'A' was forked from that branch
> whose name was forgotten.

Perhaps, but I can't see how it's relevant to the glossary. It'd be
essential if Git remembered on which branch which commit has been
created, but it (fortunately) doesn't, so it (fortunately) isn't.

> Any commit in the history represents a line of development behind
> that commit, and whether a commit is pointed at by a ref does not
> change that.

Sure. Moreover, user is free to consider this particular line of
development to be a "branch", in his vocabulary.

We do not call /every/ line of development "branch" in Git proper, or do
we? I'd say that in Git proper "branch" is not a line of development at
all, because Git doesn't care.

> And development is not even a line when you include forking and
> merging.

Development isn't. A line of development is "a line" by definition
though.

>
> In the mental model of Git about branches, I think the only one
> thing people can agree on is that a branch points at a commit, and
> checking it out and making a commit on top of it will change that
> branch to point at the newly created commit.  And this view supports
> the word "separate"---whether you have two branches pointing at the
> same commit or a different one, building a new commit on and
> advancing the tip of one branch does not affect the other branch.

So, as it does make sense, why don't we stick to "separate"?

> Come to think of it, the original "active" may not have been so bad
> a word to begin with.  It is misleading in the sense that "active"
> used in the original statement does not mean "currently checked
> out", but if we read it as "potentially active---can grow in its own
> direction", it does convey that each branch can (although does not
> have to) represent its own line of development.

I don't get it. "Potentially active" is not what is a distinction of the
"branch". Every commit is potentially active: "git checkout
<commit>" and grow new history out of it. Further, even current branch
could be inactive, so I still fail to see any reason to use "active" in
branch definition.

>
> So, I dunno.  I'd say just settling on the simplest "is a line of
> development" would be the easiest path for now.

Thinking more about it, this first phrase is entirely user-domain
entity, so we will have hard time to come up with strict definition
anyway, and "is a line of development" is as fine with me as "is a
separate line...", cause both have nothing to do with Git the program
:-)

Now, if we stay inside Git proper in the glossary, we'd need to get rid
of this first phrase and stick to what "branch" is in Git. And in Git
it's just a specific type of reference that (unlike, say, tags) follows
new commits. It's interesting that from this definition follows that we
may easily consider HEAD to be a meta-branch, that, in addition to
properties of other branches, first, defines the point in the DAG new
commits are to be grown from, and second, can point to another branch.

For what it's worth, here is description of the "branch", as I see it:

branch: /branch/ is the way to refer by name to particular line of
        development represented as a /chain/ of commits. /Branch/ is
        implemented as specific kind of /reference/, called branch
        /head/, that always points to the most recent commit of the
        branch /chain/ it gives name to. This most recent commit of the
        branch chain is referred to as the tip of the branch. Branch
        head moves forward along with the branch tip as branch chain
        grows due to addition of new commits.

        Git /repository/ can have an arbitrary number of branches, but
	your /working tree/ could be associated with at most one of them
	at any given time (the "current" or "checked out" branch), and
	special /reference/ called /HEAD/ points to the head of that
	branch in this case.

        Alternatively, /HEAD/ could point directly to a commit rather
        than to a branch head, in which case an unnamed chain will grow
        from this commit as additional commits are being made. This mode
        of operation is referred to as "detached HEAD", though for
        uniformity it could be regarded as being on "unnamed branch".
        You can still give name to this "unnamed branch" at any time thus
        turning it into yet another regular branch.


-- Sergey Organov
