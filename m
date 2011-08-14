From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] Allocate cached_refs objects dynamically
Date: Sun, 14 Aug 2011 15:21:45 -0700
Message-ID: <7vmxfbljly.fsf@alter.siamese.dyndns.org>
References: <1313188589-2330-1-git-send-email-mhagger@alum.mit.edu>
 <1313188589-2330-5-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Aug 15 00:21:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qsj44-0000bI-L2
	for gcvg-git-2@lo.gmane.org; Mon, 15 Aug 2011 00:21:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876Ab1HNWVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Aug 2011 18:21:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51791 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754774Ab1HNWVr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2011 18:21:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 294FA3169;
	Sun, 14 Aug 2011 18:21:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=JsfHR1uAAmWsawAp6erjFZCnCTA=; b=ECq0wLJvTm4/uI3tG8tn
	+IYEbbWb07mIoPzHtgye3J5pfiE14xjNeNYXXNZP0PyhSa4aiv+JKafgjxJM7MZy
	Afew5fqJnYNhhe3DhRmN8gqtWY6NSnD0PYcVbpK+7PWbV2W6k13nCP9w/WNpetQG
	9uVEdROaOjFXAeYreyzx3Fg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=MYHgCsqaqnTTNSI8t/w9AuxcOF5047O6ebKQp04T/2/QE1
	U/pY60iMf24HyrlBSZptByIy+Q7buwtPLo6szBylaWLcVB2xEU+crZQbgbmab2Mb
	xjop2uYrdcbPKOjKRNiqgKRGBn0XjzHHjMeJOOuq22c6c2XhVTO42SkG9bF5w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20FB73168;
	Sun, 14 Aug 2011 18:21:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A0DC43167; Sun, 14 Aug 2011
 18:21:46 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CC249418-C6C3-11E0-8D93-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179351>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c |   28 +++++++++++++++++++++-------
>  1 files changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index e043555..102ed03 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -157,7 +157,7 @@ static struct cached_refs {
>  	char did_packed;
>  	struct ref_list *loose;
>  	struct ref_list *packed;
> -} cached_refs, submodule_refs;
> +} *cached_refs, *submodule_refs;
>  static struct ref_list *current_ref;
>  
>  static struct ref_list *extra_refs;
> @@ -181,6 +181,15 @@ static void clear_cached_refs(struct cached_refs *ca)
>  	ca->did_loose = ca->did_packed = 0;
>  }
>  
> +struct cached_refs *create_cached_refs()

struct cached_refs *create_cached_refs(void)
