Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDEDC433FE
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 18:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiJESJE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 14:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiJESJD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 14:09:03 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B140BDEED
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 11:09:02 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y8so2062345pfp.13
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 11:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fLlclyrFX4TJFVM/VNzsK9Ior2oDa12cEY8EftNnfQ4=;
        b=alVQMMW3cVDVvmASYHs8pIP+Uzijpl0e4G4NZvVgSduD+oXxbXwzgZ2CGjoz5Df1JX
         WOUY0HzqA+VP7q2tPFH3uvv+Cls0iO2d8AyfPZu4RnV1yG3i5f8B4Lv6Qbo/y0ZepRQa
         pq83I5w6GML8YIvFg/xiuU9mcQMP1C929Wz5FtOMTqkSwweHYLmqUl7a5yX6LRMOfk3H
         i220b0aCYum81CNP7QBmOkb3cDPuvWgBY6UA5AtZ7v6cD381cUIf37CfQSTZbaoe7aKC
         W3QBvGdKn84i3JxSWKepemAXBIKU4PaM7GvSnowA3tEetJMvvMe6znkcHH1HkdnC3gzR
         uLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fLlclyrFX4TJFVM/VNzsK9Ior2oDa12cEY8EftNnfQ4=;
        b=a8nr7tfW8ok31h1yLkk0IV795cu8NdXGP03gtaoBY1ejKgnogJlYISoojNZeBFqVU9
         PE8o64NoBdqbRid99IvcpsDm/X/X/yyDewD8iEn6lQk1m/wkPPvknrQ01AA1RlSo9tTR
         8UKOeojMCFPD540+Amj47/fNylhlbLND3ikOZYWJufag5n7LPT929fjonNa4Dmg8rJ9X
         zqtg9bQYl6qq4yZnTYuoCtZgiOBFscsQV20Y31ColFfo4y2sYGzFeWXxf5tlZD1D9H3Y
         UpnlueXOYhUoHtbzey5H4CI2p54KwNti088JfcEiGXuY/R/6mVGAbPFO8yWo41eqHX7K
         iY4Q==
X-Gm-Message-State: ACrzQf1Rxbdl+5SP2QCxH+wa4W+pQt9m5Ajq0Z8+IywZY4btEDg5m/aF
        YiqJEZTsHitvmaDxWIgz000o/vD4BMM=
X-Google-Smtp-Source: AMsMyM4360ivPZ9ryRC8VQgzV0Z9YvZI3sQy4HBfGT9vr07pPBlUvZlAT0shXQbs94rCn1lkjK0R2A==
X-Received: by 2002:a05:6a00:1412:b0:557:d887:2025 with SMTP id l18-20020a056a00141200b00557d8872025mr996073pfu.39.1664993342102;
        Wed, 05 Oct 2022 11:09:02 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id l19-20020a170902d35300b00176dd41320dsm10784742plk.119.2022.10.05.11.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 11:09:01 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Fail early when partial clone prefetch fails
References: <cover.1664316642.git.jonathantanmy@google.com>
        <cover.1664917853.git.jonathantanmy@google.com>
Date:   Wed, 05 Oct 2022 11:09:01 -0700
In-Reply-To: <cover.1664917853.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Tue, 4 Oct 2022 14:13:39 -0700")
Message-ID: <xmqqy1tup2gy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Thanks everyone for your comments. I don't think that there is a test 
> for when a lazy fetch fails, for some reason, so I added one.
>
> Jonathan Tan (2):
>   promisor-remote: remove a return value
>   promisor-remote: die upon failing fetch
>
>  object-file.c            |  4 ----
>  promisor-remote.c        | 23 ++++++++++++++---------
>  promisor-remote.h        | 11 +++++------
>  t/t0410-partial-clone.sh | 14 ++++++++++++++
>  4 files changed, 33 insertions(+), 19 deletions(-)

Thanks.  Will replace.

I think the C/H code was good already in the first round, so
hopefully this can go 'next' early in this cycle.

>
> Range-diff against v1:
> 1:  fdb35bc9a6 ! 1:  207332c2df promisor-remote: remove a return value
>     @@ Commit message
>          No caller of promisor_remote_get_direct() is checking its return value,
>          so remove it.
>      
>     +    Not checking the return value means that the user would not know
>     +    whether the failure of reading an object is due to the promisor remote
>     +    not supplying the object or because of local repository corruption, but
>     +    this will be fixed in a subsequent patch.
>     +
>          Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
>          Signed-off-by: Junio C Hamano <gitster@pobox.com>
>      
> 2:  06a649b01a ! 2:  9bbf130c2c promisor-remote: die upon failing fetch
>     @@ Commit message
>          When this batch prefetch fails, these commands fall back to the
>          sequential fetches. But at $DAYJOB we have noticed that this results in
>          a bad user experience: a command would take unexpectedly long to finish
>     -    if the batch prefetch would fail for some intermittent reason, but all
>     -    subsequent fetches would work. It would be a better user experience for
>     -    such a command would just fail.
>     +    (and possibly use up a lot of bandwidth) if the batch prefetch would
>     +    fail for some intermittent reason, but all subsequent fetches would
>     +    work. It would be a better user experience for such a command would
>     +    just fail.
>      
>          Therefore, make it a fatal error if the prefetch fails and at least one
>          object being fetched is known to be a promisor object. (The latter
>     @@ promisor-remote.c: void promisor_remote_get_direct(struct repository *repo,
>       	if (to_free)
>       		free(remaining_oids);
>       }
>     +
>     + ## t/t0410-partial-clone.sh ##
>     +@@ t/t0410-partial-clone.sh: test_expect_success 'fetching of missing objects' '
>     + 	grep "$HASH" out
>     + '
>     + 
>     ++test_expect_success 'fetching of a promised object that promisor remote no longer has' '
>     ++	rm -f err &&
>     ++	test_create_repo unreliable-server &&
>     ++	git -C unreliable-server config uploadpack.allowanysha1inwant 1 &&
>     ++	git -C unreliable-server config uploadpack.allowfilter 1 &&
>     ++	test_commit -C unreliable-server foo &&
>     ++
>     ++	git clone --filter=blob:none --no-checkout "file://$(pwd)/unreliable-server" unreliable-client &&
>     ++
>     ++	rm -rf unreliable-server/.git/objects/* &&
>     ++	test_must_fail git -C unreliable-client checkout HEAD 2>err &&
>     ++	grep "could not fetch.*from promisor remote" err
>     ++'
>     ++
>     + test_expect_success 'fetching of missing objects works with ref-in-want enabled' '
>     + 	# ref-in-want requires protocol version 2
>     + 	git -C server config protocol.version 2 &&
