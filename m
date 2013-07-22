From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 4/4] config: allow http.<url>.* any user matching
Date: Sun, 21 Jul 2013 22:28:08 -0700
Message-ID: <7va9lfqi3b.fsf@alter.siamese.dyndns.org>
References: <f1109cf05979890ea9441fae7881586@f74d39fa044aa309eaea14b9f57fe79>
	<b8fedff6e14fded3929e2b835aac6f9@f74d39fa044aa309eaea14b9f57fe79>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 22 07:28:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V18fT-00051Z-Uo
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 07:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753459Ab3GVF2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 01:28:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34185 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752167Ab3GVF2N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 01:28:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0748B2CDAA;
	Mon, 22 Jul 2013 05:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LZqCee2W20hA4ogMrY/r/Mye3uE=; b=V8gl+I
	lmiK1HdP/XfFI/yq7lOvHyXL8oI2CYCWidjht4H4ocnI13pDD5RVmg7gD7y+mbTO
	LiAK7xc8n5hKKtDZOq6F5YA0Us4dkte25ZdmHPBKiYTKPKN4hMbVtXtyWV/sne5P
	sd0wU1dF/52lYMAzqxDY+Lk4/j4DrMRpnmtqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UJ3qPELntfgzgZS4dI4Dps9Sk399VD4K
	joSfN3/+dMYdmrjld0DcXUXB8WDTk9JhjGl8x0d4WdPy5PB42CjCuXN1Vh2Zdwv4
	CQ27NcKT8U06285mbx9V8CPYSX+orfdq4L6PweXcoclft5xgVXKYD4f78J5VP9Pq
	g+JZDAHXOyI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB84F2CDA9;
	Mon, 22 Jul 2013 05:28:12 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B3CF2CD9F;
	Mon, 22 Jul 2013 05:28:12 +0000 (UTC)
In-Reply-To: <b8fedff6e14fded3929e2b835aac6f9@f74d39fa044aa309eaea14b9f57fe79>
	(Kyle J. McKay's message of "Sun, 21 Jul 2013 20:18:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 804FF786-F28F-11E2-9C81-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230960>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> diff --git a/test-url-normalize.c b/test-url-normalize.c
> index d68312d..f325571 100644
> --- a/test-url-normalize.c
> +++ b/test-url-normalize.c
> @@ -9,7 +9,7 @@ int main()
>  
>  #include "http.c"
>  
> -#define url_normalize(u) http_options_url_normalize(u)
> +#define url_normalize(u,i) http_options_url_normalize(u,i)
>  
>  int main(int argc, char **argv)
>  {
> @@ -40,21 +40,22 @@ int main(int argc, char **argv)
>  		die(usage);
>  
>  	if (argc == 2) {
> -		url1 = url_normalize(argv[1]);
> +		struct url_info info;
> +		url1 = url_normalize(argv[1], &info);
>  		if (!url1)
>  			return 1;
>  		if (opt_p)
>  			printf("%s\n", url1);
>  		if (opt_l)
> -			printf("%u\n", (unsigned)strlen(url1));
> +			printf("%u\n", (unsigned)info.url_len);
>  		return 0;
>  	}
>  
>  	if (opt_p || opt_l)
>  		die(usage);
>  
> -	url1 = url_normalize(argv[1]);
> -	url2 = url_normalize(argv[2]);
> +	url1 = url_normalize(argv[1], NULL);
> +	url2 = url_normalize(argv[2], NULL);
>  	return (url1 && url2 && !strcmp(url1, url2)) ? 0 : 1;
>  }

It looks like that this program could also drive http_options()
directly, or alternatively make a call

	git_config(http_options, &info);

in its main() to let the config parser do its work, to make sure
that the machinery picks up the right values from the desired entry
in the configuration file, with a bit more effort.

> +static int match_is_ignored(size_t matchlen, int usermatch, enum http_option_type opt)
>  {
>  	/*
> -	 * Compare matchlen to the last matched length of option opt and
> +	 * Compare matchlen to the last matched path length of option opt and
>  	 * return true if matchlen is shorter than the last matched length
>  	 * (meaning the config setting should be ignored).  Upon seeing the
>  	 * _same_ key (i.e. new key has the same match length which is therefore
> -	 * not shorter) the new setting will override the previous setting.
> -	 * Otherwise return false and record matchlen as the current last
> -	 * matched length of option opt.
> +	 * not shorter) the new setting will override the previous setting
> +	 * unless the new setting did not match the user and the previous match
> +	 * did.  Otherwise return false and record matchlen as the current last
> +	 * matched path length of option opt and usermatch as the last user
> +	 * matching state for option opt.
>  	 */
>  	if (matchlen < http_option_max_matched_len[opt])
>  		return 1;
> -	http_option_max_matched_len[opt] = matchlen;
> +	if (matchlen > http_option_max_matched_len[opt]) {
> +		http_option_max_matched_len[opt] = matchlen;
> +		http_option_user_matched[opt] = usermatch;
> +		return 0;
> +	}
> +	/*
> +	 * If a previous match of the same length explicitly matched the user
> +	 * name, but the current match matched on any user, ignore it.
> +	 */
> +	if (!usermatch && http_option_user_matched[opt])
> +		return 1;
> +	http_option_user_matched[opt] = usermatch;
>  	return 0;
>  }

OK, so if there is a configuration for a generic URL that is longer,
it defeats a shorter URL with a specific username, e.g. when talking
to host.xz/name as kyle, with configuration for these two keys
exist:

	scheme://kyle@host.xz/path
        scheme://host.xz/path/name

the value for the latter one is used.

I am not complaining; just making sure that is what we want to give
users, as it was not quite clear in the Documentation/config.txt
part of the patch.

Thanks.
