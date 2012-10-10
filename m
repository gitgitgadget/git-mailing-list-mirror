From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] quote: let caller reset buffer for
 quote_path_relative()
Date: Wed, 10 Oct 2012 14:13:13 -0700
Message-ID: <7vd30qav4m.fsf@alter.siamese.dyndns.org>
References: <7vk3uzfp3p.fsf@alter.siamese.dyndns.org>
 <1349868894-3579-1-git-send-email-pclouds@gmail.com>
 <1349868894-3579-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 23:13:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM3ap-0008FR-T1
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 23:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755522Ab2JJVNR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 17:13:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64768 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754752Ab2JJVNQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Oct 2012 17:13:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B206F8277;
	Wed, 10 Oct 2012 17:13:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=LQ+7hdjNH6DN
	oQP5VfFTcqEqOr0=; b=yfSIUvPPyaAyh6TCbda1Dyl85WbTjVRB6TH3RuIyWo7f
	ItXY1XaaVqX9EbQUmCCccnIbdlouvkSW48kNFpuKIs2jdSeuAJQFa+SP3TZu4K3A
	beiSkCUJ8tFY4kE9f/NQgzwMS3I3/ZOawD7VDGvzTcljARzsVSyMo9s7C9PuhOE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Q+8Kuq
	sGJgymuYbXlmx32vOVMeXVYAzDFQLSK+40paAjpXNqeDSEJGpNDzY1XCaA1ATZ5k
	egQnswi62nX/JWvDNbifohA/eF++OIHQ7qrMxf3b7Awybr3tdXOx56LFB4CU8ASi
	MwDuYcRGNvTX1yAdxQKSRezefF8FHrQN36Fao=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9ECE78276;
	Wed, 10 Oct 2012 17:13:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E2AFA8274; Wed, 10 Oct 2012
 17:13:14 -0400 (EDT)
In-Reply-To: <1349868894-3579-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 10 Oct
 2012 18:34:52 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4E13D620-131F-11E2-9C93-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207442>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> quote_path_relative() resetting output buffer is sometimes unnecessar=
y
> as the buffer has never been used, and some other times makes it
> harder for the caller to use (see builtin/grep.c, the caller has to
> insert a string after quote_path_relative)
>
> Move the buffer reset back to call sites when necessary.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  The answer for Jeff's XXX in his patch, why strbuf_insert() instead
>  of just adding in advance.

This sounds a lot stronger than "let" to me.  All existing callers
that assumed that buf to be emptied by the function now has to clear
it.  "quote: stop resetting output buffer of quote_path_relative()"
may better describe what this really does.

How should this interact with the logic in the called function that
used to say "if we ended up returning an empty string because the
path is the same as the base, we should give ./ back", and what
should the return value of this function be?

To answer these questions, you must define the meaning of the string
in the output buffer that already exists when the function is
called.  If the caller did this:

	strbuf_addstr(&out, "The path relative to your HOME is: ");
        quote_path_relative(path, pathlen, &out, "/home/pclouds/");

then the answers are "We still need to add ./ but !out->len is no
longer a good test to decide" and "It should point at the first byte
of what we added, not out->buf".

But if the caller did this instead:

	srcdir =3D "/src/";
	strbuf_addstr(&dst, "/dst/");
        quote_path_relative(path, pathlen, &dst, srcdir);
        printf("cp '%s' '%s'\n", path, dst->buf);

then it is nonsensical to add "./" when out->len is not zero when
the function returns.

So what does it mean to have an existing string in the output buffer
when calling the function?  Is it supposed to be a path to a
directory, or just a general uninterpreted string (e.g. a message)?
