From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] install_branch_config(): switch from 'else-if' series to 'nested if-else'
Date: Wed, 12 Mar 2014 10:23:01 +0100
Message-ID: <vpqmwgvrcsq.fsf@anie.imag.fr>
References: <1394613275-3327-1-git-send-email-nishgaba9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Nishhal Gaba <nishgaba9@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 10:23:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNfNb-0002JS-Q2
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 10:23:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386AbaCLJXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 05:23:08 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35614 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751804AbaCLJXH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 05:23:07 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s2C9N0vi002817
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 Mar 2014 10:23:00 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s2C9N1ws019401;
	Wed, 12 Mar 2014 10:23:01 +0100
In-Reply-To: <1394613275-3327-1-git-send-email-nishgaba9@gmail.com> (Nishhal
	Gaba's message of "Wed, 12 Mar 2014 14:04:35 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 12 Mar 2014 10:23:00 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s2C9N0vi002817
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1395220981.98114@Km/e8c4BXkxQa0X7lT6Ltg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243929>

Nishhal Gaba <nishgaba9@gmail.com> writes:

> From: Nishchal <nishgaba9@gmail.com>

Set user.email/user.name and sendemail.from to the same address to avoid
this inline From:.

> I am Nishchal Gaba, a GSOC 2014 aspirant, submitting patch in response to microproject(8)

This part of your message is the commit message. It should justify why
the change is good, but who you are is not very interesting here (think
of someone running "git log" or "git blame" a year from now and going
through your commit, what would he expect?). The first sentence could go
below the ---.

Please, wrap your messages (less than 80 characters per line).

> Similar Execution Time, but increased readability

Why capitalize Execution Time?

> +		if (origin){

Here and below: space before {

> +			if(remote_is_branch)

space before (

> +				printf_ln(rebasing ?
>  				  _("Branch %s set up to track remote branch %s from %s by rebasing.") :
>  				  _("Branch %s set up to track remote branch %s from %s."),
>  				  local, shortname, origin);
> -		else if (remote_is_branch && !origin)
> -			printf_ln(rebasing ?
> -				  _("Branch %s set up to track local branch %s by rebasing.") :
> -				  _("Branch %s set up to track local branch %s."),
> -				  local, shortname);
> -		else if (!remote_is_branch && origin)
> -			printf_ln(rebasing ?
> +			else
> +				printf_ln(rebasing ?
>  				  _("Branch %s set up to track remote ref %s by rebasing.") :
>  				  _("Branch %s set up to track remote ref %s."),

At this point, it would make sense to me to factor the printf_ln call
like

const char *msg;
if (...)
	msg = rebasing ? _("...") : _("...");
else
	msg = rebasing ? _("...") : _("...");
printf_ln(msg, local, shortname);

(but that's very subjective)

> -		else if (!remote_is_branch && !origin)
> -			printf_ln(rebasing ?
> +		}
> +
> +		else if (!origin){

Err, isn't this the else branch of "if (origin)" ? If so, why repeat
"!origin", and more specifically, isn't the next "else" branch dead
code:

> +		}
> +
>  		else
>  			die("BUG: impossible combination of %d and %p",
>  			    remote_is_branch, origin);

I mean: obviously, it has to be dead code, but it seems a bit strange to
read

if (x)
	...
else if (!x)
	...
else
	die(...)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
