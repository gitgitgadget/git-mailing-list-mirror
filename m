From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: added '-q' option, short option for '--quiet'
Date: Wed, 14 Jan 2015 10:52:52 -0800
Message-ID: <xmqqegqx9ou3.fsf@gitster.dls.corp.google.com>
References: <1421256901-30560-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 19:53:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBT49-0001DR-GN
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 19:53:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863AbbANSxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 13:53:13 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53916 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751617AbbANSxM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 13:53:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AFDE12CEA3;
	Wed, 14 Jan 2015 13:53:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2ZL3ooiQtCYqs86DJDK6V+nU2Ws=; b=UZdFX/
	J6XxXEMdDzHKdgOAWWcFBAQ/0GW56y7x1oRtNwSEK1MSfJWCMzx6zwi6IhV4i3EN
	/q4SiFxcAXl3yPQFYbSKnCt+P3a2bPl71+7hk3u04oO2S18h4/pkfG/2/lMhJB8q
	xX/sAiDZ1cwaukmkZhmnPH2l7y5+/Y3oX1KIo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iHJw2T8cHSN2kawGkKYSpbgfdzQzOszh
	Z18MlvxlMoamHoE8MwaVPjC+/HPAxDHbUWEVSVqm+UKd4Dum4spldlqtQQ7cMT1D
	eVxFpszSpK3UGnpX4L+zBDW3eTw4mHBrPMbfsehxJop/yLOKUnc9gDk6aXpQhTQM
	CAUwow6/j5E=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 984392CEA0;
	Wed, 14 Jan 2015 13:53:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D0EE62CE77;
	Wed, 14 Jan 2015 13:52:53 -0500 (EST)
In-Reply-To: <1421256901-30560-1-git-send-email-kuleshovmail@gmail.com>
	(Alexander Kuleshov's message of "Wed, 14 Jan 2015 23:35:01 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8BEFB650-9C1E-11E4-B647-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262411>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
>  Documentation/diff-options.txt | 1 +
>  diff.c                         | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)

I think we have deliberately refrained from doing this, as it will
make "git diff" inconsistent with the underlying "git diff-fiels".

>
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 2b15050..9160c90 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -491,6 +491,7 @@ ifndef::git-log[]
>  	That is, it exits with 1 if there were differences and
>  	0 means no differences.
>  
> +-q
>  --quiet::
>  	Disable all output of the program. Implies `--exit-code`.
>  endif::git-log[]
> diff --git a/diff.c b/diff.c
> index 6ad8970..d778df7 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3798,7 +3798,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
>  	}
>  	else if (!strcmp(arg, "--exit-code"))
>  		DIFF_OPT_SET(options, EXIT_WITH_STATUS);
> -	else if (!strcmp(arg, "--quiet"))
> +	else if (!strcmp(arg, "--quiet") || !strcmp(arg, "-q"))
>  		DIFF_OPT_SET(options, QUICK);
>  	else if (!strcmp(arg, "--ext-diff"))
>  		DIFF_OPT_SET(options, ALLOW_EXTERNAL);
