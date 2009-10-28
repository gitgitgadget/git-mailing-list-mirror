From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] imap-send.c: fix pointer to be const
Date: Tue, 27 Oct 2009 23:26:09 -0700
Message-ID: <7vk4ygxce6.fsf@alter.siamese.dyndns.org>
References: <1256706591-2763-1-git-send-email-vietor@vxwo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Vietor Liu <vietor@vxwo.org>
X-From: git-owner@vger.kernel.org Wed Oct 28 07:26:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N31zD-000103-Rr
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 07:26:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756235AbZJ1G0N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Oct 2009 02:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754576AbZJ1G0N
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 02:26:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64813 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667AbZJ1G0M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Oct 2009 02:26:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5C50888E20;
	Wed, 28 Oct 2009 02:26:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=IlbaGh/bTSxq
	kQStJPIeLI6ut2k=; b=pbs1Rrmvp5MXo46JSEHacNRJEckr2tg2WJxFACbgJfNV
	p3ZpIrz2Dit5Byz53TxtSCvcChMwhpqT7WYj7hNRg/WSiOJSnGu3wLVibL4905pB
	vVprg6kTm76YIvV68A4KRzRXELKt9Mra3ZXkr0VAhCzqr6XamMaAQy1MpepE/9k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=h8b5R0
	Ht4c7g+I3jEC8eLv289Qqn5I+8B6pO0vbpXVJNjw6lhXP6ClSE2AMtYl/IgHDDIb
	uLzH7aIQO6+b5oAtCG9JmYeZKRwKqfVpeGg0xz15AJoFYJCJBljLj/bRj2EDQuDN
	jcj4UWmcRcNykJ3zb0P6tgFK87qHpDpjunB5g=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3F35888E1F;
	Wed, 28 Oct 2009 02:26:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 43FA488E1E; Wed, 28 Oct 2009
 02:26:10 -0400 (EDT)
In-Reply-To: <1256706591-2763-1-git-send-email-vietor@vxwo.org> (Vietor Liu's
 message of "Wed\, 28 Oct 2009 13\:09\:51 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CABFF290-C38A-11DE-A8C5-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131409>

Vietor Liu <vietor@vxwo.org> writes:

> Fixes some compiler warnings:
> imap-send.c: In function =E2=80=98ssl_socket_connect=E2=80=99:
> warning: assignment discards qualifiers from pointer target type
>
> Signed-off-by: Vietor Liu <vietor@vxwo.org>

I do not quite understand.  This variable gets assigned the return valu=
es
from TLSv1_method() or SSLv23_method(), but the copy of ssl.h I have
declares them as:

    SSL_METHOD *SSLv23_method(void);	/* SSLv3 but can rollback to v2 */
    SSL_METHOD *TLSv1_method(void);		/* TLSv1.0 */

We would need to explain this change a bit better.

>  imap-send.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/imap-send.c b/imap-send.c
> index 3847fd1..10dd025 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -273,7 +273,7 @@ static int ssl_socket_connect(struct imap_socket =
*sock, int use_tls_only, int ve
>  	fprintf(stderr, "SSL requested but SSL support not compiled in\n");
>  	return -1;
>  #else
> -	SSL_METHOD *meth;
> +	const SSL_METHOD *meth;
>  	SSL_CTX *ctx;
>  	int ret;
> =20
> --=20
> 1.6.5.2
