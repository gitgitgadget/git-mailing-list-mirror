From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff too slow for a file
Date: Sun, 02 May 2010 08:10:52 -0700
Message-ID: <7v1vduwd8j.fsf@alter.siamese.dyndns.org>
References: <4BB00573.6040005@gmail.com> <4BC9D928.50909@lsrfire.ath.cx>
 <7vpr1y2eev.fsf@alter.siamese.dyndns.org> <4BCB48E5.9090303@lsrfire.ath.cx>
 <7vd3xuinbe.fsf@alter.siamese.dyndns.org> <4BDD7869.10701@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SungHyun Nam <goweol@gmail.com>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun May 02 17:11:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8ap8-0001cV-5K
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 17:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757116Ab0EBPLI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 May 2010 11:11:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51545 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756635Ab0EBPLG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 May 2010 11:11:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3135EB0649;
	Sun,  2 May 2010 11:11:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=aL0Z8awSaGV8
	qEEvtKEd8IqKQfM=; b=PBYQ+YRENv721sueFkDl2zv7gmCD9p6bGFOK8PFnsl7f
	Jn7gEUJrMOEw/94K5Ko/JHRyHLCYVdZk4v3YNWuWNzT8DBQtD4j+O3wimZ8NxEC+
	JIA02lBs/ww2xPBHGDmzSQVbCSvQ69jP527YM5KPPKRLlphlNVSgFCRHXQkH2uw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=lA358P
	5kopscxTDNbmiTYSg5N53qPAcA7aOg94xFW+47S6khXS3813XJrqBx88PyfIbvtE
	AWHsOANbXkqWEfi8LrkitaBK+OX8EBQx70EWlN89DcsvHcECj0qcsm5GEAEqsLW6
	e4YgvRl93NDwVXRD0NHTr1+rsIcovfwkVaaaw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E9D14B0648;
	Sun,  2 May 2010 11:10:57 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A58AB0647; Sun,  2 May
 2010 11:10:53 -0400 (EDT)
In-Reply-To: <4BDD7869.10701@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Sun\, 02 May 2010 15\:04\:41 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E9554AD4-55FC-11DF-973B-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146181>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Ever since the xdiff library had been introduced to git, all its call=
ers
> have used the flag XDF_NEED_MINIMAL.  It makes sure that the smallest
> possible diff is produced, but that takes quite some time if there ar=
e
> lots of differences that can be expressed in multiple ways.
>
> This flag makes a difference for only 0.1% of the non-merge commits i=
n
> the git repo of Linux, both in terms of diff size and execution time.
> The patches there are mostly nice and small.
>
> SungHyun Nam however reported a case in a different repo where a diff
> took more than 20 times longer to generate with XDF_NEED_MINIMAL than
> without.  Rebasing became really slow.
>
> This patch removes this flag from all callers.  The default of xdiff =
is
> saner because it has minimal to no impact in the normal case of small
> diffs and doesn't incur that much of a speed penalty for large ones.

Thanks, will queue.

> diff --git a/merge-file.c b/merge-file.c
> index c336c93..db4d0d5 100644
> --- a/merge-file.c
> +++ b/merge-file.c
> @@ -66,7 +66,7 @@ static int generate_common_file(mmfile_t *res, mmfi=
le_t *f1, mmfile_t *f2)
>  	xdemitcb_t ecb;
> =20
>  	memset(&xpp, 0, sizeof(xpp));
> -	xpp.flags =3D XDF_NEED_MINIMAL;
> +	xpp.flags =3D 0;
>  	memset(&xecfg, 0, sizeof(xecfg));
>  	xecfg.ctxlen =3D 3;
>  	xecfg.flags =3D XDL_EMIT_COMMON;

When I wrote the message you are responding to, I tried to decide which=
 is
better, to replace the assigned value like your patch does, or to remov=
e
the assignment altogether as we have memset(&xpp, 0, sizeof(xpp)).  And=
 I
was somewhat torn.

While it expresses what the patch wants to do a lot clearer (and it als=
o
marks the places the "later patch" needs to touch), the resulting code
becomes slightly harder to read, because future readers of the code are
left with an obvious "why do we assign 0 after clearing the whole thing=
?
is there anything subtle going on?" unanswered.
