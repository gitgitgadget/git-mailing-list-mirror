Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA19DC35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 18:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1FF214AF
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 18:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="nhatf4cx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgBESzc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 13:55:32 -0500
Received: from mout.web.de ([212.227.17.11]:56037 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbgBESzc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 13:55:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1580928926;
        bh=Dx2socbsqhncj69Dcc3sRL1LgWonFd2nOOvNTdP1xrg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=nhatf4cxuBrshJfE64sUzu3AV/G4EHo14nr41XOm8drGu78WTn32rPkDbya1JpNYw
         82sakVnAK8CiUA3kpUcCcJy9FS/6YB/4dSPZt8DuRpTpy0onzu9bbr4gP489f+Yeae
         EY6lvIbm5F9uTG6V74Z9aekuAB6PxIGKhoZjsZrw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LgpVS-1jM98K1Tok-00oJFR; Wed, 05
 Feb 2020 19:55:26 +0100
Subject: Re: [PATCH 11/10] name-rev: sort tip names before applying
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
References: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
 <6f1a2547-ad0d-942e-b4a0-c614da1973fd@web.de>
 <xmqqzhdw6ghg.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <8fd61c60-e3ac-7e8d-bfd1-6ece0e88d1ca@web.de>
Date:   Wed, 5 Feb 2020 19:55:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <xmqqzhdw6ghg.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ISbi1MX5/9UNCq4KSI0LMEprD2Jd1nPHEubvmj0S3g4HggXAHz8
 gS7hMXhZ8khHuBbUYfsMLwDZlWjLGqNEU8CgTc5GnMESifwQweLsfei2kl2fJp6Zh09OLdX
 gycd1wO0qBS+V5BIsRzkHMCdjQ+on4G8VJTCVUEqonwGwQ2QD0xvdcN8QjH6p3yn4/cLo07
 tpjWFeTn2e7x/McBJ/voA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:szD2WiMXDi8=:XWGlzninc0+I3nofhygrzD
 c/Yq/Ni5tSRlMXBeG9K58S80q7p1qDanB3tPy8RDp3EiEot3PDqibijri0cZMTF+vANqnjC/G
 ipD3pHEXib5QXtLLtf54AHtCahIRHX7Ue2g0Zpc5oAGrjUad9dNrjIzakpYGsIpxzSRcIzgBX
 XEOjfX6ZYP4oAcRWYvohPCUDkhwA0QYQ1SOvu4Zuhww8L86Z0v/vnHsgKzM+phoFPTecarxlc
 +JXBUwGO9tgoMH6pnpG0gnWNkGMR0PoBWc/e2SVhtAgdBhf4FKPrmk1ArQo5E6TEUZlnopSBm
 SbURNMNO08mFZBI0QK/4AClk6odcNvajMjqXa9rvPMydLzTvGnnNVs5mgYq6r/xPEv+u4D/Qj
 JCfEhXDRe/R9NxqRmYFUrGafBY21WAKdMPVowG3WEFFrwV6mDG3BL9BT9BhiohXtrWbBwIqWQ
 K2MSDUm4vqnd49v38HHWHX4oztIhgaVPNbmaaows2WxnPjYgHlvIyy0WDkWb5dcXH/EKRdNIx
 oHZwm6eVIVbPMkCtRyhuIxfUwQz4ryyoHP31REye2zsgzwD/RVqWe9+OTTewziv3VdJYBjJdC
 2O5J4OlaxRlr9aA+REDHR2tpSypDAqNiadT/WEsefE29Ae/cG9xIsJVTJB5j+8udm6+VM2Q09
 76R/Yo90yUmRwmOZx6A+HqL1uw1JpcC+GEc1nlRx3A11XpeXHm2vyeF/jaVivvJ8p8h0z3vTH
 m0tLug47KpkcxLWx/DsUxWXLEbpqKi+G0lpyzShAi2iAQANW7S+tH9UrqVxTg2sEqHTJ8uL3y
 VSRk5IbIgHP/GI6IUcHwy+Gqo3jAzEfNrBmlABRzqaQa/9LwEA+BXidTpAvHybgIqE8qSR7Uk
 7qiwHdx31xje70vQTGtUAYp3g3etrnpCW2nZ6lnK4Knvloz2SAXAgaQay5eCX5R857InmQE74
 hM0IQO8qDWRwvemcpWMV+CpltRTGq08moCWDd20ig256mJaiw6u/KU4lTShIGqubuppb0FTi+
 Aj7+CnKtOw5RNFPp7w80RrzUTBXeYw37Q2Rn0sjm/pSashWALrTdcuZGDe7jGAlo8jrwEVgwZ
 VYz1yFowCXtCIwQZX45bUDTgH48xzzuOg8I6fjEMR882nPzBpr48r3VV1PzZbQ5NGhb+h/1+S
 22eBS6QCCjplIHNtvrIpYJHmAdV+gqIcO5Jos1SZN+mK0ExVbgCXO1oXZm5XB7hcf6Wr0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.02.20 um 19:23 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Subject: Re: [PATCH 11/10] name-rev: sort tip names before applying
>
> "before applying" what?

The tip name.  "Using" or "attaching to commits" might be better than
"applying" here.

>> name_ref() is called for each ref and checks if its a better name for
>
> s/its/it's/
>
>> the referenced commit.  If that's the case it remembers it and checks i=
f
>
> s/case/&,/
>
>> a name based on it is better for its ancestors as well.  This in done i=
n
>> the the order for_each_ref() imposes on us.
>
> s/the the/the/

Right.  I was just too excited..

>> And applying older references first should also help to reduce rework
>> due to the fact that older commits have less ancestors than newer ones.
>
> "older" in the sense of committer/tagger timestamp.  I wonder it
> would further help if the commit-graph is available and give us
> generation number.

To sort by generation number instead of by timestamp?  That would at
the very least help in repos whose timestamps are wonky (imported from
timeless version control system, or commits from a computer with a broken
clock).

>> So add all details of names to the tip table first, then sort them
>> to prefer tags and older references and then apply them in this order.
>> Here's the performance as measures by hyperfine for the Linux repo
>> before:
>>
>> Benchmark #1: ./git -C ../linux/ name-rev --all
>>   Time (mean =C2=B1 =CF=83):     851.1 ms =C2=B1   4.5 ms    [User: 806=
.7 ms, System: 44.4 ms]
>>   Range (min =E2=80=A6 max):   845.9 ms =E2=80=A6 859.5 ms    10 runs
>>
>> ... and with this patch:
>>
>> Benchmark #1: ./git -C ../linux/ name-rev --all
>>   Time (mean =C2=B1 =CF=83):     736.2 ms =C2=B1   8.7 ms    [User: 688=
.4 ms, System: 47.5 ms]
>>   Range (min =E2=80=A6 max):   726.0 ms =E2=80=A6 755.2 ms    10 runs
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  builtin/name-rev.c | 60 +++++++++++++++++++++++++++++++++++++++-------
>>  1 file changed, 52 insertions(+), 8 deletions(-)
>>
>> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
>> index 23a639ff30..a9dcd25e46 100644
>> --- a/builtin/name-rev.c
>> +++ b/builtin/name-rev.c
>> @@ -247,6 +247,10 @@ static struct tip_table {
>>  	struct tip_table_entry {
>>  		struct object_id oid;
>>  		const char *refname;
>> +		struct commit *commit;
>> +		timestamp_t taggerdate;
>> +		unsigned int from_tag:1;
>> +		unsigned int deref:1;
>>  	} *table;
>>  	int nr;
>>  	int alloc;
>> @@ -254,13 +258,18 @@ static struct tip_table {
>>  } tip_table;
>>
>>  static void add_to_tip_table(const struct object_id *oid, const char *=
refname,
>> -			     int shorten_unambiguous)
>> +			     int shorten_unambiguous, struct commit *commit,
>> +			     timestamp_t taggerdate, int from_tag, int deref)
>>  {
>>  	refname =3D name_ref_abbrev(refname, shorten_unambiguous);
>>
>>  	ALLOC_GROW(tip_table.table, tip_table.nr + 1, tip_table.alloc);
>>  	oidcpy(&tip_table.table[tip_table.nr].oid, oid);
>>  	tip_table.table[tip_table.nr].refname =3D xstrdup(refname);
>> +	tip_table.table[tip_table.nr].commit =3D commit;
>> +	tip_table.table[tip_table.nr].taggerdate =3D taggerdate;
>> +	tip_table.table[tip_table.nr].from_tag =3D from_tag;
>> +	tip_table.table[tip_table.nr].deref =3D deref;
>>  	tip_table.nr++;
>>  	tip_table.sorted =3D 0;
>>  }
>> @@ -271,12 +280,30 @@ static int tipcmp(const void *a_, const void *b_)
>>  	return oidcmp(&a->oid, &b->oid);
>>  }
>>
>> +static int cmp_by_tag_and_age(const void *a_, const void *b_)
>> +{
>> +	const struct tip_table_entry *a =3D a_, *b =3D b_;
>> +	int cmp;
>> +
>> +	/* Prefer tags. */
>> +	cmp =3D b->from_tag - a->from_tag;
>
> We end up with negative -1 if b is not from tag and a is from tag,
> even though the from_tag field is unsigned, so this is not wrong
> per-se but feels a bit subtle.

Integer promotion -- I admit I looked it up just before sending the
patch to be sure C does the right thing here.  Comparing explicitly
would be more readable.

>
>> +	if (cmp)
>> +		return cmp;
>> +
>> +	/* Older is better. */
>> +	if (a->taggerdate < b->taggerdate)
>> +		return -1;
>
> We are here if both are from tag or neither is from tag.  Mental
> note: let's make sure that add_to_tip_table() is always called with
> usable timestamp even for a commit that is not from tag.
>
>> +	return a->taggerdate !=3D b->taggerdate;
>
> OK, we know a is either of the same age as or younger than b at this
> point, so we would return 1 if a is not the same age as b.
>
>>  static int name_ref(const char *path, const struct object_id *oid, int=
 flags, void *cb_data)
>>  {
>>  	struct object *o =3D parse_object(the_repository, oid);
>>  	struct name_ref_data *data =3D cb_data;
>>  	int can_abbreviate_output =3D data->tags_only && data->name_only;
>>  	int deref =3D 0;
>> +	int from_tag =3D 0;
>> +	struct commit *commit =3D NULL;

Please remember this line.

>>  	timestamp_t taggerdate =3D TIME_MAX;
>>
>>  	if (data->tags_only && !starts_with(path, "refs/tags/"))
>> @@ -325,8 +352,6 @@ static int name_ref(const char *path, const struct =
object_id *oid, int flags, vo
>>  			return 0;
>>  	}
>>
>> -	add_to_tip_table(oid, path, can_abbreviate_output);
>> -
>>  	while (o && o->type =3D=3D OBJ_TAG) {
>>  		struct tag *t =3D (struct tag *) o;
>>  		if (!t->tagged)
>> @@ -336,17 +361,35 @@ static int name_ref(const char *path, const struc=
t object_id *oid, int flags, vo
>>  		taggerdate =3D t->date;
>>  	}
>>  	if (o && o->type =3D=3D OBJ_COMMIT) {
>> -		struct commit *commit =3D (struct commit *)o;
>> -		int from_tag =3D starts_with(path, "refs/tags/");
>> -
>> +		commit =3D (struct commit *)o;
>> +		from_tag =3D starts_with(path, "refs/tags/");
>>  		if (taggerdate =3D=3D TIME_MAX)
>>  			taggerdate =3D commit->date;
>
> OK, so a lightweight tag gets the commit date, while an annotated
> tag gets the tagger date (while peeling in the loop just above this
> part).
>
> I never make an annotated tag long after creating the commit the tag
> refers to myself (i.e. on the day I tag a release or a release
> candidate, I know that the commit I am creating is what I will tag
> even before creating the commit, and I tag the commit soon after
> that), but I can imagine that in some other workflows the
> maintainers may be tagging long after the commit was made, and more
> importantly, the interval of time between comitting and tagging
> might be different from release to release.  I wonder if it mimicks
> the topological ordering better if always compare the timestamps of
> underlying commits.

I also don't understand why lightweight tags are preferred over tag
objects both by having from_tag set and by having an older timestamp.
In my mind an annotated tag should have more weight since it's harder
to create.

>
>> -		path =3D name_ref_abbrev(path, can_abbreviate_output);
>> -		name_rev(commit, path, taggerdate, from_tag, deref);
>>  	}
>> +
>> +	add_to_tip_table(oid, path, can_abbreviate_output, commit, taggerdate=
,
>> +			 from_tag, deref);
>>  	return 0;
>>  }
>>
>> +static void name_tips(void)
>> +{
>> +	int i;
>> +
>> +	/*
>> +	 * Try to set better names first, so that worse ones spread
>> +	 * less.
>> +	 */
>> +	QSORT(tip_table.table, tip_table.nr, cmp_by_tag_and_age);
>> +	for (i =3D 0; i < tip_table.nr; i++) {
>> +		struct tip_table_entry *e =3D &tip_table.table[i];
>> +		if (e->commit) {
>
> Sorry, I am confused.  I didn't see anything that clears
> tip_table.table[i].commit in the code.

The line we remembered initializes commit to NULL.  It stays NULL for
refs that don't resolve to commits.

>
>> +			name_rev(e->commit, e->refname, e->taggerdate,
>> +				 e->from_tag, e->deref);
>> +		}
>> +	}
>> +}
>> +
>>  static const unsigned char *nth_tip_table_ent(size_t ix, void *table_)
>>  {
>>  	struct tip_table_entry *table =3D table_;
>> @@ -559,6 +602,7 @@ int cmd_name_rev(int argc, const char **argv, const=
 char *prefix)
>>  			cutoff =3D TIME_MIN;
>>  	}
>>  	for_each_ref(name_ref, &data);
>> +	name_tips();
>>
>>  	if (transform_stdin) {
>>  		char buffer[2048];
>> --
>> 2.25.0
