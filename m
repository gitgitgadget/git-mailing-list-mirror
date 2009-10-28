From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] imap-send.c: fix pointer to be const
Date: Wed, 28 Oct 2009 00:48:08 -0700
Message-ID: <7v8wewq7rb.fsf@alter.siamese.dyndns.org>
References: <1256714677-3659-1-git-send-email-vietor@vxwo.org>
 <7vljiwq8tc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Vietor Liu <vietor@vxwo.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 08:48:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N33Ga-0000g0-EP
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 08:48:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756859AbZJ1HsO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Oct 2009 03:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756771AbZJ1HsO
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 03:48:14 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48408 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754798AbZJ1HsN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Oct 2009 03:48:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 38BEE883E0;
	Wed, 28 Oct 2009 03:48:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=r4eK8uSAt9RJ
	U7mTxMNASVt+51U=; b=Uw1mmIBrmDDyscXEvPoZ7TlM8Cq+GcdMYkO9xLKF7meR
	fBXDlBElPr8cnAEmjU2o2Pc3sB2EZO+T0SpZzVCMa1d2jyYVjiMqu9RXsilct90C
	nRELU8HOa4r9w+BaigsFzky+mt+JzE15vDsrvJesVuVwNoV0PyeYg24QLOCzWxM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=U6+UvU
	Kx3Jlr6L6EcgwKVNBydGFH3YIkzwt5RveilljYi0IWYBGkr7/zIpaRRmWbRjXZxG
	Fn9gjFteRlLFwWpCppRhgxiOzhm9OHL7Ka90ff/SCZp35iUhV8XeHb6KUffP2QUs
	Tkl4rbpE7uL6vufu+CBN4emn9GmddxJTwyjHE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1ACDC883DC;
	Wed, 28 Oct 2009 03:48:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CCD8A883DA; Wed, 28 Oct 2009
 03:48:10 -0400 (EDT)
In-Reply-To: <7vljiwq8tc.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 28 Oct 2009 00\:25\:19 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3FCE4CA2-C396-11DE-A984-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131433>

Junio C Hamano <gitster@pobox.com> writes:

> Vietor Liu <vietor@vxwo.org> writes:
>
>> Fixes some compiler warnings:
>> imap-send.c: In function =E2=80=98ssl_socket_connect=E2=80=99:
>> warning: assignment discards qualifiers from pointer target type
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>> OpenSSL Changes between 0.9.8k and 1.0:
>>
>> *) Let the TLSv1_method() etc. functions return a 'const' SSL_METHOD
>>      pointer and make the SSL_METHOD parameter in SSL_CTX_new,
>>      SSL_CTX_set_ssl_version and SSL_set_ssl_method 'const'.
>>
>> Signed-off-by: Vietor Liu <vietor@vxwo.org>
>
> This is much easier to understand.

This indeed _is_ easier to understand, but what this means is that maki=
ng
"meth" const will break the compilation for people with 0.9.8k.

Their SSL_CTX_new() does not promise the callers that it won't modify t=
he
object its parameter points at, so SSL_CTX_new(meth) will now see exact=
ly
the same issue.  You will be discarding "const" qualifier by passing it=
=2E
