From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/1 alt] peel_onion: do not assume length of x_type globals
Date: Tue, 03 Sep 2013 13:46:05 -0700
Message-ID: <xmqqsixlpraq.fsf@gitster.dls.corp.google.com>
References: <20130903202041.GA7463@sigill.intra.peff.net>
	<20130903202729.GA26217@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Richard Hansen <rhansen@bbn.com>, git@vger.kernel.org,
	sunshine@sunshineco.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 03 22:46:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGxUS-0000tU-8N
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 22:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760859Ab3ICUqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 16:46:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49324 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755932Ab3ICUqM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 16:46:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A9233DEBA;
	Tue,  3 Sep 2013 20:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2h6sBgxO6KhlKoajg4fAMZ3i6Cg=; b=v9FOOC
	+JCgoi/ZdnKvSpL4Y/l1+vEk8t5kq+l5vrKeE16hrpbWihw+oHL0408jK4Ruo8BR
	UhNz93rnxgo41B1gmlFfoF2OtI7+1JeT+kXCE9QBm/lXhVpDJIBDVA3GYMH3ud0T
	ZO/9mPkVoCTYsGL+Vhhgv8xVDlyggCzE2SfCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aVVusilywsn1RVgXvmAydms+8H+tA88l
	Yh73fwsKz2rP5vrxLH4j/wAbTypsu3p1Nb4rAZQ0Mk7D1+wlvOYby4Yb/EGZ4iIP
	xsDrKcqCpI4h1US6xeiYV3jXlZ6zcEbAJ/Bwx3qrABttlato1CP8b8AIv/+drzvo
	jHTR6uPMQF0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EC933DEB7;
	Tue,  3 Sep 2013 20:46:11 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 36B4D3DEAE;
	Tue,  3 Sep 2013 20:46:09 +0000 (UTC)
In-Reply-To: <20130903202729.GA26217@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 3 Sep 2013 16:27:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DCBB7538-14D9-11E3-BB9B-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233778>

Jeff King <peff@peff.net> writes:

> If you _really_ wanted to abstract it, you could make commit_type a
> macro and use string concatenation along with prefixcmp. But that is
> going in the direction of less readable, I think. :)

;-) we are on the same wave-length.

Thanks, will apply.

>
> This has probably consumed enough brain cycles for such a small and
> probably unimportant cleanup. I'll let Junio pick from the 2 options (or
> choose to do nothing at all) as he sees fit.
>
>  sha1_name.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/sha1_name.c b/sha1_name.c
> index 6dc496d..2f6e5ab 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -677,13 +677,13 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
>  		return -1;
>  
>  	sp++; /* beginning of type name, or closing brace for empty */
> -	if (!strncmp(commit_type, sp, 6) && sp[6] == '}')
> +	if (!prefixcmp(sp, "commit}"))
>  		expected_type = OBJ_COMMIT;
> -	else if (!strncmp(tag_type, sp, 3) && sp[3] == '}')
> +	else if (!prefixcmp(sp, "tag}"))
>  		expected_type = OBJ_TAG;
> -	else if (!strncmp(tree_type, sp, 4) && sp[4] == '}')
> +	else if (!prefixcmp(sp, "tree}"))
>  		expected_type = OBJ_TREE;
> -	else if (!strncmp(blob_type, sp, 4) && sp[4] == '}')
> +	else if (!prefixcmp(sp, "blob}"))
>  		expected_type = OBJ_BLOB;
>  	else if (!prefixcmp(sp, "object}"))
>  		expected_type = OBJ_ANY;
