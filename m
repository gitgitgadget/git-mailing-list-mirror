From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use system_path to find 'po'-dir to resolve relative
 paths
Date: Wed, 06 Jun 2012 11:28:52 -0700
Message-ID: <7v7gvkmh0b.fsf@alter.siamese.dyndns.org>
References: <1338987675-7388-1-git-send-email-vfr@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Wed Jun 06 20:29:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScKyt-0001FI-RU
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 20:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758093Ab2FFS3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 14:29:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39359 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758053Ab2FFS2z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 14:28:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6513A8F31;
	Wed,  6 Jun 2012 14:28:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0eevBZpuYtmfR/GHVjPPSKmOoR0=; b=BJIlVf
	g4bAlxFL4gb6nV0NP6EOA7uQdpJkhVAfmgOuzOAmrpRypC8amx8PS74FhI4C1eMy
	iTn0VnyknDor9S9sftDNEHsvsqQKt7rDlARhhCb+kZggfzeXBtf0x1X2zd/J7bIe
	2SF07SemwN3PawtYtvDSCOPxU69NdPK+5EOh0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RAkMMdqP7QaJ0rsOeY0SVoABBJZu4lqv
	Uq1b+x2K/vPU6Y/fQuwUux74UxVj0CXf3hajpMtJDB0CdNnO7v9BsmHR7GpFq58c
	K2Emao1xBO9yC+o16A5pSAW3hemvdqtPI68oPGM/GKnJBuHn/smayL0QyV4XlK7/
	ol5BP6yGXRQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 589E28F30;
	Wed,  6 Jun 2012 14:28:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B65DD8F2E; Wed,  6 Jun 2012
 14:28:53 -0400 (EDT)
In-Reply-To: <1338987675-7388-1-git-send-email-vfr@lyx.org> (Vincent van
 Ravesteijn's message of "Wed, 6 Jun 2012 13:01:15 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 784EB612-B005-11E1-B24E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199345>

Vincent van Ravesteijn <vfr@lyx.org> writes:

> If the specified path for the 'po'-files is a relative path and if
> RUNTIME_PREFIX is set, system_path must be used to resolve the directory relative to the executable.
>
> Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
> ---

Hrm, I'd prefer to see anything that involves RUNTIME_PREFIX first
tested in msysgit tree and then fed to me through them.

Thanks.

>  gettext.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/gettext.c b/gettext.c
> index f75bca7..632ccf8 100644
> --- a/gettext.c
> +++ b/gettext.c
> @@ -4,6 +4,7 @@
>  
>  #include "git-compat-util.h"
>  #include "gettext.h"
> +#include "exec_cmd.h"
>  
>  #ifndef NO_GETTEXT
>  #	include <locale.h>
> @@ -123,7 +124,7 @@ void git_setup_gettext(void)
>  
>  	if (!podir)
>  		podir = GIT_LOCALE_PATH;
> -	bindtextdomain("git", podir);
> +	bindtextdomain("git", system_path(podir));
>  	setlocale(LC_MESSAGES, "");
>  	init_gettext_charset("git");
>  	textdomain("git");
