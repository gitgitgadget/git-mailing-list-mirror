From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] diffcore-pickaxe: make error messages more consistent
Date: Mon, 03 Jun 2013 10:52:02 -0700
Message-ID: <7vwqqbf5fh.fsf@alter.siamese.dyndns.org>
References: <1370002335-6596-1-git-send-email-artagnon@gmail.com>
	<1370002335-6596-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 19:52:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjYvS-0001Gz-Os
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 19:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756029Ab3FCRwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 13:52:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59342 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752412Ab3FCRwE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 13:52:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E6F72431C;
	Mon,  3 Jun 2013 17:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YmOC5BIg8T3t5Q4gxDsHx0GpspA=; b=sXM66H
	sFqqTWoCWjxmtctf5OyvPeoeiO2jCh+QZzeHaWUH6IPMBKGFLXgISJlhCp/qSSPF
	/pfaZPjSKdLdlWSLnihhtNk0uyr/LP4U0uA+Y2kCmEe9oZMOlOh7DSrw3ePfdb96
	qAs/BQlIS5HN49oMYAhY1Fd3OqpeYUNghrlC0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JdoDUXW5y0Dxp8dPd/s422FlDESdBsXW
	3IvQAQQIF9vcuhWfCZxUG8VPJpUdZWDIRN/6ZJBmmuNsNZ8CpMIg1dBb7woP8/Bi
	RHmyiivKsikh/VeO2FXxm8PVf6X8SsHy2svlfCJwJYvCRXiulA8rz6DyWLdMpaJL
	nzm0LWR5XqM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33BF32431B;
	Mon,  3 Jun 2013 17:52:04 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89A1524318;
	Mon,  3 Jun 2013 17:52:03 +0000 (UTC)
In-Reply-To: <1370002335-6596-2-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Fri, 31 May 2013 17:42:14 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4C78C5DA-CC76-11E2-8B8A-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226250>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Currently, diffcore-pickaxe reports two distinct errors for the same
> user error:
>
>     $ git log --pickaxe-regex -S'\1'
>     fatal: invalid pickaxe regex: Invalid back reference
>
>     $ git log -G'\1' # --pickaxe-regex is implied
>     fatal: invalid log-grep regex: Invalid back reference
>
> Since the error has nothing to do with "log-grep", change the -G and -S
> error messages to say "invalid regex".

I'll reword the above somewhat; as I repeatedly explained, -G does
*not* imply pickaxe-regex at all.

While -G was being developed, it was internally called log-grep (no
relation to "git log --grep=<pattern>"), and that seeped through to
the error message.  Removing that is a good idea.

Thanks, will queue.



>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  diffcore-pickaxe.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
> index 63722f8..c97ac9b 100644
> --- a/diffcore-pickaxe.c
> +++ b/diffcore-pickaxe.c
> @@ -122,7 +122,7 @@ static void diffcore_pickaxe_grep(struct diff_options *o)
>  		char errbuf[1024];
>  		regerror(err, &regex, errbuf, 1024);
>  		regfree(&regex);
> -		die("invalid log-grep regex: %s", errbuf);
> +		die("invalid regex: %s", errbuf);
>  	}
>  
>  	pickaxe(&diff_queued_diff, o, &regex, NULL, diff_grep);
> @@ -246,7 +246,7 @@ static void diffcore_pickaxe_count(struct diff_options *o)
>  			char errbuf[1024];
>  			regerror(err, &regex, errbuf, 1024);
>  			regfree(&regex);
> -			die("invalid pickaxe regex: %s", errbuf);
> +			die("invalid regex: %s", errbuf);
>  		}
>  		regexp = &regex;
>  	} else {
