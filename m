From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] MSVC: added missing include so `make INLINE=__inline` is no longer required
Date: Thu, 27 Mar 2014 09:49:18 -0700
Message-ID: <xmqqzjkbegdt.fsf@gitster.dls.corp.google.com>
References: <1395905668-32005-1-git-send-email-marat@slonopotamus.org>
	<1395905668-32005-2-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Thu Mar 27 17:49:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTDUd-0004T8-Lc
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 17:49:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755098AbaC0QtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 12:49:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62346 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754902AbaC0QtW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 12:49:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDA11758A3;
	Thu, 27 Mar 2014 12:49:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WarhpOEZK4/hfGgTyEAYU0AP2FI=; b=HJjVQc
	dHLMtqM9FHdiDnGHTvxQt1XZusHFi9t7q6JVS0DTDvjzZAfXT6lGAgSSKbMKz/Jg
	3Mlr8KVP1Cw32Tlwc/yWHrzcbEjJ2h3FAC4hxGvqNjOiSTLIaDqW1PCk/w26mg5c
	xTUDPxXhJkdbSEKHObTThaLDnNhQkuloQtXG8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CsP31prFrWH+zN2cn6FFfJZWGjpLpdOk
	bF2SFr7uwMCCavpFJ6hY5vVdhn/eAmMXll7ZDuvd7yLWXcm4z7u0TM7ArGKutzzX
	mODdw8b08JUavYlNQAki8yRPGVRfo1jz02LyWPXskejDlQozDOZYUMvNcPIqsPY6
	/BzKzBiJRLo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B05A6758A2;
	Thu, 27 Mar 2014 12:49:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D0F567588D;
	Thu, 27 Mar 2014 12:49:19 -0400 (EDT)
In-Reply-To: <1395905668-32005-2-git-send-email-marat@slonopotamus.org> (Marat
	Radchenko's message of "Thu, 27 Mar 2014 11:34:28 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BDD0AC3C-B5CF-11E3-99D0-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245293>

Marat Radchenko <marat@slonopotamus.org> writes:

> Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
> ---
>  xdiff/xutils.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/xdiff/xutils.c b/xdiff/xutils.c
> index 62cb23d..a21a835 100644
> --- a/xdiff/xutils.c
> +++ b/xdiff/xutils.c
> @@ -23,6 +23,7 @@
>  #include <limits.h>
>  #include <assert.h>
>  #include "xinclude.h"
> +#include "git-compat-util.h"

This is unfortunate for a few reasons:

 - xdiff/* is a borrowed code; we do not want to have (or add more)
   dependencies on the rest of Git, including compat-util.

 - When a piece of our code needs our compatibility support,
   compat-util must be the first header file included (either
   directly, or indirectly by including another header file that
   includes it at the top).

My gut feeling is that adding a mechanism to add -DINLINE=__inline
only on MSVC to the top-level Makefile, without touching this file,
may be a much more palatable.

I dunno.
