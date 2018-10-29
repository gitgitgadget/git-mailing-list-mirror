Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5A3E1F453
	for <e@80x24.org>; Mon, 29 Oct 2018 00:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbeJ2Iwq (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 04:52:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41143 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbeJ2Iwp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 04:52:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id x12-v6so6761702wrw.8
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 17:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qeuk2o1ADsYbe4EF/HJyCe8AQ5+DkUDfV2mrtsZrR1A=;
        b=ddOs++TlAvzCEQcG8LtgGAZg9oOZl16VFtqBbN3aW9VG8exgllGuNghRZicmzN2Pxn
         q+q4r4GROM5iRiHULoZoox42NZTv+kTp8tK2THF3epJLJzyF5PkNSMZxRKj1i2PznFJu
         v03NPPnr12+WGNqWqbAY5LXxg030+2bpRMFFJgSmKbfLiqknWMBeZQXqS/PO+IkeU2SH
         H8M6sTP+dZgzgcSoePO22eNNLBuFfD6aqQZZiNVW53aUoOaJyo3xmShGfKvLBTeo11dP
         iL6/JHBrNczlPIrvV9jbU2rchfBI7xNglo9aYEJyXgNkIenp2EE6vpr9N3vv27VJvSuE
         pUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qeuk2o1ADsYbe4EF/HJyCe8AQ5+DkUDfV2mrtsZrR1A=;
        b=tGd1AkTcRdlfjPegpWtzCsrSzD8QbfvTpdnqGdsYj6l/EDob3LEr4xnBnYrgK1NOAO
         E1RM3YmG5G9wa9MVbuLXvsWAtvHBUiMfYXfohgGo0TATLSWldhv5WhQbuGcsKewYCa12
         yDnVAz/MGij76BTdxQYqemgInTgvxzMe7645M6MBhDV4GKqflATlGh3s12PHwjQVdJkA
         Ej4it4O/8elCITBkxSgUoORZN4TM6gRJcBcd/vWbj3bz20df0GfLX3y1f9HHPk81Mf4z
         X3fGTm1KDwpXOYCbkt2s4UXVpr4dNVKPoWjGVlBbr7bkEkREhj6HWwOzMgyCbbB5c6gc
         KPlw==
X-Gm-Message-State: AGRZ1gIOUrnMQD3aEnQUPxX3GPTeLbYA4u+Z3QY0HXVReaR1o4Vad+J2
        qyj4KhB//+b9WiyISF+r7dI=
X-Google-Smtp-Source: AJdET5cd9rHZxMkK9FIUtKfkmqoORwy1APFu59t8rKSt9Ft2Nf8HJMCE4BH8na+oP+ZiwCSl8EkV0w==
X-Received: by 2002:a5d:48cc:: with SMTP id p12-v6mr13021900wrs.122.1540771591711;
        Sun, 28 Oct 2018 17:06:31 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t13-v6sm11285480wrn.22.2018.10.28.17.06.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 17:06:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        jeffhost@microsoft.com, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v2] list-objects.c: don't segfault for missing cmdline objects
References: <20181023215745.245333-1-matvore@google.com>
        <20181025235314.63495-1-matvore@google.com>
Date:   Mon, 29 Oct 2018 09:06:28 +0900
In-Reply-To: <20181025235314.63495-1-matvore@google.com> (Matthew DeVore's
        message of "Thu, 25 Oct 2018 16:53:14 -0700")
Message-ID: <xmqqo9bdaa63.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

> When a command is invoked with both --exclude-promisor-objects,
> --objects-edge-aggressive, and a missing object on the command line,
> the rev_info.cmdline array could get a NULL pointer for the value of
> an 'item' field. Prevent dereferencing of a NULL pointer in that
> situation.

Thanks.

> There are a few other places in the code where rev_info.cmdline is read
> and the code doesn't handle NULL objects, but I couldn't prove to myself
> that any of them needed to change except this one (since it may not
> actually be possible to reach the other code paths with
> rev_info.cmdline[] set to NULL).
>
> Signed-off-by: Matthew DeVore <matvore@google.com>
> ---
>  list-objects.c           | 3 ++-
>  t/t0410-partial-clone.sh | 6 +++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/list-objects.c b/list-objects.c
> index c41cc80db5..27ed2c6cab 100644
> --- a/list-objects.c
> +++ b/list-objects.c
> @@ -245,7 +245,8 @@ void mark_edges_uninteresting(struct rev_info *revs, show_edge_fn show_edge)
>  		for (i = 0; i < revs->cmdline.nr; i++) {
>  			struct object *obj = revs->cmdline.rev[i].item;
>  			struct commit *commit = (struct commit *)obj;
> -			if (obj->type != OBJ_COMMIT || !(obj->flags & UNINTERESTING))
> +			if (!obj || obj->type != OBJ_COMMIT ||
> +			    !(obj->flags & UNINTERESTING))
>  				continue;
>  			mark_tree_uninteresting(revs->repo,
>  						get_commit_tree(commit));
> diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
> index ba3887f178..e52291e674 100755
> --- a/t/t0410-partial-clone.sh
> +++ b/t/t0410-partial-clone.sh
> @@ -366,7 +366,11 @@ test_expect_success 'rev-list accepts missing and promised objects on command li
>  
>  	git -C repo config core.repositoryformatversion 1 &&
>  	git -C repo config extensions.partialclone "arbitrary string" &&
> -	git -C repo rev-list --exclude-promisor-objects --objects "$COMMIT" "$TREE" "$BLOB"
> +
> +	git -C repo rev-list --objects \
> +		--exclude-promisor-objects "$COMMIT" "$TREE" "$BLOB" &&
> +	git -C repo rev-list --objects-edge-aggressive \
> +		--exclude-promisor-objects "$COMMIT" "$TREE" "$BLOB"
>  '
>  
>  test_expect_success 'gc repacks promisor objects separately from non-promisor objects' '
