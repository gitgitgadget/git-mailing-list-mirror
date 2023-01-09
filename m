Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6710C5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 04:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbjAIEjW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 23:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237034AbjAIEio (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 23:38:44 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC39311C3D
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 20:35:23 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id o13so4036991pjg.2
        for <git@vger.kernel.org>; Sun, 08 Jan 2023 20:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QE42tp5V7b4S+K11oteQmA5SVwJlaUWQwLHnsBk9kUg=;
        b=Y7TNV5WXIIXkKivGHAA5aya/frwvnTXMgX1psniCY8pdZApDNL+xuxXuWQ4szimY9D
         l8LCQWOg9VIjkrMfdlIFqX7Gq4s0z8kiFdtKzzvLauayeO4pJr51kq1R8hBpXNkruxv6
         +tVu+bDcqqQz7fi8+Mf66qCzhLNEeZya/qHITtrVGWIoicvqkYP+n1QPTzU41Yhts63i
         LfS0r3IEDmKQ4pEwR4PuRqfSFwuQIW4KCVhcHJcP1iBONBx7cxdNiilArN2zMxL7iK4+
         MapklX/03J+lgu+EcLLns2uTf7cSQG3pbO6AbEpJq000ZXtYPGLamKL2vK9v5/Wqu2eq
         OfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QE42tp5V7b4S+K11oteQmA5SVwJlaUWQwLHnsBk9kUg=;
        b=W5YMm66GR3+Pu2Lih5x4vkRSieOz+pS/QnUoESlmt3NXROmsq4aQouplKy0PRWj7Hs
         DaSyeUxuYNdRnH2V2FSApvlREQbNGCBZuyaGb1/hVJX+KJaeJ4m9WHZOOoXSLiAKm4oc
         s5q9vUuJOTmBIBvI4FIjj4OiRDr6RaXc8y+kYp5gyPgf+JEwkCvFJVCK2aN7swdiGP34
         rJofbbBNpMc85Rw4OFLxuKz1VforjDBbtrAgp3rl2F/fM7OvO6Bd+9xa8CYzmNoA4bn8
         toam+sWO6i982Lad7n7ptgX6KloW0Lj5kECV88gQP3WR9dTVsHMvTQ3xidtrfDTvpLZe
         rZeg==
X-Gm-Message-State: AFqh2korPxdPPVdJKR8swUBXjAWJvleUenzAUmuIkA38O9canH5+i9s6
        sXaEbvEhctkB2B7tjuPanr4=
X-Google-Smtp-Source: AMrXdXs8wfeu6wfYmd3K93Gm6wzNSjV6T6KyJkZ8hswwa7wzU8JkEzmzmUWZ47CFwB/ckOGktF2QTw==
X-Received: by 2002:a17:902:978f:b0:189:6f76:9b61 with SMTP id q15-20020a170902978f00b001896f769b61mr135010plp.39.1673238923243;
        Sun, 08 Jan 2023 20:35:23 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902e80500b00189529ed580sm4980249plg.60.2023.01.08.20.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 20:35:22 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Julien =?utf-8?Q?=C3=89LIE?= <julien@trigofacile.com>,
        Barret Rhoden <brho@google.com>,
        Michael Platings <michael@platin.gs>
Cc:     git@vger.kernel.org
Subject: Re: Ignored commits appearing in git blame
References: <b1051e73-e663-82bf-bda6-015e64102248@trigofacile.com>
Date:   Mon, 09 Jan 2023 13:35:22 +0900
In-Reply-To: <b1051e73-e663-82bf-bda6-015e64102248@trigofacile.com> ("Julien
        =?utf-8?Q?=C3=89LIE=22's?= message of "Sun, 8 Jan 2023 10:27:37 +0100")
Message-ID: <xmqq5ydgwcj9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Julien ÉLIE <julien@trigofacile.com> writes:

[jc: redirecting to those who touched "blame-ignore" topic in the past]

> Hi all,
>
> I'm facing an issue with the use of "git blame" which shows commits marked to be ignored.
>
> We have a .git-blame-ignore-revs file that can be retrievable at <https://github.com/InterNetNews/inn/blob/main/.git-blame-ignore-revs>.
>
> The Git command line I'm using is:
>     git blame --ignore-revs-file .git-blame-ignore-revs radius.c
>
> Here is an extract where commit 36944f2b16 appears at line 59, though it should be ignored (present in .git-blame-ignore-revs):
>
> 8e3e288fec (Marc G. Fournier   1998-12-29 13:19:05 +0000  50)     int radport;
> 8e3e288fec (Marc G. Fournier   1998-12-29 13:19:05 +0000  51)     char *lochost;
> a9d899ddbe (Russ Allbery       1999-11-29 01:40:47 +0000  52)     int locport;
> 8e3e288fec (Marc G. Fournier   1998-12-29 13:19:05 +0000  53)
> 8e3e288fec (Marc G. Fournier   1998-12-29 13:19:05 +0000  54)     char *prefix, *suffix; /* futz with the username, if necessary */
> 9f21a39f37 (Katsuhiro Kondou   1999-06-12 09:33:48 +0000  55)     int ignore_source;
> d65e228465 (Jeffrey M. Vinocur 2002-03-14 07:27:00 +0000  56)
> d65e228465 (Jeffrey M. Vinocur 2002-03-14 07:27:00 +0000  57)     struct _rad_config_t *next; /* point to any additional servers */
> 8e3e288fec (Marc G. Fournier   1998-12-29 13:19:05 +0000  58) } rad_config_t;
> 36944f2b16 (Julien ÉLIE        2021-10-31 10:04:59 +0100  59)
> d65e228465 (Jeffrey M. Vinocur 2002-03-14 07:27:00 +0000  60) typedef struct _sending_t {
> d65e228465 (Jeffrey M. Vinocur 2002-03-14 07:27:00 +0000  61)     auth_req req;
> d65e228465 (Jeffrey M. Vinocur 2002-03-14 07:27:00 +0000  62)     int reqlen;
>
>
> When running git blame without ignoring revisions, commit 36944f2b16 appears at lines 54, 57 and 59:
>
> 8e3e288fec (Marc G. Fournier   1998-12-29 13:19:05 +0000  50)     int radport;
> 8e3e288fec (Marc G. Fournier   1998-12-29 13:19:05 +0000  51)     char *lochost;
> a9d899ddbe (Russ Allbery       1999-11-29 01:40:47 +0000  52)     int locport;
> 8e3e288fec (Marc G. Fournier   1998-12-29 13:19:05 +0000  53)
> 36944f2b16 (Julien ÉLIE        2021-10-31 10:04:59 +0100  54)     char *prefix, *suffix; /* futz with the username, if necessary */
> 9f21a39f37 (Katsuhiro Kondou   1999-06-12 09:33:48 +0000  55)     int ignore_source;
> d65e228465 (Jeffrey M. Vinocur 2002-03-14 07:27:00 +0000  56)
> 36944f2b16 (Julien ÉLIE        2021-10-31 10:04:59 +0100  57)     struct _rad_config_t *next; /* point to any additional servers */
> 8e3e288fec (Marc G. Fournier   1998-12-29 13:19:05 +0000  58) } rad_config_t;
> 36944f2b16 (Julien ÉLIE        2021-10-31 10:04:59 +0100  59)
> d65e228465 (Jeffrey M. Vinocur 2002-03-14 07:27:00 +0000  60) typedef struct _sending_t {
> d65e228465 (Jeffrey M. Vinocur 2002-03-14 07:27:00 +0000  61)     auth_req req;
> d65e228465 (Jeffrey M. Vinocur 2002-03-14 07:27:00 +0000  62)     int reqlen;
>
>
> Shouldn't 36944f2b16 have disappeared from the output at line 59?
>
> It should have been d65e228465 which already had that line, as it can be seen in the commit (line 53 at that time):
>   https://github.com/InterNetNews/inn/blob/d65e228465700ff044b75aecacb7062d2a1250f9/authprogs/radius.c
>
>
> The result of that command is the same as the one GitHub shows; you can therefore find the whole ouput here:
>
>     https://github.com/InterNetNews/inn/blame/main/authprogs/radius.c
>
> Commit 36944f2b16 is mentioned at lines 59, 129, 144, 293, etc. though present in .git-blame-ignore-revs.
> Yet, that very commit is correctly ignored at other places of the same file.
>
> Other files and other commits in the project are also affected.  I can give more examples if needed.
>
>
> Is it the expected behaviour of "git blame"?
> Is there a reason for these commits to appear in some portions of the blame output?
>
>
> Thanks beforehand,
