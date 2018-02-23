Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40DD61F404
	for <e@80x24.org>; Fri, 23 Feb 2018 17:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751517AbeBWRDc (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 12:03:32 -0500
Received: from homie.mail.dreamhost.com ([208.97.132.208]:49722 "EHLO
        homiemail-a60.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751351AbeBWRDb (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Feb 2018 12:03:31 -0500
X-Greylist: delayed 48142 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Feb 2018 12:03:31 EST
Received: from homiemail-a60.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a60.g.dreamhost.com (Postfix) with ESMTP id 7402528206D
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 09:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mergebase.com; h=
        mime-version:in-reply-to:references:from:date:message-id:subject
        :to:cc:content-type; s=mergebase.com; bh=gBgpHDjyosBeYYGU3QKL4tI
        z6Vw=; b=oqOuzQaGG5HigYDewxlojX5ercrSpAAE25O/QAAJ5Bt9gRzDN/xp+jf
        s9SqtZ8rpLPOsk6vFFPuXqknPc8fHJQMVLcbvqpmo63FDY9WClxvKGDp7RNp21FO
        m5M7SNkfCY27Ca4kSYs6PX95Wby6/wp3pJk9lZYghULBaIVQRWYY=
Received: from mail-it0-f54.google.com (mail-it0-f54.google.com [209.85.214.54])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: julius@mergebase.com)
        by homiemail-a60.g.dreamhost.com (Postfix) with ESMTPSA id 64AA4282068
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 09:03:31 -0800 (PST)
Received: by mail-it0-f54.google.com with SMTP id w19so1540373ite.0
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 09:03:31 -0800 (PST)
X-Gm-Message-State: APf1xPBZPJ9cAkf2oeb4kv+/uADa3MbZdEnzUCAEyFehXsx+BzOzX/TK
        zQFe85nG8Sk9qgaSQacbPLXy6OSW7KirNZhIRQ==
X-Google-Smtp-Source: AG47ELsA8Wdknfa4dhJG2+r6QHZ8NYT4267KnM68ojcDZuSahiWf3uzmaW4I/tbvLZD9MC17SouL718/9Qkyy5Q61ek=
X-Received: by 10.36.39.7 with SMTP id g7mr3004621ita.55.1519405410735; Fri,
 23 Feb 2018 09:03:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.1.69 with HTTP; Fri, 23 Feb 2018 09:03:30 -0800 (PST)
In-Reply-To: <xmqqfu5sutrc.fsf@gitster-ct.c.googlers.com>
References: <CAA7Zk=tMMPE_Ov6cSJuzgYwWmTuMTSd_909c5JY3a2k5KFzHgQ@mail.gmail.com>
 <xmqqfu5sutrc.fsf@gitster-ct.c.googlers.com>
From:   Julius Musseau <julius@mergebase.com>
Date:   Fri, 23 Feb 2018 09:03:30 -0800
X-Gmail-Original-Message-ID: <CAA7Zk=smFOZ5+ThOZ9bfr8+UB_tD1371Oiy501sR=J4xjKdhsQ@mail.gmail.com>
Message-ID: <CAA7Zk=smFOZ5+ThOZ9bfr8+UB_tD1371Oiy501sR=J4xjKdhsQ@mail.gmail.com>
Subject: Re: RFC: git squash
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 22, 2018 at 10:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Julius Musseau <julius@mergebase.com> writes:
>
>> git squash [<commit>]
>>
>> Squashes <commit>..HEAD into a single commit. Replaces HEAD with the
>> result.  If not specified, <commit> defaults to the current branch's
>> upstream (a.k.a. @{upstream}).
>>
>> Rationale:
>>
>> This command provides an intuitive mechanism for in-place squash that
>> doesn't drop dirty merge results.
>>
>> We call this an in-place squash because the state of all files and
>> directories at HEAD does not change. Only the ancestory of HEAD
>> changes: its (only) parent becomes the merge-base of <commit> and
>> HEAD, removing all intermediate commits.
>
> So is it essentially the same as
>
>     git reset --soft $(git merge-base $commit HEAD)
>     git commit
>
> with some icing for coming up with a default log message?  The above
> won't touch the working tree at all.
>
>

Yes!  I had no idea about this approach.  Thanks!  My implementation
uses "git commit-tree".

Yes, some icing to build the squashed log message, as well as some
protection to ensure the working tree is clean before doing the squash
(just like "git rebase" does).

I'm also working on two more pieces of icing:

- Adding an "--oldest-author" flag to help adjust the author for the
squashed commit (using the author value from the oldest commit in the
squash).  By "oldest" I mean whatever "git log --reverse --no-merges
-1 <commit>..HEAD" spits out.  (I don't consider timestamps.)

- Ability to arbitrarily squash any branch by taking a 2nd "branch"
argument.  (And making the command work with bare repos.)

I'm embarrassed to realise your approach matches the top-voted
stack-overflow answer on the subject:
https://stackoverflow.com/a/5201642

Nonetheless, the top-voted stack-overflow comment to that answer says:

> Ha! I like this method. It is the one closes to the spirit of the problem. It's a pity that it requires so much voodoo. Something like this should be added to one of the basic commands.

Should I proceed?
