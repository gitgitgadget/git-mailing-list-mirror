From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 2/3] Alternates API: Improve naming
Date: Wed, 30 Mar 2011 15:31:11 -0700
Message-ID: <7vwrjgkzps.fsf@alter.siamese.dyndns.org>
References: <cover.1301521243.git.mfwitten@gmail.com>
 <5ed7886ec5e12c8e3a5f45d19625a4f5d2cdd38a.1301521243.git.mfwitten@gmail.com>
 <3c357acd119aa836f6cd3298d62cc5098f4c053c.1301521244.git.mfwitten@gmail.com>
 <a0e5204fe8c03b3b6af2150198bad51f86b126c4.1301521243.git.mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 00:31:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q53vB-0003t8-Sk
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 00:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756314Ab1C3WbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 18:31:20 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34035 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756291Ab1C3WbT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 18:31:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B159F50F8;
	Wed, 30 Mar 2011 18:33:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U+MJV33Qcb70Hb4/Mjkud5qFR2w=; b=EmG6E+
	+kshJl19NX4805uNjL7oA+JorHjOeEjmjJHjAuaXGG9Gkv0kIPQvcvAnprsuCViz
	+v80BGcWSpL2iFYzF7ma+BFnZJG1r3r0SwX5Z+/I/FbUFXwoi5cgvO4Nqcpcn5Ib
	nNvGDD6c8iSgdv6pPUdKGUi9XnC1vtdqsAvvk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T1lZYLJX8JEWM5iG8z82VjzXiRHH9kjQ
	+zbmNbXdAF0Y2bqRg3Eedz9Fl1weP8695aOiU1aedQfHrz3AOEUGB1faz9mU5b3k
	9mh9B9wYHHIDbWn+Pyd7xONiVihfaerzFPhU0dsYjzVhY1WSqhZBMz++a34Phcqj
	qACI4ZDFTK4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8F8B050F6;
	Wed, 30 Mar 2011 18:33:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B2C5D50F5; Wed, 30 Mar 2011
 18:33:02 -0400 (EDT)
In-Reply-To: <a0e5204fe8c03b3b6af2150198bad51f86b126c4.1301521243.git.mfwitten@gmail.com>
 (Michael Witten's message of "Wed, 30 Mar 2011 21:24:24 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AE26E702-5B1D-11E0-923D-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170433>

Michael Witten <mfwitten@gmail.com> writes:

> diff --git a/sha1_file.c b/sha1_file.c
> index e55a496..a6c1f1f 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -390,11 +390,11 @@ void add_to_alternates_file(const char *reference)
>  
>  void foreach_alt_odb(alt_odb_fn fn)
>  {
> -	struct alternate_object_database *ent;
> +	struct alternate_object_database *d;
>  
>  	prepare_alt_odb();
> -	for (ent = alt_odb_list; ent; ent = ent->next)
> +	for (d = alt_odb_list; d; d = d->next)
> -		if (fn(ent))
> +		if (fn(d))

I see this as a naming regression; that pointer variable points at an
entry in a list, and the callback is very well aware of that too (so the
s/e/d/g in an earlier hunk also is a naming regression).
