Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A02521F404
	for <e@80x24.org>; Tue, 17 Apr 2018 23:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753080AbeDQXpX (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 19:45:23 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45361 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752619AbeDQXpW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 19:45:22 -0400
Received: by mail-wr0-f193.google.com with SMTP id u11so39898503wri.12
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 16:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=1/pZAIkZAiF6Yl5M+DCffJUiCz9/IFo4EjKW/QgKWM0=;
        b=fXE/eB2/Py5jsZhvWYmRjIehAvC2AxtLxfdQA5myVQO05ad9ewrnbqLlwwkjl1tHXZ
         3MyaJGxDOAzZPUU+WD6NjUMuJueegU8jRhLY411gAcDSWEGcOHN3MzTDQshdw5D2xJyy
         9EDTG4Ww0sqgryDe9Sj1yE227cmT886owupui535OM+EqE9hiSZCcdePm/sFoFNm9b8Q
         bdlYDGLoPTxb9q64UvTUz6tb63f4bhTE6EiDbDgNlk/YYA2TvmELpIaqImSA6tJisLYx
         FnoKogy/WuIB9bT9CaDstguFpXa8AnRiIXadolrRiYO0MmnOfsGw9JUH676Lef4yIUWM
         1Reg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=1/pZAIkZAiF6Yl5M+DCffJUiCz9/IFo4EjKW/QgKWM0=;
        b=ii7+1UaA4eTQpQmb2N9kB3iY/bHTuONt+jMcm/+qw5tWReeYjorhKBqNtd2OIHKs/K
         uXJbBELYaFhp0JWTq47vp+cot+t7IYhT9WYFCcAlxwyqHRgnzoxG69cN68i1W7wrxTGP
         0pP6HIDNN8ViPphmzAdvsrhuasIMGmd05l0nZgrEWmziGbO8ZLR0Fy03QzVH4UZ1A0pr
         nrzZsf1LUxJW0V5R8/zDe5nNyMoq/5yqrmfSOpemipKw485GTAStA3ak6jR0E7Akg4Zc
         /oaWeW0x9/6IMW9urA2cIkSsToNKsqWke8UKv7QmRBBy7OB52fkosCGHgpoVJNjeYMmP
         45NA==
X-Gm-Message-State: ALQs6tAmJvfBJw4QpFXTIfh4UqwnuzHYcrLL4Jfj+3etnI4MRupsd5VW
        IWxwhJ9CiFkMg76B7IjG8Aw=
X-Google-Smtp-Source: AIpwx48Igw43pdiMs4qPF4oVfqE6w/EjQht2DSRDid5n9cc6ExeniCBV+mcRTmDpzwzskfkM46siKA==
X-Received: by 10.28.138.69 with SMTP id m66mr117538wmd.117.1524008721226;
        Tue, 17 Apr 2018 16:45:21 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c21sm14215227wre.43.2018.04.17.16.45.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Apr 2018 16:45:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Matthew Coleman <matt@1eanda.com>,
        Stephon Harris <theonestep4@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] completion: reduce overhead of clearing cached --options
References: <xmqqmuy2wz4j.fsf@gitster-ct.c.googlers.com>
        <20180417220219.30445-1-szeder.dev@gmail.com>
Date:   Wed, 18 Apr 2018 08:45:19 +0900
In-Reply-To: <20180417220219.30445-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Wed, 18 Apr 2018 00:02:19 +0200")
Message-ID: <xmqqh8o9l7n4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> To get the names of all '$__git_builtin_*' variables caching --options
> of builtin commands in order to unset them, 8b0eaa41f2 (completion:
> clear cached --options when sourcing the completion script,
> 2018-03-22) runs a 'set |sed s///' pipeline.  This works both in Bash
> and in ZSH, but has a higher than necessary overhead with the extra
> processes.
>
> In Bash we can do better: run the 'compgen -v __gitcomp_builtin_'
> builtin command, which lists the same variables, but without a
> pipeline and 'sed' it can do so with lower overhead.
> ZSH will still continue to run that pipeline.
> 
> This change also happens to work around an issue in the default Bash
> ...
> Updated the commit message to explicitly mention that ZSH is
> unaffected.  The patch is the same.

Thanks.
