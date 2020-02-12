Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC1EC352A4
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 20:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071AF2465D
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 20:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="qhYaTiDy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgBLUZm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:25:42 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34091 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgBLUZm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 15:25:42 -0500
Received: by mail-pl1-f196.google.com with SMTP id j7so1391255plt.1
        for <git@vger.kernel.org>; Wed, 12 Feb 2020 12:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s5cim649LF2ynkQT6C6Zm/OLqHFbUQN0L5kf16mNnk8=;
        b=qhYaTiDyDw9jmImtsbvT9xVaFaB76sbdOk4TPXMo2aezogaFOF4NPVSUQLkoeTQ/BJ
         QfaqToqXfzjqwzGkdiLP2deDoZmkqVoiwTWCZxLiCTHXen8nV9k1zV2TpHtsK19AwZKh
         +BIp5FWJP1Y5v2ySl1lMcKX/XVmJ2e6VIQIrSv/KazCoyBBlQUmV3UEXrsHGe70GqveP
         VLihHzoeDx2v5bP7J2+ItRhzxgW5bMMiSPLSXVbidIeLymi9fEPROrStsLAs5nTO5ayk
         1zfD5qse9rgpge5TEJh02kq/daaKohhathJTLrKMGTH6p0G8KRksNy37q1nn4I8afYTs
         ez2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s5cim649LF2ynkQT6C6Zm/OLqHFbUQN0L5kf16mNnk8=;
        b=Tqywe2q9o1wMf53ezeh/0FXZqBVyPMRZUEuV8wpHcWPTt4lfjhS7Fif1pWnKVYy1iU
         +ek+R2mGEINRWBxfMsDO6X12wLy5jHjqQNRbHdv1Y3FJs1inE/HFRvGzIF46us01hegG
         OqaKxW1CTBXg9dfZe+T5gfEckbqfcw121FlInViQqzqzAJThipylR1BXBkeG0VnyZbNp
         vXk9zgJEmJo3RL1PElgsjeGwoxX/SeWx/5nrYNtmpmgJy3PUITopjkvFQzBfkqPG1Bk9
         /JTrV0HQ/27xW21TBRtK+FlmlTrWxHMZ/L2Jm/eZUoAZrK9ie1uqhVbYKmj9USBdte/4
         7Utw==
X-Gm-Message-State: APjAAAWADpDCdge0IPj1hfxuX0cVMvJk4sKtICrV/0Z3M4dg9PQW65/x
        yzNrrs3AkSrAD7onruhe9TXfWA==
X-Google-Smtp-Source: APXvYqwCgVrc+4zNLPpWxgU/Fr9lhQZ9CxIM9Q/4BlyiU16rG364R5uALNjehE2ZTOt4qj6YfB3snA==
X-Received: by 2002:a17:902:8b89:: with SMTP id ay9mr9821591plb.309.1581539141472;
        Wed, 12 Feb 2020 12:25:41 -0800 (PST)
Received: from localhost ([205.175.106.8])
        by smtp.gmail.com with ESMTPSA id g7sm110290pfq.33.2020.02.12.12.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 12:25:41 -0800 (PST)
Date:   Wed, 12 Feb 2020 12:25:40 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Parth Gala via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Parth Gala <parthpgala@gmail.com>
Subject: Re: [PATCH 2/5] object.c: lookup_unknown_object() accept 'r' as
 parameter
Message-ID: <20200212202540.GD4364@syl.local>
References: <pull.545.git.1581535151.gitgitgadget@gmail.com>
 <16dd64618ab6a086727685e9eca3850fabc46437.1581535151.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <16dd64618ab6a086727685e9eca3850fabc46437.1581535151.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 12, 2020 at 07:19:08PM +0000, Parth Gala via GitGitGadget wrote:
> From: Parth Gala <parthpgala@gmail.com>
>
> 'lookup_unknown_object()' and its callers are modified to enable
> passing 'r' as an argument to 'lookup_unknown_object()' in an
> effort to reduce dependence on global 'the_repository' variable.

The changes in 'object.[ch]' look sane to me here, again, but I have the
same question about why assigning:

  struct repository *r = the_repository;

