Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84701C35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 18:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4673D217F4
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 18:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YBFIFoa+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgBESXX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 13:23:23 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60322 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgBESXX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 13:23:23 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C94D6AE79F;
        Wed,  5 Feb 2020 13:23:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rdsrGivcokvo
        OQPS9sdIDN37afg=; b=YBFIFoa+Vq4F6yF1R+GNLB1Ro0+guE2aeGk1KVc0sAR1
        3pbnEykvZWX9Aj5KjtJO1c0RLXKWbw/rxcSbHuAEDt9cEs69v5QnW2LcZwY/paJl
        C9zdEg/FJV2GIm9vWDNF9/cOnOXDDWND/AKqoXQooqMYLbyzwxdHy5JLvUBR74A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=DrMQ3+
        rdBM1rrf/T1sqe5zOLxP6sLowaXzuNMLO/fJw+1KN2OWr3a4goKWlWIGrehT5R2w
        lIY9lsOzPtRTSvupHvpM/ID6rRUBqdm/HmhT5UVVNw8XAGeJPRaV7PVaXk/NQgOv
        0hNeG+XY0Nz4qsUbHJltaYiDKxJtW0tDZL2rY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C073BAE79E;
        Wed,  5 Feb 2020 13:23:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CFF58AE79D;
        Wed,  5 Feb 2020 13:23:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 11/10] name-rev: sort tip names before applying
References: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
        <6f1a2547-ad0d-942e-b4a0-c614da1973fd@web.de>
Date:   Wed, 05 Feb 2020 10:23:07 -0800
In-Reply-To: <6f1a2547-ad0d-942e-b4a0-c614da1973fd@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Wed, 5 Feb 2020 18:50:23 +0100")
Message-ID: <xmqqzhdw6ghg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8FF97984-4844-11EA-A05D-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Subject: Re: [PATCH 11/10] name-rev: sort tip names before applying

"before applying" what?

> name_ref() is called for each ref and checks if its a better name for

s/its/it's/

> the referenced commit.  If that's the case it remembers it and checks i=
f

s/case/&,/

> a name based on it is better for its ancestors as well.  This in done i=
n
> the the order for_each_ref() imposes on us.

s/the the/the/

> That might not be optimal.  If bad names happen to be encountered first
> (as defined by is_better_name()), names derived from them may spread to
> a lot of commits, only to be replaced by better names later.  Setting
> better names first can avoid that.
>
> is_better_name() prefers tags, short distances and old references.  The
> distance is a measure that we need to calculate for each candidate
> commit, but the other two properties are not dependent on the
> relationships of commits.  Sorting the refs by them should yield better
> performance than the essentially random order we currently use.

Good insight.

> And applying older references first should also help to reduce rework
> due to the fact that older commits have less ancestors than newer ones.

"older" in the sense of committer/tagger timestamp.  I wonder it
would further help if the commit-graph is available and give us
generation number.

