Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A66F11F597
	for <e@80x24.org>; Mon, 30 Jul 2018 17:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731812AbeG3T1I (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 15:27:08 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51792 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbeG3T1I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 15:27:08 -0400
Received: by mail-wm0-f65.google.com with SMTP id y2-v6so293152wma.1
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 10:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=/mNE/GBxwcLzeWuTE5bJYjND8KWsGf4DphryMwwqn9k=;
        b=hNLlnKFrzdl1ZSQJWnaYEyLBzzOyrRnz9neVfOt2WVJDcLfCwjkc4twUEAd3rIjiOS
         ocAe7ylbGfHT8ORBedlWmZwcCohzKCR01kZF1YrY9qcVyfkVaWlQ8f5LgBRgFHBgDEw+
         Qqrjl0vg9DNcEt3IvRJocAAH7ErCA5L0SBisDzYikDOUJcydGvDL6szvjpizG0uNHdbe
         rq8Bi7R787RO6KjcUcWfn29fSD9QxnGXciALxJGBI8mq25zFhbJmG9FDLnb5SxnCaSJo
         ipd6pcDyAMw9mvHdxXiPEA9XyzOJcXF/hp7Zjg4/kJQ//R+vlcQGz6XbqwQnTP1acITp
         yGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=/mNE/GBxwcLzeWuTE5bJYjND8KWsGf4DphryMwwqn9k=;
        b=g82C4oCKE6Zoa6cq9avC54//ndbsOFY1Buv0+BhJkgQX2+u0abRgZ9IvbDhPnxyQMr
         5/LkkLZfei1J4lJVuB2JBrJY0FXyWYyZyZVJS5IZHILH/S0a7LjNlp58mUkHlv9ZpCxY
         8kgML+0YD4ZusskP79P92VjwFhP/wIpqBjBWGiB97VWEJDayUafHMpejW/EhNa9g9ZHM
         uCjxQ16uS75QIAG0804gDFd0jw9gWqyRSf0Wi6qqLR1eB+vkQGW68xa+YCucMwFtT46i
         CjaFDHm9TcOxhh00imneLLNPxCFuPYhtf5pYSSqq7uV1JLX0nTV041Z/ZNaZHUXIAC6d
         /Pgg==
X-Gm-Message-State: AOUpUlFaoASzU+VNbSYtYcyMGHQ4GTo6j+PcB17XxJG29Qj5cWaI0iFl
        otRX6oTKvZslHKMLjllSw0Q=
X-Google-Smtp-Source: AAOMgpeL6pZNCI5R7r0OAic/3EdzksD7nGmq4gByRH8jarq9JDozfMF9nm1EyheN8SJc/IbUgckO+Q==
X-Received: by 2002:a1c:9bc5:: with SMTP id d188-v6mr188298wme.33.1532973061267;
        Mon, 30 Jul 2018 10:51:01 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n7-v6sm11144479wrr.35.2018.07.30.10.51.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 10:51:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 08/11] rerere: factor out handle_conflict function
References: <20180605215219.28783-1-t.gummerer@gmail.com>
        <20180714214443.7184-1-t.gummerer@gmail.com>
        <20180714214443.7184-9-t.gummerer@gmail.com>
Date:   Mon, 30 Jul 2018 10:51:00 -0700
Message-ID: <xmqqwotcfw8r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Factor out the handle_conflict function, which handles a single
> conflict in a path.  This is in preparation for a subsequent commit,
> where this function will be re-used.  No functional changes intended.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  rerere.c | 87 ++++++++++++++++++++++++++++++--------------------------
>  1 file changed, 47 insertions(+), 40 deletions(-)

Renumbering of the enum made me raise my eyebrow a bit briefly but
it is merely to keep track of the state locally and invisible from
the outside, so it is perfectly fine.

> -	git_SHA_CTX ctx;
> -	int has_conflicts = 0;
>  	enum {
> -		RR_CONTEXT = 0, RR_SIDE_1, RR_SIDE_2, RR_ORIGINAL
> -	} hunk = RR_CONTEXT;
> +		RR_SIDE_1 = 0, RR_SIDE_2, RR_ORIGINAL
> +	} hunk = RR_SIDE_1;
