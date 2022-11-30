Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCF7C4321E
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 16:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiK3Qh6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 11:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiK3Qhs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 11:37:48 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B50B1CFF3
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 08:37:44 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id d14so5808888ilq.11
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 08:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zb1BapGHpnLtgImOelLe8UQc5wW87LU+s75JGTGvnxs=;
        b=TJHhvzRyGiJZmJ7rlLj21Hl/K5OZkQmrfcrkxd8pDNd/Dhxf5J+Dq2lo9IlF2rQeDK
         oNLz2/mgj1dAl/LFc54tm65CESDzjEupNLd9dWWJ0kIfp/wD0VC1flEDhlZKoOsCM5Gw
         peo0ta+J4E/B9rGsP87eYAlK3n1ckMNW1wfgIILUf4mT0pxeJytdC6VH/2uPo0vwFj2G
         bsgmmoAemntil1t9aM5N2/krZXcT4V3I/xGg1+/R6JZPl/W1L3kc1Iw0AfPtUC3oNXAr
         Q9U5k3zz3i1CZygoOXg9/1VB8uMVWQvB0k0kb5iNQ1p77UMJFp9/6DS/V8qcjWQbTDYU
         O2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zb1BapGHpnLtgImOelLe8UQc5wW87LU+s75JGTGvnxs=;
        b=5diiNRe0TvSNVR5yWXa+EAJOHIwYxLNapwtg5atVaWHI4hRIuo0TfGOCDnxcpYRftU
         eOj5Rzi5RMOFoKQBHmTQ0fIJnT0jacgPRIInQ8HvoqgxFuCt+72rq0TO3PAFak1S9yFx
         jlBzeaG2KmHdN0ZeqYtUuxkABrBGwT6qjtUiQRFdR6cHlq3xnbw2rxDa6fA7n7ae8YoC
         wnb5CQiZFTPEARM55AQ+pciI7D0/JZtzdkZftkA0Jaiw3P4LLHu7TP22r5sqoqDJ3x3X
         FCSW80ANZ1J+QeHeiwRl8DYZ4FWQ/CZetvTXop9WoLz+DIcRyy4Dv2RIRN19fmW42k4r
         1ujQ==
X-Gm-Message-State: ANoB5pnwpfw5wf7yeYZyK0rlqe1B91kDfJyGR+ksyBWJuXjzUuSHuLc4
        c5wBq/7cHQo6B5s1OCcyBAkcqA==
X-Google-Smtp-Source: AA0mqf7TcMBs4TTmi5A86WOhhleWVN2rV5q6t/YA7SVickrBCvHWmoTZTZgvyGSe4dyAR5HeOJVLlQ==
X-Received: by 2002:a92:6809:0:b0:2f9:4d92:5b2a with SMTP id d9-20020a926809000000b002f94d925b2amr19649825ilc.177.1669826263717;
        Wed, 30 Nov 2022 08:37:43 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k17-20020a0566022d9100b006a129b10229sm684398iow.31.2022.11.30.08.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 08:37:43 -0800 (PST)
Date:   Wed, 30 Nov 2022 11:37:41 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 00/30] [RFC] extensions.refFormat and packed-refs v2 file
 format
Message-ID: <Y4eG1SDxBqjwUhwM@nand.local>
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
 <CAFQ2z_MZd150kQNTcxaDRVvALpZcCUbRj_81pt-VBY8DRaoRNw@mail.gmail.com>
 <f1c45bd5-692e-85db-90c3-c516003f47e5@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f1c45bd5-692e-85db-90c3-c516003f47e5@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2022 at 10:16:52AM -0500, Derrick Stolee wrote:
> > Do you mean 'enumerate refs' ? Why would you want to count refs by prefix?
>
> * There was a GitHub feature that counted refs and tags, but wanted to
>   ignore internal ref prefixes (outside of refs/heads/* or refs/tags/*).
>   It turns out that we didn't actually need the full count but an
>   existence indicator, but it would be helpful to quickly identify how
>   many branches or tags are in a repository at a glance. Packed-refs v1
>   requires scanning the whole file while packed-refs v2 does a fixed
>   number of binary searches followed by a subtraction of row indexes.

True. On the surface, it seemed odd to use a function which returns
something like:

    { "refs/heads/*" => NNNN, "refs/tags/*" => MMMM }

only to check whether or not NNNN and MMMM are zero or non-zero.

But there's a little more to the story. That emptiness check does occur
at the beginning of many page loads. But when it responds "non-empty",
we then care about how many branches and tags there actually are.

So calling count_refs() (the name of the internal RPC that powers all of
this) was an optimization written under the assumption that we actually
are going to ask about the exact number of branches/tags very shortly
after querying for emptiness.

It turns out that empirically it's faster to do something like:

    $ git show-ref --[heads|tags] | head -n 1

to check if there are any branches and tags at all[^1], and then a
follow up 'git show-ref --heads | wc -l' to check how many there are.

But it would be nice to do both operations quickly without having
actually scan all of the entries in each prefix.

Thanks,
Taylor

[^1]: Some may remember my series in
  https://lore.kernel.org/git/cover.1654552560.git.me@ttaylorr.com/
  which replaced '| head -n 1' with a '--count=1' option. This matches
  what GitHub runs in production where piping one command to another
  from Ruby is unfortunately quite complicated.
