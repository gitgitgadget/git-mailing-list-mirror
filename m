From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 5/6] config: add `git_die_config()` to the config-set API
Date: Fri, 25 Jul 2014 16:03:11 +0200
Message-ID: <vpqvbqlo7s0.fsf@anie.imag.fr>
References: <1406293095-15920-1-git-send-email-tanayabh@gmail.com>
	<1406293095-15920-6-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 16:05:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAg7d-0005tY-Lx
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 16:05:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760436AbaGYOFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 10:05:14 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47023 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760425AbaGYOFN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 10:05:13 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6PE3Aud029195
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 25 Jul 2014 16:03:10 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6PE3BlP020470;
	Fri, 25 Jul 2014 16:03:11 +0200
In-Reply-To: <1406293095-15920-6-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Fri, 25 Jul 2014 05:58:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 25 Jul 2014 16:03:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6PE3Aud029195
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406901794.40145@D04InXayZ/uJsocCSg8UWg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254223>

Tanay Abhra <tanayabh@gmail.com> writes:

> --- a/config.c
> +++ b/config.c
> @@ -1403,11 +1403,12 @@ const struct string_list *git_configset_get_value_multi(struct config_set *cs, c
>  
>  int git_configset_get_string_const(struct config_set *cs, const char *key, const char **dest)
>  {
> -	const char *value;
> -	if (!git_configset_get_value(cs, key, &value))
> -		return git_config_string(dest, key, value);
> -	else
> -		return 1;
> +	int ret;
> +	char *value;
> +	ret = git_configset_get_string(cs, key, &value);
> +	if (ret <= 0)
> +		*dest = (const char*)value;
> +	return ret;
>  }

Isn't this a fixup meant for another series?

>  int git_configset_get_string(struct config_set *cs, const char *key, char **dest)
> @@ -1418,8 +1419,7 @@ int git_configset_get_string(struct config_set *cs, const char *key, char **dest
>  			return config_error_nonbool(key);
>  		*dest = xstrdup(value);
>  		return 0;
> -	}
> -	else
> +	} else
>  		return 1;

Useless churn.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
