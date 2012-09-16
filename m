From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] Import wildmatch from rsync
Date: Sat, 15 Sep 2012 23:49:02 -0700
Message-ID: <7v627ezcm9.fsf@alter.siamese.dyndns.org>
References: <1347710524-15404-1-git-send-email-pclouds@gmail.com>
 <1347710524-15404-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 08:50:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TD8g4-0005yG-FW
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 08:50:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147Ab2IPGtH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Sep 2012 02:49:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49915 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750845Ab2IPGtF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Sep 2012 02:49:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7A9F65BA;
	Sun, 16 Sep 2012 02:49:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=qOFgh259t4GJ
	jhridxKrVQaZ4Pc=; b=RqIF/BkLclLy0qi1qTxwtQvqNM+LCgNFvYygszYHhAKr
	dIi1O88+mbwQYkjZA0QhjIK+F5Y70mWxiV636ZXS1GvMwQo/Pj6YIczQVd6rhejl
	0Il7SsfuPISBTvY1REr0Fveq1YJVt8q70O0tia/G8RXIdKsJIVPsm2K87EGKLaU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=yFLS2l
	DdUQtv2b/wjUXn2RwITxMpMIcAoYO70LRi/mhaGLIFAjKOtGW3optvvh8Np1YyN8
	0hJkz5gBU+/4ea2WlH8oC3nluD3djQlOXn1VaCMW+tJWfCYr6fFt64hpWFPOUKI3
	hDokwOJhGt8NG7nxdzwsU3WEy4b6bmTPpqR0k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D53F665B9;
	Sun, 16 Sep 2012 02:49:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3AA3065B7; Sun, 16 Sep 2012
 02:49:04 -0400 (EDT)
In-Reply-To: <1347710524-15404-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 15 Sep
 2012 19:02:00 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9ABE6DC2-FFCA-11E1-8529-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205596>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> These files are from rsync.git commit
> d51a3adb4fca3e6b1b046c6e570828f3bca8fe36. The commit is GPL-3. Howeve=
r
> wildmatch.[ch] have not changed since rsync turned to GPL-3.

I'd like see the last version of rsync that was GPLv2 hunted down
and the copy from that version lifted from it.  If you _know_ they
are identical, then you should be able to do that, no?

>  compat/wildmatch.c             | 368 +++++++++++++++++++++++++++++++=
++++++++++
>  compat/wildmatch.h             |   6 +

As this will be linked on all platforms, it shouldn't be in compat/
directory.  Unlike xdiff/ that has many files, this can live at the
top-level, just like kwset we borrowed from GNU grep does.

> diff --git a/compat/wildmatch.c b/compat/wildmatch.c
> new file mode 100644
> index 0000000..f3a1731
> --- /dev/null
> +++ b/compat/wildmatch.c
> @@ -0,0 +1,368 @@
> +/*
> +**  Do shell-style pattern matching for ?, \, [], and * characters.
> +**  It is 8bit clean.
> +**
> +**  Written by Rich $alz, mirror!rs, Wed Nov 26 19:03:17 EST 1986.
> +**  Rich $alz is now <rsalz@bbn.com>.
> +**
> +**  Modified by Wayne Davison to special-case '/' matching, to make =
'**'
> +**  work differently than '*', and to fix the character-class code.
> +*/
> +
> +#include "rsync.h"

Huh???

Ahh.  The approach you took is "This patch imports the pristine copy
to make it easier to verify the provenance, and the plan is to make
it usable with separate follow-up patches.", I agree that is a very
sensible thing to do.

But please say so in the commit log message.
