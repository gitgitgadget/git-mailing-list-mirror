Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 793AF20A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 23:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbeLNXcu (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 18:32:50 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46774 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbeLNXct (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 18:32:49 -0500
Received: by mail-ed1-f67.google.com with SMTP id o10so6227283edt.13
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 15:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Fe0ZVNQJ6tWFdvwo/cmdSaQcfBZDOMBed9UGR44hyfI=;
        b=UwvgGJDeXp+k18OYTd9nQC9V+7wYfU328zUEAp3ZK1kuwd47ZKKQqQRZrG6vqGaT4h
         16xnBHb1KBeB5eY4FdS3iB8/+hvm9CtcyQg0wKNJeyBsFVJrT0V9R1fK62pRTDVzH/9C
         NyJ8VHVA7T7PNdNMd/tuoOaLwE++q3wjxUgaiCMMe3jRXOJs+2nztdDF1ZYjVCZRV12n
         qqZ9n3nbuNyKG3ayxjOyLkV8sIXcQFs9V6FFOH7AFt0S2KnJFWFsuVy/ymvzgsuZmx9T
         PhZNs6rf/zUfw9FHlY2BraaJ1Sh7OYq29atXXUq/aQI/i1z6ADB99kGV9zYnVfL27KQa
         6pEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Fe0ZVNQJ6tWFdvwo/cmdSaQcfBZDOMBed9UGR44hyfI=;
        b=IUZIn1LRaONoPwQgzuf1NhYMjMnncNd+91O2fqlxQ4QMQ7yHWMkTm3sdtR2hXaJfDF
         OX4JcjHbXjTSgCvmoHuH15dxSNeVqMJX61wqoSUclKrOjpJWCyfTDmfPEyc6GCtfSQJo
         Ylg2XAwdRW5mtfwQfj9QmSlplJ/NOvgbIV44Z6M6sPhPDOgKVh14D7im445aykcxqi4M
         UyhL4JXR6NOtM1B1EigBNDeGa0mJACe4h3OSS3WPwI6lhtS+2IRFauSh64k398DkajNX
         HaOjFM8bVQn66kJAwsSUZtZgfOpSd5S4dQPpVhhkR4UaGYC1kE3qzV3Ge8XQvgqQ+E51
         3zCg==
X-Gm-Message-State: AA+aEWZ8s4QfLTR8lumH24eM9dT3cHyLzKbrm9JbvRfzGduZ3eHG07RX
        fjDGljgJOfc5X6KGow35GMU7queL
X-Google-Smtp-Source: AFSGD/Xpa8yTAIiDUJDLqvqq/VFXd7+me3CZDUd/2P1eER1XwmXKu5fIrMgRxq+068XulL6dCeAnmg==
X-Received: by 2002:a17:906:3488:: with SMTP id g8-v6mr3651358ejb.11.1544830367008;
        Fri, 14 Dec 2018 15:32:47 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id e53sm1815689ede.90.2018.12.14.15.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 15:32:45 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 4/6] revision: implement sparse algorithm
References: <pull.89.v3.git.gitgitgadget@gmail.com> <pull.89.v4.git.gitgitgadget@gmail.com> <c44172c35ece7aafec02c7f3c8438ccca4f69023.1544822533.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <c44172c35ece7aafec02c7f3c8438ccca4f69023.1544822533.git.gitgitgadget@gmail.com>
Date:   Sat, 15 Dec 2018 00:32:44 +0100
Message-ID: <87efaj1y77.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 14 2018, Derrick Stolee via GitGitGadget wrote:

> Despite these potential drawbacks, the benefits of the algorithm
> are clear. By adding a counter to 'add_children_by_path' and
> 'mark_tree_contents_uninteresting', I measured the number of
> parsed trees for the two algorithms in a variety of repos.

Ah, so we take one or the other. I tested this with:

    diff --git a/revision.c b/revision.c
    index 63bf6230dc..e9c67aa550 100644
    --- a/revision.c
    +++ b/revision.c
    @@ -61,6 +61,8 @@ static void mark_tree_contents_uninteresting(struct repository *r,
            struct tree_desc desc;
            struct name_entry entry;

    +       fprintf(stderr, "MTCU\n");
    +
            if (parse_tree_gently(tree, 1) < 0)
                    return;

    @@ -166,6 +168,8 @@ static void add_children_by_path(struct repository *r,
            struct tree_desc desc;
            struct name_entry entry;

    +       fprintf(stderr, "ACBP\n");
    +
            if (!tree)
                    return;

And tried testing my pushing this branch to my git.git:

    $ for v in true false; do git push --delete avar push/sparse; ./git -c pack.usesparse=$v --exec-path=$PWD push avar HEAD 2>&1 | grep -e MTCU -e ACBP | uniq -c; done
    To github.com:avar/git.git
     - [deleted]               push/sparse
         22 ACBP
    To github.com:avar/git.git
     - [deleted]               push/sparse
        184 MTCU

But snipping around a bit from the commit message:

>When enumerating objects to place in a pack-file during 'git
>pack-objects --revs', we discover the "frontier" of commits
>that we care about and the boundary with commit we find
>uninteresting. From that point, we walk trees to discover which
>trees and blobs are uninteresting. Finally, we walk trees from the
>interesting commits to find the interesting objects that are
>placed in the pack.
>[...]
>These improvements will have even larger benefits in the super-
>large Windows repository. In our experiments, we see the
>"Enumerate objects" phase of pack-objects taking 60-80% of the
>end-to-end time of non-trivial pushes, taking longer than the
>network time to send the pack and the server time to verify the
>pack.

If I change my monkeypatch to:

    diff --git a/revision.c b/revision.c
    index 63bf6230dc..9171ca27c5 100644
    --- a/revision.c
    +++ b/revision.c
    @@ -63,0 +64,3 @@ static void mark_tree_contents_uninteresting(struct repository *r,
    +       fprintf(stderr, "MTCU\n");
    +       sleep(1);
    +
    @@ -168,0 +172,3 @@ static void add_children_by_path(struct repository *r,
    +       fprintf(stderr, "ACBP\n");
    +       sleep(1);
    +

We spend a long time printing those out before we ever get to
"Enumerating objects".

Which was where I was trying to test this, i.e. is this a lot of work we
perform before we print out the progress bar, and regardless of this
optimization should have other progress output there, so we can see this
time we're spending on this?
