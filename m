Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F24C2D0DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 18:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E358C214D8
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 18:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DS7IFa1o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgA0SYO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 13:24:14 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42403 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgA0SYN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 13:24:13 -0500
Received: by mail-qt1-f194.google.com with SMTP id j5so8133100qtq.9
        for <git@vger.kernel.org>; Mon, 27 Jan 2020 10:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9XRzC0JsNdfctVCdzMUKQGO5YKLT+1bWQbBw2syO5jU=;
        b=DS7IFa1oOCw9mtv+EvTq8sf7xyAN0lS+evHqDKyfuzOLlccFQD0w1lXZ59+wu1Fyrm
         AwJ/c+Bar0urCx7XIQl240v4+jGwkKe2Rf93v0O0+j7QrCGznqs988DoMh1UTrDGmOo2
         JLLxjY+JlXAanZc6rqNe1J/vLxBIh6TigV2DbzmV2fMhWIfRGRVCCVQsS5GYFWIi3ehk
         KiD74HMm/zUu9PviWagoRYu/xcPmJ1b3opPWTy/zTB+hmBSCu8pwPu5m57hM/GtS7Jyw
         TYsq3XA0lJr6beyplTsfuGUeZxXY9+UJzmaOlQ4yet67Q169mrwO4PlbILumoIcu3dFt
         R8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9XRzC0JsNdfctVCdzMUKQGO5YKLT+1bWQbBw2syO5jU=;
        b=i2Xx9t5YPUp2e/H8NGaZb8gPQdGDVWd9icNxZlHZi397Yaf3nuJqj3SQj90Jp7t+Dj
         bHdsqNCkSx6YJjww3xZflGDrjnO7uyZqPGilgkIKWEQaoEHGr70LJGgq6FmQGbY8yV7/
         EFrulCvCLULGkZa7dLPOPo8Tfbwxjxt9ajKvfEzjyJL3i6jDxJj5uenXUZuPkVdpSRaK
         rYHzN322Q+nOZjK4C9Z/f2DCJhJInJCMeNTzzOlQUWlk0jG1qbqu5NbHDsBUIAiboOtH
         aiEwL4+2BYxaMMeRr1MbEbDVgP4nmMOCnkwRXg3mDviwx+vrMHlcN+tHXXHQymn9LiMe
         Mn0A==
X-Gm-Message-State: APjAAAXok8IoSgk738gWxvfYRhmf1gO/iLCCmGP5WFvGimcCA2kE0/Rx
        3OVgfvutnQ/Auu/JLAyNt/VZ0SU7
X-Google-Smtp-Source: APXvYqyPYQDJCBsTU6AWS34/w0T3jnA7mKQeaVJYguj97wHhiEeV5d5L3y13a9q4UIJJxM7XTVDSYw==
X-Received: by 2002:ac8:367b:: with SMTP id n56mr13699821qtb.258.1580149452569;
        Mon, 27 Jan 2020 10:24:12 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13f:1489:9c97:9d4d:fe0c? ([2001:4898:a800:1010:c5bf:9c97:9d4d:fe0c])
        by smtp.gmail.com with ESMTPSA id 13sm10182740qke.85.2020.01.27.10.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 10:24:11 -0800 (PST)
From:   Garima Singh <garimasigit@gmail.com>
Subject: Re: [PATCH 0/9] [RFC] Changed Paths Bloom Filters
To:     Emily Shaffer <emilyshaffer@google.com>,
        Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, szeder.dev@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com, me@ttaylorr.com,
        peff@peff.net, Junio C Hamano <gitster@pobox.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
 <20200121234055.GN181522@google.com>
Message-ID: <00ccf0f0-9598-171e-d868-2ab0ea97cc7b@gmail.com>
Date:   Mon, 27 Jan 2020 13:24:10 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200121234055.GN181522@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/21/2020 6:40 PM, Emily Shaffer wrote:>> Garima Singh (9):
>>   [1/9] commit-graph: add --changed-paths option to write
> I wonder if this can be combined with 2; without 2 actually the
> documentation is wrong for this one, right? Although I suppose you also
> mentioned 2 perhaps being too long :)
> 

True. The ordering of these commits has been a very subjective discussion. 
Leaving this commit isolated the way it is, does help separate the option
from the bloom filter computation and commit graph write step. 

