From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] diff --stat: use the full terminal width
Date: Mon, 13 Feb 2012 17:08:44 -0800
Message-ID: <7vsjie9q77.fsf@alter.siamese.dyndns.org>
References: <7vmx8qr1gb.fsf@alter.siamese.dyndns.org>
 <1329057019-29983-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pclouds@gmail.com,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Tue Feb 14 02:08:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx6t3-0003Fq-Sd
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 02:08:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756100Ab2BNBIt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Feb 2012 20:08:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32910 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751369Ab2BNBIs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2012 20:08:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 663ED6F57;
	Mon, 13 Feb 2012 20:08:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=qNhXwPNWxMK4jx5Dp7E9YGTC3
	Z4=; b=Kg9h+eQYSo2sjCCN1COhnKi6afR0AhIIL5RS6wm19X0BBslkoX+B2HiE/
	4bxPGPuzwGFcxyz0Wv6rQD19niaJAgxQsWAVulz7Vruu+ARIxioBQD08PlsUMiLs
	5z7IQsgfkbwej3O2RfFM5Cv7Sp6whIutGILcmAXk6HKf6zocPM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=Q87lbGZcDxBm2jIq2xQ
	DPBgetZ+fjoKwgrSdrU1YFHbmNc+/qDXIk9TzJwMn5Rshht/ZL0capebFZWheFn9
	crPn0811kDISqShhgbIBY9/NhssNXw5j4Bx+gzyAo+3f96e7qQ9lVoOx7IZj+SII
	jtlIY/LsteuNpkrzXnHqTn+4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CD0F6F56;
	Mon, 13 Feb 2012 20:08:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 617DF6F54; Mon, 13 Feb 2012
 20:08:46 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 71F3ABD0-56A8-11E1-A054-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190694>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> Use as many columns as necessary for filenames, as few columns as
> necessary for change counts, and up to 40 columns for the histogram.
>
> Some projects (especially in Java), have long filename paths, with
> nested directories or long individual filenames. When files are
> renamed, the stat output can be almost useless. If the middle part

s/the stat output/the name part in &/;

> between { and } is long (because the file was moved to a completely
> different directory), then most of the path would be truncated.
>
> It makes sense to detect and use the full terminal width and display
> full filenames if possible.
>
> If commits changing a lot of lines are displayed in a wide terminal
> window (200 or more columns), and the +- graph would use the full
> width, the output would look bad. Messages wrapped to about 80
> columns would be interspersed with very long +- lines. It makes
> sense to limit the width of the histogram to a fixed value, even if m=
ore

I do not think the graph ++++++--- part is "histogram", which is a name
for a specific type of graph that depicts a distribution of data.

We show the number of lines changed in a graph.  Unless people come up
with a better name, I would suggest calling it just "the graph part", o=
r
simply "the graph", throughout the patch.

> columns are available. This fixed value is subjectively hard-coded to
> be 40 columns, which seems to work well for git.git and linux-2.6.git=
 and
> some other repositories.
>
> If there isn't enough columns to print both the filename and the hist=
ogram,
> at least 5/8 of available space is devoted to filenames. On a standar=
d 80 column
> terminal, or if not connected to a terminal and using the default of =
80 columns,
> this gives the same partition as before.
>
> Number of columns required for change counts is computed based on
> the maximum number of changed lines. This means that usually a few mo=
re
> columns will be available for the filenames and the histogram.
>
> Tests are added for various combinations of long filename and big cha=
nge
> count and ways to specify widths.
>
> Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
> ---
> ...
> diff --git a/diff.c b/diff.c
> index 7e15426..7abcbe9 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1327,7 +1327,7 @@ static void show_stats(struct diffstat_t *data,=
 struct diff_options *options)
>  	int i, len, add, del, adds =3D 0, dels =3D 0;
>  	uintmax_t max_change =3D 0, max_len =3D 0;
>  	int total_files =3D data->nr;
> -	int width, name_width, count;
> +	int width, name_width, graph_width, number_width, count;
>  	const char *reset, *add_c, *del_c;
>  	const char *line_prefix =3D "";
>  	int extra_shown =3D 0;
> @@ -1341,25 +1341,13 @@ static void show_stats(struct diffstat_t *dat=
a, struct diff_options *options)
>  		line_prefix =3D msg->buf;
>  	}
> =20
> -	width =3D options->stat_width ? options->stat_width : 80;
> -	name_width =3D options->stat_name_width ? options->stat_name_width =
: 50;
> -	count =3D options->stat_count ? options->stat_count : data->nr;

It was somewhat distracting that you moved this "count =3D" below, whic=
h I
do not think was necessary.

> -	/* Sanity: give at least 5 columns to the graph,
> -	 * but leave at least 10 columns for the name.
> -	 */
> -	if (width < 25)
> -		width =3D 25;
> -	if (name_width < 10)
> -		name_width =3D 10;
> -	else if (width < name_width + 15)
> -		name_width =3D width - 15;

