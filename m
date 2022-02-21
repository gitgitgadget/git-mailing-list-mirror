Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25ABC433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 03:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343746AbiBUDMT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 22:12:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236396AbiBUDMS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 22:12:18 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9AB205F8
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 19:11:56 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id e79so14432417iof.13
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 19:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KPyiYxCegHZF4jLY1JDEu80glJkeiYNm//vrxnTqpwE=;
        b=fyObtL34+3TrOenulth7TKBvdwvAoYMxAvmYrpS1VvKCzREezdMPSF+X9IbFdmOo9p
         veMh9JL49EexbuH7Vu9cHilEKlRMe7/qa2DDc0jxyzYuZgCQgr63VIQ64AvwfKvxOCOw
         hg+g1Xix02Hq4PExLxjAD4oZgaNvF0A4KDkrioqka4NTQTcyC5rZB/0McqOq1oKHW2AJ
         NXcwnnwdwUzFAlIqcwCrilCKnu8QnLa1scXuujQic3AuameIhZ/b6SXWD82wvDpSu52s
         hCs0A9+R80TQqLIunux26T88wgYzAgxBPLMSEJJzILeVaddlOcmXiGV0WsT4/8RQP3Mt
         550w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KPyiYxCegHZF4jLY1JDEu80glJkeiYNm//vrxnTqpwE=;
        b=sQ7aAQoi2L7Rzzfy7XqKKyv/cH66BAyXIo461ALLOKRZG22vXXoS7I5hV+0fFQ/UDG
         1HG9tMJFh+zYT59ZY33RxbKffHEauCTfdGn28kKOY/iXrdsuOZjFQt1FMM69Xr6U/ab2
         7eQl+2fffFJqS0+5QW/Vzj3AZe1CdR6DtOC65Lr4z1yUZsV/SUNw2iwZoAayxnrnN5f7
         2/RfIeUjwYbgHJZCRdt6BZcBJmaW2oSXmJxr/tQvxIOs4nri1imVpoyB1peVDJbchVjp
         gL2aYucECzLWpdKxUx2VnGSYgfcn+t/wzL1DHeGVCZa/cvE8hEhtZqG5SHRu8PqRulpk
         MuKg==
X-Gm-Message-State: AOAM530QANQVWZFbN0eqP22iFpdkyXTx1gKomA8h3N+3KUj6R1WNp8+t
        L02/s8gYyR28xRfll9smDHKN0DpayCt2a2oa
X-Google-Smtp-Source: ABdhPJzQoRe2GOXy20mvhC1y+lT95ER187SQrq8kVMakhSJ+sOzs/NbyztnvRsWlw9evEF5EDNkxTw==
X-Received: by 2002:a5d:84c5:0:b0:60b:bd34:bb6f with SMTP id z5-20020a5d84c5000000b0060bbd34bb6fmr14289332ior.32.1645413116229;
        Sun, 20 Feb 2022 19:11:56 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c13sm95874ilm.2.2022.02.20.19.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 19:11:55 -0800 (PST)
Date:   Sun, 20 Feb 2022 22:11:55 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     John Cai <johncai86@gmail.com>
Cc:     Robert Coup <robert.coup@koordinates.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 0/4] [RFC] repack: add --filter=
Message-ID: <YhMC+3FdSEZz22qX@nand.local>
References: <pull.1206.git.git.1643248180.gitgitgadget@gmail.com>
 <pull.1206.v2.git.git.1644372606.gitgitgadget@gmail.com>
 <CAFLLRpJ1aDyLb4qAoQwYDyGdP1_PH8kzLAQCKJpQwiYiapZ5Aw@mail.gmail.com>
 <CB2ACEF7-76A9-4253-AD43-7BC842F9576D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CB2ACEF7-76A9-4253-AD43-7BC842F9576D@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 16, 2022 at 04:07:14PM -0500, John Cai wrote:
> > I don't know whether that is just around naming (--delete-filter /
> > --drop-filter /
> > --expire-filter ?), and/or making the documentation very explicit that
> > this isn't so
> > much "omitting certain objects from a packfile" as irretrievably
> > deleting objects.
>
> Yeah, making the name very clear (I kind of like --delete-filter) would certainly help.
> Also, to have more protection we can either
>
> 1. add a config value that needs to be set to true for repack to remove
> objects (repack.allowDestroyFilter).
>
> 2. --filter is dry-run by default and prints out objects that would have been removed,
> and it has to be combined with another flag --destroy in order for it to actually remove
> objects from the odb.

I share the same concern as Robert and Stolee do. But I think this issue
goes deeper than just naming.

Even if we called this `git repack --delete-filter` and only ran it with
`--i-know-what-im-doing` flag, we would still be leaving repository
corruption on the table, just making it marginally more difficult to
achieve.

I'm not familiar enough with the proposal to comment authoritatively,
but it seems like we should be verifying that there is a promisor remote
which promises any objects that we are about to filter out of the
repository.

I think that this is basically what `pack-objects`'s
`--missing=allow-promisor` does, though I don't think that's the right
tool for this job, either. Because we pack-objects also knows the object
filter, by the time we are ready to construct a pack, we're traversing
the filtered list of objects.

So we don't even bother to call show_object (or, in this case,
builtin/pack-objects.c::show_objecT__ma_allow_promisor) on them.

So I wonder what your thoughts are on having pack-objects only allow an
object to get "filtered out" if a copy of it is promised by some
promisor remote. Alternatively, and perhaps a more straight-forward
option might be to have `git repack` look at any objects that exist in a
pack we're about to delete, but don't exist in any of the packs we are
going to leave around, and make sure that any of those objects are
either unreachable or exist on a promisor remote.

But as it stands right now, I worry that this feature is too easily
misused and could result in unintended repository corruption.

I think verifying that that any objects we're about to delete exist
somewhere should make this safer to use, though even then, I think we're
still open to a TOCTOU race whereby the promisor has the objects when
we're about to delete them (convincing Git that deleting those objects
is OK to do) but gets rid of them after objects have been deleted from
the local copy (leaving no copies of the object around).

So, I don't know exactly what the right path forward is. But I'm curious
to get your thoughts on the above.

Thanks,
Taylor
