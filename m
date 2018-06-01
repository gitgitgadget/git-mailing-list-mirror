Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 857881F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 02:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750732AbeFACMZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 22:12:25 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37168 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbeFACMY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 22:12:24 -0400
Received: by mail-wm0-f44.google.com with SMTP id l1-v6so52072wmb.2
        for <git@vger.kernel.org>; Thu, 31 May 2018 19:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RA3+lPiHzxzugH9LjjmAaj61JZ9pFNYu/eUcnBQ7e0s=;
        b=BaC1g6Jhz2kIyK1YgxczKMu9VxivS5ih6bbAF61n1Ezylq/1550fZ/lnEWvrzs0hKW
         1W0JMNnqeck8hkzEVXC/hx8xHRIwgbmm40206XnTzn/owaFYBfpC68nA42KFNUp7WmrX
         OeVpJabTB7Zhcb796Bge5jH+LNSs6URkYDmHQNlxQ6mDO3wxKTJlaYr5fw1eW7hxhijN
         GZt4rJCf/0rYvMzZt/4h30ufGFfonm9YYLFebbJryR+A5CeZ1S/+tJVUzX1OWoZvcmC1
         kMHAZGub57k0T+wAbHd4coLYNNn1uM1jkrHlH4COqhcN9LEUwSjITTfExbR8cjcR5xLD
         Bc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RA3+lPiHzxzugH9LjjmAaj61JZ9pFNYu/eUcnBQ7e0s=;
        b=rgDuPbFObIn7u6+CBQs+te7Z+jfe42u58WVAbEMoMtWrJYBSaPPDzL9ktLYCBPqRpy
         hUrsGOvsW6T6vdtm4KapQLQM5aKV1wfIAO5RtvHDlL1yGcbUVv1n9+403CBgMfZZ3ehL
         bFr/G7ZKn1vSabYepkqP/kXpiPV1iUPHm/uF5UuumRC9a9pngzw8NIOo7H2xh0ixt2qS
         +HPijRGRUfv8cRS3BIJab96imf+KydNOLkObcb17QE/xIsMMP+FmxWiLoo+vlPUcuquD
         0HfVjeNa1xkc8uRaR/Iko1Fp8WnkzIonrwiqMPmSl2PM+5LoMOY1aOus9O1AAJhPt9Jz
         5L/A==
X-Gm-Message-State: APt69E1x048PshQomRePIGnT4TTTk+pGf1jjcaMlKjfJDyEXrztFJvUb
        us1VWeZzDP/ssti67CkRiRw=
X-Google-Smtp-Source: ADUXVKK6YMQ37L/5ouQ8HfTNqavmQQkntuCJ8DNQCS8aRvN3g97ZveIEntRYuPD0kn4WsXO3bq5E+g==
X-Received: by 2002:a1c:8d8a:: with SMTP id p132-v6mr1239986wmd.49.1527819143187;
        Thu, 31 May 2018 19:12:23 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r3-v6sm788956wmg.5.2018.05.31.19.12.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 May 2018 19:12:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] fetch: do not pass ref-prefixes for fetch by exact SHA1
References: <20180516225823.235426-1-bmwill@google.com>
        <20180516234822.182663-1-bmwill@google.com>
        <20180516234822.182663-2-bmwill@google.com>
        <20180531072339.GA43435@aiede.svl.corp.google.com>
Date:   Fri, 01 Jun 2018 11:12:21 +0900
In-Reply-To: <20180531072339.GA43435@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Thu, 31 May 2018 00:23:39 -0700")
Message-ID: <xmqqtvqn9rwa.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> When v2.18.0-rc0~10^2~1 (refspec: consolidate ref-prefix generation
> logic, 2018-05-16) factored out the ref-prefix generation code for
> reuse, it left out the 'if (!item->exact_sha1)' test in the original
> ref-prefix generation code. As a result, fetches by SHA-1 generate
> ref-prefixes as though the SHA-1 being fetched were an abbreviated ref
> name:
>
>  $ GIT_TRACE_PACKET=1 bin-wrappers/git -c protocol.version=2 \
> 	fetch origin 12039e008f9a4e3394f3f94f8ea897785cb09448
> [...]
>  packet:        fetch> ref-prefix 12039e008f9a4e3394f3f94f8ea897785cb09448
>  packet:        fetch> ref-prefix refs/12039e008f9a4e3394f3f94f8ea897785cb09448
>  packet:        fetch> ref-prefix refs/tags/12039e008f9a4e3394f3f94f8ea897785cb09448
>  packet:        fetch> ref-prefix refs/heads/12039e008f9a4e3394f3f94f8ea897785cb09448
>  packet:        fetch> ref-prefix refs/remotes/12039e008f9a4e3394f3f94f8ea897785cb09448
>  packet:        fetch> ref-prefix refs/remotes/12039e008f9a4e3394f3f94f8ea897785cb09448/HEAD
>  packet:        fetch> 0000
>
> If there is another ref name on the command line or the object being
> fetched is already available locally, then that's mostly harmless.
> But otherwise, we error out with
>
>  fatal: no matching remote head
>
> since the server did not send any refs we are interested in.  Filter
> out the exact_sha1 refspecs to avoid this.
>
> This patch adds a test to check this behavior that notices another
> behavior difference between protocol v0 and v2 in the process.  Add a
> NEEDSWORK comment to clear it up.

Thanks.

I wonder if there is a more effective way to smoke out other bugs
remaining in proto v2.  When the fetch-by-SHA1 feature was added
originally, we certainly would have added a test or two to make sure
it won't break.  The root cause of this breakage is that we lack the
ability to easily exercise proto v2 on these existing tests that
were written back in the proto v0 days.  It there were such a way
(like, a common set of tests that are run with all supported
protos), we would have caught the breakge even before the topic hit
'next'.


