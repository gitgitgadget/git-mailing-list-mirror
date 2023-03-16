Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E12EC6FD1F
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 17:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjCPRo2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Mar 2023 13:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjCPRo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2023 13:44:26 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680B5E2751
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 10:43:56 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id le6so2565092plb.12
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 10:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678988636;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sENeuOy2Ih/hXOrRt4dHba0ASeIFzzvAO6bCWQxV7B0=;
        b=miJvTL/NmLuLuGzDuuRyjkgSKoqE/hLzb+hTOOSSrAaP61JuTE19blMqBJNFFXCCpk
         tvzCeNxF88VdQMpURZaqP1N9xfQgZ9fLFrSUsxqAKGOk80dkOSFMvqBi+CHZI+mgEi1U
         W23OpWrig5kK0ZkY+kb5BOdgLnBrSpsMl785inepsYplZ36QfPqjnwBu9YzxDXmvOFt6
         u6QeqZ3jG2Jrk69u3Ex4n/pNF+YmSCEVzqC7BQZSqKT8kNMhJNRI9t0aP8MOHHU4+R08
         kgRKawp9fsVvc/h6np5/PB99ld64/+p33jVdFANXgPHnmv9siF3o1pngyKTeD+ULah5t
         oSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678988636;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sENeuOy2Ih/hXOrRt4dHba0ASeIFzzvAO6bCWQxV7B0=;
        b=JWGMHyL2S1cCjb2t+PQB5LFwGpRT+/hfvHBkqHZs2f3FEfyVLTmgrP3tZ2fXObY4b1
         wHRsZYLeWCoduKmJzQUxdxFAtCXiR/5rPlWTXkH2Gl8TrhatCWA/OKj3/+7h3wWMqTa8
         Bc4oI4ZolaSKOHciL/tPRwaJj+hHrKEqwgNcA4nrnuxzvnEYnt95+14fmhMggQFub+0e
         mMK+dPSc8mng7AvMUhe/rWcrCja1nJwjbCJWlnmZzYmuRI2xDC8DGOAwysFlL9BW0ZLK
         /G8SqIdoc0JspW3URrpRRCe5sIgwOmbhZOOm3MJs383+ddolQrP/0ae/c0bqjL4Nc2Js
         /e5w==
X-Gm-Message-State: AO0yUKWMdJsvOwi9bmdfUpUy4xYvyvU70SQc63QjBblP71+wZZPkydlw
        3Cq5tH1Tdwp6US4ZBfhPo1nik7o8fks=
X-Google-Smtp-Source: AK7set9mW9tg0u3QUVVaF6FPav+qp3WSvhw75OQdOQYpAaxIplpw2BQALo56gfjqyw1zt8xne2L9XQ==
X-Received: by 2002:a17:90b:4f48:b0:23d:1852:d3b7 with SMTP id pj8-20020a17090b4f4800b0023d1852d3b7mr4818092pjb.25.1678988635826;
        Thu, 16 Mar 2023 10:43:55 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id bk4-20020a17090b080400b0023b15e61f07sm18790pjb.12.2023.03.16.10.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 10:43:55 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] object-name: fix quiet @{u} parsing
References: <20230316171514.23741-1-felipe.contreras@gmail.com>
Date:   Thu, 16 Mar 2023 10:43:55 -0700
In-Reply-To: <20230316171514.23741-1-felipe.contreras@gmail.com> (Felipe
        Contreras's message of "Thu, 16 Mar 2023 11:15:14 -0600")
Message-ID: <xmqqfsa4lhgk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Currently `git rev-parse --quiet @{u}` is not actually quiet when
> upstream isn't configured:
>
>   fatal: no upstream configured for branch 'foo'
>
> Make it so.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  object-name.c                 | 5 +++--
>  t/t1507-rev-parse-upstream.sh | 5 +++++
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/object-name.c b/object-name.c
> index 2dd1a0f56e..d9f3a176d8 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -898,6 +898,7 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
>  	char *real_ref = NULL;
>  	int refs_found = 0;
>  	int at, reflog_len, nth_prior = 0;
> +	int fatal = !(flags & GET_OID_QUIETLY);
>  
>  	if (len == r->hash_algo->hexsz && !get_oid_hex(str, oid)) {
>  		if (warn_ambiguous_refs && warn_on_object_refname_ambiguity) {
> @@ -952,11 +953,11 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
>  
>  	if (!len && reflog_len)
>  		/* allow "@{...}" to mean the current branch reflog */
> -		refs_found = repo_dwim_ref(r, "HEAD", 4, oid, &real_ref, 0);
> +		refs_found = repo_dwim_ref(r, "HEAD", 4, oid, &real_ref, !fatal);
>  	else if (reflog_len)
>  		refs_found = repo_dwim_log(r, str, len, oid, &real_ref);
>  	else
> -		refs_found = repo_dwim_ref(r, str, len, oid, &real_ref, 0);
> +		refs_found = repo_dwim_ref(r, str, len, oid, &real_ref, !fatal);
>  
>  	if (!refs_found)
>  		return -1;

All of the above look sensible.

> diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
> index c34714ffe3..549eb315a9 100755
> --- a/t/t1507-rev-parse-upstream.sh
> +++ b/t/t1507-rev-parse-upstream.sh
> @@ -183,6 +183,11 @@ test_expect_success '@{u} error message when no upstream' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success '@{u} silent error when no upstream' '
> +	test_must_fail git rev-parse --verify --quiet @{u} 2>actual &&
> +	test_must_be_empty actual
> +'

OK.  This does not check what comes out to the standard output
stream at all, and only cares that the standard error stream emits
nothing.  Which is absolutely the right thing to do.  When a command
exits non-zero, we do not guarantee what output it emits, and the
invoker is expected to check the exit status.

Will queue.  Thanks.
