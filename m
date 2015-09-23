From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v6 0/8] port branch.c to use the filtering part of ref-filter.
Date: Wed, 23 Sep 2015 21:00:53 +0200
Message-ID: <vpqsi65t0yi.fsf@grenoble-inp.fr>
References: <1443031873-25280-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 21:01:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZepHs-0006Nr-2Y
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 21:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589AbbIWTA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 15:00:59 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36405 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753200AbbIWTA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 15:00:58 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t8NJ0oMV007245
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 23 Sep 2015 21:00:50 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8NJ0rMK009898;
	Wed, 23 Sep 2015 21:00:53 +0200
In-Reply-To: <1443031873-25280-1-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Wed, 23 Sep 2015 23:41:05 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 23 Sep 2015 21:00:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8NJ0oMV007245
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1443639651.70062@xM0tUgI7bgdOrsaTTWB3MQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278503>

Karthik Nayak <karthik.188@gmail.com> writes:

> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -479,8 +479,6 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
>  	struct ref_array array;
>  	int maxwidth = 0;
>  	const char *remote_prefix = "";
> -	struct ref_sorting def_sorting;
> -	const char *sort_type = "refname";

This was allocated on stack ...

> @@ -498,12 +496,15 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
> +	if (!sorting)
> +		sorting = ref_default_sorting();

and it's now allocated by xcalloc within ref_default_sorting(). In
theory, you need a free(). But the sensible place to add this free would
be after the call to print_ref_list(), and this is right before the
process terminates. So it's probably overkill to add a free().

The series looks good to me. I did a minor remark on PATCH 5/8 but this
should not block inclusion.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
