Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B19EC43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 19:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620BD20722
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 19:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Au0h+j+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgCZTBo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 15:01:44 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40729 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgCZTBo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 15:01:44 -0400
Received: by mail-pl1-f196.google.com with SMTP id h11so2512184plk.7
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 12:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Eb77eKq1bQ+z9KGsZ9b9AP0629bFbP7AHd0vLBXsHog=;
        b=Au0h+j+9Czsryth+ESP57J3NEdnitsKaRZ3s2qkh+4s524VrnLCHjfN/RH+4nZE0V4
         zxEapMlod8TH3ZXyA2NAc5oT4JBsbUvmtzGQOQ9OhcBW2K8Rhb47669sv0z4hvMbHFh7
         7YLvY8owmC9oRjcyZQ/TvbmldinvqKyh4mABtQ+Gy1SCf1zRv0uQ9l0dmNVUlQHCwXT5
         0K0iom/a730AocpuO0OjyWX7Y9N9YdRY5a0s/owxIYJNVXel5lVLmM3MjzCvhmyatRPU
         nzwQH3oDldKof6EW2/wEPAb0R99Ms251bxDocvml6Yq5mNrCzHhGqM2zKhvpT8KVLUha
         wxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Eb77eKq1bQ+z9KGsZ9b9AP0629bFbP7AHd0vLBXsHog=;
        b=USYNW6acrwoYid7NEqeC6zdFbdS0SilGhf2OA3EVGnUGj11EExLvwI58WECcv2N18j
         /rnLvfcW2C8Hpry7tDRqPVaoldhKSQu1ljo30AtVzuVRdbEbbwCs50+vXbnWDil/sbob
         G8o49A1RSkTDpKxerTkFeXcXiAG/VSFCVwNRVOklpjMKk3fkEejwqyd9zFEavIJDSNV0
         K0CHsZtB6szHBQv8qvB9LZoJQlHizB6CFJxI6aMYDpbN6ugfVF1cvA8VzOPwNR6YuWgd
         aMLQQzlkP9qTQ/KGZRJKfqVNrQ/PZpnCKLiMQjDC+/uT8M/MTAdCzjWrk+XuJlXRMdzm
         arpQ==
X-Gm-Message-State: ANhLgQ1pcr3txjPHHLk+3v97m+1+AjlGgQO7lNTXJsVPmSzW1UBvmqdD
        ZvdUJ9t7D0G94N44fQ5VmNUYgQ==
X-Google-Smtp-Source: ADFU+vtIhcda5kkrTfTQr4HlxnPf70m/FkVH/PGM9IqTex592iOpuHlpZnKtPvnHJSK5sL5vFqAzNw==
X-Received: by 2002:a17:902:8a8f:: with SMTP id p15mr9586713plo.45.1585249302384;
        Thu, 26 Mar 2020 12:01:42 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:ece8:7fe:c1f1:a20f])
        by smtp.gmail.com with ESMTPSA id b3sm2232069pgs.69.2020.03.26.12.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 12:01:41 -0700 (PDT)
Date:   Thu, 26 Mar 2020 12:01:36 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] connected: always use partial clone optimization
Message-ID: <20200326190136.GB12694@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
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

On 2020.03.20 15:00, Jonathan Tan wrote:
[snip]
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

Yes, this setup doesn't match with my understanding of the usual partial
clone workflow.

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

I was curious if any other code uses this option; it appears not. And
you're removing the option from the struct later on, so that's good.

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

Previously, we'd iterate until we fail to find an OID in a promisor pack
in which case we'd return 1; now, we instead jump to the
non-promisor-pack check, which uses rev-list.

>  promisor_pack_found:
>  			;
>  		} while (!fn(cb_data, &oid));
>  		return 0;
>  	}
>  
> +no_promisor_pack_found:
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

And here's the struct field cleanup.

>  
>  #define CHECK_CONNECTED_INIT { 0 }
> -- 
> 2.25.1.696.g5e7596f4ac-goog
> 

This all looks good to me.

Reviewed-by: Josh Steadmon <steadmon@google.com>
