From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow building with xmlparse.h
Date: Mon, 11 Feb 2013 14:11:16 -0800
Message-ID: <7vy5eujybf.fsf@alter.siamese.dyndns.org>
References: <20130211212411.GA19113@ftbfs.org>
 <1360620225-19587-1-git-send-email-kraai@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Matt Kraai <matt.kraai@amo.abbott.com>
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 23:11:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U51bD-0000Y2-Bp
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 23:11:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932677Ab3BKWLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 17:11:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35738 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932482Ab3BKWLT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 17:11:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88C19BD86;
	Mon, 11 Feb 2013 17:11:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TtZlQNFCEFZNubXq/vDTWK8mZPg=; b=crnqfs
	xr4ewamzt6pPPRKabSdOzrr2AsC11qKJVzk6pnX/lZUlrhbT1UcTQt+x033RsgU3
	YDyImAZxHvwz+YX4DLNHSbNo6Fugs6YHq6Kf3CVgClTqiOzQIx5O5w3epuilNayJ
	OHwhuTUccDiMEftXLphSzjwg4I9jOMZ7/pchc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x0EGhX9RnR6kOj8NYiQwTnMEyisXN5Vs
	T7Hj8P76aSNR4LpMpTj1Q/iA5u4u//g5upDR+sRxZ/PpnboyShVmQdv6CKv8XlZ/
	V572C0hEx75+oqrVFGkXGvNHYWYQFbxg0Z+qTiD7EcZgooVlpLfpUxGJHxvtyESG
	+5zekS+uyjI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D195BD85;
	Mon, 11 Feb 2013 17:11:18 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 022CABD82; Mon, 11 Feb 2013
 17:11:17 -0500 (EST)
In-Reply-To: <1360620225-19587-1-git-send-email-kraai@ftbfs.org> (Matt
 Kraai's message of "Mon, 11 Feb 2013 14:03:45 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F560C166-7497-11E2-BF89-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216100>

Matt Kraai <kraai@ftbfs.org> writes:

> From: Matt Kraai <matt.kraai@amo.abbott.com>
>
> expat 1.1 and 1.2 provide xmlparse.h instead of expat.h.  Include the
> former on systems that define the EXPAT_NEEDS_XMLPARSE_H variable and
> define that variable on QNX systems, which ship with expat 1.1.
>
> Signed-off-by: Matt Kraai <matt.kraai@amo.abbott.com>
> ---
> ...
> diff --git a/http-push.c b/http-push.c
> index 9923441..7202e2d 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -11,7 +11,11 @@
>  #include "list-objects.h"
>  #include "sigchain.h"
>  
> +#ifndef EXPAT_NEEDS_XMLPARSE_H
>  #include <expat.h>
> +#else
> +#include <xmlparse.h>
> +#endif

Thanks for a quick re-roll.

Is it just me who finds the above hard to read and find the below
much more natural?

	#ifdef NEEDS_FOO_H
        #include <foo.h>
        #else
        #include <bar.h>
        #endif
