From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/19] trace.c: add GIT_TRACE_PACK_STATS for pack usage statistics
Date: Wed, 09 Mar 2016 14:58:12 -0800
Message-ID: <xmqq4mcfgsxn.fsf@gitster.mtv.corp.google.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
	<1457548582-28302-2-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pclouds@gmail.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 23:58:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adn3c-0001Pj-AG
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 23:58:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934301AbcCIW6R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2016 17:58:17 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55510 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933722AbcCIW6P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Mar 2016 17:58:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 432F84CFCE;
	Wed,  9 Mar 2016 17:58:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=lRP85lC0mLaV
	O1jiF0o7wPCx5eI=; b=gVdIQb9kqb3bwwXey1Ov1lZ9dyjItksVhRDAqFx65Ver
	m3dmawAnNepOBDwb9zCwlNeB0FQEm6CFRbnwlY27/e52HwX/CKX0CZzHNe7z8X+J
	llzleFfhbgJT9yVfDlqsYO1wgBzg2+w2+W5GpWJWpidx+9lacnoPRkJasnvxCDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kU1fmu
	15hiaG1i7BDJnlWh8cxEJZT9TtGE/FVTtZMYxibmMmC5+QYMx6W9/neodMQqKqbh
	RPFFNOb/kJHXOCbMvl0kQj1sJj3IWEoZOYMgOBPivTfiFASUqH2OKQJuyFbHvGih
	qbv8nXvF0vOwZiVXtYLbKj89I9l2C+762//sA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3973B4CFCD;
	Wed,  9 Mar 2016 17:58:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B1C234CFCB;
	Wed,  9 Mar 2016 17:58:13 -0500 (EST)
In-Reply-To: <1457548582-28302-2-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Wed, 9 Mar 2016 13:36:04 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6729A2F0-E64A-11E5-9026-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288579>

David Turner <dturner@twopensource.com> writes:

> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>
> trace_stats() is intended for GIT_TRACE_*_STATS variable group and
> GIT_TRACE_PACK_STATS is more like an example how new vars can be adde=
d.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/git.txt |  3 +++
>  cache.h               |  2 ++
>  git.c                 |  1 +
>  sha1_file.c           | 24 ++++++++++++++++++++++++
>  trace.c               | 13 +++++++++++++
>  trace.h               |  1 +
>  6 files changed, 44 insertions(+)
>
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 2754af8..794271e 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -1055,6 +1055,9 @@ of clones and fetches.
>  	time of each Git command.
>  	See 'GIT_TRACE' for available trace output options.
> =20
> +'GIT_TRACE_PACK_STATS'::
> +	Print various statistics.

"Various" is quite vague.

Perhaps a new description in Documentation/technical/ might be a
good thing to have?

> +void report_pack_stats(struct trace_key *key)
> +{
> +	trace_printf_key(key, "\n"
> +			 "pack_report: getpagesize()            =3D %10" SZ_FMT "\n"
> +			 "pack_report: core.packedGitWindowSize =3D %10" SZ_FMT "\n"
> +			 "pack_report: core.packedGitLimit      =3D %10" SZ_FMT "\n"
> +			 "pack_report: pack_used_ctr            =3D %10u\n"
> +			 "pack_report: pack_mmap_calls          =3D %10u\n"
> +			 "pack_report: pack_open_windows        =3D %10u / %10u\n"
> +			 "pack_report: pack_mapped              =3D "
> +			 "%10" SZ_FMT " / %10" SZ_FMT "\n"
> +			 "pack_report: pack accesss             =3D %10u\n",
> +			 sz_fmt(getpagesize()),
> +			 sz_fmt(packed_git_window_size),
> +			 sz_fmt(packed_git_limit),
> +			 pack_used_ctr,
> +			 pack_mmap_calls,
> +			 pack_open_windows, peak_pack_open_windows,
> +			 sz_fmt(pack_mapped), sz_fmt(peak_pack_mapped),
> +			 pack_access_nr);
> +}
> +
>  /*
>   * Open and mmap the index file at path, perform a couple of
>   * consistency checks, then record its information to p.  Return 0 o=
n
> @@ -2238,6 +2261,7 @@ static void write_pack_access_log(struct packed=
_git *p, off_t obj_offset)
>  	static struct trace_key pack_access =3D TRACE_KEY_INIT(PACK_ACCESS)=
;
>  	trace_printf_key(&pack_access, "%s %"PRIuMAX"\n",
>  			 p->pack_name, (uintmax_t)obj_offset);
> +	pack_access_nr++;
>  }

This looks rather half-hearted, in that those who are interested in
this new number can run "wc -l" on the pack-access trace log without
adding a new "stats" anyway.  It may make the "stats" far more
useful to keep track of the summary information of what would be
written to the pack access log and add to the report_pack_stats()
output things like the average and median distance of seeks
(i.e. differences in the "obj_offset" into the same pack by two
adjacent pack accesse) and the variance, for example?
