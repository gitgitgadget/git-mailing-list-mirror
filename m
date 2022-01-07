Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A331FC433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 18:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240434AbiAGSMN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 13:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240386AbiAGSMM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 13:12:12 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BC7C061574
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 10:12:12 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id i3so18941425ybh.11
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 10:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZxXsa4SIl5G1aV8R9zWZotlmLFMEJ+CZkUL9tuxcQ2Y=;
        b=PvONE7FtaxBvC+zeoxPTEXnzGfLbxy/C/5J1c1o6hgzbLOQS6VdpC13HgzyCpYubE4
         l4xcv8yArlrxDt7Ws96abgWIiGMQshhMow1E2q9hw0u6BILFjgDEVFcxkvZdoIeuJese
         rIBPoTVgGNqOnlRkHQzczRpmt4rwRepOf2XX7H5B3ei142kCMG5vPndtqLn6hND/DAkO
         9TXPvXrcFdN3bR2F/fJCt95ufiRISkQaazjQo4N1EmwfgeL+NfdnvNh/AIRKnXPsNGcf
         jTqImbf4UejdCd5oQP/3dNpHglvhXTWkDv60wmvy3KIhuqTjzvb45Y1RSg9MLPclUrUk
         HcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZxXsa4SIl5G1aV8R9zWZotlmLFMEJ+CZkUL9tuxcQ2Y=;
        b=ipvZ9L3/StL66PqMKXaij8fCMNq6cADC0OafZp2BL/ayKrmZ+GWALPAL9phRfi8Nli
         z29zCcD5W89Z4032/TrjoZfU2HEkWzsfq+QjeqjApLZe6fRqVN9B2MRn4XHtNKtNKfWf
         AgnVbYFFRf/ik5XxopMz0nJJGA8aXshmo3w1vOwQi0WrkAsRi/9u/bCUsgo4j76pxk4E
         PrnhwLaLLtTeTpmxRA9D7//ZDi6U63/SDxT08D4XNS/Ypi4Etnt1PFFAWfXO/SJRfUY7
         LmmSHtBr319iC7xf0eYCfE3Lf3MO8O8zOZbvVA7hgRAX7JKOpG/qINK3HWYSctZYSeaL
         pPag==
X-Gm-Message-State: AOAM531ObHsm5nyl84tYBruf3twfqLvMSfdRDbaTQAAvxDhrJ4G2pko/
        hB+qDbElhaLq6rOAFpMYrb9u40ofQaoSHkl5nNQ=
X-Google-Smtp-Source: ABdhPJwTNqHtsCeot4meB14BlRylG88iZlIPu0KnMjH+uEZPPGsbstI+l2Mglea+EzXcftbXVqE2JYKx+3H52jt823A=
X-Received: by 2002:a25:d749:: with SMTP id o70mr79156389ybg.415.1641579131744;
 Fri, 07 Jan 2022 10:12:11 -0800 (PST)
MIME-Version: 1.0
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
 <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com> <1710ba4a9e432e2a854579c4c929e7f2cfc92211.1641403655.git.gitgitgadget@gmail.com>
In-Reply-To: <1710ba4a9e432e2a854579c4c929e7f2cfc92211.1641403655.git.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 7 Jan 2022 19:12:00 +0100
Message-ID: <CAP8UFD1jTgxCc-r8vzBGUt8SRS=h5jA1KSz6Fw1XpKXB5-XtoQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] merge-tree: implement real merges
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 5, 2022 at 6:27 PM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:

> The only output is:
>   - the toplevel resulting tree printed on stdout
>   - exit status of 0 (clean) or 1 (conflicts present)

I thought that the merge-ort API could (at least theoretically
according to merge-ort.h) return something < 0 in case of internal
error. In this case I would be interested in knowing what's the output
of the command.

> +The first form will merge the two branches, doing a full recursive
> +merge with rename detection.  If the merge is clean, the exit status
> +will be `0`, and if the merge has conflicts, the exit status will be
> +`1`.

No mention of what happens in case of an internal error in the merge-ort API.

> +       merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
> +       printf("%s\n", oid_to_hex(&result.tree->object.oid));
> +       merge_switch_to_result(&opt, NULL, &result, 0, 0);
> +       return result.clean ? 0 : 1;

If result.clean can be < 0, this might pretend that the merge was clean.
