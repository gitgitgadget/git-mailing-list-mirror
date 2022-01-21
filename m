Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B42C433EF
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 12:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380383AbiAUMcr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 07:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350502AbiAUMcq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 07:32:46 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B990C061574
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 04:32:46 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id z22so42289192edd.12
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 04:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=WgBTG6JsK/axuHOSMgtYZSmhUkdu8BGitO2hQ6HDAo8=;
        b=Y6xVWwvtuMKNWrfLk+gCD+NOyhOQzWznuh1tBb2SDM2/2yZACTNsAuFMs51e4RPaG+
         vmYgMoiwxRMgMWCIjVBnPWcIvcdJyqjpPfyo93niHsQ1ilfb8v4ijRXlQDZHVT5EehEf
         FQY5VZZR8bdmBdUaA9FHHrY21Qd7DbcU09auZaGBR6h8At0zpvRHKHLNr5QGk/4h7URO
         b6RuSZMDC10Z3mHQfnbEn9noUX0yPJkIS+TmT/1FGYkKOQ8YOhc7OZ09PvgkNg2U7kw7
         byMaks7Fosfh3WIb4c5nOmolF3n4hoA2oUd5FGS8OurtLpYs56ClGIINdv4IX5yZDDuN
         ZLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=WgBTG6JsK/axuHOSMgtYZSmhUkdu8BGitO2hQ6HDAo8=;
        b=H+BhO2M0FDOOMpMeBy7USceDZ2h67eq3HUx6cJDdUekTgiu/o1lrScRGcIb2TiMYA/
         Fs0o+XLY1qkYyeSyDbjZROf7HZRwiFr0Ye23ztv1vYEm8VK8jA67tAS0oXGrMcqcIIxB
         i9ZmFORTBqpFzlnaDNMqv7M79bgxmfWZNLoIDWqNC7gXgGGDtTXzR6o0cYwX9j+nQ0YJ
         cghU8mDjaLMBMZV8FkGYt02dAU4liv+6bL2w1YHRFV2FtYQ1Gt25XOl6+r60lErO5C6Q
         9oKhKRC4blYsFc3bB4qYkx87a8PAG85A03w1LvoKVe5ZfS0grqA3nAy6hqNf2IClEZmw
         f+xQ==
X-Gm-Message-State: AOAM530ceYzR0XlegwOC8+4uQW2bOq2MsKFqdcNDHclYJF3w1vGjk4eo
        JwCy3guocLUQCsaoKMB4+xxSNO1OQjA1AQ==
X-Google-Smtp-Source: ABdhPJyS1YoXVo4/yZ+EjOZxQzevN+oIVERA+iFPAHRPf5pAq+w5glee7LaZKModm/Qna+5zKwXzwA==
X-Received: by 2002:aa7:c1d7:: with SMTP id d23mr4072252edp.172.1642768364406;
        Fri, 21 Jan 2022 04:32:44 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id lc27sm2067884ejc.142.2022.01.21.04.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 04:32:43 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nAt5v-0028gO-6K;
        Fri, 21 Jan 2022 13:32:43 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v6 14/15] reftable: make reftable_record a tagged union
Date:   Fri, 21 Jan 2022 13:06:51 +0100
References: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
 <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
 <54bcac325bd542aa81328e5616b2b7573d43adac.1642691534.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <54bcac325bd542aa81328e5616b2b7573d43adac.1642691534.git.gitgitgadget@gmail.com>
Message-ID: <220121.86fsphjml0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 20 2022, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> This reduces the amount of glue code, because we don't need a void
> pointer or vtable within the structure.
> [...]
> -	struct reftable_record rec = { NULL };
> -	reftable_record_from_ref(&rec, &ref);
> +	struct reftable_record rec = { .type = BLOCK_TYPE_REF,
> +				       .u.ref = {
> +					       .refname = (char *)name,
> +				       } };
>  	return tab->ops->seek_record(tab->table_arg, it, &rec);
>  }

Both for this & the below don't we prefer to have such assignments on
their own line? I.e.:
	
	struct reftable_record rec = {
		.type = BLOCK_TYPE_REF,
	        .u.ref = { .refname = (char *)name },
	};

In this case the snuggling is buying is nothing in terms of line count,
and for the .u.ref assignment we were split across 3 lines instead of
1. So this seems easier to read to me....
	
