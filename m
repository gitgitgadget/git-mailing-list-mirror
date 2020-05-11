Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA2EC47255
	for <git@archiver.kernel.org>; Mon, 11 May 2020 16:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31D2C206DB
	for <git@archiver.kernel.org>; Mon, 11 May 2020 16:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uSmo5W3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbgEKQZf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 12:25:35 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56885 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729463AbgEKQZf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 May 2020 12:25:35 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 00F5FD1E13;
        Mon, 11 May 2020 12:25:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=suWxNZSXY+ZR
        5IkqFi7d7PT5z/s=; b=uSmo5W3IaOGqHqvKeVwCAs7GIWVm3/TJu9rX4V03fGyZ
        aGiEr+NBsgSz68nmN5BoD7wlJ4dF26MPAamM45RpIKgtsv6Af7n1RxendoJRf7oP
        KA+OtitHnl+FF8N7x59bBlZfbdZ6q9q49by4grfl4hta9rKE/zr2NAs+EQ7GSqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=grEshR
        FSvZjpKfQJoTNLiPAknjkrf7yxI4N/v+XKh4XADI9/4YSFlayWpShVm9GuVABzS6
        1qA4kU+wARa0pVf/lD9pYaynEn8KJUZiNfQOt6Pw3R+2sheTW+FtbV+9x4ziQFz4
        TQiKxK8y1zkKWHGxu1hAdIyfgRGdeI0/nK8OI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ED134D1E12;
        Mon, 11 May 2020 12:25:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 333F2D1E11;
        Mon, 11 May 2020 12:25:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Brandon Williams <bwilliamseng@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: invalid tree and commit object
References: <CALN-EhTpiLERuB16-WPZaLub6GdaRHJW8xDeaOEqSFtKe0kCYw@mail.gmail.com>
        <d963242a-72f3-7f42-7c95-ea5148f74804@web.de>
        <xmqqpnbduiec.fsf@gitster.c.googlers.com>
        <938f0818-7e57-b883-009f-01db88ef8f65@web.de>
        <xmqqh7wovoop.fsf@gitster.c.googlers.com>
        <aab9512b-a70a-0f5b-5cdc-5d40acd343d0@web.de>
        <2937d635-52a9-5e69-b3d2-fbde415b7315@web.de>
Date:   Mon, 11 May 2020 09:25:23 -0700
In-Reply-To: <2937d635-52a9-5e69-b3d2-fbde415b7315@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 10 May 2020 18:12:16 +0200")
Message-ID: <xmqq4ksmsaks.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 04C66ACE-93A4-11EA-8A6E-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>  fsck.c          | 72 +++++++++++++++++++++++++++++++++++++++++++++++--
>  t/t1450-fsck.sh | 16 +++++++++++
>  2 files changed, 86 insertions(+), 2 deletions(-)
>
> diff --git a/fsck.c b/fsck.c
> index 087a7f1ffc..8bb3ecf282 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -523,6 +523,28 @@ int fsck_walk(struct object *obj, void *data, stru=
ct fsck_options *options)
>  	}
>  }
>
> +struct name_stack {
> +	const char **names;
> +	size_t nr, alloc;
> +};
> +
> +static void name_stack_push(struct name_stack *stack, const char *name=
)
> +{
> +	ALLOC_GROW(stack->names, stack->nr + 1, stack->alloc);
> +	stack->names[stack->nr++] =3D name;
> +}
> +
> +static const char *name_stack_pop(struct name_stack *stack)
> +{
> +	return stack->nr ? stack->names[--stack->nr] : NULL;
> +}
> +
> +static void name_stack_clear(struct name_stack *stack)
> +{
> +	FREE_AND_NULL(stack->names);
> +	stack->nr =3D stack->alloc =3D 0;
> +}

OK, names are just pointing into tree objects' buffer, and will be
there until we no longer need the stack and call stack_clear().
Good.

