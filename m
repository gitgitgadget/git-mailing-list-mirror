Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AAAC432C3
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 21:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59EB7207DD
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 21:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ueto1f+q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfLBVFh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 16:05:37 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43338 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbfLBVFg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 16:05:36 -0500
Received: by mail-pg1-f196.google.com with SMTP id b1so320658pgq.10
        for <git@vger.kernel.org>; Mon, 02 Dec 2019 13:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=e5jaTawziPgAyEAs3DzERIHFjus/uHD6/iwAVDlKUgM=;
        b=ueto1f+qtP43JNjtvXfDcwSer+h7onxhBFoVmqWi7xitp08QQZxAL5YJNiC07sHSzd
         Dww7+i/U0ddMXZzumb4Pwno5Csp8x6O/k2uFt1NXEXe/RG4iq81FTOWSi+wEF3CpHj2m
         PzjeHDSma0tROaLZASG5KBaLVbdpyPz2+SBOExgCnzcQXzWgzQ+OGt1JEozJbf9jsjPp
         TN195OYOt69njBzITz8QfhqxzdQf6O4gycbkxnEMX7O13vYrwFlInP6sj8hXk+fDmlZn
         Rnb3giT4kJ4d+StmEz53JNhhTDip8c/ctayW95B1u6sdEStR1tXUo0M0vQTWK106N3Gz
         gm1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=e5jaTawziPgAyEAs3DzERIHFjus/uHD6/iwAVDlKUgM=;
        b=mYjKDPHTLEAoaWdhDIwNd8NUFupU196XX50oEv2NnHUkWMyK4wi0jsHjGfKiIyD/wg
         bWUJ9Fqv2WVDWpleGD1hPw7Ymk+UeyzoqQPyyi15O1+ldx9TnBUudSqY99lTo64LSSQP
         8JVBos+jcJs6XmG3b6kOMGCxnFj3d67uujQ1R2z3cp4uUnxHDVh2quUrv9LD+Jy8Nw4O
         m/h+LNhxuPrG133mv9/7Iql8/uSIKGjJNLLfVvqXYDexDHVosjc1tnUvPrn2eL+6Vc/x
         +22rqgZ7hZ+u52A+gKiL1Z1A4JSE/Ttf8vQK8UZJ6gu73yMOKUERp5CS4TgcorCWE+Gc
         gVjA==
X-Gm-Message-State: APjAAAXJLvF+kmotZkWtxd+koqXPLxRcuZaIS26JfUEopQ6VZG53qyyx
        4zxNZICJdJPMX7MFyHbRYuzHTxae
X-Google-Smtp-Source: APXvYqw1A13MSNKoONF+ulVmS/LiQYyjA/dojN6GCNz9WonVRYxNqXURqQdgtUpuCWJwCsc5lEQu1g==
X-Received: by 2002:a62:aa13:: with SMTP id e19mr733183pff.36.1575320736015;
        Mon, 02 Dec 2019 13:05:36 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id u3sm287799pjn.0.2019.12.02.13.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 13:05:35 -0800 (PST)
Date:   Mon, 2 Dec 2019 13:05:34 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2019, #01; Mon, 2)
Message-ID: <20191202210534.GA49785@generichostname>
References: <xmqqpnh6yfrl.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqpnh6yfrl.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, Dec 02, 2019 at 06:16:14AM -0800, Junio C Hamano wrote:

[...]

> --------------------------------------------------
> [New Topics]

Could you please queue this series[1] which fixes the bug when using rebase
with `format.useAutoBase = true`? I sent out a v2 which addresses the
vague commit messages from the first round of review. Note that 4/5 has
a spurious change that should be removed but I don't think that it's
worth the noise of sending out another reroll.

[...]

> * rs/test-cleanup (2019-11-30) 7 commits
>  - t7811: don't create unused file
>  - t9300: don't create unused file
>  - test: use test_must_be_empty F instead of test_cmp empty F

René sent a v2 for the above commit here[2].

Thanks,

Denton

[1]: https://lore.kernel.org/git/cover.1574878089.git.liu.denton@gmail.com/
[2]: https://lore.kernel.org/git/a56a4b33-61f8-d3a5-d85f-431c70b8f3e7@web.de/

>  - test: use test_must_be_empty F instead of test -z $(cat F)
>  - t1400: use test_must_be_empty
>  - t1410: use test_line_count
>  - t1512: use test_line_count
> 
>  Test cleanup.
> 
>  Will merge to 'next'.
