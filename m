From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 2/9] ref-filter: implement '--points-at' option
Date: Mon, 08 Jun 2015 19:31:14 +0200
Message-ID: <vpqwpzertst.fsf@anie.imag.fr>
References: <5573520A.90603@gmail.com>
	<1433621052-5588-1-git-send-email-karthik.188@gmail.com>
	<1433621052-5588-2-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 19:31:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z20tP-0003NC-8w
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 19:31:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbbFHRbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 13:31:19 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55772 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751424AbbFHRbS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 13:31:18 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t58HVCug020928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 8 Jun 2015 19:31:12 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t58HVEF2009844;
	Mon, 8 Jun 2015 19:31:14 +0200
In-Reply-To: <1433621052-5588-2-git-send-email-karthik.188@gmail.com> (Karthik
	Nayak's message of "Sun, 7 Jun 2015 01:34:05 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 08 Jun 2015 19:31:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t58HVCug020928
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434389473.35783@EEo1550bq4o4B/x5j9fEPw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271091>

Karthik Nayak <karthik.188@gmail.com> writes:

> +/*
> + * Given a ref (sha1, refname) see if it points to a one of the sha1s
> + * in a sha1_array.
> + */
> +static int match_points_at(struct sha1_array *points_at, const unsigned char *sha1,
> +			   const char *refname)
> +{
> +	struct object *obj;
> +
> +	if (!points_at || !points_at->nr)
> +		return 1;
> +
> +	if (sha1_array_lookup(points_at, sha1) >= 0)
> +		return 1;
> +
> +	obj = parse_object_or_die(sha1, refname);
> +	if (obj->type == OBJ_TAG &&
> +	    sha1_array_lookup(points_at, ((struct tag *)obj)->tagged->sha1) >= 0)
> +		return 1;
> +
> +	return 0;
> +}

There's a similar function in builtin/tag.c that you are not removing.
You should justify why you are doing this code duplication in the commit
message (or not do code duplication). It might make sense to add a
comment next to match_points_at in tag.c saying stg like "this is
duplicated from ..., will be removed later".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
