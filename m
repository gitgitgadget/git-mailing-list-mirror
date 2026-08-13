Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD9B2F39C2
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 09:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786612820; cv=none; b=oKnQMXEPIra7fkoicTFcaKlSNIqweszZ3uJu1IgvNr+cVMH5S4A1D1ovi9wu8O50/FdzSxDKTtXTly1KRqtI/kSij7KRL2MRWXi0024y2IH4PdqS1tXE8QciaVn0R2yx4W12p3IslhXewlenzIHVwjc3iaKxGFhWg6jAtF3C/ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786612820; c=relaxed/simple;
	bh=PR2hGfNMJkn5OXZn1P9ChIi1oyyG8gsPn+INYaqo5GA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ig+jnUwHQwk25OAw8cB/knEVphttNiBUYQn/RpSHQQ7BLKBXtXWtJNEqyVfCkhYp9zTNQ/EUigkqzPOhLloZ7swAYDE2AxTgSKtr2OgZVoD4jIb2EheaRep8Yzy7gwAMDJnKbXNBua+wKKlnJsvd019au689+8E2z4DjZB3ZxLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=orKRGS2C; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="orKRGS2C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786612815; x=1787217615;
	i=johannes.schindelin@gmx.de;
	bh=lhTvI3dKHAguTOKowy0LC1tshmPD5LoSENe2tRF3TJE=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=orKRGS2CmwWzYAJNceNc1G7KSUxTXe3YsEqDPoxkSTJuWB/8CciTLkUANSJ+L/OS
	 pJXLrGXr3S9NldrmmetN6yyDGnt6bnC5OA1GhcRZnPFIWjZy4R3qOGPuLRrbuWGKw
	 7kqrTTfC5tIQVpCQ/RfTYzAhTWWGZ3t1ZP/d/PS9ufnYOPBR7EGxOZDzEak/eaq6e
	 TVJKdJpSGc5aRE4pTPA3N6dSrCFm2FZseSjQXUMzJkDo2cKBiL4e4TqPTja8SV2Sy
	 lMfydwUnmCdr5iZWo9eego83EK+7BZ9SeyE+B62T+23zgeInCiNeQnBggcm3lquJV
	 YZhcqDsEawQ+SIXWLA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mj8qj-1xNkDb3cbV-00lQ1h; Thu, 13
 Aug 2026 11:20:15 +0200
Date: Thu, 13 Aug 2026 11:20:11 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH] packfile: fix perf regression with many packs
In-Reply-To: <an1zz02GNqDu-0Oz@pks.im>
Message-ID: <b4860540-6114-2a7b-e266-d1fc2f0041b9@gmx.de>
References: <pull.2202.git.1786561870638.gitgitgadget@gmail.com> <an1zz02GNqDu-0Oz@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=8323329109017051117866128151863
X-Provags-ID: V03:K1:9ZQkiek0EoJVwggCUAw9L/sUNbSTIndJGp4zzjUpte25c9jlYce
 sR4yg8glgxY2Qdj+d6e1uSbvyC+WlBbXxMJw0tal82z+TPmis1ZzCJ6nlt0zpac2L+UxXJ4
 otYWJAkka4Vr4QUAJPF1MFTT7eRLWRp1aFe2UfVEDgAoXWXEVwbqxtiN24wvlHNKXBYc995
 LfD5D3glH/qc6jKf+Ju6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:M4sFSzGO8sE=;BYVWFBj+zz89E06X8wchQ00tbLb
 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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329109017051117866128151863
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Thu, 13 Aug 2026, Patrick Steinhardt wrote:

> On Wed, Aug 12, 2026 at 07:11:09PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >=20
> > Since 589127caa730 (packfile: move list of packs into the packfile
> > store, 2025-10-30), there is a performance regression when many
> > packfiles need to be loaded: `packfile_store_add_pack()` now calls
> > `packfile_list_remove_internal()` to detect whether the packfile was
> > _already_ in the list, if if so, move it to the end of the list. This
>=20
> Nit: s/if if/and if/

