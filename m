From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] t1507: add additional tests for @{upstream}
Date: Wed, 11 Apr 2012 10:52:19 -0700
Message-ID: <7vfwcakvfw.fsf@alter.siamese.dyndns.org>
References: <1334161035-26355-1-git-send-email-zbyszek@in.waw.pl>
 <1334161035-26355-2-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Wed Apr 11 19:52:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI1ic-0001vR-26
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 19:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760785Ab2DKRwY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 13:52:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53587 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759508Ab2DKRwW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Apr 2012 13:52:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7819074F3;
	Wed, 11 Apr 2012 13:52:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=nwA4yxFzmwaW
	/FZG2mbtOSG/Twc=; b=KPX3hTDUd+dWgywoGQOplZdRapjj1Vh2MaalvRBi6n+C
	8c3l7nqxi/chwePGch61VO83hZPrP731Gr1j2USgdrvbrYQG1EVQHVyqMpVyGOgp
	XsWu2uXh/MqJHca5n0HUS7DNkB6QBPBVtl4x38AHkV+LW/E6LXFLFlL/1795fEo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=i5Na/k
	XZOEp+r9tbtNGRBV/mWF3XV5duS0iJrIsyU6rmlAxLoabARNWt/CJX8fZj6Aa8Po
	A7hRHDKev0BcLpr9CFt2FJXmsMIGmBVa6yZS4z2dcRKp5nOeg8pDSHfZicpaXFa4
	CR+fbFetSsQYGpyI0+kNF2Ap09rgdpi2nIuKk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FE7674F2;
	Wed, 11 Apr 2012 13:52:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E12B974F1; Wed, 11 Apr 2012
 13:52:20 -0400 (EDT)
In-Reply-To: <1334161035-26355-2-git-send-email-zbyszek@in.waw.pl> ("Zbigniew
 =?utf-8?Q?J=C4=99drzejewski-Szmek=22's?= message of "Wed, 11 Apr 2012
 18:17:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1626337A-83FF-11E1-BF86-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195224>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> +error_message () {
> +	(cd clone &&
> +	 test_must_fail git rev-parse --verify "$@")
> +}
> ...
> +test_expect_success 'branch@{u} error message when no upstream' '
> +	cat >expect <<-EOF &&
> +	error: No upstream branch found for ${sq}non-tracking${sq}
> +	fatal: Needed a single revision
> +	EOF
> +	(cd clone &&
> +	 test_must_fail git rev-parse --verify non-tracking@{u}) 2>actual &=
&

Why not use "error_message" as other new tests?

> +	test_cmp expect actual

Should we worry about test_i18ncmp here (and all the other test_cmp thi=
s
patch introduces)?

> +'
> +
> +test_expect_success '@{u} error message when no upstream' '
> +	cat >expect <<-EOF &&
> +	error: No upstream branch found for ${sq}${sq}
> +	fatal: Needed a single revision
> +	EOF
> +	test_must_fail git rev-parse --verify @{u} 2>actual &&
> +	test_cmp expect actual
> +'

We may want to update the error message for "@{u}" when the current one=
 is
not tracked, instead of saying ''.  Perhaps

	error: No upstream branch found for the current branch.

or something?

Likewise for the detached HEAD case.

> +test_expect_success 'branch@{u} error message if upstream branch not=
 fetched' '
> +	cat >expect <<-EOF &&
> +	error: No upstream branch found for ${sq}bad-upstream${sq}
> +	fatal: Needed a single revision
> +	EOF
> +	error_message bad-upstream@{u} 2>actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'pull works when tracking a local branch' '
> +(
> +	cd clone &&
> +	git checkout local-master &&
> +	git pull
> +)
> +'
> +
> +# makes sense if the previous one succeeded

Can't you make this not to depend on the result of the previous test
(Which one?  The immediately previous one is done in "clone" directory,
so that is not it)?

> +test_expect_success '@{u} works when tracking a local branch' '
> +	test refs/heads/master =3D "$(full_name @{u})"
> +'
> +
>  cat >expect <<EOF
>  commit 8f489d01d0cc65c3b0f09504ec50b5ed02a70bd5
>  Reflog: master@{0} (C O Mitter <committer@example.com>)
