From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: Remove usage of deprecated Python "has_key"
 method
Date: Sun, 28 Mar 2010 09:38:54 -0700
Message-ID: <7vy6hc4d0h.fsf@alter.siamese.dyndns.org>
References: <1269737112-21631-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 28 18:39:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvvW5-0001MQ-OH
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 18:39:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754791Ab0C1QjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 12:39:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45062 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754506Ab0C1QjF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 12:39:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B23D8A68D9;
	Sun, 28 Mar 2010 12:39:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4bT+iSPxCLJ8VIoDe0jDh4K7Uig=; b=OZ4ko9
	uc5tITNlzi6VEhnPXBc4oKRXFryz5tvSzu8Om4cUbRuX3tfVLLszT56wlZ7ErvfJ
	4CU7Yzyt7QpLIIkoX4nd9uVca1U36WHxiTS34tAECU8mXHuEhgV0OvGEI/BrJ2h5
	NUWgU2OPPNiV2dX5Mn26wf523vR3HqXIGzY0k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P+OUn/w6RoI+DglEfkNer4f/QyDxc1Qz
	a9SA/KjBu1EuKRJIhSSM2rzcq2KTjJYA2Ja8N/Es2tm7nG71q2ETDesIG0UzoRr1
	4WB8YSpfyYW1Ur7JUWGApH6uGyAKjIvAi/Y8KH/l+iu1A2eIxxwqnLTwbZdQRZYO
	HDK6bQiPldw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 70C37A68D8;
	Sun, 28 Mar 2010 12:39:00 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A5F4CA68D7; Sun, 28 Mar
 2010 12:38:55 -0400 (EDT)
In-Reply-To: <1269737112-21631-1-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Sat\, 27 Mar 2010 17\:45\:12 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 697F6D56-3A88-11DF-8D31-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143400>

David Aguilar <davvid@gmail.com> writes:

> "has_key" is a deprecated dictionary method in Python 2.6+.
> Simplify the sys.path manipulation for installed scripts by
> passing a default value to os.getenv().

It looks like the old code was replacing sys.path[0] but you are
prepending this.  Doesn't that change also make a difference?

> SCRIPT_PYTHON is currently empty but this future-proofs us.
> It also fixes things for users who maintain local git forks
> with their own SCRIPT_PYTHON additions.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>  Makefile |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 3a6c6ea..806ccdf 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1609,9 +1609,8 @@ $(patsubst %.py,%,$(SCRIPT_PYTHON)): % : %.py
>  	    -e '}' \
>  	    -e 's|^import sys.*|&; \\\
>  	           import os; \\\
> -	           sys.path[0] = os.environ.has_key("GITPYTHONLIB") and \\\
> -	                         os.environ["GITPYTHONLIB"] or \\\
> -	                         "@@INSTLIBDIR@@"|' \
> +	           sys.path.insert(0, os.getenv("GITPYTHONLIB",\
> +	                                        "@@INSTLIBDIR@@"));|' \
>  	    -e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
>  	    $@.py >$@+ && \
>  	chmod +x $@+ && \
> -- 
> 1.7.0.3.291.g5e4f6
