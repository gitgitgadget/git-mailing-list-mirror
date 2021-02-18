Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA87C433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 03:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14BB66148E
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 03:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhBRDuA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 22:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhBRDt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 22:49:59 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D991FC061756
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 19:49:18 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id gx20so610124pjb.1
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 19:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8HDXulfvRrapYIahRlLgTx+GyVQih5EX+5X6BxQnTgU=;
        b=PP0/lEGqz28q4u8nNWdDBOC/j1dbwVhQA+gLG+1eAw1PjNRbWbcJ3XeELQLD4BAhD2
         TPlLWp1j0p50j13JD9qffqTV42SAp0vvzWmw+Epxt4/cOSXTyHj+LMLzwETcu7wXRJlD
         dzm/vz+LaMWvA1cW3CG88ZlyzQW8HzdPBnrpSnDA2gfLf69lqb2iXH4I7HPzGxr0SUIs
         2iBohQqVSfjzUYAZYfzfxpEhmE+Hz9HwQBoCuYj/5xtqBF4SXHjwBmBXb1bYRW3gi2jK
         h6njp6s8yYSH9UV5DAl7MVA9DrLNzydvhJDTGT4mJBDzMJZozxFypw7VhsTeGqDBM9Kn
         pODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8HDXulfvRrapYIahRlLgTx+GyVQih5EX+5X6BxQnTgU=;
        b=QboRSFsP0h9QYVz6in/9M4x2xcgg6v4oOsd2QGXpjst72+kwuq9qMHe7Wcv2KdjoeR
         mEhIvQVrpGQ/wx/W0a5A8uBiAuIBXtMZ8sLGDsGZn9fLZI/DIIyJfPlwHsPwfciiuLgL
         HkZ0eDr645FP1tNqlx9Gpdk0hH7MGWk7e6u6FrQztpZESH4JcIGIME7C+4Et7UD42q01
         aK0SzuaTjewf4NGnzT5djf3i26US8yQne/9PC2vsFQ9d8j/Zkp1wOCfO0X7vAcB/xejj
         owk5zHT1MkB60TXU0a5J1XIbGDQ+H+guiWvLRbXEy7tGaCiYyQvbiDtMaawdY3ctvnvj
         i6DA==
X-Gm-Message-State: AOAM530rScJSB+yzQk2rL/Jp6MRKKZ3yHiduVogu29GW+lx5YAxO0YY8
        a97SZDmFEget4KKxqAuXNEc=
X-Google-Smtp-Source: ABdhPJzKD8ZuZ9qy0s9y066PXg9A+M+54xHqdb7rv0/hugYE2NM80I3dHXspcpA6ZAqvLKI1Yb/V4A==
X-Received: by 2002:a17:902:6ac5:b029:e3:2709:4c1f with SMTP id i5-20020a1709026ac5b02900e327094c1fmr2475121plt.19.1613620158402;
        Wed, 17 Feb 2021 19:49:18 -0800 (PST)
Received: from generichostname ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id n15sm4147780pfd.143.2021.02.17.19.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 19:49:17 -0800 (PST)
Date:   Wed, 17 Feb 2021 19:49:15 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Joey Salazar <jgsal@protonmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [OUTREACHY][PATCH v2] doc: fix naming of response-end-pkt
Message-ID: <YC3ju7Jg9TyvRF2d@generichostname>
References: <k1OL_yTjmhqRPUI_3wZNi4FpD0yadrwMKu1CaOXO07YyMBQG5hYoUKFtndt6mlNBKMxyCgm3JGf2YcENx-vRasj1W8keEI6ITVvkaqOi2_Q=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <k1OL_yTjmhqRPUI_3wZNi4FpD0yadrwMKu1CaOXO07YyMBQG5hYoUKFtndt6mlNBKMxyCgm3JGf2YcENx-vRasj1W8keEI6ITVvkaqOi2_Q=@protonmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 18, 2021 at 12:11:22AM +0000, Joey Salazar wrote:
> Git Protocol version 2[1] defines 0002 as a Message Packet that indicates
> the end of a response for stateless connections.
> 
> Change the naming of the 0002 Packet to 'Response End' to match the
> parsing introduced in Wireshark's MR !1922 for consistency. A subsequent
> MR in Wireshark will address additional mismatches.
> 
> [1] kernel.org/pub/software/scm/git/docs/technical/protocol-v2.html
> [2] gitlab.com/wireshark/wireshark/-/merge_requests/1922
> 
> Signed-off-by: Joey Salazar <jgsal@protonmail.com>

Reviewed-by: Denton Liu <liu.denton@gmail.com>

> ---
>  Documentation/technical/protocol-v2.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> index e597b74da39..fc163ca605c 100644
> --- a/Documentation/technical/protocol-v2.txt
> +++ b/Documentation/technical/protocol-v2.txt
> @@ -33,8 +33,8 @@ In protocol v2 these special packets will have the following semantics:
> 
>    * '0000' Flush Packet (flush-pkt) - indicates the end of a message
>    * '0001' Delimiter Packet (delim-pkt) - separates sections of a message
> -  * '0002' Message Packet (response-end-pkt) - indicates the end of a response
> -    for stateless connections
> +  * '0002' Response End Packet (response-end-pkt) - indicates the end of a
> +    response for stateless connections
> 
>  Initial Client Request
>  ----------------------
> --
> 2.29.0.rc2
> 
