From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v15 05/13] ref-filter: implement an `align` atom
Date: Wed, 02 Sep 2015 10:45:33 +0200
Message-ID: <vpqvbbttdjm.fsf@anie.imag.fr>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
	<1441131994-13508-6-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 10:45:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZX3ft-0006r1-1Q
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 10:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbbIBIpj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 04:45:39 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43028 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751380AbbIBIpi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 04:45:38 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t828jWES018968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 2 Sep 2015 10:45:32 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t828jX8f020951;
	Wed, 2 Sep 2015 10:45:33 +0200
In-Reply-To: <1441131994-13508-6-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Tue, 1 Sep 2015 23:56:26 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 02 Sep 2015 10:45:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t828jWES018968
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1441788332.69832@If5R0h/xUIxkok9GrOxoNg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277083>

Karthik Nayak <karthik.188@gmail.com> writes:

> --- a/ref-filter.c
> +++ b/ref-filter.c

> @@ -163,9 +174,28 @@ static void quote_formatting(struct strbuf *s, const char *str, int quote_style)
>  	}
>  }
>  
> +static void align_handler(struct ref_formatting_stack *stack)

Perhaps name it end_align_handler, to make the difference with
align_atom_handler clear.

Also, I think moving this function to be right next to
align_atom_handler in the code would make this more readable.

> @@ -754,6 +816,42 @@ static void populate_value(struct ref_array_item *ref)
>  			else
>  				v->s = " ";
>  			continue;
> +		} else if (skip_prefix(name, "align", &valp)) {
> +			struct align *align = &v->align;
> +			struct strbuf **s;
> +
> +			if (valp[0] != ':')
> +				die(_("format: usage %%(align:<width>,<position>)"));
> +			else
> +				valp++;

I agree with Junio that skip_prefix(name, "align:" ...) is simpler for
the same thing.

> +	if (state.stack->prev)
> +		die(_("format: `end` atom missing"));

Perhaps spell it %(end) instead of just end.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
