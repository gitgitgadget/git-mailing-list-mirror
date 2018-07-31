Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDAD91F597
	for <e@80x24.org>; Tue, 31 Jul 2018 23:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732780AbeHABQR (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 21:16:17 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:39650 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732749AbeHABQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 21:16:16 -0400
Received: by mail-it0-f74.google.com with SMTP id w196-v6so4317748itb.4
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 16:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tx1IPawfGVbb90erLnutTbrXF/el+MhXMePub7L29Dw=;
        b=T+9Pje+gQ4eiZp7HX7S91QFEQUwpakBw0kdaMHYXS5fgnzuJxKeoSOYN5RnGFEhgrp
         U+Arp8r+NRshzZMqp9oE3gtCFqkyh1J9W7K3ZJ+PwdGMISJ9H2VkKeR5vhli2ENeHHiQ
         1mf54PAjzVHzzjVeFSVTjp3cnP7D2y0YABZ6MDlNw/4Zs/H0sXA/2f7DZTDiYKWntHMs
         MqsbkCSA2YbpzOfnpYGT7RiruMReviFRFtq7HsM57X7kdM/+zT71dmXTz7QZ2mpjIcfF
         uysxOPRYsFzcP4p2rwrvOFmpUxkaNT/sPS0y1fay6Dl2iSK/TNRcnoPA/DeJim8zSxge
         CFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tx1IPawfGVbb90erLnutTbrXF/el+MhXMePub7L29Dw=;
        b=iqgfP81JBcttodLs1Yva2m9KsqF1M67//flQ0ZF0xPIL1ZFOPz37kPf6BNctNHkbYw
         tUccCZtu1kF/3S3ESQbwEKk1pTa3BsMlBBfF4sal0uYx9OmSLQu4is7cjumhAkA0CSkI
         FcRTkkpsZ8t+GiGMosrgBvfiFXXaGLk1Ef0shAoyv+Djpz/tKQix5cgqsJ/raw1MabA+
         3UbDa+xtZLhLVYkMYdSriLdy1DHVrKqDGRuvNL9cuUWlucvrq1Ki+4Yu3l5V6fX2++cj
         M4z8ufThD+1owbBLIAw4YO0gP3EwB47ho5eH8uFnPV11VRcB9veCcoI+jZtoAOryOq5N
         KQog==
X-Gm-Message-State: AOUpUlHN4HJSglZrZKEDRc27654bElAc6ma3DNbBSsfKL1ckDUb9N/wG
        gV3IVTHFGAoxmlSaKKFcu5Tqi2nkCX/Xd20m+jPQ
X-Google-Smtp-Source: AAOMgpctXwGsw/WHBf1hAo/EScLrKbtKXAbVAKJxJgdpRWXPenr6Y1bcuKKYpL0wM49zoiRm9W6+W2Jo+fZ+iM7dSoyl
X-Received: by 2002:a6b:a20b:: with SMTP id l11-v6mr8552608ioe.58.1533080015836;
 Tue, 31 Jul 2018 16:33:35 -0700 (PDT)
Date:   Tue, 31 Jul 2018 16:33:32 -0700
In-Reply-To: <xmqq1sbj9h08.fsf@gitster-ct.c.googlers.com>
Message-Id: <20180731233332.187328-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq1sbj9h08.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3.dirty
Subject: Re: [PATCH] remote: prefer exact matches when using refspecs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> That is, something like this, perhaps.  The resulting behaviour
> should match how "git rev-parse X" would give precedence to tag X
> over branch X by going this route.  What do you think?

[snip]

>  static const struct ref *find_ref_by_name_abbrev(const struct ref *refs, const char *name)
>  {
>  	const struct ref *ref;
> +	const struct ref *best_match = NULL;
> +	int best_score = -1;
> +
>  	for (ref = refs; ref; ref = ref->next) {
> -		if (refname_match(name, ref->name))
> -			return ref;
> +		int score = refname_match(name, ref->name);
> +
> +		if ((score && (best_score < 0 || score < best_score))) {
> +			best_match = ref;
> +			best_score = score;
> +		}
>  	}
> -	return NULL;
> +	return best_match;
>  }

This looks good to me. I've checked that refname_match (and
branch_merge_matches(), which returns the result of refname_match()
directly) is only used in "if" contexts, so making it return a value
other than 1 is fine.

I would initialize best_score to INT_MAX to avoid needing the
"best_score < 0" comparison, but don't feel strongly about it.
