Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95600C433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 09:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbhLMJ0C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 04:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhLMJ0B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 04:26:01 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA2DC061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 01:26:01 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id l25so50265983eda.11
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 01:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=FCWrQkqwUox7KOXtuQa1SosE2Dil8uuWSNXk2ioUg/Y=;
        b=c3Kk/iE7DdPIZFXVlxOVVCvRaVyYBJRxXYrXpx2/PI+WVTl3C16+JQExbQSBvf41oW
         9sEk181vQ+pyUXQhtE8DvfYrOpD4FVE4C3Vg0hUTa/zmfdwgjxng46jv1jTF6yR7DP6J
         CA/3cJORWyV2IIPr2p09X0j1qY7cN14mTI5Yrx86CAban+BOluJq5cp2Qaww8X69aJKB
         2zFUPg4otV7oq4V6ZoQbOc5StqbHvViJFwJhnLpdaDg7aWK1ArFFFWz1RKf5gmO7J2br
         Lx2qNquCv91UOMEbMPnt3/oNCd1kYJBlv2QOQ8NhOFQxn2Mhp1YT4t2NC4YCG+raOMJu
         Akbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=FCWrQkqwUox7KOXtuQa1SosE2Dil8uuWSNXk2ioUg/Y=;
        b=WNIaqltwHBsqED6MAsUlZOW8iMK2J44ojmuSF1f0qA1Qzu3sWvZSXEyJbx24AF6gei
         tZqcIxnI+Yi5XqyqK4CfaTJuUbUiYbGhjJx70KkBHig3BTnFktNq9IdRlKsg2di22Yf4
         6liijdUgsk/9HvHDUcVdTvkAw950+DPHgLfT7OK7M5+Bx4fYS3QrmwE0a6CwehD0CJq2
         EM3tt8GZuhnpFcKEO/Si6fxdBvNLAhH3zQ8UTW0FfA/ZQoO4hLIOIM2g24QOAlzGkGug
         hm6t86SaR5d2RF/VQXwnJUpS0UouAVV4fRjx2cj0XZsgP9Ti+LoiDr931k1zMuqvqB6P
         U7hQ==
X-Gm-Message-State: AOAM532tekFRtVOqHFC8Ac0MI8CrFUbX+UuKiONZqepM19xQraFzE/vL
        XcBRfkDLQSeO5BhgtWSJ0peBrmi5L7iU/g==
X-Google-Smtp-Source: ABdhPJz8t6sI2s8EM/OZ2wmyo8M+0BJHt/q5RSMdXmdV+e9qbp+lO9gOek5aySr2i1jBCqFOhkU7FQ==
X-Received: by 2002:a17:907:7d8f:: with SMTP id oz15mr41492867ejc.245.1639387559596;
        Mon, 13 Dec 2021 01:25:59 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id nc29sm5439420ejc.3.2021.12.13.01.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 01:25:58 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mwhao-000mf5-8J;
        Mon, 13 Dec 2021 10:25:58 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v3 5/5] branch.c: replace questionable exit() codes
Date:   Mon, 13 Dec 2021 10:19:16 +0100
References: <20211206215528.97050-1-chooglen@google.com>
 <20211209184928.71413-1-chooglen@google.com>
 <20211209184928.71413-6-chooglen@google.com>
 <211210.86ee6ldwlc.gmgdl@evledraar.gmail.com> <xmqq5yrsg9n2.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq5yrsg9n2.fsf@gitster.g>
Message-ID: <211213.8635mwamah.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 13 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> The latter should really be "exit(1)", not 128. We should reserve that
>> for die().
>
> Is it because install_branch_config_multiple_remotes() gives enough
> information to the user that the caller exits without its own
> message?  In other words, are messages given by the callee to the
> users are morally equivalent to what the caller would call die()
> with, if the callee were silent?  If so, 128 is perfectly fine.  If
> not, 1 or anything positive that is not 128 may be more appropriate.

We don't really document this outside of this tidbit:
=20=20=20=20
    Documentation/technical/api-error-handling.txt-- `die` is for fatal app=
lication errors.  It prints a message to
    Documentation/technical/api-error-handling.txt:  the user and exits wit=
h status 128.
    Documentation/technical/api-error-handling.txt-
    Documentation/technical/api-error-handling.txt-- `usage` is for errors =
in command line usage.  After printing its
    Documentation/technical/api-error-handling.txt-  message, it exits with=
 status 129.  (See also `usage_with_options`
    Documentation/technical/api-error-handling.txt-  in the link:api-parse-=
options.html[parse-options API].)

But while that doesn't say that you can *only* use 128 for die, and I
wouldn't consider the existing code that calls exit(128) in dire need of
a change, most of the builtins simply return with 1 for generic errors,
and reserve 128 for die()..

So for any new code it makes sense to follow that convention.

> Either case, -1 is a definite no-no.

I've got a local WIP patch to fix those that I can polish up, if you're
interested. It's the result of adding the below & running the test suite
against it:

diff --git a/git.c b/git.c
index 60c2784be45..d6bdb3571df 100644
--- a/git.c
+++ b/git.c
@@ -419,6 +419,7 @@ static int handle_alias(int *argcp, const char ***argv)
 static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 {
 	int status, help;
+	int posix_status;
 	struct stat st;
 	const char *prefix;
=20
@@ -459,6 +460,9 @@ static int run_builtin(struct cmd_struct *p, int argc, =
const char **argv)
=20
 	validate_cache_entries(the_repository->index);
 	status =3D p->fn(argc, argv, prefix);
+	posix_status =3D status & 0xFF;
+	if (status !=3D posix_status)
+		BUG("got status %d which will be cast to %d, returning error() perhaps?"=
, status, posix_status);
 	validate_cache_entries(the_repository->index);
=20
 	if (status)
