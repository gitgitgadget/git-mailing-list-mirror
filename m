From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] Add basic Coccinelle transforms.
Date: Mon, 06 Jun 2016 19:28:28 -0700
Message-ID: <xmqqk2i1u3zn.fsf@gitster.mtv.corp.google.com>
References: <20160607005716.69222-2-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Jun 07 04:28:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA6l4-0005f2-W2
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 04:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799AbcFGC2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 22:28:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58204 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752794AbcFGC2c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 22:28:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E443B2334E;
	Mon,  6 Jun 2016 22:28:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jGOMI+oCTZhylIAizaN/jIzHBuc=; b=jOfkuQ
	q+5YoOutl0NDMIIcEdR0fVnrCblKQBmlcKjZs6m9Kor9wgKazDdhwUetq7Qy8rx4
	3SG2Nd5tUt4Fh3ScE4Fzh3CAjT2eTIP/qAxQutcUX4VO1hhP2UwjmMl0sf1EKHK8
	3ErobPxv33b5qzzrqxuck/MT3EcywE8tPZoU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hOEaQL8eS+CBAh60QNLytbKQNVzbw3oo
	SqH9uo4e7HH8ixAuQfQzB/dZQEaHOu5vnqpZ1Kr9OAWVLm7fVZNeeqsk9vBy1hHj
	Yu+sfGLcN2SHo/ylYCnoptpAG0Y//uAGuQmwhO8JlBCxppfMy2a0+QkvFQe7P9zg
	AlnDcEpF/aI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DC7BB2334C;
	Mon,  6 Jun 2016 22:28:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 57DD32334B;
	Mon,  6 Jun 2016 22:28:30 -0400 (EDT)
In-Reply-To: <20160607005716.69222-2-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Tue, 7 Jun 2016 00:57:09 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8606A468-2C57-11E6-B71D-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296590>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Coccinelle (http://coccinelle.lip6.fr/) is a program which performs
> mechanical transformations on C programs using semantic patches.  These
> semantic patches can be used to implement automatic refactoring and
> maintenance tasks.
>
> Add a set of basic semantic patches to convert common patterns related
> to the struct object_id transformation.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> I realize the name and location of this file might be suboptimal.
> Suggestions on better locations and filenames would be appreciated.

Once is_null_sha1() is updated to is_null_oid(), the first rewrite
definition would become useless, no?  I am not sure what the point
is to keep this file in our history.

>
>  standard.cocci | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 standard.cocci
>
> diff --git a/standard.cocci b/standard.cocci
> new file mode 100644
> index 00000000..0f068252
> --- /dev/null
> +++ b/standard.cocci
> @@ -0,0 +1,83 @@
> +@@
> +expression E1;
> +@@
> +- is_null_sha1(E1.hash)
> ++ is_null_oid(&E1)
> +
> +@@
> +expression E1;
> +@@
> +- is_null_sha1(E1->hash)
> ++ is_null_oid(E1)
> +
> +@@
> +expression E1;
> +@@
> +- sha1_to_hex(E1.hash)
> ++ oid_to_hex(&E1)
> +
> +@@
> +expression E1;
> +@@
> +- sha1_to_hex(E1->hash)
> ++ oid_to_hex(E1)
> +
> +@@
> +expression E1;
> +@@
> +- hashclr(E1.hash)
> ++ oidclr(&E1)
> +
> +@@
> +expression E1;
> +@@
> +- hashclr(E1->hash)
> ++ oidclr(E1)
> +
> +@@
> +expression E1, E2;
> +@@
> +- hashcmp(E1.hash, E2.hash)
> ++ oidcmp(&E1, &E2)
> +
> +@@
> +expression E1, E2;
> +@@
> +- hashcmp(E1->hash, E2->hash)
> ++ oidcmp(E1, E2)
> +
> +@@
> +expression E1, E2;
> +@@
> +- hashcmp(E1->hash, E2.hash)
> ++ oidcmp(E1, &E2)
> +
> +@@
> +expression E1, E2;
> +@@
> +- hashcmp(E1.hash, E2->hash)
> ++ oidcmp(&E1, E2)
> +
> +@@
> +expression E1, E2;
> +@@
> +- hashcpy(E1.hash, E2.hash)
> ++ oidcpy(&E1, &E2)
> +
> +@@
> +expression E1, E2;
> +@@
> +- hashcpy(E1->hash, E2->hash)
> ++ oidcpy(E1, E2)
> +
> +@@
> +expression E1, E2;
> +@@
> +- hashcpy(E1->hash, E2.hash)
> ++ oidcpy(E1, &E2)
> +
> +@@
> +expression E1, E2;
> +@@
> +- hashcpy(E1.hash, E2->hash)
> ++ oidcpy(&E1, E2)
