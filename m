From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] diff: add --rename-file
Date: Wed, 20 Jan 2016 14:44:41 -0800
Message-ID: <xmqq4me750rq.fsf@gitster.mtv.corp.google.com>
References: <1453287968-26000-1-git-send-email-pclouds@gmail.com>
	<1453287968-26000-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 23:45:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aM1V4-00065e-5s
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 23:45:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758518AbcATWpJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jan 2016 17:45:09 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64306 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753989AbcATWor convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2016 17:44:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EE86A3E1F1;
	Wed, 20 Jan 2016 17:44:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ypjB8auwco+U
	C1ZqrdjJcW+kcDE=; b=jyyDNNFakkRiJLJXgITVDBJj9iRWK210iHsO6JBvPb4F
	zTg0vSn2gOtBEcT4CU2/Ey705jybv2PUr7bLmtMMruk4Kw/7+lRiOeVHbckjHOrA
	OMLuZ1YCC4upZ9NmhMLZ2B+2j+c8nc/A31ZWKav1EMp1O1ZpPmhp4DTbUvcb5AI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=hQUpkv
	RJXKAtizlhtPI1BHvxqv8MHt2OqZ2CxfqSlPd70NIBo9VEhus+GUwIZRkLosEs3B
	mnDCORROUmqNgkCKk09lqRgtYXkZPKY7JGqpxVqiIWfjsjb22v6l9LheOMmtYacf
	xlcKviY+2AKd0eJZUpTZGfNuwSwV3ruikVeRc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E4E173E1F0;
	Wed, 20 Jan 2016 17:44:43 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 20B743E1EF;
	Wed, 20 Jan 2016 17:44:43 -0500 (EST)
In-Reply-To: <1453287968-26000-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 20
 Jan 2016 18:06:04 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 65C4E75C-BFC7-11E5-A276-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284479>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Git's heuristics to detect renames or copies works most of the time.
> This option can be used to correct the result when it goes wrong.
> Matching pairs get max rename score and override even exact rename
> detection.
>
> Note that --rename-file does not try to break existing diff pairs. So
> if you have "abc =3D> def" in your file, but they are already paired =
up
> (e.g. "abc =3D> abc" and "def =3D> def") and not broken down by -B, t=
hen
> nothing happens.
>
> An assumption is made in this patch, that the rename file only contai=
ns
> a couple rename pairs, not thousands of them. Looping through all
> rename source and destination for each rename line will not affect
> performance and we can keep the code simple.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

> +--rename-file=3D<path>::
> +	The given file contains explicit rename pairs that override
> +	automatic detected renames. Each line contains a rename pair
> +	in the following format:
> ++
> +<source path> <space> "=3D>" <space> <destination path>
> +

Obviously this needs path-quoting support before it can get anywhere
near 'next', but I found the basic idea outlined in the change in
diffcore-rename.c in this patch OK.  The manual one comes even
before the "look for identical ones" step, which is logically the
right thing to do.

One small nit is that using MAX_SCORE may have unintended fallouts.
The manually specified one is chosen among rename candidates not
because it has the highest similarity score---it in fact may not
have a good similarity score at all, but we pair the paths because
the user tells us to (and the user knows better than we do).

I am just wondering if it is easy to make the similarity score shown
at the beginning of diff displayed differently.  For manually paired
paths, we can and should keep "rename from OLDPATH" and "rename to
NEWPATH" entries, but I think "similarity index 100%" should ideally
be not shown for them, and if we have to have the line (e.g. perhaps
existing tools expect a line that begins with "similarity index" to
exist), show something like "similarity index N/A" that is clearly
different from "100%".
