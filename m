From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] fast-import: initialize variable
 require_explicit_termination
Date: Fri, 26 Aug 2011 10:51:28 -0700
Message-ID: <7v8vqgdpsv.fsf@alter.siamese.dyndns.org>
References: <1314378689-8997-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Aug 26 19:51:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qx0Z5-0001iO-Sp
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 19:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070Ab1HZRvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 13:51:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43112 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365Ab1HZRvb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 13:51:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74FBD46DC;
	Fri, 26 Aug 2011 13:51:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k/8TBfUdZJD/5ylyLNmzgXRSRQg=; b=Dl4q19
	Tiu8+ZiKoLERDnb2z6ZUW2Gy2NxcxTI4AHVXpOpWPdlN/xcfebLMWywjzNekqJ/H
	rLX+NfK0p461WcvHKjBDv506bYZHHpsG2EjdA33xR4K/9aC5V+kJcDHMxQx9lmAm
	SSb714PKuxIrqD2fvIr0VCj9BP24SQzyf+lYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tRPLxmvStPuzzfRpB8GLeHUKabbOkAJB
	73y79Km81UY5jiPQ+xq6/RIHAfqJKBMAVQILV++mLeM9zvYX1yRCeMM4fONjbtDE
	o9yuPSBDFobqhTvqX09lrrMeQhVi883nC60zPEsEF21ZXE3jDw7Mggjg+Cafr/Ff
	woaMkYiGBGw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D58646DB;
	Fri, 26 Aug 2011 13:51:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F338A46DA; Fri, 26 Aug 2011
 13:51:29 -0400 (EDT)
In-Reply-To: <1314378689-8997-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Fri, 26 Aug 2011 19:11:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0732B4D0-D00C-11E0-9416-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180184>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> The uninitialized variable seems harmless in practice, but let's still be clean.

It is not "in practice", but by definition, file scope "static int"
variables are initialized to 0 by the C language (a typical implementation
achieves this by placing the variable in BSS section).

Please do not write unnecessary " = 0" there.

>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> For some reason, remote helpers seem to be forced to use the "done"
> command now. Investing why, I found this, but that wasn't what I was
> looking for.
>
>  fast-import.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/fast-import.c b/fast-import.c
> index 7cc2262..ed8f3cd 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -355,7 +355,7 @@ static unsigned int cmd_save = 100;
>  static uintmax_t next_mark;
>  static struct strbuf new_data = STRBUF_INIT;
>  static int seen_data_command;
> -static int require_explicit_termination;
> +static int require_explicit_termination = 0;
>  
>  /* Signal handling */
>  static volatile sig_atomic_t checkpoint_requested;
