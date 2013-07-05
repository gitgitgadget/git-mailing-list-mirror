From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 4/5] t6006: add two more tests for the case i18n.commitEncoding is not set
Date: Fri, 05 Jul 2013 00:04:34 -0700
Message-ID: <7vk3l5a3nh.fsf@alter.siamese.dyndns.org>
References: <cover.1372939482.git.Alex.Crezoff@gmail.com>
	<d1e6681bea4a69d4774b09e4cb776f4cd6e6dcc9.1372939482.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 05 09:04:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv04Q-0008Tl-3g
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 09:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465Ab3GEHEi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jul 2013 03:04:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49437 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752391Ab3GEHEh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jul 2013 03:04:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB096297CF;
	Fri,  5 Jul 2013 07:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=aU7GIU0zf5SD
	/tXfZaOcoOnB4xo=; b=RrfIeLig9yEaOfm+ahTPykawS+CNcW7k5UtofR7jXE++
	qzg1zFNe1G5Y2xQQTnT93J6I5K6QwasbZrfV40nAz2DjjzOgJuLn9UoWQ2pMu9/n
	V5Vz/1L74yDT49XdrF4b0QNoKQXNJkHbqIXVyGovAdrGh4DNjwI8eyoSwrXHmZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ELTzC6
	FkXsL4i+tPPAQiGCx6lkHEedxsHAQu55M7In2u3jE/Ywr2Zm8k+yOy8Tov3bn9sT
	tmY+c79WCu8vfmXpI6PUCNzH7G0vE+ZFpu29h726Sg1J2TZdvRcVugbwS8y32JRe
	66X4UzmaHDoLeSiPUD4NjvDnJhlBbQRu3vc3w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1190297CE;
	Fri,  5 Jul 2013 07:04:36 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2F041297CD;
	Fri,  5 Jul 2013 07:04:36 +0000 (UTC)
In-Reply-To: <d1e6681bea4a69d4774b09e4cb776f4cd6e6dcc9.1372939482.git.Alex.Crezoff@gmail.com>
	(Alexey Shumkin's message of "Thu, 4 Jul 2013 16:45:49 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 26DA5134-E541-11E2-900C-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229629>

Alexey Shumkin <alex.crezoff@gmail.com> writes:

> +test_format complex-body %b <<EOF
> +commit $head3
> +This commit message is much longer than the others,
> +and it will be encoded in iso8859-1. We should therefore
> +include an iso8859 character: =C2=A1bueno!

This is not such a good idea, as the resulting file will be in mixed
encoding (it already has a line with non-ascii that is in UTF-8),
and many editors would not like such a file.

Perhaps we should update test_format so that we can feed a quoted
input, e.g.

    +include an iso8859-1 character: <A1>bueno!

or something?

> +commit $head2
> +commit $head1
> +EOF
> +
> +# Git uses i18n.commitEncoding if no i18n.logOutputEncoding set
> +# so unset i18n.commitEncoding to test encoding conversion
> +git config --unset i18n.commitEncoding
> +
> +test_format complex-subject-commitencoding-unset %s <<EOF
> +commit $head3
> +Test printing of complex bodies
> +commit $head2
>  $changed
>  commit $head1
>  $added
>  EOF
> =20
> -test_format complex-body %b <<EOF
> +test_format complex-body-commitencoding-unset %b <<EOF
>  commit $head3
>  This commit message is much longer than the others,
>  and it will be encoded in iso8859-1. We should therefore
