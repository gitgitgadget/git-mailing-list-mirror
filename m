From: "Alan Raison" <alan@theraisons.me.uk>
Subject: RE: [PATCH] Corrected return values in post-receive-email.prep_for_email
Date: Tue, 7 Dec 2010 17:10:04 -0000
Message-ID: <002c01cb9631$972d6690$c58833b0$@me.uk>
References: <002501cb962c$5fa3aa40$1eeafec0$@me.uk> <AANLkTikYnDNRPVd-wd4+3jsX2fBbjxODEGATN5dD7t1E@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "'Thiago Farina'" <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 18:10:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ13O-0007Mp-65
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 18:10:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344Ab0LGRKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 12:10:08 -0500
Received: from gateway.bjss.co.uk ([77.86.30.29]:54655 "EHLO
	gateway.bjss.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141Ab0LGRKH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Dec 2010 12:10:07 -0500
Received: from exchange.bjss.co.uk ([172.22.32.28]) by gateway.bjss.co.uk with Microsoft SMTPSVC(6.0.3790.4675);
	 Tue, 7 Dec 2010 17:10:04 +0000
Received: from kitkat ([172.22.33.188]) by exchange.bjss.co.uk with Microsoft SMTPSVC(6.0.3790.4675);
	 Tue, 7 Dec 2010 17:10:04 +0000
In-Reply-To: <AANLkTikYnDNRPVd-wd4+3jsX2fBbjxODEGATN5dD7t1E@mail.gmail.com>
X-Mailer: Microsoft Office Outlook 12.0
thread-index: AcuWLtxd3Wj1w4C9QlaTgWJReyW/aQAAYyVA
Content-Language: en-gb
X-OriginalArrivalTime: 07 Dec 2010 17:10:04.0395 (UTC) FILETIME=[972B43B0:01CB9631]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163092>

In the main loop (lines 734 and 738 in the current master) the && and || operations assume true==0 and false==1; in line with shell defaults.

I tested it on a sourceforge shell (I think using Bash); error conditions reported an error to standard error, then proceeded to generate the email; if prep_for_email succeeded then no mail was sent.

HTH

Alan

-----Original Message-----
From: Thiago Farina [mailto:tfransosi@gmail.com] 
Sent: 07 December 2010 16:50
To: Alan Raison
Cc: git@vger.kernel.org
Subject: Re: [PATCH] Corrected return values in post-receive-email.prep_for_email

Care to explain in the change log message why the return value should
be 1 instead of 0?

On Tue, Dec 7, 2010 at 2:32 PM, Alan Raison <alan@theraisons.me.uk> wrote:
> ---
>  contrib/hooks/post-receive-email |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/hooks/post-receive-email
> b/contrib/hooks/post-receive-email
> index 85724bf..020536d 100755
> --- a/contrib/hooks/post-receive-email
> +++ b/contrib/hooks/post-receive-email
> @@ -150,7 +150,7 @@ prep_for_email()
>                        # Anything else (is there anything else?)
>                        echo >&2 "*** Unknown type of update to $refname
> ($rev_type)"
>                        echo >&2 "***  - no email generated"
> -                       return 0
> +                       return 1
>                        ;;
>        esac
>
> @@ -166,10 +166,10 @@ prep_for_email()
>                esac
>                echo >&2 "*** $config_name is not set so no email will be
> sent"
>                echo >&2 "*** for $refname update $oldrev->$newrev"
> -               return 0
> +               return 1
>        fi
>
> -       return 1
> +       return 0
>  }
>
>  #
> --
> 1.7.3.1.msysgit.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
