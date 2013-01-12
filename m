From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: turn on test-lint-shell-syntax by default
Date: Fri, 11 Jan 2013 22:00:37 -0800
Message-ID: <7vvcb37xfe.fsf@alter.siamese.dyndns.org>
References: <201301120650.46479.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Jan 12 07:01:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ttu9U-0005du-KJ
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 07:01:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510Ab3ALGAn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jan 2013 01:00:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41721 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751145Ab3ALGAm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jan 2013 01:00:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EEE5B7963;
	Sat, 12 Jan 2013 01:00:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=LuSRBkAysWFx
	0n0Rb9VZK9qUbuc=; b=nhOp+qDkq14Dln7C6GNoE3DDY+EpNGlv9SoYN+Ap3Zpf
	oV3ktrNeE88Z9Bxhm1C5UOnLoSCqbKBFOdEv+Io2J4q+zqtqI5QZLX4E8KHHhoOF
	dfz9JayXcuFYWktsOtCEvF0fBY2Bc5dTTbWdBJ4EBfEjs7VTS5J2G9ewe7T/aOY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ZwtvmU
	62vln6breClkFphAofJS7cUNJH1wsGY6Aef3lp3ASzHGkB/8eAwRsvdVdZcX13qK
	YdfQkLqQFhmfEQ/EeeLUluK9IfYf+qyqcunOVX9CKkRAZTGHcHLMbPb7pemqPSgO
	L4YnmEqqQZBzevVEZ7jc3Hg5YqMgZyTTBv0yI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E40FD7962;
	Sat, 12 Jan 2013 01:00:39 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 462DD7961; Sat, 12 Jan 2013
 01:00:39 -0500 (EST)
In-Reply-To: <201301120650.46479.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?= message of "Sat, 12 Jan 2013 06:50:45
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 64004EF8-5C7D-11E2-95E8-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213265>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> The test Makefile has a default set of lint tests which are run
> as part of "make test".
>
> The macro TEST_LINT defaults to "test-lint-duplicates test-lint-execu=
table".
>
> Add test-lint-shell-syntax here, to detect non-portable shell syntax =
early.
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---

As I said already, I do not want to do this yet without further
reduction of false positives.

Addition of the shell script test was a good starting point, but as
it stands, it still is too brittle and will trigger on something
even trivially innouous, like this:

	test_expect_success 'no issues' '
        	cat >test.file <<-\EOF &&
                which is the right way?
                EOF
        '

>  t/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/Makefile b/t/Makefile
> index 1923cc1..6fa2b80 100644
> --- a/t/Makefile
> +++ b/t/Makefile
> @@ -13,7 +13,7 @@ TAR ?=3D $(TAR)
>  RM ?=3D rm -f
>  PROVE ?=3D prove
>  DEFAULT_TEST_TARGET ?=3D test
> -TEST_LINT ?=3D test-lint-duplicates test-lint-executable
> +TEST_LINT ?=3D test-lint-duplicates test-lint-executable test-lint-s=
hell-syntax
> =20
>  # Shell quote;
>  SHELL_PATH_SQ =3D $(subst ','\'',$(SHELL_PATH))
