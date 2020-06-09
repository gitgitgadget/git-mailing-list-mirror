Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6738AC433DF
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 10:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 315DD2078D
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 10:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ozYdOMXC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgFIKQl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 06:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbgFIKQj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 06:16:39 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3463C05BD1E
        for <git@vger.kernel.org>; Tue,  9 Jun 2020 03:16:38 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y17so20618037wrn.11
        for <git@vger.kernel.org>; Tue, 09 Jun 2020 03:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hEUJ2Gc74Cy+zjN6tgpHu/2EMsB7paOfzxOv1+QS6RI=;
        b=ozYdOMXCtyRoDbTW4N/2pzPE7ajtVmLPqHJpRDitzjHeVDjspkq4cUiQdHAEoNEghF
         Pg4xy1pqGE9Qunp4Rz4yo4hgZEFvcRmN7z/u0Z5e3TiXPWL5Fb9sa/jp/tZvDmLyBBTw
         3ITDI6RL7cKCR30GJodQpZp6kpYHe3VNJj4aGnXud8/KoIVK48GOs8pgXhsaJmjQqqWH
         9IzUEP2OMKYJJm0fSuvipd+hAVJUQEL0sMtgUELKPjO+7kjMoZZyrww2fcAnACAmgKel
         pq1F8G0D/1b6pZ7MgMvExivVZEP1gRaYXrb2N4OH1gYcUxFVz/6fHQvh5oHcWVzr+LVh
         eenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hEUJ2Gc74Cy+zjN6tgpHu/2EMsB7paOfzxOv1+QS6RI=;
        b=mHwdfhYx8xUAGpZlg8sYYxJYJSKVFGn4cAZVxQhnx+lADXSnRybbhIYi/Jcpb+Gq5g
         cxl7kjIUd/df56/8ODcvL85eMY3/Z5mn9Z4SlpfHBZHFBKortyjaZCdwhtEUgHBtOJVI
         vWBUvZY3yM/SYj26wCjshNRns6W+CsAX4Upy55MjotuJVClQsfmGXF5er5n54vH1wtHk
         NTvwQGt8IGkT4GMEefyvDW17HrFz3NTrDSa0qQi3J5yuls+eErv3tJ7WLPjZ+wh0EUi5
         Xa/kkaL0Rz/rDSkSilVZ0fUdGNaIJajZi/6D8A/Fg7+UpxoyPJq+SKCQ30hp+V2SIL9T
         5NDQ==
X-Gm-Message-State: AOAM531fGfMMzozg2docM7BhtPJLGr0d6J4DJGiUPwg2J7Yfl/L+j9Gt
        bxn3ec1/nLmTbgvzQjm29c8=
X-Google-Smtp-Source: ABdhPJzqpFFb8GaUueMWKHogCPeU+K3/U6eAkIqlNhzsRLBXKv2s87c9u2maIwQFhnABDwoeetEC/A==
X-Received: by 2002:a5d:6288:: with SMTP id k8mr3474719wru.94.1591697797218;
        Tue, 09 Jun 2020 03:16:37 -0700 (PDT)
