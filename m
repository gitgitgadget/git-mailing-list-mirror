From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Segfault with merge-tree on multiple Git versions
Date: Wed, 27 Mar 2013 09:33:46 -0700
Message-ID: <7v1ub0ol91.fsf@alter.siamese.dyndns.org>
References: <51531059.8000407@atechmedia.com>
 <87boa47saw.fsf@linux-k42r.v.cablecom.net>
 <20130327155850.GN2286@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: thomas <trast@student.ethz.ch>, git@vger.kernel.org,
	Charlie Smurthwaite <charlie@atechmedia.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Mar 27 17:34:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKtIq-0000uC-Tj
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 17:34:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878Ab3C0Qdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 12:33:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39378 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735Ab3C0Qdt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 12:33:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5B8B93D4;
	Wed, 27 Mar 2013 12:33:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qx1p0ngKw1GOig5rWSejuo3FTV8=; b=YyMMxl
	/3TltAsWCKVsHZJpez3qFLyakvOy6YsQCQHNskE1bp9fYh8APRmIT5V0YOo2E34J
	uZNExVfB/RGnhcO/5+9jnRsHJbzOqJucAWv0fmUao2Vaap+CIWYg4tWugOd822vO
	4YOz7JlLNfIukhSfJ0gTWSIAPXz1To7X82KWc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C5KiD/tbOUwnONuof2HrP/NoEP604itH
	nuQKUdZCtPKzip9LqkrrGoRtr42CaC1JCpCbPD5r0gNFuRzGhFjHmDSRLvo8xDec
	F2+MFt3wyrcWUuj7Teq8NUe68BgrvOyBW0vdssAKMK8wdKtSo1V2VbQe39TUfmqx
	mAH7vW1td3M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA65E93D3;
	Wed, 27 Mar 2013 12:33:48 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1BD1493CF; Wed, 27 Mar 2013
 12:33:48 -0400 (EDT)
In-Reply-To: <20130327155850.GN2286@serenity.lan> (John Keeping's message of
 "Wed, 27 Mar 2013 15:58:50 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 19ACD5C4-96FC-11E2-A0EC-B1692E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219272>

John Keeping <john@keeping.me.uk> writes:

> Looks like a simple typo in merge-tree.c::unresolved:

Thanks.

>
> -- >8 --
> merge-tree: fix typo in merge-tree.c::unresolved
>
> When calculating whether there is a d/f conflict, the calculation of
> whether both sides are directories generates an incorrect references
> mask because it does not use the loop index to set the correct bit.
> Fix this typo.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>
>
> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index e0d0b7d..bc912e3 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -245,7 +245,7 @@ static void unresolved(const struct traverse_info *info, struct name_entry n[3])
>  	unsigned dirmask = 0, mask = 0;
>  
>  	for (i = 0; i < 3; i++) {
> -		mask |= (1 << 1);
> +		mask |= (1 << i);
>  		if (n[i].mode && S_ISDIR(n[i].mode))
>  			dirmask |= (1 << i);
>  	}
