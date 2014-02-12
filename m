From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Make the global packed_git variable static to sha1_file.c.
Date: Wed, 12 Feb 2014 13:19:17 -0800
Message-ID: <xmqqioskm3l6.fsf@gitster.dls.corp.google.com>
References: <52fbc2d6.7kJdh2GOdWTzNcPK%szager@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: szager@chromium.org
X-From: git-owner@vger.kernel.org Wed Feb 12 22:19:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDhDN-00011h-5S
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 22:19:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822AbaBLVTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 16:19:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37102 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753067AbaBLVTY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 16:19:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 088D06C96F;
	Wed, 12 Feb 2014 16:19:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mhD85OYHxm7li1vaZF1tZzwPHJI=; b=eWJdUD
	zr53Y9LWYCxPYB2W1kQ2poF4W/sZhGqAfDq3wZgRkUwtDRIwE7TiMqWkRvAlV140
	06dez1x9T3+9d7m4lTMj7gx6PjTY0Jes1K9pZ9v/hyw2CsQ5z0b2I8yyvn4SQYuy
	+RocSw4t1d8qE8koaXsQhTul0H9J8XU8tXPlw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CZ9mJTEUSo35NYkFhoQkfsp40ORRakMo
	vyRqabH2vu26MTUzSdydy9Ov+adfrbiDE4euxhPen49dR55As9QUJRXVz1Uhp2B7
	d1yw8M7vX2OuOr99hCq0+/1w/Xv6bDDnDcSiPbMOtrZFybi315co0RNY8SqAXZlp
	fEUOhY3sTaA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 023716C96D;
	Wed, 12 Feb 2014 16:19:22 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E6CE6C96C;
	Wed, 12 Feb 2014 16:19:20 -0500 (EST)
In-Reply-To: <52fbc2d6.7kJdh2GOdWTzNcPK%szager@chromium.org>
	(szager@chromium.org's message of "Wed, 12 Feb 2014 10:52:06 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5633B238-942B-11E3-9569-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242025>

szager@chromium.org writes:

> From 0a59547f3e95ddecf7606c5f259ae6177c5a104f Mon Sep 17 00:00:00 2001

Please drop this line.

> From: Stefan Zager <szager@chromium.org>

Please drop this line and instead have it in your e-mail header.

> Date: Mon, 10 Feb 2014 16:55:12 -0800

The date in your e-mail header, which is the first time general
public saw this particular version of the patch, is used by default
as the author time.  Unless there is a compelling reason to override
that with an in-body header, please drop this line.

> Subject: [PATCH] Make the global packed_git variable static to sha1_file.c.

Please drop this line and instead have it in your e-mail header.

> This patch is a pure refactor with no functional changes,...
>
> diff --git a/builtin/count-objects.c b/builtin/count-objects.c
> index a7f70cb..6554dfe 100644
> --- a/builtin/count-objects.c
> +++ b/builtin/count-objects.c
> @@ -83,14 +83,32 @@ static char const * const count_objects_usage[] = {
>  	NULL
>  };
>  
> +struct pack_data {
> +	unsigned long packed;
> +	off_t size_pack;
> +	unsigned long num_pack;
> +};
> +
> +int pack_data_fn(struct packed_git *p, void *data)

Can't/shouldn't this be static?

Also I'd suggest s/pack_data_fn/collect_pack_data/ or something.
"_fn" may be a good suffix for typedef'ed typename used in a
callback function, but for a concrete function, it only adds noise
without giving us anything new.

	Yes, I know there are a few existing violators, but we
	shouldn't make the codebase worse, using their existence due
	to past carelessness as an excuse.

> diff --git a/cache.h b/cache.h
> index dc040fb..542a9d9 100644
> --- a/cache.h
> +++ b/cache.h
> ...
> +/* The 'hint' argument is for the commonly-used 'last found pack' optimization.
> + * It can be NULL.
> + */

/*
 * Please try to have opening slash-asterisk and closing
 * asterisk-slash in a multi-line comment block on their
 * own lines by themselves.
 */

> +extern void foreach_packed_git(packed_git_foreach_fn fn, struct packed_git *hint, void *data);
> +
> +extern size_t packed_git_count();
> +extern size_t packed_git_local_count();

extern size_t packed_git_count(void);
extern size_t packed_git_local_count(void);

> diff --git a/sha1_file.c b/sha1_file.c
> index 6e8c05d..aeeb7e6 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -60,6 +60,7 @@ static struct cached_object empty_tree = {
>  	0
>  };
>  
> +static struct packed_git *packed_git;
>  static struct packed_git *last_found_pack;
>  
>  static struct cached_object *find_cached_object(const unsigned char *sha1)
> @@ -468,7 +469,6 @@ static unsigned int pack_open_fds;
>  static unsigned int pack_max_fds;
>  static size_t peak_pack_mapped;
>  static size_t pack_mapped;
> -struct packed_git *packed_git;

Hmm, any particular reason why only this variable and not others are
moved up?

> @@ -1091,6 +1091,37 @@ struct packed_git *add_packed_git(const char *path, int path_len, int local)
>  	return p;
>  }
>  
> +void foreach_packed_git(packed_git_foreach_fn fn, struct packed_git *hint, void *data)
> +{
> +	struct packed_git *p;
> +	if (hint && ((*fn)(hint, data)))
> +		return;
> +	for (p = packed_git; p; p = p->next)
> +		if (p != hint && (*fn)(p, data))
> +			return;

(mental note) In the new API, a non-zero return signals an early
return/break from the loop.

> +}
> +
> +size_t packed_git_count()

