From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-path-utils: use xsnprintf in favor of strcpy
Date: Mon, 08 Feb 2016 14:41:51 -0800
Message-ID: <xmqqh9hi6d00.fsf@gitster.mtv.corp.google.com>
References: <20160208222155.GA17395@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 08 23:41:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSuVK-0001pz-BG
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 23:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756905AbcBHWly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 17:41:54 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64603 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756613AbcBHWlx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 17:41:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 575C842538;
	Mon,  8 Feb 2016 17:41:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EhqCBoPEor/CRxQgb9C7uVLck7Q=; b=DvRgHi
	9OoK9X30okFhIurspLokhJgwavNaVhJvofOI59QQgxcwY+qI14PeLZH47vGKqz7e
	RTqJMEYa6C5VKCr4lfjpG6lmx6tl7I7y1pBTDfsG9FhbHHz8G7+kOhDsSRaknpan
	+6SDh1rqvwcppBhyXkKyC1DG8dzHew/mqMycQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qSJ43B0doYGa+Pjnq8GjVZiBEjOCLEW9
	OUB/CyIblFLXU7wv368c6yEQHLkZr7+NBUfNBviRdsBk3X+OK/mwLkyKiQ5riUj2
	2N8fYAr2mYyl0/uVDJ8hnY7mu6efOzJUzXI9oCMvr1QGCJ9cgCZn0bt/vZvfGqks
	1eF80uUo1H8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4F9E242537;
	Mon,  8 Feb 2016 17:41:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C970F42535;
	Mon,  8 Feb 2016 17:41:52 -0500 (EST)
In-Reply-To: <20160208222155.GA17395@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 8 Feb 2016 17:21:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 261ACACA-CEB5-11E5-A4B4-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285820>

Jeff King <peff@peff.net> writes:

> This strcpy will never overflow because it's copying from
> baked-in test data. But we would prefer to avoid strcpy
> entirely, as it makes it harder to audit for real security
> bugs.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Repost of <20160114202608.GA8806@sigill.intra.peff.net> from a few weeks
> ago (sorry, gmane is down so I can't generate a link). I think the
> original was never applied because the topic that introduced the strcpy
> (js/dirname-basename) predated xsnprintf, so there was some merging
> complexity. Now that topic is in master, so this can be applied there.

Thanks.  This kind of considerate "holding it off for a few weeks"
helps things a lot.

>
>  test-path-utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/test-path-utils.c b/test-path-utils.c
> index c3adcd8..6232dfe 100644
> --- a/test-path-utils.c
> +++ b/test-path-utils.c
> @@ -56,7 +56,7 @@ static int test_function(struct test_data *data, char *(*func)(char *input),
>  		if (!data[i].from)
>  			to = func(NULL);
>  		else {
> -			strcpy(buffer, data[i].from);
> +			xsnprintf(buffer, sizeof(buffer), "%s", data[i].from);
>  			to = func(buffer);
>  		}
>  		if (!strcmp(to, data[i].to))
