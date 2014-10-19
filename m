From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1304: Set LOGNAME even if USER is unset or null
Date: Sun, 19 Oct 2014 15:49:36 -0700
Message-ID: <xmqqegu3r7y7.fsf@gitster.dls.corp.google.com>
References: <12975d1f2b5b1cd4cc6052b829bf4814300a7ffd.1413581788.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Mon Oct 20 00:49:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XfzIR-0002WF-1D
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 00:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbaJSWtj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Oct 2014 18:49:39 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53998 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751579AbaJSWtj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Oct 2014 18:49:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 27EA317DD0;
	Sun, 19 Oct 2014 18:49:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=lM6LCAfC1SVV
	rsep/JF+GoOOr1s=; b=eTfc9lD2CKiO77Z9utSJsEUnAze2KQGvzi1kDJ74OktJ
	VcmPdmMOCG8UBkEkiuKULJTQw7J9nBsu8+41RD2ADgAGt+d3WZgrH9qVNHUW5mwr
	aWlRKsxkQYBuc3VnVGxr0lWb6wsNA7v39Rd6NWoF1umvikw73dInKM9OY/433PE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=SC8e7r
	AtEfBypsOHFoROLBKeObQu7jxH2gOT09dZZDnI8KFqIdC5P4g/OTRFzvNtcgy9kR
	dqp4SHr89Qwu3G4r49KGW8fVpK2JR9OuHNh1Stn0Adbv40bviSUPDaWVOu4ZsOaN
	C4XyveYxQoSV96xp1YN6ovNFAdY8i+jz3uDqU=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F15117DCF;
	Sun, 19 Oct 2014 18:49:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 91E6917DCB;
	Sun, 19 Oct 2014 18:49:37 -0400 (EDT)
In-Reply-To: <12975d1f2b5b1cd4cc6052b829bf4814300a7ffd.1413581788.git.wking@tremily.us>
	(W. Trevor King's message of "Fri, 17 Oct 2014 14:39:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 34168786-57E2-11E4-9775-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"W. Trevor King" <wking@tremily.us> writes:

> Previous LOGNAME discussion:
>
> * Michael Gruber on 2011-05-06 suggesting a discussing a whoami
>   fallback [1] (but whoami isn't POSIX).
> * Ren=C3=A9 Scharfe on 2011-10-14 suggesting USER as a fallback for
>   LOGNAME [2].
> * Matthieu Moy on 2012-09-17 suggesting dropping $LOGNAME in
>   favor of numerical user IDs 'id -u' for a system with multiple
>   usernames sharing the same user ID [3].
>
> Obviously, you can work around the problem with:
>
>   # USER=3D$(id -u -n) ./t1304-default-acl.sh
>
> so the question is really "Are empty-USER systems worth supporting ou=
t
> of the box?".
>
> Cheers,
> Trevor
>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/172883/fo=
cus=3D172961
> [2]: http://thread.gmane.org/gmane.comp.version-control.git/183586
> [3]: http://thread.gmane.org/gmane.comp.version-control.git/205690/fo=
cus=3D205703
>
>  t/t1304-default-acl.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t1304-default-acl.sh b/t/t1304-default-acl.sh
> index 79045ab..f5422f1 100755
> --- a/t/t1304-default-acl.sh
> +++ b/t/t1304-default-acl.sh
> @@ -26,7 +26,7 @@ test_expect_success 'checking for a working acl set=
up' '
> =20
>  if test -z "$LOGNAME"
>  then
> -	LOGNAME=3D$USER
> +	LOGNAME=3D"${USER:-$(id -u -n)}"

I'll queue this as-is, but it makes me wonder if we want to do this
without if/then/fi, e.g.

	: ${LOGNAME:=3D${USER:-$(id -u -n)}

Spelling everything out with if/then/fi is obviously at the other
extreme, i.e.

	if test -z "$LOGNAME"
	then
		if test -n "$USER"
                then
			LOGNAME=3D$USER
		else
			LOGNAME=3D$(id -u -n)
		fi
	fi

but it probably is a very bad idea.


More importantly, what if none of the alternatives work?  I
personally feel it is OK to punt and declare test_done early,
instead of giving false positive breakages like you saw without this
patch.