Thanks, will fix, along with dropping the claim that the CI clone was
fixed by this patch.

>=20
> > function linearly scans the existing list before every insertion. Newl=
y
> > loading N packs therefore has complexity O(N=C2=B2).
> >=20
> > In one reported use case (https://github.com/microsoft/git/issues/970)=
,
> > N equals 37,815 and caused a slow-down of a simple `git rev-parse
> > --short HEAD` (which is regularly executed as part of `GIT_PS1`) from
> > 0.4s to 4.5s. In another, heavily exercised CI scenario, clone times
> > increased from under 2 minutes to over half an hour.
>=20
> Wow, 38k packfiles is a lot.

Yes.

> > Let's fix this by establishing a fast path for known-new packfiles.
> >=20
> > The keen reader will note that there is currently only a single,
> > "known-new" caller of the `packfile_list_append()` function, and wonde=
r
> > why not simply remove this check whether the packfile already exists i=
n
> > the list? Originally, when above-mentioned commit introduced that logi=
c,
> > there was a second caller in `prepare_midx()`, which would have requir=
ed
> > that check, but that caller was removed in 6aff1f25a046 (packfile:
> > always add packfiles to MRU when adding a pack, 2025-10-30). Still, th=
e
> > function is declared in a header file, and to avoid any problems with
> > in-flight or downstream callers, it is safer to extend the signature t=
o
> > be explicit whether or not to skip that check.
>=20
> Quite conservative, but fair enough.
>=20
> > diff --git a/packfile-list.c b/packfile-list.c
> > index 01fb913abf..1379ab3a4f 100644
> > --- a/packfile-list.c
> > +++ b/packfile-list.c
> > @@ -57,11 +57,12 @@ void packfile_list_prepend(struct packfile_list *l=
ist, struct packed_git *pack)
> >  		list->tail =3D entry;
> >  }
> > =20
> > -void packfile_list_append(struct packfile_list *list, struct packed_g=
it *pack)
> > +void packfile_list_append(struct packfile_list *list, struct packed_g=
it *pack,
> > +			  int is_new)
> >  {
> >  	struct packfile_list_entry *entry;
> > =20
> > -	entry =3D packfile_list_remove_internal(list, pack);
> > +	entry =3D is_new ? NULL : packfile_list_remove_internal(list, pack);
> >  	if (!entry) {
> >  		entry =3D xmalloc(sizeof(*entry));
> >  		entry->pack =3D pack;
>=20
> I wonder whether we should slightly reformulate this and rename `is_new`
> to `accept_duplicates`. Because ultimately, that is what we're doing
> now: instead of ensuring that the packfile is unique in the list, we
> just don't care and just append the entry to the list.

Hmm. I don't quite agree, we're _not_ accepting duplicates. We know that
those packfiles _cannot_ be duplicates.

> An alternative would be to use a hashmap here that tracks the packs that
> have already been added. It has the advantage that it also covers the
> `prepend()` operation and that callers don't have to be aware of this
> mechanism at all. Furthermore, moving preexisting entries to the back or
> front could become O(logn) if the list was doubly-linked. We do this
> operation quite often to re-sort entries in the list when looking up
> objects.

Indeed, that was my initial reaction, too. I was well on my way to start
writing a hashmap-based fix when the AI assistant pointed out that no
duplicates could possibly exist yet.

> Overall though I'm not quite sure whether the added complexity would be
> worth it, see below patch.

Wow, you got a lot further than I did! And yes, I agree that we do not
(yet?) need to deal with the added complexity.

Ciao,
Johannes

>=20
> Thanks!
>=20
> Patrick
>=20
> diff --git a/http-push.c b/http-push.c
> index 94a1fac9ab..52b00e7c95 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -1729,6 +1729,7 @@ int cmd_main(int argc, const char **argv)
>  	const char *gitdir;
> =20
>  	CALLOC_ARRAY(repo, 1);
> +	packfile_list_init(&repo->packs);
> =20
>  	argv++;
>  	for (i =3D 1; i < argc; i++, argv++) {
> @@ -1992,6 +1993,7 @@ int cmd_main(int argc, const char **argv)
>   cleanup:
>  	if (info_ref_lock)
>  		unlock_remote(info_ref_lock);
> +	packfile_list_clear(&repo->packs);
>  	free(repo->url);
>  	free(repo);
> =20
> diff --git a/http-walker.c b/http-walker.c
> index b58a3b2a92..541437e52d 100644
> --- a/http-walker.c
> +++ b/http-walker.c
> @@ -325,6 +325,7 @@ static void process_alternates_response(void *callba=
ck_data)
>  					warning("adding alternate object store: %s",
>  						target.buf);
>  					CALLOC_ARRAY(newalt, 1);
> +					packfile_list_init(&newalt->packs);
>  					newalt->base =3D strbuf_detach(&target, NULL);
> =20
>  					while (tail->next !=3D NULL)
> @@ -609,6 +610,7 @@ struct walker *get_http_walker(const char *url)
>  	struct walker *walker =3D xmalloc(sizeof(struct walker));
> =20
>  	CALLOC_ARRAY(data->alt, 1);
> +	packfile_list_init(&data->alt->packs);
>  	data->alt->base =3D xstrdup(url);
>  	for (s =3D data->alt->base + strlen(data->alt->base) - 1; *s =3D=3D '/=
'; --s)
>  		*s =3D 0;
> diff --git a/odb/source-packed.c b/odb/source-packed.c
> index 0890704e76..082c2494cb 100644
> --- a/odb/source-packed.c
> +++ b/odb/source-packed.c
> @@ -835,6 +835,7 @@ struct odb_source_packed *odb_source_packed_new(stru=
ct object_database *odb,
> =20
>  	CALLOC_ARRAY(packed, 1);
>  	odb_source_init(&packed->base, odb, ODB_SOURCE_PACKED, path, local);
> +	packfile_list_init(&packed->packs);
>  	strmap_init(&packed->packs_by_path);
> =20
>  	packed->base.free =3D odb_source_packed_free;
> diff --git a/packfile-list.c b/packfile-list.c
> index 01fb913abf..d3c4843d8d 100644
> --- a/packfile-list.c
> +++ b/packfile-list.c
> @@ -2,6 +2,28 @@
>  #include "packfile.h"
>  #include "packfile-list.h"
> =20
> +static unsigned int packfile_list_entry_hash(struct packfile_list_entry=
 *e)
> +{
> +	return memhash(&e->pack, sizeof(e->pack));
> +}
> +
> +static int packfile_list_entry_cmp(const void *data UNUSED,
> +				   const struct hashmap_entry *h1,
> +				   const struct hashmap_entry *h2,
> +				   const void *keydata UNUSED)
> +{
> +	const struct packfile_list_entry *e1, *e2;
> +	e1 =3D container_of(h1, const struct packfile_list_entry, ent);
> +	e2 =3D container_of(h2, const struct packfile_list_entry, ent);
> +	return e1->pack !=3D e2->pack;
> +}
> +
> +void packfile_list_init(struct packfile_list *list)
> +{
> +	memset(list, 0, sizeof(*list));
> +	hashmap_init(&list->seen, packfile_list_entry_cmp, NULL, 0);
> +}
> +
>  void packfile_list_clear(struct packfile_list *list)
>  {
>  	struct packfile_list_entry *e, *next;
> @@ -12,6 +34,20 @@ void packfile_list_clear(struct packfile_list *list)
>  	}
> =20
>  	list->head =3D list->tail =3D NULL;
> +
> +	hashmap_clear(&list->seen);
> +}
> +
> +static struct packfile_list_entry *packfile_list_lookup(struct packfile=
_list *list,
> +							struct packed_git *pack)
> +{
> +	struct packfile_list_entry key =3D { .pack =3D pack };
> +	struct hashmap_entry *ent;
> +
> +	hashmap_entry_init(&key.ent, packfile_list_entry_hash(&key));
> +	ent =3D hashmap_get(&list->seen, &key.ent, NULL);
> +
> +	return ent ? container_of(ent, struct packfile_list_entry, ent) : NULL=
;
>  }
> =20
>  static struct packfile_list_entry *packfile_list_remove_internal(struct=
 packfile_list *list,
> @@ -38,20 +74,33 @@ static struct packfile_list_entry *packfile_list_rem=
ove_internal(struct packfile
> =20
>  void packfile_list_remove(struct packfile_list *list, struct packed_git=
 *pack)
>  {
> -	free(packfile_list_remove_internal(list, pack));
> +	struct packfile_list_entry key =3D { .pack =3D pack };
> +
> +	hashmap_entry_init(&key.ent, packfile_list_entry_hash(&key));
> +	if (hashmap_remove(&list->seen, &key.ent, NULL)) {
> +		struct packfile_list_entry *e =3D packfile_list_remove_internal(list,=
 pack);
> +		if (!e)
> +			BUG("corrupt packfile list");
> +		free(e);
> +	}
>  }
> =20
>  void packfile_list_prepend(struct packfile_list *list, struct packed_gi=
t *pack)
>  {
>  	struct packfile_list_entry *entry;
> =20
> -	entry =3D packfile_list_remove_internal(list, pack);
> -	if (!entry) {
> +	if (packfile_list_lookup(list, pack)) {
> +		entry =3D packfile_list_remove_internal(list, pack);
> +		if (!entry)
> +			BUG("corrupt packfile list");
> +	} else {
>  		entry =3D xmalloc(sizeof(*entry));
>  		entry->pack =3D pack;
> +		hashmap_entry_init(&entry->ent, packfile_list_entry_hash(entry));
> +		hashmap_add(&list->seen, &entry->ent);
>  	}
> -	entry->next =3D list->head;
> =20
> +	entry->next =3D list->head;
>  	list->head =3D entry;
>  	if (!list->tail)
>  		list->tail =3D entry;
> @@ -61,13 +110,18 @@ void packfile_list_append(struct packfile_list *lis=
t, struct packed_git *pack)
>  {
>  	struct packfile_list_entry *entry;
> =20
> -	entry =3D packfile_list_remove_internal(list, pack);
> -	if (!entry) {
> +	if (packfile_list_lookup(list, pack)) {
> +		entry =3D packfile_list_remove_internal(list, pack);
> +		if (!entry)
> +			BUG("corrupt packfile list");
> +	} else {
>  		entry =3D xmalloc(sizeof(*entry));
>  		entry->pack =3D pack;
> +		hashmap_entry_init(&entry->ent, packfile_list_entry_hash(entry));
> +		hashmap_add(&list->seen, &entry->ent);
>  	}
> -	entry->next =3D NULL;
> =20
> +	entry->next =3D NULL;
>  	if (list->tail) {
>  		list->tail->next =3D entry;
>  		list->tail =3D entry;
> diff --git a/packfile-list.h b/packfile-list.h
> index 1b05e2aa36..bfb7017852 100644
> --- a/packfile-list.h
> +++ b/packfile-list.h
> @@ -1,17 +1,22 @@
>  #ifndef PACKFILE_LIST_H
>  #define PACKFILE_LIST_H
> =20
> +#include "hashmap.h"
> +
>  struct object_id;
> =20
>  struct packfile_list {
>  	struct packfile_list_entry *head, *tail;
> +	struct hashmap seen;
>  };
> =20
>  struct packfile_list_entry {
> +	struct hashmap_entry ent;
>  	struct packfile_list_entry *next;
>  	struct packed_git *pack;
>  };
> =20
> +void packfile_list_init(struct packfile_list *list);
>  void packfile_list_clear(struct packfile_list *list);
>  void packfile_list_remove(struct packfile_list *list, struct packed_git=
 *pack);
>  void packfile_list_prepend(struct packfile_list *list, struct packed_gi=
t *pack);
>=20

--8323329109017051117866128151863--
