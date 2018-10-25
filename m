Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DC091F454
	for <e@80x24.org>; Thu, 25 Oct 2018 08:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbeJYRAo (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 13:00:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44036 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbeJYRAo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 13:00:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id q6-v6so8322766wrw.11
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 01:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ZZwCVdsB203qg+EK2JCsAIhr9/qbgLfOAGK6wamKblc=;
        b=NaYRfxSZz24ovp3nwKmD1qmDrbsnT5SyN9SO70uDc/bEWLyEkDTabRrhJxN58t+5te
         yezQ+gtcoxJ0DrP83UjtDOlTBZxyv13Rg6GFNaTr/VIJZ4Ey6z1/qK7IavZ6pNgcj6jk
         7eRzgPJ6vIScPhDld9hi5tjpsj6MYMaQ7AX/v3QM0fmBrBt2JCOCZBag1i+SnPXqKGq+
         JBZwkom7DRBhFvGl8jrlCRBLrDf9LHaQQiHm12GdYttiEwrSUNM0IJVwuX4YjamxGAqa
         wQ6sibrAyvrooz9n0xLIateW+AiAikpvVh4MPhUtfnNTgJhJxlq9tdbpcKcLb56h25+m
         6eGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ZZwCVdsB203qg+EK2JCsAIhr9/qbgLfOAGK6wamKblc=;
        b=giVWdyQ4juxh9E++/UpPevItQK9t3ZbcrSYAfxjxr+Vbs5TUTIcJUtCFdgBYDHyMQZ
         z8hIS+7LVn9ByX1gEtS+G11ii0Rs0c5EHTV7BN2fUwhTNWismOIkZmCm/xJszjeMV64x
         Ag4Ww3kaAnAKSZWFEI14fd0j6xBG4PZTcI+TGRNx70i3/uXeI1DxqqDJKfm4CfPJKkyH
         ttsudlAUP37yw4gUmg1KnrfIkuY2tRwN5WLwquaPogWaLaMRmzdUOMLM81Y3RjbM/ZMm
         lNn7RrGVDhSwZSjjOSdrabveh/PYc25WYrFwJUtuQ7KuqjEMYrfn7q9K66Nk+wgIHRmN
         yNZg==
X-Gm-Message-State: AGRZ1gIeA/LO3qOprSelWcfVb1uDYuaI/dmPE/UwsXLAdQn97LzmaNdB
        MZcjiVHfaTdVQ+BTxcHo1Kw=
X-Google-Smtp-Source: AJdET5fncbcyjqQ5oghmj81N0ayemM64hdEd15Km4JMsZnRN4UmPRrvRqKWtLjr3ezWnsj7isFVTlA==
X-Received: by 2002:adf:f941:: with SMTP id q1-v6mr776431wrr.151.1540456139693;
        Thu, 25 Oct 2018 01:28:59 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c14-v6sm988664wmh.44.2018.10.25.01.28.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 01:28:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 4/7] revision.c: begin refactoring --topo-order logic
References: <pull.25.v3.git.gitgitgadget@gmail.com>
        <pull.25.v4.git.gitgitgadget@gmail.com>
        <cd9eef96885a811196ab0b851a98de4455b950ab.1539729393.git.gitgitgadget@gmail.com>
        <86h8hfguqc.fsf@gmail.com>
        <xmqqa7n6zswl.fsf@gitster-ct.c.googlers.com>
        <bb91d5bb-4220-97b9-dd78-5aed39033e58@gmail.com>
Date:   Thu, 25 Oct 2018 17:28:57 +0900
In-Reply-To: <bb91d5bb-4220-97b9-dd78-5aed39033e58@gmail.com> (Derrick
        Stolee's message of "Sun, 21 Oct 2018 21:51:10 -0400")
Message-ID: <xmqqk1m6ig52.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>     time git log --topo-order -10 master >/dev/null
>
>     time git log --topo-order -10 maint..master >/dev/null
>
> I get 0.39s for the first call and 0.01s for the second. (Note: I
> specified "-10" to ensure we are only writing 10 commits and the
> output size does not factor into the time.) This is because the first
> walks the entire history, while the second uses the heuristic walk to
> identify a much smaller subgraph that the topo-order algorithm uses.

The algorithm can be fooled by skewed timestamps (i.e. that SLOP
thing tries to work around), but is helped by being able to leave
early, and it will give us the correct answer as long as there is no
timestamp inversion.

But monotonically increasing "timestamp" without inversion is what
we invented "generation numbers" for, no?  When there is no
timestamp inversion, would a walk based on commit timestamps walk
smaller set than a walk based on commit generation numbers?

> Just as before, by using this algorithm for the B..A case, we are
> adding an extra restriction on the algorithm: always be correct. This
> results in us walking a larger set (everything reachable from B or A
> with generation number at least the smallest generation of a commit
> reachable from only one).
>
> I believe this can be handled by using a smarter generation number
> (one that relies on commit date as a heuristic, but still have enough
> information to guarantee topological relationships), and I've already
> started testing a few of these directions.

Good ot hear.
