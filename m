From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] check_ref_format(): tighten refname rules
Date: Sat, 21 Mar 2009 16:15:12 -0700
Message-ID: <7vwsaibh8f.fsf@gitster.siamese.dyndns.org>
References: <1237673619-12608-1-git-send-email-gitster@pobox.com>
 <1237673619-12608-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 22 00:16:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlAQr-0006Di-NU
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 00:16:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992AbZCUXPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 19:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753825AbZCUXPS
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 19:15:18 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59800 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbZCUXPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 19:15:16 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 917A185F5;
	Sat, 21 Mar 2009 19:15:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 09C1185F4; Sat,
 21 Mar 2009 19:15:13 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 22ECFD0C-166E-11DE-BCDE-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114092>

Junio C Hamano <gitster@pobox.com> writes:

> diff --git a/refs.c b/refs.c
> index 8d3c502..abd5623 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -717,19 +717,23 @@ int check_ref_format(const char *ref)
>  				return CHECK_REF_FORMAT_ERROR;
>  		}
>  
> +		last = ch;
>  		/* scan the rest of the path component */
>  		while ((ch = *cp++) != 0) {
>  			bad_type = bad_ref_char(ch);
> -			if (bad_type) {
> +			if (bad_type)
>  				return CHECK_REF_FORMAT_ERROR;
> -			}
>  			if (ch == '/')
>  				break;
> -			if (ch == '.' && *cp == '.')
> +			if (last == '.' && ch == '.')
> +				return CHECK_REF_FORMAT_ERROR;
> +			if (last == '@' && ch == '{')
>  				return CHECK_REF_FORMAT_ERROR;

Oops; here I need:

+			last = ch;

here.

>  		}
