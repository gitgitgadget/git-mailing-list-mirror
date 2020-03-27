Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1619DC2D0E5
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 15:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D637220748
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 15:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgAfaIBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgC0Pqq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:46:46 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:53243 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgC0Pqq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 11:46:46 -0400
Received: by mail-wm1-f51.google.com with SMTP id z18so11906432wmk.2
        for <git@vger.kernel.org>; Fri, 27 Mar 2020 08:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uxXxH47oAR3X0Z5raa7xlCJn6UMyUcB+jTbZCu/bWRw=;
        b=OgAfaIBLP9CR/cSqrKTzS5hEmRLoDTrblPhdvYezQXTI8lcp2W2LVWO5ywiCXtZCYv
         XEXBHiVdK0qzunWhxAqVgm2k+c++IRvZuiLQZ5LpNPc9/gLRQEd2mZpxfUPJrqzQYRwU
         pMe/PC+xi915GlZbqfqsTI5q3BQT/SqfRW2rh8k6kAhQXloka50Kv4tt3cKpZTlVoXAL
         UbUzXxLfFvDQ/UVtQvLRUbnQvRHM9sKxqWPhhE09nubM3mJkhyBw5LuKl7pEowRs15YW
         wo1NiaNTzTCVLN+ArfzKnIkr2+eFgy4+9gkww3TvEt1zjOqz+cJXAivYr+6O2dt194Ny
         tMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:cc:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uxXxH47oAR3X0Z5raa7xlCJn6UMyUcB+jTbZCu/bWRw=;
        b=EmeZHwZhCWixS4DXq53BlwLNDxKQVFqDFFdGzKPKdxWEFsoBY2JgpM+EaB9UzYDS62
         7VdgaEj3XLdzgocVMiXsdb6BKIDtVl//UBoc7XyA1caq7QDBWQREnMBa8VUao/m81/Cv
         4nX5o7UykeA5D0gxBMqCACqOtn1cjRYp1B1Wax7wjLAnImS+SMKX0aRbtxhjerpBdI5h
         OhnpR7Jh10BDcz/yeL19wKnWINEdtyFWU6p+CHNOhFxP9vEQpKetd59rrS58E7L9USKB
         bzvpcfNgKtWB4Ki9QitjXU1wMs7+gZc6Q0vQBQMexwThJbyq7OSzqYmwpykGHT/pTGxO
         omgA==
X-Gm-Message-State: ANhLgQ2UcqtMuXxjp4kHHcXhh4+jvNZcx22GE2BA9wkL2pjxhTLzkMnW
        OhNAHHd3mNtzFxpEPP43Lqk=
X-Google-Smtp-Source: ADFU+vtQH8e8K7AOQ0oPbdGLeVBoFrd7G5w50XwCHQr7KbRYx4r8TowJJmJKqiLL7MmwvajRLyL9Qg==
X-Received: by 2002:a7b:c252:: with SMTP id b18mr5761997wmj.135.1585324003081;
        Fri, 27 Mar 2020 08:46:43 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-654-1-428-45.w2-6.abo.wanadoo.fr. [2.6.211.45])
        by smtp.gmail.com with ESMTPSA id i2sm8693909wrx.22.2020.03.27.08.46.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 08:46:42 -0700 (PDT)
Subject: Re: git rebase fast-forward fails with abbreviateCommands
To:     "Jan Alexander Steffens (heftig)" <jan.steffens@gmail.com>,
        git@vger.kernel.org
References: <9b4bc756764d87c9f34c11e6ec2fc6482f531805.camel@gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <a3cc46ca-824d-8cab-e333-83f51a7824ca@gmail.com>
Date:   Fri, 27 Mar 2020 16:46:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <9b4bc756764d87c9f34c11e6ec2fc6482f531805.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jan,

+cc Johannes, Elijah, and Phillip.

Le 27/03/2020 à 12:44, Jan Alexander Steffens (heftig) a écrit :
> Hi,
> 
> Since 2.26.0 a simple "git rebase" fails to fast-forward a
> branch, reporting "error: nothing to do."
> 
> It started to work again after removing my gitconfig. I've
> reduced it to the following:
> 
>     git init foo; cd foo
>     git commit --allow-empty -m foo
>     git commit --allow-empty -m bar
>     git checkout -tb foo
>     git reset HEAD~
>     git -c rebase.abbreviateCommands=true rebase
> 

Thank you for reporting this bug.

Since git 2.26, the default rebase backend switched from "am" to
"merge".  So, by default, a todo list is created, even if you can't see it.

In this case, the todo list contains only a `noop', but this command has
no short form, and is abbreviated with a comment mark.  As there is no
more commands in the list, the backend will fail with the error "nothing
to do".

Three approach to fix this:

 1) add an abbreviation to `noop';  this is the simplest fix, and "n" is
not taken.
 2) if a command has no short form, do not abbreviate it;  this is
trivial to do, and should not break anything.

A third approach would be to change the meaning of an empty buffer, but
this would break some tests (at least t3404.3) and cause more confusion
for users than necessary.

Thank you again for reporting this.

Cheers,
Alban

