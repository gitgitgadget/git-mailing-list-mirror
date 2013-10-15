From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] diff.c: keep arrow(=>) on show_stats()'s shortened filename part to make rename visible.
Date: Tue, 15 Oct 2013 15:54:35 -0700
Message-ID: <xmqqbo2qb0wk.fsf@gitster.dls.corp.google.com>
References: <38848735-7CFA-404E-AE51-4F445F813266@gmail.com>
	<A15CCF08-83FD-4F3C-9773-C26DEE38FD33@gmail.com>
	<660A536D-9993-4B81-B6FF-A113F9111570@gmail.com>
	<AFC93704-D6C5-49AF-9A66-C5EA81348FFA@gmail.com>
	<79A13931-694C-4DDC-BEDF-71A0DBA0ECA1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Yoshioka Tsuneo <yoshiokatsuneo@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 00:54:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWDVk-0006d2-5A
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 00:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933831Ab3JOWyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 18:54:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38784 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933560Ab3JOWyi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 18:54:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A2034B2AC;
	Tue, 15 Oct 2013 22:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=MU+5GIaWOZCnx5d6nbP2ZwfYL4I=; b=FjF2z7oyDazepwtWzxVK
	yHnbVNoLY+YJbZlGHSpDy3Uzy9ksTQ1IsV3W5e9isTU6TTr5sF2bbfWOhFciOXM8
	iw54HCxXUEwM0dfxrj/MbkhjVSXfcU7QHUtDQhAFhkqZE4fLQTmJ8KrHg/drxGsk
	wZEM2D6eQK8Q7bVqFfars9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=azZZKfpNPyupGjjiY+NL2si0KhhsMV5NLIakg3mZ1k2S1z
	sB0WMJ0UzYAAHsGnINf8PyHMaJd/0c+l9xUh8a0ck2jDT3ECQZCXDrWmPdAOnrlq
	jD8KySFv3kH0yCw8KlVtEyJUw0u+eyD4X3A5Ryz6WueDxTkSXUZtYbgk5wu9k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E2B04B2AB;
	Tue, 15 Oct 2013 22:54:38 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 612F84B2A6;
	Tue, 15 Oct 2013 22:54:37 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C45A69AC-35EC-11E3-B1F4-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236212>

Yoshioka Tsuneo <yoshiokatsuneo@gmail.com> writes:

> "git diff -M --stat" can detect rename and show renamed file name like
> "foofoofoo => barbarbar". But if destination filename is long, the line
> is shortened like "...barbarbar" so there is no way to know whether the
> file is renamed or existed in the source commit.

Is "destination" filename more special than the source filename?
Perhaps "s/if destination filename is/if filenames are/"?

	Note: I do not want you to reroll using the suggested
	wording without explanation; it may be possible that I am
	missing something obvious and do not understand why you
	singled out destination, in which case I'd rather see it
	explained better in the log message than the potentially
	suboptimal suggestion I made in the review without
	understanding the issue. Of course, it is possible that you
	want to do the same when source is overlong, in which case
	you can just say "Yeah, you're right; will reroll".

        The above applies to all the other comments in this message.

Also "s/source commit/original/".  You may not be comparing two
commits after all.

> Make sure there is always an arrow, like "...foo => ...bar".
> The output can contains curly braces('{','}') for grouping.

s/contains/contain/;

> So, in general, the outpu format is "<pfx>{<mid_a> => <mid_b>}<sfx>"

s/outpu/&t/;

> To keep arrow("=>"), try to omit <pfx> as long as possible at first
> because later part or changing part will be the more important part.
> If it is not enough, shorten <mid_a>, <mid_b>, and <sfx> trying to
> have the maximum length the same because those will be equaly important.

A sound reasoning.

> Signed-off-by: Tsuneo Yoshioka <yoshiokatsuneo@gmail.com>
> Test-added-by: Thomas Rast <trast@inf.ethz.ch>
> ---
>  diff.c                 | 187 +++++++++++++++++++++++++++++++++++++++++++------
>  t/t4001-diff-rename.sh |  12 ++++
>  2 files changed, 177 insertions(+), 22 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index a04a34d..cf50807 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1258,11 +1258,12 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
>  	}
>  }
>  
> -static char *pprint_rename(const char *a, const char *b)
> +static void pprint_rename_find_common_prefix_suffix(const char *a, const char *b
> +													, struct strbuf *pfx, struct strbuf *a_mid
> +													, struct strbuf *b_mid, struct strbuf *sfx)

