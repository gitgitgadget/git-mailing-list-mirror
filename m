From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] help: always suggest common-cmds if prefix of cmd
Date: Wed, 24 Nov 2010 20:49:37 -0800
Message-ID: <7vfwuqrori.fsf@alter.siamese.dyndns.org>
References: <AANLkTina0tnOEE2+17W03pFPqg37Btss0HYBeW+pOEgn@mail.gmail.com>
 <1290539473-2420-1-git-send-email-kusmabite@gmail.com>
 <7v1v6atsbd.fsf@alter.siamese.dyndns.org>
 <AANLkTi=nxcODCvQ6hmaQe=q38e=bF7cRHWrRaFr+zen6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	ziade.tarek@gmail.com
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Nov 25 05:50:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLTmj-0005w2-TV
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 05:50:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828Ab0KYEtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 23:49:53 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53300 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765Ab0KYEtw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 23:49:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 279362563;
	Wed, 24 Nov 2010 23:50:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hr+9gtuOxP1n/8zQ/Kvn7RABiUw=; b=M7sNfX
	WSIDhlrg5iAf6Gp1vDoqt4lRi4/JrxUtSh9Xuni+7qZSNzhgBJ3zE2hK5O1v5dKx
	pE9XkrZrt2E60QYBttZNxQw8LPCuK3BsxUBRBzmAf0VbmtLf3SVFuKOl+gBG01O7
	zS63WfXDvv7fdUP/Ppdtyvu7Ly1/ja7uVY/aE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BpyMGFTURTjrmGJyLlDkcm5MpRxkFXhQ
	9p03BgGEsFnzMx9oAQ7m4a3Z8E845TF/F/IOJ5I+xGezOnV0OlvsaAUM4HDuJIk/
	UFY/SWzjfkCQ2WTVe0FxS8q7iOoL5qwSzJf3g/ZQsSBdJ8NErdgdk/FPcxCjOON+
	I/GM48PT+pM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DA2C72562;
	Wed, 24 Nov 2010 23:50:00 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AE93F2560; Wed, 24 Nov 2010
 23:49:54 -0500 (EST)
In-Reply-To: <AANLkTi=nxcODCvQ6hmaQe=q38e=bF7cRHWrRaFr+zen6@mail.gmail.com>
 (Erik Faye-Lund's message of "Wed\, 24 Nov 2010 21\:20\:45 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 75E66696-F84F-11DF-B440-DF8536391E49-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162103>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> Indeed. What about this intra-diff? Hopefully it's a bit clearer, as
> it's closer to the original, just reusing the same logic for the new
> similar loop... Also makes the final diff smaller, which is nice.
>
> diff --git a/help.c b/help.c
> index dc76a62..d02a019 100644
> --- a/help.c
> +++ b/help.c
> @@ -339,11 +339,10 @@ const char *help_unknown_cmd(const char *cmd)
>  		die ("Uh oh. Your system reports no Git commands at all.");
>
>  	n = 0;
> -	do {
> -		best_similarity = main_cmds.names[n++]->len;
> -	} while (!best_similarity);
> -	n++;
> -	while (n < main_cmds.cnt && best_similarity >= main_cmds.names[n]->len)
> +	while (n < main_cmds.cnt && !main_cmds.names[n]->len)
> +		++n;
> +	best_similarity = main_cmds.names[n++]->len;
> +	while (n < main_cmds.cnt && best_similarity == main_cmds.names[n]->len)
>  		++n;

Perhaps, but it is probably more conventional to write this kind of loop with:

	for (n = 0; ...; n++)
		...

no?

>  	if (autocorrect && n == 1 && SIMILAR_ENOUGH(best_similarity)) {
>  		const char *assumed = main_cmds.names[0]->name;