> So add all details of names to the tip table first, then sort them
> to prefer tags and older references and then apply them in this order.
> Here's the performance as measures by hyperfine for the Linux repo
> before:
>
> Benchmark #1: ./git -C ../linux/ name-rev --all
>   Time (mean =C2=B1 =CF=83):     851.1 ms =C2=B1   4.5 ms    [User: 806=
.7 ms, System: 44.4 ms]
>   Range (min =E2=80=A6 max):   845.9 ms =E2=80=A6 859.5 ms    10 runs
>
> ... and with this patch:
>
> Benchmark #1: ./git -C ../linux/ name-rev --all
>   Time (mean =C2=B1 =CF=83):     736.2 ms =C2=B1   8.7 ms    [User: 688=
.4 ms, System: 47.5 ms]
>   Range (min =E2=80=A6 max):   726.0 ms =E2=80=A6 755.2 ms    10 runs
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  builtin/name-rev.c | 60 +++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 52 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index 23a639ff30..a9dcd25e46 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -247,6 +247,10 @@ static struct tip_table {
>  	struct tip_table_entry {
>  		struct object_id oid;
>  		const char *refname;
> +		struct commit *commit;
> +		timestamp_t taggerdate;
> +		unsigned int from_tag:1;
> +		unsigned int deref:1;
>  	} *table;
>  	int nr;
>  	int alloc;
> @@ -254,13 +258,18 @@ static struct tip_table {
>  } tip_table;
>
>  static void add_to_tip_table(const struct object_id *oid, const char *=
refname,
> -			     int shorten_unambiguous)
> +			     int shorten_unambiguous, struct commit *commit,
> +			     timestamp_t taggerdate, int from_tag, int deref)
>  {
>  	refname =3D name_ref_abbrev(refname, shorten_unambiguous);
>
>  	ALLOC_GROW(tip_table.table, tip_table.nr + 1, tip_table.alloc);
>  	oidcpy(&tip_table.table[tip_table.nr].oid, oid);
>  	tip_table.table[tip_table.nr].refname =3D xstrdup(refname);
> +	tip_table.table[tip_table.nr].commit =3D commit;
> +	tip_table.table[tip_table.nr].taggerdate =3D taggerdate;
> +	tip_table.table[tip_table.nr].from_tag =3D from_tag;
> +	tip_table.table[tip_table.nr].deref =3D deref;
>  	tip_table.nr++;
>  	tip_table.sorted =3D 0;
>  }
> @@ -271,12 +280,30 @@ static int tipcmp(const void *a_, const void *b_)
>  	return oidcmp(&a->oid, &b->oid);
>  }
>
> +static int cmp_by_tag_and_age(const void *a_, const void *b_)
> +{
> +	const struct tip_table_entry *a =3D a_, *b =3D b_;
> +	int cmp;
> +
> +	/* Prefer tags. */
> +	cmp =3D b->from_tag - a->from_tag;

We end up with negative -1 if b is not from tag and a is from tag,
even though the from_tag field is unsigned, so this is not wrong
per-se but feels a bit subtle.

> +	if (cmp)
> +		return cmp;
> +
> +	/* Older is better. */
> +	if (a->taggerdate < b->taggerdate)
> +		return -1;

We are here if both are from tag or neither is from tag.  Mental
note: let's make sure that add_to_tip_table() is always called with
usable timestamp even for a commit that is not from tag.

> +	return a->taggerdate !=3D b->taggerdate;

OK, we know a is either of the same age as or younger than b at this
point, so we would return 1 if a is not the same age as b.

>  static int name_ref(const char *path, const struct object_id *oid, int=
 flags, void *cb_data)
>  {
>  	struct object *o =3D parse_object(the_repository, oid);
>  	struct name_ref_data *data =3D cb_data;
>  	int can_abbreviate_output =3D data->tags_only && data->name_only;
>  	int deref =3D 0;
> +	int from_tag =3D 0;
> +	struct commit *commit =3D NULL;
>  	timestamp_t taggerdate =3D TIME_MAX;
>
>  	if (data->tags_only && !starts_with(path, "refs/tags/"))
> @@ -325,8 +352,6 @@ static int name_ref(const char *path, const struct =
object_id *oid, int flags, vo
>  			return 0;
>  	}
>
> -	add_to_tip_table(oid, path, can_abbreviate_output);
> -
>  	while (o && o->type =3D=3D OBJ_TAG) {
>  		struct tag *t =3D (struct tag *) o;
>  		if (!t->tagged)
> @@ -336,17 +361,35 @@ static int name_ref(const char *path, const struc=
t object_id *oid, int flags, vo
>  		taggerdate =3D t->date;
>  	}
>  	if (o && o->type =3D=3D OBJ_COMMIT) {
> -		struct commit *commit =3D (struct commit *)o;
> -		int from_tag =3D starts_with(path, "refs/tags/");
> -
> +		commit =3D (struct commit *)o;
> +		from_tag =3D starts_with(path, "refs/tags/");
>  		if (taggerdate =3D=3D TIME_MAX)
>  			taggerdate =3D commit->date;

OK, so a lightweight tag gets the commit date, while an annotated
tag gets the tagger date (while peeling in the loop just above this
part).

I never make an annotated tag long after creating the commit the tag
refers to myself (i.e. on the day I tag a release or a release
candidate, I know that the commit I am creating is what I will tag
even before creating the commit, and I tag the commit soon after
that), but I can imagine that in some other workflows the
maintainers may be tagging long after the commit was made, and more
importantly, the interval of time between comitting and tagging
might be different from release to release.  I wonder if it mimicks
the topological ordering better if always compare the timestamps of
underlying commits.

> -		path =3D name_ref_abbrev(path, can_abbreviate_output);
> -		name_rev(commit, path, taggerdate, from_tag, deref);
>  	}
> +
> +	add_to_tip_table(oid, path, can_abbreviate_output, commit, taggerdate=
,
> +			 from_tag, deref);
>  	return 0;
>  }
>
> +static void name_tips(void)
> +{
> +	int i;
> +
> +	/*
> +	 * Try to set better names first, so that worse ones spread
> +	 * less.
> +	 */
> +	QSORT(tip_table.table, tip_table.nr, cmp_by_tag_and_age);
> +	for (i =3D 0; i < tip_table.nr; i++) {
> +		struct tip_table_entry *e =3D &tip_table.table[i];
> +		if (e->commit) {

Sorry, I am confused.  I didn't see anything that clears
tip_table.table[i].commit in the code.

> +			name_rev(e->commit, e->refname, e->taggerdate,
> +				 e->from_tag, e->deref);
> +		}
> +	}
> +}
> +
>  static const unsigned char *nth_tip_table_ent(size_t ix, void *table_)
>  {
>  	struct tip_table_entry *table =3D table_;
> @@ -559,6 +602,7 @@ int cmd_name_rev(int argc, const char **argv, const=
 char *prefix)
>  			cutoff =3D TIME_MIN;
>  	}
>  	for_each_ref(name_ref, &data);
> +	name_tips();
>
>  	if (transform_stdin) {
>  		char buffer[2048];
> --
> 2.25.0
