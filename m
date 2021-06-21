Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27023C48BDF
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 01:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED03060E0B
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 01:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhFUBc5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 21:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbhFUBc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 21:32:56 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69EFC061574
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 18:30:41 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id g20so25968091ejt.0
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 18:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=IfuSqbJ/U3U2haxusL6m+ItF8hIQsRpy8Mbgieu5NKY=;
        b=AvINI5kiUpgYyYbwhfCLWLfozCsLXCPOBIAKcnlQp4XpnSj3mGUW6KNGGL5qpdxRXY
         NpX2v2qeEJt0Clb1D86lFWn2B3P9YmYeY11glh+VAncjzYhSWuGNbkwDvsVvPUTByXLA
         fP/aWV08vIbvrlVcR0SUKli15tmk6PJilPEjDOlEatHpekb0e0kdR08Vs9+797v1i+W+
         p/v+ab/XP5dByymSWcWsk+pAtYUTP0iX8k9HPFkCH9ZnYV9UEq0W0FcFm48fBcvXMI+N
         JivhceOafpZo+fW80gvxSFfyLK/bRiSfbZTvshe4pTXe129Z60xx/PigC4xDiH+3+nqz
         6shA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=IfuSqbJ/U3U2haxusL6m+ItF8hIQsRpy8Mbgieu5NKY=;
        b=YGznLNqLtPXCnwKAXge9CX2cwuu1ZgSF6LPxCAYBgiPey0lm22XlEevBEpJUsIoiyl
         dkZxGSJjgi4Q/NMZ5aG5Sc+4743dRC21UFdmPwy99S7U29G1XuFZ3j7e/LlcOE/t6yKH
         z21QlFRqqvg5zBO0qQvxeMz0bqeYARGH4URvdT2ptxEHgCIOCpBtPjAL50Lwf1NcfI2j
         qAgqk1Y/fAREWfXPTJNlCBRWg+VKeeowJ+T0pxyygiu4EjYDSQDGVgNwLK81fHqM1O7A
         JuOmo4pFp73phbTLyYgvhEOi1n63oigWZSIc0XetaS+o23j90kwEeq2XHvrPEKpcwcDW
         99vQ==
X-Gm-Message-State: AOAM530gdMkLIODFDQi1T4ZMX9DHGpSV5jCu600Hq02A9OLGkZAb9ndj
        7+P7pIii+b1O1Fy2tpiamhc9Ukn/i9U=
X-Google-Smtp-Source: ABdhPJwhmt2DcXUJCAaZFUK/XvSkdeqpJeC+0sfLnEQt+LytBaJCm79wOjJX5MfGHbtqg/JSZ0inDw==
X-Received: by 2002:a17:907:379:: with SMTP id rs25mr14750650ejb.426.1624239038923;
        Sun, 20 Jun 2021 18:30:38 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id v12sm4094896eja.63.2021.06.20.18.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 18:30:38 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        szeder.dev@gmail.com
Subject: Re: [PATCH] trace2: log progress time and throughput
Date:   Mon, 21 Jun 2021 03:24:47 +0200
References: <20200512214420.36329-1-emilyshaffer@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <20200512214420.36329-1-emilyshaffer@google.com>
Message-ID: <871r8w3sxu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 12 2020, Emily Shaffer wrote:

[Replying to a change long-since merged into git.git's "master"]

> Rather than teaching only one operation, like 'git fetch', how to write
> down throughput to traces, we can learn about a wide range of user
> operations that may seem slow by adding tooling to the progress library
> itself. Operations which display progress are likely to be slow-running
> and the kind of thing we want to monitor for performance anyways. By
> showing object counts and data transfer size, we should be able to
> make some derived measurements to ensure operations are scaling the way
> we expect.

Did you end up using this data for anything?

> [...]
> @@ -320,6 +321,22 @@ void stop_progress(struct progress **p_progress)
>  {
>  	finish_if_sparse(*p_progress);
>  
> +	if (p_progress && *p_progress) {
> +		trace2_data_intmax("progress", the_repository, "total_objects",
> +				   (*p_progress)->total);

We start progress bars for various things in git, yet the trace2 data
calls every such progress bar with a total "total_objects", even though
we may not be counting anything to do with objects.

Wouldn't simply s/total_objects/total/ make more sense here, do you rely
on the name of the current key?
