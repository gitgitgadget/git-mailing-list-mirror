Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98591C61DA4
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 22:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjBFW3z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 17:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjBFW3f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 17:29:35 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFC511EAD
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 14:29:15 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id v3so9231425pgh.4
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 14:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hfzH5eT5zoGdIoXIwKVykwTpNhHjD/vbBLM/EyZYJ8s=;
        b=VVtn1TDC5/snFjF92GuzbO0bTuCBbJdMvW9X9P2SCyQLUzJPtWaiC/9ZjOO9+HoY7x
         QQp85SegLDh2YIzclQbfdjQqbTng4tvbjRtYRGvFe9qgUFS6XkK0P09T4ke6YuOKbfJI
         0HR38GrJIEaYYdTg5HeDbOv1x4qEM4itbSunPpmy20YAzF6z+E2JVYga1nTDNiEQomVZ
         nT4lafFvf8tiyw5cnNT5kGyB7sYz9nw0FkARCI4utshqlIu62uPt7xi5XOk4DNAcI9xp
         0jwytz+SgRJotrsEKbmucnG6GPYyCrEn6Gn+U/AdSK3J0ssZ4R2yMTREz2Q9i8DHohrr
         6Lcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hfzH5eT5zoGdIoXIwKVykwTpNhHjD/vbBLM/EyZYJ8s=;
        b=CV2awQTTv7igflbqmwMqAdRr0vyURG7B50Y1q9uVXIPy3C25SWKz+PS94GUNi/CLy8
         IrtNrC9pw+sp3CJ3j5XAyfN/SlY0C19NV/MQtTyV5p/Ymx6wnhDHYIxFACse5H7jSBWa
         u1nVBSNbfKrbk/9kzUKaCZG2p2zU+bYVXCLWNJ5hgKxQNdb7GM0rS89BQ0uZspRlYPNo
         A80nX2xc1cteQUfVt66WHIypzGagAHlUgYxb93jz786pyLch+RMIrMXvKCjmOlRLZu8W
         pSLvxBFGHobyZ3O1FvuqH0JO231rQ6wBS+Kk2Stq8Gc75MZCEeCbyo2xKKKZV4V73Lc0
         Fvpg==
X-Gm-Message-State: AO0yUKUXpCsZC2C+q2YUOyaA70A1DoZW+oMUDExsMZv7aJ60+z335nxN
        9xhv4NsLsixUjNHNsTSnGto=
X-Google-Smtp-Source: AK7set80zfLGNT3q63nQ6OaT/sas9BOBP58phsQDroeXolc66eF/8khqnGpevgzPrj320g5QJ9372g==
X-Received: by 2002:a62:6101:0:b0:575:b783:b6b3 with SMTP id v1-20020a626101000000b00575b783b6b3mr863721pfb.28.1675722543925;
        Mon, 06 Feb 2023 14:29:03 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id z8-20020aa79e48000000b00575d1ba0ecfsm7629137pfq.133.2023.02.06.14.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 14:29:03 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] bisect: fix "reset" when branch is checked out
 elsewhere
References: <1c36c334-9f10-3859-c92f-3d889e226769@gmail.com>
        <ada28944-6e9e-d4e7-74c9-ffadaf406e1f@gmail.com>
Date:   Mon, 06 Feb 2023 14:29:03 -0800
In-Reply-To: <ada28944-6e9e-d4e7-74c9-ffadaf406e1f@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Sat, 4 Feb 2023 23:57:14 +0100")
Message-ID: <xmqqwn4u2ztc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rubén Justo <rjusto@gmail.com> writes:

> Since 1d0fa89 (checkout: add --ignore-other-wortrees, 2015-01-03) we
> have a safety valve in checkout/switch to prevent the same branch from
> being checked out simultaneously in multiple worktrees.
>
> If a branch is bisected in a worktree while also being checked out in
> another worktree; when the bisection is finished, checking out the
> branch back in the current worktree may fail.

Sorry for asking possibly the same question again (which may mean
that the phrasing of this paragraph is misleading), but isn't it a
good thing if in this sequence:

 - I checkout 'main' and start bisecting (BISECT_HEAD says 'main');

 - I then checkout 'main' in another worktree; I may even make a
   commit or two, or even rename 'main' to 'master'.

 - I finish bisection and "bisect reset" tries to take me back to
   'main', which may notice that 'main' is checked out in the other
   worktree, and fail.

the last one failed?  After the above sequence, I now have two
worktrees, both checking out 'main', and it is exactly the situation
the safety valve tries to prevent from occuring, no?

Or is the new behaviour considered better because the third step
would try to check out 'main' that is checked out elsewhere only if
the second step was forced, so the person who decided to touch
'main' in another worktree should already be aware of the risk and
we should disable the safety valve in the third step automatically?

I am not sure if that is a sensible argument, but if that is the
case, let's spell it out in the proposed log message.

Thanks.

>  builtin/bisect.c            |  5 ++++-
>  t/t6030-bisect-porcelain.sh | 23 +++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/bisect.c b/builtin/bisect.c
> index 7301740267..46fba8db50 100644
> --- a/builtin/bisect.c
> +++ b/builtin/bisect.c
> @@ -244,7 +244,10 @@ static int bisect_reset(const char *commit)
>  		struct child_process cmd = CHILD_PROCESS_INIT;
>  
>  		cmd.git_cmd = 1;
> -		strvec_pushl(&cmd.args, "checkout", branch.buf, "--", NULL);
> +		strvec_pushl(&cmd.args, "checkout", NULL);
> +		if (!commit)
> +			strvec_pushl(&cmd.args, "--ignore-other-worktrees", NULL);
> +		strvec_pushl(&cmd.args, branch.buf, "--", NULL);

OK, so this time around "git bisect reset" to go back to the
original branch gets --ignore-other-worktrees but "git bisect reset
HEAD" or other forms that names a branch still gets the safety.
That makes the blast radius smaller, but I am not 100% sure if
loosening the safety is a good thing.
