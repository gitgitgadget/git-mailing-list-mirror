Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5873C433E0
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFA41204EF
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W2RtTLrC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbgFDRtv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:49:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62343 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730124AbgFDRtu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 13:49:50 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 12B786DD35;
        Thu,  4 Jun 2020 13:49:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7Ubd+QkRJi5Numijmm2ZViyFleg=; b=W2RtTL
        rCR7kzSHvEwfhGAwjQ0rmtvdi/hmvNOxwCJviPdpsKpLagdiLntN2+dQC7vcNDLs
        AXrfbW53TwhgkuFiJDptuwAgndSFYe5n2Ng/jEuLZpoikUagXxaLoEFAr8jSkfwo
        NGf0t7wHm0WGUsVSur/oEy/2lUO6OlUueU9Xw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yjWCJgNMBnX47Wk8Ct3yaFt7c3BkHQ2u
        GiBFqy5S0UQj3Q6vXpWpn5qH9CjoGuG+m8uTiMyn5Ec/5jbALYuvXeJv3UK+tYYc
        eFMLZ0pqAiJggUp75Uoip+yEzk6IXelVGRFjmgzr3Ss0zTQ6RclMj0W+Zi7PKYxx
        D0za9zzSncc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 071416DD34;
        Thu,  4 Jun 2020 13:49:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6229A6DD33;
        Thu,  4 Jun 2020 13:49:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, jnareb@gmail.com
Subject: Re: [GSoC Patch 2/3] commit: convert commit->generation to a slab
References: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
        <20200604072759.19142-3-abhishekkumar8222@gmail.com>
Date:   Thu, 04 Jun 2020 10:49:45 -0700
In-Reply-To: <20200604072759.19142-3-abhishekkumar8222@gmail.com> (Abhishek
        Kumar's message of "Thu, 4 Jun 2020 12:57:58 +0530")
Message-ID: <xmqqftbapvpi.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C765A2D0-A68B-11EA-A90D-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:

> In this commit, we will use the generation slab helpers introduced in
> last commit and replace existing uses of commit->generation using
> 'contrib/coccinelle/generation.cocci'
>
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  alloc.c                             |  1 -
>  blame.c                             |  2 +-
>  commit-graph.c                      | 39 +++++++++++-----------
>  commit-reach.c                      | 50 ++++++++++++++---------------
>  commit.c                            |  4 +--
>  commit.h                            |  1 -
>  contrib/coccinelle/generation.cocci | 12 +++++++
>  revision.c                          | 16 ++++-----
>  8 files changed, 68 insertions(+), 57 deletions(-)
>  create mode 100644 contrib/coccinelle/generation.cocci
>
> diff --git a/alloc.c b/alloc.c
> index 1c64c4dd16..cbed187094 100644
> --- a/alloc.c
> +++ b/alloc.c
> @@ -109,7 +109,6 @@ void init_commit_node(struct repository *r, struct commit *c)
>  	c->object.type = OBJ_COMMIT;
>  	c->index = alloc_commit_index(r);
>  	c->graph_pos = COMMIT_NOT_FROM_GRAPH;
> -	c->generation = GENERATION_NUMBER_INFINITY;
>  }
>  
>  void *alloc_commit_node(struct repository *r)
> diff --git a/blame.c b/blame.c
> index da7e28800e..50e6316076 100644
> --- a/blame.c
> +++ b/blame.c
> @@ -1272,7 +1272,7 @@ static int maybe_changed_path(struct repository *r,
>  	if (!bd)
>  		return 1;
>  
> -	if (origin->commit->generation == GENERATION_NUMBER_INFINITY)
> +	if (generation(origin->commit) == GENERATION_NUMBER_INFINITY)

Hmmmm, as C is not all that object-oriented that lets us say "commit
objects have generation() method", a plain vanilla function whose
name is generation() is a bit overly vague.  The field name this
helper function replaces, .generation, is very localized to a commit
"object" and does not have such a problem.

We probably need to choose a better name in the previous step to fix
it.

