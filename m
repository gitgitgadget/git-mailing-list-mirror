From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/9] git-sh-setup.sh: add variable to use the stuck-long mode
Date: Mon, 27 Jan 2014 15:21:05 -0800
Message-ID: <xmqqtxcpm2ou.fsf@gitster.dls.corp.google.com>
References: <1390524666-51274-1-git-send-email-sandals@crustytoothpaste.net>
	<1390524666-51274-3-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Vigier <boklm@mars-attacks.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Jan 28 00:21:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7vUV-0007Os-EJ
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jan 2014 00:21:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683AbaA0XVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jan 2014 18:21:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42877 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750829AbaA0XVO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jan 2014 18:21:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66F2667DEC;
	Mon, 27 Jan 2014 18:21:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IkZgPz3M3jcAO46snJZtAPIuvwM=; b=IZwR+w
	f55AtC5EQNhFIy/mhPW6smbUNtCU2qKu2SQgyCDeiqHM/3BQHvl9iXGhOqA2aogK
	J0WxBGropGcdU9+2mi2arbYQpKqjYvPp8r9iOTeZVIg5yZuoPEf3MA2kVtztnWVl
	j7tKSBlOH65axpS5vp/LoGybHVjYeSb+sIcts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KJzdCQAdSLa9dZepMWYllvOgJwVNpGuF
	RjdkXVGhik6OA7qZPmbavC4unuZn3zivDIsYebwjPgGT4t8Hlxe17bmnfCHPf8uH
	E+Q+cTvz7Kz8bTfrEJS3o26GnU4cMB5aRNPQk9Q3OHKiFM0Rlz2OnV9f6YFJDj3c
	V1G/BeR4Isc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 686E567DEA;
	Mon, 27 Jan 2014 18:21:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA1AD67DE8;
	Mon, 27 Jan 2014 18:21:09 -0500 (EST)
In-Reply-To: <1390524666-51274-3-git-send-email-sandals@crustytoothpaste.net>
	(brian m. carlson's message of "Fri, 24 Jan 2014 00:50:59 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B46FFF16-87A9-11E3-ABFA-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241165>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> From: Nicolas Vigier <boklm@mars-attacks.org>
>
> If the variable $OPTIONS_STUCKLONG is not empty, then rev-parse
> option parsing is done in --stuck-long mode.
>
> Signed-off-by: Nicolas Vigier <boklm@mars-attacks.org>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  contrib/examples/git-checkout.sh | 1 +
>  contrib/examples/git-clean.sh    | 1 +
>  contrib/examples/git-clone.sh    | 1 +
>  contrib/examples/git-merge.sh    | 1 +
>  contrib/examples/git-repack.sh   | 1 +

Hmmm, especially given that nobody is exercising the ``updated''
code even in our testsuite, is it a good idea to touch these?

The STUCKLONG never existed back when they were scripted.  It just
adds noise when trying to view them for hints, no?

> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index fffa3c7..5f28b32 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -72,6 +72,8 @@ if test -n "$OPTIONS_SPEC"; then
>  	parseopt_extra=
>  	[ -n "$OPTIONS_KEEPDASHDASH" ] &&
>  		parseopt_extra="--keep-dashdash"
> +	[ -n "$OPTIONS_STUCKLONG" ] &&
> +		parseopt_extra="$parseopt_extra --stuck-long"
>  
>  	eval "$(
>  		echo "$OPTIONS_SPEC" |
