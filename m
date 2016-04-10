From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/7] i18n: builtin/pull.c: mark strings for translation
Date: Sun, 10 Apr 2016 11:01:27 -0700
Message-ID: <xmqqinzptkaw.fsf@gitster.mtv.corp.google.com>
References: <1460234324-13506-1-git-send-email-vascomalmeida@sapo.pt>
	<1460234324-13506-4-git-send-email-vascomalmeida@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Sun Apr 10 20:01:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apJg1-0006JX-7p
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 20:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756189AbcDJSBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 14:01:31 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:52919 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756185AbcDJSBa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 14:01:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BF7C2521E0;
	Sun, 10 Apr 2016 14:01:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f/rjl7TrRpb1ZmuxNDYGmUkEYno=; b=Did+4m
	p1tKlqRKeII0KHJ3tTRQRnOEVKp5MANfqG4fs5EgGVCvQkXsyRHBOutZd7lyzjKu
	wmmtOMtbZoUAByQk6247earAeai3nEBeNu6bYCr1fKQv34/A0djbLD8rP1GgvFm7
	BrY3d1a3DIw5ZjvbR+KGIDAJkqc47HqsYBB9o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PCOKB/E7b1SOdyaWZV0krmDGJAdDwHHr
	A08ePmLJEDZYv9Kse+vLaWUvN8o1n3KD86fYWg2IHYI72lzwbRF5vb4Si2k+u18v
	E6NPehC50Xh9JobVH5TqMLS6SAFX5XOqdgncqmZXG7HWR2kowFgWlnuYsGAzQnBO
	uAyi/Wmskos=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B7089521DF;
	Sun, 10 Apr 2016 14:01:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3A147521DE;
	Sun, 10 Apr 2016 14:01:28 -0400 (EDT)
In-Reply-To: <1460234324-13506-4-git-send-email-vascomalmeida@sapo.pt> (Vasco
	Almeida's message of "Sat, 9 Apr 2016 20:38:41 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3F7B900A-FF46-11E5-BC1D-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291183>

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> Some translations might also translate "<remote>" and "<branch>".

This offers an interesting observation that I didn't think of while
reviewing the first round of this series.

Do translations want to translate "remote" and "branch" without the
"<bra" and "ket>"?  Or is it better to allow translations to adjust
the "quote around a placeholder" in a locale dependent way?

> @@ -458,13 +458,13 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
>  			fprintf_ln(stderr, _("Please specify which branch you want to merge with."));
>  		fprintf_ln(stderr, _("See git-pull(1) for details."));
>  		fprintf(stderr, "\n");
> -		fprintf_ln(stderr, "    git pull <remote> <branch>");
> +		fprintf_ln(stderr, "    git pull <%s> <%s>", _("remote"), _("branch"));

I know this hunk follows I suggested, i.e. "quotes around a
placeholder is universal and locale independent".  However, ...

>  		fprintf(stderr, "\n");
>  	} else if (!curr_branch->merge_nr) {
>  		const char *remote_name = NULL;
>  
>  		if (for_each_remote(get_only_remote, &remote_name) || !remote_name)
> -			remote_name = "<remote>";
> +			remote_name = _("<remote>");
>  
... this does not.  It allows to translate the "quote around a
placeholder".  And where this phony "remote_name" string is used,
there is also this reference to <branch>:

    fprintf_ln(stderr, _("If you wish to set tracking information for ..."
                    "\n"
                    "    git branch --set-upstream-to=%s/<branch> %s\n"),
                    remote_name, curr_branch->name);

which also does.

Perhaps the first hunk at around ll.458 would want to do

> +	fprintf_ln(stderr, "    git pull %s %s", _("<remote>"), _("<branch>"));

to be consistent and more flexible for the translator's needs?  The
quoting convention may be locale dependent after all.
