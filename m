From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git.c: binary-search builtin commands
Date: Tue, 15 Feb 2011 12:12:48 -0800
Message-ID: <7v4o85njjz.fsf@alter.siamese.dyndns.org>
References: <7vvd0ms9ra.fsf@alter.siamese.dyndns.org>
 <1297739344-28961-1-git-send-email-pclouds@gmail.com>
 <1297739344-28961-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 21:13:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpRGg-00086N-11
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 21:13:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755986Ab1BOUM5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Feb 2011 15:12:57 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47180 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755482Ab1BOUMz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 15:12:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4737C39BF;
	Tue, 15 Feb 2011 15:14:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=wqZWGP6+zauUmSFkyH9jEY5s5
	H4=; b=r1sbx3l5JOPSORL1Z7oBwYAajljOEkvt2bVxi2FDTQWeX77+GYujJ4qkQ
	2EOZzNJs2JGoxx6JQUoMIN7Nb7NMFPVtim96irY6CFrI7yWhlpDauBq19AZbO2zs
	7YzxV7pAN2b3ygS30FdXlH8YOuzceZo40Z7u4O89qBz2KWgjAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=fFhqhbwoXz92UHzMIYM
	2o0vlHf1FBz9u5G6HglwmsnrjULQMrw+2SeWAmACwjAIzdAJXfQlUQd+JlsXmO+y
	S64HpnrMkSkYl5Folvl5881036u0VgedXk6Xb7ghlKZvA2qYUdJ7HM7Zd+bxRGYl
	8kYiLR1Uw6qhlW9oeUtj6WOo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2238F39BE;
	Tue, 15 Feb 2011 15:13:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2C10139BD; Tue, 15 Feb 2011
 15:13:55 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1F8B1B84-3940-11E0-AE2B-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166874>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> An obvious implication of this patch: commands array must be in corre=
ct
> order.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>   2011/2/15 Junio C Hamano <gitster@pobox.com>:
>   > I did this myself the other day, as I think it simply is a good p=
roject
>   > hygiene.  If this were 1/2 of a series followed by 2/2 that runs =
binary
>   > search in the table, that would make it make more sense ;-)
>  =20
>   I did think the array was binary-searched and nearly claimed "git-s=
tage
>   won't work because it's in wrong order".

Heh, that "binary search" was a tongue-in-cheek comment.  I am sorry th=
at
you took it too seriously.

>   This patch won't give any performance gain, but it would force
>   people to keep the array in order :-)

That is exactly why I discarded what I did the other day.  Without an
active mechanism to force the orderedness, such a change simply introdu=
ces
a downside of letting a mistake go unnoticed, without any real upside (=
as
you measured and saw no performance gain).

A better project hygine is a good thing to aim for, and I would imagine
that you could add "--verify-builtin-command-table" as an unadvertised
option to "git" wrapper, and make t/t0000-basic.sh call it to minimize =
the
downside risk.  But without such an active measure to prevent mistakes,=
 we
would be relying on somebody getting caught on a ticking bomb and
reporting it, which is not a good tradeoff between risk and reward.
