From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 2/8] push: add advice for rejected tag reference
Date: Sun, 02 Dec 2012 02:42:00 -0800
Message-ID: <7vmwxwka6f.fsf@alter.siamese.dyndns.org>
References: <1354239700-3325-1-git-send-email-chris@rorvick.com>
 <1354239700-3325-3-git-send-email-chris@rorvick.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 11:42:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tf70B-0008VA-Bd
	for gcvg-git-2@plane.gmane.org; Sun, 02 Dec 2012 11:42:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266Ab2LBKmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2012 05:42:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47441 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752542Ab2LBKmF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2012 05:42:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7040B6660;
	Sun,  2 Dec 2012 05:42:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=NkHvJKga4Stw40W0rfoaq+Zsh6U=; b=x0yLpZBXHuTcsnoTd+cC
	Se6P7qaFy7CgGf0qwjDnU5EoaQAhku4aPjB3zrnS/5MY1y9s0koLiYBiKKldpWF0
	9l6LttUrX4EMe0QSVFZNG8TAg23XWfNow6IZIfcrPU9csMCDMJZpO6RrNbo8hIva
	MAQ5jtzSBD6TIW456wIuSQU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=W34QzAkuVDm2rgICJeW7qwQUrj3aZwOf7l4LcmadAGs3sJ
	WQe3vw+I8MmkhBay28jsTw/e51k7x7x/SYmw/cbetx+JgKff9W1iyjIMfjcMEAOG
	Z1mNtDQfApX/csPaJy5RAiBFeMNcT0NRUfm8CDCyZMAJXTIX2W9bgqd6LBwhE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21302665F;
	Sun,  2 Dec 2012 05:42:03 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64D76665E; Sun,  2 Dec 2012
 05:42:02 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E8359ACE-3C6C-11E2-8307-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211010>

Chris Rorvick <chris@rorvick.com> writes:

>  static void advise_pull_before_push(void)
>  {
>  	if (!advice_push_non_ff_current || !advice_push_nonfastforward)
> @@ -241,6 +245,11 @@ static void advise_checkout_pull_push(void)
>  	advise(_(message_advice_checkout_pull_push));
>  }
>  
> +static void advise_ref_already_exists(void)
> +{
> +	advise(_(message_advice_ref_already_exists));
> +}
> +
>  static int push_with_options(struct transport *transport, int flags)
>  {
>  	int err;
> @@ -272,6 +281,8 @@ static int push_with_options(struct transport *transport, int flags)
>  			advise_use_upstream();
>  		else
>  			advise_checkout_pull_push();
> +	} else if (reject_reasons & REJECT_ALREADY_EXISTS) {
> +		advise_ref_already_exists();
>  	}

The existing advise_* functions that are called from this function
honor the advice.* configuration, and advise_ref_already_exists()
would want to follow suit here (it is OK to do so as a follow-up
patch without further rerolling the entire series).

Thanks.