Received: from [192.168.1.201] (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.googlemail.com with ESMTPSA id s132sm2532769wmf.12.2020.06.09.03.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 03:16:36 -0700 (PDT)
Subject: Re: [PATCH v16 01/14] Write pseudorefs through ref backends.
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
References: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
 <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
 <4a1f600fb8520967778dd564279eabb8fd73a0e3.1591380199.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <68cdf3b9-4606-2a68-ac7d-0cff188d9ce8@gmail.com>
Date:   Tue, 9 Jun 2020 11:16:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <4a1f600fb8520967778dd564279eabb8fd73a0e3.1591380199.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/06/2020 19:03, Han-Wen Nienhuys via GitGitGadget wrote:
> From: Han-Wen Nienhuys <hanwen@google.com>
> 
> Pseudorefs store transient data in in the repository. Examples are HEAD,
> CHERRY_PICK_HEAD, etc.
> 
> These refs have always been read through the ref backends, but they were written
> in a one-off routine that wrote an object ID or symref directly into
> .git/<pseudo_ref_name>.
> 
> This causes problems when introducing a new ref storage backend. To remedy this,
> extend the ref backend implementation with a write_pseudoref_fn and
> update_pseudoref_fn.

I think this patch is looking better now, I've had a couple more
thoughts though

> [...]
> diff --git a/refs.h b/refs.h
> index e010f8aec28..4dad8f24914 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -732,6 +732,17 @@ int update_ref(const char *msg, const char *refname,
>  	       const struct object_id *new_oid, const struct object_id *old_oid,
>  	       unsigned int flags, enum action_on_err onerr);
>  
> +/* Pseudorefs (eg. HEAD, CHERRY_PICK_HEAD) have a separate routines for updating
> +   and deletion as they cannot take part in normal transactional updates.
> +   Pseudorefs should only be written for the main repository.
> +*/
> +int refs_write_pseudoref(struct ref_store *refs, const char *pseudoref,
> +			 const struct object_id *oid,
> +			 const struct object_id *old_oid, struct strbuf *err);
> +int refs_delete_pseudoref(struct ref_store *refs, const char *pseudoref,
> +			  const struct object_id *old_oid);
> +int delete_pseudoref(const char *pseudoref, const struct object_id *old_oid);
> +

Do we need to expose these functions to the rest of git? In sequencer.c
we write the pseudo ref REBASE_HEAD when a rebase stops due to
conflicts. It is created with update_ref() and deleted with
delete_ref(), is there a reason can't we just use update_ref()/delete
ref() for the other pseudo refs?

>  int parse_hide_refs_config(const char *var, const char *value, const char *);
>  
>  /*
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 6516c7bc8c8..df7553f4cc3 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -731,6 +731,115 @@ static int lock_raw_ref(struct files_ref_store *refs,
>  	return ret;
>  }
>  
> +static int files_write_pseudoref(struct ref_store *ref_store,
> +				 const char *pseudoref,
> +				 const struct object_id *oid,
> +				 const struct object_id *old_oid,
> +				 struct strbuf *err)
> +{
> +	struct files_ref_store *refs =
> +		files_downcast(ref_store, REF_STORE_READ, "write_pseudoref");
> +	int fd;
> +	struct lock_file lock = LOCK_INIT;
> +	struct strbuf filename = STRBUF_INIT;
> +	struct strbuf buf = STRBUF_INIT;
> +	int ret = -1;
> +
> +	if (!oid)
> +		return 0;
> +
> +	strbuf_addf(&filename, "%s/%s", refs->gitdir, pseudoref);
> +	fd = hold_lock_file_for_update_timeout(&lock, filename.buf, 0,
> +					       get_files_ref_lock_timeout_ms());
> +	if (fd < 0) {
> +		strbuf_addf(err, _("could not open '%s' for writing: %s"),
> +			    buf.buf, strerror(errno));
> +		goto done;
> +	}
> +
> +	if (old_oid) {
> +		struct object_id actual_old_oid;
> +
> +		if (read_ref(pseudoref, &actual_old_oid)) {
> +			if (!is_null_oid(old_oid)) {
> +				strbuf_addf(err, _("could not read ref '%s'"),
> +					    pseudoref);
> +				rollback_lock_file(&lock);
> +				goto done;
> +			}
> +		} else if (is_null_oid(old_oid)) {
> +			strbuf_addf(err, _("ref '%s' already exists"),
> +				    pseudoref);
> +			rollback_lock_file(&lock);
> +			goto done;
> +		} else if (!oideq(&actual_old_oid, old_oid)) {
> +			strbuf_addf(err,
> +				    _("unexpected object ID when writing '%s'"),
> +				    pseudoref);
> +			rollback_lock_file(&lock);
> +			goto done;
> +		}
> +	}
> +
> +	strbuf_addf(&buf, "%s\n", oid_to_hex(oid));
> +	if (write_in_full(fd, buf.buf, buf.len) < 0) {
> +		strbuf_addf(err, _("could not write to '%s'"), filename.buf);
> +		rollback_lock_file(&lock);
> +		goto done;
> +	}
> +
> +	commit_lock_file(&lock);
> +	ret = 0;
> +done:
> +	strbuf_release(&buf);
> +	strbuf_release(&filename);
> +	return ret;
> +}
> +
> +static int files_delete_pseudoref(struct ref_store *ref_store,
> +				  const char *pseudoref,
> +				  const struct object_id *old_oid)
> +{
> +	struct files_ref_store *refs =
> +		files_downcast(ref_store, REF_STORE_READ, "delete_pseudoref");
> +	struct strbuf filename = STRBUF_INIT;
> +	int ret = -1;
> +
> +	strbuf_addf(&filename, "%s/%s", refs->gitdir, pseudoref);
> +
> +	if (old_oid && !is_null_oid(old_oid)) {
> +		struct lock_file lock = LOCK_INIT;
> +		int fd;
> +		struct object_id actual_old_oid;
> +
> +		fd = hold_lock_file_for_update_timeout(
> +			&lock, filename.buf, 0,
> +			get_files_ref_lock_timeout_ms());
> +		if (fd < 0) {
> +			error_errno(_("could not open '%s' for writing"),
> +				    filename.buf);
> +			goto done;
> +		}
> +		if (read_ref(pseudoref, &actual_old_oid))
> +			die(_("could not read ref '%s'"), pseudoref);
> +		if (!oideq(&actual_old_oid, old_oid)) {
> +			error(_("unexpected object ID when deleting '%s'"),
> +			      pseudoref);
> +			rollback_lock_file(&lock);
> +			goto done;
> +		}
> +
> +		unlink(filename.buf);

This could fail (especially on windows I think) and there are one or two
places in sequencer.c where we do actually check that the ref has
actually been deleted. Switching to calling delete_pseudoref() as it
stands will break those checks. What are the error semantics of normal
ref deletion where the file cannot be unlinked?

Best Wishes

Phillip

> +		rollback_lock_file(&lock);
> +	} else {
> +		unlink(filename.buf);
> +	}
> +	ret = 0;
> +done:
> +	strbuf_release(&filename);
> +	return ret;
> +}
> +
>  struct files_ref_iterator {
>  	struct ref_iterator base;
>  
> @@ -3189,6 +3298,9 @@ struct ref_storage_be refs_be_files = {
>  	files_rename_ref,
>  	files_copy_ref,
>  
> +	files_write_pseudoref,
> +	files_delete_pseudoref,
> +
>  	files_ref_iterator_begin,
>  	files_read_raw_ref,
>  
> @@ -3198,5 +3310,5 @@ struct ref_storage_be refs_be_files = {
>  	files_reflog_exists,
>  	files_create_reflog,
>  	files_delete_reflog,
> -	files_reflog_expire
> +	files_reflog_expire,
>  };
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 4458a0f69cc..08e8253a893 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -1590,6 +1590,22 @@ static int packed_copy_ref(struct ref_store *ref_store,
>  	BUG("packed reference store does not support copying references");
>  }
>  
> +static int packed_write_pseudoref(struct ref_store *ref_store,
> +				  const char *pseudoref,
> +				  const struct object_id *oid,
> +				  const struct object_id *old_oid,
> +				  struct strbuf *err)
> +{
> +	BUG("packed reference store does not support writing pseudo-references");
> +}
> +
> +static int packed_delete_pseudoref(struct ref_store *ref_store,
> +				   const char *pseudoref,
> +				   const struct object_id *old_oid)
> +{
> +	BUG("packed reference store does not support deleting pseudo-references");
> +}
> +
>  static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_store)
>  {
>  	return empty_ref_iterator_begin();
> @@ -1656,6 +1672,9 @@ struct ref_storage_be refs_be_packed = {
>  	packed_rename_ref,
>  	packed_copy_ref,
>  
> +	packed_write_pseudoref,
> +	packed_delete_pseudoref,
> +
>  	packed_ref_iterator_begin,
>  	packed_read_raw_ref,
>  
> @@ -1665,5 +1684,5 @@ struct ref_storage_be refs_be_packed = {
>  	packed_reflog_exists,
>  	packed_create_reflog,
>  	packed_delete_reflog,
> -	packed_reflog_expire
> +	packed_reflog_expire,
>  };
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index 4271362d264..59b053d53a2 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -556,6 +556,21 @@ typedef int copy_ref_fn(struct ref_store *ref_store,
>  			  const char *oldref, const char *newref,
>  			  const char *logmsg);
>  
> +typedef int write_pseudoref_fn(struct ref_store *ref_store,
> +			       const char *pseudoref,
> +			       const struct object_id *oid,
> +			       const struct object_id *old_oid,
> +			       struct strbuf *err);
> +
> +/*
> + * Deletes a pseudoref. Deletion always succeeds (even if the pseudoref doesn't
> + * exist.), except if old_oid is specified. If it is, it can fail due to lock
> + * failure, failure reading the old OID, or an OID mismatch
> + */
> +typedef int delete_pseudoref_fn(struct ref_store *ref_store,
> +				const char *pseudoref,
> +				const struct object_id *old_oid);
> +
>  /*
>   * Iterate over the references in `ref_store` whose names start with
>   * `prefix`. `prefix` is matched as a literal string, without regard
> @@ -655,6 +670,9 @@ struct ref_storage_be {
>  	rename_ref_fn *rename_ref;
>  	copy_ref_fn *copy_ref;
>  
> +	write_pseudoref_fn *write_pseudoref;
> +	delete_pseudoref_fn *delete_pseudoref;
> +
>  	ref_iterator_begin_fn *iterator_begin;
>  	read_raw_ref_fn *read_raw_ref;
>  
> 

