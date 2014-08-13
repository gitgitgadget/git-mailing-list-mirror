From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/4] ll-merge.c: refactor `read_merge_config()` to use `git_config_string()`
Date: Wed, 13 Aug 2014 13:32:37 +0200
Message-ID: <vpqfvh0vd4a.fsf@anie.imag.fr>
References: <1407918122-29973-1-git-send-email-tanayabh@gmail.com>
	<1407918122-29973-2-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 13:32:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHWnN-00006R-OL
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 13:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbaHMLcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 07:32:42 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58184 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939AbaHMLcl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 07:32:41 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s7DBWamk024656
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 Aug 2014 13:32:36 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s7DBWboN023616;
	Wed, 13 Aug 2014 13:32:37 +0200
In-Reply-To: <1407918122-29973-2-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Wed, 13 Aug 2014 01:22:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 13 Aug 2014 13:32:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s7DBWamk024656
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1408534357.88632@6N3i+5sJ9x8bCK4Oil4b6Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255202>

Tanay Abhra <tanayabh@gmail.com> writes:

> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---
>  ll-merge.c | 23 ++++++-----------------
>  1 file changed, 6 insertions(+), 17 deletions(-)
>
> diff --git a/ll-merge.c b/ll-merge.c
> index fb61ea6..8ea03e5 100644
> --- a/ll-merge.c
> +++ b/ll-merge.c
> @@ -225,11 +225,8 @@ static int read_merge_config(const char *var, const char *value, void *cb)
>  	const char *key, *name;
>  	int namelen;
>  
> -	if (!strcmp(var, "merge.default")) {
> -		if (value)
> -			default_ll_merge = xstrdup(value);
> -		return 0;
> -	}
> +	if (!strcmp(var, "merge.default"))
> +		return git_config_string(&default_ll_merge, var, value);

Previously, merge.default without value was a no-op. It's now an error.

I think it makes perfect sense, but should be documented in the log
message.

Also, I think you should explain briefly the reason for not using your
non-callback API here.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
