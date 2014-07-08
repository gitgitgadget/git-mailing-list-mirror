From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] use new config API for worktree configurations of submodules
Date: Tue, 08 Jul 2014 13:14:20 -0700
Message-ID: <xmqqy4w38v6r.fsf@gitster.dls.corp.google.com>
References: <20140628095800.GA89729@book.hvoigt.net>
	<20140628100321.GD89729@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, "W. Trevor King" <wking@tremily.us>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Jul 08 22:14:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4bma-0005Ln-I7
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 22:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbaGHUO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 16:14:28 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54679 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754334AbaGHUO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 16:14:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E05B327EF9;
	Tue,  8 Jul 2014 16:14:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qwbD9MmOtCgs74l6MN2RHB/bqHM=; b=ICBcb6
	lTFdFwHPXMJZFN9Qv0bB8YK5CesCCRmDhaHfLaGO/QcZSZn1Sqwtrjkm7SuFGrHb
	qHevXfnyUxYSkBpvpmMS+ViHrjnFJ2L5s0plZBrR+CogaZcaJJIHB8nDnPzoIa/v
	UeWjDiH2PXRFrbVI9JGDSbr0f/R0qPK3s4hYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z6c1kjol8WzQGX8iP5sslJNzq7L7bgff
	p3LRgOivBjJSn2TVmVncsl6cf+21gVuf+0jW3nsx2n0og80Prxi1LfxquvkbDhLv
	FOa9d/CU8w8vNiBRbQcXEvcKAQro78Vg1ahCuR7O+uMx6Jr/Sp85m9P6DC1xqcWi
	oUYTEKs9h9s=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D27A627EF8;
	Tue,  8 Jul 2014 16:14:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 94BDC27EF1;
	Tue,  8 Jul 2014 16:14:06 -0400 (EDT)
In-Reply-To: <20140628100321.GD89729@book.hvoigt.net> (Heiko Voigt's message
	of "Sat, 28 Jun 2014 12:03:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 69E09084-06DC-11E4-AA09-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253042>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 07cf555..03ea20d 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -18,6 +18,7 @@
>  #include "xdiff-interface.h"
>  #include "ll-merge.h"
>  #include "resolve-undo.h"
> +#include "submodule-config.h"
>  #include "submodule.h"
>  #include "argv-array.h"
>  

Hmph.  What is this change about?  

Nobody in checkout.c needs anything new, yet we add a new include?

> diff --git a/diff.c b/diff.c
> index f72769a..f692a3c 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -13,6 +13,7 @@
>  #include "utf8.h"
>  #include "userdiff.h"
>  #include "sigchain.h"
> +#include "submodule-config.h"
>  #include "submodule.h"
>  #include "ll-merge.h"
>  #include "string-list.h"

Likewise.

It is somewhat unclear to me what real change that improves the life
of end-users this series brings to us.   The "test-submodule-config"
test program obviously is new but that does not really count until
we see real uses.
