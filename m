From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] push: Provide situational hints for non-fast-forward
 errors
Date: Mon, 19 Mar 2012 15:41:40 -0700
Message-ID: <7vwr6g8b8b.fsf@alter.siamese.dyndns.org>
References: <20120319074944.GA18489@democracyinaction.org>
 <7vbonsbepx.fsf@alter.siamese.dyndns.org> <20120319222225.GA36860@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, zbyszek@in.waw.pl,
	Matthieu.Moy@grenoble-inp.fr, drizzd@aon.at
To: Christopher Tiwald <christiwald@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 23:42:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9lH2-0004hS-Is
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 23:41:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001Ab2CSWlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 18:41:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50884 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932168Ab2CSWlm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 18:41:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15CA377EA;
	Mon, 19 Mar 2012 18:41:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x+ziF+S6bE/TGFcEtdkiWj302Bs=; b=lq2ERN
	jDQpBCmj5mu32oemmOBDhiRD3+McvZFaneugGYFT9ufpz+kS+YU7hQrrFjxL8sM8
	mnkC8BsITdfjMHfvpAtpGVToByMvwVCbLtBmseCD8EM78U18Z0aXpBLkGJxG/aka
	D8W8lAP3X7SLIdVkgutRwjExBjas7ZGNw7iKs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lUpwpx6dbbbOJy2IBvHsNXeBScSKvl9v
	DmcvoWybW9ZvOOeeWFj4zt0YuumP1ucit9kdsyc0r+s8jg2xTa6LzjJqc0Z/L22L
	f9TI8IvJuWAPPgmiMAeDY4quGJbGB6WAbDnBWfNifRl5e/3vPRWhZDDgYit1uHbQ
	nioxmsRAuYo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AFD077E9;
	Mon, 19 Mar 2012 18:41:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 972D077E8; Mon, 19 Mar 2012
 18:41:41 -0400 (EDT)
In-Reply-To: <20120319222225.GA36860@gmail.com> (Christopher Tiwald's message
 of "Mon, 19 Mar 2012 18:22:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B26E594E-7214-11E1-99C0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193470>

Christopher Tiwald <christiwald@gmail.com> writes:

> How about the something like the following fixup? This introduces two
> changes to v2:
>
> - It breaks the new advice into three config variables. Users
>   who might benefit from the advice can't accidentally shut a message
>   off before being confronted with the situation it's designed to
>   advise.
> - It leaves pushNonFastForward in place, and if a user sets
>   'advice.pushNonFastForward = false', it'll disable all three pieces
>   of advice.

Sounds good.

>  static void advise_pull_before_push(void)
>  {
> -	if (!advice_push_non_ff_current)
> +	if (!advice_push_non_ff_current | !advice_push_nonfastforward)

Bitwise or would work OK as long as both sides are !var, but is not
particularly a style.  Please replace all of these with "||".

Other than that, sounds sane to me.

Thanks.
