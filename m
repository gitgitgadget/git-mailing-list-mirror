Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1687BC38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 19:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E12E1208CA
	for <git@archiver.kernel.org>; Thu,  7 May 2020 19:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W6MImoSO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgEGTn7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 15:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726326AbgEGTn6 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 15:43:58 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6BEC05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 12:43:58 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h185so8285535ybg.6
        for <git@vger.kernel.org>; Thu, 07 May 2020 12:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cOG7+ZEulku4pnSkBV67Pf9YrQe/+cIjVC8cXR4fOyE=;
        b=W6MImoSOy0nqs2+7FyPyYyr91c/m9/Wab0ZBCb3aWXv68RVr+2Nbsbhr2VvI9cUOcD
         u4BwA/LRiAywRLVsbp9PXa0v0ts6TiDCoVOzzY8IN23LTvMlEHh3OL/aWb9gyIJROzA4
         PNDqjkmJQ8MlX0Cmj/f931R+e7l7mSiro50dOcvJT9ToCgsF/a3nlSg0xD5Z3lWoAht5
         oewh9qBDf/0tgNXMxyNRQlr/ONQ6fBYJmGNW19qvAAnxPJzkY+gMflZg+Jl3alelrLHV
         rvjsUJ9JBs+Bq5sdGiS0eBypJPg1awsi6aOfPMgCiGStxonYMEIzBOzQ1PdlLoMV9SqH
         XtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cOG7+ZEulku4pnSkBV67Pf9YrQe/+cIjVC8cXR4fOyE=;
        b=QRulsV0hxAkPiSk1ZGkUYm65DPhT/+Ref0U1n5kW20ADKfeHM+ZbS/WhmXrwEYmqDk
         EJP53nfLvgKicsqtfRPNlFykrZckjeU7qWx5alxKxXxEKaba0/Uv1ihJx1gmEp0yJ0s4
         Tz3/sFf8Ak3aIouYo2U4FznwnTtRICzaGS+kHZfU6fsBjw+8DM7WYNAQi2BMBEkMVWIF
         6Diw2egrc0xn7G5LHBLHOUTQaRjrj2JanMgy+a7auFl+4F/M51d5SSAu5DowClOWERLf
         Y9VJ2f5R+EheY/8i0wMtSzvUlIBf0tJ1M66kcPalL70IlIlcfEQVb5K+iBgXrO5NszLY
         Fygw==
X-Gm-Message-State: AGi0PuZ0htFHEtkbZQPgOQM4M+4GoTK5/L4PQEB+v5KLB4QAUTtZuwaD
        FgLd8FZ56ZMR9FA3ktOVSboNmacbQ/OVykudD0Ur
X-Google-Smtp-Source: APiQypLnhRwstBFwnnE3bin8ZE3lZwJKrjYHN5431/YycMBVt5CtjlfhIrc4PAdNaCO4+M3Tt07H5bo1k1zF+i1e+IAv
X-Received: by 2002:a25:e008:: with SMTP id x8mr25074332ybg.295.1588880637655;
 Thu, 07 May 2020 12:43:57 -0700 (PDT)
Date:   Thu,  7 May 2020 12:43:54 -0700
In-Reply-To: <eb0cbeeeed080596c130f657186894999ae6121b.1587412477.git.gitgitgadget@gmail.com>
Message-Id: <20200507194354.33347-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <eb0cbeeeed080596c130f657186894999ae6121b.1587412477.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: Re: [PATCH 1/2] fetch-pack: remove fetch_if_missing=0
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, hariom18599@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Hariom Verma <hariom18599@gmail.com>
> 
> Commit 6462d5e ("fetch: remove fetch_if_missing=0", 2019-11-08)
> strove to remove the need for fetch_if_missing=0 from the fetching
> mechanism, so it is plausible to attempt removing fetch_if_missing=0
> from fetch-pack as well.
> 
> Signed-off-by: Hariom Verma <hariom18599@gmail.com>

As Christian said [1], please include tests like in the commit you
mentioned. For a change like this, I think that the test is the most
important part.

Also include a justification for why it's safe to remove
fetch_if_missing=0. You can probably cite the aforementioned commit to
say that it covers the fetch_pack() method, and then go through the rest
of the code to see if any may inadvertently fetch an object.

Also, the fetch-pack and index-pack parts can be sent in separate patch
sets, so you might want to concentrate on one command first.

[1] https://lore.kernel.org/git/CAP8UFD2SNnpKWtYUztZ76OU7zBsrXyYhG_Zds1wi+NqBKCv+Qw@mail.gmail.com/

> diff --git a/fetch-pack.c b/fetch-pack.c
> index 1734a573b01..1ca643f6491 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1649,7 +1649,7 @@ static void update_shallow(struct fetch_pack_args *args,
>  		struct oid_array extra = OID_ARRAY_INIT;
>  		struct object_id *oid = si->shallow->oid;
>  		for (i = 0; i < si->shallow->nr; i++)
> -			if (has_object_file(&oid[i]))
> +			if (has_object_file_with_flags(&oid[i], OBJECT_INFO_SKIP_FETCH_OBJECT))
>  				oid_array_append(&extra, &oid[i]);
>  		if (extra.nr) {
>  			setup_alternate_shallow(&shallow_lock,

Hmm...this triggers when the user requests a clone that is both partial
and shallow, and the server reports a shallow object that it didn't send
back as a packfile; and it causes another fetch to be sent. This is a
separate issue, but Hariom, if you'd like to take a look at this, that
would work out too. You'll need to figure out how to make the server
send back shallow lines referencing objects that are not in the packfile
- one way to do it is to use one-time-perl. (Search the codebase to see
how it is used.) This is probably more complex, though.
