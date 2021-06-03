Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFFCC4708F
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 02:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A71A613E9
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 02:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFCCkE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 22:40:04 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:50951 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhFCCkD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 22:40:03 -0400
Received: by mail-pf1-f201.google.com with SMTP id t20-20020aa793940000b02902e8f588ec26so2636644pfe.17
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 19:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TzSJf58JSLwdo0xnR81d+1PNkXYgN9MIdFFInUoFrnw=;
        b=AT0LS1QnoNbpHAn//AXAqdQ20ZhbenbT4uhH1IsU/iXNefeMpV3qHfW6jBndpRyrGP
         A5o53f/dMxxMe44dh06mclah3kSEh2OTLXqFBgVbiQjmKidu/4O4e6nQbYWlhktN8Kf6
         K/v09hL7fpHhx+uxCluoNnszf2louAur25qjtV2BTFvW8bdaVAL7Z20ygDO00wR3Dha7
         JOYg6Dh0thtT0J5pcgMnc8t+3Oe1abOhLYvMnTAi9UoVa6r7ZraI4PZdcKQFVmqholGg
         yu9oqGs6n9fL3sScVt6AMSvyPgJ+PUaRCOgjDnsLiuA5sIP72IYL65QO5eyEEBwTAEER
         PNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TzSJf58JSLwdo0xnR81d+1PNkXYgN9MIdFFInUoFrnw=;
        b=EsKd+U7m5qJswbxk0B6COTT429Ucqz895Bz4oIZfcNeKnYSKoNILmj0szTLXpGATwt
         DMwrMmmgAo3nVIALbzxHYDQVpzzM9O9MGY93b6XD9DXghphER1fHmSWIVa28/iTl512B
         03vbBZ5aGV4KM30BEBIhexFHoHU9Dx99i/9a7MRMuopWwTAkZCmMYQqw5PnfCWczRWwr
         pjWA3CYIsGRncXHUBgLGjHdmPM8Y+GRNCqZnB51sMILc+/lTeAD20qXfV6vRS3e3/UYX
         cgV6yavoGBlDq+I1ooPQUOnPjbkSQbvE5z5V3NunDWXuKZ2yx6IOqw8GWA99OZLJ33Sz
         Fv6A==
X-Gm-Message-State: AOAM530iVxejgVLnNju9zO+GW6iVO9xZA24M4UTWQNXkmruUUZ+lLtYi
        Ab60CgVqVD6NeJCpatK5H+mv46T7+DmN89xkxmji
X-Google-Smtp-Source: ABdhPJw04aFlN9RWzyKbj7eXj/QGGrCtNHtZEkrsH6P6djMmYVdwDeWPueNlK+11U2gIHbU/37PaWOfDiy1/shRLWnkV
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a65:6291:: with SMTP id
 f17mr17203385pgv.280.1622687831194; Wed, 02 Jun 2021 19:37:11 -0700 (PDT)
Date:   Wed,  2 Jun 2021 19:37:09 -0700
In-Reply-To: <ebd7b8380bf7aed84d23973a4809d1441aa21692.1619710329.git.gitgitgadget@gmail.com>
Message-Id: <20210603023709.345324-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <ebd7b8380bf7aed84d23973a4809d1441aa21692.1619710329.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: Re: [PATCH 3/8] refs: make errno output explicit for read_raw_ref_fn
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, hanwenn@gmail.com, hanwen@google.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Han-Wen Nienhuys <hanwen@google.com>
> 
> read_raw_ref_fn needs to supply a credible errno for a number of cases. These
> are primarily:
> 
> 1) The files backend calls read_raw_ref from lock_raw_ref, and uses the
> resulting error codes to create/remove directories as needed.
> 
> 2) ENOENT should be translated in a zero OID, optionally with REF_ISBROKEN set,
> returning the last successfully resolved symref. This is necessary so
> read_raw_ref("HEAD") on an empty repo returns refs/heads/main (or the default branch
> du-jour), and we know on which branch to create the first commit.
> 
> Make this information flow explicit by adding a failure_errno to the signature
> of read_raw_ref. All errnos from the files backend are still propagated
> unchanged, even though inspection suggests only ENOTDIR, EISDIR and ENOENT are
> relevant.

Looks good.

> @@ -1675,13 +1675,16 @@ int refs_read_raw_ref(struct ref_store *ref_store,
>  		      const char *refname, struct object_id *oid,
>  		      struct strbuf *referent, unsigned int *type)
>  {
> +	int result, failure;
>  	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEAD")) {
>  		return refs_read_special_head(ref_store, refname, oid, referent,
>  					      type);
>  	}
>  
> -	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
> -					   type);
> +	result = ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
> +					     type, &failure);
> +	errno = failure;
> +	return result;
>  }

Should we initialize "failure" to 0 here? As a reader, I would assume
that "failure" has the semantics of errno here, which upon success, may
or may not be set.
