Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807C7C38A02
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 21:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJ1VtO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 17:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiJ1VtL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 17:49:11 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9A024C11E
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 14:49:11 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so5657788pjl.3
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 14:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z6TJgBy2Hz5jg6ec0ty4p4ptx+PEOLJPp+a4LhSsSKg=;
        b=Gw0M2eVdo9CZB0PA2KDfna3BfWNBrm35vtluq+FIfizw5+zadB9apfrRmEWkCP4cBm
         en3MZx8kJyKVY4K4Nnu8pgC4JRW/75PZ+/kVca/Jt5HmmJUNjl56uMY8qWiAJ1K3j1Wd
         cOCK+99lwt19trrlaCQslcSFYIg1vya/vMWz3zRe5hTS67ospTDbowjqB0p4RK7FNT9E
         truCJEktyeMfEH8HqNJqLhDcwX0fvY67UyoHRsVEVJl2Ow9ZzNuVMbImreMly9TdYFjv
         n0jEwNf/41X5rNiHG6lZoA4ftL7UrBgUJDeP0CZCjw8BWTqwHUa2HvNG9F0mAnl/v3K5
         5s1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z6TJgBy2Hz5jg6ec0ty4p4ptx+PEOLJPp+a4LhSsSKg=;
        b=JNcRSLwwJfsCKDMzwHGHTjGKLh9h4Rigp2elY+vj9gYZw0KbMDDtW2YFnuIYGGQvi1
         AXliYOOAmm9iEfF4AtCD7qkcaxo6lZNnUU2O8jUB8WnvD4ESGjG3NrsRs0B/7bP8fcYX
         2YtAedsvLL02f6C1icQmSCmgsQKnvHb98ARMOaKNktNzZDbtouy5EzXH7D2CpMjFBXJj
         IY9UPtjWVT7QLd4YNrv8MuGI0puLE9y7bOlFZV6PhvVB/Ys02mD98nhXLWIhmOGlddbD
         BLwMiwJP5fEjsjcy7OVMAkXu0225cbWUnCtqo+oHv7UsqhCw9tTDHuXW3qN1x+qjhBKP
         MCNQ==
X-Gm-Message-State: ACrzQf0YKP7kCj+hcUbzROMyEhINSwtbizY/7DdSsH4dtz8vfLQ8FMIW
        6ONelydd0drGiT/+a+rYmyE=
X-Google-Smtp-Source: AMsMyM6K+CBr0jxLvGeX7nf4Vcnp+tdQVIycMp11n6MDc7QjplDjSMOyskDtO5LIMYkNP2ZzCLspVg==
X-Received: by 2002:a17:90b:390c:b0:211:6e5:6351 with SMTP id ob12-20020a17090b390c00b0021106e56351mr1429816pjb.158.1666993750721;
        Fri, 28 Oct 2022 14:49:10 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id f6-20020a170902ce8600b0018157b415dbsm3584014plg.63.2022.10.28.14.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 14:49:10 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v3 5/8] submodule: return target of submodule symref
References: <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com>
        <pull.1321.v3.git.git.1666988096.gitgitgadget@gmail.com>
        <bd8ffd7cde2feb3853f837778d660c0f47db32ff.1666988096.git.gitgitgadget@gmail.com>
Date:   Fri, 28 Oct 2022 14:49:09 -0700
In-Reply-To: <bd8ffd7cde2feb3853f837778d660c0f47db32ff.1666988096.git.gitgitgadget@gmail.com>
        (Glen Choo via GitGitGadget's message of "Fri, 28 Oct 2022 20:14:53
        +0000")
Message-ID: <xmqqfsf7hb56.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  int resolve_gitlink_ref(const char *submodule, const char *refname,
> -			struct object_id *oid)
> +			struct object_id *oid, const char **target_out)
>  {
>  	struct ref_store *refs;
>  	int flags;
> +	const char *target;
>  
>  	refs = get_submodule_ref_store(submodule);
>  
>  	if (!refs)
>  		return -1;
> -
> -	if (!refs_resolve_ref_unsafe(refs, refname, 0, oid, &flags) ||
> -	    is_null_oid(oid))
> +	target = refs_resolve_ref_unsafe(refs, refname, 0, oid, &flags);
> +	if (!target || is_null_oid(oid))
>  		return -1;
> +	if (target_out)
> +		*target_out = target;
>  	return 0;
>  }

Please remind me why we call this underlying helper _unsafe()?

Isn't it because we return a temporary buffer  (static strbuf),
whose contents is not permanent?

I am wondering if we should force the callers who care enough to
pass the optional **target_out to xstrdup() the result.
