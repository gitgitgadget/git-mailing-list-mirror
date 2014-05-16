From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: switch core.commentChar if it's found in existing commit
Date: Fri, 16 May 2014 10:27:24 -0700
Message-ID: <xmqqzjihab2b.fsf@gitster.dls.corp.google.com>
References: <CACsJy8DSqeAnCMCawsh-58=B1z93tBCVb+x8XAAUZ17Y1ZaJKA@mail.gmail.com>
	<1400237982-5842-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michal Stasa <michal.stasa@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 20:51:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlNEA-00044L-15
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 20:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758084AbaEPSv0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 May 2014 14:51:26 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62263 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758074AbaEPSvZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 May 2014 14:51:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EDF0A17DE1;
	Fri, 16 May 2014 14:51:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PWo5yX21Hjvh
	4fEheTfurzHbOOs=; b=od5+0UE0k0iQzeNM01RHngrTV4LbBpVJApD26Jxj4R28
	tH+WTGEN1jdhoQ/PQgfj7TwejAfEv5T/ec2nuOEwsUYGeeDrXeeoiaygllfetI7d
	zsEnYh/vA8+OdZXE1lhQfq+u/KQyB/7LBq0WzlEyu0LC13S/JLFyud5vfOPIgPY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gQ++3a
	cHMbovi9pFEcfGF+pLKsFSpHzhZo7QZGKg1ZNyNNLgmhahi6xwaMNQ67TR3BGNo0
	jAqBGeZQ524jWEz+sObx7zRrQB3Msh/rlXwMrzsochFIZyMo7YIh4vNpvCc2gvkA
	axZempV96E4HUMGfW+NKA6H+p1evSxCLOw/Eg=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E580C17DE0;
	Fri, 16 May 2014 14:51:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0F5EA17396;
	Fri, 16 May 2014 13:27:26 -0400 (EDT)
In-Reply-To: <1400237982-5842-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 16
 May 2014 17:59:42 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 59C0E32A-DD1F-11E3-ABEB-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249410>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> If we need to use core.commentChar and it's already in the prepared
> message, find another char among a small subset. This should stop
> surprises because git strips some lines unexpectedly. Of course if
> candicate characters happen to be all out, this change does not help.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  On Fri, May 16, 2014 at 5:28 PM, Duy Nguyen <pclouds@gmail.com> wrot=
e:
>  > But maybe git should detect that the
>  > current commit message has leading '#' and automatically switch to
>  > another character..
>
>  Something like this. Lightly tested.. I know there's a small bug..
>
>  builtin/commit.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 6ab4605..70ceb61 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -593,6 +593,32 @@ static char *cut_ident_timestamp_part(char *stri=
ng)
>  	return ket;
>  }
> =20
> +static void adjust_comment_line_char(const struct strbuf *sb)
> +{
> +	char candidates[] =3D " !@#$%^&|:;~";

Did you really mean to add a SP to the candidates?

> +	char *candidate;
> +	const char *p;
> +	if (!sb->len)
> +		return;
> +	candidates[0] =3D comment_line_char;
> +	p =3D sb->buf;
> +	do {
> +		candidate =3D strchr(candidates, *p);
> +		if (candidate)
> +			*candidate =3D ' ';
> +		p =3D strchrnul(p, '\n');
> +		if (*p)
> +			p++;
> +	} while (*p);
> +	if (strchr(candidates, comment_line_char)) {
> +		p =3D candidates;
> +		while (*p && *p =3D=3D ' ')
> +			p++;
> +		if (*p)
> +			comment_line_char =3D *p;
> +	}
> +}
> +
>  static int prepare_to_commit(const char *index_file, const char *pre=
fix,
>  			     struct commit *current_head,
>  			     struct wt_status *s,
> @@ -748,6 +774,9 @@ static int prepare_to_commit(const char *index_fi=
le, const char *prefix,
>  	if (fwrite(sb.buf, 1, sb.len, s->fp) < sb.len)
>  		die_errno(_("could not write commit template"));
> =20
> +	if (use_editor && include_status)
> +		adjust_comment_line_char(&sb);
> +
>  	strbuf_release(&sb);
> =20
>  	/* This checks if committer ident is explicitly given */
