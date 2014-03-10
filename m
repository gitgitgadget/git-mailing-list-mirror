From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH][GSOC2014] changed logical chain in branch.c to lookup
 tables
Date: Mon, 10 Mar 2014 22:05:27 +0100
Message-ID: <531E2917.1000908@googlemail.com>
References: <y> <1394478262-17911-1-git-send-email-tamertas@outlook.com> <BLU0-SMTP15131ED34F192C9871ACC0CD5740@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: TamerTas <tamertas@outlook.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 10 22:05:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN7OA-0008Lk-5Y
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 22:05:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753336AbaCJVF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 17:05:29 -0400
Received: from mail-ea0-f181.google.com ([209.85.215.181]:47267 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242AbaCJVF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 17:05:28 -0400
Received: by mail-ea0-f181.google.com with SMTP id k10so3959636eaj.40
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 14:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=TBsRxEpZCAPSQtIbVJeNotRA0EUCngSK6NNk0ogGXng=;
        b=vps7YKjd9la+wVj7b0m+sZuwsrbuOachRaoyNiR826kG0TS6k9VfKOVESD/0+QD7Gl
         m2FpWM1KV4uaTRsTJrKZtOv7ZKlzQ5lmQGQE7D41iZTvVRgTAHd5zM51jR3CJv6q18sb
         bXVF4JVPSneeCipuBkXkykaM6jV8uWV+EvkKo0hykZTB69YriArgfSzOuCUJcxfa28aZ
         c5oaKmffdKEVoOkG/e6Fh++njQePvQr76UNs62W5l4UdTKUgkL2/T2BQ4Hlcizf8zBSl
         KFF0fnrdUm/3iwZ0xXH7Be77lmTpK+YzZ2dWVEn8p+YUoVCWxqaaio3uDb2LjXXEXj3A
         gwzA==
X-Received: by 10.14.209.5 with SMTP id r5mr5198691eeo.91.1394485527573;
        Mon, 10 Mar 2014 14:05:27 -0700 (PDT)
Received: from [192.168.1.7] (ip-178-200-168-156.unitymediagroup.de. [178.200.168.156])
        by mx.google.com with ESMTPSA id j41sm49308645eeg.10.2014.03.10.14.05.26
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 10 Mar 2014 14:05:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <BLU0-SMTP15131ED34F192C9871ACC0CD5740@phx.gbl>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243815>

On 10.03.2014 20:04, TamerTas wrote:
> 
> Signed-off-by: TamerTas <tamertas@outlook.com>
> ---
>  branch.c |   31 ++++++++-----------------------
>  1 file changed, 8 insertions(+), 23 deletions(-)
> 
> diff --git a/branch.c b/branch.c
> index 723a36b..397edd3 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -50,6 +50,9 @@ static int should_setup_rebase(const char *origin)
>  void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
>  {
>  	const char *shortname = remote + 11;
> +	const char *location[] = {"local", "remote"};
> +	const char *type[] = {"branch", "ref"};
> +
>  	int remote_is_branch = starts_with(remote, "refs/heads/");
>  	struct strbuf key = STRBUF_INIT;
>  	int rebasing = should_setup_rebase(origin);
> @@ -77,29 +80,11 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
>  	strbuf_release(&key);
>  
>  	if (flag & BRANCH_CONFIG_VERBOSE) {
> -		if (remote_is_branch && origin)
> -			printf_ln(rebasing ?
> -				  _("Branch %s set up to track remote branch %s from %s by rebasing.") :
> -				  _("Branch %s set up to track remote branch %s from %s."),
> -				  local, shortname, origin);
> -		else if (remote_is_branch && !origin)
> -			printf_ln(rebasing ?
> -				  _("Branch %s set up to track local branch %s by rebasing.") :
> -				  _("Branch %s set up to track local branch %s."),
> -				  local, shortname);
> -		else if (!remote_is_branch && origin)
> -			printf_ln(rebasing ?
> -				  _("Branch %s set up to track remote ref %s by rebasing.") :
> -				  _("Branch %s set up to track remote ref %s."),
> -				  local, remote);
> -		else if (!remote_is_branch && !origin)
> -			printf_ln(rebasing ?
> -				  _("Branch %s set up to track local ref %s by rebasing.") :
> -				  _("Branch %s set up to track local ref %s."),
> -				  local, remote);
> -		else
> -			die("BUG: impossible combination of %d and %p",
> -			    remote_is_branch, origin);
> +        
> +        printf_ln(rebasing ?
> +              _("Branch %s set up to track %s %s %s by rebasing.") :
> +              _("Branch %s set up to track %s %s %s."),
> +              local, location[!origin], type[remote_is_branch], remote);
>  	}
>  }
>  
> 

This one is neat, I'd favor this one as opposed to the one posted
earlier today.

Acked-by: Stefan Beller <stefanbeller@googlemail.com>