Also for clarity, I have changed the message for 2/9 to:
`commit-graph: compute Bloom filters for changed paths`

 
>>   [2/9] commit-graph: write changed paths bloom filters
> As I understand it, this one always regenerates the bloom filter pieces,
> and doesn't write it down in the commit-graph file. How much longer does
> that take now than before? I don't have a great feel for how often 'git
> commit-graph' is run, or whether I need to be invoking it manually.
> 

Yes. Computation and writing the bloom filters to the commit-graph file
(2/9 and 5/9) are ideally one time operations per commit. The time taken
depends on the shape and size of the repo since computation involves 
running a full diff. If you look at the discussions and patches exchanged
by Dr. Stolee and Peff: it has improved greatly since this RFC patch. 
My next submission will carry these patches and more concrete numbers for
time and memory. 

Also, `git commit-graph write` is not run very frequently and is ideally
incremental. A full rewrite is usually only done in case there is a 
corruption caught by `git commit-graph verify` in which case, you delete
and rewrite. These are both manual operations. 
See the docs here: 
https://git-scm.com/docs/git-commit-graph

Note: that fetch.writeCommitGraph is now on by default in which case 
new computations happen automatically for newly fetched commits. But 
I am not adding the --changed-paths option to that yet. So computing, 
writing and using bloom filters will still be an opt-in feature 
that users need to manually run. 
 
>>   [7/9] commit-graph: reuse existing bloom filters during write.
> I saw an option to give up if there wasn't an existing bloom filter, but
> I didn't see an option here to force recalculating. 

The way to force recalculation at the moment would be to delete the commit
graph file and write it again. 

Is there a scenario when that would be useful? 

Yes, if there are algorithm or hash version changes in the changed paths logic
we would need to rewrite. Each of the cases I can think of would involve
triggering a recalculation by deleting and rewriting.

What's the mitigation path if:
>  - I have a commit-graph with v0 of the bloom index piece, but update to
>    Git which uses v1?     
   
     Take a look at 5/9, when we are parsing the commit graph: if the code 
     is expected to work with a particular version (hash_version = 1 in the 
     current version), and the commit graph has a different version, we just 
     ignore it. In the future, this is where we could extend this to support 
     multiple versions.

>  - My commit-graph file is corrupted in a way that the bloom filter
>    results are incorrect and I am missing a blob change (and therefore
>    not finding it during the walk)?
         The mitigation for any commit graph corruption is to delete and 
     rewrite. 

     If however, we are confident that the bloom filter computation itself
     is wrong, the immediate mitigations would be to deleting the commit
     graph file and rewriting without the --changed-paths option; and ofc
     report the bug so it can be investigated and fixed. :) 

> Speaking of making sure I understand the change right, I will also
> summarize my own understanding in the hopes that I can be corrected and
> others can learn too ;)
> 
>  - The general idea is that we can write down a hint at the tree level
>    saying "something I own did change this commit"; when we look for an
>    object later, we can skip the commit where it looks like that path
>    didn't change.

The hint we are storing is a bloom filter which answers "No" or "Maybe"
to the question "Did file A change in commit c"
If the answer is No, we can ignore walking that commit. Else, we fall
back to the diff algorithm like before to confirm if the file changed or
not. 

>  - The change is in two pieces: first, to generate the hints per tree
>    (which happens during commit-graph); second, to use those hints to
>    optimize a rev walk (which happens in revision.c patch 8)

Yes. 

>  - When we calculate the hints during commit-graph, we check the diff of
>    each tree compared to its recent ancestor to see if there was a
>    change; if so we calculate a hash for each path and use that as a key
>    for a map from hash to path. After we look through everything changed
>    in the diff, we can add it to a cumulative bloom filter list (one
>    filter per commit) so we have a handy in-memory idea of which paths
>    changed in each commit.
>  - When it's time to do the rev walk, we ask for the bloom filter for
>    each commit and check if that commit's map contains the path to the
>    object we're worried about; if so, then it's OK to unpack the tree
>    and check if the path we are interested in actually did get changed
>    during that commit.

Essentially yes. There are a few implementation specifics this description
is glossing over, but I understand that is the intention. 

 
> Thanks.
>  - Emily

Cheers! 
Garima Singh
