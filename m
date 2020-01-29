Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC87BC2D0DB
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 20:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B377020702
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 20:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzgDcsq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgA2Ulz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 15:41:55 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33812 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgA2Ulz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 15:41:55 -0500
Received: by mail-pl1-f193.google.com with SMTP id j7so420023plt.1
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 12:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ggCP2PCbM7g7HXZwwW9Yk1HPFP0sL2aCO0Js9kl1+M8=;
        b=AzgDcsq8spPcFD6PNIDuuU+V3jpyi6P8UxqRgZbCXe/XSuIV8u5oWANykdobGrF7Wi
         nYwm7dkQle29ydx47Ao6GiCyEnfN8ZzVGhwu8ZV1XVA0OfjnihoFBcvgVBEoeJd9bNDW
         B3qukCeGdUKab66oJBtGWDqR2T9PzjYdut71uCVgdrpZmTjRHLABOOvhBxVc2FCsIIy4
         I7pfiV+8iBbVJmw+loxhb2iua6ikN4KVHR0C5WseTSzpxBPnqSehKR00rp5RbR0ImQoE
         DT4RyodAN5vTIXD8d+4Xyce0t4z+f6BMmD2Xh85OuQBnhfZVjUban1oujEAzDXlgOrvO
         VZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ggCP2PCbM7g7HXZwwW9Yk1HPFP0sL2aCO0Js9kl1+M8=;
        b=mcEZyMDyjuRc5TfHvDtjAXImaNqG0QNNzHFfgqzRQkWZynu/z6fdd/90zMH/QbUVth
         gHSMsBoS73tKYCjwIID+G3XKPsfgfYKPpu0G1BjWAjpDayWlKX/L+89hlkP5gug1mkVd
         gAZ4hnMNda4BaQ8X0VMX1qUVJEelWm4nwOuEa9jEgPe85nPOZwLcbjY405Q3KkBJwk8j
         QpzaUBnGAuFIEUH3aOh24df+aYGo0NHFnzabW/dxpgamkVrwurzMxBVS9KpJ7sdgDINb
         IP5c8uusJjbLQz6hchhJexNlPEb/Sn0baNbyMw1Z3pXRqv9SHpgwZbxRxJvJYeo0h/0U
         KgBA==
X-Gm-Message-State: APjAAAWwf8ixy3FWw+ZZaLGtCn6fRFqamJvFX4G8IVQ0lVYcFh96vtlZ
        Jx4J3wN/wq6N5M4QWZLhP3U=
X-Google-Smtp-Source: APXvYqwjyNXT4j6KmrfGv7uzMxwlOudZxfompEWWAKTc9H2bvPMiN+vjRcoc+ui2akB0jwUTEX3DAw==
X-Received: by 2002:a17:90a:30a4:: with SMTP id h33mr1684650pjb.50.1580330514909;
        Wed, 29 Jan 2020 12:41:54 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id s22sm3494334pji.30.2020.01.29.12.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 12:41:54 -0800 (PST)
Date:   Wed, 29 Jan 2020 12:41:52 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] connected: verify promisor-ness of partial clone
Message-ID: <20200129204152.GA17350@google.com>
References: <cover.1578802317.git.jonathantanmy@google.com>
 <6a4f704e475fe1669e63731333fce9ed09d17d0c.1578802317.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a4f704e475fe1669e63731333fce9ed09d17d0c.1578802317.git.jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:

> Commit dfa33a298d ("clone: do faster object check for partial clones",
> 2019-04-21) optimized the connectivity check done when cloning with
> --filter to check only the existence of objects directly pointed to by
> refs. But this is not sufficient: they also need to be promisor objects.
> Make this check more robust by instead checking that these objects are
> promisor objects, that is, they appear in a promisor pack.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  builtin/clone.c |  5 +++--
>  connected.c     | 19 ++++++++++++++-----
>  connected.h     | 11 ++++++-----
>  3 files changed, 23 insertions(+), 12 deletions(-)

Good call.  Sorry for the slow review.

[...]
> --- a/connected.c
> +++ b/connected.c
> @@ -52,19 +52,28 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
>  		strbuf_release(&idx_file);
>  	}
>  
> -	if (opt->check_refs_only) {
> +	if (opt->check_refs_are_promisor_objects_only) {
>  		/*
>  		 * For partial clones, we don't want to have to do a regular
>  		 * connectivity check because we have to enumerate and exclude
>  		 * all promisor objects (slow), and then the connectivity check
>  		 * itself becomes a no-op because in a partial clone every
>  		 * object is a promisor object. Instead, just make sure we
> -		 * received the objects pointed to by each wanted ref.
> +		 * received, in a promisor packfile, the objects pointed to by
> +		 * each wanted ref.
>  		 */
>  		do {
> -			if (!repo_has_object_file_with_flags(the_repository, &oid,
> -							     OBJECT_INFO_SKIP_FETCH_OBJECT))
> -				return 1;
> +			struct packed_git *p;
> +
> +			for (p = get_all_packs(the_repository); p; p = p->next) {
> +				if (!p->pack_promisor)
> +					continue;
> +				if (find_pack_entry_one(oid.hash, p))
> +					goto promisor_pack_found;
> +			}
> +			return 1;
> +promisor_pack_found:
> +			;
>  		} while (!fn(cb_data, &oid));
>  		return 0;

Yep, does what it says on the tin.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