What kind of line splitting is this?

I think the real issue is that the function name is overly long, but
aside from that,

 - comma comes at the end of the line, not at the beginning of the
   next line;

 - the second and subsequent lines are indented, but not more than
   the usual line width (align with the first letter inside the
   opening parenthesis of the first line);

 - a_mid and b_mid are more "alike" than pfx and a_mid.

so I would expect to see it more like:

static void abbrev_rename(const char *a, const char *b,
			  struct strbuf *pfx,
			  struct strbuf *a_mid, struct strbuf *b_mid,
			  struct strbuf *sfx)

Note that the suggested name does not say "pprint", because in your
version of this file, the code around here is no longer doing any
printing.  The caller does so after using this function to decide
how to abbreviate renames, so naming the helper function after what
it does (e.g. abbreviate renames) is more appropriate.

>  {
>  	const char *old = a;
>  	const char *new = b;
> -	struct strbuf name = STRBUF_INIT;
>  	int pfx_length, sfx_length;
>  	int pfx_adjust_for_slash;
>  	int len_a = strlen(a);
> @@ -1272,10 +1273,9 @@ static char *pprint_rename(const char *a, const char *b)
>  	int qlen_b = quote_c_style(b, NULL, NULL, 0);
>  
>  	if (qlen_a || qlen_b) {
> -		quote_c_style(a, &name, NULL, 0);
> -		strbuf_addstr(&name, " => ");
> -		quote_c_style(b, &name, NULL, 0);
> -		return strbuf_detach(&name, NULL);
> +		quote_c_style(a, a_mid, NULL, 0);
> +		quote_c_style(b, b_mid, NULL, 0);
> +		return;
>  	}
>  
>  	/* Find common prefix */
> @@ -1321,18 +1321,151 @@ static char *pprint_rename(const char *a, const char *b)
>  		a_midlen = 0;
>  	if (b_midlen < 0)
>  		b_midlen = 0;
> +	

Trailing whitespace (there are many others you added to this file; I
won't bother to point out all of them).

> +	strbuf_add(pfx, a, pfx_length);
> +	strbuf_add(a_mid, a + pfx_length, a_midlen);
> +	strbuf_add(b_mid, b + pfx_length, b_midlen);
> +	strbuf_add(sfx, a + len_a - sfx_length, sfx_length);
> +}
> +
> +/*
> + * Omit each parts to fix in name_width.
> + * Formatted string is "<pfx>{<a_mid> => <b_mid>}<sfx>".
> + * At first, omit <pfx> as long as possible.
> + * If it is not enough, omit <a_mid>, <b_mid>, <sfx> by tring to set the length of
> + * those 3 parts(including "...") to the same.
> + * Ex:
> + * "foofoofoo => barbarbar"
> + *   will be like
> + * "...foo => ...bar".
> + * "long_parent{foofoofoo => barbarbar}longfilename"
> + *   will be like
> + * "...parent{...foofoo => ...barbar}...lename"
> + */
> +static void pprint_rename_omit(struct strbuf *pfx, struct strbuf *a_mid, struct strbuf *b_mid
> +							   , struct strbuf *sfx, int name_width)

Bad line splitting.

> +{
> +
> +#define ARROW " => "
> +#define ELLIPSIS "..."

Ugly and leaks these symbols after the function is done using them
to the remainder of this file.  Write them like this instead, perhaps?

	static const char arrow[] = " => ";
        static const char dots[] = "...";

> +#define swap(a, b) myswap((a), (b), sizeof(a))
> +	
> +#define myswap(a, b, size) do {		\
> +unsigned char mytmp[size];	\
> +memcpy(mytmp, &a, size);		\
> +memcpy(&a, &b, size);		\
> +memcpy(&b, mytmp, size);		\
> +} while (0)

These are totally unneeded, I suspect (see below).

> +
> +	int use_curly_braces = (pfx->len > 0) || (sfx->len > 0);
> +	size_t name_len;
> +	size_t len;
> +	size_t part_lengths[4];

Do not name an array in plural, i.e. elements[], unless there is a
compelling reason to do so.  By using singular, e.g. element[], the
third element can be spelled as element[3], which is more logical
than having to call it elements[3].

	Side note. a notable exception is an array that is used as a
	hash-table and frequently passed around as an argument; you
	are usually not interested in iterating over it in ascending
	order, and being able to call such a collection of things
	"things" in plural, e.g. struct object objects[], is more
	important.

> +	size_t max_part_len = 0;
> +	size_t remainder_part_len = 0;
> +	int i, j;
> +
> +	name_len = pfx->len + a_mid->len + b_mid->len + sfx->len + strlen(ARROW)
> +		+ (use_curly_braces ? 2 : 0);
> +	
> +	if (name_len <= name_width) {
> +		/* Everthing fits in name_width */
> +		return;
> +	}
> +	
> +	if (use_curly_braces) {
> +		if (strlen(ELLIPSIS) + (name_len - pfx->len) <= name_width) {
> +			/*
> +			 Just omitting left of '{' is enough
> +			 Ex: ...aaa{foofoofoo => bar}file
> +			 */

	/*
         * We format our multi-line
         * comments like
         * this.
         */

> +			strbuf_splice(pfx, name_len - pfx->len, name_width - (name_len - pfx->len), ELLIPSIS, strlen(ELLIPSIS));

Overlong line.

Is the math for the second and third arguments correct?  If you are
making "abcdefghij" into "...hij", you would splice at position 0
for length up to 'g', so it felt strange to see any arithmetic as
the second argument, but I didn't look at this code very closely.

> +			return;
> +		} else {
> +			if (pfx->len > strlen(ELLIPSIS)) {
> +				/*
> +				 Just omitting left of '{' is not enough
> +				 name will be "...{SOMETHING}SOMETHING"
> +				 */
> +				strbuf_reset(pfx);
> +				strbuf_addstr(pfx, ELLIPSIS);
> +			}
> +		}
> +	}
>  
> -	strbuf_grow(&name, pfx_length + a_midlen + b_midlen + sfx_length + 7);
> -	if (pfx_length + sfx_length) {
> -		strbuf_add(&name, a, pfx_length);
> +	/* available length for a_mid, b_mid and sfx */
> +	len = name_width - strlen(ARROW) - (use_curly_braces ? 2 : 0);
> +	
> +	/* a_mid, b_mid, sfx will be have the same max, including ellipsis("..."). */
> +	part_lengths[0] = (int)a_mid->len;
> +	part_lengths[1] = (int)b_mid->len;
> +	part_lengths[2] = (int)sfx->len;

What are these casts about?  strbuf.len is of size_t which is
already the correct type for part_length[].

> +	
> +	/* bubble sort of part_lengths, descending order */

Do not bubble sort.  Unless there is a compelling reason not to
(liek you are in a performance critical section and want to use a
custom sort algorithm), just let the platform-supplied qsort(3) do
the job by writing a small comparison function.

> +	for (i=0; i<3; i++) {
> +		for (j=i+1; j<3; j++) {
> +			if (part_lengths[j] > part_lengths[i]) {
> +				swap(part_lengths[i], part_lengths[j]);
> +			}
> +		}
> +	}
> +	
> +	if (part_lengths[1] + part_lengths[1] + part_lengths[2] <= len) {
> +		/*
> +		 * "{...foofoo => barbar}file"
> +		 * There is only one omitting part.

s/omitting/omitted/;

> +		 */
> +		max_part_len = len - part_lengths[1] - part_lengths[2];
> +	} else if (part_lengths[2] + part_lengths[2] + part_lengths[2] <= len) {
> +		/*
> +		 * "{...foofoo => ...barbar}file"
> +		 * There are 2 omitting part.

s/omitting part/omitted parts/;

> +		 */
> +		max_part_len = (len - part_lengths[2]) / 2;
> +		remainder_part_len = (len - part_lengths[2]) - max_part_len * 2;
> +	} else {
> +		/*
> +		 * "{...ofoo => ...rbar}...file"
> +		 * There are 3 omitting part.

Likewise.
