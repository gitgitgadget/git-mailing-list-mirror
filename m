From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status: list unmerged files after staged files
Date: Tue, 01 Sep 2009 13:38:08 -0700
Message-ID: <7vy6oy9z9r.fsf@alter.siamese.dyndns.org>
References: <20090901145213.GB4194@debian.b2j>
 <7vljkypqfi.fsf@alter.siamese.dyndns.org> <200909012140.08953.j6t@kdbg.org>
 <200909012213.54611.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, bill lam <cbill.lam@gmail.com>,
	git <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Sep 01 22:38:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mia7V-0001pY-H3
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 22:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231AbZIAUiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 16:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752150AbZIAUiQ
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 16:38:16 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44040 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014AbZIAUiP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 16:38:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A0BB921812;
	Tue,  1 Sep 2009 16:38:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mmlw/E8fTuf+u6RW3b3ax7FteQc=; b=XLmSBC
	BvDZwjLKgkWxkSiXkwfDgctHT5Cn34WbSwTwkQTTeFooyR1R0S1SPuo6TaaBYVGX
	UX1AgicaOOp0J4S9rsPj3CAgp2e0/OQMMFw57FAqaIAu+HuqsLtRpyWQgJEALkM0
	3qKoR22Oh2jBWl/r8e83LCQpmZQGU6EQUfzSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yk5uZj6PCSYQ4ajDZxEzuax7vvyio0rM
	5/6rAz1vIWN+00QF1DC1FDQcA40wyf/oevuR8Q9fXAVTtu4aH/b0DQjiY7cK2r7H
	biKVQYAGRbZxyg5vvs4fzJGb6ZM0U2YLjBd9eTj5PkWJevc5y2foQCJ9Rbfzf+G/
	XvtBH4GlvvY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7295421810;
	Tue,  1 Sep 2009 16:38:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A1412180F; Tue,  1 Sep
 2009 16:38:09 -0400 (EDT)
In-Reply-To: <200909012213.54611.j6t@kdbg.org> (Johannes Sixt's message of
 "Tue\, 1 Sep 2009 22\:13\:53 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5F3ABC6E-9737-11DE-98E3-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127556>

Johannes Sixt <j6t@kdbg.org> writes:

> Moreover, keeping the unmerge entries at the top is inconvenient if a merge
> touched many files, but only a few conflicted: After the conflicts were
> resolved, the user will conduct a 'git add' command. In order to do that
> with copy-and-paste, the user must scroll the terminal window up, and must
> do so for each individual entry (because terminal windows commonly scroll
> down automatically on the paste operation to make the cursor visible).

I actually was expecting that you would move this at the very bottom after
untracked list for the above reason, and also because this part is only
shown while running status (that was a good point you made in the previous
message) and never in commit.

>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  wt-status.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/wt-status.c b/wt-status.c
> index 3395456..85f3fcb 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -561,8 +561,8 @@ void wt_status_print(struct wt_status *s)
>  		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
>  	}
>  
> -	wt_status_print_unmerged(s);
>  	wt_status_print_updated(s);
> +	wt_status_print_unmerged(s);
>  	wt_status_print_changed(s);
>  	if (s->submodule_summary)
>  		wt_status_print_submodule_summary(s);
> -- 
> 1.6.4.2.280.gb16ab
