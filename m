From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] read_revisions_from_stdin: make copies for
 handle_revision_arg
Date: Tue, 16 Apr 2013 11:17:55 -0700
Message-ID: <7vzjwyl4q4.fsf@alter.siamese.dyndns.org>
References: <516C4FB6.8060703@gmail.com>
 <c68f7df5367d254360ddf184fa1eaf6b8c3bef18.1366106134.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@suse.cz>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	<git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Apr 16 20:18:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USASA-00012d-Rt
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 20:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753349Ab3DPSR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 14:17:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39822 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752550Ab3DPSR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 14:17:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A622317396;
	Tue, 16 Apr 2013 18:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kX9qV2ishcbZLoRHH2q+elZapVg=; b=rUjNzy
	s+WOVgPpeqziu0GhlpHa6qtcwbMIXkYHUpIprLl7bkbTdmuBz/IyJUgIi+LUGgle
	jY3y7yNf9RPdZJmasaG7WJKQ28fpfmtwXogFgCh9cEVApnl9s8aw9iaDYrPKQEnV
	qiumQH9DqV2JsnRn0b0M8NneBYQwh5Khbj4z8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d8lms9DcnRqFndgoWsXXuYEX/sHM/XJN
	2NX2tlg20se1Lyq0TKQ4xNvHFqvJUwLnt0mje4tsqcf0c3niQrpZwAWut6CCvCJO
	ZXpSrRNKsNn46c7xBHJMScFz8sxlAPMQ8yk95gWPMpfuNqs2OqyjE9W/lAK98t+z
	mVdsdz1axMw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D15017394;
	Tue, 16 Apr 2013 18:17:57 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD9451738F; Tue, 16 Apr
 2013 18:17:56 +0000 (UTC)
In-Reply-To: <c68f7df5367d254360ddf184fa1eaf6b8c3bef18.1366106134.git.trast@inf.ethz.ch>
 (Thomas Rast's message of "Tue, 16 Apr 2013 11:57:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F690135A-A6C1-11E2-99A1-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221445>

Thomas Rast <trast@inf.ethz.ch> writes:

> read_revisions_from_stdin() has passed pointers to its read buffer
> down to handle_revision_arg() since its inception way back in 42cabc3
> (Teach rev-list an option to read revs from the standard input.,
> 2006-09-05).  Even back then, this was a bug: through
> add_pending_object, the argument was recorded in the object_array's
> 'name' field.
>
> Fix it by making a copy whenever read_revisions_from_stdin() passes an
> argument down the callchain.  The other caller runs handle_revision_arg()
> on argv[], where it would be redundant to make a copy.
>
> Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
> ---
>
>> So I changed my mind.  Your "easy fix" looks to me the right thing
>> to do.
>
> So here's the same with a commit message and signoff.  I hope I got my
> history right; I didn't look too long if it had any users, but it was
> definitely recorded.

Thanks.


>
>
>  revision.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/revision.c b/revision.c
> index 3a20c96..181a8db 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1277,7 +1277,8 @@ static void read_revisions_from_stdin(struct rev_info *revs,
>  			}
>  			die("options not supported in --stdin mode");
>  		}
> -		if (handle_revision_arg(sb.buf, revs, 0, REVARG_CANNOT_BE_FILENAME))
> +		if (handle_revision_arg(xstrdup(sb.buf), revs, 0,
> +					REVARG_CANNOT_BE_FILENAME))
>  			die("bad revision '%s'", sb.buf);
>  	}
>  	if (seen_dashdash)
