Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4368EC38A29
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 15:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 219B62084D
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 15:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gouh57xT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407220AbgDNPE6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407084AbgDNPEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Apr 2020 11:04:09 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD99C061A0C
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 08:04:09 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id k21so1579409otl.5
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 08:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nwwL97TaLqCN20CL065+Y3ss+zlDdO4s1arc7cqorHM=;
        b=Gouh57xT6iZZkYLTK5Im6Wo6yqmcYfd7W+JKFDVlOyuCDVdtct43l0vb/nEeQQvCTM
         MC9vol5MRA4LgJBc6Q1GtHnS/8UItJMMQVFi1fxBfNFuuQGiVdGgUY/eXedXjBEPo3na
         QPfW77oXLNuKxnw+DU09zN4i/HHLeC9N4GM1Pd/Rpm5vZUNneS5FCSKN0a0EYq4jSSNH
         rRy1F25KzkV6k5lPm7jp8GLVjddho3607Hu4qfo3eqXwH7JDwZGCNMAGz8OOdagc1gcH
         tGEe7b11a1zkV4/6DfF6reOJPEsgrs7sSjj92Q8c+k/s9Cfjx4mUcnts4DvDGTO145W7
         lCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nwwL97TaLqCN20CL065+Y3ss+zlDdO4s1arc7cqorHM=;
        b=nJsLuKfhTnNlRguvBbu2BZb01AOaC3pVBIojCn4yhWrDmrJkFBNqlVGzaK/ZyvUlya
         Qouf4gDVkQkxwMFIoIlk1lTBdd8lzvLjn2e4HBELvXd2jW98VGJch/VFgZ5WasR1Wzvf
         oiccPQTVciWmQSIScdth0fV7Ycj14z8P2jcV9hqeinkEBuz+jSFpMSYwN7/p8e80xmEU
         oSGNe+4mtg+u3yv1l6J/P223YXJz61vFYdgXCzM+jpijYoMJnY21cMO7FLanVzDa1zDi
         MxikP53rdYaTi+6bQdo4u0cSfW0wf61Hk+rA6CX92q7CeSuvCZforO1BONLqCIH7GY0L
         vO0Q==
X-Gm-Message-State: AGi0Puaip1QXu2a3HoGIkXtEbHTzf7y9CaIA49ZDpnhhURtspVTF4B+T
        fei40RvLUjptsYpQIN7GjZyiY+QhLQ4=
X-Google-Smtp-Source: APiQypJsBncaTi2BXqw//jmu45PyS5BpxoflyRzmSat+2vgt7gVD9ybrH7cZA1CrzaGQ3Xh7cpTowg==
X-Received: by 2002:a9d:7a47:: with SMTP id z7mr19312902otm.290.1586876648735;
        Tue, 14 Apr 2020 08:04:08 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id x125sm5715464oia.50.2020.04.14.08.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 08:04:08 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] commit: write commit-graph with Bloom filters
To:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jnareb@gmail.com, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
 <pull.609.v2.git.1586789126.gitgitgadget@gmail.com>
 <7e8f1aed1138ab2a52a8957ac95895ac9effd933.1586789126.git.gitgitgadget@gmail.com>
 <20200413161245.GE59601@syl.local> <xmqqh7xnauxc.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <74e4e8d6-d401-081d-14cc-c4b6087bdeda@gmail.com>
Date:   Tue, 14 Apr 2020 11:04:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <xmqqh7xnauxc.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/13/2020 6:21 PM, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> 
>> Hmm. I'm not crazy about a library function looking at 'GIT_TEST_*'
>> environment variables and potentially ignoring its arguments, but given
>> the discussion we had in v1, I don't feel strongly enough to recommend
>> that you change this.
>>
>> For what it's worth, I think that 'write_commit_graph' could behave more
>> purely if callers checked 'GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS' and set
>> 'flags' appropriately from the outside,...
> 
> Yeah, I agree that it would be a lot cleaner if that is easy to
> arrange.  I have a suspicion that Derrick already tried and the
> resulting code looked messier and was discarded?

Perhaps I could fix both concerns by

1. Use a macro instead of a library call.

2. Check the _CHANGED_PATHS variable in the macro.

The macro would look like this:


#define git_test_write_commit_graph_or_die() \
	if (git_env_bool(GIT_TEST_COMMIT_GRAPH, 0)) { \
		int flags = 0; \
		if (git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0)) \
			flags = COMMIT_GRAPH_WRITE_BLOOM_FILTERS; \
		if (write_commit_graph_reachable( \
			the_repository->objects->odb, flags, NULL)) \
			die("failed to write commit-graph under GIT_TEST_COMMIT_GRAPH"); \
	}

Thanks,
-Stolee