and passing 'r' everywhere is preferable to simply passing
'the_repository' in directly.

> Signed-off-by: Parth Gala <parthpgala@gmail.com>
> ---
>  builtin/fsck.c                   | 3 ++-
>  builtin/pack-objects.c           | 3 ++-
>  http-push.c                      | 3 ++-
>  object.c                         | 8 ++++----
>  object.h                         | 2 +-
>  refs.c                           | 3 ++-
>  t/helper/test-example-decorate.c | 7 ++++---
>  upload-pack.c                    | 3 ++-
>  walker.c                         | 3 ++-
>  9 files changed, 21 insertions(+), 14 deletions(-)
>
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index d2b4336f7e..cd0b67f3bc 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -745,7 +745,8 @@ static int fsck_cache_tree(struct cache_tree *it)
>
>  static void mark_object_for_connectivity(const struct object_id *oid)
>  {
> -	struct object *obj = lookup_unknown_object(oid);
> +	struct repository *r = the_repository;
> +	struct object *obj = lookup_unknown_object(r, oid);
>  	obj->flags |= HAS_OBJ;
>  }
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 393c20a2d7..b03f4378a0 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -2891,6 +2891,7 @@ static void add_objects_in_unpacked_packs(void)
>  {
>  	struct packed_git *p;
>  	struct in_pack in_pack;
> +	struct repository *r = the_repository;
>  	uint32_t i;
>
>  	memset(&in_pack, 0, sizeof(in_pack));
> @@ -2910,7 +2911,7 @@ static void add_objects_in_unpacked_packs(void)
>
>  		for (i = 0; i < p->num_objects; i++) {
>  			nth_packed_object_oid(&oid, p, i);
> -			o = lookup_unknown_object(&oid);
> +			o = lookup_unknown_object(r, &oid);
>  			if (!(o->flags & OBJECT_ADDED))
>  				mark_in_pack_object(o, p, &in_pack);
>  			o->flags |= OBJECT_ADDED;
> diff --git a/http-push.c b/http-push.c
> index 822f326599..c26d03b21b 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -1416,6 +1416,7 @@ static void one_remote_ref(const char *refname)
>  {
>  	struct ref *ref;
>  	struct object *obj;
> +	struct repository *r = the_repository;
>
>  	ref = alloc_ref(refname);
>
> @@ -1432,7 +1433,7 @@ static void one_remote_ref(const char *refname)
>  	 * may be required for updating server info later.
>  	 */
>  	if (repo->can_update_info_refs && !has_object_file(&ref->old_oid)) {
> -		obj = lookup_unknown_object(&ref->old_oid);
> +		obj = lookup_unknown_object(r, &ref->old_oid);
>  		fprintf(stderr,	"  fetch %s for %s\n",
>  			oid_to_hex(&ref->old_oid), refname);
>  		add_fetch_request(obj);
> diff --git a/object.c b/object.c
> index 549fbe69ca..90338a509c 100644
> --- a/object.c
> +++ b/object.c
> @@ -177,12 +177,12 @@ void *object_as_type(struct repository *r, struct object *obj, enum object_type
>  	}
>  }
>
> -struct object *lookup_unknown_object(const struct object_id *oid)
> +struct object *lookup_unknown_object(struct repository *r, const struct object_id *oid)
>  {
> -	struct object *obj = lookup_object(the_repository, oid);
> +	struct object *obj = lookup_object(r, oid);
>  	if (!obj)
> -		obj = create_object(the_repository, oid,
> -				    alloc_object_node(the_repository));
> +		obj = create_object(r, oid,
> +				    alloc_object_node(r));
>  	return obj;
>  }
>
> diff --git a/object.h b/object.h
> index 5a8ae274ee..375236cec3 100644
> --- a/object.h
> +++ b/object.h
> @@ -144,7 +144,7 @@ struct object *parse_object_or_die(const struct object_id *oid, const char *name
>  struct object *parse_object_buffer(struct repository *r, const struct object_id *oid, enum object_type type, unsigned long size, void *buffer, int *eaten_p);
>
>  /** Returns the object, with potentially excess memory allocated. **/
> -struct object *lookup_unknown_object(const struct object_id *oid);
> +struct object *lookup_unknown_object(struct repository *, const struct object_id *oid);
>
>  struct object_list *object_list_insert(struct object *item,
>  				       struct object_list **list_p);
> diff --git a/refs.c b/refs.c
> index 1ab0bb54d3..a630a8c271 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -379,7 +379,8 @@ static int filter_refs(const char *refname, const struct object_id *oid,
>
>  enum peel_status peel_object(const struct object_id *name, struct object_id *oid)
>  {
> -	struct object *o = lookup_unknown_object(name);
> +	struct repository *r = the_repository;
> +	struct object *o = lookup_unknown_object(r, name);
>
>  	if (o->type == OBJ_NONE) {
>  		int type = oid_object_info(the_repository, name, NULL);
> diff --git a/t/helper/test-example-decorate.c b/t/helper/test-example-decorate.c
> index c8a1cde7d2..6b3262a9d3 100644
> --- a/t/helper/test-example-decorate.c
> +++ b/t/helper/test-example-decorate.c
> @@ -10,6 +10,7 @@ int cmd__example_decorate(int argc, const char **argv)
>  	struct object_id two_oid = { {2} };
>  	struct object_id three_oid = { {3} };
>  	struct object *one, *two, *three;
> +	struct repository *r = the_repository;
>
>  	int decoration_a, decoration_b;
>
> @@ -26,8 +27,8 @@ int cmd__example_decorate(int argc, const char **argv)
>  	 * Add 2 objects, one with a non-NULL decoration and one with a NULL
>  	 * decoration.
>  	 */
> -	one = lookup_unknown_object(&one_oid);
> -	two = lookup_unknown_object(&two_oid);
> +	one = lookup_unknown_object(r, &one_oid);
> +	two = lookup_unknown_object(r, &two_oid);
>  	ret = add_decoration(&n, one, &decoration_a);
>  	if (ret)
>  		BUG("when adding a brand-new object, NULL should be returned");
> @@ -56,7 +57,7 @@ int cmd__example_decorate(int argc, const char **argv)
>  	ret = lookup_decoration(&n, two);
>  	if (ret != &decoration_b)
>  		BUG("lookup should return added declaration");
> -	three = lookup_unknown_object(&three_oid);
> +	three = lookup_unknown_object(r, &three_oid);
>  	ret = lookup_decoration(&n, three);
>  	if (ret)
>  		BUG("lookup for unknown object should return NULL");
> diff --git a/upload-pack.c b/upload-pack.c
> index cb7312268f..6d196e275b 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -962,7 +962,8 @@ static void receive_needs(struct packet_reader *reader, struct object_array *wan
>  static int mark_our_ref(const char *refname, const char *refname_full,
>  			const struct object_id *oid)
>  {
> -	struct object *o = lookup_unknown_object(oid);
> +	struct repository *r = the_repository;
> +	struct object *o = lookup_unknown_object(r, oid);
>
>  	if (ref_is_hidden(refname, refname_full)) {
>  		o->flags |= HIDDEN_REF;
> diff --git a/walker.c b/walker.c
> index 06cd2bd569..098c69ebe1 100644
> --- a/walker.c
> +++ b/walker.c
> @@ -258,6 +258,7 @@ void walker_targets_free(int targets, char **target, const char **write_ref)
>  int walker_fetch(struct walker *walker, int targets, char **target,
>  		 const char **write_ref, const char *write_ref_log_details)
>  {
> +	struct repository *r = the_repository;
>  	struct strbuf refname = STRBUF_INIT;
>  	struct strbuf err = STRBUF_INIT;
>  	struct ref_transaction *transaction = NULL;
> @@ -285,7 +286,7 @@ int walker_fetch(struct walker *walker, int targets, char **target,
>  			error("Could not interpret response from server '%s' as something to pull", target[i]);
>  			goto done;
>  		}
> -		if (process(walker, lookup_unknown_object(&oids[i])))
> +		if (process(walker, lookup_unknown_object(r, &oids[i])))
>  			goto done;
>  	}
>
> --
> gitgitgadget
>

Thanks,
Taylor
