Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA46C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 20:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7C5D6105A
	for <git@archiver.kernel.org>; Thu, 20 May 2021 20:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237689AbhETUk4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 16:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbhETUky (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 16:40:54 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6019C061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 13:39:31 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id q7so25069714lfr.6
        for <git@vger.kernel.org>; Thu, 20 May 2021 13:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=L9ZloDnzbnZ69vN6gh8JGmDN0+ZNgTjeJ/DeckNw7Uk=;
        b=tZr7/HMZUklT7pPuFBIe7920k3Y2YTyac5mEhgAceBfP0CutSoeizLPkv+b9KP/EnA
         qsEumNF+cjCLrRp5yY3WHz6prsfbqVG2jX31wTHpT1N87dfx9I7WHPM5GVAtgi6SZpIF
         uon9clilKTx6vSHuRftkNsHr0Az5x0qrO9TfcZ7vAw2r+GuKbaY0SFsRNP0EKYTcnepp
         CM6HMGEX5APsj5FO2ln6C8LYgUVnJo/DDbhCmqhcBbhEWbziJXnZ5fBWOe4hZALXfJY6
         /WEwMJlp71r+M4i8nLdhVHhO+LyCifk+tADvZQXAqFMMb45aTS9a1Uht30AMPHAszhdU
         ud3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=L9ZloDnzbnZ69vN6gh8JGmDN0+ZNgTjeJ/DeckNw7Uk=;
        b=LXqeN3j9NX+ibwu81/Htq4zMuw6FYS2HQJhWsL7VidAlC3f08cy+Ufl1RqbWQU7aiW
         4RAZy4HWFg7GesFwiXn3xn8EihuqEHOFhBgTAzyXGdXghYhjzoRWD9ftrIcQKUkwBL7R
         o//glg5H0qNrELgweVYZh+VnJ9DIoXDdRhLm3pvIpVgpVQUA8CRJLZtJNtAsNmfmHpNz
         8IXRP4m+Xk3Aqh/fCCouFn9qaeEibFncKRPfnh3GQNwcXg3EErMj25EmexNhgXWNIooa
         Tq20opAgYJQny66ia/ub44faL3Q5ZANDo5H8RmqzRP7yNstRpNqurjLj8ZUf800KlHkl
         yQMQ==
X-Gm-Message-State: AOAM530MXaXAdNF6CqlWVs2ipSET1iuJNMgJnIwC9SFKKYbp7Eh/Vwll
        InHiN5frNtXy32B8afERGw+4oG85cgo=
X-Google-Smtp-Source: ABdhPJwpz3jQVYHnbrtPyBOjaG5oV5M4TFFM6Ky1WrlXBqx48ZYQDFUoE0DqDxx5wjgN6C7CEmL19w==
X-Received: by 2002:a05:6512:b1e:: with SMTP id w30mr4440197lfu.292.1621543169872;
        Thu, 20 May 2021 13:39:29 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id z10sm396773lfq.45.2021.05.20.13.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 13:39:29 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 6/6] diff-merges: let -m imply -p
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210510153451.15090-1-sorganov@gmail.com>
        <20210510153451.15090-7-sorganov@gmail.com>
        <xmqqsg2toqik.fsf@gitster.g> <xmqqo8dhool7.fsf@gitster.g>
        <87v97pv04p.fsf@osv.gnss.ru>
        <CABPp-BEwp5bWWaBkv-G+OAJgd+pcsB=GoMCBd+gnhK5JAAnFgQ@mail.gmail.com>
        <YKWG0jgYXAnKUJNR@google.com>
Date:   Thu, 20 May 2021 23:39:28 +0300
In-Reply-To: <YKWG0jgYXAnKUJNR@google.com> (Jonathan Nieder's message of "Wed,
        19 May 2021 14:44:50 -0700")
Message-ID: <87sg2h9m2n.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi,
>
> Elijah Newren wrote:
>
>> Interesting.  I have a strong preference for --diff-merges=remerge
>> (yeah, I know it's not upstream, but it's been ready to submit for
>> months, but just backed up behind the other ort changes.  Sorry, I
>> can't push those through any faster).  I've had others using it for
>> about 9 months now.
>
> I agree.  The --diff-merges=remerge behavior has also been the default
> in Gerrit since time immemorial, and when I first started using Gerrit
> it was one of my favorite things about it.

Due to previous set of diff-merges patches you now can set
log.diffMerges=remerge and have fun having it as the default for "-m" in
pure Git. I've introduced log.diffMerges exactly because I do realize
that different people and different workflows might have different
preferences here.

> That is because it shows the human content of the merge: it shows
> exactly what changes were made after the automated part was done.

No, in fact it shows what additional changes were to be made if the
merge had been achieved using particular automated merge algorithm you
apply right now. Provided you utilize no external knowledge, you have no
idea how merge has been in fact achieved, as core Git (fortunately)
neither cares nor stores such information.

Contrary to your view, and I believe more inline with Git core
philosophy, I (usually) don't care *how* particular changes were
achieved, I rather care *what* they are, so pure diff to the first
parent is the best basic format for me. Only if I need to see *why* the
changes are this particular way, I'd use advanced tools and formats to
get to the best *guess*, and that's where these advanced formats get
handy.

In other words, for me merge commit is mostly *commit*, and only then
it's *merge*: "here are the changes, and, by the way, here is where
these changes came from."

That said, please don't get me wrong: I'm all for advanced features such
as --diff-merges=remerge, as I do understand how and when they are
useful, I just personally won't make them active by default.

>
> I don't have a strong opinion about what the default for -m should be.
>
>> I think --cc is a lot better than -m for helping you find what users
>> changed when they did the merge, but I agree the format is somewhat
>> difficult for many users to understand.

I do have strong opinion. --diff-merges=1 is the only sensible
factory-default. Not only it has no implicit assumptions about how given
commit has been achieved, it's also the only format even entire Git
newbie might already be familiar with.

Then, --cc and I suspect "remerge" too, give exactly empty output most
of times, that'd cause even more surprises when one of them is the
default: you enable diff for merges, but still get nothing. OTOH,
--diff-merges=1 will give empty output if and only if given commit
actually brings no changes to the branch, exactly as any commit out
there. No surprises at all.

Principle of least surprise is still a good thing to follow.

Thanks,
-- Sergey Organov
