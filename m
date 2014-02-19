From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 23/25] checkout: detach if the branch is already checked out elsewhere
Date: Wed, 19 Feb 2014 12:20:36 -0800
Message-ID: <xmqqha7u97mz.fsf@gitster.dls.corp.google.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1392730814-19656-24-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 19 21:21:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGDdP-0001yZ-9n
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 21:20:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754713AbaBSUUn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Feb 2014 15:20:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52855 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752710AbaBSUUm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Feb 2014 15:20:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 138056D646;
	Wed, 19 Feb 2014 15:20:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0o5tT/ZzjU1L
	ubQok5QpkqniqpY=; b=ZesOd1r2bb+mF0yP0ccDYSLI5CuHHoJL0/oLWLf6IieY
	h6zv7tEdFJvk7RjuuuRjO+Bd/piCAxVmTNNoQ1MXL0jLsTs2va4pe6jI+/uY8Q61
	HAyDCRhvSddCmBcTa6qm9qpZuHoplfe0Ln3+tC7GZKE5vg0h9NAGXv6xnSH6zpU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=umqfYr
	N8zq51ATVXMolg6OnodL9IQRJKRy+sLBSAb8Ciu7Lv/entwsc7jDTqJd8UA2IV9J
	81hczuEaRIkCVjy/DyPdKsQO2GSjlZn032prHAy3fc4+0aBLAf3hDkYUBsEdiyLr
	tseb25GvpMexOx+peGKMIDO4XUHwugwK1RGDA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E60C06D640;
	Wed, 19 Feb 2014 15:20:40 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6143D6D63B;
	Wed, 19 Feb 2014 15:20:38 -0500 (EST)
In-Reply-To: <1392730814-19656-24-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 18
 Feb 2014 20:40:12 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4BF16FF4-99A3-11E3-A7EF-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242405>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> The normal rule is anything outside refs/heads/ is detached. This
> strictens the rule a bit more: if the branch is checked out (either i=
n
> $GIT_COMMON_DIR/HEAD or any $GIT_DIR/repos/.../HEAD) then it's
> detached as well.
>
> A hint is given so the user knows where to go and do something there
> if they still want to checkout undetached here.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

(Only nitpicks during this round of review).

> diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
> index 76eae4a..f6a5c47 100755
> --- a/t/t2025-checkout-to.sh
> +++ b/t/t2025-checkout-to.sh
> @@ -13,13 +13,14 @@ test_expect_success 'checkout --to not updating p=
aths' '
>  '
> =20
>  test_expect_success 'checkout --to a new worktree' '
> +	git rev-parse HEAD >expect &&
>  	git checkout --to here master &&
>  	(
>  		cd here &&
>  		test_cmp ../init.t init.t &&
> -		git symbolic-ref HEAD >actual &&
> -		echo refs/heads/master >expect &&
> -		test_cmp expect actual &&
> +		! git symbolic-ref HEAD &&

test_must_fail?
