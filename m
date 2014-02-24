From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] commit: add --cleanup=scissors
Date: Mon, 24 Feb 2014 09:20:14 -0800
Message-ID: <xmqqd2icbf75.fsf@gitster.dls.corp.google.com>
References: <1392521840-21628-1-git-send-email-pclouds@gmail.com>
	<1392639332-7703-1-git-send-email-pclouds@gmail.com>
	<1392639332-7703-4-git-send-email-pclouds@gmail.com>
	<20140222005856.GA9231@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 18:20:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHzCg-0006Sk-Mg
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 18:20:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879AbaBXRUX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Feb 2014 12:20:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48885 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752682AbaBXRUV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Feb 2014 12:20:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C19396CD80;
	Mon, 24 Feb 2014 12:20:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=dbLQQTxUtY+G
	//fVHagR7h2tHLM=; b=arMbgatRVfhSWsfiCEuYSknN/YQRmJLKsN8z5eSv42Re
	dFPQwZmCSCztRKdJeq3vI1raG5xpNnRUiMcwLTh963ckqIl9J/zLCZecAKbW82ID
	0fRKdebRewFSjzADbEemkO0kZUFcN0eVbJE7ekudlWuqJjVj9Ielv76T/YPEWDs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ZaifB7
	pZQa+c48xA7g3NMLSJW+ShsEY6KR4pt7DL5OIAVPZ4FTkM9Q6nvdKoMZn4RGMwsu
	Zdte2b1x+9PlUokZGB5ag9U+j4soBjkKl+5K76dnt5nWHSthxMuuUf6xOFaG/HCy
	N3rZNU1yGWVVF4LVQL64524JwvyOuYRYPcG50=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 966BB6CD7E;
	Mon, 24 Feb 2014 12:20:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D7A56CD7B;
	Mon, 24 Feb 2014 12:20:19 -0500 (EST)
In-Reply-To: <20140222005856.GA9231@lanh> (Duy Nguyen's message of "Sat, 22
	Feb 2014 07:58:56 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EF696CEA-9D77-11E3-8921-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242616>

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Feb 17, 2014 at 07:15:32PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>> @@ -777,6 +778,8 @@ static int prepare_to_commit(const char *index_f=
ile, const char *prefix,
>>  				_("Please enter the commit message for your changes."
>>  				  " Lines starting\nwith '%c' will be ignored, and an empty"
>>  				  " message aborts the commit.\n"), comment_line_char);
>> +		else if (cleanup_mode =3D=3D CLEANUP_SCISSORS)
>> +			wt_status_add_cut_line(s->fp);
>>  		else /* CLEANUP_SPACE, that is. */
>>  			status_printf(s, GIT_COLOR_NORMAL,
>>  				_("Please enter the commit message for your changes."
>
> This cut line does not cover the merge conflict message before it. Th=
e
> following patch should be squashed in to move the cut line up in that
> case.

I somehow thought that it was a policy decision we made in very
early days that these conflict messages are meant to be edited with
explanation of how they were resolved, not to be simply edited away?

The other stuff (commented out instructions and patch text) are
meant to aid humans while editing the log message, and stripping
away automatically after they are done editing like your patch does
is perfectly fine, but I find this change questionable.

> -- 8< --
> diff --git a/builtin/commit.c b/builtin/commit.c
> index ea2912f..1033c50 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -755,7 +755,9 @@ static int prepare_to_commit(const char *index_fi=
le, const char *prefix,
>  	strbuf_addstr(&committer_ident, git_committer_info(IDENT_STRICT));
>  	if (use_editor && include_status) {
>  		char *ai_tmp, *ci_tmp;
> -		if (whence !=3D FROM_COMMIT)
> +		if (whence !=3D FROM_COMMIT) {
> +			if (cleanup_mode =3D=3D CLEANUP_SCISSORS)
> +				wt_status_add_cut_line(s->fp);
>  			status_printf_ln(s, GIT_COLOR_NORMAL,
>  			    whence =3D=3D FROM_MERGE
>  				? _("\n"
> @@ -771,6 +773,7 @@ static int prepare_to_commit(const char *index_fi=
le, const char *prefix,
>  				git_path(whence =3D=3D FROM_MERGE
>  					 ? "MERGE_HEAD"
>  					 : "CHERRY_PICK_HEAD"));
> +		}
> =20
>  		fprintf(s->fp, "\n");
>  		if (cleanup_mode =3D=3D CLEANUP_ALL)
> @@ -778,7 +781,7 @@ static int prepare_to_commit(const char *index_fi=
le, const char *prefix,
>  				_("Please enter the commit message for your changes."
>  				  " Lines starting\nwith '%c' will be ignored, and an empty"
>  				  " message aborts the commit.\n"), comment_line_char);
> -		else if (cleanup_mode =3D=3D CLEANUP_SCISSORS)
> +		else if (cleanup_mode =3D=3D CLEANUP_SCISSORS && whence =3D=3D FRO=
M_COMMIT)
>  			wt_status_add_cut_line(s->fp);
>  		else /* CLEANUP_SPACE, that is. */
>  			status_printf(s, GIT_COLOR_NORMAL,
> -- 8< --
