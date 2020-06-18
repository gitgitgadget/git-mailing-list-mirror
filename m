Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5478EC433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 13:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 292562083B
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 13:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duw/i4BA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgFRNcl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 09:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbgFRNck (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 09:32:40 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31C1C06174E
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 06:32:40 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id x202so5052935oix.11
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 06:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=NeXFdGWOL4/RqtvVzd3pBifIxC9Vir/vlmZ8h05hf6c=;
        b=duw/i4BAqP6AXR5KFsnvA//ZMnhhxGMQhSqgqrAridCNbcfZc/qM4II5O7NHUg18Pu
         FHU+jjMdX4Vb47Y7wfHSnxxOuhFq9/f/XKGnpAvTLRu0Ikn3ysBTZ0XGMGVQOB0OENEk
         MBnwsbAbeXEnuNQzV21wblC4pwK7/mnptUdH5hcUgGV0syaQJRQblo5m8OqcqYtcGnJX
         UFJIY9eVgKpkdNiYfYvHIGYuHcF+SwjX2e1QtfqK3cH3HRbwqoO8EtQayWoVHJyUIWsZ
         ya58QMpsrTQpNvy+pjsx+WDcL7sIV/qrd2X3bTtAt4m1B0HUHQumvZC7Lu5TjxPSnrjE
         htUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NeXFdGWOL4/RqtvVzd3pBifIxC9Vir/vlmZ8h05hf6c=;
        b=h4o9FBvGyR4MWL1TmYn5KFkMIsTpmCU1k8p2yWLC2+Q8hoXmDncHpiHHAomrWidCu+
         XczhgjJXeTVGvSQlVK3v53HtXe8y4+17Irm0H2dYAPfyJF0HMTWihx0JyjSbBFA9pPXU
         Pe2kKuKAJMceg2oF5b6nWPuSvkawGyZv9Qxzc2iFd/JO+U1kkamDTlZow54eDQ54unSz
         b/YwA6zIBDfrO9NYV6VhNYHw6Wb6Tk4sA2E036dQd6T1YpncLL2sfRlvf96OUofISDyk
         NwNC+0SPOWmDz4ukIxSz3s7AhQOpFXSj5A7nddgpDH2XwO0nW12AvAoT9gC5V2pAov1+
         56Ng==
X-Gm-Message-State: AOAM533Huov4B9mPcQDFGZU04NzU9jtvCDYzjUaIxuE1nk3nceLmgad/
        6IxghXzQ6UoLynfSknFbyV+HKuTU7SY=
X-Google-Smtp-Source: ABdhPJyoT0lkGAvKHOmt3cU8Gho9VmOWUV+LgkSJyb/vBPRsJc9ApzuNsXDoDAOMs+VfLCIrals4/w==
X-Received: by 2002:a54:4716:: with SMTP id k22mr2708360oik.78.1592487156623;
        Thu, 18 Jun 2020 06:32:36 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id c129sm625331oif.53.2020.06.18.06.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 06:32:35 -0700 (PDT)
Subject: sg/commit-graph-cleanups (was Re: What's cooking in git.git (Jun
 2020, #03; Wed, 17))
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqpn9wq3tl.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <76f63479-c142-86f2-c045-f802f7794a7d@gmail.com>
Date:   Thu, 18 Jun 2020 09:32:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <xmqqpn9wq3tl.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/18/2020 2:35 AM, Junio C Hamano wrote:
> * sg/commit-graph-cleanups (2020-06-17) 18 commits

You have this topic marked with "Code cleanup" which is definitely
true of the first submission, but not the second.

>  - commit-graph: persist existence of changed-paths
>  - commit-graph: change test to die on parse, not load

These two add an important behavior change to persist the changed-paths
after a user opts-in to using them.

>  - bloom: enforce a minimum size of 8 bytes
>  - commit-graph: check all leading directories in changed path Bloom filters

These two have meaningful performance gains.

>  - commit-graph: check chunk sizes after writing
>  - commit-graph: simplify chunk writes into loop
>  - commit-graph: unify the signatures of all write_graph_chunk_*() functions
>  - commit-graph: place bloom_settings in context

These four (from the second series) _are_ cleanups, but were harder to
apply than the others from the first series.

>  - commit-graph: simplify write_commit_graph_file() #2
>  - commit-graph: simplify write_commit_graph_file() #1
>  - commit-graph: simplify parse_commit_graph() #2
>  - commit-graph: simplify parse_commit_graph() #1
>  - commit-graph: clean up #includes
>  - diff.h: drop diff_tree_oid() & friends' return value
>  - commit-slab: add a function to deep free entries on the slab
>  - commit-graph-format.txt: all multi-byte numbers are in network byte order
>  - commit-graph: fix parsing the Chunk Lookup table
>  - tree-walk.c: don't match submodule entries for 'submod/anything'

These are all cleanups from the first series.

In summary, if you would like to keep these together as a single
topic, then perhaps this summary might be good:

	The changed-path Bloom filter is improved using ideas from
	an independent implementation.

Thanks,
-Stolee
