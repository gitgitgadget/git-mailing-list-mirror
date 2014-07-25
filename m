From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] home_config_path: allow NULL xdg parameter
Date: Fri, 25 Jul 2014 12:09:38 -0700
Message-ID: <xmqqwqb15k7h.fsf@gitster.dls.corp.google.com>
References: <1406311207-8276-1-git-send-email-Matthieu.Moy@imag.fr>
	<1406311207-8276-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jul 25 21:09:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAksJ-0003s8-Cl
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 21:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760981AbaGYTJs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 15:09:48 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57902 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754086AbaGYTJr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 15:09:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AA36C29C9B;
	Fri, 25 Jul 2014 15:09:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zAua/xebIXNYIotwB+KHyUZxZos=; b=SEyAW5
	ln/Nc5mEjWyecWz+2YRe68s8vrTpg6K8tymqmaYY6MoyWeI2zWXefty0CEc7/8Ea
	8YOcDIyCVii8vUEbMQIhGXYeNBfjfCl6E87IaR9ll6uD1M4uUjGauefvr+gFDdJN
	kbZrJ4E1bRFGsKyxg6s9RxrEEdOinSWbgr3lg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZiGjjo0BgghAAosPZsTFpQ/XoQnh8mZj
	Jm+EP3b9EEtOqpWus8aEtetgkAn8scMX+DRP0HqLXSiKzvoC4rsJ+M9TUn6g7mGG
	imKQAUC9MJRTVB9X9HKrotmU9j7zheuT+YQHcm6DV8CQ79iFud/vp4T9CjYYjGBO
	q21oX+Us+hY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9E74B29C9A;
	Fri, 25 Jul 2014 15:09:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 88BF929C8B;
	Fri, 25 Jul 2014 15:09:40 -0400 (EDT)
In-Reply-To: <1406311207-8276-2-git-send-email-Matthieu.Moy@imag.fr> (Matthieu
	Moy's message of "Fri, 25 Jul 2014 20:00:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3A83CCEC-142F-11E4-97BF-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254258>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> This allows a caller to request the global config file without requesting
> the XDG one.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---

Will rephrase

    A caller can ask only for XDG location by passing global=NULL.
    Allow it to ask only for the $HOME/.gitconfig by passing
    xdg=NULL.

as you seem to have forgotten ;-)

>  path.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/path.c b/path.c
> index 3afcdb4..f68df0c 100644
> --- a/path.c
> +++ b/path.c
> @@ -148,10 +148,12 @@ void home_config_paths(char **global, char **xdg, char *file)
>  			*global = mkpathdup("%s/.gitconfig", home);
>  	}
>  
> -	if (!xdg_home)
> -		*xdg = NULL;
> -	else
> -		*xdg = mkpathdup("%s/git/%s", xdg_home, file);
> +	if (xdg) {
> +		if (!xdg_home)
> +			*xdg = NULL;
> +		else
> +			*xdg = mkpathdup("%s/git/%s", xdg_home, file);
> +	}
>  
>  	free(to_free);
>  }
