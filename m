Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1DB520248
	for <e@80x24.org>; Wed,  3 Apr 2019 08:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbfDCIuB (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 04:50:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55795 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfDCIuB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 04:50:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id o25so6440222wmf.5
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 01:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=M0hFsTDJZ17UM8wLBdV7fHrPlnlwBhP7bFtmZjs2H/A=;
        b=AJqD84nXImO+/nN7LSMRrltQ6aPxbYUymVV64eoORvEWu5LkLznu9LJty2fFr/ZmOK
         u61TNuYQYsQK8UgARZjEWZ/OsUWuxeFR5CsbbzfZ/JJddC4861kYcoXPdbkCaBt32woD
         zd7EVz7HPyCbc8GmljgKm9PeA2Elb+gNd4NKeFIkhoDNsOZ1msf16tJJTWOdKN70bJIv
         V3diFowhQDcZUUCvCz5F9MjRtDwa7h2XhvE1Rt6J3kHOuiPzB/eq5LsdKrNbV6NXMZDZ
         uqQzeVyCleU9qUfHZJL6UQjhDKt6iA6s/P+we+SCzn0Rm3gDkZpZ7JKLXPpQUQqEEJdr
         4Zbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=M0hFsTDJZ17UM8wLBdV7fHrPlnlwBhP7bFtmZjs2H/A=;
        b=r+XWOpb3fEkW/jBSfQ1OUBf0ttZhea0rYJI+uUaz8EckU5J8jA3V3S+VhNSz6rtg+V
         Mq6Too3xl2w+hPjKfCsuyIUzyKCz5taChFAxNHpb1IxH5rVQ24TLGDwKzMzJTuzKudZo
         +2/p3EPqOk5JsVCgFLLXhBQlGtGHiyCAtGcR2AcGJAZupMm4KRUensNdUPqz6aGRO775
         Z11quvkcyQ2b5WPeNzBYhCC5GlnP4XXKAZNA7U0TmoKz/M7gmTyJAPBlY0VJLiOAPuQL
         AUm6qxxsPgPArqiZzL0ZLizQU8s1Z/u/5P0MuIoM/zKpozjCcWC69qIb1qLtSYJsqFl9
         M/dw==
X-Gm-Message-State: APjAAAXJr2z16u+zAPatPAC26pDJgotcsGcyIvf+YdPMKa23a8EzJfQ3
        5jGYO2UXkqNLNQc+8/rjGs8n0BOzVLI=
X-Google-Smtp-Source: APXvYqwSAYRe1Xgia5IoARht+y5QxI+Gvhtk7tuGGkR6b74kZ3/pFpKX6ahty+4NR5nlDn25t7u0Iw==
X-Received: by 2002:a1c:31c3:: with SMTP id x186mr1197967wmx.82.1554281399575;
        Wed, 03 Apr 2019 01:49:59 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id i28sm45338725wrc.32.2019.04.03.01.49.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 01:49:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Robert Dailey <rcdailey.lists@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2.5 2/2] tag: prevent nested tags
References: <1bd9ee28bc8726490ec0a93286056beeb147fc49.1554183429.git.liu.denton@gmail.com>
        <20190402230345.GA5004@dev-l>
        <xmqqzhp7sfw4.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 03 Apr 2019 17:49:57 +0900
In-Reply-To: <xmqqzhp7sfw4.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 03 Apr 2019 16:32:27 +0900")
Message-ID: <xmqq7ecbscay.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I am not sure if this is so bad, actually.  Why do we need to treat
> it as a mistake?  When a command that wants a commit is fed a tag
> (either a tag that directly refers to a commit, or a tag that tags
> another tag that refers to a commit), the command knows how to peel
> so it's not like the user is forced to say "git log T^{commit}".
>
> And if something that *MUST* take a commit refuses to (or more
> likely, forges to) peel a tag down to a commit and yields an error,
> I think that is what needs fixing, not the command that creates a
> tag.
>
> So, I am fairly negative on this change---unless it is made much
> more clear in the doc and/or in the proposed log message what
> practical downside there are to the end users if we do not stop this
> "mistake", that is.

Having said all that, I can sort-of see that it may make sense to
forbid tagging anything but a commit-ish, either by default, or a
"git tag --forbid-no-committish" that can be turned on with a
configuration.