Removal of this sanity check is fine as long as sanity is kept by the n=
ew
code in the later part. This was primarily so that people won't specify
impossible values (e.g. what happens when name_width that is wider than
the total width is given).

> ...
> +	count =3D options->stat_count ? options->stat_count : data->nr;
> +
> @@ -1380,19 +1368,63 @@ static void show_stats(struct diffstat_t *dat=
a, struct diff_options *options)
>  	}
>  	count =3D i; /* min(count, data->nr) */
> =20
> -	/* Compute the width of the graph part;
> -	 * 10 is for one blank at the beginning of the line plus
> -	 * " | count " between the name and the graph.


> +	/* We have width =3D stat_width or term_columns() columns total.

Just a style, but in the more recent part of the codebase,

	/*
         * We have width =3D ....

is preferred.

> +	 * We want a maximum of min(max_len, stat_name_width) for the name =
part.
> +	 * We want a maximum of min(max_change, 40) for the +- part.
> +	 * We also need 1 for " " and 4 + decimal_width(max_change)
> +	 * for " | NNNN " and one for " " at the end, altogether
> +	 * 6 + decimal_width(max_change).

The math looks correct but 'one for " " at the end' sounds as if you ar=
e
printing a SP, but I think we simply avoid printing anything, so perhap=
s
rewrite it to "we leave one column at the end" or something.

> +	 * If there's not enough space, we will use stat_name_width
> +	 * or 5/8*width for filename, and the rest for constant

"A or B for filename"---unclear how it picks between A or B.

"A or B, whichever is shorter, for filename", perhaps?

> +	 * elements + histogram, but no more than 40 for the histogram.
> +	 * (5/8 gives 50 for filename and 30 for constant parts and
> +	 * histogram for the standard terminal size).
>  	 *
> -	 * From here on, name_width is the width of the name area,
> -	 * and width is the width of the graph area.
> +	 * In other words: stat_width limits the maximum width, and
> +	 * stat_name_width fixes the maximum width of the filename,
> +	 * and is also used to divide available columns if there
> +	 * aren't enough.
>  	 */
> -	name_width =3D (name_width < max_len) ? name_width : max_len;
> -	if (width < (name_width + 10) + max_change)
> -		width =3D width - (name_width + 10);
> -	else
> -		width =3D max_change;
> +	width =3D options->stat_width ? options->stat_width : term_columns(=
);
> +	number_width =3D decimal_width(max_change);
> +	/* first sizes that are wanted */

Missing verb; "first, compute sizes that are ..."?

> +	graph_width =3D max_change < 40 ? max_change : 40;
> +	name_width =3D (options->stat_name_width > 0 &&
> +		      options->stat_name_width < max_len) ?
> +		options->stat_name_width : max_len;

mental note: name_width can be limited to max_len, and graph_width may =
be
quite small when max_change is small.  The total graph may be much smal=
ler
than the terminal width in such a case (and it is not a wasted space on
the right hand side of the terminal).

> +	/* sanity: guarantee a minimum and maximum width */
> +	if (width < 25)
> +		width =3D 25;
> +
> +	if (name_width + number_width + 6 + graph_width > width) {
> +		if (graph_width > width * 3/8 - number_width - 6)
> +			graph_width =3D width * 3/8 - number_width - 6;
> +		if (graph_width > 40)
> +			graph_width =3D  40;
> +		if (name_width > width - number_width - 6 - graph_width)
> +			name_width =3D width - number_width - 6 - graph_width;
> +		else
> +			graph_width =3D width - number_width - 6 - name_width;
> +	}
> =20
> +	/* More sanity: give at least 5 columns to the graph,

Hrm, having to have a separate "More sanity" is ugly, and you seem to
already know it "This should already be satisfied...".

Can the logic above be tightened to make this "mopping up" unnecessary?

> +	 * but leave at least 10 columns for the name.
> +	 *
> +	 * This should already be satisfied, unless max_change is
> +	 * really huge. If the window is extemely narrow, this might
> +	 * overflow available columns.
> +	 */
> +	if (name_width < 10 && max_len >=3D 10)
> +		name_width =3D 10;

The logic up to this point uses the same "25 <=3D width, 10 <=3D name_w=
idth"
as the original to ensure that graph and the fixed part can use at leas=
t
15 columns.  And then you do this:

> +	if (graph_width < 5 && max_change >=3D 5)
> +		graph_width =3D 5;

which means you are allocating 10 columns for fixed part.  In the
original, it was OK to give fixed number of columns for fixed part like
this, as it always gave fixed 5 columns to show the number.  Don't you
need to adjust that 10 depending on the decimal_width(max_change), now
your number_width flexes?

This patch also breaks many existing tests that need to be adjusted for
the change to use decimal_width(max_change), which I do not care to fix=
 up
for you.  Perhaps that part of the change needs to be split out into a
separate patch.

Among the tests it breaks is t1200-tutorial.sh, which means that the
tutorial document that has illustration of the sample output also needs=
 to
be updated before the final round.

Thanks.
