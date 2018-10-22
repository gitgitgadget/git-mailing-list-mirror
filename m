Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B68461F453
	for <e@80x24.org>; Mon, 22 Oct 2018 09:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbeJVSPs (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 14:15:48 -0400
Received: from mout.gmx.net ([212.227.17.22]:43545 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728362AbeJVSPs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 14:15:48 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LufbI-1fWV4K2u0G-00zo46; Mon, 22
 Oct 2018 11:57:45 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LufbI-1fWV4K2u0G-00zo46; Mon, 22
 Oct 2018 11:57:45 +0200
Date:   Mon, 22 Oct 2018 11:57:46 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3] fetch: replace string-list used as a look-up table
 with a hashmap
In-Reply-To: <xmqqy3au1tr1.fsf_-_@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1810221140510.4546@tvgsbejvaqbjf.bet>
References: <xmqqin2sj6df.fsf@gitster-ct.c.googlers.com>        <20180927053418.GB14178@sigill.intra.peff.net>        <xmqq5zyn91ku.fsf@gitster-ct.c.googlers.com> <xmqqy3au1tr1.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Bhx6w7LZUMyAdLouHHa/52xDC1SYHFIJElG3FOFRb0U8wFmHogm
 4tEZ6VRJ9k3Tz62gC+aX8Rg5w0lErGEKkfM+5uo0uHXRgYBi5Un3Ln+mJlP/39aG3/lsxrL
 4BolXvG0fYlDZy4zD3bP/dqT2oX68npgBZwjC6JMUi9dxnEkUqBKTu4ZVo7kJ6fJ7Jhnd2p
 WOH/DYopj02ZHTf3WUalg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WpUwNGR6JgQ=:5kqv6CpjkDbjrkaC0iY50m
 txk7rLCl+bbxz9UMB7EHBTC7BEu5ttYJrfDkVwW9YNORAlw8IE/BYLH2f97pT8WNn7EEcayX/
 qe3H2IZk+m3JZ6CPTZbpO94ZULQKNW9kpC/m587rENqx1vVU2vWzyhsI47aR6PtqJb2M4Roh1
 LUbvbRBJMS1TGgiPISaDw8c/4juYQqBsWhKzk251N5ChucHIb2UGvlq0p7EP97lFg6hEn9KlA
 q09TfjpAeRkCLhOkYOBHm+3cMgsdbtUpCabY0aunZLUI4sqYGVrcQ63gnb1uvLQr96PPgNYL6
 KRcmLRmQfeUo5Oqn7gQPY1va33NOAfPzxHRhzaJgcernt2dvdXLQTAeEiUTZVsCAdYQZEjovb
 GmWArFVAOjgLq82LifxHY2wMWVARP1ThXu4JX6wbx3Mdzg+HAbV2pQh09tpne6+5HaG3AvqBw
 wyY342Hevk5InJuqKfKoqPhyJAhYN09BIG/d1CV3LnYpDO1sgLT8uAheV+NIEyRYQIwAWfRr0
 hxkJGinsypdUN5D21cnHCUTWpU5AMAm0iJ7E0K7Mrouv+uSx4YGGY6MaSkVfsySv/pedWJBHy
 07lCdFnf87OYbTR2b2HbibyVR05q2Z4/YeGABdoeA9osQi6jU9CgoVkFJ6PO8uaV1auOoTvQU
 A+F5flpZ+bGUXXe5S8E9u16GAXC1wTNiCQdzrz+i4/IlMdmKnh22iU3/A8ovmLsa+wzSFFOdO
 pldqAtx528946EfYUAMPwzt5wQsu/ObpegX1omLLW3XB+rKXAiUhu6/AIFV+4qXL9mvPWesX/
 rBEkEQL/n9fWQkE2OTnxrBDN6u5tfTmqCR+VGOsZTP5xuMI90c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 19 Oct 2018, Junio C Hamano wrote:

> In find_non_local_tags() helper function (used to implement the
> "follow tags"), we use string_list_has_string() on two string lists
> as a way to see if a refname has already been processed, etc.
> 
> All this code predates more modern in-core lookup API like hashmap;
> replace them with two hashmaps and one string list---the hashmaps
> are used for look-ups and the string list is to keep the order of
> items in the returned result stable (which is the only single thing
> hashmap does worse than lookups on string-list).

This sounds as if you would need a linked hash map, i.e. a hash map whose
iterator remembers the order in which items were inserted.

I am fine, however, with your patch as a first step in that direction, and
only implementing a linked hash map when we realize that we need it
somewhere else, too.

Just one thing^W^Wa couple of things:

> Similarly, get_ref_map() uses another string-list as a look-up table
> for existing refs.  Replace it with a hashmap.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * This converts another string-list user in the same file.  For now
>    I am done with this topic; I'm willing to fix bugs in this patch,
>    but do not intend to spend time killing more string-lists used as
>    look-up tables.
> 
>  builtin/fetch.c | 152 +++++++++++++++++++++++++++++++++---------------
>  1 file changed, 106 insertions(+), 46 deletions(-)
> 
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 0696abfc2a..0f8e333022 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -223,18 +223,6 @@ static void add_merge_config(struct ref **head,
>  	}
>  }
>  
> -static int add_existing(const char *refname, const struct object_id *oid,
> -			int flag, void *cbdata)
> -{
> -	struct string_list *list = (struct string_list *)cbdata;
> -	struct string_list_item *item = string_list_insert(list, refname);
> -	struct object_id *old_oid = xmalloc(sizeof(*old_oid));
> -
> -	oidcpy(old_oid, oid);
> -	item->util = old_oid;
> -	return 0;
> -}
> -
>  static int will_fetch(struct ref **head, const unsigned char *sha1)
>  {
>  	struct ref *rm = *head;
> @@ -246,16 +234,76 @@ static int will_fetch(struct ref **head, const unsigned char *sha1)
>  	return 0;
>  }
>  
> +struct refname_hash_entry {
> +	struct hashmap_entry ent; /* must be the first member */
> +	struct object_id oid;
> +	char refname[FLEX_ARRAY];
> +};
> +
> +static int refname_hash_entry_cmp(const void *hashmap_cmp_fn_data,
> +				  const void *e1_,
> +				  const void *e2_,
> +				  const void *keydata)
> +{
> +	const struct refname_hash_entry *e1 = e1_;
> +	const struct refname_hash_entry *e2 = e2_;
> +
> +	return strcmp(e1->refname, keydata ? keydata : e2->refname);
> +}
> +
> +static struct refname_hash_entry *refname_hash_add(struct hashmap *map,
> +						   const char *refname,
> +						   const struct object_id *oid)
> +{
> +	struct refname_hash_entry *ent;
> +	size_t len = strlen(refname);
> +
> +	FLEX_ALLOC_MEM(ent, refname, refname, len);
> +	hashmap_entry_init(ent, memhash(refname, len));
> +	oidcpy(&ent->oid, oid);
> +	hashmap_add(map, ent);
> +	return ent;
> +}
> +
> +static int add_one_refname(const char *refname,
> +			   const struct object_id *oid,
> +			   int flag, void *cbdata)
> +{
> +	struct hashmap *refname_map = cbdata;
> +
> +	(void) refname_hash_add(refname_map, refname, oid);
> +	return 0;
> +}
> +
> +static void refname_hash_init(struct hashmap *map)
> +{
> +	hashmap_init(map, refname_hash_entry_cmp, NULL, 0);
> +}
> +
> +static int refname_hash_exists(struct hashmap *map, const char *refname)
> +{
> +	struct hashmap_entry key;
> +	size_t len = strlen(refname);
> +	hashmap_entry_init(&key, memhash(refname, len));
> +
> +	return !!hashmap_get(map, &key, refname);

It would probably make more sense to `hashmap_get_from_hash()` and
`strhash()` here (and `strhash()` should probably be used everywhere
instead of `memhash(str, strlen(str))`).

> +}
> +
>  static void find_non_local_tags(const struct ref *refs,
>  				struct ref **head,
>  				struct ref ***tail)
>  {
> -	struct string_list existing_refs = STRING_LIST_INIT_DUP;
> -	struct string_list remote_refs = STRING_LIST_INIT_NODUP;
> +	struct hashmap existing_refs;
> +	struct hashmap remote_refs;
> +	struct string_list remote_refs_list = STRING_LIST_INIT_NODUP;
> +	struct string_list_item *remote_ref_item;
>  	const struct ref *ref;
> -	struct string_list_item *item = NULL;
> +	struct refname_hash_entry *item = NULL;
>  
> -	for_each_ref(add_existing, &existing_refs);
> +	refname_hash_init(&existing_refs);
> +	refname_hash_init(&remote_refs);
> +
> +	for_each_ref(add_one_refname, &existing_refs);
>  	for (ref = refs; ref; ref = ref->next) {
>  		if (!starts_with(ref->name, "refs/tags/"))
>  			continue;
> @@ -271,10 +319,10 @@ static void find_non_local_tags(const struct ref *refs,
>  			    !has_object_file_with_flags(&ref->old_oid,
>  							OBJECT_INFO_QUICK) &&
>  			    !will_fetch(head, ref->old_oid.hash) &&
> -			    !has_sha1_file_with_flags(item->util,
> +			    !has_sha1_file_with_flags(item->oid.hash,

I am not sure that we need to test for null OIDs here, given that...

>  						      OBJECT_INFO_QUICK) &&
> -			    !will_fetch(head, item->util))
> -				item->util = NULL;
> +			    !will_fetch(head, item->oid.hash))
> +				oidclr(&item->oid);

we no longer can set `util` to `NULL`, but have to use a null OID to
indicate that condition now.

Of course, `has_sha1_file_with_flags()` is supposed to return `false` for
null OIDs, I guess.

>  			item = NULL;
>  			continue;
>  		}
> @@ -286,48 +334,55 @@ static void find_non_local_tags(const struct ref *refs,
>  		 * fetch.
>  		 */
>  		if (item &&
> -		    !has_sha1_file_with_flags(item->util, OBJECT_INFO_QUICK) &&
> -		    !will_fetch(head, item->util))
> -			item->util = NULL;
> +		    !has_sha1_file_with_flags(item->oid.hash, OBJECT_INFO_QUICK) &&
> +		    !will_fetch(head, item->oid.hash))
> +			oidclr(&item->oid);
>  
>  		item = NULL;
>  
>  		/* skip duplicates and refs that we already have */
> -		if (string_list_has_string(&remote_refs, ref->name) ||
> -		    string_list_has_string(&existing_refs, ref->name))
> +		if (refname_hash_exists(&remote_refs, ref->name) ||
> +		    refname_hash_exists(&existing_refs, ref->name))
>  			continue;
>  
> -		item = string_list_insert(&remote_refs, ref->name);
> -		item->util = (void *)&ref->old_oid;
> +		item = refname_hash_add(&remote_refs, ref->name, &ref->old_oid);
> +		string_list_insert(&remote_refs_list, ref->name);
>  	}
> -	string_list_clear(&existing_refs, 1);
> +	hashmap_free(&existing_refs, 1);
>  
>  	/*
>  	 * We may have a final lightweight tag that needs to be
>  	 * checked to see if it needs fetching.
>  	 */
>  	if (item &&
> -	    !has_sha1_file_with_flags(item->util, OBJECT_INFO_QUICK) &&
> -	    !will_fetch(head, item->util))
> -		item->util = NULL;
> +	    !has_sha1_file_with_flags(item->oid.hash, OBJECT_INFO_QUICK) &&
> +	    !will_fetch(head, item->oid.hash))
> +		oidclr(&item->oid);
>  
>  	/*
> -	 * For all the tags in the remote_refs string list,
> +	 * For all the tags in the remote_refs_list,
>  	 * add them to the list of refs to be fetched
>  	 */
> -	for_each_string_list_item(item, &remote_refs) {
> +	for_each_string_list_item(remote_ref_item, &remote_refs_list) {
> +		const char *refname = remote_ref_item->string;
> +		struct hashmap_entry key;
> +
> +		hashmap_entry_init(&key, memhash(refname, strlen(refname)));
> +		item = hashmap_get(&remote_refs, &key, refname);
> +		if (!item)
> +			continue; /* can this happen??? */

This would indicate a BUG, no?

Thank you for working on this,
Dscho

> +
>  		/* Unless we have already decided to ignore this item... */
> -		if (item->util)
> -		{
> -			struct ref *rm = alloc_ref(item->string);
> -			rm->peer_ref = alloc_ref(item->string);
> -			oidcpy(&rm->old_oid, item->util);
> +		if (!is_null_oid(&item->oid)) {
> +			struct ref *rm = alloc_ref(item->refname);
> +			rm->peer_ref = alloc_ref(item->refname);
> +			oidcpy(&rm->old_oid, &item->oid);
>  			**tail = rm;
>  			*tail = &rm->next;
>  		}
>  	}
> -
> -	string_list_clear(&remote_refs, 0);
> +	hashmap_free(&remote_refs, 1);
> +	string_list_clear(&remote_refs_list, 0);
>  }
>  
>  static struct ref *get_ref_map(struct remote *remote,
> @@ -343,7 +398,7 @@ static struct ref *get_ref_map(struct remote *remote,
>  	/* opportunistically-updated references: */
>  	struct ref *orefs = NULL, **oref_tail = &orefs;
>  
> -	struct string_list existing_refs = STRING_LIST_INIT_DUP;
> +	struct hashmap existing_refs;
>  
>  	if (rs->nr) {
>  		struct refspec *fetch_refspec;
> @@ -437,19 +492,24 @@ static struct ref *get_ref_map(struct remote *remote,
>  
>  	ref_map = ref_remove_duplicates(ref_map);
>  
> -	for_each_ref(add_existing, &existing_refs);
> +	refname_hash_init(&existing_refs);
> +	for_each_ref(add_one_refname, &existing_refs);
> +
>  	for (rm = ref_map; rm; rm = rm->next) {
>  		if (rm->peer_ref) {
> -			struct string_list_item *peer_item =
> -				string_list_lookup(&existing_refs,
> -						   rm->peer_ref->name);
> +			struct hashmap_entry key;
> +			const char *refname = rm->peer_ref->name;
> +			struct refname_hash_entry *peer_item;
> +
> +			hashmap_entry_init(&key, memhash(refname, strlen(refname)));
> +			peer_item = hashmap_get(&existing_refs, &key, refname);
>  			if (peer_item) {
> -				struct object_id *old_oid = peer_item->util;
> +				struct object_id *old_oid = &peer_item->oid;
>  				oidcpy(&rm->peer_ref->old_oid, old_oid);
>  			}
>  		}
>  	}
> -	string_list_clear(&existing_refs, 1);
> +	hashmap_free(&existing_refs, 1);
>  
>  	return ref_map;
>  }
> -- 
> 2.19.1-450-ga4b8ab5363
> 
> 
