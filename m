From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] dir.c: clean the entire struct in clear_exclude_list()
Date: Mon, 28 Dec 2015 12:47:58 -0800
Message-ID: <xmqqtwn2jo5d.fsf@gitster.mtv.corp.google.com>
References: <1451181274-26213-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 28 21:48:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDei8-0006Fx-Ib
	for gcvg-git-2@plane.gmane.org; Mon, 28 Dec 2015 21:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752664AbbL1UsE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Dec 2015 15:48:04 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62556 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752437AbbL1UsC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Dec 2015 15:48:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0418C38BAA;
	Mon, 28 Dec 2015 15:48:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7mCLKFW8/wrs
	4GSBFOWNKf+Kf8o=; b=C2ZJbHxsK4EfI1D276Esu4Ei2WRnC50OR6e8dj9HImWX
	kiQtV7ktbTj10FHyR1WWyX4KsAXtcSkpawc8QH9bqYq0xdBIApWIbJqLfp12XX8b
	iTB+1TxsYllNL7778vvJg8YOVLRV2v7qyW7jlt2XY0yBtg39n+RmPk3+RonPPQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=mznLNU
	lT5tUFT/HwAOuMkiKBAnrdoq02OFtkrgp1k2VgtJa3mtQ0839VpHbj/ccsTMNmVw
	vmOqPQkFweyKCaehIXV2iXy31bXrHrxwOAEpnuiu79bsnXsTcgv1R0W3YyOY1No0
	hUbK6PENN/wkwnl+IfhEenvXjjfNQ1GPwa6Zs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 25D7F38BA7;
	Mon, 28 Dec 2015 15:48:01 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 17B0F38BA2;
	Mon, 28 Dec 2015 15:48:00 -0500 (EST)
In-Reply-To: <1451181274-26213-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 27
 Dec 2015 08:54:34 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 482212F4-ADA4-11E5-A96B-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283049>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Make sure "el" can be reuseable again. The problem was el->alloc is
> not cleared and may cause segfaults next time because add_exclude()
> thinks el->excludes (being NULL) has enough space. Just clear the
> entire struct to be safe.

OK.

If somebody ever adds a field to this structure that should not be
cleared by filling it with '\0', that person would notice and turn
this memset() back to individual field assignment, but until then,
I think memset is a reasonable thing to do, as that is how it is
initialized by add_exclude_list() in the first place anyway.

Will apply.

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  This was needed in the worktree config split series because the same
>  exclude_list could be reused. But that series is changing and will n=
ot
>  need exclude_list any more. So instead of dropping this patch, I
>  submit it separately. It's a good fix anyway.
>
>  dir.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index d2a8f06..b8b4576 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -564,9 +564,7 @@ void clear_exclude_list(struct exclude_list *el)
>  	free(el->excludes);
>  	free(el->filebuf);
> =20
> -	el->nr =3D 0;
> -	el->excludes =3D NULL;
> -	el->filebuf =3D NULL;
> +	memset(el, 0, sizeof(*el));
>  }
> =20
>  static void trim_trailing_spaces(char *buf)
