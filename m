From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 04/13] refactor parse_loc
Date: Mon, 12 Jul 2010 11:32:18 -0700
Message-ID: <7vk4p0blfx.fsf@alter.siamese.dyndns.org>
References: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com>
 <1278829141-11900-4-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 12 20:32:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYNnr-0004Fz-RI
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 20:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756388Ab0GLSc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 14:32:27 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45924 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753258Ab0GLSc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 14:32:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1844BC32DA;
	Mon, 12 Jul 2010 14:32:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=oGMs9aixjhP8OeTbqHieXCR6Wnw=; b=HkgOW5mNz0pB+1ckYVybX0p
	eoKIqoL9S2JegO64qoELj2Eg4KJQh3wxrFRNHf5IA1T8tPVDb2NOfGQPbRxfXoja
	pRNG/Lvbdpquc4D6PwRShWUdAsfJqLMVC0ni9x9TRfhOcs7IcAph8JIThLUWJN5s
	AYymNkbluMt/2ujGXiIA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=vhVZ+UeBvxz4HQLS+p49ceoGG9/q1DNte4N9oJBuniatxQeiI
	tSRtlm5KcuJIsNhCyUs9babQx0fdUG81fbkrmnAEw2zEbhrvMozlivo2KNTzfBak
	2+dDzxXYwtKe9set3icN+CL63yRaNJyKftPMlHUxYu+ImFu6naxQT0Y2Ps=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E80A8C32D4;
	Mon, 12 Jul 2010 14:32:22 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 40746C32D2; Mon, 12 Jul
 2010 14:32:20 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CFE276E8-8DE3-11DF-957C-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150838>

Bo Yang <struggleyb.nku@gmail.com> writes:

> Both 'git blame -L' and 'git log -L' parse the same style
> of line number arguments, so put the 'parse_loc' function
> to line.c and export it.

> The caller of parse_loc should provide a callback function
> which is used to calculate the nth line start position.

"the start position of the nth line"?

> Other parts such as regexp search, line number parsing are
> abstracted and re-used.
>
> Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
> ---
>  builtin/blame.c |   89 +++++-------------------------------------------------
>  line.c          |   35 ++++++++++++---------
>  line.h          |    5 +++
>  3 files changed, 34 insertions(+), 95 deletions(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 01e62fd..17b71cd 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -21,6 +21,7 @@

Nice code reduction.  The abstraction feels right (but I didn't read it
very carefully).
