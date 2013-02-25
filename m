From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Fix unsigned time_t comparison
Date: Mon, 25 Feb 2013 14:27:54 -0800
Message-ID: <7vmwusni51.fsf@alter.siamese.dyndns.org>
References: <CAHXAxrMZODO07_dPep-yKgrzD1228iSMGUXX06xkKDmoZF4+qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Gorchak <mike.gorchak.qnx@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 23:28:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA6X8-0004XC-8L
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 23:28:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932964Ab3BYW16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 17:27:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48032 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932269Ab3BYW14 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 17:27:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B5EBB820;
	Mon, 25 Feb 2013 17:27:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kLhsOv59oSxwDnL51c8ozm3hYGY=; b=oHuNsX
	pX5KYKS3RLvJoPAMye8ro4KrlP0ttoBXhlfTcBxrkpudKJCJYEyxDHZw3AZyCKH2
	2ZTVpLw7EuCSH6b+bb6Pi7apOxZP5iX9tGIJtBos2kJJ/ff7QUYKu2exkjFMmJZ+
	G3tdzcDdIT7lUPVfcwyYeV/PUtLjx69ioJDpg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UG5TO6sta4zIBBhgdiGpUMdVYDMHAIDi
	GlzG2hYflivaLTcmF/1i1zOe03fSJ6tYwPkEM/3Qrgyto/fpYry76oFaCJg1Zisn
	QAZxf3ErcUOtQfgLMv5uoklnmdECw1e0xEOYLx9xELDLMW/eVgoH/hUGpBFmuWe/
	VVzlAfkLHv0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2195DB81F;
	Mon, 25 Feb 2013 17:27:56 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 873E4B81D; Mon, 25 Feb 2013
 17:27:55 -0500 (EST)
In-Reply-To: <CAHXAxrMZODO07_dPep-yKgrzD1228iSMGUXX06xkKDmoZF4+qA@mail.gmail.com> (Mike
 Gorchak's message of "Mon, 25 Feb 2013 23:51:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 99BE548C-7F9A-11E2-AB79-F3C82E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217114>

Mike Gorchak <mike.gorchak.qnx@gmail.com> writes:

> Do not compare time_t (less comparison) with -1. If time_t
> is unsigned this leads to always true comparison.
>
> Signed-off-by: Mike Gorchak <mike.gorchak.qnx@gmail.com>
> ---
>  date.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/date.c b/date.c
> index 57331ed..1ac28e5 100644
> --- a/date.c
> +++ b/date.c
> @@ -383,7 +383,7 @@ static int is_date(int year, int month, int day,
> struct tm *now_tm, time_t now,

Line-wrapped.  Will manually fix while applying.

Thanks.

>  		 * sense to specify timestamp way into the future.  Make
>  		 * sure it is not later than ten days from now...
>  		 */
> -		if (now + 10*24*3600 < specified)
> +		if ((specified != -1) && (now + 10*24*3600 < specified))
>  			return 0;
>  		tm->tm_mon = r->tm_mon;
>  		tm->tm_mday = r->tm_mday;
