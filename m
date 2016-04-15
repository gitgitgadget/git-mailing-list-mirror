From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 08/21] bisect: make bisect compile if DEBUG_BISECT is set
Date: Fri, 15 Apr 2016 14:22:05 -0700
Message-ID: <xmqqd1pqa7pe.fsf@gitster.mtv.corp.google.com>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
	<1460294354-7031-9-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Apr 15 23:22:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arBBv-0001ZZ-4O
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 23:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbcDOVWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 17:22:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60737 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750914AbcDOVWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 17:22:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 92FC413D1B;
	Fri, 15 Apr 2016 17:22:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4++/80Av/EJTcdzBuFoGFzZdqFE=; b=oMf/i7
	/xJS0/dMS0kHAwdslGp+zi0wofiREICJ3xqHwboun5z5ot/QgKJ3feYoXSCuKE6v
	I4g9x3FqorjV9gxiQ1az4taQZru3BQnrOrmOUDaFX+WcupOBSC+9N684NBYLkNWM
	mTAm09apBVfiGOTxoEyVeU/OKh8vc1EMZWdjo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xjUPrDUYmtpj8o/f50JhvzIX33P/BgxW
	+fAMTmim43Wgg4Z9fKFY/oJBnCntB+KsnFQ7L7Vo+tLNc1CUk06AGWQO0woKYA4Q
	AG7RYd5qS3wk2lY+WqzQesXZVILPALLT2WEMiS3SXecBPbiMKYEpzJSOtYtdpJcA
	SAXXon3dqT4=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B8FB13D1A;
	Fri, 15 Apr 2016 17:22:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 03B8713D19;
	Fri, 15 Apr 2016 17:22:06 -0400 (EDT)
In-Reply-To: <1460294354-7031-9-git-send-email-s-beyer@gmx.net> (Stephan
	Beyer's message of "Sun, 10 Apr 2016 15:19:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1B37C62E-0350-11E6-923B-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291666>

Stephan Beyer <s-beyer@gmx.net> writes:

> Setting the macro DEBUG_BISECT to 1 enables debugging information
> for the bisect algorithm. The code did not compile due to struct
> changes.
>
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> ---

Thanks.

This is something that we should do as a preparatory clean-up patch
before the series.  The real body of the series is more important
thing for us to spend review cycles on, and striving to slim it down
by having preparatory bits graduate early would help the process.


>  bisect.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index 901e4d3..2f54d96 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -131,7 +131,7 @@ static void show_list(const char *debug, int counted, int nr,
>  		unsigned flags = commit->object.flags;
>  		enum object_type type;
>  		unsigned long size;
> -		char *buf = read_sha1_file(commit->object.sha1, &type, &size);
> +		char *buf = read_sha1_file(commit->object.oid.hash, &type, &size);
>  		const char *subject_start;
>  		int subject_len;
>  
> @@ -143,10 +143,10 @@ static void show_list(const char *debug, int counted, int nr,
>  			fprintf(stderr, "%3d", weight(p));
>  		else
>  			fprintf(stderr, "---");
> -		fprintf(stderr, " %.*s", 8, sha1_to_hex(commit->object.sha1));
> +		fprintf(stderr, " %.*s", 8, sha1_to_hex(commit->object.oid.hash));
>  		for (pp = commit->parents; pp; pp = pp->next)
>  			fprintf(stderr, " %.*s", 8,
> -				sha1_to_hex(pp->item->object.sha1));
> +				sha1_to_hex(pp->item->object.oid.hash));
>  
>  		subject_len = find_commit_subject(buf, &subject_start);
>  		if (subject_len)
