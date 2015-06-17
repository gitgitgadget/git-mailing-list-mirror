From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 06/11] ref-filter: implement '--merged' and '--no-merged' options
Date: Wed, 17 Jun 2015 10:38:02 +0200
Message-ID: <vpqoakezq51.fsf@anie.imag.fr>
References: <CAOLa=ZQeZ=6mZcntR_BS_Wp0LXDzSUx9WTLXCTLxemb0e3SS0w@mail.gmail.com>
	<1434464457-10749-1-git-send-email-karthik.188@gmail.com>
	<1434464457-10749-6-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 10:38:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z58rR-0007tl-65
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 10:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbbFQIiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 04:38:12 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45432 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750839AbbFQIiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 04:38:09 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5H8c2Kx012872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Jun 2015 10:38:02 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5H8c2th030945;
	Wed, 17 Jun 2015 10:38:02 +0200
In-Reply-To: <1434464457-10749-6-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Tue, 16 Jun 2015 19:50:52 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 17 Jun 2015 10:38:02 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5H8c2Kx012872
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435135086.45174@74Ymvgo5a8Ibefiy4OiPwA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271820>

Karthik Nayak <karthik.188@gmail.com> writes:
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -901,12 +903,19 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
>  	if (!match_points_at(&filter->points_at, oid->hash, refname))
>  		return 0;
>  
> +	if (filter->merge_commit) {
> +		commit = lookup_commit_reference_gently(oid->hash, 1);
> +		if (!commit)
> +			return 0;
> +	}

I'd appreciate a comment here. If I understand correctly, the comment
could be along the lines of

/*
 * A merge filter implies that we're looking at refs pointing to
 * commits => discard non-commits early. The actual filtering is done
 * later.
 */

(perhaps something more concise)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
