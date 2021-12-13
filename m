Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9ACC433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 19:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241084AbhLMT7l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 14:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242688AbhLMT70 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 14:59:26 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402EBC0613F8
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 11:59:25 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id y12so54995218eda.12
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 11:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=zFSEv+K6Np/y9FSbETL35EOVWl/8iHn387nPenARZW4=;
        b=I3iTyXqrm0OrqHAaKueedVtIYXXdz+22BT60UhA7WSWH+b5wQD+bXwcLQLyW/0j0rv
         p14WCNBVfAuYnsXdHupvVYFBK3kJ9FgKL1Qgs3g0emkMhelk4Of7PUqXROhkRBnNJYxw
         GWJXj9cuV9Q/Loy6LD17bU73CViFRU6qjmFHyyukf74o9YUbjI+tFoUt8SdLJbb1VMEu
         IWRyCpJXTOonYRrpe5fMcqiazMxyL1S7PHdVW7Vlfxc048mQviPxNmslqQ4b7yg00cnb
         cpAWGcMuaFYnaUY7cQaF0uK1r4mPzBV5IJMm0VME+BVjdXC9otnVwQO/y9eY0zKqWiz3
         Mh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=zFSEv+K6Np/y9FSbETL35EOVWl/8iHn387nPenARZW4=;
        b=UD8ctIyizaVaeLW3TP3nzRpUOlca1JQJMaoUQvoZbIHTRX7N0WKOiIOTuxre8Gj12X
         Qh6Es3DlJOo3lvnzUXrzjtbFbVixx3fB2+OVvWzPrt7rLKS3+D4bnKdehOCkKen0moQp
         QwHvt59aKNs7zwat17Lif0fIHn2mbuPIcGEvj9p9PRZv+mAYM94HTy9tu7r8ubwDxwRC
         KXI8OZ5cLsORWHSOcLBO+z04hyMXDEKicb+Hq48HGx4m7hdOT0vqSs5BC72+YaoyNPUL
         awikM6KR60LHgSpLnD/yAjZcbkiTsOGVBc4quQyPTfe4HaIGT8vH7j8xdc/vV0b/Pt1X
         qmng==
X-Gm-Message-State: AOAM530DsQs1Wbw8bO6fkJbtXkYI1BzqVaAr52qldw9XTvghB4hZ6FE/
        Ex7day40ZXyu7uzfJqtZXHM=
X-Google-Smtp-Source: ABdhPJzg9QdmXjQm5IzFEkv4zAP26QJrJ5wb2DQPmI7ZPSbwGXrlWnzFT7W2N/CW5IlwCIY0LLLDoQ==
X-Received: by 2002:a17:907:6d92:: with SMTP id sb18mr580703ejc.594.1639425563736;
        Mon, 13 Dec 2021 11:59:23 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id lv19sm6391931ejb.54.2021.12.13.11.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 11:59:23 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mwrTm-000w8I-MA;
        Mon, 13 Dec 2021 20:59:22 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] checkout: introduce "--to-branch" option
Date:   Mon, 13 Dec 2021 20:55:00 +0100
References: <pull.1095.git.1639117329.gitgitgadget@gmail.com>
        <254b352e31029d8151eb6a974fdf8c127340cf79.1639117329.git.gitgitgadget@gmail.com>
        <xmqq5yrwm7km.fsf@gitster.g>
        <CAOLTT8Rx9M9=a5M8UeDrJqMayTXo=dvdanVDLi7QLdPX8W_Tzw@mail.gmail.com>
        <xmqqy24pk6f4.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqy24pk6f4.fsf@gitster.g>
Message-ID: <211213.86r1ag6ztx.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Dec 12 2021, Junio C Hamano wrote:

> ZheNing Hu <adlternative@gmail.com> writes:
>
>>> It is unclear if you mean "dev1" exactly point at the commit tagged
>>> as v1.1, or you want the branch "dev1" that is a descedanant of
>>> v1.1.  Without telling that to the reader, the above explanation is
>>> useless.
>>>
>>
>> I meant the former.
>>
>>> And whether you meant the former or the latter, neither use case does
>>> not make much sense.
>>> ...
>>> So, "--to-branch v1.1" that finds and checks out a branch whose tip
>>> exactly points at v1.1 would be pretty useless.
>> ...
>> "git branch --contains v1.1" can find all branches whose history contains the
>>  commit tagged as v1.1. So what if "git checkout --contains v1.1"?
>
> I already said, whether you meant "the only branch that points
> exactly at" or "the only branch that contains", the feature does not
> make sense.  Forcing users to keep only a single branch that either
> points at a given tag is simply impossible and also useless.  Once
> the branch gains even a single commit, it will no loger be pointing
> at the tag, so "let's prepare a branch pointing at v1.1 just in case
> when I want to start working from there" would not be a good
> workflow to begin with.  Forcing users to keep only a single branch
> that contains a given tag would encourage even a worse workflow to
> throw in unrelated things, whose only commonality is that they all
> want to fork from a single tag, into a single branch.
>
> IOW, there is nothing we want to add to "git checkout/switch" for
> this topic.  "git checkout --contains $tag" smells like a solution
> looking for a problem.

I don't see how it's fundimentally different than the DWIM logic of
taking "<name>" and seeing that there's only one "refs/heads/<name>",
and giving up in other cases where we get ambiguous reference names that
we can't resolve.

I.e. I think this is probably useful for some, it's a common workflow to
have a 1=1 relationship like this, and if it's 1=many we can just handle
it as we do with ambiguous ref, or ambiguous short OIDs for that matter.

But as I noted upthread I really don't see this making sense as a
per-command thing, as opposed to some extension of the "peel"
syntax. I.e. we should (or at least expose it as such to the user)
interpret that sort of argument/newx syntax before "git checkout" et al
get to it, so from a UX perspective you could feed a ^{oid2ref} (or
whatever it would be called) to rev-parse, checkout etc. etc.
