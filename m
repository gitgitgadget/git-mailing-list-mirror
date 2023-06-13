Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06846EB64D7
	for <git@archiver.kernel.org>; Tue, 13 Jun 2023 21:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240034AbjFMV7V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jun 2023 17:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbjFMV7F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2023 17:59:05 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026EB1FD7
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 14:58:32 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-652426346bbso4740296b3a.3
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 14:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686693506; x=1689285506;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j2uNi+83lowOw3oQbS5DCm6iT5z8WSFF2UK0gCrhUlo=;
        b=gZQFacYodq2zR/uZCWG8Oaho/JFdYwbgRezLFnWcGic+sR/lmLH1NzygFZL8ca0Hhh
         zhl/tQVk3lxVYJlbgLXI+0/kXAYICtnd9Xp2SdYjuswBXXucymHBvxFY8L+l6TV+LfL6
         0c5GV6K45Jv808o17RjJC7ei/TCESY8a8gdgbxQhD8SnBPRgGVAX1/m946L3sL8t+R/0
         bbq76etO5uZwpmy4RmA2+1or/mnF1V6c/w+Po1mRVL2hqke+5S93V+Mx99yACZbFwrFv
         +FU9g1urmgfjvSehIV/rvj1D+Hs+dkWjHzUwUpNwlmJImIOvJT5wfXqTGe5QKx4urptE
         3g9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686693506; x=1689285506;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j2uNi+83lowOw3oQbS5DCm6iT5z8WSFF2UK0gCrhUlo=;
        b=cmjyvRLNFqeTFVH0wA47XbxpkzONJJCH46RAstTuBe35wRzEndkkK379i2+ugz0nAE
         OMPTQ16E5WNNxknEC2oO5fYdJvX7xC8+5KAhxC+Kt5OPma31ZzKS5cjGq1esL0QeketW
         lPM6uNW/qy5+qEOFauZ55seraD1dlxhUcwgXG89fhMUmUaxsgygC9jwepPteiPWlFBZz
         DyZkJYKizxgP6aOLGRcJ0Ht+wFbHeoaj/qMIAJtp2coAHeZ0rtFGd2DHdbmeFNNi4WUF
         yyzC7pxQHPIIi0ctdVIk2qPgp6FAtBuB2XHfoiPBS1X8KOZlbBdVlMOzf+pWIGKUXvES
         tYKg==
X-Gm-Message-State: AC+VfDzJ1ZPJv/v4AB6ywz5bxwVw7l9IlLrMdRIndI/n9CduEJmX4H8z
        tnWKis269hABCQW873Dtg1c0mhElj10=
X-Google-Smtp-Source: ACHHUZ7rC0294OqlPS4k+YQcqf5+2Wkhj2LhqoARJA6lnare+BvBAIdsqq9wdXfVLkIW71GV2rRaRA==
X-Received: by 2002:a05:6a20:3d8b:b0:119:94f4:c62e with SMTP id s11-20020a056a203d8b00b0011994f4c62emr25535pzi.19.1686693505801;
        Tue, 13 Jun 2023 14:58:25 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902b20c00b0019719f752c5sm10664122plr.59.2023.06.13.14.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 14:58:25 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 1/4] gitformat-commit-graph: describe version 2 of BDAT
References: <cover.1684790529.git.jonathantanmy@google.com>
        <cover.1686677910.git.jonathantanmy@google.com>
        <a3b52af4c96db9a8164119e8ace0541db47b6815.1686677910.git.jonathantanmy@google.com>
Date:   Tue, 13 Jun 2023 14:58:24 -0700
In-Reply-To: <a3b52af4c96db9a8164119e8ace0541db47b6815.1686677910.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 13 Jun 2023 10:39:55 -0700")
Message-ID: <xmqqlegn3tz3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> The code change to Git to support version 2 will be done in subsequent
> commits.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  Documentation/gitformat-commit-graph.txt | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/gitformat-commit-graph.txt b/Documentation/gitformat-commit-graph.txt
> index 31cad585e2..112e6d36a6 100644
> --- a/Documentation/gitformat-commit-graph.txt
> +++ b/Documentation/gitformat-commit-graph.txt
> @@ -142,13 +142,16 @@ All multi-byte numbers are in network byte order.
>  
>  ==== Bloom Filter Data (ID: {'B', 'D', 'A', 'T'}) [Optional]
>      * It starts with header consisting of three unsigned 32-bit integers:
> -      - Version of the hash algorithm being used. We currently only support
> -	value 1 which corresponds to the 32-bit version of the murmur3 hash
> +      - Version of the hash algorithm being used. We currently support
> +	value 2 which corresponds to the 32-bit version of the murmur3 hash
>  	implemented exactly as described in
>  	https://en.wikipedia.org/wiki/MurmurHash#Algorithm and the double
>  	hashing technique using seed values 0x293ae76f and 0x7e646e2 as
>  	described in https://doi.org/10.1007/978-3-540-30494-4_26 "Bloom Filters
> -	in Probabilistic Verification"
> +	in Probabilistic Verification". Version 1 bloom filters have a bug that appears

"bloom" -> "Bloom", probably, as the name comes from the name of its
inventor (just like we spell "Boolean", not "boolean").

> +	when char is signed and the repository has path names that have characters >=
> +	0x80; Git supports reading and writing them, but this ability will be removed
> +	in a future version of Git.

Makes sense.

I wonder if we want to mention what the undesired misbehaviour the
"bug" causes and what we do to avoid getting affected by the bug
here.  If we can say something like "When querying for a pathname
with a byte with high-bit set, the buggy filter may produce false
negative, making the filter unusable, but asking for a pathname
without such a byte produces no false negatives (even though we may
get false positives).  When Git reads version 1 filter data, it
refrains from using it for processing paths with high-bit set to
avoid triggering the bug", then it would be ideal.  Or "When the
repository has even a single pathname with high-bit set anywhere in
its history, version 1 Bloom can give false negative when querying
any paths and becomes unusable.  You can use $THIS configuration
variable to disable use of Bloom filter data in such a case" would
also be fine.  The point is to give actionable piece of information
to the readers.

Thanks.
