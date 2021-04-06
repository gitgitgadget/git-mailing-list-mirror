Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE677C433B4
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 12:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 854E7613CB
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 12:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243419AbhDFM5c (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 08:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243376AbhDFM5c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 08:57:32 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738D3C06174A
        for <git@vger.kernel.org>; Tue,  6 Apr 2021 05:57:24 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id v25so14958700oic.5
        for <git@vger.kernel.org>; Tue, 06 Apr 2021 05:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=t+GU7I2+kUrwKQg4SRP5VJisCRmva2BTesDNBOSBF5A=;
        b=ESsbEhLBDIRk6/ZQJahaFkimEerBv867ASzv6xSrLDKrx6F96B9Qv/zJElG8O3fiQF
         9HpC/b3dXZes5c+3cVuZoRHWOJcktY9NdetvbSe4ewhUotSZfS2jSaHh0xsop+P3CH6E
         E3S67S+HvKy+yJzzw+lu2k+oDVCH9XWVIRsWx8gTCwiBIVfFO4dj7m6m1Q13DUVSgttp
         sgZ+XJSjdAWmdaa/SxPZcwtBhftsvChlAxLiYecuC+jinuW5qP9PXNzWbdxyYSpB8Fwy
         dPOwEvh8Hn/tlsevNOYAZFCO97Q18P7kLdDt4lka41SDarEWAygJQ7aXqXnMsvnr3wHr
         o7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t+GU7I2+kUrwKQg4SRP5VJisCRmva2BTesDNBOSBF5A=;
        b=lZqH8Ug9EH87jg1moFPtcrD/N9xARsDg+ZO+MJVk9514g7rm+iCYGNnM0ylNgyzJec
         ZV0s6cG+c2CkNcsueV9uKBHY2PGKuUppk2FAFRU5xTYOooJRHDFzmxkOLRWHrnVvkWG4
         FThit2d78rELtgDZ6NC8IuCqLVEEqmTQ3wJWwVn/nXzzPfJOTIUrQHnvjtCCt3eEX6vJ
         07MjOvo1CV9ie1JNevUeZLpRBXu7efJCFuIgQIA3+QVk3drEePzdkwPQj+xWpp0pgw/U
         7Nc9JdJTtrXlxxWNjgKaGWjWhHMx4C0vi2EBDGOf1G664/Scegy+D6Ns8qnv7PXRRY3a
         CfHw==
X-Gm-Message-State: AOAM5326o+cjXLLcn51CzOL2zUF/Ubesf3tbfM9ka5txiAK1nN5w+wB1
        7c6xy98CQnUFf3PKlMGke70=
X-Google-Smtp-Source: ABdhPJxgI9JS1HKIWizgoBvsJu6o9Ye8St/H699sVLa6b2BXPHsaOduqxBSgQsg6ibYYGESRth/uXg==
X-Received: by 2002:aca:57d1:: with SMTP id l200mr3077375oib.148.1617713843706;
        Tue, 06 Apr 2021 05:57:23 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7d35:99dc:7770:379a? ([2600:1700:e72:80a0:7d35:99dc:7770:379a])
        by smtp.gmail.com with ESMTPSA id g5sm3637049oiy.24.2021.04.06.05.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 05:57:23 -0700 (PDT)
Subject: Re: What's cooking in git.git (Apr 2021, #01; Mon, 5)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
References: <xmqqy2dw2pai.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6000ac2f-5d6d-09a2-c44d-4090e3d4c804@gmail.com>
Date:   Tue, 6 Apr 2021 08:57:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <xmqqy2dw2pai.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/5/2021 9:08 PM, Junio C Hamano wrote:> * ds/clarify-hashwrite (2021-03-26) 1 commit
>   (merged to 'next' on 2021-03-30 at 701f5c0696)
>  + csum-file: make hashwrite() more readable
> 
>  The hashwrite() API always resulted in a call to write(2), even
>  when writing a small amount of bytes that would still fit in the
>  internal buffer held by the hashfile struct.  It has been updated
>  to delay the writing until the buffer is filled or the hashfile
>  concluded for performance.

Sorry for not noticing earlier, but this branch description is
based on my erroneous understanding of the change in v1. The
commit now only rearranges and comments the method to be more
clear that it is correctly buffering the data. Perhaps this
could be a substitute?

  The hashwrite() API uses a buffering mechanism to avoid calling
  write(2) too frequently. This logic has been refactored to be
  easier to understand.

> * ds/sparse-index (2021-03-30) 21 commits
>  - p2000: add sparse-index repos
>  - sparse-index: loose integration with cache_tree_verify()
>  - cache-tree: integrate with sparse directory entries
>  - sparse-checkout: disable sparse-index
>  - sparse-checkout: toggle sparse index from builtin
>  - sparse-index: add index.sparse config option
>  - sparse-index: check index conversion happens
>  - unpack-trees: allow sparse directories
>  - submodule: sparse-index should not collapse links
>  - sparse-index: convert from full to sparse
>  - sparse-index: add 'sdir' index extension
>  - sparse-checkout: hold pattern list in index
>  - unpack-trees: ensure full index
>  - test-tool: don't force full index
>  - test-read-cache: print cache entries with --table
>  - t1092: compare sparse-checkout to sparse-index
>  - sparse-index: implement ensure_full_index()
>  - sparse-index: add guard to ensure full index
>  - t1092: clean up script quoting
>  - t/perf: add performance test for sparse operations
>  - sparse-index: design doc and format update
>  (this branch is used by ds/sparse-index-protections.)
> 
>  Both in-core and on-disk index has been updated to optionally omit
>  individual entries and replace them with the tree object that
>  corresponds to the directory that contains them when the "cone"
>  mode of sparse checkout is in use.

I believe this one has been stable for a little while. Do you
think it could be a candidate for 'next' soon? Alternatively,
you could wait and merge ds/sparse-index and
ds/sparse-index-protections at the same time. I just know that
the second series is causing some merge contention with other
topics.

> * ds/sparse-index-protections (2021-03-31) 25 commits
>  - name-hash: use expand_to_path()
>  - sparse-index: expand_to_path()
>  - revision: ensure full index
>  - resolve-undo: ensure full index
>  - read-cache: ensure full index
>  - pathspec: ensure full index
>  - merge-recursive: ensure full index
>  - entry: ensure full index
>  - dir: ensure full index
>  - update-index: ensure full index
>  - stash: ensure full index
>  - rm: ensure full index
>  - merge-index: ensure full index
>  - ls-files: ensure full index
>  - grep: ensure full index
>  - fsck: ensure full index
>  - difftool: ensure full index
>  - commit: ensure full index
>  - checkout: ensure full index
>  - checkout-index: ensure full index
>  - add: ensure full index
>  - cache: move ensure_full_index() to cache.h
>  - read-cache: expand on query into sparse-directory entry
>  - *: remove 'const' qualifier for struct index_state
>  - sparse-index: API protection strategy
>  (this branch uses ds/sparse-index.)
> 
>  Builds on top of the sparse-index infrastructure to mark operations
>  that are not ready to mark with the sparse index, causing them to
>  fall back on fully-populated index that they always have worked with.

I will have at least one more re-roll of this topic based on
Elijah's latest comments. I know that this is causing merge
contention with other topics, so I'm refraining from submitting
more series on top until this one is merged.

Thanks,
-Stolee
