From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9001: avoid not portable '\n' with sed
Date: Wed, 04 Jun 2014 10:42:46 -0700
Message-ID: <xmqqr434vaeh.fsf@gitster.dls.corp.google.com>
References: <538ED6DF.5020505@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 04 19:43:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsFDy-0001Hf-Be
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 19:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbaFDRmx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jun 2014 13:42:53 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54070 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751094AbaFDRmw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jun 2014 13:42:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EDB7A1C532;
	Wed,  4 Jun 2014 13:42:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=DlkU49veh8ad
	uhWN1fpX0e6ctf8=; b=fudvo7CxJvj58ua0PhUaX3jaxbpfW/qx+ZmfjAiTBvx5
	/9cTmMr+cTUO4Ye23rYJnUfVcFNgNm8oeKBKhrpH7xNc9BvY0aFoSzi80sTiZ/8u
	wYo0rrqgaPBbSflB945OH3yhLW3wN2z4bHx/tH7s0Jt2teZV3PIxhyk0OKSCObU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=b4pyRv
	iyBaxHjgNm+JgZZtiVEPc7f/jZ2ICD0HKJ4fmJzTv1UvClqzC1A1/HIzSUudcNgk
	MZ2OYHKcTLvamPc7/a/6rN8HGnFG24o3X1ThNZN/S/pWkEqEQkdvF+EV34o3TFvq
	jCwyLmbkrF6Ca9PxhEYOCV2EU1L6JERqNCXY0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E3F601C531;
	Wed,  4 Jun 2014 13:42:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3F3DA1C52E;
	Wed,  4 Jun 2014 13:42:48 -0400 (EDT)
In-Reply-To: <538ED6DF.5020505@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Wed, 04 Jun 2014 10:20:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A4ACC08A-EC0F-11E3-9BE2-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250749>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> t9001 used a '\n' in a sed expression to split one line into two line=
s.
> Some versions of sed simply ignore the '\' before the 'n', treating
> '\n' as 'n'.
>
> As the test already requires perl as a prerequisite, use perl instead=
 of sed.
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---

Hmph.  I read this in pubs.opengroup.org/onlinepubs/9699919799/utilitie=
s/sed.html

    The escape sequence '\n' shall match a <newline> embedded in the
    pattern space.

so it may be better to be a bit more explicit in the log message to
say whose implementation has this issue to warn people.

>  t/t9001-send-email.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 64d9434..2bf48d1 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -1342,7 +1342,7 @@ test_cover_addresses () {
>  	git format-patch --cover-letter -2 -o outdir &&
>  	cover=3D`echo outdir/0000-*.patch` &&
>  	mv $cover cover-to-edit.patch &&
> -	sed "s/^From:/$header: extra@address.com\nFrom:/" cover-to-edit.pat=
ch >"$cover" &&
> +	"$PERL_PATH" -pe "s/^From:/$header: extra\@address.com\nFrom:/" cov=
er-to-edit.patch | tr Q "$LF" >"$cover" &&

We have a shell function "perl" in test-lib-function.sh these days
so that you do not have to write "$PERL_PATH" yourself in tests ;-)

>  	git send-email \
>  	  --force \
>  	  --from=3D"Example <nobody@example.com>" \

Thanks.
