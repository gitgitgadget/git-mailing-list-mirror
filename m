From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Make git selectively and conditionally ignore certain
 stat fields
Date: Mon, 14 Jan 2013 13:57:38 -0800
Message-ID: <7vmwwb8m25.fsf@alter.siamese.dyndns.org>
References: <50C0475F.1030206@viscovery.net>
 <1358197878-36736-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, j.sixt@viscovery.net
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 22:58:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tus2b-0003pB-8y
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 22:58:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756744Ab3ANV5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 16:57:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34040 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756633Ab3ANV5k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 16:57:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19342BA24;
	Mon, 14 Jan 2013 16:57:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rRtVhdhXLspl8AYnxl456hRPQ3Y=; b=CMA0M+
	da/lCQBbxp8GdXNRjIL3L4EwFy6oFCHiUFEdFRQ4HOOelly7ZbTv56mlMrYZ7pO+
	4VY91h/ldehevD47EH78hJjTgJAgBnD9N0qPpsC/XZjBJrWvUnUt1yeYYPaL2vhN
	c5yfB8CdR98Te2rq6/mKWC/njdm8Am7RoZEPM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xYhI+bKbd+nSO4QeK6aZds7zB+mWRQ4P
	5VHiBXe8vByVPFgbZAF9YZhO+zO2FPe5xD0ftTonoT8pt7wk9BrgOorItxn8T22j
	ZLpsPxsi3uYxYy31iyudv75g5Q3EaXJP7mt7Nn/zN7CWXI2whmE/QJMN+40IQVLJ
	lBo1GAFHP6w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D64BBA23;
	Mon, 14 Jan 2013 16:57:40 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F8F7BA22; Mon, 14 Jan 2013
 16:57:39 -0500 (EST)
In-Reply-To: <1358197878-36736-1-git-send-email-robin.rosenberg@dewire.com>
 (Robin Rosenberg's message of "Mon, 14 Jan 2013 22:11:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 69F47E78-5E95-11E2-A433-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213535>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> diff --git a/read-cache.c b/read-cache.c
> index fda78bc..f7fe15d 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -197,8 +197,9 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
>  	}
>  	if (ce->ce_mtime.sec != (unsigned int)st->st_mtime)
>  		changed |= MTIME_CHANGED;
> -	if (trust_ctime && ce->ce_ctime.sec != (unsigned int)st->st_ctime)
> -		changed |= CTIME_CHANGED;
> +	if ((trust_ctime || ((check_nonzero_stat&CHECK_NONZERO_STAT_CTIME) && ce->ce_ctime.sec)))

One SP is required on each side of a binary operator; please have
one after check_nonzero_stat and after the & after it.

I wonder if we should lose the trust_ctime variable and use this
check_nonzero_stat bitset exclusively, provided that this were a
good direction to go?
