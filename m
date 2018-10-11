Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B28DB1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 21:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbeJLF1q (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 01:27:46 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:49425 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725742AbeJLF1q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 01:27:46 -0400
Received: by mail-qt1-f202.google.com with SMTP id f20-v6so10133187qta.16
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 14:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yxUMzL3c1fa7TFXBHIRpu+q33FnX67YhPfzSGIxclcs=;
        b=aui3B+mkDTzvyRZbZjwAgVNY5NKQMJ3ZhBXnu7zW+ifiKl19U5+LMnb7FrenNZew39
         KftT/0OcFEHJRXyJkJK5HJks4LDobZFN7fTGQdXjDlzSp0AooKng6sYodHEfBJ9jM7L5
         NyA43gyhrSvWUGFqcETC/aD2IjvFxvS/WFVxpdxecs7OdHS/ZMp0fzOGbkKU+YmgxIKz
         4YOc70i4ndCuR1C63iVfSEkJkBvyhullzRRxodeIqrYmvxeOl4sUYI8wxNnxuCwpkBIK
         EhvSRb98iU4WmF4lYBz6PRt7ZzvJWTNp190BxEleyyxTVbMFUFi+RwdLjjl3YzzxPLfr
         8a7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yxUMzL3c1fa7TFXBHIRpu+q33FnX67YhPfzSGIxclcs=;
        b=TpA4XK3qsz8vKRm2yWO1JM60Sm20ThNBkOJllOHOmZH1+KK8o0dElLByxq9wodVqEI
         B3OSliRFrsIhJfZ6ACn+RWUjKWDFA8D3PLifCWmp52kD0psStKn/4PFeqe8zXWseeKOg
         sHc50rC33EeR5WOcOShtn12xot7XvXsRfxG7fdXEmTNwaE6Loc5ju+CTdoeAjjzkuOuC
         ZJVBBEWDBWnBz1XGpcOGzjZZv2pDtDKoebRcy/LN/7z0NFnvEbiLBqIIS1ZdiHz0Sy5P
         YxCnZCmzMHLqpaPm4uG2BbiZEK+H/YKsr9C5HJHKmWR1kjK3XZsqx7J7tEJvPtFi9B0u
         9EWw==
X-Gm-Message-State: ABuFfojJAtlRgP6UCSnB7Nmc5g/Z8UwUK38wJl8rKIfpIt/EdsRvm3fa
        lLL2U41x5lqOpb0ubb4P2hn1FwIKTnyVNUXvx37W
X-Google-Smtp-Source: ACcGV61WENW2fYf/wyoAIrrLstTRUQIeiRDnuue/I5HXbgNfrRJaPRa2Ni+mH8q0Lpt6ypzfxE9oXOYI/oQ3KabCtKpS
X-Received: by 2002:a37:1be8:: with SMTP id m101-v6mr2764285qkh.58.1539295113328;
 Thu, 11 Oct 2018 14:58:33 -0700 (PDT)
Date:   Thu, 11 Oct 2018 14:58:23 -0700
In-Reply-To: <20181011211754.31369-4-sbeller@google.com>
Message-Id: <20181011215823.182711-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181011211754.31369-4-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 03/19] object-store: allow read_object_file_extended to
 read from arbitrary repositories
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -1413,10 +1414,10 @@ void *read_object_file_extended(const struct object_id *oid,
>  	const char *path;
>  	struct stat st;
>  	const struct object_id *repl = lookup_replace ?
> -		lookup_replace_object(the_repository, oid) : oid;
> +		lookup_replace_object(r, oid) : oid;

Firstly, patches 1 and 2 are obviously correct.

This lookup_replace_object() is a bit tricky in that at 'master',
register_replace_ref() (indirectly called by lookup_replace_object())
did not handle arbitrary repositories correctly, but 'next' has a patch
that solves this, so this shouldn't be an issue. The other function
changes look fine. So this patch looks correct too.
