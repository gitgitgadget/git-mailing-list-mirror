Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F0EC54E8B
	for <git@archiver.kernel.org>; Tue, 12 May 2020 10:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A46CF20736
	for <git@archiver.kernel.org>; Tue, 12 May 2020 10:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uPdzhSov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbgELKWu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 06:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726193AbgELKWq (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 06:22:46 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38FAC061A0C
        for <git@vger.kernel.org>; Tue, 12 May 2020 03:22:45 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l17so1113932wrr.4
        for <git@vger.kernel.org>; Tue, 12 May 2020 03:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0GOH5BGD6xBrkJLNbhCb0erWMwP1twOsqBwMQ+H7zNc=;
        b=uPdzhSovQZaaAeWlINRtfwBN00+/rzWmcrkMlmDV9m4w44u7P4hOTAI158b8xhT1rM
         4FxLhJP1/5PNyNbHrZlhJBblObmZGcrmic2oBc/FHYyBp9yy/nEGIN5+YDgwzFWk5sxs
         QRWtDOjMCrV72a59MJbFSdCsMqziuHaE0vgB5xof9jZc22OSpUm6M9loYPd7nD6N2x2P
         YSMEY7DXIqI53Vh0f/TjeOF34e0KIwsUOgcF4NskX3GtzbO8fYlPqXxd742GJd02AYkZ
         6qrt2ffsK+A3MRamWXQp7FgiQDDP0skB4k4W18JT3HtjIpgx+SPOq6w9yuzFJIIMiNXi
         A+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0GOH5BGD6xBrkJLNbhCb0erWMwP1twOsqBwMQ+H7zNc=;
        b=FDQ4kx1+VV/r2+CTj/PJd0GLkyFpx8nG0lRVAgqo7CQWcVpenuICAOBwSaV8Um61iO
         NS8dTkkgMnDgx+h/i/8rLXL9r4z+AOKPIgIHcp6fb69ByxbXWNk9IAXhBduBIgEHqIGh
         MGzOnmQQ/ShB66rQbc4gYvrxE3WtggvnGIi+xC6bojgeQAyQe7g8B1TGLVjNXGXXSEbm
         eQkyvJzJn0PVHCIz0pR68dbHoQG9qKAN+I/DLSEtULkgLcjWlqJpPq+5SIi9Oym++XwA
         lS1No/u04xcd7SwaFyxlNuLxwSORAEzqdB1z5DhSPTtg7MnueqaPYyzVML7FIvZITfMb
         tGEg==
X-Gm-Message-State: AOAM532Tir8p6cX6eaiHnitdXniKp0I7oBSJ2/LtYyNZsJVzcr83NawH
        lEvUh0DDjJC8pulk/ifLMr4c7Mr9
X-Google-Smtp-Source: ABdhPJx6Bvb2SYe2fj+76qG4lQBUKtwAcXY8K2Q7ZGUwQ6XiR0WlpXHdrnpEQtfTcAREe4T4C57Eqg==
X-Received: by 2002:a05:6000:ce:: with SMTP id q14mr1976524wrx.105.1589278964279;
        Tue, 12 May 2020 03:22:44 -0700 (PDT)
Received: from [192.168.1.201] (155.20.198.146.dyn.plus.net. [146.198.20.155])
        by smtp.googlemail.com with ESMTPSA id r11sm19108637wma.35.2020.05.12.03.22.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 03:22:43 -0700 (PDT)
Subject: Re: [PATCH v13 07/13] Write pseudorefs through ref backends.
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
References: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
 <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
 <2c2f94ddc0e77c8c70041a2a736e3a56698f058c.1589226388.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <cd06245f-4717-3695-9550-0d8c4244725a@gmail.com>
Date:   Tue, 12 May 2020 11:22:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <2c2f94ddc0e77c8c70041a2a736e3a56698f058c.1589226388.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Han-Wen

Thanks for working on the reftable implementation. I've had a look at
this patch but bear in mind I'm not familiar with the refs code

On 11/05/2020 20:46, Han-Wen Nienhuys via GitGitGadget wrote:
> From: Han-Wen Nienhuys <hanwen@google.com>
> 
> Pseudorefs store transient data in in the repository. Examples are HEAD,
> CHERRY_PICK_HEAD, etc.
> 
> These refs have always been read through the ref backends, but they were written
> in a one-off routine that wrote a object ID or symref directly wrote into
> .git/<pseudo_ref_name>.
> 
> This causes problems when introducing a new ref storage backend. To remedy this,
> extend the ref backend implementation with a write_pseudoref_fn and
> update_pseudoref_fn.
> 
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  refs.c                | 115 +++++------------------------
>  refs.h                |  11 +++
>  refs/files-backend.c  | 164 +++++++++++++++++++++++++++++++++++-------
>  refs/packed-backend.c |  40 ++++-------
>  refs/refs-internal.h  |  12 ++++
>  5 files changed, 192 insertions(+), 150 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 224ff66c7bb..fc72211a36f 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -739,101 +739,6 @@ long get_files_ref_lock_timeout_ms(void)
>  	return timeout_ms;
>  }
>  
> -static int write_pseudoref(const char *pseudoref, const struct object_id *oid,
> -			   const struct object_id *old_oid, struct strbuf *err)
> -{
> -	const char *filename;
> -	int fd;
> -	struct lock_file lock = LOCK_INIT;
> -	struct strbuf buf = STRBUF_INIT;
> -	int ret = -1;
> -
> -	if (!oid)
> -		return 0;
> -
> -	strbuf_addf(&buf, "%s\n", oid_to_hex(oid));
> -
> -	filename = git_path("%s", pseudoref);
> -	fd = hold_lock_file_for_update_timeout(&lock, filename, 0,
> -					       get_files_ref_lock_timeout_ms());
> -	if (fd < 0) {
> -		strbuf_addf(err, _("could not open '%s' for writing: %s"),
> -			    filename, strerror(errno));
> -		goto done;
> -	}
> -
> -	if (old_oid) {
> -		struct object_id actual_old_oid;
> -
> -		if (read_ref(pseudoref, &actual_old_oid)) {
> -			if (!is_null_oid(old_oid)) {
> -				strbuf_addf(err, _("could not read ref '%s'"),
> -					    pseudoref);
> -				rollback_lock_file(&lock);
> -				goto done;
> -			}
> -		} else if (is_null_oid(old_oid)) {
> -			strbuf_addf(err, _("ref '%s' already exists"),
> -				    pseudoref);
> -			rollback_lock_file(&lock);
> -			goto done;
> -		} else if (!oideq(&actual_old_oid, old_oid)) {
> -			strbuf_addf(err, _("unexpected object ID when writing '%s'"),
> -				    pseudoref);
> -			rollback_lock_file(&lock);
> -			goto done;
> -		}
> -	}
> -
> -	if (write_in_full(fd, buf.buf, buf.len) < 0) {
> -		strbuf_addf(err, _("could not write to '%s'"), filename);
> -		rollback_lock_file(&lock);
> -		goto done;
> -	}
> -
> -	commit_lock_file(&lock);
> -	ret = 0;
> -done:
> -	strbuf_release(&buf);
> -	return ret;
> -}
> -
> -static int delete_pseudoref(const char *pseudoref, const struct object_id *old_oid)
> -{
> -	const char *filename;
> -
> -	filename = git_path("%s", pseudoref);
> -
> -	if (old_oid && !is_null_oid(old_oid)) {
> -		struct lock_file lock = LOCK_INIT;
> -		int fd;
> -		struct object_id actual_old_oid;
> -
> -		fd = hold_lock_file_for_update_timeout(
> -				&lock, filename, 0,
> -				get_files_ref_lock_timeout_ms());
> -		if (fd < 0) {
> -			error_errno(_("could not open '%s' for writing"),
> -				    filename);
> -			return -1;
> -		}
> -		if (read_ref(pseudoref, &actual_old_oid))
> -			die(_("could not read ref '%s'"), pseudoref);
> -		if (!oideq(&actual_old_oid, old_oid)) {
> -			error(_("unexpected object ID when deleting '%s'"),
> -			      pseudoref);
> -			rollback_lock_file(&lock);
> -			return -1;
> -		}
> -
> -		unlink(filename);
> -		rollback_lock_file(&lock);
> -	} else {
> -		unlink(filename);
> -	}
> -
> -	return 0;
> -}
>  
>  int refs_delete_ref(struct ref_store *refs, const char *msg,
>  		    const char *refname,
> @@ -844,8 +749,7 @@ int refs_delete_ref(struct ref_store *refs, const char *msg,
>  	struct strbuf err = STRBUF_INIT;
>  
>  	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
> -		assert(refs == get_main_ref_store(the_repository));

I don't think you meant to delete this line, the equivalent line is left
untouched in the next hunk and there are comments in refs.h saying this
should only me called on the main repository

> -		return delete_pseudoref(refname, old_oid);
> +		return ref_store_delete_pseudoref(refs, refname, old_oid);
>  	}
>  
>  	transaction = ref_store_transaction_begin(refs, &err);
> @@ -1172,7 +1076,8 @@ int refs_update_ref(struct ref_store *refs, const char *msg,
>  
>  	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
>  		assert(refs == get_main_ref_store(the_repository));
> -		ret = write_pseudoref(refname, new_oid, old_oid, &err);
> +		ret = ref_store_write_pseudoref(refs, refname, new_oid, old_oid,
> +						&err);
>  	} else {
>  		t = ref_store_transaction_begin(refs, &err);
>  		if (!t ||
> @@ -1441,6 +1346,20 @@ int head_ref(each_ref_fn fn, void *cb_data)
>  	return refs_head_ref(get_main_ref_store(the_repository), fn, cb_data);
>  }
>  
> +int ref_store_write_pseudoref(struct ref_store *refs, const char *pseudoref,
> +			      const struct object_id *oid,
> +			      const struct object_id *old_oid,
> +			      struct strbuf *err)
> +{
> +	return refs->be->write_pseudoref(refs, pseudoref, oid, old_oid, err);
> +}
> +
> +int ref_store_delete_pseudoref(struct ref_store *refs, const char *pseudoref,
> +			       const struct object_id *old_oid)
> +{
> +	return refs->be->delete_pseudoref(refs, pseudoref, old_oid);
> +}
> +
>  struct ref_iterator *refs_ref_iterator_begin(
>  		struct ref_store *refs,
>  		const char *prefix, int trim, int flags)
> diff --git a/refs.h b/refs.h
> index 99ba9e331e5..d1d9361441b 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -728,6 +728,17 @@ int update_ref(const char *msg, const char *refname,
>  	       const struct object_id *new_oid, const struct object_id *old_oid,
>  	       unsigned int flags, enum action_on_err onerr);
>  
> +/* Pseudorefs (eg. HEAD, CHERRY_PICK_HEAD) have a separate routines for updating
> +   and deletion as they cannot take part in normal transactional updates.
> +   Pseudorefs should only be written for the main repository.
> +*/
> +int ref_store_write_pseudoref(struct ref_store *refs, const char *pseudoref,
> +			      const struct object_id *oid,
> +			      const struct object_id *old_oid,
> +			      struct strbuf *err);
> +int ref_store_delete_pseudoref(struct ref_store *refs, const char *pseudoref,
> +			       const struct object_id *old_oid);
> +
>  int parse_hide_refs_config(const char *var, const char *value, const char *);
>  
>  /*
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 6516c7bc8c8..53b891190be 100644
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

The original used git_path(), this change looks correct to an uninformed
reviewer. As far as I can see the only changes to this function are to
accommodate the strbuf which is cleanup up correctly.

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

Same comment as above, the memory management looks good.

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
> @@ -3173,30 +3282,31 @@ static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
>  	return 0;
>  }
>  
> -struct ref_storage_be refs_be_files = {
> -	NULL,
> -	"files",
> -	files_ref_store_create,
> -	files_init_db,
> -	files_transaction_prepare,
> -	files_transaction_finish,
> -	files_transaction_abort,
> -	files_initial_transaction_commit,
> -
> -	files_pack_refs,
> -	files_create_symref,
> -	files_delete_refs,
> -	files_rename_ref,
> -	files_copy_ref,
> -
> -	files_ref_iterator_begin,
> -	files_read_raw_ref,
> -
> -	files_reflog_iterator_begin,
> -	files_for_each_reflog_ent,
> -	files_for_each_reflog_ent_reverse,
> -	files_reflog_exists,
> -	files_create_reflog,
> -	files_delete_reflog,
> -	files_reflog_expire
> -};
> +struct ref_storage_be refs_be_files = { NULL,
> +					"files",
> +					files_ref_store_create,
> +					files_init_db,
> +					files_transaction_prepare,
> +					files_transaction_finish,
> +					files_transaction_abort,
> +					files_initial_transaction_commit,
> +
> +					files_pack_refs,
> +					files_create_symref,
> +					files_delete_refs,
> +					files_rename_ref,
> +					files_copy_ref,
> +
> +					files_write_pseudoref,
> +					files_delete_pseudoref,
> +
> +					files_ref_iterator_begin,
> +					files_read_raw_ref,
> +
> +					files_reflog_iterator_begin,
> +					files_for_each_reflog_ent,
> +					files_for_each_reflog_ent_reverse,
> +					files_reflog_exists,
> +					files_create_reflog,
> +					files_delete_reflog,
> +					files_reflog_expire };

The formatting has gone haywire

> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 4458a0f69cc..8f9b85f0b0c 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -1641,29 +1641,19 @@ static int packed_reflog_expire(struct ref_store *ref_store,
>  }
>  
>  struct ref_storage_be refs_be_packed = {
> -	NULL,
> -	"packed",
> -	packed_ref_store_create,
> -	packed_init_db,
> -	packed_transaction_prepare,
> -	packed_transaction_finish,
> -	packed_transaction_abort,
> -	packed_initial_transaction_commit,
> -
> -	packed_pack_refs,
> -	packed_create_symref,
> -	packed_delete_refs,
> -	packed_rename_ref,
> -	packed_copy_ref,
> -
> -	packed_ref_iterator_begin,
> -	packed_read_raw_ref,
> -
> -	packed_reflog_iterator_begin,
> -	packed_for_each_reflog_ent,
> -	packed_for_each_reflog_ent_reverse,
> -	packed_reflog_exists,
> -	packed_create_reflog,
> -	packed_delete_reflog,
> -	packed_reflog_expire
> +	NULL, "packed", packed_ref_store_create, packed_init_db,
> +	packed_transaction_prepare, packed_transaction_finish,
> +	packed_transaction_abort, packed_initial_transaction_commit,
> +
> +	packed_pack_refs, packed_create_symref, packed_delete_refs,
> +	packed_rename_ref, packed_copy_ref,
> +
> +	/* XXX */
> +	NULL, NULL,

Should the wrappers above that invoke these virtual functions check they
are non-null before dereferencing them? It would be better to die with
BUG() than segfault.

> +
> +	packed_ref_iterator_begin, packed_read_raw_ref,
> +
> +	packed_reflog_iterator_begin, packed_for_each_reflog_ent,
> +	packed_for_each_reflog_ent_reverse, packed_reflog_exists,
> +	packed_create_reflog, packed_delete_reflog, packed_reflog_expire

Formatting again

I think this patch basically works but I'm concerned by the potential
NULL pointer dereference. While it's unfair to judge a patch by it's
formatting the changes to the formatting of existing code and the
dropped assertion rightly or wrongly gave me the impression lack of
attention which does make me concerned that there are other more serious
unintentional changes in the rest of the series.

Best Wishes

Phillip

>  };
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index 3490aac3a40..dabe18baea1 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -549,6 +549,15 @@ typedef int copy_ref_fn(struct ref_store *ref_store,
>  			  const char *oldref, const char *newref,
>  			  const char *logmsg);
>  
> +typedef int write_pseudoref_fn(struct ref_store *ref_store,
> +			       const char *pseudoref,
> +			       const struct object_id *oid,
> +			       const struct object_id *old_oid,
> +			       struct strbuf *err);
> +typedef int delete_pseudoref_fn(struct ref_store *ref_store,
> +				const char *pseudoref,
> +				const struct object_id *old_oid);
> +
>  /*
>   * Iterate over the references in `ref_store` whose names start with
>   * `prefix`. `prefix` is matched as a literal string, without regard
> @@ -648,6 +657,9 @@ struct ref_storage_be {
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

