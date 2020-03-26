Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4EEC43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 21:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9B82076A
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 21:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gAQwGIIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgCZVMG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:12:06 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:52783 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbgCZVME (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 17:12:04 -0400
Received: by mail-pj1-f67.google.com with SMTP id ng8so2994351pjb.2
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 14:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jWat0j3wWK6TrpBZqpwBSBQuGJSy2NKwmiJVOtnXujI=;
        b=gAQwGIIm4cNbjfpyDT4iNWHUXmQN1of1wwuir9a5hr7gcChxSG5JheR1it1hsBLITV
         /9yZRxRd/C5lYyaz0QW83KCuMOsLAnEeywaOJ/nRizxNR39AalUWZC1UtgHgvTF++SSq
         jVB1wq4/I59qveZoD2URbQumjYsYvwCj15kBEUS2hD28b9pZvud4XNJet2PeAgRzV0N9
         iO1Iq0bvVzhLwkpaBHet8wawvLEuPQdNOhFaftNB/XGtZ9ZruOFb/8m8gMZ/5FK6yDey
         Rs1dSSPFh0I996YSdIn5SSF/bPQhQ5gXvnz6hVowmnT81VUiEap4XJlRfJOlI3kZZNQV
         IoVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jWat0j3wWK6TrpBZqpwBSBQuGJSy2NKwmiJVOtnXujI=;
        b=iUYs3JLP0sCkpsxtvrbJR7KBi09KZPvLgxlbUfVP4yqBnl9j8ZvyBpeCSsK9rNEAkZ
         XywfN5zKxHSu+vHwmYZSaWSRIJqgClrNlcH8CtXr12s2EZE+PQdkoDr5GoxItLkoPxI7
         s2JbcCgpqs7Q5JaPU+wWanoOmVxpCXgykEUBKVH27awSkLcb59dnAihGETdZOy28iFsI
         WEEhFdSuc8hMt7uYcXoI3s2m2Q+TSZOUXxAYE4KWBvJYR1nsmTvWBRWUL3fN5brAzf9d
         jX5HTYjmbuCkO/ZiMV78MdOJ3vaEo27N2ewdBEsCfTBoCnvtid6pOO/PQxUS06YF74QG
         XFSw==
X-Gm-Message-State: ANhLgQ2+8TSgLs+HxzHXc/AenVZOrcFGG6RnGXN9/2MXaYsDscgeQiyW
        gQ1/S4V2spczuS4CHMK+xnNzLw==
X-Google-Smtp-Source: ADFU+vs7icPnnbyLxwWXl5LS6SvvFM36EdARFfyFNT1TdTtkEWCpysWTDh5Nkozl5LtIkycn4NVdrg==
X-Received: by 2002:a17:902:7593:: with SMTP id j19mr10409230pll.55.1585257121732;
        Thu, 26 Mar 2020 14:12:01 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id q12sm2379273pgi.86.2020.03.26.14.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 14:12:01 -0700 (PDT)
Date:   Thu, 26 Mar 2020 14:11:56 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] connected: always use partial clone optimization
Message-ID: <20200326211156.GA37946@google.com>
References: <20200320220045.258462-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320220045.258462-1-jonathantanmy@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 20, 2020 at 03:00:45PM -0700, Jonathan Tan wrote:
> With 50033772d5 ("connected: verify promisor-ness of partial clone",
> 2020-01-30), the fast path (checking promisor packs) in
> check_connected() now passes a subset of the slow path (rev-list) - if
> all objects to be checked are found in promisor packs, both the fast
> path and the slow path will pass; otherwise, the fast path will
> definitely not pass. This means that we can always attempt the fast path
> whenever we need to do the slow path.
> 
> The fast path is currently guarded by a flag; therefore, remove that
> flag. Also, make the fast path fallback to the slow path - if the fast
> path fails, the failing OID and all remaining OIDs will be passed to
> rev-list.

It looks like a pretty simple change. I had one probably-biased
complaint about gotos below, otherwise it looks reasonable to me.

