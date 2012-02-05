From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Change include order in two compat/ files to avoid
 compiler warning
Date: Sun, 05 Feb 2012 12:41:08 -0800
Message-ID: <7vr4y9ggij.fsf@alter.siamese.dyndns.org>
References: <1328404107-15757-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Sun Feb 05 21:41:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ru8tf-0004pN-Mn
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 21:41:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066Ab2BEUlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 15:41:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61660 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751662Ab2BEUlK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 15:41:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3BCE527F;
	Sun,  5 Feb 2012 15:41:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ppLqX4G56gNlcrhJ+JOfei7oFaI=; b=Qdimxq
	mf+GnZUxpHY4fpZJAXGK/nhk7g/gCU3tcb2PsW8dCHDL/A0GIT8lF4YROZmI4NN5
	j3HrsuNvMh3NyvHL3LlujYm/6bArVrW7RRmvmhNXuxZLKiiKkmTafMMh/bcJXudt
	SHRG3JBDzBkuevfaVDA+AWSDQ+IuXLkT25OFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aClb0GQ7vyjd+55Qk+jw+gp21+U1pawj
	KTQulFMRzrz5ndzaGzI6vsiHHVy/qts5FsOXDX92XBFUhBKu5FaLZCOiZoI3K0Ny
	+H5x0H/jjIE6cpq22rxnEihHpwK3s+yZfXFu+u9W8q+ZtIsF8VR724EAgSIx4/iB
	wT4m3V7Y7Js=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC3E1527E;
	Sun,  5 Feb 2012 15:41:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 835DC527C; Sun,  5 Feb 2012
 15:41:09 -0500 (EST)
In-Reply-To: <1328404107-15757-1-git-send-email-bwalton@artsci.utoronto.ca>
 (Ben Walton's message of "Sat, 4 Feb 2012 20:08:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BC02C3A2-5039-11E1-80A4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189955>

Ben Walton <bwalton@artsci.utoronto.ca> writes:

> The inet_ntop and inet_pton compatibility wrapper source files
> included system headers before git-compat-utils.h.

Thanks, that is definitely a breakage.

> diff --git a/compat/inet_ntop.c b/compat/inet_ntop.c
> index 60b5a1d..f1bf81c 100644
> --- a/compat/inet_ntop.c
> +++ b/compat/inet_ntop.c
> @@ -15,11 +15,9 @@
>   * SOFTWARE.
>   */
>  
> +#include "../git-compat-util.h"
>  #include <errno.h>
>  #include <sys/types.h>
> -
> -#include "../git-compat-util.h"
> -
>  #include <stdio.h>
>  #include <string.h>

I actually have to wonder if any of these four inclusion of the system headers
are warranted. Wouldn't they be included as part of git-compat-util.h anyway?
