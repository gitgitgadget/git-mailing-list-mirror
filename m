Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C17C77B73
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 00:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbjFFAbM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jun 2023 20:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjFFAbL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2023 20:31:11 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AABA6
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 17:31:10 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-33b22221da6so22019095ab.1
        for <git@vger.kernel.org>; Mon, 05 Jun 2023 17:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686011469; x=1688603469;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=atTisuA0NSxS8grnxrxxIWmrAPBsF/KtwS1INwBQpjA=;
        b=DtWJ5igfhDQ8lTrh8HS+A9GMPdG8LRDPBztJM5mVoEgqhaUxyzboz5/BKZs7wf8/PT
         qjvJDvhiAk9HFSwzSmCDgS6jErplFfyY5j1ZvxqtkosPSdIsJsAcPyniYHBkFQgRF/Iq
         yIULJAEJPpIGqNWajTliPS0XCGruWoJ9VoUvDW02PasvQZOR6J8KYXd/oNcTUAKmpuMj
         DfDXKVPBzeeZR+VsbvtAX6En9mZdNIG756j1zGfUNf7yC+V3Lwvc18k+eX/cH/Z5Qj0r
         ESFB+ZXf46l2fe4Xjj5Nl9wkiF7E+p6Qu49X3XVuHh9YoLCAVt3EhAelkOeLtFvWNVtY
         4dQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686011469; x=1688603469;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=atTisuA0NSxS8grnxrxxIWmrAPBsF/KtwS1INwBQpjA=;
        b=GEjF62lqauXhKj3XmPN3DANkX+Wfq6BMFlM0BhqJ6GFcV/UwJx44STvx8+fiJ0cIZX
         ZNI4QzvThEhSt1VBW4kHWyTYRKsxBiAnoG3za0I7jFz7h70ZC3nmWNE5vIxlm/8asREB
         Kp5J2F+Gt1kC0HC9XxxU0ijpYJARXohMqZPzJbGYjvXYC/a//7wU1R1SMfhRNAB3IpW0
         fns7WjhBzDdQFD/n1CiSdnv35OVoYYFynno0Ff3ZGWVWOf8ozvaNXDUd022Forp4jUaM
         UMJPgtVuxfcZX+kn9IFCDnyiRQshzONwbNXWWq5pHSIaJAyCZsA00jdR+0hEXUd0ik4F
         iyOw==
X-Gm-Message-State: AC+VfDyd2sqkkuwnJbq7PkXMC1vcD9tzpqKeOb0FWeWLjPkYnIl6Bl7u
        C+/o9hhNQkiyR1rZ7lj+9C0=
X-Google-Smtp-Source: ACHHUZ5PaMllBXFn04dGEEt2bUGhkCwkdlxu0WjqkmDF5C4zKLKQH5irSqVzFb+NaCPDvjPPwjznLw==
X-Received: by 2002:a05:6e02:810:b0:33b:1da8:a7d0 with SMTP id u16-20020a056e02081000b0033b1da8a7d0mr628668ilm.29.1686011469321;
        Mon, 05 Jun 2023 17:31:09 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id n35-20020a635923000000b0051303d3e3c5sm6252414pgb.42.2023.06.05.17.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 17:31:08 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     rsbecker@nexbridge.com, git@vger.kernel.org
Subject: Re: [BUG] Git 2.38.0-rc1 t1800 message text comparison
References: <022e01d8ceb5$c2da52c0$488ef840$@nexbridge.com>
        <003501d8cf8d$21ce5ba0$656b12e0$@nexbridge.com>
        <013701d90f80$692ba9c0$3b82fd40$@nexbridge.com>
        <2e3be2e9-191d-fbfd-54c6-a3958e35637c@web.de>
        <013501d98cee$e58dc980$b0a95c80$@nexbridge.com>
        <013601d98cf2$392153c0$ab63fb40$@nexbridge.com>
        <f5519f93-bca7-ecbc-9da3-b25ce8aef618@web.de>
        <28d808e4-77b4-d91e-8a86-c21287019b56@web.de>
Date:   Tue, 06 Jun 2023 09:31:08 +0900
In-Reply-To: <28d808e4-77b4-d91e-8a86-c21287019b56@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 4 Jun 2023 22:55:54 +0200")
Message-ID: <xmqqwn0h4ek3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> What's the significance of "run" and "exec" here?  Why do we have both
> variants?  Is it to tell apart errors of the actual execve(2) call from
> those in code leading up to it (e.g. when searching the executable in
> $PATH)?  But at this point we are after the call, so why is ENOENT
> from execve(2) a "run" thing, not an "exec" thing?

I was reading output from

    $ git log --reverse -p -SNOENT 7e5d776854e.. run-command.c

45c0961c (run_command(): handle missing command errors more
gracefully, 2009-01-28) explains how we use NOENT to tell between
"we failed to run the command requested because it did not even
exist" and "we failed to run the command and the reason why it
failed is *not* because it did not exist" (the distinction matters
to implement "run command X on $PATH").  To further that, 38f865c2
(run-command: treat inaccessible directories as ENOENT, 2012-03-30)
and a7855083 (sane_execvp(): ignore non-directory on $PATH,
2012-07-31) dealt corner cases where entries on $PATH were
unreadable or were non-directories, but the idea should be the same.

All of the above matters purely when we fail silently (because we
expect only some directories on $PATH contain the command), and I
suspect that the phrasing differences when we _do_ tell the human
user what we failed to run does not matter all that much.

