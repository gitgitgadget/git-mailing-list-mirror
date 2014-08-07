From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 5/8] config: add `git_die_config()` to the config-set API
Date: Thu, 07 Aug 2014 11:55:25 -0700
Message-ID: <xmqqd2ccku3m.fsf@gitster.dls.corp.google.com>
References: <1407412759-13833-1-git-send-email-tanayabh@gmail.com>
	<1407412759-13833-6-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 07 20:56:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFSqp-0008Gw-CD
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 20:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755464AbaHGSzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 14:55:41 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53483 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754964AbaHGSzj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 14:55:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 84DA22FD23;
	Thu,  7 Aug 2014 14:55:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nZDH0QaSDzbI3T431kZcFEkXTvE=; b=Wsqgkg
	G/H9T67MIIOoB093iT2rZtsd52n+X7ZpaNB58kp7hcbXUQ3ciX+R+2yij2qvyXGe
	WSTerYJqaFG0FWayxkpPyLSdsaoaZ52coLQmrVyYKtWtWVs+C5xSRD1/IHY2fSrm
	AkkJJrHFm0gpWQxooVds3Kx0BbBAHW3wwh+Oo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OUh74CajOeXJr4cKBaShS+NS3OEcNNhb
	7iaq1pMdoKNCtloWiYpVuSDamZy+YKMH0ai3c02wP4T8GquQxrzjTa3UuPYBe0UT
	ipSBg9pn7X/3kCY91KlVV85qPEkHJbNXVkAjaQM7EV4xP+4LJnV6Dq3q0xlrSRNF
	LA7Nt+/hqLI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7AC012FD22;
	Thu,  7 Aug 2014 14:55:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9CC552FD14;
	Thu,  7 Aug 2014 14:55:26 -0400 (EDT)
In-Reply-To: <1407412759-13833-6-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Thu, 7 Aug 2014 04:59:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 64E9CCF4-1E64-11E4-8207-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254987>

Tanay Abhra <tanayabh@gmail.com> writes:

> diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
> index 21f280c..0d8b99b 100644
> --- a/Documentation/technical/api-config.txt
> +++ b/Documentation/technical/api-config.txt
> @@ -155,6 +155,19 @@ as well as retrieval for the queried variable, including:
>  	Similar to `git_config_get_string`, but expands `~` or `~user` into
>  	the user's home directory when found at the beginning of the path.
>  
> +`git_die_config(const char *key, const char *err, ...)`::
> +
> +	First prints the error message specified by the caller in `err` and then
> +	dies printing the line number and the file name of the highest priority
> +	value for the configuration variable `key`.

Reviewed with a wider context, I notice that this entry alone lacks
the return type.  I am assuming that this is just an oversight, and
adding 'void ' in front of the filename to match the next entry is
simple enough.

> +`void git_die_config_linenr(const char *key, const char *filename, int linenr)`::
> + ...
> +extern NORETURN void git_die_config(const char *key, const char *err, ...) __attribute__((format(printf, 2, 3)));
> ...
> +NORETURN __attribute__((format(printf, 2, 3)))
> +void git_die_config(const char *key, const char *err, ...)
> +{

My first reaction was that it might make the compiler unhappy to
declare that the "err" is a printf-like format string and then to
allow some callers to pass NULL to the function.  My build however
does not seem to complain, so perhaps this is OK.

> +	const struct string_list *values;
> +	struct key_value_info *kv_info;
> +
> +	if (err) {
> +		va_list params;
> +		va_start(params, err);
> +		vreportf("error: ", err, params);
> +		va_end(params);
> +	}
> +	values = git_config_get_value_multi(key);
> +	kv_info = values->items[values->nr - 1].util;
> +	git_die_config_linenr(key, kv_info->filename, kv_info->linenr);
>  }
>  
>  /*
