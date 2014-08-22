From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] Push the NATIVE_CRLF Makefile variable to C and added a test for native.
Date: Fri, 22 Aug 2014 15:54:03 -0700
Message-ID: <xmqq61hknnjo.fsf@gitster.dls.corp.google.com>
References: <53F797A1.1060804@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Aug 23 00:54:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKxis-0005am-At
	for gcvg-git-2@plane.gmane.org; Sat, 23 Aug 2014 00:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179AbaHVWyO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Aug 2014 18:54:14 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50816 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752158AbaHVWyN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Aug 2014 18:54:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A4CFD331B6;
	Fri, 22 Aug 2014 18:54:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7BpDnLevwEMs
	MUSuQec3ssNzLeE=; b=CQXSFPIFN9+e+8XMEyRphymNgeM0haoqKGyeYzTKRInl
	JWmfLrPriFKyOsUBlNlqmVg5ncbdMyNVONAqp1Pfi+1HYgY0fgoUQT8cGGMFuNgT
	/v1aTaKD+tH/uhSLMiXZ5ud/szK3DAcxUOIlsvPEy0fjsT8mbzyc3i6//FTO+Cc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WnPtYH
	5J2bP26TN21KlybmuP4GB4gbaIQRc1NWOjGnFebeP2r52iFFf8DHsxSgjKrUli38
	NfSSS74Szc6kaUPFUJtobilxtxAHYVmvR3+tyC+GWhw//du0I3K76niPv0t7F7m+
	rPyC9UF78cbWZL4MPdX4ECHALfy6RZawA1RcQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9BE33331B5;
	Fri, 22 Aug 2014 18:54:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 17063331AF;
	Fri, 22 Aug 2014 18:54:05 -0400 (EDT)
In-Reply-To: <53F797A1.1060804@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Fri, 22 Aug 2014 21:18:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 379201C6-2A4F-11E4-B748-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255725>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Commit 95f31e9a correctly points out that the NATIVE_CRLF setting is
> incorrectly set on Mingw git. However, the Makefile variable is not
> propagated to the C preprocessor and results in no change. This patch
> pushes the definition to the C code and adds a test to validate that
> when core.eol as native is crlf, we actually normalize text files to =
this
> line ending convention when core.autocrlf is false.
>
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---

Who should I record as the author of this patch?

>
> This mini series mainly updates git.git with patches from msysgit:
> Patch 1 is taken "as is",
> Patch 2 is taken "as is",
> and Patch 3 is the outcome of the code-review=20
>
> Thanks for careful reading
>
>
>  Makefile              |  3 +++
>  t/t0026-eol-config.sh | 18 ++++++++++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 2320de5..517036e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1479,6 +1479,9 @@ ifdef NO_REGEX
>  	COMPAT_CFLAGS +=3D -Icompat/regex
>  	COMPAT_OBJS +=3D compat/regex/regex.o
>  endif
> +ifdef NATIVE_CRLF
> +	BASIC_CFLAGS +=3D -DNATIVE_CRLF
> +endif
> =20
>  ifdef USE_NED_ALLOCATOR
>         COMPAT_CFLAGS +=3D -Icompat/nedmalloc
> diff --git a/t/t0026-eol-config.sh b/t/t0026-eol-config.sh
> index 4807b0f..43a580a 100755
> --- a/t/t0026-eol-config.sh
> +++ b/t/t0026-eol-config.sh
> @@ -80,4 +80,22 @@ test_expect_success 'autocrlf=3Dtrue overrides uns=
et eol' '
>  	test -z "$onediff" && test -z "$twodiff"
>  '
> =20
> +test_expect_success NATIVE_CRLF 'eol native is crlf' '
> +
> +	rm -rf native_eol && mkdir native_eol &&
> +	( cd native_eol &&
> +	printf "*.txt text\n" > .gitattributes
> +	printf "one\r\ntwo\r\nthree\r\n" > filedos.txt
> +	printf "one\ntwo\nthree\n" > fileunix.txt

I think I saw a few style fixes sent against the previous round of
patches; have you missed them?

> +	git init &&
> +	git config core.autocrlf false &&
> +	git config core.eol native &&
> +	git add filedos.txt fileunix.txt &&
> +	git commit -m "first" &&
> +	rm file*.txt &&
> +	git reset --hard HEAD &&
> +	has_cr filedos.txt && has_cr fileunix.txt
> +	)
> +'
> +
>  test_done
