From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/4] convert: Refactor would_convert_to_git() to single arg 'path'
Date: Mon, 25 Aug 2014 15:55:52 -0700
Message-ID: <xmqqvbpgji13.fsf@gitster.dls.corp.google.com>
References: <1408896466-23149-1-git-send-email-prohaska@zib.de>
	<1408896466-23149-2-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	john@keeping.me.uk, schacon@gmail.com
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Aug 26 00:56:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XM3BI-0008Ar-Uw
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 00:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754256AbaHYW4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 18:56:04 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53013 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751780AbaHYW4C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 18:56:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2DD7B35246;
	Mon, 25 Aug 2014 18:56:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gXcOnMdTY85A4PIT4cMvczVAd/g=; b=w7bGIK
	mbFv8Vvz6qX6MfR1r+aaknfoabPW8gwU7RWDnFLt70SJ3ZRurXeG6p0f+4SIungD
	yEWQEJGiU7WilI6iIPTvH6vxo5FUMg0pHds3kMoOtXlqYZQbS+H7Gr2lOfcLcme+
	NlmhiPRgWMJNJEHA/x8bemu15PCbkTaBPbG7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V8LHV/N5qdrQHqO9FPRtCJH4m3EthDuA
	9gNkK8c3tosm6fE9ln09ykJ6wo3kWcYW10ML0jxS5OiIN7lCnMQxSbDsTTVNKukz
	j1ToxIgs+yjtss7dGiF6LfB4QQX3f4sHhmZZqvvU4fxMM2d9s9XqsNGZ1d4qaunZ
	mokdUmAFd/I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 239B935244;
	Mon, 25 Aug 2014 18:56:02 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 016943523A;
	Mon, 25 Aug 2014 18:55:53 -0400 (EDT)
In-Reply-To: <1408896466-23149-2-git-send-email-prohaska@zib.de> (Steffen
	Prohaska's message of "Sun, 24 Aug 2014 18:07:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F7BA978A-2CAA-11E4-B3BE-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255875>

Steffen Prohaska <prohaska@zib.de> writes:

> It is only the path that matters in the decision whether to filter or
> not.  Clarify this by making path the single argument of
> would_convert_to_git().
>
> Signed-off-by: Steffen Prohaska <prohaska@zib.de>
> ---

I've retitled this as:

    convert: drop arguments other than 'path' from would_convert_to_git()

to match the output from "git shortlog --since=3.months --no-merges"
by using lowercase 'd' after the "convert: " area name, and also
more importantly avoid calling "refactor" which this change is not.

Thanks.

>  convert.h   | 5 ++---
>  sha1_file.c | 2 +-
>  2 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/convert.h b/convert.h
> index 0c2143c..c638b33 100644
> --- a/convert.h
> +++ b/convert.h
> @@ -40,10 +40,9 @@ extern int convert_to_working_tree(const char *path, const char *src,
>  				   size_t len, struct strbuf *dst);
>  extern int renormalize_buffer(const char *path, const char *src, size_t len,
>  			      struct strbuf *dst);
> -static inline int would_convert_to_git(const char *path, const char *src,
> -				       size_t len, enum safe_crlf checksafe)
> +static inline int would_convert_to_git(const char *path)
>  {
> -	return convert_to_git(path, src, len, NULL, checksafe);
> +	return convert_to_git(path, NULL, 0, NULL, 0);
>  }
>  
>  /*****************************************************************
> diff --git a/sha1_file.c b/sha1_file.c
> index 3f70b1d..00c07f2 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -3144,7 +3144,7 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st,
>  	if (!S_ISREG(st->st_mode))
>  		ret = index_pipe(sha1, fd, type, path, flags);
>  	else if (size <= big_file_threshold || type != OBJ_BLOB ||
> -		 (path && would_convert_to_git(path, NULL, 0, 0)))
> +		 (path && would_convert_to_git(path)))
>  		ret = index_core(sha1, fd, size, type, path, flags);
>  	else
>  		ret = index_stream(sha1, fd, size, type, path, flags);