>  int reftable_table_seek_log(struct reftable_table *tab,
>  			    struct reftable_iterator *it, const char *name)
>  {
> -	struct reftable_log_record log = {
> -		.refname = (char *)name,
> -		.update_index = ~((uint64_t)0),
> -	};
> -	struct reftable_record rec = { NULL };
> -	reftable_record_from_log(&rec, &log);
> +	struct reftable_record rec = { .type = BLOCK_TYPE_LOG,
> +				       .u.log = {
> +					       .refname = (char *)name,
> +					       .update_index = ~((uint64_t)0),
> +				       } };

...ditto..

>  	return tab->ops->seek_record(tab->table_arg, it, &rec);
>  }
>  
> @@ -129,17 +128,25 @@ void reftable_iterator_destroy(struct reftable_iterator *it)
>  int reftable_iterator_next_ref(struct reftable_iterator *it,
>  			       struct reftable_ref_record *ref)
>  {
> -	struct reftable_record rec = { NULL };
> -	reftable_record_from_ref(&rec, ref);
> -	return iterator_next(it, &rec);
> +	struct reftable_record rec = {
> +		.type = BLOCK_TYPE_REF,
> +		.u.ref = *ref,
> +	};

...and here we have the sort of assignment I'm suggesting, not

	struct reftable_record rec = { .type = [...]

...

>  int reftable_iterator_next_log(struct reftable_iterator *it,
>  			       struct reftable_log_record *log)
>  {
> -	struct reftable_record rec = { NULL };
> -	reftable_record_from_log(&rec, log);
> -	return iterator_next(it, &rec);
> +	struct reftable_record rec = {
> +		.type = BLOCK_TYPE_LOG,
> +		.u.log = *log,
> +	};

...ditto (good)....

> -	struct reftable_ref_record ref = {
> -		.refname = (char *)name,
> +	struct reftable_record rec = {
> +		.type = BLOCK_TYPE_REF,
> +		.u.ref = {
> +			.refname = (char *)name,
> +		},

... yet another style that's a mix between the two. I suppose always
putting the braces on their own line is consistent, but for these
one-member assignments just doing:

	struct reftable_record rec = {
		.type = BLOCK_TYPE_REF,
		.u.ref = { .refname = (char *)name },
  	};

seems easier to read....

> +	struct reftable_record rec = { .type = BLOCK_TYPE_LOG,
> +				       .u.log = {
> +					       .refname = (char *)name,
> +					       .update_index = update_index,
> +				       } };

...ditto (exhaustively wrapped)

>  	return merged_table_seek_record(mt, it, &rec);
>  }
>  
> diff --git a/reftable/pq.c b/reftable/pq.c
> index efc474017a2..96ca6dd37b3 100644
> --- a/reftable/pq.c
> +++ b/reftable/pq.c
> @@ -74,6 +74,7 @@ struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq)
>  void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, struct pq_entry e)
>  {
>  	int i = 0;
> +
>  	if (pq->len == pq->cap) {

A stray whitespace change. A good one, but maybe (depending on others in
the topic) bundle those into their own patch (or maybe it's not worth
it, haven't looked at the whole thing again).

In this case we don't otherwise touch this function, so maybe just
leaving it for some future re-formatting change is better?

> -		last = ref->refname;
> -		ref->refname = NULL;
> -		reftable_free(ref);
> +		// this is names[i], so don't dealloc.
> +		last = rec->u.ref.refname;
> +		rec->u.ref.refname = NULL;
> +		reftable_record_release(rec);

Per https://lore.kernel.org/git/87wnmwpwyf.fsf@evledraar.gmail.com/ I
think Junio at al prefer not to have C++-style comments in git, even
though they're also in C99.

>  	}
> -

...more stray whitespace...

> [...]
> -	struct reftable_index_record want_index = { .last_key = STRBUF_INIT };
> -	struct reftable_record want_index_rec = { NULL };
> -	struct reftable_index_record index_result = { .last_key = STRBUF_INIT };
> -	struct reftable_record index_result_rec = { NULL };
> +	struct reftable_record want_index = {
> +		.type = BLOCK_TYPE_INDEX, .u.idx = { .last_key = STRBUF_INIT }
> +	};
> +	struct reftable_record index_result = {
> +		.type = BLOCK_TYPE_INDEX,
> +		.u.idx = { .last_key = STRBUF_INIT },
> +	};

Here you are formatting/indenting these struct assignments exactly in
the style I suggested above (but within just this patch I think it's the
3rd or 4th style you're using picking).

>  	struct table_iter index_iter = TABLE_ITER_INIT;
>  	struct table_iter next = TABLE_ITER_INIT;
>  	int err = 0;
>  
> -	reftable_record_key(rec, &want_index.last_key);
> -	reftable_record_from_index(&want_index_rec, &want_index);
> -	reftable_record_from_index(&index_result_rec, &index_result);
> -
> +	reftable_record_key(rec, &want_index.u.idx.last_key);

Since you're adjusting whitespace that splits blocks for readability,
doesn't it mke sense to retain the reftable_record_key() as a "block"
here before reader_start(), even if there's only one of them left?

I.e. to split up data setup from "real work" in the function.

>  {
> -	struct reftable_ref_record ref = {
> -		.refname = (char *)name,
> +	struct reftable_record rec = {
> +		.type = BLOCK_TYPE_REF,
> +		.u.ref = {
> +			.refname = (char *)name,
> +		},
>  	};
> -	struct reftable_record rec = { NULL };
> -	reftable_record_from_ref(&rec, &ref);
>  	return reader_seek(r, it, &rec);
>  }

...more struct formatting...

> @@ -607,12 +608,11 @@ int reftable_reader_seek_log_at(struct reftable_reader *r,
>  				struct reftable_iterator *it, const char *name,
>  				uint64_t update_index)
>  {
> -	struct reftable_log_record log = {
> -		.refname = (char *)name,
> -		.update_index = update_index,
> -	};
> -	struct reftable_record rec = { NULL };
> -	reftable_record_from_log(&rec, &log);
> +	struct reftable_record rec = { .type = BLOCK_TYPE_LOG,
> +				       .u.log = {
> +					       .refname = (char *)name,
> +					       .update_index = update_index,
> +				       } };

..ditto...

>  	return reader_seek(r, it, &rec);
>  }
>  
> @@ -656,31 +656,33 @@ static int reftable_reader_refs_for_indexed(struct reftable_reader *r,
>  					    struct reftable_iterator *it,
>  					    uint8_t *oid)
>  {
> -	struct reftable_obj_record want = {
> -		.hash_prefix = oid,
> -		.hash_prefix_len = r->object_id_len,
> +	struct reftable_record want = {
> +		.type = BLOCK_TYPE_OBJ,
> +		.u.obj = {
> +			.hash_prefix = oid,
> +			.hash_prefix_len = r->object_id_len,
> +		},
>  	};

..ditto...

> -	struct reftable_record want_rec = { NULL };
>  	struct reftable_iterator oit = { NULL };
> -	struct reftable_obj_record got = { NULL };
> -	struct reftable_record got_rec = { NULL };
> +	struct reftable_record got = {
> +		.type = BLOCK_TYPE_OBJ,
> +		.u.obj = { 0 },
> +	};
>  	int err = 0;
>  	struct indexed_table_ref_iter *itr = NULL;
>  
>  	/* Look through the reverse index. */
> -	reftable_record_from_obj(&want_rec, &want);
> -	err = reader_seek(r, &oit, &want_rec);
> +	err = reader_seek(r, &oit, &want);
>  	if (err != 0)
>  		goto done;
>  
>  	/* read out the reftable_obj_record */
> -	reftable_record_from_obj(&got_rec, &got);
> -	err = iterator_next(&oit, &got_rec);
> +	err = iterator_next(&oit, &got);
>  	if (err < 0)
>  		goto done;
>  
> -	if (err > 0 ||
> -	    memcmp(want.hash_prefix, got.hash_prefix, r->object_id_len)) {
> +	if (err > 0 || memcmp(want.u.obj.hash_prefix, got.u.obj.hash_prefix,
> +			      r->object_id_len)) {
>  		/* didn't find it; return empty iterator */
>  		iterator_set_empty(it);
>  		err = 0;
> @@ -688,15 +690,16 @@ static int reftable_reader_refs_for_indexed(struct reftable_reader *r,
>  	}
>  
>  	err = new_indexed_table_ref_iter(&itr, r, oid, hash_size(r->hash_id),
> -					 got.offsets, got.offset_len);
> +					 got.u.obj.offsets,
> +					 got.u.obj.offset_len);
>  	if (err < 0)
>  		goto done;
> -	got.offsets = NULL;
> +	got.u.obj.offsets = NULL;
>  	iterator_from_indexed_table_ref_iter(it, itr);
>  
>  done:
>  	reftable_iterator_destroy(&oit);
> -	reftable_record_release(&got_rec);
> +	reftable_record_release(&got);
>  	return err;
>  }
>  
> diff --git a/reftable/record.c b/reftable/record.c
> index 2a9e41a992e..a8cee628942 100644
> --- a/reftable/record.c
> +++ b/reftable/record.c
> @@ -15,6 +15,10 @@ https://developers.google.com/open-source/licenses/bsd
>  #include "reftable-error.h"
>  #include "basics.h"
>  
> +static struct reftable_record_vtable *
> +reftable_record_vtable(struct reftable_record *rec);
> +static void *reftable_record_data(struct reftable_record *rec);

The reftable_record_data() function can just be moved above its first
user, and we can avoid this forward deceleration for a new static
function.

> +	if (src->hash_prefix_len)
> +		memcpy(obj->hash_prefix, src->hash_prefix, obj->hash_prefix_len);

Earlier I commented on other mem*() usage, but this goes against the
memcpy() paranoia being dropped referenced in the CL. I.e. we can do
away with the guard clause here too.

> +static void *reftable_record_data(struct reftable_record *rec)
> +{
> +	switch (rec->type) {
> +	case BLOCK_TYPE_REF:
> +		return &rec->u.ref;
> +	case BLOCK_TYPE_LOG:
> +		return &rec->u.log;
> +	case BLOCK_TYPE_INDEX:
> +		return &rec->u.idx;
> +	case BLOCK_TYPE_OBJ:
> +		return &rec->u.obj;
> +	}
> +	abort();
> +}

The static function we forward-declared above, and could just move up.

> +struct reftable_record reftable_new_record(uint8_t typ)
> +{

nit: There's no "type" variable in the below function, so just call this "type"?...

> +	struct reftable_record clean = {
> +		.type = typ,

...only this "type" member, which won't confuse a compiler.

> +	switch (typ) {

...but actually...


> +	case BLOCK_TYPE_OBJ:
> +	{
> +		struct reftable_obj_record obj = { 0 };
> +		clean.u.obj = obj;
> +		break;
> +	}
> +	case BLOCK_TYPE_INDEX:
> +	{
> +		struct reftable_index_record idx = {
> +			.last_key = STRBUF_INIT,
> +		};
> +		clean.u.idx = idx;
> +		break;
> +	}
> +	case BLOCK_TYPE_REF:
> +	{
> +		struct reftable_ref_record ref = { 0 };
> +		clean.u.ref = ref;
> +		break;
> +	}
> +	case BLOCK_TYPE_LOG:
> +	{
> +		struct reftable_log_record log = { 0 };
> +		clean.u.log = log;
> +		break;
> +	}
> +	}
> +	return clean;
> +}

...reading this whole function shouldn't this be a more normal *_init()
pattern function where the caller just populates the ".type = ", and we
init the rest here? That would also make the ownership more obvious, and
if any future API user needs to pass in variable on the heap instead of
us returning it on the stack here...

> -/* zeroes out the embedded record */
> +/* frees and zeroes out the embedded record */
>  void reftable_record_release(struct reftable_record *rec);

I didn't follow all the vtable entries, but for these:
    
    4 matches for ".release =" in buffer: record.c     
        440:        .release = &reftable_ref_record_release_void,
        582:        .release = &reftable_obj_record_release,
        925:        .release = &reftable_log_record_release_void,
       1052:        .release = &reftable_index_record_release,

Some zero'd the data out already, but for
"reftable_index_record_release" isn't promising this a bug, as we don't
want to memset() to 0 a strbuf_init()?

>  static void test_copy(struct reftable_record *rec)
>  {
> -	struct reftable_record copy =
> -		reftable_new_record(reftable_record_type(rec));
> +	struct reftable_record copy = { 0 };
> +	uint8_t typ;
> +
> +	typ = reftable_record_type(rec);

More odd s/typ/type/

Also for the whitespace here we can just add this assignment above where
we declare it.

> [...]
>  		};
> -
>  		int n, m;

Good whitespace change, but another thing to split up in unrelated
whitespace fixes...

> [...]
>  	struct strbuf key = STRBUF_INIT;
> -	struct reftable_record rec = { NULL };
> -	struct reftable_index_record out = { .last_key = STRBUF_INIT };
> -	struct reftable_record out_rec = { NULL };
> +	struct reftable_record out = {
> +		.type = BLOCK_TYPE_INDEX,
> +		.u.idx = { .last_key = STRBUF_INIT },
> +	};

Another case of different struct formatting (but the one I suggested using uniformly).

>  		int err = writer_finish_public_section(w);
> @@ -316,8 +320,6 @@ static int reftable_writer_add_log_verbatim(struct reftable_writer *w,
>  
>  	w->next -= w->pending_padding;
>  	w->pending_padding = 0;
> -

stray whitespace change...


>  	if (arg->err == 0)
>  		goto done;
> -	obj_rec.offset_len = 0;
> +

..stray whitespace change...

> +	rec.u.obj.offset_len = 0;
>  	arg->err = block_writer_add(arg->w->block_writer, &rec);
>  
>  	/* Should be able to write into a fresh block. */

