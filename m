From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v15 07/13] ref-filter: add support for %(contents:lines=X)
Date: Wed, 02 Sep 2015 11:07:05 +0200
Message-ID: <vpq8u8ptcjq.fsf@anie.imag.fr>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
	<1441131994-13508-8-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 11:07:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZX41H-0002Gc-M1
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 11:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753785AbbIBJHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 05:07:47 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45895 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753540AbbIBJHN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 05:07:13 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t82974fV010048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 2 Sep 2015 11:07:04 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t82975N8021511;
	Wed, 2 Sep 2015 11:07:05 +0200
In-Reply-To: <1441131994-13508-8-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Tue, 1 Sep 2015 23:56:28 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 02 Sep 2015 11:07:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t82974fV010048
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1441789627.51701@zqWgwnMVvrX7Ce7FgR3tmw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277084>

Karthik Nayak <karthik.188@gmail.com> writes:

> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -185,6 +185,10 @@ static enum contains_result contains(struct commit *candidate,
>  	return contains_test(candidate, want);
>  }
>  
> +/*
> + * Currently modified and used in ref-filter as append_lines(), will
> + * eventually be removed as we port tag.c to use ref-filter APIs.
> + */
>  static void show_tag_lines(const struct object_id *oid, int lines)

I would rather have one "cut and paste" patch followed by a "modify and
use" patch for review.

As-is, reading the patch doesn't tell me what change you did.

That said, I did get this information in the interdiff, so I won't
insist on that.

> +static void append_lines(struct strbuf *out, const char *buf, unsigned long size, int lines)
> +{
> +	int i;
> +	const char *sp, *eol;
> +	size_t len;
> +
> +	if ((sp = strstr(buf, "\n\n")) && (sp <= buf + size))
> +		size += 2;

Why is this "size += 2" needed?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
