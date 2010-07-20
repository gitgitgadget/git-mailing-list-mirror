From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Add -e/--exclude to git-clean.
Date: Tue, 20 Jul 2010 13:27:07 -0700
Message-ID: <7vr5ixlx0k.fsf@alter.siamese.dyndns.org>
References: <cover.1279654370.git.jaredhance@gmail.com>
 <8f454efeb3aa4acd0e0c420b197d0269dc53db34.1279654370.git.jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 20 22:27:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObJPO-0001oM-4O
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 22:27:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761493Ab0GTU1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 16:27:16 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44559 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758627Ab0GTU1P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 16:27:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 78437C62CE;
	Tue, 20 Jul 2010 16:27:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MmRAw5TolnnV/WoA+5c33jDtT0I=; b=LKQ1si
	sudX2eVcPWv+yhP+O3GpKG/WK49QjPrAyHMJkUUu7ALRPtRuedsL4aBKjVfkI/TZ
	x8df41lUIXh5e7KGoHG9P9h7jXTpUwkrg9EWQ1dpzfi+bYdrbBGdlrprUlTCPFVp
	FyTY0gDiHR2usYvUqZnFG0aoLusfbs4cvJz6s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AyJIw1yhk2EF0UhoBDQHcv/MTuI0cFfi
	xuZ8uy2ScNI5/JQCtJeMmzKkHoRJdHnUOZTdNcJwDuSU8GugaP5XDr8InM64euFw
	yaLlh/wJgOioSeLlRtkLMcVWMyTmD0ASF0hLOFTwAheumCslqZzM41LbrSxhHkYg
	oiLXmbZ0gWQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F86EC62CC;
	Tue, 20 Jul 2010 16:27:12 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2432FC62CA; Tue, 20 Jul
 2010 16:27:08 -0400 (EDT)
In-Reply-To: <8f454efeb3aa4acd0e0c420b197d0269dc53db34.1279654370.git.jaredhance@gmail.com> (Jared Hance's message of "Tue\, 20 Jul 2010 15\:35\:56 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2D7E5D94-943D-11DF-AD68-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151362>

Jared Hance <jaredhance@gmail.com> writes:

> With the -e/--exclude option for git-clean, a user can specify files
> that they haven't yet told git about, but either need for a short amount
> of time or plan to tell git about them later. This allows one to still
> use git-clean while these files are around without losing data.
>
> Signed-off-by: Jared Hance <jaredhance@gmail.com>

Thanks.

> +static int exclude_cb(const struct option *opt, const char *arg, int unset)
> +{
> +	struct string_list *exclude_list = (struct string_list *)opt->value;

Unnecessary cast, as opt->value is of type (void *).

> @@ -36,6 +44,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  	struct dir_struct dir;
>  	static const char **pathspec;
>  	struct strbuf buf = STRBUF_INIT;
> +	struct string_list exclude_list = { NULL, 0, 0, 0 };

Mental note to myself.  We should convert this to use STRING_LIST_INIT
after the next release when Thiago's patch graduates to 'master'.
