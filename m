Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5950C77B7F
	for <git@archiver.kernel.org>; Thu, 11 May 2023 16:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238830AbjEKQ0a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 12:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238820AbjEKQ02 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 12:26:28 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D032FB
        for <git@vger.kernel.org>; Thu, 11 May 2023 09:26:26 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-643b7b8f8ceso4589189b3a.1
        for <git@vger.kernel.org>; Thu, 11 May 2023 09:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683822386; x=1686414386;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1eSuOvxLbRRmjQ8rtMlhODT/q6I9rHcZVev9u6xCCXY=;
        b=cQParwBNJYD3Hsls8zuApvRH0X9fH7mvdPP7roE2IVJpyTwhB105AKU2n1BKNqIeMh
         kf6W42OVNW8M75bOt0UVILRx1X8EmthpBk0osdDOLgheGEOeKglrVFG9tNS5PbBl7w+H
         +pIV5qoLXIpMv7EnpC9LMzSQcSaWNoSALGgf+SPpVXPee2lv8comiTd20aoMbrlrfU2d
         fiLB5gU2W97Eb7Ab3Dy62A/VKaUt/EXB17gBzmWbpJcoRvNfWkXzjfFhHVuxgoRTC3mj
         6miVkGAoyy6tQP+pEARF3tAaxenaEmL6SpR3Q25hrybdU/PFPjghVUHUDlimdbtZdM5C
         h2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683822386; x=1686414386;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1eSuOvxLbRRmjQ8rtMlhODT/q6I9rHcZVev9u6xCCXY=;
        b=IR3K/x5J9NdfsGCh/6HmeRRtY8F+lJFbHkCHC9a4+v8jZ9BX+UkphC4VGvWwKun5+Z
         8XU4qmbQXYHONbJh1MJZ1K7eW0qW3l9Dk0LUdF41nT/S5YZ6WJSnxDpCAyaH1T7a1/Pz
         3FgKOtkvEn3FSugySR2z1idH1YpVg2EvaYp0mnros/Xk30eUuXnZHyNBbVS6n7q0hw1Y
         rxYEJjjAnW7/nWi73Sw78rtgH/1v3XzbdxXRl9GuWrPRc3B8feMm/2pBEciYZLuM17YI
         LssBL60h6o1FDFlO6bp5CR+6yXsh9dt1q9rS3lWCJQr6imXi4lotrfbS2/Sfm05+h5Iw
         Gjtg==
X-Gm-Message-State: AC+VfDyIP2FI51JuZNCz+Ri6egzjIau+njn0vQ8jFbnlZYRvhybURaaz
        WtzgY/PJR0i5vAkM6lhBz/0S7pIIUOY=
X-Google-Smtp-Source: ACHHUZ7IvwhBxdykdYQNpb/BAbbfnL0s4qEsIYBXcougn2v5/nDRTbd2tX5GoJrm2HeaEJOahRYB7w==
X-Received: by 2002:a05:6a00:198a:b0:643:791b:892d with SMTP id d10-20020a056a00198a00b00643791b892dmr27151947pfl.18.1683822385760;
        Thu, 11 May 2023 09:26:25 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id e5-20020aa78c45000000b00640defda6d2sm5449676pfd.207.2023.05.11.09.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 09:26:25 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Matthieu Moy <matthieu.moy@univ-lyon1.fr>
Subject: Re: Can we clarify the purpose of `git diff -s`?
References: <645c5da0981c1_16961a29455@chronos.notmuch>
        <871qjn2i63.fsf@osv.gnss.ru>
Date:   Thu, 11 May 2023 09:26:25 -0700
In-Reply-To: <871qjn2i63.fsf@osv.gnss.ru> (Sergey Organov's message of "Thu,
        11 May 2023 14:59:00 +0300")
Message-ID: <xmqqpm76ygum.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> That said, there is another mystery in the diff interface as well: why
> do we have --patch-with-raw and --patch-with-stat, yet no
> --raw-with-stat, --numstat-with-shortstat, --patch-with-numstat, etc.?
> If, say, --patch turned off everything except usual diff output, then
> these combinatorical options would make sense, but currently they don't.

I can explain the mystery but the explanation may or may not justify
it, depending on how lenient you are to developers of old days, with
less experience than they have today ;-).

Back when we started, "--raw" was the only thing there, and then we
were to pass the raw-to-patch external filter, when you wanted a
patch output.  I then updated this arrangement to work in a single
process [*] without having to produce textual hexadecimal output
(raw) and piping it to another process, and that is how "--patch"
mode was created [*].

After I added "--patch", without having foresight of the risk of the
combinatorial explosion, "--patch-with-raw" was born.  "--stat" and
other niceties came much later, and made me finally realize the risk
of the combinatorial explosion.  "--patch-with-raw" stopped gaining
siblings as a consequence.

Yes, I was slow and inexperienced, but one has to do with the
capability one has at the time.

> Finally, there is another intrinsic problem in current Git CI: the
> "defaults to" part, as in "git show" that defaults to --patch for simple
> commits, --cc for merge commits, etc., except that it doesn't behave as
> if these options were explicitly provided at the beginning of the
> command-line.

Yes, as you said in your message after this part, this is pretty
much deliberate and is done for the sake of usability.  Essentially
the logic is to achieve two distinct goals:

 * we want to be able to combine the basic things like --patch,
   --raw, --stat to specify exact format (but some things may not
   mix well with others).

 * when the user does not give a specific preference, we want to
   give a reasonable default.

So, when the user wants "--stat", we do not want to combine it with
"--patch" that the user may have gotten by default if they did not
give "--stat".  If we implemented the default logic like the way (I
guess) you are suggesting, i.e.

 * there is a default set of options, "--patch".

 * the user can add or subtract options with "--[no-]foo" where the
   value of foo may be patch, stat, etc.

it would turn it to "--patch --stat" if the user gave "--stat" on
the command line.  The user needs to say "--no-patch --stat" if they
want to see only the diffstat (which by itself is not necessarily
bad; if it is more common to want --patch-with-stat than --stat, it
may even be better), but the bad part is that the user need to
remember what the built-in default is.


[Footnote]

* Not exactly a "single process"; until Linus imported xdiff
  machinery to make the textual patch generation in-process, we
  forked "diff -u" as a subprocess inside "git diff-*".  But the end
  user no longer had to construct the "git diff-files | raw-to-patch"
  pipeline themselves.

* Eventually it would become the in-process "diffcore transformation
  pipeline" to compute diff_queue, which is a moral equivalent of
  the input to "raw-to-patch filter", then transform the result of
  the previous step (e.g. rename detection) and then format the
  result of the previous step into various output, but none of that
  existed back then.
