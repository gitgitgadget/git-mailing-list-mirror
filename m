From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] index-pack: show chain length histogram as graph for better visual
Date: Mon, 24 Feb 2014 09:27:42 -0800
Message-ID: <xmqq8ut0beup.fsf@gitster.dls.corp.google.com>
References: <1393032504-11854-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 18:30:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHzK5-0008IM-NR
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 18:28:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753182AbaBXR1t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Feb 2014 12:27:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35146 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752664AbaBXR1q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Feb 2014 12:27:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F8056B113;
	Mon, 24 Feb 2014 12:27:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Mc1wi5Dak0zt
	F8TN3dNKx4B13bU=; b=MtkJ8tk7Zsfj/OaCpqceKiP8Qwcb9W0NKj+uZO4R6c5U
	8YHgMREoR6Ms65v8VqmUOq866VRxacofd0yva6AMf2G+0RcdKUL6cVsTQxBXVSJL
	MlU4+vDJzyFAYIwpEZk5m6Yel4mfnqPHgh3PsgTS2Ir9vpx63Evlu+l5ESFY11c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=tE055+
	nv3fUr+g/WTwWHmObKWVYDQYV+bni27kJYirJDVFtgKLsl3aFatCHXpaLe4SFCIf
	RPTgCsvLzDPtiFu4/bcIV1cPu5i0vo5nQSnqlcK7lTpkyrssGlDHkcNd77qofUbA
	CxRhV52FOlfXfMlXs1xBJr83qjrbk6czRZc3o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 689986B112;
	Mon, 24 Feb 2014 12:27:45 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 871516B111;
	Mon, 24 Feb 2014 12:27:44 -0500 (EST)
In-Reply-To: <1393032504-11854-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 22
 Feb 2014 08:28:24 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F8B70266-9D78-11E3-A1A6-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242617>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  definitely better than raw numbers but not really important

I would appreciate if it were an optional feature. =20

> diff --git a/diff.c b/diff.c
> index 8e4a6a9..ca2b92a 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1489,7 +1489,8 @@ int print_stat_summary(FILE *fp, int files, int=
 insertions, int deletions)
>  	return ret;
>  }
> =20
> -static void show_stats(struct diffstat_t *data, struct diff_options =
*options)
> +static void show_stats(struct diffstat_t *data, struct diff_options =
*options,
> +		       int summary)
>  {
>  	int i, len, add, del, adds =3D 0, dels =3D 0;
>  	uintmax_t max_change =3D 0, max_len =3D 0;
> @@ -1729,10 +1730,40 @@ static void show_stats(struct diffstat_t *dat=
a, struct diff_options *options)
>  			fprintf(options->file, "%s ...\n", line_prefix);
>  		extra_shown =3D 1;
>  	}
> +	if (!summary)
> +		return;

Yuck.

>  	fprintf(options->file, "%s", line_prefix);
>  	print_stat_summary(options->file, total_files, adds, dels);
>  }
> =20
> +void show_histogram_graph(const char *label, unsigned long *data, in=
t nr)
> +{
> +	struct diffstat_t diffstat;
> +	struct diff_options options;
> +	struct diffstat_file *files;
> +	char buf[64];
> +	int i;
> +
> +	memset(&options, 0, sizeof(options));
> +	options.file =3D stdout;
> +	options.use_color =3D diff_use_color_default;
> +	options.stat_width =3D -1;
> +	diffstat.nr =3D nr;
> +	diffstat.files =3D xmalloc(nr * sizeof(*diffstat.files));

Double yuck for an incomplete refactoring.  Why should a generic
histogram-drawer know about *diff*-anything (and if this is still
a diff-specific histogram-drawer, verify-pack has no business
calling it)?

I like the idea very much, but not this particular execution.

> +	files =3D xcalloc(nr, sizeof(*files));
> +	for (i =3D 0; i < nr; i++) {
> +		diffstat.files[i] =3D files + i;
> +		sprintf(buf, "%s %d", label, i);
> +		files[i].name =3D xstrdup(buf);
> +		files[i].added =3D data[i];
> +	}
> +	show_stats(&diffstat, &options, 0);
