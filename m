Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E6101F42D
	for <e@80x24.org>; Thu, 10 May 2018 09:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756773AbeEJJ1z (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 05:27:55 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:44922 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756627AbeEJJ1y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 05:27:54 -0400
Received: by mail-wr0-f169.google.com with SMTP id y15-v6so1276556wrg.11
        for <git@vger.kernel.org>; Thu, 10 May 2018 02:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=h/l/jWkZt3rfd4A0422w0Fn0vexmUIPZBwWgNGBX+1g=;
        b=f/smTY4bcutDCiGeZ2KoTkZSvEfVctCw7HsWTHYOdcRu8qz1AalKNhZ2K2jjYjgJL/
         O7pR1qwNjKdINw82yxR57Ns55WEhs4nmGvdylXqzhTiwp6I599O/GTo7gQLMulALw/DL
         cX04fz5g0uTZgB3tpRPc945w6nnoEFaSNvxZOIcu7MHGNqM8hGOXek8QM9m+9aOK6Vmm
         OLEgelVgKy+16X8zF6dFMHw4UZgSytGFLsHsDtEpNNbCC2DNOJD4jmz2+JEGz3CLZXWj
         Ke/2SWv3pd2DG0P+3+NEBIUoEoY1UiEbNS1uckc0BAjGYPdgUqKj3AN+fqQ4aoZjwaaB
         UvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=h/l/jWkZt3rfd4A0422w0Fn0vexmUIPZBwWgNGBX+1g=;
        b=BUmEiCiI1balny7uBxNa0YQIgEm1z1tQVnFekNCjmAV+wL8KWCa+BQhNYqWUb+1+IR
         rkn8Q8Ml4qowdsqZFMrrhyccnvncGm24Y0aShZ8zRu4gZUwoGKuwv2GCq1Ai6E6l88vv
         RVTD1zbHnKdoaB096+dkptLqEml92GnEjfrDI5WYxAl4H5CAVcr4FSTrDNfylwyeRsaA
         /AQ7YfmRDEiKEZM3+oyWjHSLXAev10u0Cm9J/wfPYTT+Ak/Vf7wrtxowD7CJwEIV2CtO
         tiWOZO3iICPrs0FuiVr9bLqQgLhCYckt7bb2h3GhM7OO0fDzt56WSVu+SnoNeDuV/jLJ
         0JuA==
X-Gm-Message-State: ALKqPwdtm7H30KakJ/S3ruDjWG1Ork+hwG6l5kcF+I6iLaBhim9tMpu0
        jPDdEhYvwzRhbTHRLCwME/s=
X-Google-Smtp-Source: AB8JxZpJk9K7Tzv58feB0iDu/7+RE40bZVvAhNK8PxA4FlB+5LYSX2RmDCL8M+meQZo9XXVWN60+1Q==
X-Received: by 2002:adf:a9e6:: with SMTP id b93-v6mr698324wrd.234.1525944472739;
        Thu, 10 May 2018 02:27:52 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d17-v6sm483491wrc.0.2018.05.10.02.27.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 May 2018 02:27:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] repository: fix free problem with repo_clear(the_repository)
References: <20180509170409.13666-1-pclouds@gmail.com>
        <CAGZ79kbFiULj1NJARm6ObYrqv_Fu+U2sb8h_sNJwdWur+JqrvQ@mail.gmail.com>
Date:   Thu, 10 May 2018 18:27:51 +0900
In-Reply-To: <CAGZ79kbFiULj1NJARm6ObYrqv_Fu+U2sb8h_sNJwdWur+JqrvQ@mail.gmail.com>
        (Stefan Beller's message of "Wed, 9 May 2018 10:50:00 -0700")
Message-ID: <xmqqbmdnkgh4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> So this would go with the latest sb/object-store-alloc ?
>
> My impression was that we never call repo_clear() on
> the_repository, which would allow us to special case
> the_repository further just as I did in v2 of that series[1] by
> having static allocations for certain objects in case of \
> the_repository.
>
> [1] https://public-inbox.org/git/20180501213403.14643-14-sbeller@google.com/
>
> We could just deal with all the exceptions, but that makes repo_clear
> ugly IMHO.

So perhaps

         void repo_clear(...)
         {
        +       if (repo == the_repository)
        +               BUG("repo_clear() called on the repository");
                ...

or something?
