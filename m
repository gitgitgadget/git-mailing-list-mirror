From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] test: Add target test-lint-shell-syntax
Date: Mon, 07 Jan 2013 10:07:20 -0800
Message-ID: <7vwqvoj293.fsf@alter.siamese.dyndns.org>
References: <201301012240.10722.tboegi@web.de>
 <20130102094635.GD9328@sigill.intra.peff.net>
 <7vtxqzyw0g.fsf@alter.siamese.dyndns.org>
 <7vpq1nyvp1.fsf@alter.siamese.dyndns.org> <50EB0928.3090901@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Jan 07 19:08:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsH7H-0003Tr-AL
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 19:08:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754408Ab3AGSHY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jan 2013 13:07:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49267 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754345Ab3AGSHX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jan 2013 13:07:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EAB7B8D2;
	Mon,  7 Jan 2013 13:07:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ANxepaW1V5j2
	/rTjYZv8sr7E+9g=; b=HcMWnlDW3agFYmgp303Qs0iliOlvdyI8W9hAbQtL/Ne0
	6AyKpfXq39eNN1u5rrwHxrpjjxtSgNXrixwZxtqs+3C+nu6GDeu4w1CDWm9DCg0v
	/yAOc975aM5cB1YgmYr0gXTiDXE9TY5nRxdCyLwt4qbDX62e5xHx9h58RaANDZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Ie5ys1
	PnC1Z7enC37hvQc+YMqz0jJuZmNlzH10X/mFziXsEVkAKAKRniQjLJ300HBx/hjP
	0zTunzw3MKBX1mJHElKsCEG9/03dSzHiebqunU1EkgpCF0nk+j/j9jftdyeItmEt
	6SHZPebmM/srpK3+j6XEzABIwImKvWO0VO3DA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3BAFB8D1;
	Mon,  7 Jan 2013 13:07:22 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56C93B8D0; Mon,  7 Jan 2013
 13:07:22 -0500 (EST)
In-Reply-To: <50EB0928.3090901@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of "Mon, 07 Jan 2013 18:43:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1563D76E-58F5-11E2-95DF-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212909>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Sorry for late answer, but there is a problem (both linux and Mac OS =
X) :-(
> $ make test-lint does not do shel syntax check, neither
> $ make test-lint-shell-syntax

In which directory?

    $ make -C t test-lint-shell-syntax
    ... passes silently ...
    $ ed t/t0000-basic.sh
    /test_expect_success/
    a
            which sh
    .
    w
    q
    $ make -C t test-lint-shell-syntax
    t0000-basic.sh:28: error: which is not portable (please use type): =
     which sh
    make: *** [test-lint-shell-syntax] Error 1

If you edit out '@' (but nothing else) from this line:

> 	@'$(PERL_PATH_SQ)' check-non-portable-shell.pl $(T)

and run the above again, you would see that it is running this shell
command:

'/usr/bin/perl' check-non-portable-shell.pl t0000-basic.sh t0001-init.s=
h ...

If you introduce a Perl syntax error to check-non-portable-shell.pl,
like this, you will get:

    $ make -C t test-lint-shell-syntax
    syntax error at check-non-portable-shell.pl line 11, near "whoa

So... is your shell broken?  The above seems to work for dash, bash,
ksh and zsh.
