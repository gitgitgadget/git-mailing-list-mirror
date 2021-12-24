Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF685C433EF
	for <git@archiver.kernel.org>; Fri, 24 Dec 2021 17:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353261AbhLXQ7L (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 11:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236414AbhLXQ7K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 11:59:10 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4770FC061401
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 08:59:10 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id b13so35263835edd.8
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 08:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=zUbKjhVR6fxuEMGiQCTULftiJj7VCIs12k/tZWuXxNs=;
        b=BCdFeqB92PXm6JMJzO0kiy64WDD4eYP8INIHanMLQmHN5xS+H+DoKdkp7XVyA+3cCg
         n4D8ES8UUjBSQGKVz2WcR07pVpMVotPRIKlpKwJhRX2cevFGWOZiA3NCizbPb/5s9PfS
         82NWYKrEG7vA7J6zJJQgahfY24qzNRY2+iaAY5RKZCtgC7eShVjmo3PAlGLqepmA9vaR
         ZR3ws6DhJ4QN5QbiUgvp5z6anuuRo3dJAdjgeOf6C/7ZMe7cAbdnGIKM8A3qZrwO3d58
         NWsw91vhkahTSC8L+avbE1qTboljwMdW9721nV1ajaw8gc9XnZz+En5tT3P3xmPg68LC
         OhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=zUbKjhVR6fxuEMGiQCTULftiJj7VCIs12k/tZWuXxNs=;
        b=Xe5GPbpUv94FsM7olKBxvBNn1EtP2Pd8sUy3If+Mea6D1uvdts4I1G1eCO0vGg2XiH
         SWUwxQyLBcjd+3YUP1GzOzCWfk6NoMLglMIQ9pz7y4aHBXk6v//EwZjke7muZIuGGF42
         JhBdp+MQ6Fr3OxN9oAqzv3loqu3YbtPkCPMKZT+G93iUEq6eZ8FcpP19Gvu7Hqd5iuyh
         37R+Vzm2IACPYKs+hkg6FLGk+BR6o22U8trKl6TFv8jCtz5IJOniBhm8X0HXlwNzzFVn
         BcXSadbCIJIwMPA3r8GMzMEf025GsFJ3QWFw0LB/I3iz1v0nvw0CDtBx2tHL5AkGTdno
         jRRg==
X-Gm-Message-State: AOAM533Hzvlg4xlbaR/9YwpVE3WBxvRwUEJU4GasxvaPfZbSHyBaaR7e
        Xp05C9gYKuNx0i9m6aQ2i8+AlHv+Znn+mg==
X-Google-Smtp-Source: ABdhPJxfytkg9b3E4rXbmWYO2JPqDtdB5ybju9ZM7+fu4UDH/C3P2QwISxhmU2PqhpPNHhcAW1Hi6A==
X-Received: by 2002:a17:907:97d5:: with SMTP id js21mr5915094ejc.445.1640365148265;
        Fri, 24 Dec 2021 08:59:08 -0800 (PST)
Received: from gmgdl (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id r24sm3184753edv.18.2021.12.24.08.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 08:59:07 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n0nuN-0002Np-1m;
        Fri, 24 Dec 2021 17:59:07 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v5 13/16] reftable: remove outdated file reftable.c
Date:   Fri, 24 Dec 2021 17:53:30 +0100
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
 <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
 <4175089ec432da921d158fec9ccb1902be710af6.1640199396.git.gitgitgadget@gmail.com>
 <xmqqmtksfe3j.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqmtksfe3j.fsf@gitster.g>
Message-ID: <211224.86v8zegcro.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 22 2021, Junio C Hamano wrote:

> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Han-Wen Nienhuys <hanwen@google.com>
>>
>> This was renamed to generic.c, but the origin was never removed
>>
>> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
>> ---
>>  reftable/reftable.c | 115 --------------------------------------------
>>  1 file changed, 115 deletions(-)
>>  delete mode 100644 reftable/reftable.c
>
> That's embarrassing for all reviewers of past reftable patches.

As one of those reviewers: I think it suggests something different:

Various people looked it over, but this amount of code is just too much
for someone to review in one sitting, so it's not unexpected that
various things like this slipped through.

The current landing of this topic on "master" is based on a plan I
suggested, i.e. to have the library and its own tests in "master" first,
and not to do any of the integration yet.

Exactly because we expected that we would not be getting any of this
right the first time around.

So if anything I think these current topics and recent reftable activity
suggest that we should have been more willing to get it into "master"
earlier, and not wait until all bugs in it were solved beforehand.

I.e. there's bugs in the code, but they're well-contained, since nothing
in-tree uses it except its own tests.

And by having merged it down we're benefiting from more eyes, both in
terms of human review, and in the review of various tooling (like
coverity) that's being run on "master" but not on some random branch
that's languishing in "seen" for months.
