Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169F3C38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 21:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEB80218AC
	for <git@archiver.kernel.org>; Fri,  8 May 2020 21:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSfT3Jus"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgEHVPC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 17:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbgEHVPC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 17:15:02 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A89CC061A0C
        for <git@vger.kernel.org>; Fri,  8 May 2020 14:15:02 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id f18so3136190lja.13
        for <git@vger.kernel.org>; Fri, 08 May 2020 14:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Jc3IpvvTBlPVrgq4vQjbYB/KA8rRJ7Y8GL5T5QnhOEk=;
        b=SSfT3Jus/zHwCEGE0tIWu66cUsuZIln11v4lTbxClHcSBvbxGImb98bEr5/WRyZHlh
         5uwDxA9uy4kWIs8u7NoFf5Ckgudp79YBSbYZ7TLCC97UHqg4C1lzvyPeVIKWD6rTdcWj
         xkDiYaZnzCtngeETpN0tEXjV89mXOpLgCMdFhSttAn1bwEkrlaTDGfXHFsXlOEAf5g+7
         Eo7Bz2cXe1mC0Q/gmoNQSMJTdDMYfrhxDQfWoqZavlSKA3zOwT5025A2i5IoUlswI1Xa
         HnpCTk92iGJHPlXtExEe7SqHhzl+y4iiqLIAGahB/SLRbHbyE6pqRk5a45PqkeigubX9
         e+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=Jc3IpvvTBlPVrgq4vQjbYB/KA8rRJ7Y8GL5T5QnhOEk=;
        b=Y3B1rtP4O3VRYfqQ5XAy1Wi04ioIqiwoeWSsGQPCf0rL6gQC+bW/gd+LOa4egjTXzh
         68oSS0C7PS37INaArsqnkKdtfVbZpE0EEXsYoHZVo1eMV6sFXfqEntLftMgIDl3jUS18
         0zEYePgQ2/FsAWqn5QP/ZIVGYzIZNU9fvexwz+BJXxZarvOzHM8V9HM/g1spO3837Nuo
         o//V+DT08R8TFIacuTVcfarUyZMwDzX85X0K7AS2TEeVSTdEYhawg864l4dFdoGJpVEQ
         DbjEEOW64czYtDupGZhv664LshjdY1skSPopEipHm2InkUNrntKc5UeIm/BeLMnPvmYv
         iuRA==
X-Gm-Message-State: AOAM532lbcAMpEokMQ4ZF7mkWTaPiK1Dq29r0WocbiaTaO0QfkRYaCK4
        Oy3zFnyhVNkXnREf65fOWPQ9V+Uc
X-Google-Smtp-Source: ABdhPJzD4N90JSUsTZT/jME2/TkDxXpQxIwtLb66MEzoN/XMHqlIMgVnnUdF2lFohF4NSiUORJJp8A==
X-Received: by 2002:a2e:9258:: with SMTP id v24mr2945424ljg.109.1588972500233;
        Fri, 08 May 2020 14:15:00 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id x204sm2142040lff.21.2020.05.08.14.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 14:14:59 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Solomon Ucko <solly.ucko@gmail.com>, git@vger.kernel.org
Subject: Re: rebase -i: quick/inline reword
References: <CANtMP6oKN6Ueu=fqFYv2VhUP5S-ifbSzPTARvbEg4eV0pcRcHw@mail.gmail.com>
        <87imh8m346.fsf@osv.gnss.ru>
        <20200508000538.GE7234@camp.crustytoothpaste.net>
Date:   Sat, 09 May 2020 00:14:58 +0300
In-Reply-To: <20200508000538.GE7234@camp.crustytoothpaste.net> (brian m.
        carlson's message of "Fri, 8 May 2020 00:05:38 +0000")
Message-ID: <87sggab031.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2020-05-07 at 10:49:29, Sergey Organov wrote:
>> It'd be really nice if it were possible to, say, search&replace in, or
>> spell-check, interactively, all the commit messages (including titles)
>> of a bunch of commits to be published, all in a single file handled by
>> single rebase run.
>
> It is possible to do this with a bit of shell scripting.  You can run
> "git rebase -x" if you want to check every commit in a certain way.
>
> If instead you'd like to modify all the commit messages, you can use
> something like this:
>
>   GIT_SEQUENCE_EDITOR="sed -e 's/^pick /reword /'" \
>   GIT_EDITOR="some-shell-script-that-modifies-its-file-argument-in-place" \
>   git rebase -i BASE
>
> I use something similar as an alias to automatically squash all my
> squash and fixup commits without needing to open an editor:
>
>   !f() { GIT_SEQUENCE_EDITOR=true git rebase -i --autosquash "$@"; };f

These are very good and useful features indeed, and they are examples of
batch processing that is very handy for automation, but lacks
interactivity. What I rather have in mind is being able to put all the
messages /simultaneously/ into my favorite text editor and edit them
more or less freely till I'm satisfied, then "commit" the overall result
by passing it back to git. Essentially "git rebase -i" on steroids.

-- Sergey