> 
> The main user-visible benefit is the performance of fetch from a partial
> clone - specifically, the speedup of the connectivity check done before
> the fetch. In particular, a no-op fetch into a partial clone on my
> computer was sped up from 7 seconds to 0.01 seconds. This is a
> complement to the work in 2df1aa239c ("fetch: forgo full
> connectivity check if --filter", 2020-01-30), which is the child of the
> aforementioned 50033772d5. In that commit, the connectivity check
> *after* the fetch was sped up.
> 
> The addition of the fast path might cause performance reductions in
> these cases:
> 
>  - If a partial clone or a fetch into a partial clone fails, Git will
>    fruitlessly run rev-list (it is expected that everything fetched
>    would go into promisor packs, so if that didn't happen, it is most
>    likely that rev-list will fail too).
> 
>  - Any connectivity checks done by receive-pack, in the (in my opinion,
>    unlikely) event that a partial clone serves receive-pack.
> 
> I think that these cases are rare enough, and the performance reduction
> in this case minor enough (additional object DB access), that the
> benefit of avoiding a flag outweighs these.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> This is the second half of the work I did previously [1]. Quoting from
> [1]:
> 
> > For example, a local fetch was sped up from 6.63s to 3.39s. The bulk of
> > the remaining time is spent in yet another connectivity check
> > (fetch_refs -> check_exist_and_connected) prior to the fetch - that will
> > hopefully be done in a subsequent patch.
> 
> This is the subsequent patch. (Note that the timings were done on
> another computer, so don't compare the timings from [1] and this patch
> directly.)
> 
> [1] https://lore.kernel.org/git/be1d6aa4c4fd8868f3682b73c01a92d3830534ad.1578802317.git.jonathantanmy@google.com/
> ---
>  builtin/clone.c | 7 ++-----
>  builtin/fetch.c | 7 -------
>  connected.c     | 9 +++++++--
>  connected.h     | 9 ---------
>  4 files changed, 9 insertions(+), 23 deletions(-)
> 
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 1ad26f4d8c..4b2b14ff61 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -672,8 +672,7 @@ static void update_remote_refs(const struct ref *refs,
>  			       const char *branch_top,
>  			       const char *msg,
>  			       struct transport *transport,
> -			       int check_connectivity,
> -			       int check_refs_are_promisor_objects_only)
> +			       int check_connectivity)
>  {
>  	const struct ref *rm = mapped_refs;
>  
> @@ -682,8 +681,6 @@ static void update_remote_refs(const struct ref *refs,
>  
>  		opt.transport = transport;
>  		opt.progress = transport->progress;
> -		opt.check_refs_are_promisor_objects_only =
> -			!!check_refs_are_promisor_objects_only;
>  
>  		if (check_connected(iterate_ref_map, &rm, &opt))
>  			die(_("remote did not send all necessary objects"));
> @@ -1275,7 +1272,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  
>  	update_remote_refs(refs, mapped_refs, remote_head_points_at,
>  			   branch_top.buf, reflog_msg.buf, transport,
> -			   !is_local, filter_options.choice);
> +			   !is_local);
>  
>  	update_head(our_head_points_at, remote_head, reflog_msg.buf);
>  
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index bf6bab80fa..1097e1e512 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -908,13 +908,6 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>  	if (!connectivity_checked) {
>  		struct check_connected_options opt = CHECK_CONNECTED_INIT;
>  
> -		if (filter_options.choice)
> -			/*
> -			 * Since a filter is specified, objects indirectly
> -			 * referenced by refs are allowed to be absent.
> -			 */
> -			opt.check_refs_are_promisor_objects_only = 1;
> -
>  		rm = ref_map;
>  		if (check_connected(iterate_ref_map, &rm, &opt)) {
>  			rc = error(_("%s did not send all necessary objects\n"), url);
> diff --git a/connected.c b/connected.c
> index 7e9bd1bc62..846f2e4eef 100644
> --- a/connected.c
> +++ b/connected.c
> @@ -52,7 +52,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
>  		strbuf_release(&idx_file);
>  	}
>  
> -	if (opt->check_refs_are_promisor_objects_only) {
> +	if (has_promisor_remote()) {
>  		/*
>  		 * For partial clones, we don't want to have to do a regular
>  		 * connectivity check because we have to enumerate and exclude
> @@ -71,13 +71,18 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
>  				if (find_pack_entry_one(oid.hash, p))
>  					goto promisor_pack_found;
>  			}
> -			return 1;
> +			/*
> +			 * Fallback to rev-list with oid and the rest of the
> +			 * object IDs provided by fn.
> +			 */
> +			goto no_promisor_pack_found;
>  promisor_pack_found:
>  			;
>  		} while (!fn(cb_data, &oid));
>  		return 0;
>  	}
>  
> +no_promisor_pack_found:

Having a look at the final structure of the loop with these gotos, I'm a
little confused. Could be this isn't C-idiomatic but I think the code
could be easier to read with helpers instead of gotos. I realize it's
longer but I have a hard time understanding that your gotos are used to
double-continue or double-break; nested loops tend to make me want to
use helpers. But - I'm a lowly barely-reformed C++ developer, so what do
I know ;)

  int oid_in_promisor(oid) {
    for (p = get_all_packs(the_repository); p; p = p->next) {
      if (!p->pack_promisor)
        continue;
      if (find_pack_entry_one(oid.hash, p)
        return 1;
    }
  }

  int all_oids_in_promisors(oid, fn, cb_data)
  {
    do {
      if (! oid_in_promisor(oid))
        return 0;
    } while (!fn(cb_data, &oid));
    return 1;
  }

  int check_connected(...)
  {
    ...
    if (has_promisor_remote()) {
      if (all_oids_in_promisors(oid, fn, cb_data))
        return 0;
      if (opt->shallow_file) {
       ...
  }

>  	if (opt->shallow_file) {
>  		argv_array_push(&rev_list.args, "--shallow-file");
>  		argv_array_push(&rev_list.args, opt->shallow_file);
> diff --git a/connected.h b/connected.h
> index eba5c261ba..8d5a6b3ad6 100644
> --- a/connected.h
> +++ b/connected.h
> @@ -46,15 +46,6 @@ struct check_connected_options {
>  	 * during a fetch.
>  	 */
>  	unsigned is_deepening_fetch : 1;
> -
> -	/*
> -	 * If non-zero, only check that the top-level objects referenced by the
> -	 * wanted refs (passed in as cb_data) are promisor objects. This is
> -	 * useful for partial clones, where enumerating and excluding all
> -	 * promisor objects is very slow and the commit-walk itself becomes a
> -	 * no-op.
> -	 */
> -	unsigned check_refs_are_promisor_objects_only : 1;
>  };
>  
>  #define CHECK_CONNECTED_INIT { 0 }
> -- 
> 2.25.1.696.g5e7596f4ac-goog
> 
