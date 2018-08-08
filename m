Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CF94208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 16:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeHHSzV (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 14:55:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36562 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbeHHSzU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 14:55:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9-v6so2589408wro.3
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 09:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uYMEpADKGNp0ZzcssTCEfN6ASio+iAWTkK2DnT5ZlD0=;
        b=F+vVKcxF2w/t8pQD07s0j3Wl9tAc9DXHlw9adb98k7nlWGLiLaQMfzUJcXxEamLjo9
         3xE/1J89lsmgjrRoKBBHLMDK6/GzLyOdbBl8C1DActekrxbsoaKeFSr013WQSV/eu7hA
         SqeRo8VKTbWL0sO1APoxye7SuRAq3ig/vWYaJqAlOvYmqoN8UN6XB82RsUcrZJrOQ3xm
         YeWg10XYy6/VyTXEDyNWJCmr5Rngd/yRXOoJ96nIXQ2OZPsKHPHH3TlahDsrsXHjdsJd
         DAvoFiLPzZefg4Q7v1n+iyk2cJ8/5XugG+1d+Czds/8PAIkEg8D1+YS9SDlQjCm3iU9q
         xXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uYMEpADKGNp0ZzcssTCEfN6ASio+iAWTkK2DnT5ZlD0=;
        b=ijl8xyR+ud5KCH+XHzYzU4tKzORXLTNppLx5vd48FAwCIqMOoiZlL6Ugy5UeG0eXDG
         6Roxprfv6sgZhXjb4EL158ViCMPOETlswWMSqe214kKen6dC5icJBlSxpjYucxnoCOzW
         qxSfJGZ1RM15SWT979JtPy7VdVSVk8PZ399fzk8igdA4hV1KsG/5RYKs6m+FnB0aQl+2
         QUcfrG+MkncI53fpTHztR2/iIKCW5uLxStLwymVj0ibCWjm5SkKh5Wk1Ewc3mBnj7smZ
         lZdrBJ9LcGt4iX1p4+6TL0FMHshGvRJii4X234lYagXz9FMoUgC/N3r3y3gST8scpa7S
         pnVQ==
X-Gm-Message-State: AOUpUlEblPzsA/Et8rSOV/2MDWL6a/6ehckXhJDUQs1ggvSb11/UoLkw
        OCwOrU4t1RyieMhBQdjRFfgzQSNO
X-Google-Smtp-Source: AA+uWPwyV/EQXrdRoveFWLsNdIsRsuPTpapKU7GsB1WWJ3dHVyTdr7TZlnJNPgSmYgYfkzxZ2iTndw==
X-Received: by 2002:adf:8004:: with SMTP id 4-v6mr2494524wrk.130.1533746091290;
        Wed, 08 Aug 2018 09:34:51 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x62-v6sm17758772wmg.1.2018.08.08.09.34.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Aug 2018 09:34:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com
Subject: Re: [PATCH 2/2] repack: repack promisor objects if -a or -A is set
References: <xmqq7el1kdlt.fsf@gitster-ct.c.googlers.com>
        <20180807232528.182492-1-jonathantanmy@google.com>
Date:   Wed, 08 Aug 2018 09:34:50 -0700
In-Reply-To: <20180807232528.182492-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 7 Aug 2018 16:25:28 -0700")
Message-ID: <xmqqd0usizpx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> Just a note (and a request-for-sanity-check) and not meant to be a
>> request to update the code, but with a still-in-pu 4b757a40 ("Use
>> remote_odb_get_direct() and has_remote_odb()", 2018-08-02) in
>> flight, repository_format_partial_clone is now gone.
>> ...
> Thanks for the heads-up. This makes me realize that even the current
> precondition (repository_format_partial_clone) is not an exact one - I
> should only be doing this if I know that there is at least one promisor
> object (if not, in the rare case that a repo is configured to be partial
> but does not have any promisor objects, repack will generate an empty
> packfile). In the next reroll, I'll take care of this, which should
> avoid this merge issue too.

I think that it is a good change, regardless of the semantic
conflict with any other topic, to look at the .promisor packs and
not look at the partial clone extension for this "do we want to
coalesce .promisor packs into one?" application.  You only want to
do so when you have two or more such packs; being in partial clone
might be a preconditon for having such packs, but it is overly loose.

In any case, remote-odb topic is turning out to be more trouble than
I originally thought; in the same change that removes the variable,
it actually removes the support for a repository configured with a
partial clone extension, and causes a hard error in t0410, breaking
test of 'pu'.  I do not know how many people actually use partial
clone right now, but their repositories would be broken the same way
when they update Git, if we merge that topic in its current shape.

I am dropping it from 'pu' for today's integration cycle.
