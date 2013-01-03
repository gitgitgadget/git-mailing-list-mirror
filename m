From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] test: Add target test-lint-shell-syntax
Date: Wed, 02 Jan 2013 16:01:51 -0800
Message-ID: <7vtxqzyw0g.fsf@alter.siamese.dyndns.org>
References: <201301012240.10722.tboegi@web.de>
 <20130102094635.GD9328@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 03 01:02:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqYGE-0001e9-9W
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 01:02:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852Ab3ACAB4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jan 2013 19:01:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35447 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752785Ab3ACABy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jan 2013 19:01:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23686BD53;
	Wed,  2 Jan 2013 19:01:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PihJ9kGRuvWX
	oUqth14/NBBNoyE=; b=O3BoVyrWfxICuRNkB6LePt1j6CJk9puum5fLbYfaxFod
	UMwa5lNPnMhZWhoPGesrFyNRBs1BWHrlzyxrk/m7miaF2ZZ9ufNZVT0D5CBRbqvC
	9L1VsYIAE7e1iT0+2GjjuzT2gtpCw+KgbHGm5Y6dW+6bvD/AqgM5dBd7gtMGCvY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=V1N512
	7EHSeTITCAalJB24r/h8D0a8poCVFGXjFcl1c3+laS88orAkeNxVEhqPDRlqjcpl
	PAcctEBY/x5ILnyxfddYg/vm2cWZBskvrLbuwcZicPhV/T8tUoXwm5Eud3Vl7hRi
	Vqq6LqFGsAF/UBd9oXBS47bLtHa6HPsVB3x0c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 158C8BD52;
	Wed,  2 Jan 2013 19:01:54 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F59ABD50; Wed,  2 Jan 2013
 19:01:53 -0500 (EST)
In-Reply-To: <20130102094635.GD9328@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 2 Jan 2013 04:46:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C7E366D6-5538-11E2-A6F2-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212560>

Jeff King <peff@peff.net> writes:

> On Tue, Jan 01, 2013 at 10:40:08PM +0100, Torsten B=C3=B6gershausen w=
rote:
>
>> Add the perl script "check-non-portable-shell.pl" to detect non-port=
able
>> shell syntax
>
> Cool. Thanks for adding more test-lint. But...
>
>> diff --git a/t/Makefile b/t/Makefile
>> index 88e289f..7b0c4dc 100644
>> --- a/t/Makefile
>> +++ b/t/Makefile
>> @@ -23,7 +23,7 @@ TGITWEB =3D $(sort $(wildcard t95[0-9][0-9]-*.sh))
>> =20
>>  all: $(DEFAULT_TEST_TARGET)
>> =20
>> -test: pre-clean $(TEST_LINT)
>> +test: pre-clean test-lint-shell-syntax $(TEST_LINT)
>>  	$(MAKE) aggregate-results-and-cleanup
>
> I do not think it should be a hard-coded dependency of "test", as the=
n
> there is no way to turn it off. It would make more sense to me to set=
 a
> default TEST_LINT that includes it, but could be overridden by the us=
er.

I would actually not add this to TEST_LINT by default, especially
when "duplicates" and "executable" that are much simpler and less
likely to hit false positives are not on by default.

At least, a change to add this to TEST_LINT by default must wait to
be merged to any integration branch until all the fix-up topics that
this test triggers in the current codebase graduate to the branch.

>> +test-lint-shell-syntax:
>> +	$(PERL_PATH) check-non-portable-shell.pl $(T)
>
> This is wrong if $(PERL_PATH) contains spaces, no?

You are correct; "harness" thing in the same Makefile gets this
wrong, too.  I think the right invocation is:

	@'$(PERL_PATH_SQ)' check-non-portable.shell.pl $(T)

although I do not offhand know if that symbol is already exported by
the top-level Makefile.
