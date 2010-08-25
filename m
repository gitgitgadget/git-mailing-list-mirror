From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-merge: ignore space support
Date: Wed, 25 Aug 2010 10:55:46 -0700
Message-ID: <7vy6bushjx.fsf@alter.siamese.dyndns.org>
References: <20100823205915.GA4484@ns1.cockos.com>
 <20100824022820.GE17406@burratino>
 <5F681E95-9369-490A-84FE-55B99EA8FE63@cockos.com>
 <20100825044006.GJ11619@burratino>
 <AANLkTimRyeMbLKLmbKJEqgGPDFo3OCsz=QwVzkSaP5n8@mail.gmail.com>
 <4C753BFD.5060807@cockos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	eyvind.bernhardsen@gmail.com
To: Justin Frankel <justin@cockos.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 19:56:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoKCo-0003bm-4U
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 19:56:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465Ab0HYR4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 13:56:05 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45919 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400Ab0HYR4D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 13:56:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 00F58D0AF8;
	Wed, 25 Aug 2010 13:56:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dm29eBDOR2r0+1Cnx5rTlZnwm8E=; b=uOWCfM
	YeJvR1TeWppEEBBS+4PLEZaiIRUOUwx/quWFCbH0CB645cGJs/MLdk2D12gX5lB5
	S2UWBFpVChriCAmgM+BpbCgwFZh7OJA4lJjYEq0Ek4I+LiL65MzvbR3G+JcJWvPI
	xEfq9F5uf4rf2iakIo6mYaxOU66vKgX+gVfKs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RqOp1pMVYjIgP+Rv7yAaOE2SqZDT5iMW
	+Iy9m4LLinyCsjy6Rxh3MzRNTt0oN4rEkHD+jEygtlPK3AuQ01BThVt0ssiD/rsX
	z6lhbMVfLg7JGaC2MINsYqRKrL5xNahRIUr5Se0dCilDuSWNkaR+LznZqv8RjHhe
	3jNdMuBvrxg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D66BD0AF2;
	Wed, 25 Aug 2010 13:55:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 744D8D0AEF; Wed, 25 Aug
 2010 13:55:48 -0400 (EDT)
In-Reply-To: <4C753BFD.5060807@cockos.com> (Justin Frankel's message of
 "Wed\, 25 Aug 2010 08\:51\:25 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 02485FA2-B072-11DF-B7C9-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154454>

Justin Frankel <justin@cockos.com> writes:

> The only danger is that ll_merge()'s signature didn't change in such a
> way to break compilation, i.e:
>
> int ll_merge(mmbuffer_t *result_buf,
>             const char *path,
>             mmfile_t *ancestor, const char *ancestor_label,
>             mmfile_t *ours, const char *our_label,
>             mmfile_t *theirs, const char *their_label,
>             int flag);
>
> becomes:
>
> int ll_merge(mmbuffer_t *result_buf,
>             const char *path,
>             mmfile_t *ancestor, const char *ancestor_label,
>             mmfile_t *ours, const char *our_label,
>             mmfile_t *theirs, const char *their_label,
>             struct whatever *conf);
>
> In this case, passing 0 as the last parameter will compile either way.
>
> Sure, we can grep all of the source, but who knows when something else
> will get merged in...

That is technically a valid concern but I suspect it does not matter in
this particular case, where integer 0 used to mean "use the default" and
the new API uses NULL to mean the same.

If an existing call site used to pass 0 and the patch forgot to update it,
it will look ugly (we encourage to spell a NULL pointer "NULL", not "0",
in our codebase) but no harm is done.  If an existing call site asked for
a non-default behaviour by passing a non-zero integer flag, and the patch
forgot to update it, the compiler would have caught it.  Merging a side
branch is the same deal; if it adds a call with a non-zero argument to ask
for a non-default behaviour, that will be done via an expression over some
integer variables or constants, and that won't be casted silently to a
pointer to "struct whatever", no?