> @@ -534,7 +556,14 @@ int fsck_walk(struct object *obj, void *data, stru=
ct fsck_options *options)
>  #define TREE_UNORDERED (-1)
>  #define TREE_HAS_DUPS  (-2)
>
> -static int verify_ordered(unsigned mode1, const char *name1, unsigned =
mode2, const char *name2)
> +static int is_less_than_slash(unsigned char c)
> +{
> +	return '\0' < c && c < '/';
> +}

Mental note: the terminating byte does not count as
"less than".

> +static int verify_ordered(unsigned mode1, const char *name1,
> +			  unsigned mode2, const char *name2,
> +			  struct name_stack *candidates)

Mental note: the caller is iterating over tree entries, and calls
this helper with two adjacent entries (mode2/name2 is what it just
saw).  The function wants to see if name1 has duplicate in the tree
object, and before this fix, we thought that it is sufficient to
compare it with name2, but now we realized that an entry with the
same name as name1 can come much later than name2.  But it is still
the same in spirit---we want to make sure name1 does not have any
duplicate (name2 will get its turn by the next call to this function
the caller makes).

>  {
>  	int len1 =3D strlen(name1);
>  	int len2 =3D strlen(name2);
> @@ -566,6 +595,41 @@ static int verify_ordered(unsigned mode1, const ch=
ar *name1, unsigned mode2, con
>  		c1 =3D '/';
>  	if (!c2 && S_ISDIR(mode2))
>  		c2 =3D '/';

Mental note: at this point, we have rejected two adjacent and
identical names, and c1 and c2 are the first byte that are different
between these two names; but if it is NUL at the end of the name,
and the object is a tree, c1/c2 is changed to a slash.

> +
> +	/*
> +	 * There can be non-consecutive duplicates due to the implicitly
> +	 * add slash, e.g.:

s/add slash/added slash/, or even "added slash at the end of the
name of a tree object".

> +	 *
> +	 *   foo
> +	 *   foo.bar
> +	 *   foo.bar.baz
> +	 *   foo.bar/
> +	 *   foo/
> +	 *
> +	 * Record non-directory candidates (like "foo" and "foo.bar" in
> +	 * the example) on a stack and check directory candidates (like
> +	 * foo/" and "foo.bar/") against that stack.
> +	 */
> +	if (!c1 && is_less_than_slash(c2)) {
> +		name_stack_push(candidates, name1);

If name1 is a blob and the name2 sorts before a hypothetical entry
that is a tree object with the same name as name1, we need to
remember that we saw name1.  We need to keep that record until we
see an entry that sorts after such a hypothetical tree.

We earlier made a mental note that c2=3D=3DNUL does not count as being
less than slash, but it does not matter, as we rejected !c1 && !c2
much earlier.

When we remember name1 this way, we cannot yet tell if it is
duplicate, so we don't do anything unusual.

> +	} else if (c2 =3D=3D '/' && is_less_than_slash(c1)) {

Now we are seeing a tree.  Does it crash with the last "suspicious"
name we saw?

> +		for (;;) {
> +			const char *p;
> +			const char *f_name =3D name_stack_pop(candidates);

We pop one name.  We know that=20

 - it is a name of a blob object
 - all we have seen since then are blobs and commits and no tree

> +			if (!f_name)
> +				break;

If there is no remembered name, we are done.

> +			if (!skip_prefix(name2, f_name, &p))
> +				break;

If the remembered name (e.g. "foo") is not a prefix of the current
name (e.g. "fop"), we cannot have "foo/" after "fop" we are seeing
without violating ordering constraints that we will notice while
inspecting the later entries of this tree.  So "foo" can be
discarded at this point.

> +			if (!*p)
> +				return TREE_HAS_DUPS;

If name2 and f_name are the same, we have found a duplicate.

> +			if (is_less_than_slash(*p)) {

If name2 (the one we are currently looking at) has f_name as its
prefix, and the first byte that differs is less than slash (again,
our earlier observation that NUL is not counted as less than slash
does not matter here, as we just handled NUL case before this
check), then it still is possible that a tree entry with the same
name as f_name is hiding behind name2, so we push it back to the
stack (i.e.  we cannot tell f_name is a duplicat).  Entries in the
stack below f_name sorts earlier than f_name, are they are prefixes
of f_name in the ascending order of their length (due to the "if not
prefix we can pop" logic we saw earlier), and a tree with the same
name as stack[n] should sort earlier than a tree with the same name
as stack[n-1], so after seeing that we are not ready to determine
if f_name has duplicate, we know we are not ready for the names
deeper in the stack.

	Side note. this is nice but is subtle.  I'd need to retrace
	the thoughts on this part again later to convince myself
	that we are not missing anything.

> +				name_stack_push(candidates, f_name);
> +				break;
> +			}

Otherwise, we know name2 sorts later than the hypothetical entry
that is a tree with the same name as f_name, so f_name can be
discarded (i.e. we do not push it again).  Further, we may notice
that name2 makes it impossile for other names in the stack to have
entries with the same name, so we iterate.

> +		}
> +	}
> +
>  	return c1 < c2 ? 0 : TREE_UNORDERED;
>  }
>
> @@ -587,6 +651,7 @@ static int fsck_tree(const struct object_id *oid,
>  	struct tree_desc desc;
>  	unsigned o_mode;
>  	const char *o_name;
> +	struct name_stack df_dup_candidates =3D { NULL };
>
>  	if (init_tree_desc_gently(&desc, buffer, size)) {
>  		retval +=3D report(options, oid, OBJ_TREE, FSCK_MSG_BAD_TREE, "canno=
t be parsed as a tree");
> @@ -666,7 +731,8 @@ static int fsck_tree(const struct object_id *oid,
>  		}
>
>  		if (o_name) {
> -			switch (verify_ordered(o_mode, o_name, mode, name)) {
> +			switch (verify_ordered(o_mode, o_name, mode, name,
> +					       &df_dup_candidates)) {
>  			case TREE_UNORDERED:
>  				not_properly_sorted =3D 1;
>  				break;
> @@ -682,6 +748,8 @@ static int fsck_tree(const struct object_id *oid,
>  		o_name =3D name;
>  	}
>
> +	name_stack_clear(&df_dup_candidates);
> +

OK.  Nicely done.

Thanks.

>  	if (has_null_sha1)
>  		retval +=3D report(options, oid, OBJ_TREE, FSCK_MSG_NULL_SHA1, "cont=
ains entries pointing to null sha1");
>  	if (has_full_path)
> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> index 449ebc5657..91a6e34f38 100755
> --- a/t/t1450-fsck.sh
> +++ b/t/t1450-fsck.sh
> @@ -257,6 +257,22 @@ test_expect_success 'tree object with duplicate en=
tries' '
>  	test_i18ngrep "error in tree .*contains duplicate file entries" out
>  '
>
> +test_expect_success 'tree object with dublicate names' '
> +	test_when_finished "remove_object \$blob" &&
> +	test_when_finished "remove_object \$tree" &&
> +	test_when_finished "remove_object \$badtree" &&
> +	blob=3D$(echo blob | git hash-object -w --stdin) &&
> +	printf "100644 blob %s\t%s\n" $blob x.2 >tree &&
> +	tree=3D$(git mktree <tree) &&
> +	printf "100644 blob %s\t%s\n" $blob x.1 >badtree &&
> +	printf "100644 blob %s\t%s\n" $blob x >>badtree &&
> +	printf "040000 tree %s\t%s\n" $tree x >>badtree &&
> +	badtree=3D$(git mktree <badtree) &&
> +	test_must_fail git fsck 2>out &&
> +	test_i18ngrep "$badtree" out &&
> +	test_i18ngrep "error in tree .*contains duplicate file entries" out
> +'
> +
>  test_expect_success 'unparseable tree object' '
>  	test_oid_cache <<-\EOF &&
>  	junk sha1:twenty-bytes-of-junk
> --
> 2.26.2