size_t packed_git_count(void)

> +{
> +	size_t res = 0;
> +	struct packed_git *p;
> +
> +	for (p = packed_git; p; p = p->next)
> +		++res;

When pre- or post- increment does not make any difference (i.e. you
do not use its value), please stick to post-increment.  pre-increment
looks unusual in our codebase and becomes distracting while reading
it through.

Same comments for packed-git-local-count.

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 541667f..bc3074b 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -900,14 +900,45 @@ static int no_try_delta(const char *path)
>  	return 0;
>  }
>  
> +struct find_pack_data {
> +	const unsigned char *sha1;
> +	off_t offset;
> +	struct packed_git *found_pack;
> +	int exclude;
> +	int found_non_local_pack;
> +	int found_pack_keep;
> +};
> +
> +static int find_pack_fn(struct packed_git *p, void *data)
> +{
> +	struct find_pack_data *fpd = (struct find_pack_data *) data;
> +	off_t offset = find_pack_entry_one(fpd->sha1, p);
> +	if (offset) {
> +		if (!fpd->found_pack) {
> +			if (!is_pack_valid(p)) {
> +				warning("packfile %s cannot be accessed", p->pack_name);
> +				return 0;
> +			}
> +			fpd->offset = offset;
> +			fpd->found_pack = p;
> +		}
> +		if (fpd->exclude)
> +			return 1;
> +		if (!p->pack_local)
> +			fpd->found_non_local_pack = 1;
> +		else if (p->pack_keep)
> +			fpd->found_pack_keep = 1;
> +	}
> +	return 0;
> +}
> +
>  static int add_object_entry(const unsigned char *sha1, enum object_type type,
>  			    const char *name, int exclude)
>  {
>  	struct object_entry *entry;
> -	struct packed_git *p, *found_pack = NULL;
> -	off_t found_offset = 0;
>  	int ix;
>  	uint32_t hash = name_hash(name);
> +	struct find_pack_data fpd;
>  
>  	ix = nr_objects ? locate_object_entry_hash(sha1) : -1;
>  	if (ix >= 0) {
> @@ -923,27 +954,18 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
>  	if (!exclude && local && has_loose_object_nonlocal(sha1))
>  		return 0;
>  
> -	for (p = packed_git; p; p = p->next) {
> -		off_t offset = find_pack_entry_one(sha1, p);
> -		if (offset) {
> -			if (!found_pack) {
> -				if (!is_pack_valid(p)) {
> -					warning("packfile %s cannot be accessed", p->pack_name);
> -					continue;
> -				}
> -				found_offset = offset;
> -				found_pack = p;
> -			}
> -			if (exclude)
> -				break;
> -			if (incremental)
> -				return 0;
> -			if (local && !p->pack_local)
> -				return 0;
> -			if (ignore_packed_keep && p->pack_local && p->pack_keep)
> -				return 0;
> -		}
> -	}
> +	fpd.sha1 = sha1;
> +	fpd.offset = 0;
> +	fpd.found_pack = NULL;
> +	fpd.exclude = exclude;
> +	fpd.found_non_local_pack = fpd.found_pack_keep = 0;

I am debating myself if this should be the usual

	memset(&fpd, 0, sizeof(fpd);

followed by assignments to the fields that matter.

> +	foreach_packed_git(find_pack_fn, NULL, &fpd);
> +	if (fpd.found_pack && !exclude &&
> +	    (incremental ||
> +	     (local && fpd.found_non_local_pack) ||
> +	     (ignore_packed_keep && fpd.found_pack_keep)))
> +		return 0;

When told to do --incremental, we used to return 0 from this
function immediately once we find the object in one pack, without
going thru the list of packs.  Now we let foreach to loop thru all
of them and then return 0.  Does this difference matter?  A similar
difference may exist for local/keep but I did not think it through.

I'd stop here for now.  Thanks for starting this.
