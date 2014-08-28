From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pretty: Provide a strict ISO8601 date format
Date: Thu, 28 Aug 2014 15:53:13 -0700
Message-ID: <xmqq61hc8bvq.fsf@gitster.dls.corp.google.com>
References: <1409248189-31409-1-git-send-email-bbolli@ewanet.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Beat Bolli <bbolli@ewanet.ch>
X-From: git-owner@vger.kernel.org Fri Aug 29 00:53:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN8ZM-0002Ee-6e
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 00:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161AbaH1WxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 18:53:24 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57808 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751454AbaH1WxX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 18:53:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E50C936D3B;
	Thu, 28 Aug 2014 18:53:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ASdTze+6S3xLdMF7S0jgVn34Etc=; b=Ab1UB2
	ytQxUeF5d9c5NAyZFJms7/7oOdl9Ioi9PbB2XLZ/4h/s5ikk3cjnX1NaTI1rqIOc
	hKGOsKMvfUWmEe61lx+83Og0/4W/L3uWdgTj+V7MNTaAL8laayEwXafVf9ZMrV+V
	MpOcPXYF6thumbVzy5LqVQMqkHC8h1Gy/dXs0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LtejRKvcYWzRYs4b4uULck6QlzjIMtqU
	U0KnNK9agusgiV/pEj0HVacsAJb0F3ba5/JvXa+AlC7pLxfjOhOvEHdNV6vhhA/k
	NInviUvBIwOzBNKL1aL1YTjNnxvMgN29GJBDd+SPa47LWCUY4KxKNKfJhvmrJobR
	2UQNG3pqwFs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DBA1236D3A;
	Thu, 28 Aug 2014 18:53:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CF0A136D2D;
	Thu, 28 Aug 2014 18:53:14 -0400 (EDT)
In-Reply-To: <1409248189-31409-1-git-send-email-bbolli@ewanet.ch> (Beat
	Bolli's message of "Thu, 28 Aug 2014 19:49:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1819677E-2F06-11E4-AC7B-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256131>

Beat Bolli <bbolli@ewanet.ch> writes:

> It uses the '%aI' and '%cI' format specifiers or the '--date=iso-strict'
> date format name.

OK.

>
> See http://article.gmane.org/gmane.comp.version-control.git/255879 for
> discussion.

Please think of a way to explain/justify your changes better before
forcing readers to go online.  In this case, I think what you wrote
in the updates to the documentation would serve as a good basis for
it (describe it backwards).

> +The differences to the strict ISO 8601 format are:
> +
> +	- a space instead of the `T` date/time delimiter
> +	- a space between time and time zone
> +	- no colon between hours and minutes of the time zone
> +
> ...
> -`--date=iso` (or `--date=iso8601`) shows timestamps in ISO 8601 format.
> +`--date=iso` (or `--date=iso8601`) shows timestamps in a ISO 8601-like format.

Should it be s/a ISO/an ISO/?

> +	else if (mode == DATE_ISO8601_STRICT)
> +		strbuf_addf(&timebuf, "%04d-%02d-%02dT%02d:%02d:%02d%+03d:%02d",
> +				tm->tm_year + 1900,
> +				tm->tm_mon + 1,
> +				tm->tm_mday,
> +				tm->tm_hour, tm->tm_min, tm->tm_sec,
> +				tz / 100, abs(tz % 100));

Wouldn't this misidentify a zone that is 30 minutes off of GMT,
i.e. tz == -30?  tz/100 would not be negative and "%+03d:" would
happily show "+00:", no?
