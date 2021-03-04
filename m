Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEFFC433DB
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 22:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E3BE65009
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 22:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbhCDWtD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 17:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbhCDWtD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 17:49:03 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E590FC061574
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 14:49:01 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id h22so28998214otr.6
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 14:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TFuNvwGHEgacFqyKkkQacUCLY9wI/sFcemhvITcJJpU=;
        b=ToAyrr6KSuqqpYQLgcy3eKrixS2SKhevc46HHnvInwiKQgYd0zq/R1CAYD2lItZP98
         Ehgc2gQp7lbiEnSEttQMW3SZnJ1JjwZQuwpcH7B9veOYB1npAL/FCeAmDcumWCmFOnBX
         Tfxt92NPJqj7fcDWMdIMkIX8i+APMGU+qOmsgwPNR7IK38ujjP1vdgjgyg/F37JBRAT9
         zWzN/TMuRKcLntjdMBSHCGslGQa39VxVVhMB+y7VTBlr8S7nI/x4iIkR3/vXLB3PPIXh
         L844HRH6BBK6qkf4r6Z0/Bs/14RQICMYfzzIRg1feHfeAIJHpIYjKYFW9yLm6bxjSs/d
         Zt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TFuNvwGHEgacFqyKkkQacUCLY9wI/sFcemhvITcJJpU=;
        b=V6rM7aNmLK4LPX9AcTQ55kMepHs7DOLmKDlk/OF/HN+i+oCeNqFovqcW7ueYkzWWrK
         1s4F8Ukcd9IBFWrJlZJ8LUzC3aFDjz5LW6kf1/R9LDYNdbkfHPugWXXYfn6hMGRHTu2O
         QNsHzEqKMPyqdhuvZocgbDI1vZ2vGd58E7QKVqQIAGSLHGVzACKl/0Yl9DCPA5YFRWJY
         g42dTKQFOCrajFC1wzO/8gTG9Dl/v6LgPNvC9tynNBA8gdVDW7Nt7gDkcmYxieKrkBz8
         lTqUuB6YgihVP1p8jYeORRxSkJEydrl0435ZV0qPGyCRam7aBzRFdMZmo7v65V4aDkKM
         AhDg==
X-Gm-Message-State: AOAM530TsRcuQH3T4/8jpGuLReVFxwTEao6JMKOhznp8XBvjBh/GOowE
        zjJV2ptOn7rRum+/oW+6+3dWz3og12UwTTTTRfw=
X-Google-Smtp-Source: ABdhPJxxZMzLKsuIyWq8mB8cqDJ5VjKFA/3Q3B6dEdRl2OYsHqEp8a/Ulpox50+dNNO1hCE8tp8ykuDFHq1J3CjX+r8=
X-Received: by 2002:a9d:7459:: with SMTP id p25mr5303553otk.316.1614898141395;
 Thu, 04 Mar 2021 14:49:01 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BEpnaR1tydJ-vcWAUYnT-TFcfCMMqwbmOz1Dx+nvsHZMQ@mail.gmail.com>
 <20210304152315.18498-1-matheus.bernardino@usp.br> <CABPp-BE9QA5RAwdebmAyK3b3wh1mGE+NF7sPS5RCf4FogYBV7A@mail.gmail.com>
 <xmqq5z26eime.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq5z26eime.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 4 Mar 2021 14:48:50 -0800
Message-ID: <CABPp-BE7kOuGdF0hyMYhUW_Ts+wniAaM+EKU+h65RD-_wkmVTQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] add: warn when pathspec only matches SKIP_WORKTREE entries
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 4, 2021 at 1:03 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > I think it's kind of lame that git-add won't provide a warning for
> > ignored files when the match is via glob/pattern; if git-add didn't
> > end up adding anything, but an ignored file was matched, I think a
> > warning is appropriate.
>
> I am not so sure.  When I have this in my exclude list:
>
>         tmp-*
>
> and have this file in the working tree:
>
>         tmp-000.txt
>
> I am not sure if I want to see any such warning when I did
>
>         $ git add "*.txt"
>
> After all, I said that I never would want to worry about anything
> that begins with "tmp-".  It would be a totally different issue if I
> did
>
>         $ git add tmp-000.txt
>
> as I am contermanding my previous wish and saying that I care about
> this particular file, even if its name begins with "tmp-".
>
> So far, the flow of logic is simple, clear and straight-forward.
>
> BUT.
>
> What makes the whole thing tricky is that people don't do
>
>         $ git add "*.txt"
>
> The instead do
>
>         $ git add *.txt
>
> and "git add" cannot tell if the tmp-000.txt it sees is what the
> user meant, or what the shell expanded.
>
> If there were no shell glob expansion, then "warn only if a
> glob/pattern did not match any" would have been an attractive
> option, especially when we had another file in the working tree,
> say, hello.txt, next to the tmp-000.txt.  Then
>
>         $ git add "*.txt"
>
> would add only hello.txt, and we won't see a warning about
> tmp-000.txt.  But end-users will use shell expansion, i.e.
>
>         $ git add *.txt
>
> (1) warning against tmp-000.txt because the command line named it
>     explicitly (from "git add"'s point of view, but never from the
>     user's point of view) would be a disaster.  I think that is why
>     your suggestion was "if git-add did not add anything then warn".
>     but ...
>
> (2) not warning, because the command line named hello.txt as well,
>     i.e. "git add" added something, would make it inconsistent.
>     Whether there is another file whose name ends with .txt, what
>     the user typed (i.e. *.txt) to the command line is the same, and
>     the exclude pattern (i.e. tmp-*) is the same, but the presence
>     of an unrelated hello.txt affects if a warning is given for
>     tmp-000.txt.
>
> So, I dunno.

Fair enough.  All the more reason to leave it out of Matheus' patch
series, then.  :-)
