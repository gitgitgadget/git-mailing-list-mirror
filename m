From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: add cppcheck target
Date: Wed, 29 Jan 2014 10:26:29 -0800
Message-ID: <xmqqeh3qk5ka.fsf@gitster.dls.corp.google.com>
References: <1390993371-2431-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 29 19:26:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8ZqP-00011E-VM
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jan 2014 19:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255AbaA2S0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jan 2014 13:26:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54154 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752369AbaA2S0d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jan 2014 13:26:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1B54684A2;
	Wed, 29 Jan 2014 13:26:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Aag5AubvxtzGZ0dq8j94EJAHcYI=; b=hwlk6D
	uvhSlPuNguRCB1DmVVWXTQkVNAp/i1sI1t3tD4bfw8Xir1VE0LS40kvlDNdMASGV
	hBPlORS/LNGGGMsoYfSSLS+yB3dpZQ63lVjx7TLG/+ARz2NiyQLQ3gbh9vHXmKM2
	NDuPzTh3U5GqN13nQogd91ieKtitpPL1pBVvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t+mOgFafVODehry3wkhfkUiycvKzz3UT
	AT34nmNoAHdzjUgZiDMgAL647vIWciqVcgZWakQhWglXptJD/oR9AUM969SbPEj0
	nmW6rlPNlCZPlwZ+pJGNetHU4t5RLSKhsX7K0qQlm8pPucsUKevOrIYxGEpkfllV
	r8C9+UST6CA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3184684A1;
	Wed, 29 Jan 2014 13:26:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B9196849F;
	Wed, 29 Jan 2014 13:26:32 -0500 (EST)
In-Reply-To: <1390993371-2431-1-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Wed, 29 Jan 2014 03:02:51 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E0AE14FE-8912-11E3-948F-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241217>

Elia Pinto <gitter.spiros@gmail.com> writes:

> Add cppcheck target to Makefile. Cppcheck is a static
> analysis tool for C/C++ code. Cppcheck primarily detects
> the types of bugs that the compilers normally do not detect.
> It is an useful target for doing QA analysis.
>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  Makefile      |    6 ++++++
>  config.mak.in |    1 +
>  2 files changed, 7 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index dddaf4f..1d25a70 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2602,3 +2602,9 @@ cover_db: coverage-report
>  cover_db_html: cover_db
>  	cover -report html -outputdir cover_db_html cover_db
>  
> +### cppcheck static coverage analysis
> +#
> +.PHONY: cppcheck
> +
> +cppcheck:
> +	cppcheck --enable=all -q $(top_srcdir)

Why isn't this "."?

In other words, why is the change to config.mak.in even necessary?

> diff --git a/config.mak.in b/config.mak.in
> index e6a6d0f..86b95fb 100644
> --- a/config.mak.in
> +++ b/config.mak.in
> @@ -22,3 +22,4 @@ docdir = @docdir@
>  
>  mandir = @mandir@
>  htmldir = @htmldir@
> +top_srcdir = @top_srcdir@
