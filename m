From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] attr: a note about the order of .gitattributes lookup
Date: Wed, 10 Oct 2012 11:04:32 -0700
Message-ID: <7vd30qcifj.fsf@alter.siamese.dyndns.org>
References: <20121010135552.GA11293@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 20:04:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM0eE-0003JT-8p
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 20:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756783Ab2JJSEf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 14:04:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35607 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756377Ab2JJSEf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Oct 2012 14:04:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36EA9899B;
	Wed, 10 Oct 2012 14:04:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Rg5q8Q4HZEqc
	XiE8z4zBL9camzc=; b=qEgWWftAVoZrk7h4pHTs/E3iQPf07b20+SnpSzwXIDh6
	IdT+0IO6gsYetgMuy/Z04UjYahz+ewzcKeg0m9qSkj71jIDH685phb3mUT8otlTn
	BuvYnn7bj3G15aYlALrXpS2F1oyHRAetcCR9rrH63bZJqsbJwt5kzLAfLKvWITo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Kz84V8
	r5RM3e1SfJp9TJI3m7pYhLiWivS8qGSDW0lbYSfZQaXTc52qyf9Kl9qX4sOY1h4a
	aK/YUmvjHIG9zPWKQb1mf9bKwzEXhX3Sn3vU+rVoJhreNFa89YIVqrNIfbGstTgd
	l6SkXy1VlXyPjbjgBFsFf1wLXQg/SMfTiq25c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2432B899A;
	Wed, 10 Oct 2012 14:04:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 83AD18997; Wed, 10 Oct 2012
 14:04:33 -0400 (EDT)
In-Reply-To: <20121010135552.GA11293@do> (Nguyen Thai Ngoc Duy's message of
 "Wed, 10 Oct 2012 20:55:52 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F200CE2A-1304-11E2-AF47-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207422>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> This is the documentation part of
>
> 1a9d7e9 (attr.c: read .gitattributes from index as well. - 2007-08-14=
)
> 06f33c1 (Read attributes from the index that is being checked out - 2=
009-03-13)
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  I looked around but did not see anywhere mentioning this. If I did
>  not miss anything, then we should take a note about this to avoid
>  surprises.
>
>  Resend, this time git@vger is CCed. Sorry for the noise.
>
>  Documentation/gitattributes.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattri=
butes.txt
> index 99ed04d..8c52a99 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -66,6 +66,12 @@ is from the path in question, the lower its preced=
ence). Finally
>  global and system-wide files are considered (they have the lowest
>  precedence).
> =20
> +Normally if `.gitattributes` is not found in a directory in work tre=
e,
> +the same path in the index is examined. If there's a `.gitattributes=
`
> +version in the index, that version will be used. During checkout pro=
cess,
> +the order of examination is reversed: index version is preferred ove=
r
> +the work tree version.
> +

Yeah, thanks for writing it up.  The "direction" fix was done to
help people when they check out a commit when a different commit
with different .gitattributes is checked out to the working tree.

>  If you wish to affect only a single repository (i.e., to assign
>  attributes to files that are particular to
>  one user's workflow for that repository), then
