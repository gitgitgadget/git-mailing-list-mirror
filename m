From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] i18n: Not add stripped contents for translation
Date: Sun, 04 Mar 2012 18:27:49 -0800
Message-ID: <7v7gyz7pei.fsf@alter.siamese.dyndns.org>
References: <1330910494-17216-1-git-send-email-worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 03:28:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4Nf4-0001zj-2F
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 03:28:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755855Ab2CEC1x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Mar 2012 21:27:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43450 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755611Ab2CEC1x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Mar 2012 21:27:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B297606B;
	Sun,  4 Mar 2012 21:27:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=fhB82lSnm9+f
	gTHbRFHO/8fD1l0=; b=xrnkA4zcvX97AMt2HQ7fYLz3M09heaYtc2BznRXR+gO/
	TcHYrBF5qNgcsCVG4o7ItHkWmDDlEpqrN4T9H5CBEpNjt1knimGWtq/VUlqbo7UQ
	Yelkb+gd2uH8FdF4xQbIdvkvKtvRbd3tOE04e/HnEhyTbEHyAKLov7h3Wev7UFk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qkPhpz
	4FDgysA/xNYkwCJR3rxGnh6ahZ8efza36sPfCLiWvJbjFVGvScUVaYWIzSrbWcgu
	E+TRvQFJTdWLDZurwGkDXY4wvsy35JplBXU5Vf+XaTo0wjzQKFSDijqpGHmlIewp
	flNuwOORo5cbbOgqLl7LH6EyDq9sJ/09DEFHU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F501606A;
	Sun,  4 Mar 2012 21:27:52 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 84E9B6068; Sun,  4 Mar 2012
 21:27:51 -0500 (EST)
In-Reply-To: <1330910494-17216-1-git-send-email-worldhello.net@gmail.com>
 (Jiang Xin's message of "Mon, 5 Mar 2012 09:21:34 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CE8A488C-666A-11E1-AF40-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192187>

Jiang Xin <worldhello.net@gmail.com> writes:

> The last two chars of the concatenate str from the i18n marked string=
s
> (", ") will be stripped out by strbuf_setlen.
>
>         before: "new commits, modified content, "
>         end:    "new commits, modified content"
>
> If the translations won't end with COMMA+SPACE, will break the integr=
ity
> of the concatenate string. As for Chinese, COMMA+SPACE may translated=
 to
> "=EF=BC=8C" -- a 3-byte UTF-8 Chinese comma character.

Hmph.  Why would that be a bad thing in the first place?
=46or example, for the diff.c::print_stat_summary() message, you have t=
his
translation:

>  1 =E4=B8=AA=E6=96=87=E4=BB=B6=E8=A2=AB=E4=BF=AE=E6=94=B9=EF=BC=8C=E6=
=8F=92=E5=85=A5 3 =E8=A1=8C(+)=EF=BC=8C=E5=88=A0=E9=99=A4 3 =E8=A1=8C(-=
)

where the original would be:

   %d file changed, %d insertions(+), %d deletions(-).

and I would imagine that it entirely is plausible if a native reader wo=
uld
wish to read a Japanese translation like this:

   1=E5=80=8B=E3=81=AE=E3=83=95=E3=82=A1=E3=82=A4=E3=83=AB=E3=82=92=E5=A4=
=89=E6=9B=B4=E3=80=81=E6=8C=BF=E5=85=A5 3 =E8=A1=8C(+)=E3=80=81=E5=89=8A=
=E9=99=A4 3 =E8=A1=8C(-)

without using ASCII comma, but using "=E3=80=81" instead.

> diff --git a/wt-status.c b/wt-status.c
> index 9ffc535..0042dbc 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -245,11 +245,11 @@ static void wt_status_print_change_data(struct =
wt_status *s,
>  		if (d->new_submodule_commits || d->dirty_submodule) {
>  			strbuf_addstr(&extra, " (");
>  			if (d->new_submodule_commits)
> -				strbuf_addf(&extra, _("new commits, "));
> +				strbuf_addf(&extra, "%s, ", _("new commits"));
>  			if (d->dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
> -				strbuf_addf(&extra, _("modified content, "));
> +				strbuf_addf(&extra, "%s, ", _("modified content"));
>  			if (d->dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
> -				strbuf_addf(&extra, _("untracked content, "));
> +				strbuf_addf(&extra, "%s, ", _("untracked content"));
>  			strbuf_setlen(&extra, extra.len - 2);
>  			strbuf_addch(&extra, ')');
>  		}
