From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 5/9] ref-filter: add option to match literal pattern
Date: Wed, 22 Jul 2015 21:20:20 +0200
Message-ID: <vpqmvyongnf.fsf@anie.imag.fr>
References: <1437246749-14423-1-git-send-email-Karthik.188@gmail.com>
	<1437246749-14423-6-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 21:20:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHzZA-00013H-J9
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 21:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbbGVTU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2015 15:20:28 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50532 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779AbbGVTU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2015 15:20:27 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t6MJKI3Z018715
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 22 Jul 2015 21:20:18 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6MJKKtr029853;
	Wed, 22 Jul 2015 21:20:20 +0200
In-Reply-To: <1437246749-14423-6-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Sun, 19 Jul 2015 00:42:25 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 22 Jul 2015 21:20:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6MJKI3Z018715
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438197619.87108@KjsTs3ytOqjSlGpWIkRhUQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274457>

Karthik Nayak <karthik.188@gmail.com> writes:

> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -943,9 +943,23 @@ static int commit_contains(struct ref_filter *filter, struct commit *commit)
>  
>  /*
>   * Return 1 if the refname matches one of the patterns, otherwise 0.
> + * A pattern can be a literal prefix (e.g. a refname "refs/heads/master"
> + * matches a pattern "refs/heads/m") or a wildcard (e.g. the same ref
> + * matches "refs/heads/m*", too).
> + */
> +static int match_pattern(const char **patterns, const char *refname)
> +{
> +	for (; *patterns; patterns++)
> +		if (!wildmatch(*patterns, refname, 0, NULL))
> +			return 1;
> +	return 0;
> +}
> +
> +/*
> + * Return 1 if the refname matches one of the patterns, otherwise 0.
>   * A pattern can be path prefix (e.g. a refname "refs/heads/master"
>   * matches a pattern "refs/heads/") or a wildcard (e.g. the same ref

While you're there, why not say explicitly

   * A pattern can be path prefix (e.g. a refname "refs/heads/master"
   * matches a pattern "refs/heads/" but not "refs/heads/m")
                                     ^^^^^^^^^^^^^^^^^^^^^^
   ...

(I find it frustrating when the docstrings for two function look
identical and I have to find out the 1-character difference to
understand ...)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
