From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/14] cache.h: add comments for git_path() and
 git_path_submodule()
Date: Thu, 13 Oct 2011 11:37:00 -0700
Message-ID: <7vvcrs4u2b.fsf@alter.siamese.dyndns.org>
References: <1318492715-5931-1-git-send-email-mhagger@alum.mit.edu>
 <1318492715-5931-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Oct 13 20:37:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REQ9w-0006ng-V2
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 20:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900Ab1JMShI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 14:37:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61972 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751723Ab1JMShH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 14:37:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30F5F3184;
	Thu, 13 Oct 2011 14:37:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y0RnnNSAPSWHrdDeRki3bJXdYY8=; b=KyhVVS
	Kf12ZoPmZWqUhCj0TYgkyQYfMswjU8VIml6jUzbT+dQk2Cwz7T/Lu7SSZCWnLBYt
	69dMjmsYmmjw3N2/gj4NgFl+Tw/f1L5DEFa+1vBzXO65829As/oKxanoztlph0gO
	7Ombll8Ic04ErvafJum7vcKvGjESaz2Okm8w8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SWYJTS6nyFU+VyUNwjPOMZKPPGWi/qdL
	nXC94TGwUFOdTSuj3AMlxHFkdKQHNlzXjoh2M+5mleNix25JaKRjF8+wtVKywfRV
	mYcxPJz4kuLpxvUOZQa+PkmizwWQusvYTbF4+fGhAFL7GabsBsnJfZrZDWF88Vw8
	q5nks139834=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 286243183;
	Thu, 13 Oct 2011 14:37:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC71D3182; Thu, 13 Oct 2011
 14:37:01 -0400 (EDT)
In-Reply-To: <1318492715-5931-2-git-send-email-mhagger@alum.mit.edu>
 (mhagger@alum.mit.edu's message of "Thu, 13 Oct 2011 09:58:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 574523A2-F5CA-11E0-A8D8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183508>

mhagger@alum.mit.edu writes:

> +
> +/*
> + * Return the path of a file within get_git_dir().  The arguments
> + * should be printf-like arguments that produce the filename relative
> + * to get_git_dir().  Return the resulting path, or "/bad-path/" if
> + * there is an error.
> + */
>  extern char *git_path(const char *fmt, ...) __attribute__((format (printf, 1, 2)));

Ok.

> +/*
> + * Return the path of a file within the submodule located at path.

This is confusing. Does this "file within the submodule" refer to files
like "Makefile" tracked in a submodule at "dir"?  Your description for
git_path() above makes it clear that the function is about files like
"index" and "HEAD" that are part of the control information for the
current project, but the above gives an impression that you are talking
about files in the working tree of the submodule.

> + * The other arguments should be printf-like arguments that produce
> + * the filename relative to "<path>/.git".  If "<path>/.git" is a

And the reader is puzzled by the sudden mention of <path>/.git here.

> + * gitlink file, follow it to find the actual submodule git path.
> + * Return the resulting path, or "/bad-path/" if there is an error.
> + */
>  extern char *git_path_submodule(const char *path, const char *fmt, ...)
>  	__attribute__((format (printf, 2, 3)));
